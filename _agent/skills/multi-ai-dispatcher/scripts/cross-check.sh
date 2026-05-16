#!/bin/zsh

set -euo pipefail

SCRIPT_NAME="${0:t}"

usage() {
  cat <<'EOF'
Usage:
  cross-check.sh --mode MODE FILE [options]

Modes:
  outside     Use an external-eye review against the source file
  style       Ask multiple models to produce parallel style variants
  blindspot   Ask multiple models to surface blindspots

Options:
  --mode MODE                 Required: outside | style | blindspot
  --intensity LEVEL           Optional: light | heavy (default: light)
  --prompt TEXT               Optional extra instruction
  --integrator NAME           Optional: cowork | code | manual (default: cowork)
  --providers LIST            Optional comma-separated providers override
  --output-dir DIR            Optional package directory override
  CROSS_CHECK_TIMEOUT_SEC     Optional provider timeout in seconds (default: 180)
  --help                      Show this help

Examples:
  cross-check.sh --mode outside 教案.md
  cross-check.sh --mode style 文章.md --prompt "幫這篇文章想 5 個標題"
  cross-check.sh --mode blindspot 會議記錄.md --integrator code
  cross-check.sh --mode blindspot 會議記錄.md --providers claude,codex
  cross-check.sh --mode blindspot --intensity heavy 企劃.md
EOF
}

die() {
  print -u2 -- "Error: $*"
  exit 1
}

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  print -r -- "$value"
}

slugify() {
  local input="$1"
  input="${input// /-}"
  input="${input//\//-}"
  input="${input//:/-}"
  input="${input//｜/-}"
  input="${input//、/-}"
  input="${input//，/-}"
  input="${input//。/}"
  input="${input//\?/}"
  input="${input//\*/}"
  input="${input//\"/}"
  input="${input//\'/}"
  input="${input//\(/}"
  input="${input//\)/}"
  input="${input//\[/}"
  input="${input//\]/}"
  input="${input//\{/}"
  input="${input//\}/}"
  print -r -- "$input"
}

abs_path() {
  local target="$1"
  if [[ -d "$target" ]]; then
    (cd "$target" && pwd -P)
  else
    local parent
    parent="$(cd "${target:h}" && pwd -P)"
    print -r -- "$parent/${target:t}"
  fi
}

mode=""
intensity="light"
prompt=""
integrator="cowork"
providers_override=""
output_dir=""
timeout_sec="${CROSS_CHECK_TIMEOUT_SEC:-180}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode)
      [[ $# -ge 2 ]] || die "--mode requires a value"
      mode="$2"
      shift 2
      ;;
    --intensity)
      [[ $# -ge 2 ]] || die "--intensity requires a value"
      intensity="$2"
      shift 2
      ;;
    --prompt)
      [[ $# -ge 2 ]] || die "--prompt requires a value"
      prompt="$2"
      shift 2
      ;;
    --integrator)
      [[ $# -ge 2 ]] || die "--integrator requires a value"
      integrator="$2"
      shift 2
      ;;
    --providers)
      [[ $# -ge 2 ]] || die "--providers requires a value"
      providers_override="$2"
      shift 2
      ;;
    --output-dir)
      [[ $# -ge 2 ]] || die "--output-dir requires a value"
      output_dir="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --*)
      die "Unknown option: $1"
      ;;
    *)
      break
      ;;
  esac
done

[[ -n "$mode" ]] || die "--mode is required"
[[ $# -ge 1 ]] || die "Source file is required"
source_input="$1"

case "$mode" in
  outside|style|blindspot) ;;
  *)
    die "Unsupported mode: $mode"
    ;;
esac

case "$integrator" in
  cowork|code|manual) ;;
  *)
    die "Unsupported integrator: $integrator"
    ;;
esac

case "$intensity" in
  light|heavy) ;;
  *)
    die "Unsupported intensity: $intensity"
    ;;
esac

[[ -f "$source_input" ]] || die "Source file not found: $source_input"

timestamp="$(TZ=Asia/Taipei date +"%Y-%m-%d-%H%M")"
source_file="$(abs_path "$source_input")"
source_dir="$(dirname "$source_file")"
source_name="$(basename "$source_file")"
source_stem="${source_name:r}"
safe_stem="$(slugify "$source_stem")"

if [[ -n "$output_dir" ]]; then
  package_dir="$(abs_path "$output_dir")"
else
  package_dir="$source_dir/_cross-check/${timestamp}-${safe_stem}"
fi

mkdir -p "$package_dir"
raw_dir="$package_dir/raw"
logs_dir="$package_dir/logs"
mkdir -p "$raw_dir" "$logs_dir"

round1_dir="$raw_dir/round1"
round2_dir="$raw_dir/round2"
mkdir -p "$round1_dir" "$round2_dir"

report_file="$source_dir/${timestamp} 交叉比對：${source_stem}.md"
integration_prompt_file="$package_dir/integration-prompt.md"
manifest_file="$package_dir/manifest.md"

if [[ -n "$providers_override" ]]; then
  providers_csv="$providers_override"
else
  case "$mode" in
    outside)
      providers_csv="codex"
      ;;
    style|blindspot)
      providers_csv="claude,codex"
      ;;
  esac
