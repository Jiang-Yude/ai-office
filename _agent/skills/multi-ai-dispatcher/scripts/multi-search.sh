#!/bin/bash
# multi-search.sh - 多代理並行搜尋（風組長調度）
#
# 預設三角度：官方 / 正面評價 / 負面評價（可用 --angles 覆寫）
# 由 Codex 開 3 個子代理並行查，最後由 Codex 整合。
#
# 用法：
#   multi-search.sh [options] "搜尋主題"
#
# 選項：
#   --angles "a,b,c"           三個角度，逗號分隔
#   --help                     顯示說明
#
# 觸發來源：
#   收到「多代理查」「上網查」→ 調此腳本

set -euo pipefail

# ========== 預設值 ==========
ANGLES="官方,正面評價,負面評價"
QUERY=""

# ========== 解析參數 ==========
while [[ $# -gt 0 ]]; do
  case "$1" in
    --angles)
      ANGLES="$2"; shift 2 ;;
    --help|-h)
      grep '^#' "$0" | sed 's/^# \{0,1\}//; s/^#$//'
      exit 0 ;;
    --*)
      echo "未知參數：$1" >&2; exit 1 ;;
    *)
      QUERY="$1"; shift ;;
  esac
done

if [[ -z "$QUERY" ]]; then
  echo "錯誤：缺少搜尋主題" >&2
  echo "用法：multi-search.sh [options] \"搜尋主題\"" >&2
  exit 1
fi

# ========== 準備輸出資料夾 ==========
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TIMESTAMP=$(TZ=Asia/Taipei date +"%Y-%m-%d-%H%M")
OUTDIR="${SCRIPT_DIR}/../output/multi-search/${TIMESTAMP} ${QUERY}"
mkdir -p "$OUTDIR"

echo "主題：$QUERY"
echo "角度：$ANGLES"
echo "輸出：$OUTDIR"
echo ""

# ========== 拆角度 ==========
IFS=',' read -ra ANGLE_ARRAY <<< "$ANGLES"
if [[ ${#ANGLE_ARRAY[@]} -ne 3 ]]; then
  echo "提醒：建議三個角度，目前 ${#ANGLE_ARRAY[@]} 個" >&2
fi

# ========== Prompt 模板 ==========
build_prompt() {
  local angle="$1"
  cat <<EOF
搜尋主題：${QUERY}
角度：${angle}

任務：從「${angle}」角度上網搜尋這個主題，找最近、最具代表性的資料。

硬規則：
- 只輸出有來源的資訊，每條都要附 URL
- 摘錄原文，不做翻譯或改寫
- 找不到就明說「無資料」，不要推論
- 區分「原文摘錄」和「你的整理說明」

輸出格式（Markdown）：

# ${angle}：${QUERY}

## 來源列表
1. [標題](URL) — 日期
2. ...

## 原文摘錄
### 來源 1
> 原文內容...

### 來源 2
> 原文內容...

## 關鍵重點
- 重點 1（對應來源 X）
- 重點 2（對應來源 Y）

## 不確定點
- 矛盾、爭議或查不到的部分
EOF
}

# ========== 呼叫函式 ==========
run_codex() {
  local angle="$1"
  local tag="codex-${angle}"
  local outfile="${OUTDIR}/${tag}.md"
  local logfile="${OUTDIR}/${tag}.log"
  local prompt
  prompt="$(build_prompt "$angle")"

  echo "[Codex] 啟動：${angle}" >&2
  if codex exec \
       --skip-git-repo-check \
       --sandbox read-only \
       -o "$outfile" \
       "$prompt" >"$logfile" 2>&1; then
    echo "[Codex] 完成：${angle} → ${outfile}" >&2
  else
    echo "[Codex] 失敗：${angle}（看 ${logfile}）" >&2
  fi
}

# ========== 並行執行 ==========
PIDS=()

for angle in "${ANGLE_ARRAY[@]}"; do
  run_codex "$angle" &
  PIDS+=($!)
done

for pid in "${PIDS[@]}"; do
  wait "$pid" || true
done

# ========== 產生整合材料包 ==========
MATERIALS="${OUTDIR}/materials.md"
{
  echo "# 多代理搜尋材料包"
  echo ""
  echo "- 主題：${QUERY}"
  echo "- 角度：${ANGLES}"
  echo "- 時間：${TIMESTAMP}"
  echo ""
  echo "## 代理清單"
  for angle in "${ANGLE_ARRAY[@]}"; do
    echo "- Codex × ${angle}：[codex-${angle}.md](codex-${angle}.md)"
  done
  echo ""
  echo "## 整合建議（交給 Codex 做最後整合）"
  echo ""
  echo "1. 交叉比對不同角度的資訊"
  echo "2. 標出矛盾、爭議、待驗證的點"
  echo "3. 保留來源引用（URL、日期）"
  echo "4. 不要把模型推論和原文摘錄混在一起"
  echo "5. 找不到資料的角度也要明說，不要補齊"
} > "$MATERIALS"

echo ""
echo "✅ 完成"
echo "材料包：$MATERIALS"
