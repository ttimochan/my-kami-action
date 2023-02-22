# Rebuild the source code only when needed
FROM node:19-alpine 

RUN apk add --no-cache libc6-compat git
RUN npm i -g pnpm pm2
WORKDIR /app
RUN git clone https://github.com/mx-space/kami.git --depth 1 .
ENV BASE_URL=https://api.timochan.cn
ENV NEXT_PUBLIC_API_URL=${BASE_URL}/apc
ENV NEXT_PUBLIC_GATEWAY_URL=${BASE_URL}
RUN node -e "console.log(process.env)"
RUN pnpm install
RUN npm run build

EXPOSE 2323

ENV PORT 2323

CMD echo "Mix Space Web [Kami] Image." && sh