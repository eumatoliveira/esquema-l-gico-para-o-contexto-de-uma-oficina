
-- Criação do banco de dados e tabelas para Oficina
CREATE DATABASE oficina;

USE oficina;

-- Tabela de Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

-- Tabela de Veículos
CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    modelo VARCHAR(100),
    placa VARCHAR(10) UNIQUE,
    cor VARCHAR(20),
    ano INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela de Serviços
CREATE TABLE Servicos (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255),
    preco DECIMAL(10, 2)
);

-- Tabela de Peças
CREATE TABLE Pecas (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10, 2),
    quantidade INT
);

-- Tabela de Agendamentos
CREATE TABLE Agendamentos (
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_veiculo INT,
    id_servico INT,
    data_agendamento DATE,
    hora_agendamento TIME,
    status ENUM('Pendente', 'Em andamento', 'Concluído') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo),
    FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
);

-- Tabela de Pagamentos
CREATE TABLE Pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_agendamento INT,
    valor DECIMAL(10, 2),
    data_pagamento DATE,
    metodo_pagamento ENUM('Cartão', 'Dinheiro', 'Transferência', 'Boleto') NOT NULL,
    FOREIGN KEY (id_agendamento) REFERENCES Agendamentos(id_agendamento)
);

-- Inserção de dados exemplo para testes
INSERT INTO Clientes (nome, tipo_cliente, cpf_cnpj, email, telefone, endereco) VALUES
('João Silva', 'PF', '123.456.789-00', 'joao@email.com', '11987654321', 'Rua A, 123'),
('Maria Santos', 'PJ', '12.345.678/0001-00', 'maria@empresa.com', '1122334455', 'Rua B, 456');

INSERT INTO Veiculos (id_cliente, modelo, placa, cor, ano) VALUES
(1, 'Fusca', 'ABC-1234', 'Azul', 1985),
(2, 'Fiat Palio', 'XYZ-9876', 'Branco', 2015);

INSERT INTO Servicos (descricao, preco) VALUES
('Troca de Óleo', 100.00),
('Alinhamento e Balanceamento', 150.00);

INSERT INTO Pecas (nome, preco, quantidade) VALUES
('Filtro de Óleo', 25.00, 10),
('Pneu', 200.00, 5);

INSERT INTO Agendamentos (id_cliente, id_veiculo, id_servico, data_agendamento, hora_agendamento, status) VALUES
(1, 1, 1, '2025-03-10', '09:00:00', 'Pendente'),
(2, 2, 2, '2025-03-12', '14:00:00', 'Pendente');

INSERT INTO Pagamentos (id_agendamento, valor, data_pagamento, metodo_pagamento) VALUES
(1, 100.00, '2025-03-10', 'Dinheiro');
