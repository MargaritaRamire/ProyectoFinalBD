USE logistics;

-- =====================================
-- Datos de prueba para rutas (FK)
-- =====================================
-- Asegúrate que estas rutas existan en tbl_routes
INSERT IGNORE INTO tbl_routes (id_origin, id_destination, distance_km, created_at, updated_at)
VALUES
(1, 2, 15.5, NOW(), NOW()),
(2, 1, 20.0, NOW(), NOW());

-- =====================================
-- Datos de prueba para estados de entrega (FK)
-- =====================================
INSERT IGNORE INTO tbl_delivery_statuses (name_status, description, created_at, updated_at)
VALUES
('Pendiente', 'Pendiente de envío', NOW(), NOW()),
('En tránsito', 'En camino al destino', NOW(), NOW()),
('Entregado', 'Paquete entregado', NOW(), NOW());

-- =====================================
-- Insertar entregas de prueba
-- =====================================
INSERT INTO tbl_deliveries (delivery_date, delivery_status, id_route, id_status, created_at, updated_at)
VALUES
(CURDATE(), 'Pendiente', 1, 1, NOW(), NOW()),
(DATE_ADD(CURDATE(), INTERVAL -1 DAY), 'En tránsito', 1, 2, NOW(), NOW()),
(DATE_ADD(CURDATE(), INTERVAL -2 DAY), 'Entregado', 2, 3, NOW(), NOW()),
(DATE_ADD(CURDATE(), INTERVAL -3 DAY), 'Pendiente', 2, 1, NOW(), NOW());
