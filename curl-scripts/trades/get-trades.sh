#!/bin/bash

curl "http://localhost:4741/trades" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"

echo
