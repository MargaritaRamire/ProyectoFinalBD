DELIMITER $$

-- ============================================
-- INSERT
-- ============================================
CREATE PROCEDURE sp_users_insert (
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_username VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_password VARCHAR(255),
    IN p_jwt_token VARCHAR(500),
    IN p_jwt_expiration DATETIME,
    IN p_status TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO tbl_users (first_name, last_name, username, email, password, jwt_token, jwt_expiration, status, created_at, updated_at)
    VALUES (p_first_name, p_last_name, p_username, p_email, p_password, p_jwt_token, p_jwt_expiration, p_status, NOW(), NOW());

    COMMIT;
END$$

-- ============================================
-- UPDATE
-- ============================================
CREATE PROCEDURE sp_users_update (
    IN p_id_user INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_username VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_password VARCHAR(255),
    IN p_jwt_token VARCHAR(500),
    IN p_jwt_expiration DATETIME,
    IN p_status TINYINT(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_users
    SET first_name    = p_first_name,
        last_name     = p_last_name,
        username      = p_username,
        email         = p_email,
        password      = p_password,
        jwt_token     = p_jwt_token,
        jwt_expiration= p_jwt_expiration,
        status        = p_status,
        updated_at    = NOW()
    WHERE id_user = p_id_user;

    COMMIT;
END$$

-- ============================================
-- GET ALL
-- ============================================
CREATE PROCEDURE sp_users_get_all ()
BEGIN
    SELECT id_user, first_name, last_name, username, email, jwt_token, jwt_expiration, status, created_at, updated_at
    FROM tbl_users
    WHERE status = 1; -- Solo activos
END$$

-- ============================================
-- GET BY ID
-- ============================================
CREATE PROCEDURE sp_users_get_by_id (
    IN p_id_user INT
)
BEGIN
    SELECT id_user, first_name, last_name, username, email, jwt_token, jwt_expiration, status, created_at, updated_at
    FROM tbl_users
    WHERE id_user = p_id_user;
END$$

-- ============================================
-- DELETE (lógico)
-- ============================================
CREATE PROCEDURE sp_users_delete (
    IN p_id_user INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE tbl_users
    SET status = 0,
        updated_at = NOW()
    WHERE id_user = p_id_user;

    COMMIT;
END$$

DELIMITER ;
INSERT INTO tbl_users (first_name, last_name, username, email, password, jwt_token, jwt_expiration, status, created_at, updated_at)
VALUES
('Carlos', 'Ramírez', 'carlosr', 'carlos@example.com', 'hashed_password1', NULL, NULL, 1, NOW(), NOW()),
('María', 'López', 'marial', 'maria@example.com', 'hashed_password2', NULL, NULL, 1, NOW(), NOW()),
('Ana', 'Martínez', 'anam', 'ana@example.com', 'hashed_password3', NULL, NULL, 1, NOW(), NOW());
-- Insertar usuario nuevo
CALL sp_users_insert('Luis', 'Gómez', 'luisg', 'luis@example.com', 'hashed_password4', NULL, NULL, 1);

-- Ver todos los usuarios activos
CALL sp_users_get_all();

-- Obtener un usuario por ID
CALL sp_users_get_by_id(1);

-- Actualizar un usuario
CALL sp_users_update(2, 'María', 'López', 'maria_lopez', 'maria_lopez@example.com', 'hashed_password_updated', NULL, NULL, 1);

-- Eliminar lógicamente un usuario
CALL sp_users_delete(3);
