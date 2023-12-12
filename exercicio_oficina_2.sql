create database oficina;
use oficina;

# utilizado site https://www.uuidgenerator.net/ para geração das primary keys, optou-se por utilizar a versão 1 que se basea na data/hora
# e mac da maquina onde foi gerado o GUID

-- criação de tabelas e insert dos dados  

create table Clientes(
idCliente varchar(36),
Nome varchar (100) not null,
Endereço varchar (200) not null,
Bairro varchar (20),
Contato int,
idPlaca_carro char(7),
primary key(idCliente, idPlaca_carro));


insert into Clientes (idCliente, Nome, Endereço, Bairro, Contato, idPlaca_carro) values
('5e6bc362-97ba-11ee-b9d1-0242ac120002', 'Antonio Fagundes', 'Rua Salinas, 51', 'Prado', 97852636, 'lop1158'),
('5e6bc77c-97ba-11ee-b9d1-0242ac120002', 'Luana Brito', 'Rua Goiás , 517', 'Santa Efigênia', 95663256, 'uie1779'),
('5e6bc8c6-97ba-11ee-b9d1-0242ac120002', 'Eleonora Magalhães', 'Rua São Tome de Souza, 95', 'Savassi', 98512365, 'mty2180'),
('5e6bc9f2-97ba-11ee-b9d1-0242ac120002', 'Gustavo Tavares', 'Av Getulio Vargas, 1287', 'Savassi', 97359823, 'wft7832'),
('5e6bcb0a-97ba-11ee-b9d1-0242ac120002', 'Luiz Marcedo de Carvalho', 'Av Brasil, 1285', 'Funcionarios', 98343187, 'plk4789'),
('5e6bc389-97ba-11ea-b9d1-0242ac120002', 'Heitor de Menezes Garcia', 'Rua José Bonifacio , 103', 'Sion', 98322569, 'ccd4811'),
('5e6bct78-97ba-11ea-b9d1-0242ac120002', 'Douglas Elias Nogueira', 'Rua São Paulo, 236', 'Santa Efigênia', 98329577, 'ccd5289'),
('5e6bp086-97ba-11ea-b9d1-0242ac120002', 'Bruna Esteves Braga', 'Rua Almeida dos Santos, 19', 'Funcionarios', 98326958, 'pop2058'),
('5e6bff2s-97ba-11ea-b9d1-0242ac120002', 'Stella Smith', 'Av do contorno, 1458', 'Funcionarios', 95665428, 'pwe7182'),
('5e6bcb7c-97ba-11ea-b9d1-0242ac120002', 'Rosangela Kaiser Colonia', 'Rua Pernambuco, 1658', 'Savassi', 97714630, 'rty1185');

drop table Oficina;
create table Oficina (
idStatus_servico char(8) not null,
idMecanico char(7),
constraint fk_oficina_idStatus_servico foreign key (idStatus_servico) references Status_servico (idOS_servico),
constraint fk_equipe_mecanico foreign key (idMecanico) references Mecanico (idMecanico));

insert into Oficina (idStatus_servico, idMecanico) values
 ('OS110011', 'M651275'),
 ('OS110012', 'M651275'),
 ('OS110013', 'M651236'),
 ('OS110014', 'M651236'),
 ('OS110015', 'M651275'),
 ('OS110016', 'M651275'),
 ('OS110017', 'M651289'),
 ('OS110019', 'M650023'),
 ('OS110020', 'M650023'),
 ('OS110021', 'M650023'),
 ('OS110022', 'M651275'),
 ('OS110023', 'M651289'),
 ('OS110024', 'M651289'),
 ('OS110025', 'M651236'),
 ('OS110026', 'M651289'),
 ('OS110027', 'M651275');




create table Mecanico (
idMecanico char (7) primary key,
Nome_mecanico varchar(20),
Endereco_mecanico varchar(200));

alter table Mecanico modify Nome_mecanico varchar(100);

insert into Mecanico (idMecanico, Nome_mecanico, Endereco_mecanico) values
('M650023', 'Pietro Enrico Souza', 'Rua Maracanã, 10'),
('M651289', 'Lorenzo João Souza', 'Rua Platina, 871'),
('M651275', 'Felipe Jorge Kauê Brito', 'Rua cambui, 987'),
('M651236', 'Malu Agatha', 'Av Silviano Brandão, 1288');

