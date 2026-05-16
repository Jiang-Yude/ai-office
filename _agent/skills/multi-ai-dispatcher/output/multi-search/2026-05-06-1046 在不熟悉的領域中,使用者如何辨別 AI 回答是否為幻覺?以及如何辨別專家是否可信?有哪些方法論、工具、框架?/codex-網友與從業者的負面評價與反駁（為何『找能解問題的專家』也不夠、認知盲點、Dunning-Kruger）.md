# 網友與從業者的負面評價與反駁（為何『找能解問題的專家』也不夠、認知盲點、Dunning-Kruger）：在不熟悉的領域中,使用者如何辨別 AI 回答是否為幻覺?以及如何辨別專家是否可信?有哪些方法論、工具、框架?

## 來源列表
1. [Why language models hallucinate](https://openai.com/research/why-language-models-hallucinate/) — 2025-09-05
2. [AI makes you smarter but none the wiser](https://www.sciencedirect.com/science/article/pii/S0747563225002262) — 2026-02
3. [Reddit r/science discussion on AI and reverse Dunning-Kruger](https://www.reddit.com/r/science/comments/1oj0pn9/when_interacting_with_ai_tools_like_chatgpt/) — 2025-10-29
4. [How to Spot Real Expertise](https://www.clearerthinking.org/post/how-to-spot-real-expertise) — 2024-04-17, updated 2024-07-04
5. [Novices and Expert Disagreement](https://academic.oup.com/book/35018/chapter/298800827) — 2019-09-19
6. [When the Experts Are Wrong](https://academic.oup.com/book/55947/chapter/439420039) — 2024-02-22
7. [Detecting hallucinations in large language models using semantic entropy](https://www.nature.com/articles/s41586-024-07421-0) — 2024-06-19
8. [SIFT: Empowering Informed Communities](https://depts.washington.edu/learncip/sift/) — no page date found
9. [Stanford scholars observe experts to see how they evaluate credibility online](https://ed.stanford.edu/news/stanford-scholars-observe-experts-see-how-they-evaluate-credibility-information-online) — 2017-10-24
10. [The Superforecasters’ Track Record](https://goodjudgment.com/resources/the-superforecasters-track-record/) — 2023
11. [Foxes, Hedgehogs, and Regulators](https://www.cato.org/regulation/fall-2017/foxes-hedgehogs-regulators) — 2017

## 原文摘錄

### 來源 1
> “standard training and evaluation procedures reward guessing over acknowledging uncertainty.”

### 來源 2
> “Higher AI literacy correlates with lower self-assessment accuracy.”

### 來源 3
> “Checking a giant wall of text for accuracy and content takes longer in general than writing it.”

### 來源 4
> “sometimes the fake experts even have very impressive credentials”

### 來源 5
> “we are often not well-poised to distinguish between rival experts.”

### 來源 6
> “Experts make mistake all the time.”

### 來源 7
> “users cannot trust that any given output is correct.”

### 來源 8
> “trace a claim back to its original context.”

### 來源 9
> “fact checkers read less but learn more”

### 來源 10
> “For every forecast we make, we keep score so we can learn and improve.”

### 來源 11
> “experts often do little better than laymen in predicting the future.”

## 關鍵重點

- 「AI 回答像專家」不等於可靠；OpenAI 的材料指出，模型被訓練與評估制度推向「猜答案」，所以使用者不能只看語氣自信或文字完整度。（來源 1）
- Dunning-Kruger 在 AI 使用情境中可能變形：ScienceDirect 這篇研究摘要指出，AI 使用者整體會高估表現，而且 AI literacy 較高者反而可能自我評估更差。（來源 2）
- 從業者/網友的負面反駁集中在「驗證成本」：AI 產出很快，但檢查一大段文字的事實與邏輯常比自己寫更慢，導致口頭上說會查證，實務上容易直接信。（來源 3）
- 「找專家」仍不夠，因為假專家也可能有漂亮 credentials；比較可用的訊號是：是否標示信心水準、承認不知道、引用高品質證據、鼓勵看其他來源、能說明主流共識與自己偏離共識的理由。（來源 4）
- 新手在專家互相衝突時，常沒有足夠能力分辨哪個專家更可信；這正是「我不懂所以找專家」仍然不夠的核心盲點。（來源 5）
- 專家會犯錯、也可能有 misconduct、error、credential misrepresentation、prediction failure；所以可信度不能只看頭銜，要看可檢查的過程與紀錄。（來源 6）
- 對 AI 幻覺的技術檢測方向之一是 semantic entropy：看同一問題多次生成在「語義層」是否分歧，用來提示哪些回答需要額外小心。（來源 7）
- SIFT / lateral reading 是可操作的方法論：Stop、Investigate、Find better coverage、Trace claims。重點不是在原頁面裡越讀越深，而是跳出去找來源背景、交叉報導、原始脈絡。（來源 8、9）
- 專家可信度的一個反直覺指標是「可記分的預測紀錄」；Good Judgment 強調對每個 forecast 留紀錄、事後檢討，這比單次雄辯或名氣更可驗證。（來源 10）
- Tetlock 相關材料反駁「專家自然比外行準」：至少在預測型問題上，某些專家表現接近外行；更可信的是會更新、多視角、可校準、可回顧的人。（來源 11）

## 不確定點

- 關於「一般使用者最有效辨別 AI 幻覺的方法」沒有找到單一公認標準；目前資料較像工具箱：SIFT/lateral reading、原始來源追溯、信心校準、語義分歧檢測、專家交叉比對。
- 關於「找能解問題的專家是否不夠」有支持與反駁兩邊：資料支持「只找單一專家不夠」，但沒有資料支持「專家完全無用」。
- 「Dunning-Kruger」在 AI 使用情境中是否已被穩定改寫，仍要看後續研究；目前找到的是 2026 Computers in Human Behavior 研究與社群討論，代表性高，但不等於所有任務都成立。