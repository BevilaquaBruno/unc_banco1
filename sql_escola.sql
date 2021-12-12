create database atv_escola_bruno;
use atv_escola_bruno;

-- tables
create table prova_trabalho (
	id int not null,
	descricao varchar(50) not null,
	datapt datetime,
	composicao tinyint not null,
	id_disciplina int not null
);

create table aluno (
	id int not null,
	nome varchar(50) not null,
	fone varchar(20),
	e_mail varchar(30) not null
);

create table frequencia (
	id int not null,
	dataf datetime not null,
	num_aulas smallint not null,
	id_aluno int not null,
	id_disciplina int not null
);

create table disciplina(
	id int not null,
	descricao varchar(50) not null,
	fase char(7),
	ch smallint,
	id_curso int not null
);

create table curso (
	id int not null,
	descricao varchar(50)
);

create table efetivado (
	id int not null,
	id_prova_trabalho int not null,
	id_aluno int not null,
	nota decimal(4,2)
);

create table matricula (
	id int not null,
	id_disciplina int not null,
	id_aluno int not null
);

-- primary keys 
alter table prova_trabalho add constraint pk_prova_trabalho primary key (id);
alter table aluno add constraint pk_aluno primary key (id);
alter table frequencia add constraint pk_frequencia primary key (id);
alter table disciplina add constraint pk_disciplina primary key (id);
alter table curso add constraint pk_curso primary key (id);
alter table efetivado add constraint pk_efetivado primary key (id);
alter table matricula add constraint pk_matricula primary key (id);

--foreign keys
alter table prova_trabalho add constraint fk_prova_trabalho_disciplina foreign key (id_disciplina) references disciplina(id);
alter table frequencia add constraint fk_frequencia_disciplina foreign key (id_disciplina) references disciplina(id); 
alter table frequencia add constraint fk_frequencia_aluno foreign key (id_aluno) references aluno(id);
alter table disciplina add constraint fk_disciplina_curso foreign key (id_curso) references curso(id);
alter table efetivado add constraint fk_efetivado_prova_trabalho foreign key (id_prova_trabalho) references prova_trabalho(id);
alter table efetivado add constraint fk_efetivado_aluno foreign key (id_aluno) references aluno(id);
alter table matricula add constraint fk_matricula_aluno foreign key (id_aluno) references aluno(id);
alter table matricula add constraint fk_matricula_disciplina foreign key (id_disciplina) references disciplina(id);