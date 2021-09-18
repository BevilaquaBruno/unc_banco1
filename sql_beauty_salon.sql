-- create database exerc_salao;

use exerc_salao;

-- 1 criar tabelas
create table reserva (
	id integer not null,
	dt_atendimento smalldatetime default getdate(),
	hora time not null,
	obs varchar(200),
	atendido char(1) default 'N',
	id_cliente int not null
);

create table cliente(
	id int not null,
	nome varchar(50) not null,
	telefone varchar(50)
);

create table produto(
	id int not null,
	unidade varchar(3) default 'UNI',
	descricao varchar(40) not null,
	preco decimal(12,2) default 0
);

create table atendente (
	id smallint not null,
	nome varchar(40) not null
);

create table servico (
	id int not null,
	descricao varchar(40) not null,
	preco decimal(12,2) default 0
);

create table atendente_reserva(
	id int not null,
	id_atendente smallint not null,
	id_reserva int not null
);

create table servico_reserva(
	id int not null,
	id_servico int not null,
	id_reserva int not null,
	preco decimal(12,2) not null
);

create table produto_reserva (
	id int not null,
	id_produto int not null,
	id_reserva int not null,
	preco decimal(12,2) not null,
	quantidade decimal(12,2) not null
);

-- 2 criar chaves primarias
alter table reserva add constraint pk_reserva primary key(id);
alter table produto add constraint pk_produto primary key(id);
alter table atendente add constraint pk_atendente primary key(id);
alter table servico add constraint pk_servico primary key(id);
alter table cliente add constraint pk_cliente primary key(id);
alter table atendente_reserva add constraint pk_atendente_reserva primary key(id);
alter table servico_reserva add constraint pk_servico_reserva primary key(id);
alter table produto_reserva add constraint pk_produto_reserva primary key(id);

-- 3 criar chaves estrangeiras
alter table reserva add constraint fk_cliente_reserva foreign key (id_cliente) references cliente(id);

alter table atendente_reserva add constraint fk_atendente_reserva foreign key (id_atendente) references atendente(id);
alter table atendente_reserva add constraint fk_reserva_atendente foreign key (id_reserva) references reserva(id);

alter table servico_reserva add constraint fk_servico_reserva foreign key (id_servico) references servico(id);
alter table servico_reserva add constraint fk_reserva_servico foreign key (id_reserva) references reserva(id);

alter table produto_reserva add constraint fk_produto_reserva foreign key (id_produto) references produto(id);
alter table produto_reserva add constraint fk_produto_servico foreign key (id_reserva) references reserva(id);

-- até agora é sql ddl data definition language
-- agora é sql dml data manipulation language

INSERT INTO cliente(id, nome, telefone) VALUES
(1, 'Cliente 1', '49998320023'),
(2, 'Cliente 2', '49998320054'),
(3, 'Cliente 3', '49998320003');

set dateformat DMY;

INSERT INTO reserva (id, dt_atendimento, hora, obs, atendido, id_cliente) VALUES
(1, '17.09.2021', '17:30', 'observacao', 'N', 1),
(2, '15.09.2021', '18:00', 'observacao sa', 'S', 2),
(3, '19.09.2021', '13:30', '', 'N', 2);

INSERT INTO servico(id, descricao, preco) VALUES 
(1, 'unha', 10.00),
(2, 'cabelo', 25.00),
(3, 'unha pés', 9.00),
(4, 'hidratação', 20.00);

INSERT INTO produto VALUES
(1, 'UNI', 'Espátula', 5.52),
(2, 'ML', 'Esmalte', 15),
(3, 'UNI', 'Pincel', 20),
(4, 'KG', 'Algodão', 1);

INSERT INTO atendente VALUES
(1, 'Bruno'),
(2, 'Pagé'),
(3, 'Gau'),
(4, 'Moa');

INSERT INTO atendente_reserva (id, id_atendente, id_reserva) VALUES
(1, 3, 2),
(2, 2, 2),
(3, 4, 2),
(4, 1, 3),
(5, 1, 1),
(6, 4, 1);

INSERT INTO servico_reserva(id, id_servico, id_reserva, preco) VALUES
(1, 2, 1, 25.00),
(2, 4, 3, 35.99),
(3, 4, 2, 30.99),
(4, 1, 2, 25.60),
(5, 3, 3, 35.99);

INSERT INTO produto_reserva(id, id_produto, id_reserva, quantidade, preco) VALUES
(1, 4, 3, 10, 20.75),
(2, 3, 2, 1, 50.99),
(3, 3, 2, 4, 60.39),
(4, 1, 1, 9, 10.00);

-- algumas consultas

SELECT r.*, c.nome, c.telefone FROM reserva r 
	INNER JOIN cliente c on c.id = r.id_cliente

SELECT c.nome, c.telefone, r.dt_atendimento, r.hora FROM reserva r 
	INNER JOIN cliente c on c.id = r.id_cliente
WHERE r.atendido = 'N'

SELECT ar.*, a.nome FROM reserva r
INNER JOIN atendente_reserva ar ON ar.id_reserva = r.id
INNER JOIN atendente a ON a.id = ar.id_atendente
WHERE r.atendido = 'S'