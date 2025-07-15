-- *************************************************************************************************************************
-- SEÇÃO DE DESCARTE DE TABELAS (na ordem inversa de dependência)
-- REMOVA OU COMENTE ESTAS LINHAS EM AMBIENTES DE PRODUÇÃO!
-- *************************************************************************************************************************

IF OBJECT_ID('Logistica.Operacoes', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.Operacoes;
END
GO

IF OBJECT_ID('Logistica.HistoricoOperacoes', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.HistoricoOperacoes;
END
GO

IF OBJECT_ID('Logistica.Clientes', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.Clientes;
END
GO

IF OBJECT_ID('Logistica.Transportadoras', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.Transportadoras;
END
GO

IF OBJECT_ID('Logistica.TiposOcorrencia', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.TiposOcorrencia;
END
GO

IF OBJECT_ID('Logistica.Regioes', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.Regioes;
END
GO

-- *************************************************************************************************************************
-- SEÇÃO DE CRIAÇÃO DE TABELAS (na ordem de dependência)
-- *************************************************************************************************************************

-- 1. Tabela Logistica.Regioes (CORRIGIDA: 'uf' agora é UNIQUE)
CREATE TABLE Logistica.Regioes (
    id_regiao INT PRIMARY KEY IDENTITY(1,1),
    nome_regiao VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL UNIQUE, -- <--- CORREÇÃO AQUI: Adicionado UNIQUE para permitir FKs
    capital VARCHAR(100) NOT NULL
);
GO

INSERT INTO Logistica.Regioes (nome_regiao, uf, capital) VALUES
('Sudeste', 'SP', 'São Paulo'),
('Sudeste', 'RJ', 'Rio de Janeiro'),
('Sudeste', 'MG', 'Belo Horizonte'),
('Sudeste', 'ES', 'Vitória');
GO

-- 2. Tabela Logistica.Clientes
CREATE TABLE Logistica.Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome_cliente VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    tipo_ecommerce VARCHAR(100) NOT NULL,
    contato_email VARCHAR(255) NULL,
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    cidade VARCHAR(100) NULL,
    uf VARCHAR(2) NULL, -- Esta UF pode ser uma FK para Logistica.Regioes no futuro, se necessário
    data_cadastro DATE NOT NULL DEFAULT GETDATE(),
    status_ativo BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO Logistica.Clientes (nome_cliente, cnpj, tipo_ecommerce, contato_email, telefone, endereco, cidade, uf) VALUES
('E-commerce Alpha', '00.000.000/0001-00', 'Eletrônicos', 'contato@ecomalpha.com.br', '(11) 98765-4321', 'Rua das Lojas, 123', 'São Paulo', 'SP'),
('Loja Virtual Beta', '11.111.111/0001-11', 'Moda', 'sac@lojabeta.com.br', '(21) 91234-5678', 'Av. Comércio, 456', 'Rio de Janeiro', 'RJ'),
('Varejo Online Gama', '22.222.222/0001-22', 'Alimentos', 'suporte@varejogama.com.br', '(31) 95555-4444', 'Praça Central, 789', 'Belo Horizonte', 'MG'),
('Livraria Digital', '33.333.333/0001-33', 'Livros', 'vendas@livros.com', '(11) 97777-1111', 'Av. Leitura, 10', 'São Paulo', 'SP'),
('Casa & Decor', '44.444.444/0001-44', 'Decoração', 'info@casadecor.com', '(21) 96666-2222', 'Rua dos Moveis, 20', 'Niterói', 'RJ'),
('Pet Shop Online', '55.555.555/0001-55', 'Pet Shop', 'atendimento@petshop.com', '(31) 94444-3333', 'R. dos Bichos, 30', 'Contagem', 'MG'),
('Fitness Store', '66.666.666/0001-66', 'Esportes', 'faleconosco@fitness.com', '(27) 93333-4444', 'Av. Treino, 40', 'Vitória', 'ES'),
('Jóias Finas', '77.777.777/0001-77', 'Jóias', 'vendas@joiasfinas.com', '(11) 92222-5555', 'Alameda Brilhante, 50', 'São Paulo', 'SP'),
('Ferramentas Online', '88.888.888/0001-88', 'Ferramentas', 'contato@ferramentas.com', '(21) 91111-6666', 'Rua da Obra, 60', 'Duque de Caxias', 'RJ'),
('Artesanato Brasil', '99.999.999/0001-99', 'Artesanato', 'info@artesanato.com', '(31) 90000-7777', 'R. dos Artesãos, 70', 'Juiz de Fora', 'MG');
GO

-- 3. Tabela Logistica.Transportadoras
CREATE TABLE Logistica.Transportadoras (
    id_transportadora INT PRIMARY KEY IDENTITY(1,1),
    nome_transportadora VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    tipo_transportadora VARCHAR(50) NOT NULL,
    contato_email VARCHAR(255) NULL,
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    cidade VARCHAR(100) NULL,
    uf VARCHAR(2) NULL, -- Esta UF pode ser uma FK para Logistica.Regioes no futuro, se necessário
    status_ativo BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO Logistica.Transportadoras (nome_transportadora, cnpj, tipo_transportadora, contato_email, telefone, endereco, cidade, uf) VALUES
('Expressa SP', '01.234.567/0001-01', 'Pequeno Porte', 'contato@expressa.com', '(11) 99887-7665', 'Rua das Entregas, 10', 'São Paulo', 'SP'),
('Rio Veloz', '02.345.678/0001-02', 'Médio Porte', 'comercial@rioveloz.com', '(21) 97766-5544', 'Av. dos Transportes, 20', 'Rio de Janeiro', 'RJ'),
('Minas Log', '03.456.789/0001-03', 'Pequeno Porte', 'vendas@minaslog.com', '(31) 96655-4433', 'R. da Logística, 30', 'Belo Horizonte', 'MG'),
('Sudeste Cargas', '04.567.890/0001-04', 'Médio Porte', 'sac@sudestecargas.com', '(27) 95544-3322', 'Travessa Frete, 40', 'Vitória', 'ES'),
('Fast Entrega', '05.678.901/0001-05', 'Pequeno Porte', 'contato@fastentrega.com', '(11) 94433-2211', 'Av. Rápida, 50', 'Campinas', 'SP');
GO

-- 4. Tabela Logistica.TiposOcorrencia
CREATE TABLE Logistica.TiposOcorrencia (
    id_tipo_ocorrencia INT PRIMARY KEY IDENTITY(1,1),
    descricao_ocorrencia VARCHAR(255) NOT NULL UNIQUE,
    categoria_ocorrencia VARCHAR(100) NOT NULL
);
GO

INSERT INTO Logistica.TiposOcorrencia (descricao_ocorrencia, categoria_ocorrencia) VALUES
('Atraso na Entrega', 'Atraso'),
('Extravio de Encomenda', 'Perda / Dano'),
('Avaria no Produto', 'Perda / Dano'),
('Destinatário Ausente', 'Reentrega'),
('Endereço Incorreto', 'Problema na Entrega'),
('Recusa da Mercadoria', 'Devolução'),
('Coleta Não Realizada', 'Problema na Coleta'),
('Roubo / Furto', 'Perda / Dano'),
('Restrição de Entrega', 'Problema na Entrega'),
('Coleta Realizada', 'Sucesso / Andamento'),
('Em Trânsito', 'Andamento'),
('Objeto em Rota de Entrega', 'Andamento'),
('Entrega Realizada', 'Sucesso'),
('Objeto Devolvido', 'Devolução'),
('Problema Fiscal', 'Problema na Entrega');
GO

-- 5. Tabela Logistica.HistoricoOperacoes
CREATE TABLE Logistica.HistoricoOperacoes (
    id_historico INT PRIMARY KEY IDENTITY(1,1),
    id_operacao INT NOT NULL, -- FK para Logistica.Operacoes (será criada posteriormente)
    data_hora_evento DATETIME NOT NULL DEFAULT GETDATE(),
    id_tipo_ocorrencia INT NOT NULL,
    local_evento VARCHAR(200) NULL,
    observacoes VARCHAR(500) NULL,

    CONSTRAINT FK_Historico_TipoOcorrencia FOREIGN KEY (id_tipo_ocorrencia)
    REFERENCES Logistica.TiposOcorrencia (id_tipo_ocorrencia)
);
GO

-- Inserir alguns dados de exemplo (id_operacao 1001 e 1002 são ilustrativos aqui)
INSERT INTO Logistica.HistoricoOperacoes (id_operacao, data_hora_evento, id_tipo_ocorrencia, local_evento, observacoes) VALUES
(1001, '2025-07-01 10:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'São Paulo / SP', 'Coleta bem-sucedida.'),
(1001, '2025-07-01 18:30:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Em Trânsito'), 'Campinas / SP', 'Saída da unidade de origem.'),
(1001, '2025-07-02 08:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Objeto em Rota de Entrega'), 'Rio de Janeiro / RJ', 'Objeto saiu para entrega final.'),
(1001, '2025-07-02 15:15:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Rio de Janeiro / RJ', 'Entrega finalizada com sucesso.'),
(1002, '2025-07-01 11:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'Belo Horizonte / MG', 'Coleta confirmada.'),
(1002, '2025-07-02 10:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Atraso na Entrega'), 'Belo Horizonte / MG', 'Chuvas fortes na rota.'),
(1002, '2025-07-03 14:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Vitória / ES', 'Entrega finalizada.');
GO

-- 6. Tabela Logistica.Operacoes (Última a ser criada, pois referencia todas as outras)
CREATE TABLE Logistica.Operacoes (
    id_operacao INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_transportadora INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    data_previsao_entrega DATE NULL,
    data_entrega_real DATE NULL,
    origem_uf VARCHAR(2) NOT NULL,
    origem_cidade VARCHAR(100) NOT NULL,
    destino_uf VARCHAR(2) NOT NULL,
    destino_cidade VARCHAR(100) NOT NULL,
    peso_kg DECIMAL(10,2) NOT NULL,
    volume_m3 DECIMAL(10,4) NULL,
    valor_frete DECIMAL(10,2) NOT NULL,
    status_entrega_id INT NOT NULL,
    codigo_rastreio VARCHAR(50) UNIQUE NOT NULL,

    CONSTRAINT FK_Operacoes_Cliente FOREIGN KEY (id_cliente)
    REFERENCES Logistica.Clientes (id_cliente),

    CONSTRAINT FK_Operacoes_Transportadora FOREIGN KEY (id_transportadora)
    REFERENCES Logistica.Transportadoras (id_transportadora),

    CONSTRAINT FK_Operacoes_OrigemUF FOREIGN KEY (origem_uf)
    REFERENCES Logistica.Regioes (uf), -- Referencia Regioes.uf

    CONSTRAINT FK_Operacoes_DestinoUF FOREIGN KEY (destino_uf)
    REFERENCES Logistica.Regioes (uf), -- Referencia Regioes.uf

    CONSTRAINT FK_Operacoes_StatusEntrega FOREIGN KEY (status_entrega_id)
    REFERENCES Logistica.TiposOcorrencia (id_tipo_ocorrencia)
);
GO

-- Inserir alguns dados de exemplo MINIMOS para testar a estrutura de Operacoes.
-- A carga massiva será feita com Python, conforme discutiremos na sequência.
INSERT INTO Logistica.Operacoes (id_cliente, id_transportadora, data_pedido, data_previsao_entrega, data_entrega_real, origem_uf, origem_cidade, destino_uf, destino_cidade, peso_kg, volume_m3, valor_frete, status_entrega_id, codigo_rastreio) VALUES
(
    (SELECT TOP 1 id_cliente FROM Logistica.Clientes ORDER BY NEWID()),
    (SELECT TOP 1 id_transportadora FROM Logistica.Transportadoras ORDER BY NEWID()),
    '2025-01-05 10:30:00',
    '2025-01-10',
    '2025-01-09',
    'SP',
    'Niterói', -- Cidade de origem (exemplo)
    'RJ',
    'Rio de Janeiro', -- Cidade de destino (exemplo)
    2.50,
    0.015,
    25.00,
    (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'),
    'LOGCONN001'
),
(
    (SELECT TOP 1 id_cliente FROM Logistica.Clientes ORDER BY NEWID()),
    (SELECT TOP 1 id_transportadora FROM Logistica.Transportadoras ORDER BY NEWID()),
    '2025-01-07 14:00:00',
    '2025-01-12',
    NULL,
    'MG',
    'Belo Horizonte',
    'SP',
    'Campinas',
    0.80,
    0.005,
    18.50,
    (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Em Trânsito'),
    'LOGCONN002'
);
GO