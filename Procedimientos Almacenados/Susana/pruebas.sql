-- ============================================
-- Inserts iniciales en tbl_expense_types
-- ============================================

INSERT INTO tbl_expense_types (name, status, created_at, updated_at)
VALUES
('Combustible', 1, NOW(), NOW()),
('Mantenimiento', 1, NOW(), NOW()),
('Peajes', 1, NOW(), NOW()),
('Salarios', 1, NOW(), NOW()),
('Seguros', 1, NOW(), NOW()),
('Papelería y suministros', 1, NOW(), NOW());




-- Insertar un nuevo tipo de gasto
CALL sp_expense_types_insert('Repuestos', 1);

-- Obtener todos los tipos activos
CALL sp_expense_types_get_all();

-- Obtener un tipo específico
CALL sp_expense_types_get_by_id(2);

-- Actualizar un tipo de gasto
CALL sp_expense_types_update(3, 'Peajes y parqueos', 1);

-- Baja lógica de un registro
CALL sp_expense_types_delete(4);
