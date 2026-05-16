# Claude Code 呼叫 Codex 的多 Agent 搜尋協作 SOP

標籤：[[風組長]] [[AI工作流]] [[AIAgent]] [[ClaudeCode]] [[Codex]] [[多AI協作]] [[交叉驗證]]

日期：2026/05/04

## 定位

這份 reference 是風組長用來判斷與教學的操作案例。

核心場景：Claude Code 作為主控台，透過 `codex-plugin-cc` 呼叫本機 Codex CLI，讓 Codex 負責多代理搜尋與材料回收，再由 Claude Code 或主控 AI 做最後分析。

這不是單純工具安裝筆記，而是多 Agent 協作的標準案例。

## 何時使用

適合使用這個流程的情境：

- 需要查最新公開資料
- 需要官方、正面、負面三角度材料
- 需要避免單一搜尋視角造成確認偏誤
- Claude Code 額度有限，不適合把大量搜尋都壓在 Claude 上
- 需要把搜尋層和分析層拆開
- 使用者要教學「Agent 之間如何協作」

不適合使用的情境：

- 只是短問答
- 本地檔案整理
- 高敏感資料，不能丟給外部 provider
- 不需要來源查證的常識問題

## 標準分工

| 角色 | 職責 |
|---|---|
| Claude Code | 主控台、任務判斷、脈絡理解、最後分析 |
| Codex | 搜尋、子代理並行、材料回收、初步整理 |
| 風組長 | 分工判斷、任務邊界、驗證規格、整合順序 |
| Gemini CLI | 備用外部搜尋或交叉視角，需注意忙線與穩定性 |

## 安裝前提

Claude Code 內安裝 plugin：

```text
/plugin marketplace add openai/codex-plugin-cc
/plugin install codex@openai-codex
/reload-plugins
/codex:setup
```

本機 Codex CLI：

```bash
npm install -g @openai/codex
codex login
```

前提檢查：

- Claude Code 支援 plugin
- `codex-plugin-cc` 已安裝
- Codex CLI 已安裝
- Codex CLI 已登入
- 使用者有可用的 OpenAI / ChatGPT Codex 權限

## 搜尋任務規格

風組長派給 Codex 的搜尋任務要限制清楚。

Codex 子代理只做三件事：

1. 找資料
2. 列來源
3. 摘錄原文或整理可追溯材料

子代理不要做高階判斷，不要直接給最終建議。

這樣做是為了避免搜尋代理把「來源事實」和「模型推論」混在一起。

## 三代理預設角度

預設三角度：

- 官方資訊：官方文件、官方 repo、正式公告、release notes
- 正面評價：使用者推薦、成功案例、好用之處、採用理由
- 負面評價：問題、限制、踩雷、反對意見、穩定性疑慮

依主題可以替換成：

- 技術 / 商業 / 法規
- 產品 A / 產品 B / 產品 C
- 短期 / 中期 / 長期
- 官方 / 社群 / 競品

## Claude Code 回收後的分析順序

Codex 回收材料後，Claude Code 或主控 AI 依序處理：

1. 檢查是否有官方來源
2. 比對正面與負面材料是否互相矛盾
3. 區分來源事實、使用者觀感、模型推論
4. 標出不確定點
5. 整理成使用者需要的格式，例如教學、SOP、工作日記、決策建議

## 教學口徑

可以這樣對使用者說明：

> Claude Code 當主控，Codex 當搜尋與執行助理。需要查資料時，Codex 開三個代理，分別從官方、正面、負面角度找來源。查完後不要讓搜尋代理直接下結論，而是把材料交回 Claude Code 分析。這樣可以節省 Claude 額度，也能降低單一視角的盲點。

## 風組長判斷規則

遇到「Claude 要不要叫 Codex」「Codex 要不要開多代理」「Gemini CLI 要不要補查」時，風組長先問：

- 這次需要外部資料嗎？
- 這次需要多角度嗎？
- 這次是否有敏感資料？
- 這次是搜尋材料，還是要做最終判斷？
- 主控台應該是 Claude Code 還是 Codex？

如果答案是「需要公開資料、多角度、低敏感」，優先用 Codex 多代理搜尋。

如果答案是「需要知識庫脈絡、高度判斷、客戶資料」，搜尋可以拆出去，但最後分析必須回到主控 AI。

## 對 AI 辦公室的意義

這是 AI 辦公室從單一助理進入 Agent 團隊化的重要案例。

核心不是多開幾個模型，而是建立分工：

- 搜尋層只負責材料
- 分析層負責判斷
- 風組長負責調度規則
- 主控台負責最後收斂

這套流程可以成為 AI 辦公室課程中「Agent 之間協作」的標準示範。
