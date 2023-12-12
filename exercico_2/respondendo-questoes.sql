-- Recuperações simples com SELECT Statement

SELECT C.* FROM cliente as C;

-- Filtros com WHERE Statement

SELECT * FROM pedido WHERE Cliente_idCliente = 3;

-- Crie expressões para gerar atributos derivados

SELECT nome, categoria, round(valor*0.5, 2) as comissao FROM produto;

-- Defina ordenações dos dados com ORDER BY

SELECT * FROM pedido WHERE Cliente_idCliente = 3 ORDER BY valor_total DESC;

-- Condições de filtros aos grupos – HAVING Statement

SELECT count(idPedido) as qtde_compras, Cliente_idCliente as cliente, SUM(valor_total) as valor_total
FROM pedido
GROUP BY cliente
HAVING valor_total >= 200;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

SELECT count(p.idPedido) AS qtde_compras, SUM(p.valor_total) as valor_total, CONCAT(c.primeiro_nome, ' ', c.ultimo_nome)  AS nome_cliente, 
	CONCAT(c.rua, ', ', c.numero, ', ', c.bairro, ', ', c.cidade, '-', c.estado, ', ', c.pais) AS endereco
FROM pedido p
INNER JOIN cliente c ON c.idCliente = p.Cliente_idCliente
GROUP BY p.Cliente_idCliente
HAVING valor_total >= 200;

-- Quantos pedidos foram feitos por cada cliente?

SELECT count(p.idPedido) AS qtde_pedidos, CONCAT(c.primeiro_nome, ' ', c.ultimo_nome)  AS nome_cliente
FROM pedido p
INNER JOIN cliente c ON c.idCliente = p.Cliente_idCliente
GROUP BY p.Cliente_idCliente;

-- Algum vendedor também é fornecedor?
 SELECT t.cnpj, t.cpf,t.nome_fantasia,t.razao_social,t.endereco,
 (case when t.cnpj = f.cnpj then "Tambem um vendedor" end) as situacao
 FROM terceiro as t
 INNER JOIN produto_por_vendedor as pv ON pv.Terceiro_idTerceiro = t.idTerceiro
 INNER JOIN produto as p ON p.idProduto = pv.Produto_idProduto
 INNER JOIN fornecimento_de_produto as fp ON fp.Produto_idProduto = p.idProduto
 INNER JOIN Fornecedor as f ON f.idFornecedor = fp.Fornecedor_idFornecedor
 order by t.cnpj  asc;
 
-- * Relação de produtos fornecedores e estoques
SELECT f.cnpj, f.razao_social,p.nome,p.categoria,p.descricao,p.valor,ep.quantidade
FROM estoque as e 
 INNER JOIN estoque_do_produto as ep ON ep.Estoque_idEstoque = e.idEstoque
 INNER JOIN produto as p ON p.idProduto = ep.Produto_idProduto
 INNER JOIN fornecimento_de_produto as fp ON fp.Produto_idProduto = p.idProduto
 INNER JOIN Fornecedor as f ON f.idFornecedor = fp.Fornecedor_idFornecedor
 group by f.cnpj, f.razao_social,p.nome,p.categoria,p.descricao,p.valor,ep.quantidade;

 -- Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.cnpj, f.razao_social,p.nome,p.categoria,p.valor
FROM estoque as e 
 INNER JOIN estoque_do_produto as ep ON ep.Estoque_idEstoque = e.idEstoque
 INNER JOIN produto as p ON p.idProduto = ep.Produto_idProduto
 INNER JOIN fornecimento_de_produto as fp ON fp.Produto_idProduto = p.idProduto
 INNER JOIN Fornecedor as f ON f.idFornecedor = fp.Fornecedor_idFornecedor
 
 