fi

providers=()
IFS=',' read -rA raw_providers <<< "$providers_csv"
for provider in "${raw_providers[@]}"; do
  provider="$(trim "$provider")"
  [[ -n "$provider" ]] || continue
  providers+=("$provider")
done

[[ ${#providers[@]} -gt 0 ]] || die "No providers selected"

case "$mode" in
  outside)
    default_task="你是外部讀者，不知道作者的內部脈絡。請只根據我提供的文件內容，指出外部讀者最可能看不懂、誤解、或覺得邏輯不完整的地方。請用繁體中文輸出，分成：1. 整體判斷 2. 主要問題 3. 建議修改。"
    ;;
  style)
    default_task="請根據我提供的文件內容產出一版回應，重點是呈現你的風格版本。若我有另外指定任務，請以該任務為主。請用繁體中文輸出。"
    ;;
  blindspot)
    default_task="請檢查這份文件的盲點、遺漏、風險與過度假設之處。請用繁體中文輸出，分成：1. 高信心盲點 2. 可能盲點 3. 建議補強。"
    ;;
esac

if [[ -n "$prompt" ]]; then
  task_prompt="$prompt"
else
  task_prompt="$default_task"
fi

source_content="$(<"$source_file")"

build_round1_prompt() {
  local provider="$1"
  case "$mode" in
    outside)
      cat <<EOF
你現在扮演交叉檢查流程中的 ${provider}。

任務模式：outside
任務說明：
$task_prompt

重要限制：
- 不要假設你知道作者平常的脈絡。
- 只能根據下面文件本身做判斷。
- 不要重寫全文，重點是指出外部視角會卡住的地方。

文件內容如下：

$source_content
EOF
      ;;
    style)
      cat <<EOF
你現在扮演交叉檢查流程中的 ${provider}。

任務模式：style
任務說明：
$task_prompt

重要限制：
- 不要評論另一個模型。
- 直接給出你的版本。
- 如果任務是標題或文案發想，請直接列出結果。

文件內容如下：

$source_content
EOF
      ;;
    blindspot)
      cat <<EOF
你現在扮演交叉檢查流程中的 ${provider}。

任務模式：blindspot
任務說明：
$task_prompt

重要限制：
- 請明確指出依據，不要只下抽象判斷。
- 盡量區分高信心與低信心。
- 不要假設你看過其他模型的回答。

文件內容如下：

$source_content
EOF
      ;;
  esac
}

build_round2_prompt() {
  local provider="$1"
  local round1_bundle=""
  local p

  for p in "${success_providers[@]}"; do
    round1_bundle+=$'---\n'
    round1_bundle+="模型：${p}"$'\n'
    round1_bundle+="檔案：${round1_dir}/${p}.md"$'\n'
    round1_bundle+=$'內容：\n'
    round1_bundle+="$(<"$round1_dir/${p}.md")"$'\n\n'
  done

  cat <<EOF
你現在扮演交叉檢查流程中的 ${provider}，正在執行第二輪交叉分析。

任務模式：$mode
分析強度：heavy
第一輪任務說明：
$task_prompt

你的任務不是重寫原始文件，而是分析各家第一輪分析的異同。

請用繁體中文輸出，至少包含：
1. 各家共同結論
2. 各家主要分歧
3. 你認為哪一家看法最值得優先採納，為什麼
4. 你認為最終決策還缺什麼資訊
5. 你的整體結論

重要限制：
- 你要同時看原始文件與各家第一輪分析。
- 請明確點出共識與獨見，不要只做摘要。
- 你可以不同意你自己第一輪的觀點，但要說明原因。

原始文件如下：

$source_content

第一輪分析如下：

$round1_bundle
EOF
}

