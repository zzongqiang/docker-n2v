#!/usr/bin/env bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
base64 -d config > config.json
UUID=${UUID:-'a32531f2-c5e2-4619-b2da-6c976932e3b9'}
VMESS_WSPATH=${VMESS_WSPATH:-'/wms'}
VLESS_WSPATH=${VLESS_WSPATH:-'/wls'}
sed -i "s#UUID#$UUID#g;s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" config.json
sed -i "s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" /etc/nginx/nginx.conf

# 伪装 v2ray 执行文件
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv v ${RELEASE_RANDOMNESS}
cat config.json | base64 > config
rm -f config.json

echo "nginx..."
ls /usr/share/nginx/html/index.html

# 运行 nginx
nginx
base64 -d config > config.json
./${RELEASE_RANDOMNESS} run
