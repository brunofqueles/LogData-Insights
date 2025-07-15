CREATE TABLE Logistica.Operacoes_TMS_Fonte (
    id_operacao INT IDENTITY(1,1) PRIMARY KEY, -- ID �nico para cada opera��o, auto-increment�vel
    id_cliente INT NOT NULL,                  -- ID do cliente (FK para Logistica.Clientes)
    id_transportadora INT NOT NULL,           -- ID da transportadora (FK para Logistica.Transportadoras)
    data_pedido DATETIME NOT NULL,            -- Data e hora em que o pedido foi registrado no TMS
    data_previsao_entrega DATE NOT NULL,      -- Data prevista para a entrega final
    data_entrega_real DATE,                   -- Data real da entrega (pode ser NULL se n�o entregue)
    origem_uf NVARCHAR(2) NOT NULL,           -- UF de origem da opera��o (ex: 'SP', 'RJ')
    origem_cidade NVARCHAR(100) NOT NULL,     -- Cidade de origem da opera��o
    destino_uf NVARCHAR(2) NOT NULL,          -- UF de destino da opera��o
    destino_cidade NVARCHAR(100) NOT NULL,    -- Cidade de destino da opera��o
    peso_kg DECIMAL(10, 2) NOT NULL,          -- Peso da mercadoria em KG
    volume_m3 DECIMAL(10, 4) NOT NULL,        -- Volume da mercadoria em metros c�bicos
    valor_frete DECIMAL(10, 2) NOT NULL,      -- Valor do frete da opera��o
    status_entrega_id INT NOT NULL,           -- ID do status atual da entrega (FK para Logistica.TiposOcorrencia)
    codigo_rastreio NVARCHAR(50) UNIQUE NOT NULL -- C�digo �nico de rastreio da opera��o

    -- Restri��es de Chave Estrangeira (Opcional, mas recomendado para integridade)
    -- As FKs abaixo podem ser adicionadas se as tabelas Logistica.Clientes,
    -- Logistica.Transportadoras e Logistica.TiposOcorrencia j� existirem.
    -- CONSTRAINT FK_OperacoesTMS_Cliente FOREIGN KEY (id_cliente) REFERENCES Logistica.Clientes(id_cliente),
    -- CONSTRAINT FK_OperacoesTMS_Transportadora FOREIGN KEY (id_transportadora) REFERENCES Logistica.Transportadoras(id_transportadora),
    -- CONSTRAINT FK_OperacoesTMS_Status FOREIGN KEY (status_entrega_id) REFERENCES Logistica.TiposOcorrencia(id_tipo_ocorrencia)
);