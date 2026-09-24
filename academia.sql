CREATE TABLE alunos(
id serial PRIMARY key,
nome VARCHAR(150) not null,
email VARCHAR(150) unique not null,
cpf VARCHAR(11) unique not null,
telefone VARCHAR(15) not null,
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

CREATE TABLE planos(
id serial PRIMARY key,
nome VARCHAR(150) not null,
valor_mensal_base NUMERIC(10,2) not null check(valor_mensal_base>0)
)


CREATE TABLE modalidades(
id serial PRIMARY key,
planos_id int not null,
FOREIGN KEY (planos_id) references planos(id),
sala varchar(50) not null,
capacidade_maxima int not null check(capacidade_maxima>0),
disponivel bool default TRUE
)

CREATE TABLE matriculas (
id serial PRIMARY key,
alunos_id int not null,
FOREIGN KEY (alunos_id) REFERENCES alunos(id),
data_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(15) DEFAULT 'ativa' CHECK(status in('ativa', 'cancelada', 'trancada'))

)

CREATE TABLE itens_matricula (
id serial PRIMARY key,
matriculas_id int not null,
FOREIGN KEY (matriculas_id) REFERENCES matriculas(id),
duracao_meses int not null check(duracao_meses>0),
valor_mensal_aplicado numeric(10,2) not null check(valor_mensal_aplicado>=0.00)

)



