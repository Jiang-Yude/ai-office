# 各平台官方API能力盤點 Threads IG Reels YouTube Shorts TikTok 發文排程留言數據：個人創作者多平台社群中控台 自用級 跨平台發文 留言收集 數據分析

## 來源列表
1. [Meta's social networking service 'Threads' now has an API that allows third-party app development](https://gigazine.net/gsc_news/en/20240619-meta-threads-api/) — 2024-06-19
2. [Get Post Insights | Threads API | Postman API Network](https://www.postman.com/meta/threads/request/ndeeu6p/get-post-insights) — crawled 2025-07 左右
3. [1.1 Create Text Container | Threads API | Postman API Network](https://www.postman.com/meta/threads/request/34203612-5c006612-638f-4044-8143-054a1dea5133) — crawled 2026-04
4. [Meta introduces Instagram Reels APIs for developers](https://techcrunch.com/2022/06/27/meta-instagram-reels-apis-developers/) — 2022-06-27
5. [Publish Content - Instagram Platform - Meta for Developers bookmark mirror](https://b.hatena.ne.jp/entry/s/developers.facebook.com/docs/instagram-platform/content-publishing/) — crawled 2026-03
6. [View insights on your Instagram reels](https://www.facebook.com/help/instagram/202865988324236?locale=en_GB) — crawled 2025-11
7. [Videos: insert | YouTube Data API](https://developers.google.com/youtube/v3/docs/videos/insert?hl=ja) — last updated 2024-11-11 UTC
8. [Videos | YouTube Data API](https://developers.google.com/youtube/v3/docs/videos) — last updated 2025-12 左右 / crawled 2026-01
9. [CommentThreads: list | YouTube Data API](https://developers.google.com/youtube/v3/docs/commentThreads/list) — last updated 2025-08-28 UTC
10. [Metrics | YouTube Analytics API](https://developers.google.com/youtube/analytics/metrics) — crawled 2026-01
11. [TikTok Content Posting API - Direct Post](https://developers.tiktok.com/doc/content-posting-api-reference-direct-post) — crawled 2026-05-08
12. [TikTok Display API Overview](https://developers.tiktok.com/doc/display-api-overview/) — crawled 2026-05-08
13. [TikTok Research API Codebook](https://developers.tiktok.com/doc/research-api-codebook) — crawled 2026-05-08
14. [TikTok Research API FAQ](https://developers.tiktok.com/doc/research-api-faq) — crawled 2026-04

## 原文摘錄

### 來源 1
> publishing posts, getting content, using reply management functions

### 來源 2
> Use the `GET` /{threads-media-id}/insights endpoint

### 來源 3
> Use the `POST` /{threads-user-id}/threads endpoint

### 來源 4
> content publishing, insights, comment moderation, hashtag search, business discovery, mentions and more

### 來源 5
> publish single images, videos, reels

### 來源 6
> follows, likes, comments, saves and shares

### 來源 7
> Uploads a video to YouTube and optionally sets the video's metadata.

### 來源 8
> `status.publishAt` | `datetime`

### 來源 9
> Returns a list of comment threads

### 來源 10
> `comments`, `dislikes`, `engagedViews`, `likes`, `shares`

### 來源 11
> directly post a video to users' TikTok accounts

### 來源 12
> display a TikTok creator's videos and their profile information

### 來源 13
> A comment OR a reply to a comment posted for a public video

### 來源 14
> creators, advertisers, or commercial user. Am I eligible... No.

## 關鍵重點（你的整理說明）
- Threads：官方 API 已支援發文、讀取內容、回覆管理與 insights；Postman 的 Meta Threads collection 顯示可用 `/threads` 建 container、`/{threads-media-id}/insights` 讀 views/likes/replies/reposts/quotes/shares。（來源 1, 2, 3）
- IG Reels：Meta 曾宣布 Reels API 覆蓋 content publishing、insights、comment moderation；Meta content publishing 文件 mirror 顯示支援 publishing reels。（來源 4, 5）
- IG Reels 數據：Instagram Help 明列 Reels insights 可見 follows、likes、comments、saves、shares、views、watch time 等，但這是產品/Help Center 說明，不等於逐項確認 Graph API 欄位。（來源 6）
- YouTube Shorts：找到的是 YouTube Data API 的一般影片上傳能力，`videos.insert` 可上傳影片；Shorts 沒看到獨立「Shorts-only upload API」來源，應視為影片上傳後由 YouTube 判定短影音格式。（來源 7）
- YouTube 排程：`status.publishAt` 存在於 video resource，且只能在影片為 private 時設定；這可支援排程發布。（來源 8）
- YouTube 留言：`commentThreads.list` 可取影片留言討論串，`comments.insert` 可回覆留言；Analytics API 有 comments、likes、shares、views 等 metrics。（來源 9, 10）
- TikTok 發文：Content Posting API Direct Post 可直接發布影片，但未審核 client 發布內容會限制為 private viewing mode；也有每日/速率限制錯誤碼。（來源 11）
- TikTok 數據：Display API 主要是顯示創作者 profile 與影片 metadata；Research API 有公開影片的 comments、like_count、reply_count、view_count 等，但 Research API 明確不是給 creator/commercial user。（來源 12, 13, 14）

## 不確定點
- TikTok：本輪未找到官方「一般創作者/商業 app 可讀取自己影片逐則留言、回覆留言、做創作者後台數據分析」的 API；找到的是 Display API 與 Research API，但 Research API 不適用創作者/商業用戶。（來源 12, 13, 14）
- IG Reels 排程：2022 報導寫「schedule Reels」，但本輪未能直接打開 Meta 官方原頁確認最新版 scheduling 參數；需要再以 Meta 官方文件頁逐條核對。（來源 4, 5）
- Threads 排程：找到官方/準官方資料可發文與讀 insights，但未找到 Threads 官方 `scheduled_publish_time` 類排程欄位來源。