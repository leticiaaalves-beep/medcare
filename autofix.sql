CREATE TABLE clientes(
id serial PRIMARY key,
nome varchar(150) not null,
email varchar(150) unique not null,
telefone varchar(11) not null,
cpf VARCHAR(11) unique not null,
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

)

CREATE TABLE mecanicos(
id serial PRIMARY key,
nome varchar(150) not null,
especialidade VARCHAR(100) not null,
valor_hora NUMERIC(10,2) not null

)

CREATE TABLE veiculos(
id serial PRIMARY key,
clientes_id int NOT null,
FOREIGN KEY (clientes_id) REFERENCES clientes(id),
placa varchar(7) unique not null,
modelo VARCHAR(100) not null,
marca VARCHAR(100) not null,
ano INT
)

CREATE TABLE ordens_servico(
id serial PRIMARY key,
veiculos_id int NOT null,
FOREIGN KEY (veiculos_id) REFERENCES veiculos(id),
mecanicos_id int not null,
FOREIGN KEY (mecanicos_id) REFERENCES mecanicos(id),
data_abertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
valor_mao_obra NUMERIC(10,2) not null check(valor_mao_obra>=0),
status varchar(25) DEFAULT 'Em aberto' CHECK(status in('Em Aberto', 'Em Andamento', 'Concluida', 'Cancelada'))
)

CREATE TABLE pecas_ordemservico(
id serial PRIMARY key,
ordemservico_id int NOT null,
FOREIGN KEY (ordemservico_id) REFERENCES ordens_servico(id),
nome_peca varchar(50) not null,
quantidade int not null check(quantidade>0),
valor_unitario numeric(10,2) not null check(valor_unitario>0)
)

INSERT INTO clientes(nome, email,telefone,cpf) VALUES
('claudio', 'claudio@gmail.com','48999999999', '11122233344'),
('robson', 'robson@gmail.com','4888888888', '22233344455'),
('valeria', 'valeria@gmail.com','48777777777', '33344455566')

SELECT * from clientes

INSERT INTO mecanicos(nome, especialidade, valor_hora) VALUES
('fernando', 'eletrica', 300.00),
('ramon', 'motor', 500.00),
('gabriel', 'eletrica', 300.00)

SELECT * from mecanicos

INSERT INTO veiculos(clientes_id, placa, modelo, marca, ano) VALUES
(1, 'ABC1D12', 'HB20', 'HYUNDAI', 2019),
(2, 'CDE1D16', 'CIVIC', 'HONDA', 2020),
(3, 'ABC1F99', '320I', 'BMW', 2024)

INSERT INTO ordens_servico(veiculos_id, mecanicos_id, valor_mao_obra, status) VALUES
(1, 2, 200.00 , 'Em Aberto'),
(2, 3, 400.00 , 'Em Andamento'),
(3, 1, 350.00 , 'Concluida')

INSERT INTO pecas_ordemservico(ordemservico_id, nome_peca, quantidade, valor_unitario) VALUES
(2, 'motor', 10, 150.00),
(7, 'pneu', 100, 200.00),
(8, 'freio', 30, 100.00)

 SELECT
 veiculos.marca,
 veiculos.modelo,
 veiculos.placa,
 clientes.nome,
 clientes.telefone
 from veiculos join clientes ON clientes.id = veiculos.clientes_id 



SELECT
veiculos.placa,
veiculos.modelo,
ordens_servico.status,
mecanicos.nome,
clientes.nome,
ordens_servico.id,
ordens_servico.data_abertura

FROM veiculos join ordens_servico on veiculos.id = ordens_servico.veiculos_id
JOIN clientes ON clientes.id = veiculos.clientes_id
JOIN mecanicos on mecanicos.id = ordens_servico.mecanicos_id
WHERE clientes.nome = 'claudio' order by ordens_servico.data_abertura

SELECT
    ordens_servico.id,
    veiculos.placa,
    mecanicos.nome,
    ordens_servico.valor_mao_obra,
    ordens_servico.valor_mao_obra + COALESCE(SUM(pecas_ordemservico.quantidade * pecas_ordemservico.valor_unitario), 0)
FROM ordens_servico
JOIN veiculos ON veiculos.id = ordens_servico.veiculos_id
JOIN mecanicos ON mecanicos.id = ordens_servico.mecanicos_id
LEFT JOIN pecas_ordemservico ON pecas_ordemservico.ordemservico_id = ordens_servico.id
GROUP BY ordens_servico.id, veiculos.placa, mecanicos.nome, ordens_servico.valor_mao_obra
ORDER BY ordens_servico.id

SELECT
    nome,
    valor_hora
FROM mecanicos
WHERE valor_hora > 90.00

SELECT
    mecanicos.especialidade,
    SUM(ordens_servico.valor_mao_obra)
FROM mecanicos
JOIN ordens_servico
ON mecanicos.id = ordens_servico.mecanicos_id
WHERE ordens_servico.status = 'Concluida'
GROUP BY mecanicos.especialidade



