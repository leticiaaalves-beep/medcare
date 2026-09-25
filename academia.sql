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
    id SERIAL PRIMARY KEY,
    matriculas_id INT REFERENCES matriculas(id),
    modalidades_id INT REFERENCES modalidades(id),
    duracao_meses INT CHECK (duracao_meses > 0) NOT NULL,
    valor_mensal_aplicado DECIMAL(10,2) CHECK (valor_mensal_aplicado > 0) NOT NULL,
    taxa_adesao DECIMAL(10,2) CHECK (taxa_adesao >= 0) DEFAULT 0.00 
	);

INSERT INTO alunos(nome, email,cpf, telefone) VALUES
('Claudia', 'caudia@gmail.com', '11122233344', '48999579091'),
('Robson', 'robson@gmail.com', '22233344455', '48999888777'),
('Renata', 'renata@gmail.com', '33344455566', '48777999666')

INSERT INTO planos(nome, valor_mensal_base) VALUES
('VIP prmium', 200.00),
('Basic fit', 140.00),
('Fitness standard', 170.00)

INSERT INTO modalidades(planos_id, sala, capacidade_maxima, disponivel) VALUES
(1, 'sala 1 ',100, true),
(2, 'sala 2 ',50, false),
(3, 'sala 5 ',100, true)

INSERT INTO matriculas(alunos_id, status ) VALUES
(1, 'ativa'),
(1, 'cancelada'),
(2, 'trancada'),
(3, 'ativa')

INSERT INTO itens_matricula (matriculas_id, modalidades_id, duracao_meses, valor_mensal_aplicado, taxa_adesao) VALUES 
(1, 1, 6, 220.00, 50.00),
(1, 2, 3, 140.00, 30.00),
(2, 3, 12, 90.00, 0.00),
(3, 1, 1, 220.00, 50.00);

ALTER TABLE modalidades
add column nome VARCHAR(100)

UPDATE modalidades
SET nome = 'pilates avançado' 
WHERE id = 1;

UPDATE modalidades
SET nome = 'crossfit pro' 
WHERE id = 2;

UPDATE modalidades
SET nome = 'musculação livre' 
WHERE id = 3;

CREATE VIEW vw_modalidades_custo_estimado as
SELECT 
modalidades.nome as modalidade,
modalidades.sala as sala,
planos.nome as plano,
round(planos.valor_mensal_base * 1.10 , 2) as mensalidade_ajustada 

FROM modalidades join planos on planos.id = modalidades.planos_id
order by mensalidade_ajustada DESC

SELECT * from vw_modalidades_custo_estimado


CREATE VIEW vw_matriculas_ativas AS
SELECT
alunos.nome as aluno,
alunos.cpf,
modalidades.nome as modalidades,
modalidades.sala as sala,
itens_matricula.duracao_meses,
matriculas.data_inicio

FROM matriculas join alunos ON alunos.id = matriculas.alunos_id
join itens_matricula on itens_matricula.id = matriculas.id
JOIN modalidades on modalidades.id = itens_matricula.modalidades_id
WHERE matriculas.status = 'ativa'


SELECT
modalidades.nome as modalidalidades,
modalidades.capacidade_maxima,
planos.valor_mensal_base

FROM modalidades join planos on planos.id = modalidades.planos_id
WHERE modalidades.capacidade_maxima >= 15
and planos.valor_mensal_base > 100
and modalidades.disponivel = true






