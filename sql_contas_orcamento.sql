CREATE DATABASE sql_inicial;
GO
USE sql_inicial;
GO
/*
	DDL - Data Definition Language - metadado = estrutura do banco de dados
	Comandos: CREATE, ALTER E DROP = ANSI/92
	Criados: TABLES, CONSTRAINTS, TRIGGERS, VIEWS E PROCEDURES

	DML - Data Manipulation Language
	Comandos: SELECT, UPDATE, DELETE, INSERT
	PLSQL - Program Language SQL --PROCEDURES, TRIGGERS

	TRANSACT-SQL = PLSQL DO SQL SERVER
*/


CREATE TABLE grupo (
	id_grupo SMALLINT NOT NULL,
	descricao_grupo VARCHAR(40)
);

CREATE TABLE subgrupo (
	id_sub SMALLINT NOT NULL,
	descricao_sub VARCHAR(40),
	id_grupo SMALLINT
);

-- ALTER TABLE subgrupo ADD id_grupo SMALLINT;
-- ALTER TABLE subgrupo DROP id_grupo;
-- DROP TABLE subgrupo;

CREATE TABLE conta (
	id_conta SMALLINT NOT NULL,
	desc_conta VARCHAR(40),
	tipo CHAR(1),
	id_subgrupo SMALLINT NOT NULL
);

CREATE TABLE orcamento (
	mes_ano CHAR(6) NOT NULL,
	valor NUMERIC(18,2),
	id_conta SMALLINT NOT NULL
);

CREATE TABLE realizado (
	id_realizado INT NOT NULL,
	datar SMALLDATETIME DEFAULT GETDATE(),
	valor NUMERIC(18,2) DEFAULT 0,
	obs VARCHAR(100),
	id_conta SMALLINT NOT NULL
);

-- PRIMARY KEYS
ALTER TABLE grupo
	ADD CONSTRAINT pk_grupo
		PRIMARY KEY (id_grupo);

ALTER TABLE subgrupo 
	ADD CONSTRAINT pk_subgrupo
		PRIMARY KEY (id_sub);

ALTER TABLE conta
	ADD CONSTRAINT pk_conta
		PRIMARY KEY (id_conta);

ALTER TABLE orcamento
	ADD CONSTRAINT pk_orcamento
		PRIMARY KEY (mes_ano, id_conta);

ALTER TABLE realizado 
	ADD CONSTRAINT pk_realizado
		PRIMARY KEY (id_realizado);

-- FOREIGN KEYS - FK
ALTER TABLE subgrupo
	ADD CONSTRAINT fk_grupo_subgrupo
		FOREIGN KEY (id_grupo)
			REFERENCES grupo (id_grupo);

ALTER TABLE conta 
	ADD CONSTRAINT fk_subgrupo_conta
		FOREIGN KEY (id_subgrupo)
			REFERENCES subgrupo (id_sub)

ALTER TABLE orcamento 
	ADD CONSTRAINT fk_conta_orcamento
		FOREIGN KEY (id_conta)
			REFERENCES conta (id_conta);

ALTER TABLE realizado
	ADD CONSTRAINT fk_conta_realizado
		FOREIGN KEY (id_conta)
			REFERENCES conta (id_conta);