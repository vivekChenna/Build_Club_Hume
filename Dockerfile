FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./

RUN pnpm install

COPY . .

RUN pnpm run build


FROM node:18-alpine AS runner
WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

CMD [ "pnpm", "run","dev" ]