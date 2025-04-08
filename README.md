# Primeiro projeto lógico de banco de dados com mysql

# Requisitos

- Instalar MySQL
- Lógica de programação
- Conhecimento de modelo relacional

## Cardinalidades

|            Relação	             |Cardinalidade|
|----------------------------------|-------------|
|Cliente → Endereco                |    1:N      |
|Endereco → Email	                 |    1:N      |
|Email → Pessoa_Fisica / Jurídica  |    1:1      |
|Cliente → Pedido	                 |    1:N      |
|Forma_de_pagamento → Pagamento	   |    1:N      |
|Pagamento → Pedido	               |    1:N      |
|Produto → Movimentacao_Estoque	   |    1:N      |
|Produto → Estoque	               |    1:N      |
|Movimentacao_Estoque → Estoque	   |    1:N      |
|Produto → Recall	                 |    1:N      |
|Cliente → Entrega	               |    1:N      |
|Produto → Relacao_produto_pedido  |	  N:M      |
|Entrega → Relacao_produto_pedido  |	  1:N      |
|Pagamento → Relacao_produto_pedido|    1:N      |
|Produto → Fornecedor	             |    1:N      |
|Produto ⇄ Terceiro_Vendedor	     |    N:M      |
