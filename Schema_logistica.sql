-- Verificar se o schema Logistica existe, caso contr�rio, cri�-lo
IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'Logistica')
BEGIN
    EXEC('CREATE SCHEMA Logistica');
END