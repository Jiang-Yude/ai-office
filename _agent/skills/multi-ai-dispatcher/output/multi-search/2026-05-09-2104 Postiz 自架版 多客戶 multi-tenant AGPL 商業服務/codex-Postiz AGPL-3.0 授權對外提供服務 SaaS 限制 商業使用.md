# Postiz AGPL-3.0 授權對外提供服務 SaaS 限制 商業使用：Postiz 自架版 多客戶 multi-tenant AGPL 商業服務

## 來源列表
1. [GitHub - gitroomhq/postiz-app](https://github.com/gitroomhq/postiz-app) — 最新 release 顯示 2026-04-27；查閱 2026-05-09
2. [Postiz Pricing FAQ](https://postiz.com/pricing) — 頁面未標示日期；查閱 2026-05-09
3. [GitHub Issue #975: Multi-Tenant Token Management & External OAuth Integration](https://github.com/gitroomhq/postiz-app/issues/975) — 2025-09-11
4. [GNU Affero General Public License v3.0 - GNU Project](https://www.gnu.org/licenses/agpl-3.0.html.en) — 2007-11-19
5. [Choose a License: GNU Affero General Public License v3.0](https://choosealicense.com/licenses/agpl-3.0/) — 2007-11-19

## 原文摘錄

### 來源 1
> This repository's source code is available under the AGPL-3.0 license.

> At the moment there is no difference between the hosted version to the self-hosted version

### 來源 2
> Alternatively you can deploy Postiz open-source on your cloud for free

### 來源 3
> Closed as not planned

> a single Postiz instance can serve multiple customers, each with their own social media tokens.

> Current Postiz setup requires hard-coded secrets in Docker, which only supports single-tenant usage.

### 來源 4
> Mere interaction with a user through a computer network, with no transfer of a copy, is not conveying.

> public use of a modified version, on a publicly accessible server, gives the public access to the source code

### 來源 5
> Commercial use

> Network use is distribution

> Same license

## 關鍵重點
- Postiz 主 repo 明確標示 AGPL-3.0；這是本題授權判斷的直接來源。（對應來源 1）
- Postiz 官方頁面明確說可以把 open-source Postiz 部署到自己的 cloud；但該 FAQ 沒有直接說「可否包成對外 SaaS 服務轉售」。（對應來源 2）
- 多客戶 / multi-tenant 需求在官方 GitHub issue 中有使用者提出，而且 issue 目前顯示「Closed as not planned」。（對應來源 3）
- 該 issue 的描述指出，提出者認為目前 setup「only supports single-tenant usage」，這是 multi-tenant 商業服務可行性上的產品限制線索，不是授權條款本身。（對應來源 3）
- AGPL 原文重點是：若你修改程式並讓遠端網路使用者互動，需提供該修改版本的 Corresponding Source；商業使用本身不是被禁止項。（對應來源 4、5）

## 不確定點
- 無資料：我沒有找到 Postiz 官方針對「自架版包成多客戶 SaaS 商業服務」的專門授權 FAQ 或白皮書。
- 無資料：我沒有找到 Postiz 官方明文禁止「商業使用」或「對外提供服務」的條款。
- 需要法律確認：AGPL 對「修改版、整合、外掛、私有後端、前端包裝、多租戶 SaaS」的源碼揭露範圍，不能只靠一般搜尋結論判定。