run_provider() {
  local provider="$1"
  local provider_prompt="$2"
  local output_file="$3"
  local stage="$4"
  local log_file="$logs_dir/${stage}-${provider}.log"
  local status_file="$logs_dir/${stage}-${provider}.status"

  case "$provider" in
    claude)
      if ! command -v claude >/dev/null 2>&1; then
        print -r -- "missing command: claude" >"$log_file"
        print -r -- "missing" >"$status_file"
        return 1
      fi
      if perl -e 'alarm shift; exec @ARGV' "$timeout_sec" claude -p "$provider_prompt" >"$output_file" 2>"$log_file"; then
        print -r -- "ok" >"$status_file"
        return 0
      fi
      print -r -- "failed" >"$status_file"
      return 1
      ;;
    codex)
      if ! command -v codex >/dev/null 2>&1; then
        print -r -- "missing command: codex" >"$log_file"
        print -r -- "missing" >"$status_file"
        return 1
      fi
      if env OTEL_SDK_DISABLED=true perl -e 'alarm shift; exec @ARGV' "$timeout_sec" codex exec --skip-git-repo-check --output-last-message "$output_file" "$provider_prompt" >"$log_file" 2>&1; then
        print -r -- "ok" >"$status_file"
        return 0
      fi
      print -r -- "failed" >"$status_file"
      return 1
      ;;
    *)
      print -r -- "unsupported provider: $provider" >"$log_file"
      print -r -- "unsupported" >"$status_file"
      return 1
      ;;
  esac
}

success_providers=()
failed_providers=()
round2_success_providers=()
round2_failed_providers=()

for provider in "${providers[@]}"; do
  provider_prompt="$(build_round1_prompt "$provider")"
  prompt_file="$package_dir/prompt-round1-${provider}.md"
  print -r -- "$provider_prompt" >"$prompt_file"
  if run_provider "$provider" "$provider_prompt" "$round1_dir/${provider}.md" "round1"; then
    success_providers+=("$provider")
  else
    failed_providers+=("$provider")
  fi
done

if [[ "$intensity" == "heavy" ]] && [[ ${#success_providers[@]} -ge 2 ]]; then
  for provider in "${success_providers[@]}"; do
    provider_prompt="$(build_round2_prompt "$provider")"
    prompt_file="$package_dir/prompt-round2-${provider}.md"
    print -r -- "$provider_prompt" >"$prompt_file"
    if run_provider "$provider" "$provider_prompt" "$round2_dir/${provider}.md" "round2"; then
      round2_success_providers+=("$provider")
    else
      round2_failed_providers+=("$provider")
    fi
  done
fi

{
  print -- "# Cross-check Manifest"
  print
  print -- "- Timestamp: $timestamp"
  print -- "- Mode: $mode"
  print -- "- Intensity: $intensity"
  print -- "- Integrator: $integrator"
  print -- "- Source: $source_file"
  print -- "- Package: $package_dir"
  print -- "- Round 1 successful providers: ${success_providers[*]:-none}"
  print -- "- Round 1 failed providers: ${failed_providers[*]:-none}"
  if [[ "$intensity" == "heavy" ]]; then
    print -- "- Round 2 successful providers: ${round2_success_providers[*]:-none}"
    print -- "- Round 2 failed providers: ${round2_failed_providers[*]:-none}"
  fi
  print
  print -- "## Round 1 Outputs"
  for provider in "${providers[@]}"; do
    print -- "- $provider: $round1_dir/${provider}.md"
  done
  if [[ "$intensity" == "heavy" ]]; then
    print
    print -- "## Round 2 Outputs"
    for provider in "${success_providers[@]}"; do
      print -- "- $provider: $round2_dir/${provider}.md"
    done
  fi
  print
  print -- "## Logs"
  for provider in "${providers[@]}"; do
    print -- "- round1 $provider: $logs_dir/round1-${provider}.log"
  done
  if [[ "$intensity" == "heavy" ]]; then
    for provider in "${success_providers[@]}"; do
      print -- "- round2 $provider: $logs_dir/round2-${provider}.log"
    done
  fi
} >"$manifest_file"

{
  print -- "# 最終整合提示"
  print
  print -- "你現在是這次交叉比對的最後整合器。"
  print
  print -- "請讀以下材料："
  print -- "- 原始文件：$source_file"
  for provider in "${success_providers[@]}"; do
    print -- "- ${provider} 第一輪原始輸出：$round1_dir/${provider}.md"
  done
  if [[ "$intensity" == "heavy" ]]; then
    for provider in "${round2_success_providers[@]}"; do
      print -- "- ${provider} 第二輪交叉分析：$round2_dir/${provider}.md"
    done
  fi
  print
  print -- "任務模式：$mode"
  print -- "分析強度：$intensity"
  print -- "整合器建議：$integrator"
  print
  case "$mode" in
    outside)
      print -- "請整理成一份外部視角檢查報告，重點是：哪些地方外人會卡住、原因是什麼、最值得優先修改的是什麼。"
      ;;
    style)
      print -- "請整理成一份風格並陳報告，不要幫使用者硬選唯一答案。請比較不同版本的取向、語氣、適用情境。"
      ;;
    blindspot)
      print -- "請整理成一份盲點總表，至少輸出三區：共識、獨見、你的最終判斷。"
      ;;
  esac
  if [[ "$intensity" == "heavy" ]]; then
    print -- "這次是重度交叉分析，除了第一輪模型意見，還要比較第二輪各模型對彼此分析的再分析。"
  fi
  print
  print -- "輸出要求："
  print -- "- 用繁體中文"
  print -- "- 明確標示各模型觀點來源"
  print -- "- 不要只貼原文，要做二次整理"
  print -- "- 若有分歧，請區分第一輪分歧與第二輪分歧"
} >"$integration_prompt_file"

