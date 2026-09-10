CREATE TABLE pacientes (
id serial primary key,
nome VARCHAR(150) not null,
email VARCHAR(150) unique not null,
cpf VARCHAR(11) unique not null,
data_nascimento date not null,
data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

)

CREATE TABLE especialidades (
id serial primary key,
nome VARCHAR(150) unique not null

)

CREATE TABLE medicos (
id serial primary key,
especialidade_id int not null,
FOREIGN key (especialidade_id) REFERENCES medicos(id),
nome VARCHAR(150) unique not null,
crm VARCHAR(150) unique not null,
valor_consulta numeric(10,2) not null check (valor_consulta>0)

)

CREATE TABLE consultas (
id serial primary key,
medicos_id int not null,
FOREIGN key (medicos_id) REFERENCES medicos(id),
pacientes_id int not null,
FOREIGN key (pacientes_id) REFERENCES pacientes(id),
data_hora varchar(20) not null,
status VARCHAR(20) DEFAULT 'Agendada' CHECK (status IN ('Agendada', 'Realizada', 'Cancelada'))


)

CREATE TABLE exames_consultas (
id serial primary key,
consultas_id int not null,
FOREIGN KEY (consultas_id) REFERENCES consultas(id),
nome_exame varchar(150) not null,
valor_exame numeric(10,2) not null check(valor_exame>0)

)

insert into especialidades (nome) VALUES
('pediatria'),
('cardiologia'),
('dermatologia')

select * from especialidades

insert into medicos(especialidade_id, nome, crm,valor_consulta) VALUES
(1, 'Claudia', '12345', 150.00),
(2, 'Flavio', '54321', 200.00),
(3, 'Jade', '12233', 250.00)

select * from medicos

INSERT into pacientes(nome, email, cpf, data_nascimento,data_cadastro) VALUES
('Roberta', 'roberta@gmail.com', 11122233355, '08-05-2020', '01-08-2026'),
('Debora', 'debora@gmail.com', 22233344466, '09-04-2000', '28-08-2026'),
('João', 'joao@gmail.com', 33355566677, '15-10-2006', '30-08-2026')

select * from pacientes

INSERT INTO consultas(medicos_id, pacientes_id,data_hora,status) VALUES
(1,1,'28-08-2026','Realizada'),
(1,1,'29-08-2026','Realizada'),
(2,2,'12-09-2026', 'Agendada'),
(3,3,'02-09-2026', 'Cancelada')

select * from consultas

 INSERT INTO exames_consultas(consultas_id, nome_exame, valor_exame) VALUES
(6, 'cardiologia', 250.00),
(7, 'dermatologia', 200.00),
(8, 'pediatria', 300.00),
(9, 'cardiologia', 250.00)

select * from exames_consultas

SELECT
m.nome as medico,
m.crm,
e.nome as especialidades,
m.valor_consulta
FROM medicos m
JOIN especialidades e ON m.especialidade_id = e.id
ORDER BY m.valor_consulta DESC;

SELECT
c.id as consultas_id,
c.data_hora,
m.nome as medico,
e.nome as especialidades,
c.status
FROM consultas c
JOIN pacientes p ON c.pacientes_id = p.id
JOIN medicos m ON c.medicos_id = m.id
JOIN especialidades e ON m.especialidade_id = e.id
WHERE p.nome = 'Roberta';

SELECT
    c.id AS consulta_id,
    p.nome AS paciente,
    m.nome AS medico,
    m.valor_consulta + COALESCE(SUM(ec.valor_exame), 0) AS valor_total
FROM consultas c
JOIN pacientes p ON c.pacientes_id = p.id
JOIN medicos m ON c.medicos_id = m.id
LEFT JOIN exames_consultas ec ON c.id = ec.consultas_id
GROUP BY c.id, p.nome, m.nome, m.valor_consulta
ORDER BY c.id;







