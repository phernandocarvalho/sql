CREATE DATABASE EmpresaDB;


CREATE TABLE Funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_admissao DATE NOT NULL
);

CREATE TABLE Departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Funcionario_Departamento (
    funcionario_id INT,
    departamento_id INT,
    PRIMARY KEY (funcionario_id, departamento_id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id),
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id)
);

CREATE TABLE Auditoria_Salario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT,
    salario_antigo DECIMAL(10, 2),
    salario_novo DECIMAL(10, 2),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id)
);

DELIMITER //

CREATE TRIGGER Salario_Audit_Trigger
AFTER UPDATE ON Funcionarios
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO Auditoria_Salario (funcionario_id, salario_antigo, salario_novo)
        VALUES (OLD.id, OLD.salario, NEW.salario);
    END IF;
END;
//

DELIMITER ;
