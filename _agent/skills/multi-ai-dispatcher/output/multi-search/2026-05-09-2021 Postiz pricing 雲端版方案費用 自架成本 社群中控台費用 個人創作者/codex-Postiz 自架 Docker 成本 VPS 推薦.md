# Postiz 自架 Docker 成本 VPS 推薦：Postiz pricing 雲端版方案費用 自架成本 社群中控台費用 個人創作者

## 來源列表
1. [Pricing - Postiz](https://postiz.com/pricing) — 未標示頁面日期，檢索 2026-05-09
2. [Docker Compose - Postiz Documentation](https://docs.postiz.com/installation/docker-compose) — 未標示頁面日期，檢索 2026-05-09
3. [How it works - Postiz Documentation](https://docs.postiz.com/howitworks) — 未標示頁面日期，檢索 2026-05-09
4. [gitroomhq/postiz-app - GitHub](https://github.com/gitroomhq/postiz-app) — 最新 release 顯示 2026-04-27
5. [Hetzner Pricing Breakdown 2026 - Deploy Handbook](https://deployhandbook.com/pricing/hetzner) — Updated 2026-05-06
6. [Droplet Pricing - DigitalOcean](https://www.digitalocean.com/pricing/droplets) — pricing note effective 2026-01-01
7. [Docker CE - Hetzner Docs](https://docs.hetzner.com/cloud/apps/list/docker-ce/) — Last change 2024-11-06
8. [Important Update Postiz v2.12.0 - Reddit r/selfhosted](https://www.reddit.com/r/selfhosted/comments/1qciwak/important_update_postiz_v2120_open_source_social/) — 2026-01-14
9. [Postiz Self-Hosted - All working, but API access does not - Reddit r/selfhosted](https://www.reddit.com/r/selfhosted/comments/1t3c56l/postiz_selfhosted_all_working_but_api_access_does/) — 2026-05-04

## 原文摘錄

### 來源 1
> Postiz has a 7-days free trial. Alternatively you can deploy Postiz open-source on your cloud for free

### 來源 2
> Virtual Machine, Ubuntu 24.04, 2Gb RAM, 2 vCPUs.

### 來源 3
> SQL Database, Redis, Temporal and Storage.

### 來源 4
> At the moment there is no difference between the hosted version to the self-hosted version

### 來源 5
> CX22 2 4 GB 40 GB $4.35/mo

### 來源 6
> 2 GiB 2 vCPUs 3,000 GiB 60 GiB $18.00

### 來源 7
> Docker is preinstalled when the image is booted.

### 來源 8
> If you use Postiz and upgrade from an older version, it will crash.  
> We have updated our docker-compose docs to the new one.  
> If you want to stay with the legacy BullMQ version, don't upgrade after v2.11.3.

### 來源 9
> I have self-hosted Postiz on my server at home via Docker. I have it published to the Internet via NGINX Proxy Manager. All is working so far: I can register, login, connect channels, all good. But I cannot access the API.

## 關鍵重點
- Postiz 官方明確提供雲端試用與 open-source 自架選項；自架本身未標示 Postiz 授權費，但仍需要自備雲端/VPS 資源。（對應來源 1：https://postiz.com/pricing）
- 官方 Docker Compose 文件的已測試規格是 Ubuntu 24.04、2GB RAM、2 vCPU；這是目前找到最接近「最低可跑」的官方依據。（對應來源 2：https://docs.postiz.com/installation/docker-compose）
- 自架不是單一容器成本，Postiz 架構含 SQL Database、Redis、Temporal、Storage；VPS 選型要把這些服務一起算進資源。（對應來源 3：https://docs.postiz.com/howitworks）
- GitHub README 表示 hosted 與 self-hosted 版本目前「沒有差異」，所以個人創作者若能承擔部署維護，自架可避開 Postiz 雲端月費。（對應來源 4：https://github.com/gitroomhq/postiz-app）
- Hetzner CX22 這類 2 vCPU / 4GB RAM VPS 的第三方近期價格整理為 $4.35/mo，比官方最低測試規格多 2GB RAM；但此為第三方價格頁，不是 Postiz 官方推薦。（對應來源 5：https://deployhandbook.com/pricing/hetzner）
- DigitalOcean 官方同級 2GB RAM / 2 vCPU Droplet 為 $18/mo；若升到 4GB RAM / 2 vCPU，來源頁列為 $24/mo。（對應來源 6：https://www.digitalocean.com/pricing/droplets）
- Hetzner 有 Docker CE One-Click App，可降低 VPS 初始 Docker 安裝成本，但仍需自行部署 Postiz compose、網域、反代、備份。（對應來源 7：https://docs.hetzner.com/cloud/apps/list/docker-ce/）
- 2026-01 Postiz v2.12.0 後導入 Temporal，舊版升級有 crash 風險；新自架應優先使用最新 Docker Compose 文件，不宜沿用舊 compose。（對應來源 8：https://www.reddit.com/r/selfhosted/comments/1qciwak/important_update_postiz_v2120_open_source_social/）
- 近期 Reddit 使用者仍回報 Docker + NGINX Proxy Manager 下 API / 反代設定問題；自架成本不只 VPS 月費，還包含反代與環境變數排錯時間。（對應來源 9：https://www.reddit.com/r/selfhosted/comments/1t3c56l/postiz_selfhosted_all_working_but_api_access_does/）

## 不確定點
- 無資料：未找到 Postiz 官方明確列出「推薦 VPS 商」或「個人創作者最佳 VPS 方案」。
- 無資料：未找到 Postiz 官方列出完整每月自架總成本；官方只說可部署 open-source 到自己的 cloud。
- 不確定：Hetzner $4.35/mo 來自第三方 2026 價格整理，不是 Hetzner 官方可靜態引用的完整價目表。
- 不確定：Reddit 回報多為個案，能證明常見問題方向，但不能當成普遍失敗率。