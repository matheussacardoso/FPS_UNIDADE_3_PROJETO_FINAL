#!/bin/bash

# Captura as variáveis de ambiente e escreve no arquivo de log
echo "Environment variables:" > /var/www/data/env.log
printenv >> /var/www/data/env.log

LOG_FILE="/var/www/data/script_debug.log"

# Caminho do arquivo de banco de dados
DB_FILE="/var/www/data/cotacoes.txt"

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

# Cabeçalhos para o conteúdo HTML
echo "Content-type: text/html"
echo ""
echo "<!DOCTYPE html>"
echo "<html lang='pt-br'>"
echo "<head>"
echo "  <meta charset='UTF-8'>"
echo "  <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
echo "  <title>Cotações de Moedas</title>"
echo "  <style>"
echo "    body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; }"
echo "    table { width: 50%; margin: 20px auto; border-collapse: collapse; }"
echo "    th, td { padding: 10px; border: 1px solid #ddd; }"
echo "    th { background-color: #006443; color: white; }"
echo "    tr:nth-child(even) { background-color: #f2f2f2; }"
echo "    h1 { color: #006443; }"
echo "  </style>"
echo "</head>"
echo "<body>"
echo "  <h1>Cotações de Moedas</h1>"
echo "  <table>"
echo "    <tr><th>Data e Hora</th><th>Cotação EUR/BRL</th></tr>"

# Adicionar as cotações do arquivo de banco de dados
while IFS=, read -r data cotacao; do
    echo "    <tr><td>$data</td><td>$cotacao</td></tr>"
done < "$DB_FILE"

# Finalizar a tabela e o HTML
echo "  </table>"
echo "</body>"
echo "</html>"
