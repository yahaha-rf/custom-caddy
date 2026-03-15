FROM caddy:builder-alpine AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/greenpau/caddy-security \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy