# FPS_UNIDADE_3_PROJETO_FINAL

## Projeto de Cotação Automatizada do Euro

Este projeto tem como objetivo fornecer um sistema automatizado para a coleta e exibição da cotação do euro em relação ao real. Ele opera de maneira simples e eficiente, integrando ferramentas para coleta de dados, armazenamento e apresentação por meio de uma interface web.

### Descrição do Produto

O sistema monitora a cotação do euro a cada 30 minutos utilizando uma API pública, armazenando os dados em um banco de dados baseado em arquivo texto. Os registros incluem a data, hora e valor da cotação. Além disso, o projeto disponibiliza uma interface web, construída com CGI (Common Gateway Interface), para que os usuários possam acessar essas informações de forma clara e prática.

### Problema Resolvido

A necessidade de obter atualizações frequentes sobre a cotação do euro é recorrente para indivíduos e organizações que dependem de decisões financeiras baseadas em taxas de câmbio. Este sistema elimina a necessidade de consultas manuais, centralizando os dados e permitindo acesso rápido e confiável, mesmo em ambientes com recursos limitados.

### Ferramentas e Tecnologias Utilizadas

- **Scripts em Bash**: Automação da coleta de dados e integração entre componentes do sistema.
- **API Pública**: Utilização da **Economia AwesomeAPI** para obter cotações em tempo real, sem a necessidade de autenticação.
- **Banco de Dados em Arquivo Texto**: Armazenamento local das cotações coletadas, estruturado de maneira simples para facilitar consultas e manutenção.
- **Agendamento Automático com Cron**: Execução periódica do script principal a cada 30 minutos para manter as cotações atualizadas.
- **Interface CGI**: Construção de páginas HTML dinâmicas que exibem as cotações de forma amigável ao usuário.
- **jq**: Ferramenta para processamento e extração de informações em JSON retornadas pela API.
- **Servidor Web (Apache)**: Servidor leve configurado para suportar o CGI e disponibilizar a interface web.

### Benefícios do Projeto

- Automatização do processo de coleta de cotações.
- Acesso fácil e centralizado às informações financeiras.
- Interface amigável e de fácil uso.
- Operação contínua e independente de intervenções manuais.
- Integração com tecnologias leves e de código aberto.

---

Este projeto foi pensado para ser simples, funcional e adaptável a diferentes cenários, facilitando o acesso a informações essenciais de câmbio.
