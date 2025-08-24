INSERT INTO tbl_drivers (name, license, status, created_at, updated_at)
VALUES
('Juan Pérez', 'LIC-12345', 1, NOW(), NOW()),
('María López', 'LIC-54321', 1, NOW(), NOW()),
('Carlos Gómez', 'LIC-11111', 1, NOW(), NOW()),
('Ana Torres', 'LIC-22222', 1, NOW(), NOW()),
('Luis Ramírez', 'LIC-33333', 1, NOW(), NOW());




-- Insertar un nuevo conductor
CALL sp_drivers_insert('Pedro Martínez', 'LIC-44444', 1);

-- Consultar todos los conductores activos
CALL sp_drivers_get_all();

-- Consultar un conductor específico
CALL sp_drivers_get_by_id(2);

-- Actualizar un conductor existente
CALL sp_drivers_update(3, 'Carlos G. Gómez', 'LIC-11111', 1);

-- Eliminar (baja lógica) un conductor
CALL sp_drivers_delete(4);

-- Volver a consultar todos
CALL sp_drivers_get_all();
