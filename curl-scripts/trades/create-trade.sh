#!/bin/bash

curl "http://localhost:4741/trades" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "trade": {
      "ticker_symbol": "'"${SYMBOL}"'",
      "entry_price": "'"${ENTRY_PRICE}"'",
      "entry_size": "'"${ENTRY_SIZE}"'"
    }
  }'

echo
