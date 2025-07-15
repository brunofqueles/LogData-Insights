-- Criar a tabela Regioes dentro do schema Logistica
CREATE TABLE Logistica.Regioes (
    id_regiao INT PRIMARY KEY IDENTITY(1,1), -- Chave primária auto-incrementável
    nome_regiao VARCHAR(100) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    capital VARCHAR(100) NOT NULL
);

-- Criar a tabela Clientes dentro do schema Logistica
CREATE TABLE Logistica.Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome_cliente VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    tipo_ecommerce VARCHAR(100) NOT NULL, 
    contato_email VARCHAR(255) NULL,
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    cidade VARCHAR(100) NULL,
    uf VARCHAR(2) NULL,
    data_cadastro DATE NOT NULL DEFAULT GETDATE(),
    status_ativo BIT NOT NULL DEFAULT 1
);

-- Criar a tabela Transportadoras dentro do schema Logistica
CREATE TABLE Logistica.Transportadoras (
    id_transportadora INT PRIMARY KEY IDENTITY(1,1),
    nome_transportadora VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    tipo_transportadora VARCHAR(50) NOT NULL, -- Nova coluna para o porte da transportadora
    contato_email VARCHAR(255) NULL,
    telefone VARCHAR(20) NULL,
    endereco VARCHAR(255) NULL,
    cidade VARCHAR(100) NULL,
    uf VARCHAR(2) NULL, -- Pode ser uma FK para Logistica.Regioes no futuro
    status_ativo BIT NOT NULL DEFAULT 1 -- 1 para ativo, 0 para inativo
);
-- Criar a tabela TiposOcorrencia dentro do schema Logistica
CREATE TABLE Logistica.TiposOcorrencia (
    id_tipo_ocorrencia INT PRIMARY KEY IDENTITY(1,1),
    descricao_ocorrencia VARCHAR(255) NOT NULL UNIQUE, -- Descrição única para cada tipo
    categoria_ocorrencia VARCHAR(100) NOT NULL
);
-- Criar a tabela HistoricoOperacoes dentro do schema Logistica
CREATE TABLE Logistica.HistoricoOperacoes (
    id_historico INT PRIMARY KEY IDENTITY(1,1),
    id_operacao INT NOT NULL, -- FK para Logistica.Operacoes (será criada posteriormente)
    data_hora_evento DATETIME NOT NULL DEFAULT GETDATE(), -- Data e hora do evento
    id_tipo_ocorrencia INT NOT NULL, -- FK para Logistica.TiposOcorrencia
    local_evento VARCHAR(200) NULL, -- Ex: "São Paulo / SP"
    observacoes VARCHAR(500) NULL,
	    -- Definição da Chave Estrangeira para TiposOcorrencia
    CONSTRAINT FK_Historico_TipoOcorrencia FOREIGN KEY (id_tipo_ocorrencia)
    REFERENCES Logistica.TiposOcorrencia (id_tipo_ocorrencia)
    -- NOTA: A FK para Logistica.Operacoes será adicionada na criação da tabela Operacoes,
    -- ou por um ALTER TABLE após a criação de Operacoes, para evitar dependência circular.
);

