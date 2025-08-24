-- ============================================
-- BLOQUE DE COMPROBACIÓN PARA tbl_customers
-- ============================================



    -- ============================================
-- DATOS INICIALES DE PRUEBA PARA tbl_customers
-- ============================================

INSERT INTO tbl_customers
(name, nit, phone, email, address, id_municipality, status, created_at, updated_at)
VALUES
('Juan Pérez',    '1234567-8',  '50212345678', 'juan.perez@example.com',  'Calle Principal 123, Zona 1', 1, 1, NOW(), NOW()),  -- Guatemala
('María López',   '2345678-9',  '50223456789', 'maria.lopez@example.com', 'Avenida Central 45, Zona 2',  2, 1, NOW(), NOW()),  -- Mixco
('Carlos Gómez',  '3456789-0',  '50234567890', 'carlos.gomez@example.com','Col. Jardines, Casa 10',      3, 1, NOW(), NOW()),  -- Santa Catarina Pinula
('Ana Martínez',  NULL,         '50245678901', 'ana.mtz@example.com',     'Boulevard Vista Hermosa',     4, 1, NOW(), NOW()),  -- Antigua Guatemala
('Luis Torres',   '4567890-1',  NULL,          'luis.torres@example.com', 'Zona 10, Oficina 402',        7, 1, NOW(), NOW()); -- Escuintla



-- Obtener todos los registros activos
CALL sp_tbl_customers_get_all();

-- Obtener un cliente específico por ID (ej. id = 1)
CALL sp_tbl_customers_get_by_id(1);

-- Actualizar un cliente existente (ej. id = 2)
CALL sp_tbl_customers_update(
  2,
  'María López Actualizado',
  '2345678-9',
  '50223456789',
  'maria.lopez@update.com',
  'Avenida Central 45, Zona 2 (Act.)',
  NULL,
  1
);

-- Eliminar lógicamente (baja lógica) un cliente (ej. id = 5)
CALL sp_tbl_customers_delete(12);

-- Volver a consultar todos los registros activos
CALL sp_tbl_customers_get_all();