drop table Ordem_servico;
create table Ordem_servico (
idOS char(10) primary key,
Conserta_carro enum ('S', 'N') not null,
Revisao_periodica enum ('S', 'N') not null,
data_emissao date not null,
data_entrega date not null,
Fase_servico enum ('Não iniciado','Em andamento','Revisão','Atrasado','Finalizado') default 'Não iniciado',
idEstoque_OS char(4),
idtab_calculo_OS int default 0,
idMecanico_OS char(7),
idPlaca_OS varchar(7),
idCliente_OS varchar(36),
constraint fk_ordem_idCliente foreign key (idCliente_OS) references Clientes (idCliente),
constraint fk_ordem_idEstoque foreign key (idEstoque_OS) references Estoque (idEstoque),
constraint fk_ordem_idtab_Custo_Hora foreign key (idtab_calculo_OS) references Tabela_Custo (idtab_custo),
constraint fk_ordem_idMecanico foreign key (idMecanico_OS) references Mecanico (idMecanico));



insert into Ordem_servico (idOS, Conserta_carro, Revisao_periodica, data_emissao, data_entrega, Fase_servico,
 idEstoque_OS, idtab_calculo_OS, idMecanico_OS, idPlaca_OS) values
 ('OS110011', 'S', 'N', '2023-04-05', '2023-05-01', 'Finalizado', 'E103', 1, 'M651275', 'lop1158'),
 ('OS110012', 'S', 'N', '2023-04-10', '2023-05-06', 'Finalizado', 'E113', 1, 'M651275', 'uie1779'),
 ('OS110013', 'N', 'S', '2023-04-20', '2023-05-07', 'Atrasado', default, 6, 'M651236', 'mty2180'),
 ('OS110014', 'N', 'N', '2023-05-01', '2023-05-12', 'Revisão', 'E107', 4, 'M651236', 'wft7832'),
 ('OS110015', 'N', 'S', '2023-05-05', '2023-05-10', 'Revisão', 'E115', 2, 'M651275', 'plk4789'),
 ('OS110016', 'S', 'N', '2023-05-05', '2023-05-05', 'Finalizado', 'E120', 2, 'M651275', 'plk4789'),
 ('OS110017', 'S', 'N', '2023-05-12', '2023-05-16', 'Finalizado', 'E114', 3, 'M651289', 'pwe5132'),
 ('OS110019', 'N', 'S', '2023-05-22', '2023-05-30', 'Finalizado', default, 5, 'M650023', 'pep1020'),
 ('OS110020', 'N', 'S', '2023-05-22', '2023-05-30', 'Atrasado', 'E121', 10, 'M650023', 'pep1020'),
 ('OS110021', 'S', 'N', '2023-05-22', '2023-05-22', 'Revisão', 'E116', 7, 'M650023', 'ccd4811'),
 ('OS110022', 'N', 'N', '2023-05-22', '2023-06-01', 'Revisão', 'E121', 10, 'M651275', 'ccd5289'),
 ('OS110023', 'S', 'N', '2023-05-23', '2023-08-01', 'Em andamento', 'E120', 2, 'M651289', 'ccd5289'),
 ('OS110024', 'S', 'N', '2023-05-23', '2023-06-06', 'Em andamento', 'E122', 11, 'M651289', 'ccd5289'),
 ('OS110025', 'N', 'N', '2023-06-03', '2023-07-07', 'Não iniciado', default, 5, 'M651236', 'pop2058'),
 ('OS110026', 'N', 'N', '2023-06-04', '2023-11-12', 'Não iniciado', 'E101', 8, 'M651289', 'pwe7182'),
 ('OS110027', 'N', 'N', '2023-06-05', '2023-12-01', 'Em andamento', 'E123', 9, 'M651275', 'rty1185');
   
drop table Tabela_custo;
create table Tabela_custo (
idtab_custo int primary key,
Tipo_Trabalho enum ('Avaliação', 'Borracharia', 'Pintura', 'Caixa de Marcha', 'Fluidos', 'Central', 'Eletrica', 'Eixo', 'Tração','Motor','Interior') default 'Avaliação',
Valor_mao_de_obra decimal not null);

insert into Tabela_custo (idtab_custo, Tipo_Trabalho, Valor_mao_de_obra) values
(1,'Avaliação', 10.00),
(2,'Borracharia', 25.00),
(3,'Pintura', 150.50),
(4,'Caixa de Marcha', 100.00),
(5,'Fluidos', 10.00),
(6,'Central', 200.00),
(7,'Eixo', 180.00),
(8,'Eletrica', 95.50),
(9,'Tração', 200.20),
(10,'Motor', 300.00),
(11,'Interior', 35.00);


