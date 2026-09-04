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





