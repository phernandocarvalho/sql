CREATE OR REPLACE FUNCTION contar_clientes_por_data(data DATE)
RETURNS INT AS $$
DECLARE
    total_clientes INT;
BEGIN
    SELECT COUNT(*) INTO total_clientes
    FROM clientes
    WHERE data_cadastro = data;
    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;
