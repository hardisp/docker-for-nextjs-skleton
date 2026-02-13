# 🧱 Next.js Skeleton Project (Home Server + Cloudflare Tunnel)

Reusable production-ready Next.js skeleton untuk:

* Development dengan Docker (hot reload)
* Production deployment ke home server
* Reverse proxy via Nginx Proxy Manager
* Online via Cloudflare Tunnel
* Single docker-compose (profiles)
* Makefile command wrapper

## 📦 Project Structure

```lua
skeleton-project/
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── nextjs/
│   ├── app/
│   ├── public/
│   ├── next.config.ts
│   └── package.json
│
├── .env
├── Makefile
└── README.md
```

## 🏗 Architecture Overview

```lua
Internet
   ↓
Cloudflare
   ↓
Cloudflare Tunnel (CLI)
   ↓
Nginx Proxy Manager (proxy-net)
   ↓
NextJS container (proxy-net)
```

Notes:

- Tidak perlu buka port router
- Tunnel forward ke NPM
- NPM route ke container
- Semua container di proxy-net

## ⚙️ Requirements

- Docker
- Docker Compose v2
- Existing docker network: proxy-net
- Nginx Proxy Manager running
- Cloudflare Tunnel already configured
  
Jika network belum ada:

```sh
docker network create proxy-net
```

## Jika ingin Nextjs Fresh

jalankan ini di main path (setara docker);

```sh
npx create-next-app@latest nextjs --typescript --eslint --app
```

## 🚀 Available Commands

Semua command dibungkus di Makefile.

Lihat semua command:

```sh
make help
```

## 🔹 Development Mode

Menjalankan Next.js dengan hot reload.

```sh
make dev
```

Akses:

```sh
http://localhost:3000
```

Mode ini:

- Menggunakan bind mount
- Tidak digunakan untuk production

## 🔹 Production Mode

Build dan jalankan production container.

```sh
make build
make prod
```

Atau langsung:

```
make restart
```

Container akan:

- Build dengan standalone output
- Tidak menggunakan volume
- Immutable artifact

## 🔹 Stop Container

```sh
make down
```

## 🔹 Logs

```sh
make logs
```

## 🔹 Clean (Hati-hati)

Menghapus container dan volume.

```sh
make clean
```

## 🧠 Deployment Workflow (Home Server)

1. Masuk ke project folder
2. Pull latest code (jika pakai git)
3. Deploy:

```sh
git pull
make restart
```

Selesai.

Tidak perlu sentuh NPM atau Tunnel.

## 🛠 Development vs Production

| Feature             | Dev | Prod |
| ------------------- | --- | ---- |
| Hot reload          | ✅   | ❌    |
| Volume mount        | ✅   | ❌    |
| Standalone build    | ❌   | ✅    |
| Immutable container | ❌   | ✅    |


## Rule:

Development boleh fleksibel. Production harus immutable.

## 📦 Reusing Skeleton for New Project

```sh
cp -r skeleton-project my-new-app
cd my-new-app/nextjs
```

Edit isi app sesuai kebutuhan.

Semua infra tetap sama.

## 🧩 Troubleshooting

### Container tidak bisa diakses dari NPM

Cek network:

```sh
docker network inspect proxy-net
```

Pastikan container ada di network tersebut.

### Tunnel online tapi tidak bisa akses domain

Cek:

```sh
cloudflared tunnel info <tunnel-name>
```

Pastikan public hostname forward ke NPM.

### Port 3000 conflict

Pastikan tidak ada service lain pakai port 3000 saat dev.
