CREATE TABLE Logistica.Operacoes_TMS_Fonte (
    id_operacao INT IDENTITY(1,1) PRIMARY KEY, -- ID único para cada operação, auto-incrementável
    id_cliente INT NOT NULL,                  -- ID do cliente (FK para Logistica.Clientes)
    id_transportadora INT NOT NULL,           -- ID da transportadora (FK para Logistica.Transportadoras)
    data_pedido DATETIME NOT NULL,            -- Data e hora em que o pedido foi registrado no TMS
    data_previsao_entrega DATE NOT NULL,      -- Data prevista para a entrega final
    data_entrega_real DATE,                   -- Data real da entrega (pode ser NULL se não entregue)
    origem_uf NVARCHAR(2) NOT NULL,           -- UF de origem da operação (ex: 'SP', 'RJ')
    origem_cidade NVARCHAR(100) NOT NULL,     -- Cidade de origem da operação
    destino_uf NVARCHAR(2) NOT NULL,          -- UF de destino da operação
    destino_cidade NVARCHAR(100) NOT NULL,    -- Cidade de destino da operação
    peso_kg DECIMAL(10, 2) NOT NULL,          -- Peso da mercadoria em KG
    volume_m3 DECIMAL(10, 4) NOT NULL,        -- Volume da mercadoria em metros cúbicos
    valor_frete DECIMAL(10, 2) NOT NULL,      -- Valor do frete da operação
    status_entrega_id INT NOT NULL,           -- ID do status atual da entrega (FK para Logistica.TiposOcorrencia)
    codigo_rastreio NVARCHAR(50) UNIQUE NOT NULL -- Código único de rastreio da operação

    -- Restrições de Chave Estrangeira (Opcional, mas recomendado para integridade)
    -- As FKs abaixo podem ser adicionadas se as tabelas Logistica.Clientes,
    -- Logistica.Transportadoras e Logistica.TiposOcorrencia já existirem.
    -- CONSTRAINT FK_OperacoesTMS_Cliente FOREIGN KEY (id_cliente) REFERENCES Logistica.Clientes(id_cliente),
    -- CONSTRAINT FK_OperacoesTMS_Transportadora FOREIGN KEY (id_transportadora) REFERENCES Logistica.Transportadoras(id_transportadora),
    -- CONSTRAINT FK_OperacoesTMS_Status FOREIGN KEY (status_entrega_id) REFERENCES Logistica.TiposOcorrencia(id_tipo_ocorrencia)
);