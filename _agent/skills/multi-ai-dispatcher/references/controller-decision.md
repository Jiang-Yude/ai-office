# 主控台動態切換決策

> 這份文件回答一個問題：**多 AI 協作專案中，誰當主控台？**
>
> 來源：2026-05-02 風組長派 Codex（gpt-5.5）評估「Claude Code 主控、Codex 雜工」分工方案後沉澱。

## 核心判斷：主控台不是固定的，是動態切換的

很多人預設「Claude Code 永遠主控」或「Codex 永遠主控」，這是錯的。

主控台的本質是「持有對話脈絡 + 做判斷」。**判斷類型隨任務階段改變，主控台也應該換人**。

## 三階段切換規則

```
階段              主控台          雜工           用戶感受
─────────────────────────────────────────────────────────
規劃／設計        Claude Code     Codex          跟 Claude 對話
（需求釐清、      （需求、品味、  （查資料、     決定方向
 品牌策略、       策展、文案）    驗證、研究、
 站體架構）                       外部視角）

實作／開發        Codex           Claude Code    跟 Codex 對話
（建好 repo 後、  （repo owner、  （文案候選、   工單與審查
 開始寫程式）     寫程式、測試、  品牌語氣
                  部署、整合）    檢查）

審查／上線        Claude Code     Codex          跟 Claude 對話
（最終把關、      （品牌驗收、    （部署、bug    最終把關
 文案校對）       訪客視角、      修正、SEO）
                  最後決策）
```

切換點：**「有 repo」是分水嶺。** repo 還沒建 → Claude 主控；repo 建好開始寫程式 → Codex 主控；要上線了 → 切回 Claude 把關品牌。

## 為什麼這樣切

### 規劃期 Claude 主控的理由

- 持有完整對話脈絡（CLAUDE.md、Memory.md、過往討論）
- 擅長品味判斷（命名、視覺方向、文案調性）
- 能跟使用者來回對話、改方向、不會卡在「要繼續嗎」
- 對話成本：高 token 但低頻決策，剛好

### 實作期 Codex 主控的理由

- 比 Claude Code 更會持續執行長任務（不太需要使用者回應就能跑）
- 對 repo 操作更直接（讀檔、改檔、跑測試、看 log、部署）
- token 成本對「高頻執行低頻判斷」的工作更划算
- 可以連續跑數小時不斷頭

### 審查期切回 Claude 的理由

- 工程完成 ≠ 產品完成
- 需要品牌驗收、訪客視角、文案校對
- 這些都是判斷類工作，回到 Claude 強項

## 切換觸發訊號

從 Claude 切到 Codex 主控的訊號：

- repo 已經 init、技術選型已定
- 接下來主要是「寫程式、修 bug、跑測試」
- 工程風險高於品牌風險（例如資料 pipeline、slug 系統、build 設定）
- 需要連續跑多小時不中斷

從 Codex 切回 Claude 主控的訊號：

- 進入上線前的最終驗收
- 需要做品牌品質判斷（不是技術判斷）
- 使用者要看「整體感覺對不對」
- 要寫對外文案、社群推廣、講座簡報

## 切換時的 handoff 流程

切換主控不是換衣服，是要做交接。

從 Claude → Codex 切換時，Claude 要交：

- **完整工單**（machine-readable 格式，見下方）
- **設計決策摘要**（為什麼選 X 不選 Y）
- **品牌規範**（顏色、字型、文案禁忌）
- **驗收條件**（怎樣算做完）
- **檔案 ownership**（哪些檔 Codex 可以改、哪些不能碰）

從 Codex → Claude 切換時，Codex 要交：

- **實作清單**（做了什麼、改了哪些檔）
- **未解問題**（卡在哪、需要決策的點）
- **build / test 結果**（git diff、測試輸出、deploy preview URL）
- **已知 bug 與 workaround**

## 工單格式（machine-readable）

Claude 給 Codex 的工單必須結構化，否則 Bash subprocess 遙控很脆弱。

