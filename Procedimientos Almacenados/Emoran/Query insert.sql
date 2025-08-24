-- 1. Crear un departamento
INSERT INTO tbl_departments (name_department, status_department, created_at)
VALUES ('Guatemala', 1, NOW());

-- Guarda el ID
SET @id_department = LAST_INSERT_ID();

-- 2. Crear dos municipios (origen y destino)
INSERT INTO tbl_municipalities (name_municipality, id_department, status_municipality, created_at)
VALUES ('Ciudad de Guatemala', @id_department, 1, NOW()),
       ('Mixco', @id_department, 1, NOW());

-- Guardar IDs
SELECT MIN(id_municipality) INTO @id_origin FROM tbl_municipalities WHERE name_municipality='Ciudad de Guatemala';
SELECT MIN(id_municipality) INTO @id_dest   FROM tbl_municipalities WHERE name_municipality='Mixco';

-- 3. Crear una ruta usando esos municipios
INSERT INTO tbl_routes (id_origin, id_destination, distance_km, status, created_at)
VALUES (@id_origin, @id_dest, 12.5, 1, NOW());

SET @id_route = LAST_INSERT_ID();

-- 4. Crear un estado de delivery
INSERT INTO tbl_delivery_statuses (name_status, description, status, created_at)
VALUES ('En tránsito', 'Pedido en camino', 1, NOW());

SET @id_status = LAST_INSERT_ID();

-- 5. Crear un delivery con ruta y status válidos
INSERT INTO tbl_deliveries (delivery_date, delivery_status, id_route, id_status, status, created_at)
VALUES (CURDATE(), 'En tránsito', @id_route, @id_status, 1, NOW());

SET @id_delivery = LAST_INSERT_ID();

-- 6. Crear un usuario
INSERT INTO tbl_users (first_name, last_name, username, email, password, status, created_at)
VALUES ('Prueba','Usuario','testuser','test@example.com','123456',1,NOW());

SET @id_user = LAST_INSERT_ID();

-- 7. Finalmente, crear un income de prueba
INSERT INTO tbl_incomes (amount, description, income_date, id_user, id_delivery, status, created_at)
VALUES (2000.00, 'Pago inicial', CURDATE(), @id_user, @id_delivery, 1, NOW());




-- Insertar un ingreso
CALL sp_incomes_insert(3000.00, 'Pago en efectivo cliente X', '2025-08-23', 1, 1, 1);

-- Actualizar un ingreso
CALL sp_incomes_update(1, 1800.00, 'Pago corregido entrega 1', '2025-08-21', 1, 1, 1);

-- Consultar todos los ingresos activos
CALL sp_incomes_get_all();

-- Consultar un ingreso específico
CALL sp_incomes_get_by_id(1);

-- Eliminar lógicamente un ingreso
CALL sp_incomes_delete(2);
