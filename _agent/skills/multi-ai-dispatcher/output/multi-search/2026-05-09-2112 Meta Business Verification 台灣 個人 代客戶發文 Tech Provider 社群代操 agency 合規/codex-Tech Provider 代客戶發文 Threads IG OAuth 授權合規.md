# Tech Provider 代客戶發文 Threads IG OAuth 授權合規：Meta Business Verification 台灣 個人 代客戶發文 Tech Provider 社群代操 agency 合規

## 來源列表
1. [Threads API docs mirror — Context7 / official source: developers.facebook.com/docs/threads](https://context7.com/websites/developers_facebook_threads/llms.txt?tokens=10000) — 2026-05-09 mirror update
2. [Instagram Platform docs mirror — Context7 / official source: developers.facebook.com/docs/instagram-platform](https://context7.com/websites/developers_facebook_instagram-platform/llms.txt?tokens=10000) — 2026-04 左右 mirror update
3. [Instagram — Outstand Docs](https://www.outstand.so/docs/configurations/instagram) — crawled 2026-05-08
4. [What is a Meta Tech Provider? — Inrō](https://www.inro.social/blog/what-is-a-meta-tech-provider) — Last updated January 14, 2026
5. [Standard Business Verification — 360dialog](https://docs.360dialog.com/docs/resources/meta-business-verification/standard-business-verification) — crawled 2026-04
6. [Verify Your Business on Meta — Gupshup Docs](https://docs.gupshup.io/docs/verify-your-business-on-meta) — updated 5 months ago
7. [Get authorized to post or interact as your Page — Facebook Help Center](https://www.facebook.com/help/1939753742723975/) — date not shown
8. [Meta Verified for Business Terms — Facebook Legal](https://www.facebook.com/legal/mvb_terms) — last updated March 31, 2025

## 原文摘錄
### 來源 1
> `scope=threads_basic,threads_content_publish`

> `POST /{threads-user-id}/threads_publish`

### 來源 2
> `instagram_business_content_publish`

> `Send a GET request to the /me endpoint`

### 來源 3
> “Personal Instagram accounts cannot be used with the Graph API”

> “Instagram publishing requires App Review approval from Meta”

### 來源 4
> “Inrō has completed Meta’s Access Verification for Tech Providers.”

> “You connect your Instagram account through Meta’s official pop-up (OAuth)”

### 來源 5
> “Partners, Tech Providers, and ISVs are not permitted to upload documents on the Business’s behalf.”

### 來源 6
> “Not every business needs to go through business verification.”

> “You only need to verify your business if you want to access certain Meta technologies or developer features.”

### 來源 7
> “Facebook is requiring people who manage high potential reach Pages to get authorized to publish as their Page.”

### 來源 8
> “You may be asked to input or confirm the business contact information associated with the selected Business Asset(s).”

## 關鍵重點
- Threads 代發文需要 OAuth scope `threads_basic,threads_content_publish`，並透過 Threads publish endpoint 發文。（來源 1）
- Instagram 發文權限核心是 `instagram_business_content_publish`；個人帳號不能用 Graph API 發文，要 Business 或 Creator 類型。（來源 2、3）
- IG 發文不是單純拿 token 就能公開提供服務，第三方工具文件明示 publishing 需要 Meta App Review。（來源 3）
- Tech Provider 角度的合規敘事集中在：Access Verification、官方 OAuth、不收密碼、只拿使用者授權 scope。（來源 4）
- Business Verification 文件上傳必須由該 Business 的授權代表處理，Tech Provider / agency 不能代替客戶上傳文件。（來源 5）
- Business Verification 不是每個情境都必須，但若要用特定 Meta developer features / technologies，可能會被要求。（來源 6）
- Page 發文另有「高觸及 Page 管理者需授權」規則；若有 System User，Meta Help Center 提到需驗證 Business Manager accounts。（來源 7）
- Meta Verified for Business 條款提到可能要求 business contact information、business documents、government ID、bank verification 或 domain verification。（來源 8）

## 不確定點
- 無資料：未找到 Meta 官方明確寫「台灣個人可否以個人身份完成 Tech Provider / Access Verification 並代客戶發 Threads/IG」的公開條文。
- 無資料：未找到 Meta 官方針對「台灣社群代操 agency 代客戶發文」的專門合規指南。
- 無資料：未找到官方明確說「個人工作室／未設立公司」能否通過 Business Verification 作為 Tech Provider 的台灣適用規則。
- 代表性第三方工具多用「Business-Verified / Access-Verified Tech Provider + OAuth」作為合規表述，但這是廠商自述，不等於 Meta 對所有 agency 情境的保證。