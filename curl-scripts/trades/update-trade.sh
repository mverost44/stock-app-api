#!/bin/bash

curl "http://localhost:4741/trades/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "trade": {
      "exit_price": "'"${EXIT_PRICE}"'",
      "exit_size": "'"${EXIT_SIZE}"'"
    }
  }'

echo
