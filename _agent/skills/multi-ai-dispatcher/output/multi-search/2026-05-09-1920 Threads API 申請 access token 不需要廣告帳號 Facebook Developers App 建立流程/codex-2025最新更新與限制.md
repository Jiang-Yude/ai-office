# 2025最新更新與限制：Threads API 申請 access token 不需要廣告帳號 Facebook Developers App 建立流程

## 來源列表
1. [Meta / Postman：Threads API Documentation](https://www.postman.com/meta/threads/documentation/dht3nzz/threads-api?entity=request-34203612-f8bf85ba-a2a2-47f8-9183-f94cd3e9c9d3) — 未標示日期，官方 Collection
2. [PPC Land：Meta expands advertising formats on Threads with catalog ads](https://ppc.land/meta-expands-advertising-formats-on-threads-with-catalog-ads/) — Oct 28, 2025
3. [PPC Land：Meta expands Threads API with advanced features for developers](https://ppc.land/meta-expands-threads-api-with-advanced-features-for-developers/) — Jul 28, 2025
4. [Packagist：revolution/laravel-threads](https://packagist.org/packages/revolution/laravel-threads) — 未標示頁面日期
5. [Make Community：Can’t Post to Threads via threads_content_publish Despite Being Authorised Tester](https://community.make.com/t/cant-post-to-threads-via-threads-content-publish-despite-being-authorised-tester/76204) — Mar 24, 2025 / Jun 14, 2025

## 原文摘錄

### 來源 1
> You need to create a Meta app with the Threads use case.

> The Grant type must be set to Authorization Code.

> Note: The `threads_basic` permission is sufficient for the exchange or refresh process.

### 來源 2
> The platform eliminated the requirement for a linked Instagram account on September 23, 2025.

> Threads profiles without Instagram connections can access all API functionalities except followers_count and follower_demographics user metrics.

### 來源 3
> Implementation requires specific API permissions including "threads_basic" for core functionality

> Meta's app review process ensures appropriate usage while maintaining platform integrity.

### 來源 4
> To use the Threads API, you need to create an "App" on Meta for Developers.

> "Do not link to a business portfolio"

> Add your Threads account as a Threads tester. Approve it on the Threads website. Generate a token.

### 來源 5
> I have the correct access token with all relevant scopes

> `threads_basic` calls work fine and return data.

> Maybe you can try to add the tester role to your Meta app

## 關鍵重點
- 官方 Postman 流程列出的 access token 前置條件是 Meta App + Threads use case + OAuth Authorization Code + app id / secret / scope；來源未列「廣告帳號」為必要條件。（來源 1）
- 目前可找到的實作文件明確寫「Do not link to a business portfolio」，這不是「廣告帳號」同義詞，但支持建立 Threads API App 時不一定要綁 Business Portfolio。（來源 4）
- `threads_basic` 是 token exchange / refresh 充分權限；發文、刪除、搜尋等再另外啟用 `threads_content_publish`、`threads_delete`、`threads_keyword_search`。（來源 1、4）
- 2025 的重要限制更新：Threads API 在 2025-09-23 取消「必須連結 Instagram account」要求，但沒有 Instagram 連結時，`followers_count` 與 `follower_demographics` 仍例外不可用。（來源 2）
- 進 production / 非 tester 使用時，限制集中在 permission、tester role、App Review / Advanced Access，而不是廣告帳號。（來源 3、5）

## 不確定點
- 無資料：我沒有找到 Meta 官方明文寫「申請 Threads API access token 不需要廣告帳號」。
- 有資料但不能等同：來源 4 的「Do not link to a business portfolio」只能說不必連 Business Portfolio，不能直接推論成所有情境都不需要廣告帳號。
- 官方 developers.facebook.com 文件頁本次讀取時多次回 429；目前官方依據主要來自 Meta 的 Postman Collection，以及其連到 developer documentation / changelog 的說法。
- 來源 2、3 引用 Meta Threads API changelog，但本次沒有成功直接讀取官方 changelog 原頁；因此 2025 更新時間線應視為「代表性二手整理」，不是官方原頁逐字驗證。

