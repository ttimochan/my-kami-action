# Rebuild the source code only when needed
FROM node:18-alpine 

RUN apk add libc6-compat git && \
    npm i -g pnpm pm2
    
WORKDIR /app
RUN git clone https://git.timochan.cn/ttimochan/kami.git --depth 1 .
ENV BASE_URL=https://api.timochan.cn
ENV NEXT_PUBLIC_API_URL=${BASE_URL}/apc
ENV NEXT_PUBLIC_GATEWAY_URL=${BASE_URL}
RUN node -e "console.log(process.env)" && \
    pnpm install && \
    npm run build

EXPOSE 2323

ENV PORT 2323

CMD echo "Mix Space Web [Kami] Image." && sh