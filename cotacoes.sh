#!/bin/bash

# Caminho do arquivo de banco de dados
DB_FILE="cotacoes.txt"

# URL da API pública
API_URL="https://economia.awesomeapi.com.br/last/EUR-BRL"

# Obter cotação do euro em relação ao real (BRL)
COTACAO=$(curl -s "$API_URL" | jq '.EURBRL.bid' | tr -d '"')

# Adicionar data e cotação ao banco de dados
if [[ -n "$COTACAO" && "$COTACAO" != "null" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'), $COTACAO" >> "$DB_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S'), ERRO: Não foi possível obter a cotação." >> "$DB_FILE"
fi

