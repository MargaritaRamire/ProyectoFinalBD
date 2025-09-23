DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_products_insert (
    IN p_name VARCHAR(150),
    IN p_stock INT,
    IN p_price DECIMAL(10,2),
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_products (name, stock, price, status, created_at, updated_at)
    VALUES (p_name, p_stock, p_price, p_status, NOW(), NOW());

    COMMIT;

    SELECT LAST_INSERT_ID() AS id;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_products_update (
    IN p_id_product INT,
    IN p_name VARCHAR(150),
    IN p_stock INT,
    IN p_price DECIMAL(10,2),
    IN p_status TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_products
    SET name = p_name,
        stock = p_stock,
        price = p_price,
        status = p_status,
        updated_at = NOW()
    WHERE id = p_id_product;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_products_get_all ()
BEGIN
    SELECT id, name, stock, price, status, created_at, updated_at
    FROM tbl_products
    WHERE status = 1; -- solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_products_get_by_id (
    IN p_id_product INT
)
BEGIN
    SELECT id, name, stock, price, status, created_at, updated_at
    FROM tbl_products
    WHERE id = p_id_product;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_products_delete (
    IN p_id_product INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_products
    SET status = 0,
        updated_at = NOW()
    WHERE id = p_id_product;

    COMMIT;
END$$

-- ============================================
-- TOTAL STOCK
-- ============================================
CREATE PROCEDURE sp_products_total_stock ()
BEGIN
    SELECT SUM(stock) AS total_stock
    FROM tbl_products
    WHERE status = 1; -- solo productos activos
END$$

DELIMITER ;



-- //////////////////////////////////
-- por separado
-- Insertar un producto
CALL sp_products_insert('Laptop Dell', 15, 8500.00, 1);
CALL sp_products_insert('Laptop Lenovo', 10, 9000.00, 1);
CALL sp_products_insert('Laptop Azus', 20, 10500.00, 1);

-- Listar todos los activos
CALL sp_products_get_all();

-- Consultar producto por ID
CALL sp_products_get_by_id(1);

-- Actualizar un producto
CALL sp_products_update(1, 'Laptop Dell XPS', 20, 9500.00, 1);

-- Eliminar lógicamente un producto
CALL sp_products_delete(1);

-- Obtener total de stock
CALL sp_products_total_stock();


