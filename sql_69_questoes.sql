create database Listao_complementar

use listao_complementar

/*criar estrutura das tabelas */
create table cliente (
    cod_cliente integer not null,
    nome_cliente varchar(40) not null,
    endereco varchar(40),
    cidade varchar(40),
    cep varchar(9),
    uf char(2),
    cgc char(18),
    ie char(11));

create table pedido (
    num_pedido integer not null,
    cod_cliente integer not null,
    prazo_entrega date not null,
    cod_vendedor integer not null);

create table produto (
    cod_produto integer not null,
    descricao varchar(40),
    unidade char(3),
    vlr_unitario numeric(10,2));

create table item_pedido (
    num_pedido integer not null,
    cod_produto integer not null,
    quantidade numeric(10,2));

create table vendedor (
    cod_vendedor integer not null, 
    nome_vendedor varchar(40),
    faixa_comissao char(1),
    salario_fixo numeric(10,2));

/* criar chaves prim�rias */
alter table cliente add constraint PK_CLIENTE primary key(cod_cliente);
alter table pedido add constraint PK_PEDIDO primary key(num_pedido);
alter table produto add constraint PK_PRODUTO primary key(cod_produto);
alter table item_pedido add constraint PK_ITEMPED primary key(num_pedido,cod_produto);
alter table vendedor add constraint PK_VENDEDOR primary key(cod_vendedor);

/* criar chaves estrangeiras */
alter table pedido add constraint FK_PEDIDO_VENDEDOR foreign key(cod_vendedor) references vendedor(cod_vendedor);
alter table pedido add constraint FK_PEDIDO_CLIENTE foreign key(cod_cliente) references cliente(cod_cliente);
alter table item_pedido add constraint FK_ITEMPED_NUMPEDIDO foreign key(num_pedido) references pedido(num_pedido);
alter table item_pedido add constraint FK_ITEMPED_PRODUTO foreign key(cod_produto) references produto(cod_produto);

-- SEÇÃO 1
--Listar número do pedido e prazo de entrega de todos os pedidos.
select p.num_pedido, p.prazo_entrega 
	from pedido p;
--Listar a descrição e o valor unitário dos produtos.
select p.descricao, p.vlr_unitario
	from produto p;
--Listar nome e endereço de todos os clientes.
select c.nome_cliente, c.endereco
	from cliente c;
--Listar nome de todos os vendedores.
select v.nome_vendedor
	from vendedor v;
--Listar todas as informações da tabela de clientes.
select c.* 
	from cliente c;
--Listar todas as informações da tabela produtos.
select p.*
	from produto p;
--Listar o código e nome dos produtos. Insira as literais "código do produto" e "nome do produto" antes de cada atributo.
select 
	CONCAT('Código do produto ', p.cod_produto) as cod_produto,
	--'cod ' & CAST(p.cod_produto as varchar(6)) as cod_cast,
	CONCAT('nome do produto ', p.descricao) as descricao
	from produto p;
--Listar o nome de todos os vendedores. Alterar o cabeçalho da coluna para nome.
select v.nome_vendedor as nome
	from vendedor v;
--Listar o nome de todos os clientes. Alterar o cabeçalho da coluna para nome.
select c.nome_cliente as nome
	from cliente c;
--Listar o preço dos produtos aumentados em 10%.
select (p.vlr_unitario * 1.1) as vlr_unitario
	from produto p;
--Listar o salário fixo dos vendedores aumentados em 5%.
select (v.salario_fixo * 1.05) as salario_fixo, v.salario_fixo
	from vendedor v;

-- SEÇÃO 2
--Listar o nome dos clientes que moram em Sorocaba.
select c.* 
	from cliente c
		where c.cidade = 'Sorocaba'
--Listar todos os dados dos vendedores com salário fixo <$400,00.
select v.*
	from vendedor v
		where v.salario_fixo < 400;
--Listar o código do produto e a descrição para os produtos cuja unidade seja igual  a "Kg".
select p.cod_produto, p.descricao
	from produto p
		where p.unidade = 'Kg';
