# 官方文件正確流程：Threads API 申請 access token 不需要廣告帳號 Facebook Developers App 建立流程

## 來源列表
1. [Threads Use Case - Meta App Development - Meta for Developers](https://developers.facebook.com/docs/development/create-an-app/threads-use-case) — 頁面未顯示日期，查閱：2026-05-09
2. [Long-Lived Access Tokens - Threads API - Meta for Developers](https://developers.facebook.com/docs/threads/get-started/long-lived-tokens) — 頁面未顯示日期，查閱：2026-05-09
3. [Threads API Documentation - Postman / Meta](https://www.postman.com/meta/threads/documentation/dht3nzz/threads-api) — 頁面未顯示日期，查閱：2026-05-09

## 原文摘錄
### 來源 1
> If you're building an app for a business you own or manage, you aren't required to connect a business to your app.

### 來源 2
> short-lived tokens can be exchanged for long-lived tokens.

> Long-lived tokens are valid for 60 days

### 來源 3
> You need to create a Meta app with the Threads use case.

> The Grant type must be set to Authorization Code.

## 關鍵重點
- 官方 Threads App 建立流程是建立 Meta app，選擇 `Access the Threads API` use case；來源 1。
- 官方文件明確寫「business」連結在自用或自有業務情境下不是必要；來源 1。
- 若是 Tech Provider、服務客戶或其他 business portfolios，發布 app 前需要連到完成 Access and Business Verification 的 business；來源 1。
- Threads 使用者 access token 的正式流程是 OAuth Authorization Code，而不是只靠 App access token；來源 3。
- short-lived Threads user access token 可以換 long-lived token；來源 2。
- long-lived token 需要 app secret、短效 user access token，並由 server-side request 執行；來源 2。

## 不確定點
- 官方文件中未找到「申請 Threads API access token 需要廣告帳號」這種要求。
- 官方文件中也未找到逐字寫明「不需要 advertising account / ad account」的句子；能確認的是官方流程提到 Meta app、Threads use case、OAuth、permissions、business optional / Tech Provider business verification，未把廣告帳號列為必要條件。