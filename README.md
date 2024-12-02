# FPS_UNIDADE_3_PROJETO_FINAL

Componentes da Equipe
- Matheus Sá
- Joseph Neiva
- Daniel Telles
- Victor Lima

## Projeto de Cotação Automatizada do Euro

Este projeto tem como objetivo fornecer um sistema automatizado para a coleta e exibição da cotação do euro em relação ao real. Ele opera de maneira simples e eficiente, integrando ferramentas para coleta de dados, armazenamento e apresentação por meio de uma interface web.

Descrição do Produto

O sistema monitora a cotação do euro a cada 30 minutos utilizando uma API pública, armazenando os dados em um banco de dados baseado em arquivo texto. Os registros incluem a data, hora e valor da cotação. Além disso, o projeto disponibiliza uma interface web, construída com CGI (Common Gateway Interface), para que os usuários possam acessar essas informações de forma clara e prática.

Problema Resolvido

A necessidade de obter atualizações frequentes sobre a cotação do euro é recorrente para indivíduos e organizações que dependem de decisões financeiras baseadas em taxas de câmbio. Este sistema elimina a necessidade de consultas manuais, centralizando os dados e permitindo acesso rápido e confiável, mesmo em ambientes com recursos limitados.

Ferramentas e Tecnologias Utilizadas

- **Scripts em Bash**: Automação da coleta de dados e integração entre componentes do sistema.
- **API Pública**: Utilização da **Economia AwesomeAPI** para obter cotações em tempo real, sem a necessidade de autenticação.
- **Banco de Dados em Arquivo Texto**: Armazenamento local das cotações coletadas, estruturado de maneira simples para facilitar consultas e manutenção.
- **Agendamento Automático com Cron**: Execução periódica do script principal a cada 30 minutos para manter as cotações atualizadas.
- **Interface CGI**: Construção de páginas HTML dinâmicas que exibem as cotações de forma amigável ao usuário.
- **jq**: Ferramenta para processamento e extração de informações em JSON retornadas pela API.
- **Servidor Web (Apache)**: Servidor leve configurado para suportar o CGI e disponibilizar a interface web.

Benefícios do Projeto

- Automatização do processo de coleta de cotações.
- Acesso fácil e centralizado às informações financeiras.
- Interface amigável e de fácil uso.
- Operação contínua e independente de intervenções manuais.
- Integração com tecnologias leves e de código aberto.

---

Este projeto foi pensado para ser simples, funcional e adaptável a diferentes cenários, facilitando o acesso a informações essenciais de câmbio.

---

## Estrutura do Projeto

- `/usr/lib/cgi-bin/cotacoes.sh`: Script Bash que coleta cotações, gera a página HTML e gerencia os dados.
- `/var/www/data/cotacoes.txt`: Banco de dados simples armazenando as cotações coletadas.
- `/var/www/data/env.log`: Log contendo as variáveis de ambiente do cron para fins de depuração.
- `/var/www/data/script_debug.log`: Log adicional para depuração.
- Página HTML gerada dinamicamente como saída do script.

---

## Guia de configuração e instalação do projeto

## Requisitos

- **Dependências**:
  - `curl`: Para realizar requisições HTTP.
  - `jq`: Para manipular dados JSON.
- **Servidor Apache** com suporte a scripts CGI.

### Instalar as dependências:

```bash
sudo apt update
sudo apt install curl jq apache2
```

Ative o módulo CGI no Apache:

```bash
sudo a2enmod cgi
sudo systemctl restart apache2
```

---

## Configuração

### Diretórios e Permissões

1. **Crie o diretório de dados:**

   ```bash
   sudo mkdir -p /var/www/data
   ```

2. **Defina as permissões adequadas:**

   ```bash
   sudo chown www-data:www-data /var/www/data
   sudo chmod 775 /var/www/data
   ```

3. **Configure o arquivo de banco de dados:**

   ```bash
   sudo touch /var/www/data/cotacoes.txt
   sudo chown www-data:www-data /var/www/data/cotacoes.txt
   sudo chmod 664 /var/www/data/cotacoes.txt
   ```

4. **Adicione o script no diretório CGI:**

   ```bash
   sudo mv cotacoes.sh /usr/lib/cgi-bin/
   sudo chown www-data:www-data /usr/lib/cgi-bin/cotacoes.sh
   sudo chmod 755 /usr/lib/cgi-bin/cotacoes.sh
   ```

---

## Funcionamento do Script

### Fluxo de Operação

1. Captura as variáveis de ambiente para depuração (`env.log`).
2. Consulta a API pública para obter a cotação do Euro (EUR) em relação ao Real (BRL).
3. Salva os resultados em um arquivo de texto com registro da data e hora.
4. Gera uma página HTML com as informações em formato de tabela.

### Exemplo de Saída HTML

```html
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cotações de Moedas</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; color: #333; text-align: center; }
        table { width: 50%; margin: 20px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; }
        th { background-color: #006443; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        h1 { color: #006443; }
    </style>
</head>
<body>
    <h1>Cotações de Moedas</h1>
    <table>
        <tr><th>Data e Hora</th><th>Cotação EUR/BRL</th></tr>
        <tr><td>2024-12-01 10:00:00</td><td>5.23</td></tr>
    </table>
</body>
</html>
```

---

## Automação com Cron

### Esta seção descreve o processo de agendamento automático de um script para execução periódica a cada 30 minutos usando o cron. 

1. **Edite o arquivo crontab do usuário:**

   ```bash
   crontab -e
   ```

2. **Adicione a seguinte linha para executar o script a cada 30 minutos:**

   ```bash
   */30 * * * * /usr/lib/cgi-bin/cotacoes.sh
   ```

3. **Verifique os logs do cron:**

   ```bash
   grep CRON /var/log/syslog
   ```

---

## Solução de Problemas

- **Erro de permissão**: Verifique as permissões dos arquivos e diretórios.
- **Erro no cron**: Capture as variáveis de ambiente em `env.log` e valide.
- **Erro na API**: Verifique a conectividade com a API usando `curl`.

---

## Como Testar

1. **Execute o script manualmente:**

   ```bash
   /usr/lib/cgi-bin/cotacoes.sh
   ```

2. **Verifique o arquivo de cotações:**

   ```bash
   cat /var/www/data/cotacoes.txt
   ```

3. **Acesse o HTML no navegador:**

   ```bash
   http://localhost/cgi-bin/cotacoes.sh
   ```

---
