DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL
);

-- Tabela Endereço
CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY,
    Endereco1 VARCHAR(45),
    Endereco2 VARCHAR(45),
    Valor_frete FLOAT,
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Email
CREATE TABLE Email (
    idEmail INT PRIMARY KEY,
    email1 VARCHAR(45),
    email2 VARCHAR(45),
    Endereco_idEndereco INT,
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);

-- Tabela Pessoa Física
CREATE TABLE Pessoa_Fisica (
    idPessoa_Fisica INT PRIMARY KEY,
    Nome VARCHAR(100),
    CPF CHAR(11),
    Contato VARCHAR(45),
    email_idEmail INT,
    FOREIGN KEY (email_idEmail) REFERENCES Email(idEmail)
);

-- Tabela Pessoa Jurídica
CREATE TABLE Pessoa_Juridica (
    idPessoa_Juridica INT PRIMARY KEY,
    Nome VARCHAR(100),
    CNPJ CHAR(14),
    Contato VARCHAR(45),
    email_idEmail INT,
    FOREIGN KEY (email_idEmail) REFERENCES Email(idEmail)
);

-- Tabela Forma de Pagamento
CREATE TABLE Forma_de_pagamento (
    idForma_de_pagamento INT PRIMARY KEY,
    forma_pagamento_credito FLOAT,
    forma_pagamento_debito FLOAT,
    forma_pagamento_boleto FLOAT
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    idstatus_pagamento INT PRIMARY KEY,
    Forma_de_pagamento_idForma_de_pagamento INT,
    total_pago FLOAT,
    FOREIGN KEY (Forma_de_pagamento_idForma_de_pagamento) REFERENCES Forma_de_pagamento(idForma_de_pagamento)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    Cliente_idCliente INT,
    status_pedido ENUM('ativo', 'entregue', 'cancelado'),
    Pagamento_idstatus_pagamento INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Pagamento_idstatus_pagamento) REFERENCES Pagamento(idstatus_pagamento)
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    Descricao VARCHAR(200),
    Nome VARCHAR(45),
    Preco FLOAT,
    Categoria VARCHAR(45)
);

-- Tabela Movimentação de Estoque
CREATE TABLE Movimentacao_Estoque (
    idMovimentacao_Estoque INT PRIMARY KEY,
    idMovimentacao VARCHAR(45),
    Produto_idProduto INT,
    tipo_movimentacao ENUM('entrada', 'saida'),
    quantidade INT,
    data_movimentacao DATE,
    referencia VARCHAR(45),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    Produto_idProduto INT,
    Movimentacao_Estoque_idMovimentacao_Estoque INT,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Movimentacao_Estoque_idMovimentacao_Estoque) REFERENCES Movimentacao_Estoque(idMovimentacao_Estoque)
);

-- Tabela Recall
CREATE TABLE Recall (
    idRecall INT PRIMARY KEY,
    periodo_devolucao VARCHAR(45),
    Produto_idProduto INT,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    codigo_rastreio CHAR(30),
    status_entrega ENUM('ativo', 'entregue', 'cancelado'),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Relacao Produto/Pedido
CREATE TABLE Relacao_produto_pedido (
    idRelacao_produto_pedido INT PRIMARY KEY,
    Quantidade_de_produtos_por_pedido INT,
    Pagamento_idstatus_pagamento INT,
    Produto_idProduto INT,
    Entrega_idEntrega INT,
    FOREIGN KEY (Pagamento_idstatus_pagamento) REFERENCES Pagamento(idstatus_pagamento),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Entrega_idEntrega) REFERENCES Entrega(idEntrega)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    Produto_idProduto INT,
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Terceiro Vendedor
CREATE TABLE Terceiro_Vendedor (
    idTerceiro_Vendedor INT PRIMARY KEY
);

-- Tabela Produto_Terceiro_Vendedor
CREATE TABLE Produto_Terceiro_Vendedor (
    Produto_idProduto INT,
    Terceiro_Vendedor_idTerceiro_Vendedor INT,
    PRIMARY KEY (Produto_idProduto, Terceiro_Vendedor_idTerceiro_Vendedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Terceiro_Vendedor_idTerceiro_Vendedor) REFERENCES Terceiro_Vendedor(idTerceiro_Vendedor)
);

-- ------------------------------------
-- INSERÇÕES
-- ------------------------------------

INSERT INTO Cliente VALUES (1, 'PF');
INSERT INTO Cliente VALUES (2, 'PJ');

INSERT INTO Endereco VALUES (1, 'Rua A, 123', NULL, 10.00, 1);
INSERT INTO Endereco VALUES (2, 'Av. B, 456', NULL, 20.00, 2);

INSERT INTO Email VALUES (1, 'joao@email.com', NULL, 1);
INSERT INTO Email VALUES (2, 'contato@xyz.com', NULL, 2);

INSERT INTO Pessoa_Fisica VALUES (1, 'João Silva', '12345678900', '11999999999', 1);
INSERT INTO Pessoa_Juridica VALUES (1, 'Empresa XYZ', '11222333444455', '21988887777', 2);

INSERT INTO Forma_de_pagamento VALUES (1, 0.0, 0.0, 0.0);
INSERT INTO Forma_de_pagamento VALUES (2, 0.0, 0.0, 0.0);

INSERT INTO Pagamento VALUES (1, 1, 99.90);

INSERT INTO Pedido VALUES (1, 1, 'ativo', 1);

INSERT INTO Produto VALUES (1, 'Camiseta branca, tamanho M', 'Camiseta', 49.90, 'Vestuário');
INSERT INTO Produto VALUES (2, 'Tênis preto, tamanho 42', 'Tênis', 89.90, 'Calçados');

INSERT INTO Movimentacao_Estoque VALUES (1, 'M001', 1, 'entrada', 10, '2024-01-01', 'ENTRADA1');
INSERT INTO Movimentacao_Estoque VALUES (2, 'M002', 2, 'entrada', 5, '2024-01-02', 'ENTRADA2');

INSERT INTO Estoque VALUES (1, 1, 1);
INSERT INTO Estoque VALUES (2, 2, 2);

INSERT INTO Recall VALUES (1, '2025-04', 1);

INSERT INTO Entrega VALUES (1, 'ABC123', 'ativo', 1);

INSERT INTO Relacao_produto_pedido VALUES (1, 2, 1, 1, 1);

INSERT INTO Fornecedor VALUES (1, 1);

INSERT INTO Terceiro_Vendedor VALUES (1);
INSERT INTO Produto_Terceiro_Vendedor VALUES (1, 1);
