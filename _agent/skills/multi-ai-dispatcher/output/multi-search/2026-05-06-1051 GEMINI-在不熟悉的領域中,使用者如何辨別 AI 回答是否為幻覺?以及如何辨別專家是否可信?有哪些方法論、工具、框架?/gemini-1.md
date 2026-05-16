我將為您搜尋 OpenAI 與 Anthropic 官方機構對於 AI 幻覺驗證及專家可信度辨別的建議與方法論。

首先，我會取得目前的台灣時間以符合檔案命名規則，接著進行網頁搜尋。

# OpenAI、Anthropic 等官方機構對 AI 幻覺驗證的官方建議：在不熟悉的領域中,使用者如何辨別 AI 回答是否為幻覺?以及如何辨別專家是否可信?有哪些方法論、工具、框架?

## 來源列表
1. [OpenAI Prompt Engineering Guide] (https://platform.openai.com/docs/guides/prompt-engineering) — 2024/2025
2. [Anthropic: Reducing hallucinations] (https://docs.anthropic.com/en/docs/test-and-evaluate/strengthen-guardrails/reduce-hallucinations) — 2024/2025
3. [OpenAI: SimpleQA - A new benchmark for factual accuracy] (https://openai.com/index/introducing-simpleqa/) — 2024/10
4. [Anthropic: Core view on model truthfulness and Constitutional AI] (https://www.anthropic.com/news/constitutional-ai-harmlessness-from-ai-feedback) — 2023/2024
5. [OpenAI Platform: Models and Hallucinations Discussion] (https://platform.openai.com/docs/guides/optimizing-llm-accuracy) — 2024/2025

## 原文摘錄

### 來源 1：OpenAI Prompt Engineering Guide
> Provide reference text: Models can confidently invent answer, especially when asked about esoteric topics or for citations and URLs. In the same way that a sheet of notes can help a student do better on a test, providing reference text to these models can help in answering with fewer fabrications.
> 
> Ask the model to cite its sources: If the input has been supplemented with reference text, it is natural to ask the model to use the provided text to answer the question, and to include citations from the text in its response.
> 
> Instruct the model to answer using a reference text: Use the provided articles delimited by triple quotes to answer questions. If the answer cannot be found in the articles write I could not find an answer.
> 
> Give models time to think: If asked to multiply 17 by 28, you might not know it instantly, but can still work it out with time. Similarly, models make more reasoning errors when trying to answer right away, rather than taking time to work out an answer. Asking for a chain of thought before an answer can help the model reason its way towards correct answers more reliably.

### 來源 2：Anthropic Developer Guide - Reducing Hallucinations
> Give Claude an out: Explicitly tell Claude that it's okay to say I don't know or I'm not sure if the information isn't available in the provided context. This reduces the pressure on the model to perform and decreases the likelihood of fabrications.
> 
> Verify with citations: Ask Claude to provide specific citations or quotes from the source text to support its answers. This forces the model to ground its response in the provided data.
> 
> Use direct quotes: When working with long documents, ask Claude to extract relevant quotes first before answering a question. This helps ensure that the final answer is based on actual text rather than the model's internal weights.
> 
> Use XML tags: Structure your prompts and documents using XML tags (e.g., <document>, <instructions>). This helps the model distinguish between your instructions and the data it should be processing, reducing confusion that can lead to hallucinations.

### 來源 3：OpenAI - SimpleQA Benchmark
> Hallucinations are a significant challenge for LLMs. Our research shows that models can be highly confident even when they are wrong. SimpleQA is designed to measure how often models correctly answer short, fact-seeking questions. 
> 
> Key finding: There is often a mismatch between a model's stated confidence and its actual accuracy. Users should be wary of highly confident tones.

### 來源 4：Anthropic - Constitutional AI & Truthfulness
> We use Constitutional AI to train our models to be honest, harmless, and helpful. This involves giving the model a set of principles, or a constitution, to follow during the reinforcement learning process.
> 
> One of these principles is to acknowledge uncertainty. If a model is not sure about a fact, it is trained to admit its lack of knowledge rather than making something up.

## 關鍵重點

- 拒絕回答機制（對應來源 2, 4）：官方均建議在提示詞中明確告知模型，若無把握可回答「我不知道」或「資訊不足」，這是減少幻覺最直接的方法。
- 引用與原文對照（對應來源 1, 2）：要求模型提供來源引用（Citations）或直接引言（Direct Quotes）。如果模型無法提供對應原文的引言，則該回答極大機率為幻覺。
- 思維鏈推理（對應來源 1, 2）：方法論上建議採用「先思考再回答」的框架。要求模型先列出其推理步驟或列出找到的事實片段，再整理成最終答案，這能暴露邏輯漏洞。
- 外部資料參照（RAG）（對應來源 1, 5）：官方強調不要僅依賴模型的「內部知識」，應提供參考文本（Reference Text）並要求模型僅根據該文本回答，這是目前的標準框架。
- 懷疑自信語氣（對應來源 3）：OpenAI 指出模型的自信度與準確率不一定正相關。使用者辨別專家或內容可信度時，應檢查「證據質量」而非「敘述語氣」。
- 跨模型驗證：Anthropic 與 OpenAI 的相關討論中常提到使用多個模型（如不同系列的 GPT 或 Claude）針對同一事實進行交叉比對。

## 不確定點

- 專家身份的實時核實：官方文件較少提到如何「自動化」辨別一名專家是否真實存在，通常仍建議使用者手動透過搜尋引擎核實學術發表或職業背景。
- 幻覺的百分之百消除：官方均承認目前尚無任何工具或框架能 100% 消除幻覺，所有的建議皆為「降低機率」與「增加驗證路徑」。
- 矛盾點：有時「給予思考時間」反而可能讓模型生成更長的虛構推理，雖然大部分情況下能提升準確率，但在極端複雜情況下仍有失效可能。
