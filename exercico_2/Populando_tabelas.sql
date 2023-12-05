SHOW DATABASES;
USE ecommerce_2;
SHOW TABLES;
DESC cliente;

-- Inserindo Dados
-- Clientes

INSERT INTO cliente (primeiro_nome, nome_meio, ultimo_nome, documento, tipo_conta, data_nascimento, rua,
	bairro, cidade, numero, complemento, estado, pais) VALUES ('Carlos', 'AS', 'Junior', 123456789, 'PJ', '2007-05-08',
    'Rua A', 'Bairro B', 'Andradas', '137', '', 'MG', 'BR'),
    ('Isaac', 'C', 'Silva', 987654321, 'PJ', '2007-05-08',
    'Rua A', 'Bairro B', 'Andradas',  '422', '', 'MG', 'BR'),
    ('Rosilene', 'C', 'Silva', 987651234, 'PJ', '1989-04-08',
    'Rua A', 'Bairro B', 'Andradas',  '101', '', 'MG', 'BR'),
    ('Roberta', 'G', 'Mendonça', 325867877, 'PF', '2000-05-18',
    'Rua A', 'Bairro C', 'Loira',  '69', '', 'MG', 'BR'),
    ('Iris', 'T', 'Melo', 133589641, 'PF', '1994-03-02',
    'Rua A', 'Bairro D', 'Bagunça',  '89', '', 'MG', 'BR'),
     ('Antonio', 'M', 'Silveira', 189563287, 'PF', '1990-11-08',
    'Rua A', 'Bairro E', 'Solaris',  '3', '', 'MG', 'BR'),
    ('Patricia', 'O', 'Smith', 895625748, 'PF', '2003-08-28',
    'Rua A', 'Bairro E', 'Pokarontas',  '753', '', 'MG', 'BR'),
    ('Rosilene', 'k', 'Abravanel', 987689562, 'PJ', '1996-07-04',
    'Rua A', 'Bairro A', 'Andalus',  '532', '', 'MG', 'BR');
    
-- Cartoes

DESC cartoes;

INSERT INTO cartoes (nro_cartao, nome_cartao, bandeira_cartao, idCliente) VALUES
	('345645674332', 'Carlos Junior', 'Visa', 1),
    ('345645674332', 'Isaac Silva', 'Visa', 2),
    ('345645674732', 'Rosilene Couto', 'Visa',3),
    ('345645674532', 'Roberta Gioto', 'Visa', 4),
    ('564567433257', 'Iris Talude', 'american express', 5),
    ('345648974831', 'Antonio Mederos', 'Visa', 6),
    ('345643312572', 'Patricia Otto', 'Visa', 7),
    ('345458174922', 'Rosilene kayser', 'Visa', 8);
    
    
-- Fornecedor

DESC fornecedor;

INSERT INTO fornecedor (razao_social, cnpj, telefone) VALUES
	('Fulano Brinquedos', '345566556563425', '3599996006'),
    ('Siclando Modas', '565656565656789', '11677653456');
    
-- Produtdo

DESC produto;

INSERT INTO produto (nome, categoria, descricao, valor, classificacao_criancas,
altura_cm, largura_cm, comprimento_cm, peso_kg) VALUES
	('Camisa Preta', 'Roupas', 'Camisa masculina com várias cores.', 30.50, 0, 30, 30, 10, 0.200),
	('Carrinho de controle remoto', 'Brinquedos', 'Carrinho com pilhas recarregáveis.', 70.00, 1, 20, 30, 40, 0.500),
	('Calça jeans', 'Roupas', 'Calça jeans feminina', 60.99, 0, 30, 30, 5, 0.200),
    ('Boneco Soldado', 'Brinquedos', 'Boneco de soldado', 60.99, 0, 30, 30, 5, 0.200);

-- Produto/Fornecedor (relacionamento)

DESC fornecimento_de_produto;

INSERT INTO fornecimento_de_produto VALUES
	(1, 2),
    (2, 1),
    (2, 3);
    
-- Vendedor terceiro

DESC terceiro;

INSERT INTO terceiro (razao_social, endereco, nome_fantasia, cnpj, cpf) VALUES
	('Terceiro Moda LTDA', 'Rua A, 32, Jd B, São Paulo, SP', 'Roupas Daora', '64517366000115', ''),
    ('Pequenino Importação LTDA', 'Rua C, 12, Jd D, Diadema, SP', 'Pequeninos Brinquedos', '35478258000182', '');
    
