# Projeto-Modelagem-de-Banco-de-Dados-E-COMMERCE
Refinando um Modelagem de Banco de Dados E-COMMERCE,Usando MySQL Workbench

O Projeto de Banco de Dados de E-commerce contem:
- Contexto: Levantamento de requisitos
- Projeto Conceitual: Modelo Entidade Relacionamento
- Projeto Lógico: Modelo Relacional

Modelando Do Banco de Dados :

Entidades:
Cliente, Pedido, Produto e Fornecedor & estoque

Cliente:
- O cliente pode se cadastrar no site com seu CPF ou CNPJ
- O endereço do cliente irá determinar o valor do frete
- Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto

Pedido:
- O pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega
- Um produto ou mais compoem o pedido
- O pedido pode ser cancelado

Produto:
- Cada produto possui somente um fornecedor
- Um ou mais produtos podem compor o pedido

Fornecedor:
-cada distribuidor somente pode disponibilizar um produto

Estoque:
- cada produto deve estr ligado a um centro de distribuição



Observações:
- Cliente PJ e PF - Uma conta pode ser PJ ou PF, mas não pode ter as duas informações
- Pagamento - Pode ter cadastrado mais de uma forma de pagamento
- Entrega - possui status e código de restreio
-Cada tabela registra o horario que foi incerido o registro e o usuario que efetuou a ação no sistema
- o dado é apagado de forma logica  registrando  o usuario que fez a ação "terminationuser" e a data da ação  "terminationdate" para fins de auditoria