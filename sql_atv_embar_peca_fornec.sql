create database atv_5_11;
use atv_5_11;

create table peca (
	codPeca varchar(3) not null,
	nomePeca varchar(100),
	corPeca varchar(20),
	pesoPeca int,
	cidadePeca varchar(30)
);

create table fornec(
	codFornec varchar(3) not null,
	nomeFornec varchar(100),
	statusFornec smallint,
	cidadeFornec varchar(30)
);

create table embarq(
	codPeca varchar(3),
	codFornec varchar(3),
	qtidEmbarq int
);

alter table peca add constraint pk_peca PRIMARY KEY(codPeca);
alter table fornec add constraint pk_fornec PRIMARY KEY(codFornec);
alter table embarq add constraint pk_embarq PRIMARY KEY(codEmbarq);

alter table embarq add constraint fk_embarq_peca FOREIGN KEY(codPeca) references peca(codPeca);
alter table embarq add constraint fk_embarq_fornec FOREIGN KEY(codFornec) references fornec(codFornec);


insert into peca(codPeca, nomePeca, corPeca, pesoPeca, cidadePeca)
	VALUES 
	('P1', 'Eixo', 'Cinza', 10, 'Porto Alegre'),
	('P2', 'Rolamento', 'Preto', 16, 'Santa Maria'),
	('P3', 'Mancal', 'Verde', 30, 'Uruguaiana');

insert into fornec(codFornec, nomeFornec, statusFornec, cidadeFornec)
	VALUES
	('F1', 'Silva', 5, 'São Paulo'),
	('F2', 'Souza', 10, 'Rio de Janeiro'),
	('F3', 'Alvares', 5, 'São Paulo'),
	('F4', 'Tavares', 8, 'Rio de Janeiro');

insert into embarq(codPeca, codFornec, qtidEmbarq)
values 
('P1', 'F1', 300),
('P1', 'F2', 400),
('P1', 'F3', 200),
('P2', 'F1', 300),
('P2', 'F4', 350);

--1a listar fornecedores e pecas embarcadas
select f.*, p.*
	from embarq e, fornec f, peca p
	where e.codFornec = f.codFornec and e.codPeca = p.codPeca

--1b pecas embarcadas do fornecedor 2
select f.*, p.*
	from embarq e, fornec f, peca p
	where e.codFornec = f.codFornec and e.codPeca = p.codPeca
	and f.codFornec = 'F2'

--1c dados dos fornecedores de são paulo
select f.*
	from fornec f
	where f.cidadeFornec = 'São Paulo'
--1d quantidde de embarques
select count(e.codPeca) as contagem_embarq from embarq e
--e peça que não teve embarq
select p.*
	from peca p
	 where p.codPeca not in (select e.codPeca from embarq e)
--f media de quantidade embarcada
select AVG(e.qtidEmbarq)
	from embarq e
--g total de quantidade embarcada
select sum(e.qtidEmbarq)
	from embarq e

--2 add foneFornec remove corPeca
alter table fornec add foneFornec varchar(20);
alter table peca drop column corPeca;

--3 totalizar a quantidade de pecas embarcadas
select p.codPeca, count(p.codPeca)
	from peca p, embarq e
		where p.codPeca = e.codPeca
			group by p.codPeca
--4 acrescentar 10% na quantidade total de pecas
update embarq set qtidEmbarq = qtidEmbarq * 1.1;
--5 eliminar embarq de p2 do fornecedor f4
delete from embarq where codFornec = 'F4' and codPeca = 'P2'
--6 criar view com o peso total
select (p.pesoPeca * e.qtidEmbarq) as peso_total, p.*, e.*
	from peca p, embarq e
		where p.codPeca = e.codPeca
--7 eliminar a constraint codPeca do embarq
alter table embarq drop constraint fk_embarq_peca;
--8 eliminar codPeca de embarq
alter table embarq drop column codPeca;
--9 eliminar table embarq
drop table embarq; 