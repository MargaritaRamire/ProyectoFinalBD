

-- ============================================
-- INSERT
-- ============================================
DELIMITER $$
CREATE PROCEDURE sp_expenses_insert (
    IN p_id_expense_type INT,
    IN p_id_user INT,
    IN p_id_vehicle INT,
    IN p_description TEXT,
    IN p_amount DECIMAL(10,2),
    IN p_expense_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    INSERT INTO tbl_expenses (id_expense_type, id_user, id_vehicle, description, amount, expense_date, status, created_at, updated_at)
    VALUES (p_id_expense_type, p_id_user, p_id_vehicle, p_description, p_amount, p_expense_date, 1, NOW(), NOW());
    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_expenses_update (
    IN p_id_expense INT,
    IN p_id_expense_type INT,
    IN p_id_user INT,
    IN p_id_vehicle INT,
    IN p_description TEXT,
    IN p_amount DECIMAL(10,2),
    IN p_expense_date DATE,
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    UPDATE tbl_expenses
    SET id_expense_type = p_id_expense_type,
        id_user = p_id_user,
        id_vehicle = p_id_vehicle,
        description = p_description,
        amount = p_amount,
        expense_date = p_expense_date,
        status = p_status,
        updated_at = NOW()
    WHERE id_expense = p_id_expense;
    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_expenses_get_all ()
BEGIN
    SELECT e.id_expense, et.name AS expense_type, u.username, v.license_plate,
           e.description, e.amount, e.expense_date, e.status, e.created_at, e.updated_at
    FROM tbl_expenses e
    INNER JOIN tbl_expense_types et ON e.id_expense_type = et.id_expense_type
    INNER JOIN tbl_users u ON e.id_user = u.id_user
    LEFT JOIN tbl_vehicles v ON e.id_vehicle = v.id_vehicle
    WHERE e.status = 1;
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_expenses_get_by_id (IN p_id_expense INT)
BEGIN
    SELECT e.id_expense, et.name AS expense_type, u.username, v.license_plate,
           e.description, e.amount, e.expense_date, e.status, e.created_at, e.updated_at
    FROM tbl_expenses e
    INNER JOIN tbl_expense_types et ON e.id_expense_type = et.id_expense_type
    INNER JOIN tbl_users u ON e.id_user = u.id_user
    LEFT JOIN tbl_vehicles v ON e.id_vehicle = v.id_vehicle
    WHERE e.id_expense = p_id_expense;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_expenses_delete (IN p_id_expense INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; END;

    START TRANSACTION;
    UPDATE tbl_expenses
    SET status = 0, updated_at = NOW()
    WHERE id_expense = p_id_expense;
    COMMIT;
END$$

DELIMITER ;

INSERT INTO tbl_users (first_name, last_name, username, email, password, status, created_at, updated_at) VALUES
('Juan', 'Pérez', 'admin', 'admin@empresa.com', 'admin123', 1, NOW(), NOW()),
('María', 'Gómez', 'contadora', 'maria@empresa.com', 'conta123', 1, NOW(), NOW()),
('Carlos', 'López', 'chofer1', 'carlos@empresa.com', 'chofer123', 1, NOW(), NOW());

INSERT INTO tbl_expense_types (name, status, created_at, updated_at) VALUES
('Combustible', 1, NOW(), NOW()),
('Mantenimiento', 1, NOW(), NOW()),
('Repuestos', 1, NOW(), NOW());

-- Vehículos
INSERT INTO tbl_vehicles (license_plate, capacity, plates, available, status, created_at, updated_at) VALUES
('P123ABC', 3000, '123ABC', 1, 1, NOW(), NOW()),
('P456DEF', 5000, '456DEF', 1, 1, NOW(), NOW()),
('P789GHI', 2000, '789GHI', 1, 1, NOW(), NOW());

-- Gastos iniciales
INSERT INTO tbl_expenses (id_expense_type, id_user, id_vehicle, description, amount, expense_date, status, created_at, updated_at) VALUES
(1, 3, 1, 'Carga de combustible regular', 800.00, '2025-08-20', 1, NOW(), NOW()),
(2, 1, 2, 'Servicio de mantenimiento preventivo', 1200.00, '2025-08-22', 1, NOW(), NOW()),
(3, 2, 3, 'Compra de repuesto de frenos', 600.00, '2025-08-25', 1, NOW(), NOW());

CALL sp_expenses_insert(1, 1, 1, 'Cambio de llantas', 500.00, '2025-08-27');
CALL sp_expenses_get_all();
CALL sp_expenses_get_by_id(1);
CALL sp_expenses_update(1, 1, 1, 1, 'Cambio de llantas delanteras', 550.00, '2025-08-27', 1);
CALL sp_expenses_delete(1);