固定七段：

```markdown
## Task
（一句話說明要做什麼）

## Context
（背景脈絡：專案是什麼、為什麼做這個、跟其他任務的關係）

## Files in scope
（明確列出可以改哪些檔，用絕對路徑）

## Do not touch
（明確列出不能改哪些檔；如：CLAUDE.md、其他技能包、未列入 scope 的檔）

## Acceptance criteria
（驗收條件：怎樣算做完、要產出什麼檔、要通過什麼測試）

## Verification command
（給驗收用的指令，例如 `npm run build && npm run test`）

## Expected report
（要 Codex 回報什麼：done/blocked、改了哪些檔、有什麼風險、git diff 摘要）
```

## Claude 不應該直接判斷工程完成

最常見的盲點：Claude 看 Codex 說「做完了」就回報使用者完成。

實際上 Claude 應該再驗證一道：

- 看 git diff
- 跑驗收指令（npm run build、tests）
- 看 deploy preview
- 截圖看視覺

「Codex 說做完了」≠「真的做完了」。永遠要看證據。

## 多代理並行的工程紀律

風組長的多代理並行（multi-search、cross-check）只在「探索期」用。**進入實作期就要降回單寫手**。

### 為什麼

- token 成本指數型上升（三個代理各讀一遍 repo、各產一份報告）
- context 不同步（A 改了資料結構、B 還在舊假設下改 UI）
- 結果格式不一致（有人給建議、有人給 patch、有人給半成品）
- 重複解同一題（三個代理都在設計 slug、都在選圖譜 library）
- repo 寫入衝突（同時改 `astro.config.mjs`、`package.json` 互相踩）

### 多代理使用原則

- **探索期**可以多代理（搜尋、研究、外部視角）
- **實作期**最多一個主寫手，其他只讀不寫
- 同時寫入時，必須**分檔案 ownership**（A 只動 src/components/、B 只動 src/content/）
- 子代理最後只交：**決策、證據、風險、建議 patch**，不交長篇散文

### 子代理的 bounded task

子代理不要做開放式工作。給明確邊界：

- 「只研究 graph library，回三個候選 + 取捨表」
- 「只整理 wiki-link 規則，產一份轉換 spec」
- 「只檢查 SEO metadata，列出缺漏項」

避免「請你幫我做這個專案的某部分」這種模糊指派。

## 反例：不要這樣分工

**反例 1：Claude 一直主控、Codex 永遠雜工**
- 進入實作期後 Claude 還在每個 build error 都跑回來問使用者
- 使用者會被迫做工程細節決策
- 應該切換到 Codex 主控，使用者只看結果

**反例 2：Codex 一直主控、Claude 偶爾插嘴**
- 從規劃就讓 Codex 開始寫程式
- 還沒想清楚要做什麼，先寫了一堆程式碼
- 應該規劃期讓 Claude 主控收斂方向

**反例 3：兩邊都覺得自己是主控**
- Claude 寫工單給 Codex，Codex 自己又寫文案給 Claude
- 沒有明確「現在誰當家」的共識
- 結果產出衝突、互相覆蓋

## 適用範圍

這套「動態主控切換」適合：

- 從零開始的大專案（建站、產品開發、技能包設計）
- 需要規劃 + 實作 + 審查三段式工作流
- 使用者有 Claude Code + Codex 兩個 CLI 環境

不適合：

- 純對話、純研究、純查資料（Claude 一個就夠）
- 純工程修 bug、純 refactor（Codex 一個就夠）
- 不到一小時就做完的小任務（不需要切換成本）

## 風組長的責任

風組長被叫進來判斷「主控台是誰」時，要做的事：

1. 判斷專案在哪個階段（規劃／實作／審查）
2. 確認當前主控台是不是該階段該負責的人
3. 不對 → 建議切換 + 給 handoff 清單
4. 對 → 確認分工沒有越界（Claude 不要寫程式、Codex 不要決策品牌）

風組長不負責執行切換，負責提醒切換時機。