create table Estoque (
idEstoque char(4) primary key,
Sku_peca varchar (16) not null,
Nome varchar (80) not null,
Quantidade int not null,
Valor_peca decimal(10,2) not null);

alter table Estoque modify Valor_peca decimal(10,2) default '0';

insert into Estoque (idEstoque, Sku_peca, Nome, Quantidade, Valor_peca) values
('E100','KSDTL128','Lanternas dianteiras', 10, 120.00),
('E101','KLDTL828','Central universal', 36, 2000.00),
('E102','KSKKL828','Braço de macha', 5, 850.00),
('E103','KSDTL328','Lanternas dianterias led', 100, 130.00),
('E104','KSDTL528','Lanterna traseira', 89, 150.00),
('E105','KSDTL728','Parachoque dianteiro', 12, 250.00),
('E106','KSDTL928','Parachoque traseiro', 11, 220.00),
('E107','KSDKK538','Caixa 6 machas', 6, 3200.00),
('E108','KSDKK177','Transmissão rotor', 5, 800.00),
('E109','KLDTL128','Ar condicionado painel', 8, 930.00),
('E110','KLDTL159','Ar condicionado Traseiro', 5, 800.00),
('E111','KLDTL178','Trava Eletrica', 2000, 155.00),
('E112','KLDTL122','Sensor de ré', 40, 120.00),
('E113','KLDTL128','Trava Porta', 36, 95.00),
('E114','KSDTL178','Tinta Automatovia', 53, 50.00),
('E115','KSDTL145','Kit Borracharia', 28, 30.00),
('E116','KSDTL582','Exio', 1, 300.00),
('E117','KSDTL728','Lubrificantes', 200, 25.00),
('E118','KSDTL718','Oléo Motor', 100, 120.00),
('E119','KSDTL828','Fluido de Freio', 66, 32.00),
('E120','KLDTL828','Conjunto Rodas', 12, 400.00),
('E121','KSDTL384','Motor', 1, 5000.00),
('E122','KLDTL855','Estofado', 50, 100.00),
('E123','KSDKK128','Engrenagem mestra', 20, 295.00),
('E124','KSDKK141','Chave de machas', 9, 610.00);

create table Status_servico (
idOS_servico char (10) not null,
Servico_aprovado enum ('Sim', 'Não') not null,
idClientes_servico varchar(36) not null,
constraint fk_Servico_realizado_OS foreign key (idOS_servico) references Ordem_servico (idOS),
constraint fk_Servico_idClientes foreign key (idClientes_servico) references Clientes (idCliente));

insert into Status_servico (idOS_servico, Servico_aprovado, idClientes_servico) values
 ('OS110011','Sim','5e6bc362-97ba-11ee-b9d1-0242ac120002'),
 ('OS110012','Sim','5e6bc77c-97ba-11ee-b9d1-0242ac120002'),
 ('OS110013','Sim','5e6bc8c6-97ba-11ee-b9d1-0242ac120002'),
 ('OS110014','Sim','5e6bc9f2-97ba-11ee-b9d1-0242ac120002'),
 ('OS110015','Sim','5e6bcb0a-97ba-11ee-b9d1-0242ac120002'),
 ('OS110016','Sim','5e6bcb0a-97ba-11ee-b9d1-0242ac120002'),
 ('OS110017','Sim','5e6bff2s-97ba-11ea-b9d1-0242ac120002'),
 ('OS110019','Sim','5e6bp086-97ba-11ea-b9d1-0242ac120002'),
 ('OS110020','Sim','5e6bp086-97ba-11ea-b9d1-0242ac120002'),
 ('OS110021','Sim','5e6bc389-97ba-11ea-b9d1-0242ac120002'),
 ('OS110022','Sim','5e6bct78-97ba-11ea-b9d1-0242ac120002'),
 ('OS110023','Sim','5e6bct78-97ba-11ea-b9d1-0242ac120002'),
 ('OS110024','Sim','5e6bct78-97ba-11ea-b9d1-0242ac120002'),
 ('OS110025','Não','5e6bp086-97ba-11ea-b9d1-0242ac120002'),
 ('OS110026','Não','5e6bff2s-97ba-11ea-b9d1-0242ac120002'),
 ('OS110027','Sim','5e6bcb7c-97ba-11ea-b9d1-0242ac120002');

-- mostrar tabelas

