# ---------- Base ----------
FROM node:20-alpine AS base
WORKDIR /app

# ---------- Dependencies ----------
FROM base AS deps
COPY ../nextjs/package.json ../nextjs/package-lock.json* ./
RUN npm install

# ---------- Builder ----------
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY ../nextjs .
RUN npm run build

# ---------- Runner ----------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

RUN addgroup -g 1001 nodejs
RUN adduser -S nextjs -u 1001

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

USER nextjs

EXPOSE 3000

CMD ["node", "server.js"]