-- 1. Descartar Logistica.HistoricoOperacoes (pois ela referencia Logistica.TiposOcorrencia)
IF OBJECT_ID('Logistica.HistoricoOperacoes', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.HistoricoOperacoes;
END
GO

-- 2. Descartar Logistica.TiposOcorrencia (agora que nenhuma tabela a referencia mais)
IF OBJECT_ID('Logistica.TiposOcorrencia', 'U') IS NOT NULL
BEGIN
    DROP TABLE Logistica.TiposOcorrencia;
END
GO

-- *************************************************************************************************************************
-- ORDEM CORRETA DE CRIAÇÃO: Tabelas que SÃO REFERENCIADAS (contêm PKs) devem ser criadas ANTES das tabelas que CONTÊM FKs.
-- *************************************************************************************************************************

-- 1. Criar a tabela TiposOcorrencia dentro do schema Logistica
CREATE TABLE Logistica.TiposOcorrencia (
    id_tipo_ocorrencia INT PRIMARY KEY IDENTITY(1,1),
    descricao_ocorrencia VARCHAR(255) NOT NULL UNIQUE,
    categoria_ocorrencia VARCHAR(100) NOT NULL
);
GO

-- Inserir os tipos de ocorrência corrigidos e ampliados
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

-- Opcional: Visualizar os dados inseridos para confirmar
SELECT * FROM Logistica.TiposOcorrencia;
GO

-- 2. Criar a tabela HistoricoOperacoes dentro do schema Logistica (agora que TiposOcorrencia já existe)
CREATE TABLE Logistica.HistoricoOperacoes (
    id_historico INT PRIMARY KEY IDENTITY(1,1),
    id_operacao INT NOT NULL, -- FK para Logistica.Operacoes (será criada posteriormente)
    data_hora_evento DATETIME NOT NULL DEFAULT GETDATE(),
    id_tipo_ocorrencia INT NOT NULL, -- FK para Logistica.TiposOcorrencia
    local_evento VARCHAR(200) NULL,
    observacoes VARCHAR(500) NULL,

    -- Definição da Chave Estrangeira para TiposOcorrencia
    CONSTRAINT FK_Historico_TipoOcorrencia FOREIGN KEY (id_tipo_ocorrencia)
    REFERENCES Logistica.TiposOcorrencia (id_tipo_ocorrencia)
);
GO

-- Inserir alguns dados de exemplo (assumindo que id_operacao 1001 e 1002 existiriam na tabela Operacoes)
-- Usando subconsultas para garantir que os IDs de id_tipo_ocorrencia sejam válidos
INSERT INTO Logistica.HistoricoOperacoes (id_operacao, data_hora_evento, id_tipo_ocorrencia, local_evento, observacoes) VALUES
(1001, '2025-07-01 10:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'São Paulo / SP', 'Coleta bem-sucedida.'),
(1001, '2025-07-01 18:30:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Em Trânsito'), 'Campinas / SP', 'Saída da unidade de origem.'),
(1001, '2025-07-02 08:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Objeto em Rota de Entrega'), 'Rio de Janeiro / RJ', 'Objeto saiu para entrega final.'),
(1001, '2025-07-02 15:15:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Rio de Janeiro / RJ', 'Entrega finalizada com sucesso.'),

(1002, '2025-07-01 11:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'Belo Horizonte / MG', 'Coleta confirmada.'),
(1002, '2025-07-02 10:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Atraso na Entrega'), 'Belo Horizonte / MG', 'Chuvas fortes na rota.'),
(1002, '2025-07-03 14:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Vitória / ES', 'Entrega finalizada.');


-- Criar a tabela Operacoes dentro do schema Logistica
CREATE TABLE Logistica.Operacoes (
    id_operacao INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_transportadora INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    data_previsao_entrega DATE NULL,
    data_entrega_real DATE NULL, -- Pode ser NULL se ainda não entregue
    origem_uf VARCHAR(2) NOT NULL,
    origem_cidade VARCHAR(100) NOT NULL,
    destino_uf VARCHAR(2) NOT NULL,
    destino_cidade VARCHAR(100) NOT NULL,
    peso_kg DECIMAL(10,2) NOT NULL,
    volume_m3 DECIMAL(10,4) NULL, -- Volume em metros cúbicos, com mais casas decimais
    valor_frete DECIMAL(10,2) NOT NULL,
    status_entrega_id INT NOT NULL, -- FK para TiposOcorrencia (status atual)
    codigo_rastreio VARCHAR(50) UNIQUE NOT NULL,

    -- Definição das Chaves Estrangeiras
    CONSTRAINT FK_Operacoes_Cliente FOREIGN KEY (id_cliente)
    REFERENCES Logistica.Clientes (id_cliente),

    CONSTRAINT FK_Operacoes_Transportadora FOREIGN KEY (id_transportadora)
    REFERENCES Logistica.Transportadoras (id_transportadora),

    -- FKs para UF de origem e destino (assumindo que Regioes.uf é UNIQUE)
    CONSTRAINT FK_Operacoes_OrigemUF FOREIGN KEY (origem_uf)
    REFERENCES Logistica.Regioes (uf),

    CONSTRAINT FK_Operacoes_DestinoUF FOREIGN KEY (destino_uf)
    REFERENCES Logistica.Regioes (uf),

    CONSTRAINT FK_Operacoes_StatusEntrega FOREIGN KEY (status_entrega_id)
    REFERENCES Logistica.TiposOcorrencia (id_tipo_ocorrencia)
);