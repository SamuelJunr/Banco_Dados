-- Criando banco de dados

DROP DATABASE  ecommerce_2;
CREATE DATABASE ecommerce_2;
USE ecommerce_2;

-- Criando tabelas --

-- Clientes

CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  primeiro_nome VARCHAR(45) NOT NULL,
  nome_meio CHAR(3) NOT NULL,
  ultimo_nome VARCHAR(45) NOT NULL,
  documento CHAR(15) NOT NULL,
  tipo_conta VARCHAR(45) NOT NULL DEFAULT 'PF',
  data_nascimento DATE NOT NULL,
  rua VARCHAR(100) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  complemento VARCHAR(45),
  estado VARCHAR(2) NOT NULL,
  pais VARCHAR(2) NOT NULL DEFAULT 'BR',
  PRIMARY KEY (idCliente),
  CONSTRAINT cliente_identificacao_unica 
	UNIQUE (documento));

-- Produtos

CREATE TABLE IF NOT EXISTS Produto(
  idProduto INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  categoria ENUM('Roupas', 'Brinquedos', 'Eletrônicos', 'Sem categoria') NOT NULL DEFAULT 'Sem categoria',
  descricao VARCHAR(45) NOT NULL,
  valor VARCHAR(45) NOT NULL,
  classificacao_criancas TINYINT NULL,
  altura_cm FLOAT NOT NULL,
  largura_cm FLOAT NOT NULL,
  comprimento_cm FLOAT NOT NULL,
  peso_kg FLOAT NOT NULL,
  PRIMARY KEY (idProduto));


-- Estoque

CREATE TABLE IF NOT EXISTS Estoque (
  idEstoque INT NOT NULL AUTO_INCREMENT,
  locacao VARCHAR(45) NULL,
  endereco VARCHAR(255)  NOT NULL,
  PRIMARY KEY (idEstoque));

-- Pedidos

CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT(11) NOT NULL AUTO_INCREMENT,
  status ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Processando',
  descricao VARCHAR(255) NULL,
  Cliente_idCliente INT NOT NULL,
  Frete FLOAT NOT NULL DEFAULT 10,
  valor_total FLOAT NOT NULL,
  PRIMARY KEY (idPedido, Cliente_idCliente),
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente));
    
-- Entregas

CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega INT NOT NULL AUTO_INCREMENT,
  status VARCHAR(45) NOT NULL,
  cod_rastreio VARCHAR(45) NOT NULL,
  data_saida DATE NULL,
  data_entrega DATE NULL,
  transportadora VARCHAR(45) NOT NULL,
  idPedido INT(11) NOT NULL,
  PRIMARY KEY (idEntrega),
  CONSTRAINT fk_idpedido_entrega2
	FOREIGN KEY (idPedido)
    REFERENCES Pedido (idPedido));

-- Cartoes

CREATE TABLE IF NOT EXISTS Cartoes (
  idCartao INT NOT NULL AUTO_INCREMENT,
  nro_cartao VARCHAR(45) NOT NULL,
  nome_cartao VARCHAR(45) NOT NULL,
  bandeira_cartao VARCHAR(45) NOT NULL,
  idCliente INT NOT NULL,
  PRIMARY KEY (idCartao, idCliente),
  CONSTRAINT fk_pagamento_cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente));

-- Pagamentos

CREATE TABLE IF NOT EXISTS Pagamento (
  idPagamento INT NOT NULL AUTO_INCREMENT,
  idCliente INT NOT NULL,
  tipo ENUM('boleto', 'cartao_credito', 'pix') NOT NULL DEFAULT 'boleto',
  data_pagamento DATE NOT NULL,
  id_cartao INT(11) NULL,
  codigo_pix VARCHAR(255) NULL,
  link_boleto VARCHAR(255) NULL,
  idPedido INT(11) NOT NULL,
  PRIMARY KEY (idPagamento, idCliente),
  CONSTRAINT fk_pagamento_cliente_pagamentos
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente),
    CONSTRAINT fk_pagamento_cartao
    FOREIGN KEY (id_cartao)
    REFERENCES Cartoes (idCartao),
    CONSTRAINT fk_pagamento_pedido
	FOREIGN KEY (idPedido)
    REFERENCES Pedido (idPedido));

-- Fornecedor

CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  razao_social VARCHAR(45) NOT NULL,
  cnpj VARCHAR(15) NOT NULL,
  telefone CHAR(11) NOT NULL,
  PRIMARY KEY (idFornecedor),
 CONSTRAINT cnpj_unique 
	UNIQUE (cnpj));


-- Fornecimento de produto

CREATE TABLE IF NOT EXISTS Fornecimento_de_produto (
  Fornecedor_idFornecedor INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
  CONSTRAINT fk_fornecedor
    FOREIGN KEY (Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor),
  CONSTRAINT fk_produto
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto));


-- Estoque do produto

CREATE TABLE IF NOT EXISTS Estoque_do_produto (
  Produto_idProduto INT NOT NULL AUTO_INCREMENT,
  Estoque_idEstoque INT NOT NULL,
  quantidade INT NOT NULL DEFAULT 0,
  PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
  CONSTRAINT fk_produto_estoque
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_estoque
    FOREIGN KEY (Estoque_idEstoque)
    REFERENCES Estoque (idEstoque));


-- Produtos nos Pedidos

CREATE TABLE IF NOT EXISTS Produto_no_Pedido (
  Produto_idProduto INT NOT NULL AUTO_INCREMENT,
  Pedido_idPedido INT NOT NULL,
  quantidade_produto INT NOT NULL,
  status ENUM('Disponível', 'Sem estoque') NULL DEFAULT 'Disponível',
  PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
  CONSTRAINT fk_produto_no_pedido
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido));


-- Vendedores terceiros

CREATE TABLE IF NOT EXISTS Terceiro (
  idTerceiro INT NOT NULL AUTO_INCREMENT,
  razao_social VARCHAR(45) NOT NULL,
  endereco VARCHAR(45) NOT NULL,
  nome_fantasia VARCHAR(45) NOT NULL,
  cnpj VARCHAR(15) NULL,
  cpf VARCHAR(11) NULL,
  PRIMARY KEY (idTerceiro),
  CONSTRAINT razao_social_unique UNIQUE (razao_social));


-- Produto por Vendedor

CREATE TABLE IF NOT EXISTS Produto_por_Vendedor (
  Terceiro_idTerceiro INT NOT NULL AUTO_INCREMENT,
  Produto_idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (Terceiro_idTerceiro, Produto_idProduto),
  CONSTRAINT fk_vendedor
    FOREIGN KEY (Terceiro_idTerceiro)
    REFERENCES Terceiro (idTerceiro),
  CONSTRAINT fk_produto_vendedor
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto));
