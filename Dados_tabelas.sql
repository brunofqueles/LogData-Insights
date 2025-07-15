-- Inserir os dados da região Sudeste com as respectivas capitais
INSERT INTO Logistica.Regioes (nome_regiao, uf, capital) VALUES
('Sudeste', 'SP', 'São Paulo'),
('Sudeste', 'RJ', 'Rio de Janeiro'),
('Sudeste', 'MG', 'Belo Horizonte'),
('Sudeste', 'ES', 'Vitória');

-- Inserir os 10 clientes de exemplo com seus respectivos tipos de e-commerce
INSERT INTO Logistica.Clientes (nome_cliente, cnpj, tipo_ecommerce, contato_email, telefone, endereco, cidade, uf) VALUES
('E-commerce Alpha', '00.000.000/0001-00', 'Eletrônicos', 'contato@ecomalpha.com.br', '(11) 98765-4321', 'Rua das Lojas, 123', 'São Paulo', 'SP'),
('Loja Virtual Beta', '11.111.111/0001-11', 'Moda', 'sac@lojabeta.com.br', '(21) 91234-5678', 'Av. Comércio, 456', 'Rio de Janeiro', 'RJ'),
('Varejo Online Gama', '22.222.222/0001-22', 'Eletrônicos', 'suporte@varejogama.com.br', '(31) 95555-4444', 'Praça Central, 789', 'Belo Horizonte', 'MG'),
('Livraria Digital', '33.333.333/0001-33', 'Livros', 'vendas@livros.com', '(11) 97777-1111', 'Av. Leitura, 10', 'São Paulo', 'SP'),
('Casa & Decor', '44.444.444/0001-44', 'Decoração', 'info@casadecor.com', '(21) 96666-2222', 'Rua dos Moveis, 20', 'Niterói', 'RJ'),
('Pet Shop Online', '55.555.555/0001-55', 'Moda', 'atendimento@petshop.com', '(31) 94444-3333', 'R. dos Bichos, 30', 'Contagem', 'MG'),
('Fitness Store', '66.666.666/0001-66', 'Esportes', 'faleconosco@fitness.com', '(27) 93333-4444', 'Av. Treino, 40', 'Vitória', 'ES'),
('Jóias Finas', '77.777.777/0001-77', 'Eletrônicos', 'vendas@joiasfinas.com', '(11) 92222-5555', 'Alameda Brilhante, 50', 'São Paulo', 'SP'),
('Ferramentas Online', '88.888.888/0001-88', 'Ferramentas', 'contato@ferramentas.com', '(21) 91111-6666', 'Rua da Obra, 60', 'Duque de Caxias', 'RJ'),
('Artesanato Brasil', '99.999.999/0001-99', 'Eletrônicos', 'info@artesanato.com', '(31) 90000-7777', 'R. dos Artesãos, 70', 'Juiz de Fora', 'MG');

-- Inserir os 5 exemplos de transportadoras com seus tipos de porte
INSERT INTO Logistica.Transportadoras (nome_transportadora, cnpj, tipo_transportadora, contato_email, telefone, endereco, cidade, uf) VALUES
('Expressa SP', '01.234.567/0001-01', 'Médio Porte', 'contato@expressa.com', '(11) 99887-7665', 'Rua das Entregas, 10', 'São Paulo', 'SP'),
('Rio Veloz', '02.345.678/0001-02', 'Médio Porte', 'comercial@rioveloz.com', '(21) 97766-5544', 'Av. dos Transportes, 20', 'Rio de Janeiro', 'RJ'),
('Minas Log', '03.456.789/0001-03', 'Médio Porte', 'vendas@minaslog.com', '(31) 96655-4433', 'R. da Logística, 30', 'Belo Horizonte', 'MG'),
('Sudeste Cargas', '04.567.890/0001-04', 'Médio Porte', 'sac@sudestecargas.com', '(27) 95544-3322', 'Travessa Frete, 40', 'Vitória', 'ES'),
('Fast Entrega', '05.678.901/0001-05', 'Pequeno Porte', 'contato@fastentrega.com', '(11) 94433-2211', 'Av. Rápida, 50', 'Campinas', 'SP');

-- Inserir os tipos de ocorrência de exemplo
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
('Entrega Realizada', 'Sucesso'); -- Incluir um "status final" positivo para referência

-- Inserir alguns dados de exemplo (assumindo que id_operacao 1001 e 1002 existiriam na tabela Operacoes)
-- E que os ids dos TiposOcorrencia correspondem à tabela TiposOcorrencia (ex: 10 para 'Entrega Realizada')
-- **IMPORTANTE**: Você precisará ajustar os id_tipo_ocorrencia com base nos IDs gerados na sua tabela real.
-- Para esta simulação, estou usando IDs que correspondem à ordem da inserção na query de TiposOcorrencia.
-- 1: Atraso na Entrega, 2: Extravio de Encomenda, ..., 10: Entrega Realizada
INSERT INTO Logistica.HistoricoOperacoes (id_operacao, data_hora_evento, id_tipo_ocorrencia, local_evento, observacoes) VALUES
(1001, '2025-07-01 10:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Não Realizada'), 'São Paulo / SP', 'Tentativa de coleta falhou por ausência.'), -- Exemplo de coleta não realizada
(1001, '2025-07-01 14:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'São Paulo / SP', 'Coleta bem-sucedida em segunda tentativa.'),
(1001, '2025-07-01 20:30:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Em Trânsito'), 'Campinas / SP', 'Saída da unidade de origem - SP'),
(1001, '2025-07-02 09:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Em Trânsito'), 'Rio de Janeiro / RJ', 'Chegada na unidade de destino - RJ'),
(1001, '2025-07-02 16:30:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Rio de Janeiro / RJ', 'Entrega finalizada com sucesso.'),

(1002, '2025-07-01 11:30:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Coleta Realizada'), 'Belo Horizonte / MG', 'Coleta confirmada.'),
(1002, '2025-07-02 15:00:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Atraso na Entrega'), 'Juiz de Fora / MG', 'Atraso devido a problemas mecânicos no veículo.'),
(1002, '2025-07-03 16:45:00', (SELECT id_tipo_ocorrencia FROM Logistica.TiposOcorrencia WHERE descricao_ocorrencia = 'Entrega Realizada'), 'Vitória / ES', 'Entrega finalizada.');
