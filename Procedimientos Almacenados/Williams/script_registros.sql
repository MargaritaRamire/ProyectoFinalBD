-- REGISTROS DE PRUEBA
-- DepartamentoS
INSERT INTO tbl_departments (name_department)
SELECT 'Guatemala'
WHERE NOT EXISTS (
  SELECT 1 FROM tbl_departments WHERE name_department = 'Guatemala'
);

-- Municipios
INSERT INTO tbl_municipalities (name_municipality, id_department)
SELECT 'Ciudad de Guatemala', 1
WHERE NOT EXISTS (
  SELECT 1 FROM tbl_municipalities WHERE name_municipality = 'Ciudad de Guatemala'
);

-- Rutas
INSERT INTO tbl_routes (id_origin, id_destination, distance_km)
SELECT 1, 1, 10.5
WHERE NOT EXISTS (
  SELECT 1 FROM tbl_routes WHERE id_origin = 1 AND id_destination = 1
);

-- Estado de entrega
INSERT INTO tbl_delivery_statuses (name_status)
SELECT 'Programada'
WHERE NOT EXISTS (
  SELECT 1 FROM tbl_delivery_statuses WHERE name_status = 'Programada'
);

-- Entregas
INSERT INTO tbl_deliveries (delivery_date, delivery_status, id_route, id_status)
VALUES 
(CURDATE(), 'Programada', 1, 1),
(DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'Programada', 1, 1),
(DATE_ADD(CURDATE(), INTERVAL 2 DAY), 'Programada', 1, 1),
(DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Programada', 1, 1),
(DATE_ADD(CURDATE(), INTERVAL 4 DAY), 'Programada', 1, 1);

-- Vehiculos
INSERT INTO tbl_vehicles (license_plate, capacity, plates)
VALUES 
('P-LOG-001', 2000, 'PLOG001'),
('P-LOG-002', 2500, 'PLOG002');

-- Conductores
INSERT INTO tbl_drivers (name, license)
VALUES 
('Luis Torres', 'LIC-0001'),
('Ana García', 'LIC-0002');

-- Insertar asignaciones usando el procedimiento almacenado insert
CALL sp_delivery_assignments_insert(1, 1, 1, CURDATE());
CALL sp_delivery_assignments_insert(2, 2, 2, DATE_ADD(CURDATE(), INTERVAL 1 DAY));
CALL sp_delivery_assignments_insert(3, 1, 2, DATE_ADD(CURDATE(), INTERVAL 2 DAY));
CALL sp_delivery_assignments_insert(4, 2, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY));
CALL sp_delivery_assignments_insert(5, 1, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY));