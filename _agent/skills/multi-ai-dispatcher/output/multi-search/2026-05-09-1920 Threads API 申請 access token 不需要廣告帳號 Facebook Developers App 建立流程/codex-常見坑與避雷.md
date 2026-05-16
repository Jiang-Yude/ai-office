# 常見坑與避雷：Threads API 申請 access token 不需要廣告帳號 Facebook Developers App 建立流程

## 來源列表
1. [Long-Lived Tokens - Threads API - Meta for Developers](https://developers.facebook.com/docs/threads/get-started/long-lived-tokens) — 未標示日期（存取：2026-05-09）
2. [Threads API Documentation - Postman / Meta](https://www.postman.com/meta/threads/documentation/dht3nzz/threads-api) — 未標示日期（存取：2026-05-09）
3. [Meta API Setup - Zirelia Docs](https://zirelia.github.io/zirelia/guides/meta_setup/) — 未標示日期（搜尋結果：近 2 週）
4. [API Credentials for Threads - Botize](https://botize.com/en/api-credentials/threads) — 未標示日期（搜尋結果：近 3 天）
5. [Threads - Postiz Documentation](https://docs.postiz.com/providers/threads) — 未標示日期（搜尋結果：近 3 週）
6. [Meta Threads API exchange access tokens in error - Stack Overflow](https://stackoverflow.com/questions/79895230/meta-threads-api-exchange-access-tokens-in-error) — 2026-02-24 / 2026-02-26

## 原文摘錄

### 來源 1
> “Threads user access tokens are short-lived and are valid for one hour.”

### 來源 2
> “You need to create a Meta app with the Threads use case.”

### 來源 3
> “The "Threads App ID" on the Customize page is DIFFERENT from the App ID shown in Settings > Basic!”

### 來源 4
> “Select a “Business Portfolio”. If you don’t have one, create a new one”

### 來源 5
> “You should not have any extra requirements to publish and maintain access.”

### 來源 6
> “This action requires the threads_basic permission.”

## 關鍵重點

- 建立 Threads API app 的核心是「Threads use case」，不是 Facebook Ads API 或廣告帳號流程。（對應來源 2）
- access token 有短期與長期差異；短期 token 預設 1 小時，實作時要換長期 token。（對應來源 1）
- 常見坑：OAuth 用錯 App ID。Threads App ID 可能不同於一般 App ID，需用 Threads use case/customize 頁面顯示的值。（對應來源 3）
- 常見坑：Meta 建立流程可能要求 Business Portfolio，但這不等於必須有廣告帳號。（對應來源 4）
- 第三方文件明確提到 publish/maintain access 不應有額外要求，支持「不需要廣告帳號」這個避雷方向；但這不是 Meta 官方原文。（對應來源 5）
- 常見錯誤：即使 app 已 approved/published，仍可能遇到 `threads_basic` 權限錯誤；Stack Overflow 案例中有人用 unpublish / republish 修復。（對應來源 6）

## 不確定點

- 我沒有找到 Meta 官方文件直接寫出「不需要廣告帳號」這句原文。
- 「Business Portfolio」是否在所有帳號 / 地區 / app 類型中都必填，第三方流程說法不完全一致。
- Stack Overflow 的 unpublish / republish 解法是社群案例，不是官方保證流程。
- Postiz 與 Botize 是第三方工具文件，可作實務參考，但不能取代 Meta 官方文件。