--Listar o pedido e o prazo de entrega para os pedidos feitos entre 01/05/1998 a 01/06/1998.
select p.num_pedido, p.prazo_entrega
	from pedido p
		where p.prazo_entrega BETWEEN '1998-05-01' AND '1998-06-01';
--Listar os dados dos produtos cujo valor unitário seja maior que $100,00 e menor que $200,00.
select p.cod_produto, p.descricao, p.unidade, p.vlr_unitario
	from produto p
		where vlr_unitario BETWEEN 100 AND 200;
--Listar o numero do pedido e o código do pedido cuja quantidade esteja entre 1000 e 1500.
select p.num_pedido
	from pedido p, item_pedido ip
		where p.num_pedido = ip.num_pedido
		and ip.quantidade BETWEEN 1000 AND 1500;
--Listar o nome dos vendedores cujo nome comece por "José".
select v.nome_vendedor
	from vendedor v
		where v.nome_vendedor LIKE 'José%';
--Listar o nome de todos os clientes cujo ultimo nome seja "Silva".
select c.nome_cliente
	from cliente c
		where c.nome_cliente LIKE '%Silva'	;
--Listar a descrição e o código dos produtos que tem a seqüência "AC" em qualquer parte da descrição.
select p.descricao, p.cod_produto
	from produto p
		where p.descricao like '%AC%';
--Listar o código do produto que tenha quantidade 100, 200 ou 300.
select ip.cod_produto
	from item_pedido ip
		where ip.quantidade IN(100, 200, 300);
--Listar o nome e a faixa, de comissão para os vendedores com salário fixo igual a $300,00, $400,00 ou $500,00.
select v.nome_vendedor, v.faixa_comissao
	from vendedor v
		where v.salario_fixo in (300, 400, 500);
--Listar os nomes dos clientes que não tenham endereço cadastrado.
select c.nome_cliente
	from cliente c
		where c.endereco is null
--Listar a descrição dos produtos com unidade igual a "Lt" e valor unitário entre $100,00 e $150,00.
select p.descricao
	from produto p
	where p.unidade = 'Lt'
	and p.vlr_unitario between 100 and 150;
--Listar os dados dos clientes que moram em "Itu" e não estão com o CEP cadastrado.
select c.cod_cliente, c.nome_cliente, c.cep, c.cgc, c.cidade, c.endereco, c.ie, c.uf
	from cliente c
	where c.cidade = 'Itu'
	and c.cep is null;
--Listar as cidades onde moram os clientes (exibir cada cidade apenas uma vez).
select distinct(c.cidade)
	 from cliente c;
--Listar dos dados dos clientes por ordem alfabética de nome.
select c.cod_cliente, c.nome_cliente, c.cep, c.cgc, c.cidade, c.endereco, c.ie, c.uf
	from cliente c
		order by c.nome_cliente;
--Listar os dados dos clientes por ordem alfabética decrescente de cidade.
select c.cod_cliente, c.nome_cliente, c.cep, c.cgc, c.cidade, c.endereco, c.ie, c.uf
	from cliente c
		order by c.cidade desc;
--Listar a maior quantidade que conste na tabela de item do pedido.
select max(ip.quantidade) as quantidade_maxima
	from item_pedido ip;
--Listar o menor valor unitário da tabela de produtos.
select min(p.vlr_unitario) as menor_vlr_unitario
	from produto p;
--Mostrar a somatória dos salários fixos pago aos vendedores.
select sum(v.salario_fixo) as total_salarios_fixos
	from vendedor v;
--Listar o numero de produtos cuja unidade seja igual a "Lt".
select count(p.cod_produto) as produtos_lt
	from produto p
		where p.unidade = 'Lt';
--Listar o numero de clientes agrupados por cidade.
select count(c.cod_cliente) as quantidade, c.cidade
	from cliente c
		group by c.cidade;
