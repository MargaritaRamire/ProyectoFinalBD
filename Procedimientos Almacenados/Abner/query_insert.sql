-- ============================================
-- Datos iniciales de prueba
-- ============================================

INSERT INTO tbl_delivery_statuses (name_status, description, status, created_at, updated_at)
VALUES
('Pendiente', 'El pedido aún no ha sido procesado', 1, NOW(), NOW()),
('En tránsito', 'El pedido está en ruta de entrega', 1, NOW(), NOW()),
('Entregado', 'El pedido fue entregado al cliente', 1, NOW(), NOW()),
('Cancelado', 'El pedido fue cancelado por el cliente o el sistema', 1, NOW(), NOW()),
('Devuelto', 'El pedido fue devuelto al almacén', 1, NOW(), NOW());



-- Insertar un nuevo estado usando el procedimiento
CALL sp_delivery_statuses_insert('Reprogramado', 'Entrega reprogramada por el cliente', 1);

-- Obtener todos los registros activos
CALL sp_delivery_statuses_get_all();

-- Obtener un estado específico por ID (ej. id = 1)
CALL sp_delivery_statuses_get_by_id(1);

-- Actualizar un estado existente
CALL sp_delivery_statuses_update(2, 'En ruta', 'Pedido salió a ruta de entrega', 0);

-- Eliminar lógicamente un estado
CALL sp_delivery_statuses_delete(5);

-- Volver a consultar todos los registros
CALL sp_delivery_statuses_get_all();
