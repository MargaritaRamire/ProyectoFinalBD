/* =========================================================
   CREACIÓN DE TABLAS
   ========================================================= */

-- Tabla de Gastos
CREATE TABLE tbl_expenses (
    expense_id INT PRIMARY KEY IDENTITY(1,1),
    expense_type_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    description NVARCHAR(255),
    expense_date DATE NOT NULL,
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Roles
CREATE TABLE tbl_roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
GO


/* =========================================================
   PROCEDIMIENTOS PARA tbl_expenses
   ========================================================= */

-- Insertar gasto
CREATE PROCEDURE sp_tbl_expenses_insert
    @expense_type_id INT,
    @amount DECIMAL(10,2),
    @description NVARCHAR(255),
    @expense_date DATE
AS
BEGIN
    INSERT INTO tbl_expenses (expense_type_id, amount, description, expense_date)
    VALUES (@expense_type_id, @amount, @description, @expense_date);
END;
GO

-- Modificar gasto
CREATE PROCEDURE sp_tbl_expenses_update
    @expense_id INT,
    @expense_type_id INT,
    @amount DECIMAL(10,2),
    @description NVARCHAR(255),
    @expense_date DATE
AS
BEGIN
    UPDATE tbl_expenses
    SET expense_type_id = @expense_type_id,
        amount = @amount,
        description = @description,
        expense_date = @expense_date
    WHERE expense_id = @expense_id;
END;
GO

-- Listar todos los gastos
CREATE PROCEDURE sp_tbl_expenses_get_all
AS
BEGIN
    SELECT * FROM tbl_expenses;
END;
GO

-- Ver gasto por ID
CREATE PROCEDURE sp_tbl_expenses_get_by_id
    @expense_id INT
AS
BEGIN
    SELECT * FROM tbl_expenses WHERE expense_id = @expense_id;
END;
GO

-- Eliminar gasto
CREATE PROCEDURE sp_tbl_expenses_delete
    @expense_id INT
AS
BEGIN
    DELETE FROM tbl_expenses WHERE expense_id = @expense_id;
END;
GO


/* =========================================================
   PROCEDIMIENTOS PARA tbl_roles
   ========================================================= */

-- Insertar rol
CREATE PROCEDURE sp_tbl_roles_insert
    @role_name NVARCHAR(100),
    @description NVARCHAR(255)
AS
BEGIN
    INSERT INTO tbl_roles (role_name, description)
    VALUES (@role_name, @description);
END;
GO

-- Modificar rol
CREATE PROCEDURE sp_tbl_roles_update
    @role_id INT,
    @role_name NVARCHAR(100),
    @description NVARCHAR(255)
AS
BEGIN
    UPDATE tbl_roles
    SET role_name = @role_name,
        description = @description
    WHERE role_id = @role_id;
END;
GO

-- Listar todos los roles
CREATE PROCEDURE sp_tbl_roles_get_all
AS
BEGIN
    SELECT * FROM tbl_roles;
END;
GO

-- Ver rol por ID
CREATE PROCEDURE sp_tbl_roles_get_by_id
    @role_id INT
AS
BEGIN
    SELECT * FROM tbl_roles WHERE role_id = @role_id;
END;
GO

-- Eliminar rol
CREATE PROCEDURE sp_tbl_roles_delete
    @role_id INT
AS
BEGIN
    DELETE FROM tbl_roles WHERE role_id = @role_id;
END;
GO