desc Clientes;
select *from Clientes;
select *from Oficina;
desc Mecanico;
select *from Mecanico;
select *from Ordem_servico;
select *from Tabela_custo;
select *from Estoque;
select *from Status_servico;

-- recuperando informações simples

select * from Clientes, Ordem_servico where idPlaca_carro = idPlaca_OS;

-- Andamento de cada serviço realizado
select Nome_mecanico, Endereco_mecanico, o.data_entrega, o.Fase_servico from Mecanico as m, Ordem_servico o 
where m.idMecanico = o.idMecanico_OS
order by o.data_entrega desc;

-- Quais Serviços foram Aprovados?

select *from Status_servico s, Clientes c where s.idClientes_servico = c.idCliente and s.Servico_aprovado = 'Sim';

-- Soma dos serviços de revisão periódica

select Revisao_periodica, sum(Valor_mao_de_obra) as valor_total  from Ordem_servico as o, Tabela_custo as t 
where o.idtab_calculo_OS = t.idtab_custo and Revisao_periodica = 'S';

-- Soma dos serviços de conserto

select Conserta_carro, sum(Valor_mao_de_obra) as valor_total  from Ordem_servico as o, Tabela_custo as t 
where o.idtab_calculo_OS = t.idtab_custo and Conserta_carro = 'S';

select Conserta_carro, Valor_mao_de_obra from Ordem_servico as o, Tabela_custo as t 
where o.idtab_calculo_OS = t.idtab_custo and Conserta_carro = 'S';

-- Serificando os carros que foram feitas apenas revisão

select Revisao_periodica, Fase_servico,  idPlaca_OS, Valor_mao_de_obra from Ordem_servico as o, Tabela_custo as t 
where o.idtab_calculo_OS = t.idtab_custo and Revisao_periodica = 'S';

-- Verificando quantos serviços foram feitos por cada mecânico

select count(*) as total_servicos, idMecanico_OS, sum(Valor_mao_de_obra) as valor_total from Ordem_servico as o 
inner join  Tabela_custo as t on o.idtab_calculo_OS = t.idtab_custo
group by o.idMecanico_OS;

-- Recuperando o nome de cada mecânico por serviço e valor

select count(*) as total_servicos, o.idMecanico_OS, sum(t.Valor_mao_de_obra) as valor_total,  m.Nome_mecanico from Mecanico as m, Ordem_servico as o, Tabela_custo as t 
where o.idtab_calculo_OS = t.idtab_custo and m.idMecanico = o.idMecanico_OS
group by o.idMecanico_OS, m.Nome_mecanico;

-- Aplicando aumento na revisão periódica e peças

update Tabela_custo set Valor_mao_de_obra = 
case 
when idtab_custo = 1 then Valor_mao_de_obra + 60.00
when idtab_custo = 5 then Valor_mao_de_obra + 30.00
else Valor_mao_de_obra + 0
end
where idtab_custo >= 1;

select idtab_custo, round(Valor_mao_de_obra, 2) from Tabela_custo;

-- Verificando cliente que aprovaram o serviço

select Nome, Contato, idPlaca_carro,  Servico_aprovado from Clientes c
inner join Status_servico s on c.idCliente = s.idClientes_servico
and Servico_aprovado = 'Sim';

-- Verificando Status de Aprovação dos serviços 

select c.Nome, c.Contato, o.idPlaca_OS, s.Servico_aprovado from Clientes c
inner join Status_servico s on c.idCliente = s.idClientes_servico
inner join Ordem_servico o on s.idOS_servico = o.idOS
order by c.Nome;


select * from Status_servico
inner join Ordem_servico on idOS_servico = idOS
inner join Clientes on idCliente = idClientes_servico;

-- verificando estoque e tabela de referência utilizada

select c.Nome, c.idPlaca_carro, s.Servico_aprovado, os.Fase_servico, os.idEstoque_OS, os.idtab_calculo_OS  from  Status_servico s
inner join Ordem_servico os on s.idOS_servico = os.idOS
inner join Clientes c on c.idCliente = s.idClientes_servico;

-- verificar quanto cada cliente irá pagar

select o.idPlaca_OS, e.Valor_peca, t.Valor_mao_de_obra from Ordem_servico o
left outer join Estoque e on o.idEstoque_OS = e.idEstoque
inner join Tabela_custo t on o.idtab_calculo_OS = t.idtab_custo;

-- Condições de filtros aos grupos – HAVING Statement
select idMecanico_OS, count(*) from Ordem_servico  group by idMecanico_OS having count(idPlaca_OS)>4;