{
  print -- "# 交叉比對報告"
  print
  print -- "- 模式：$mode"
  print -- "- 強度：$intensity"
  print -- "- 整合器：$integrator"
  print -- "- 原始文件：[${source_name}]($source_file)"
  print -- "- 材料包：$package_dir"
  print -- "- 第一輪成功模型：${success_providers[*]:-無}"
  print -- "- 第一輪失敗模型：${failed_providers[*]:-無}"
  if [[ "$intensity" == "heavy" ]]; then
    print -- "- 第二輪成功模型：${round2_success_providers[*]:-無}"
    print -- "- 第二輪失敗模型：${round2_failed_providers[*]:-無}"
  fi
  print
  if [[ ${#failed_providers[@]} -gt 0 ]]; then
    print -- "> 注意：有模型未成功執行，請先查看材料包內 logs/。"
    print
  fi
  print -- "## 後整合說明"
  print
  case "$integrator" in
    cowork)
      print -- "這包材料適合交給桌面版 Claude Cowork 做最終整合，因為 Cowork 比較適合帶著知識庫脈絡收斂成正式文件。"
      ;;
    code)
      print -- "這包材料適合交給桌面版 Claude Code 做最終整合，因為 Code 比較適合快速比對、整理與一次性輸出。"
      ;;
    manual)
      print -- "這包材料目前只做收集，不綁定最後整合器，你可以自行決定這次交給誰。"
      ;;
  esac
  print
  print -- "整合提示檔：[$integration_prompt_file]($integration_prompt_file)"
  print -- "材料清單：[$manifest_file]($manifest_file)"
  print
  print -- "## 第一輪分析"
  print
  for provider in "${success_providers[@]}"; do
    print -- "## ${provider:u}"
    print
    print -- "原始輸出：[$round1_dir/${provider}.md]($round1_dir/${provider}.md)"
    print
    sed 's/^/> /' "$round1_dir/${provider}.md"
    print
  done
  if [[ "$intensity" == "heavy" ]] && [[ ${#round2_success_providers[@]} -gt 0 ]]; then
    print -- "## 第二輪交叉分析"
    print
    for provider in "${round2_success_providers[@]}"; do
      print -- "## ${provider:u}"
      print
      print -- "第二輪輸出：[$round2_dir/${provider}.md]($round2_dir/${provider}.md)"
      print
      sed 's/^/> /' "$round2_dir/${provider}.md"
      print
    done
  fi
} >"$report_file"

print -- "Done"
print -- "Report: $report_file"
print -- "Package: $package_dir"