--Listar quantos pedidos cada vendedor realizou.
select count(p.num_pedido) as quantidade_pedidos, v.cod_vendedor, v.nome_vendedor
	from pedido p, vendedor v
		where p.cod_vendedor = v.cod_vendedor
				group by v.cod_vendedor, v.nome_vendedor;
--Listar o maior e o menor valor unitário para cada tipo de unidade de produto.
select min(p.vlr_unitario) as menor_vlr_unitario, max(p.vlr_unitario) as maior_vlr_unitario, p.unidade
	 from produto p
		group by p.unidade;
--Listar o numero de clientes, agrupados por cidade para todas as cidades que aparecem mais de 4 vezes na tabela de clientes.
select count(c.cod_cliente) as qtd, c.cidade
	from cliente c
		group by cidade
			having count(c.cod_cliente) > 4;
-- SEÇÃO 3
-- Listar o código e o nome dos vendedores que efetuaram vendas para o cliente com código 10.
select v.cod_vendedor, v.nome_vendedor
	from vendedor v, pedido p
		where p.cod_vendedor = v.cod_vendedor 
		and p.cod_cliente = 10;
-- Listar  o número do pedido, prazo de entrega, a quantidade e a descrição do produto com código 100.
select p.num_pedido, p.prazo_entrega, ip.quantidade, pr.descricao
	from pedido p, item_pedido ip, produto pr
		where p.num_pedido = ip.num_pedido
		and pr.cod_produto = ip.cod_produto
		and pr.cod_produto = 100;
-- Listar o endereço dos clientes do estado do Rio de Janeiro (UF = 'RJ') que têm prazo de entrega até 03-08-1998 ou fizeram pedido com o vendedor com código 20.
select c.endereco
	from cliente c, pedido p
		where p.cod_cliente = c.cod_cliente
		and ( c.uf = 'RJ'
		and p.cod_vendedor = 20)
		or p.prazo_entrega <= '1998-08-03';
-- Quais os vendedores (código e nome) fizeram pedidos para o cliente 'Ciclano da Silva'.
select v.cod_vendedor, v.nome_vendedor
	from vendedor v, pedido p, cliente c
		where v.cod_vendedor = p.cod_vendedor
		and p.cod_cliente = c.cod_cliente
		and c.nome_cliente = 'Ciclano da Silva';
-- Quais produtos (código, descrição, unidade e quantidade) cuja quantidade seja maior que 50 e menor que 100.
select p.cod_produto, pr.descricao, pr.unidade, sum(ip.quantidade) as qtd_total
	from produto p, item_pedido ip, produto pr
		where p.cod_produto = ip.cod_produto
		and pr.cod_produto = ip.cod_produto
		group by p.cod_produto, pr.descricao, pr.unidade
		having sum(ip.quantidade) between 50 and 100;
-- Listar o número do pedido, o código do produto, a descrição do produto, o código do vendedor, o nome do vendedor , o nome do cliente, para todos os clientes que moram em Sorocaba.
select pd.num_pedido, pr.cod_produto, pr.descricao, v.cod_vendedor, v.nome_vendedor, c.nome_cliente
	from pedido pd, produto pr, vendedor v, cliente c, item_pedido ip
	where pd.cod_cliente = c.cod_cliente
	and pd.cod_vendedor = v.cod_vendedor
	and ip.cod_produto = pr.cod_produto
	and ip.num_pedido = pd.num_pedido
	and c.cidade = 'Sorocaba';
-- Listar o código e o nome dos clientes que tem prazo de entrega para maio/2002.
select c.cod_cliente, c.nome_cliente
	from cliente c, pedido p
		where c.cod_cliente = p.cod_cliente
		and MONTH(p.prazo_entrega) = 5 and YEAR(p.prazo_entrega) = 2002 
-- Listar o código do produto, a descrição, a quantidade pedida e o prazo de entrega para o pedido número 123.
select pr.cod_produto, pr.descricao, pd.prazo_entrega, ip.quantidade
	from produto pr, item_pedido ip, pedido pd
		where ip.cod_produto = pr.cod_produto
		and ip.num_pedido = pd.num_pedido;
