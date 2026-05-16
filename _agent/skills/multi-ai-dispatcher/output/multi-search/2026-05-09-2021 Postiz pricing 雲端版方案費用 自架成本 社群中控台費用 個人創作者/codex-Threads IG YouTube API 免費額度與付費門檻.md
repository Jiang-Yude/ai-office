# Threads IG YouTube API 免費額度與付費門檻：Postiz pricing 雲端版方案費用 自架成本 社群中控台費用 個人創作者

## 來源列表
1. [Postiz Pricing](https://postiz.com/pricing) — 頁面未標示日期，搜尋索引顯示約 3 週前抓取
2. [Postiz Docker Compose Documentation](https://docs.postiz.com/installation/docker-compose) — 頁面未標示日期
3. [Postiz Providers Overview](https://docs.postiz.com/providers/overview) — 頁面未標示日期
4. [YouTube Data API Overview](https://developers.google.com/youtube/v3/getting-started) — Last updated 2025-12-04 UTC
5. [YouTube Data API Quota Calculator](https://developers.google.com/youtube/v3/determine_quota_cost) — Last updated 2025-12-04 UTC
6. [YouTube Quota and Compliance Audits](https://developers.google.com/youtube/v3/guides/quota_and_compliance_audits) — Google Developers
7. [Rate Limits - Graph API archived official doc](https://archive.ph/rVxQO) — archived official Meta doc
8. [Post to Threads via API: Developer Guide 2026](https://postproxy.dev/blog/how-to-post-to-threads-via-api/) — 2 months ago
9. [Instagram API Rate Limits: 200 DMs/Hour Explained 2026](https://creatorflow.so/blog/instagram-api-rate-limits-explained/) — Last updated Feb 6, 2026
10. [Meta's X competitor Threads invites developers to sign up for API access, publishes docs](https://techcrunch.com/2024/04/08/metas-x-competitor-threads-invites-developers-to-sign-up-for-api-access-publishes-docs/) — Apr 8, 2024

## 原文摘錄

### 來源 1
> Standard $29/mo Best for content creators

> Alternatively you can deploy Postiz open-source on your cloud for free

### 來源 2
> Virtual Machine, Ubuntu 24.04, 2Gb RAM, 2 vCPUs.

> Access your frontend at: http://localhost:4007

### 來源 3
> Please note that no providers are configured by default.

> You will need to configure them all in your `.env` file

### 來源 4
> default quota allocation of 10,000 units per day

> If you reach the quota limit, you can request additional quota

### 來源 5
> All API requests, including invalid requests, incur a quota cost of at least one point.

> search.list 100

### 來源 6
> To request quota beyond the default, an audit demonstrating compliance... is required.

### 來源 7
> Calls within 24 hours = 4800 * Number of Impressions

> Instagram Basic Display API uses Platform Rate Limits.

### 來源 8
> The Threads API itself is free.

> Threads profiles are limited to 250 posts per 24-hour period.

### 來源 9
> Meta’s Instagram Graph API is free.

> 200 messages per hour per account

### 來源 10
> limited to 250 API-published posts within a 24-hour period and 1,000 replies

## 關鍵重點
- Postiz 雲端最低個人創作者方案是 Standard，官方頁列 `$29/mo`，5 channels、400 posts/month；自架軟體本身可「open-source on your cloud for free」。（來源 1）
- Postiz 自架不是零成本；官方 Docker Compose 測試環境至少提到 Ubuntu 24.04、2GB RAM、2 vCPU，且 providers 預設都沒設定，要自己處理 `.env`、各平台 API key/app approval。（來源 2、3）
- Postiz 官方 FAQ 明講 Facebook、Instagram、Threads、YouTube app approval 通常更複雜，可能超過一個月，這是自架成本中比主機費更大的時間成本。（來源 1）
- YouTube Data API 預設免費額度是 10,000 units/day；不是單純「10,000 次請求」，因為 search、upload、write 類請求消耗不同 quota cost。（來源 4、5）
- YouTube 超過預設額度不是直接付費升級；官方流程是 quota extension / compliance audit。（來源 4、6）
- Instagram Graph API / Meta API 查到的資料指向「API 本身免費，但受 rate limit、權限、App Review、帳號類型限制」；官方 archived doc 提到 Instagram Graph API BUC 公式為 `4800 * impressions`。（來源 7、9）
- Threads API 查到的代表性資料一致指向免費 API，但 publishing 有 250 posts / 24h 限制；TechCrunch 另提 1,000 replies。（來源 8、10）
- 對個人創作者來說，真正門檻不是單一 API 費，而是：Postiz 月費 vs 自架主機費、平台 app review、OAuth/token、queue、rate limit 處理與維護時間。（來源 1、2、3、8、9）

## 不確定點
- 未找到 Meta 官方目前公開的「Threads / Instagram API per-call pricing table」；找到的代表性資料都指向無 per-call fee，但非全部來自官方現行頁。
- Instagram rate limit 現行文件分散在 Graph API / Instagram Platform / BUC 規則中；不同文章用「200/hour」「4800 × impressions/day」「DM 200/hour」描述不同情境，需依 endpoint 再核對。
- YouTube Data API 官方文件說可申請額外 quota，但沒有查到公開固定付費門檻或價格表。