-- Produto por terceiro

DESC produto_por_vendedor;

INSERT INTO produto_por_vendedor (Terceiro_idTerceiro, Produto_idProduto, quantidade) VALUES
	(1, 4, 10);
    
-- Dados de estoque

DESC estoque;

INSERT INTO estoque (locacao, endereco) VALUES
	('Box B, 203', 'Armazem A'),
    ('Box A, 123', 'Armazem B'),
    ('', 'Armazenado por terceiro');
    
-- Dados de estoque dos produtos

DESC estoque_do_produto;

INSERT INTO estoque_do_produto (Produto_idProduto, Estoque_idEstoque, quantidade) VALUES
	(1, 1, 22),
    (2, 1, 32),
    (3, 2, 10),
    (4, 3, 21);
    
-- Pedidos

DESC pedido;

INSERT INTO pedido (status, descricao, Cliente_idCliente, Frete, valor_total) VALUES
	('Em andamento', '', 1, 25.60, 300.00),
    ('Processando', '', 2, 34.00, 500.00),
    ('Enviado', '', 3, 0.00, 70.00),
    ('Entregue', 'Finalizado', 4, 20.00, 80.00),
    ('Entregue', 'Finalizado', 4, 0.00, 520.00),
    ('Entregue','Finalizado', 5, 0.00, 110.00),
    ('Enviado', '', 5, 0.00, 78.50),
    ('Enviado', '', 6, 0.00, 31.50),
    ('Enviado', '', 7, 0.00, 35.00),
    ('Processando', '', 8, 0.00, 100.00),
    ('Processando', '', 8, 0.00, 70.00),
    ('Processando', '', 8, 0.00, 70.00),
    ('Processando', '', 8, 0.00, 70.00);
    
-- Entrega

DESC entrega;

INSERT INTO entrega (cod_rastreio, data_entrega, data_saida, status, transportadora, idPedido) VALUES
	('FGFG56563', NULL, NULL, 'Em separação', 'Correios', 1),
    ('FGFG56564', NULL, NULL, 'Aguardando', 'Correios', 2),
    ('FGFG56565', '2007-05-08', NULL, 'Saiu para entrega', 'Correios', 3),
    ('FGFG56566', '2007-05-08', '2007-05-18', 'Entregue', 'Correios', 4),
    ('FGFG56567', '2007-05-09', '2007-05-20', 'Entregue', 'Correios', 5),
    ('FGFG56568', '2007-05-09', NULL, 'Saiu para entrega', 'Correios', 6),
    ('FGFG56569', '2007-05-09', NULL, 'Saiu para entrega', 'Correios', 7),
    ('FGFG56570', '2007-05-10', NULL, 'Saiu para entrega', 'Correios', 8),
    ('FGFG56571', NULL, NULL, 'Aguardando', 'Correios', 9),
    ('FGFG56572', NULL, NULL, 'Aguardando', 'Correios', 10),
    ('FGFG56573', NULL, NULL, 'Aguardando','Correios', 11),
    ('FGFG56574', NULL, NULL, 'Aguardando','Correios', 12);
    
-- Pagamento

DESC pagamento;

INSERT INTO pagamento (idCliente, tipo, data_pagamento, id_cartao, codigo_pix, link_boleto, idPedido) VALUES
	('1', 'boleto', '2007-07-05', NULL, NULL, 'https://boleto.com', 1),
    ('2', 'boleto', '2007-07-05', NULL, NULL, 'https://boleto.com', 2),
    ('3', 'pix', '2007-07-05', NULL, 'governo.etc', NULL, 3),
    ('4', 'cartao_credito', '2007-07-05', 4, NULL, NULL, 4),
    ('4', 'cartao_credito', '2007-07-05', 4, NULL, NULL,5),
    ('5', 'boleto', '2007-07-05', NULL, NULL, 'https://boleto.com', 6),
    ('5', 'cartao_credito', '2007-07-05', 5, NULL, NULL, 7),
    ('6', 'pix', '2007-07-05', NULL, 'governo.etc', NULL, 8),
    ('7', 'boleto', '2007-07-05', NULL, NULL, 'https://boleto.com', 9),
    ('8', 'cartao_credito', '2007-07-05', 8, NULL, NULL, 10),
    ('8', 'cartao_credito', '2007-07-05', 8, NULL, NULL, 11),
    ('8', 'cartao_credito', '2007-07-05', 8,  NULL, NULL, 12);