-- Quais os clientes ( nome e endereço) da cidade de Itu ou Sorocaba tiveram seus pedidos tirados com o vendedor  'Alôncio Pimentão'.
select c.nome_cliente, c.endereco
	from cliente c, pedido p, vendedor v
		where p.cod_cliente= c.cod_cliente
		and v.cod_vendedor = p.cod_vendedor
		and c.cidade in('Itu', 'Sorocaba')
		and v.nome_vendedor = 'Alôncio Pimentão';
-- Crie uma visão com  o número do pedido, o código do produto, a descrição do produto, o código do vendedor, o nome do vendedor , o nome do cliente, para todos os clientes que moram em Itu. Esta visão é alterável? Explique o porque.
-- a view é alterável através de um alter view, o que não é possível é alterar os registros da view com um update NOME_VIEW.
-- quando a view é de uma tabela só, pode ser usada para alterar os registros, se não não
create view pedido_completo (num_pedido, cod_produto, descricao, cod_vendedor, nome_vendedor, nome_cliente) as 
	select p.num_pedido, pr.cod_produto, pr.descricao,v.cod_vendedor, v.nome_vendedor, c.nome_cliente
		from pedido p, produto pr, item_pedido ip, vendedor v, cliente c
		where pr.cod_produto = ip.cod_produto
		and ip.num_pedido = p.num_pedido
		and p.cod_cliente = c.cod_cliente
		and p.cod_vendedor = v.cod_vendedor
		and c.cidade = 'Itu';
-- Listar todos os clientes que moram na mesma cidade que 'João da Silva'.
select c.*
	from cliente c
	where c.cidade IN (select c2.cidade from cliente c2 where c2.nome_cliente = 'João da Silva');
-- Quais produtos tem valor unitário acima da media.
select avg(pr.vlr_unitario) as media, pr.descricao
	from produto pr
		group by pr.descricao
			having avg(pr.vlr_unitario) > (select avg(pr2.vlr_unitario) from produto pr2);
-- Quais os clientes que só compraram com o vendedor com codigo 10.
select c.*
	from cliente c, pedido p
		where c.cod_cliente = p.cod_cliente
		and p.cod_vendedor = 10;
-- Quais  os clientes que só compraram com o vendedor 'Fulado de Tal'.
select c.*
	from cliente c, pedido p, vendedor v
		where c.cod_cliente = p.cod_cliente
		and v.cod_vendedor = p.cod_vendedor
		and v.nome_vendedor = 'Fulano de Tal';
-- Quais os vendedores não fizeram nenhum pedido no mês de novembro/98.
select v.*
	from vendedor v
		where v.cod_vendedor NOT IN (
			select p.cod_vendedor 
				from pedido p 
					where p.cod_vendedor = v.cod_vendedor 
						and month(p.prazo_entrega) = 11
						and year(p.prazo_entrega) = 1998
			)

-- SEÇÃO 4
--Remova da tabela de produtos os produtos com valor unitários > $ 600,00.
delete
	from produto
		where vlr_unitario > 600;
--Remover da tabela de pedidos todos os pedidos do vendedor com código 30.
delete
	from pedido	
		where cod_vendedor = 30;
--Remover da tabela vendedor os que não tem nenhum pedido emitido.
delete 
	from vendedor
		where cod_vendedor not in (select p.cod_vendedor from pedido p);
--Remover da tabela item do pedido os produtos que tenham valor unitário > $300,00.
delete
	from item_pedido
		where cod_produto in (select p.cod_produto from produto p where p.vlr_unitario > 300)
--Dar um aumento de 5% para todos os produtos.
update produto
	set vlr_unitario = vlr_unitario * 1.05;
--Alterar a faixa de comissão de B para A do vendedor com código 32.
update vendedor
	set faixa_comissao = 'A'
		where cod_vendedor = 32;
--Reduzir o valor unitário em 0,5% dos produtos que estejam acima da media dos preços.
update produto
	set vlr_unitario = vlr_unitario * 0.995
		where vlr_unitario > (select avg(p.vlr_unitario) from produto p);