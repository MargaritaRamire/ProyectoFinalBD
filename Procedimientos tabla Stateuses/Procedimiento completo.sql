USE logistics;

INSERT INTO tbl_alert_statuses (name_alert, description, threshold_km, created_at, updated_at)
VALUES
('Alerta Roja', 'Supera el límite de velocidad en autopista', 120.50, NOW(), NOW()),
('Alerta Amarilla', 'Velocidad moderada, alerta preventiva', 90.00, NOW(), NOW()),
('Alerta Verde', 'Todo en orden, velocidad dentro de parámetros', 60.00, NOW(), NOW());

SELECT * FROM tbl_alert_statuses;

## 1 Procedimiento de insert

DELIMITER $$

CREATE PROCEDURE sp_tbl_alert_statuses_insert (
    IN p_name_alert VARCHAR(50),
    IN p_description TEXT,
    IN p_threshold_km DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al insertar en tbl_alert_statuses' AS ErrorMessage;
    END;

    START TRANSACTION;

    INSERT INTO tbl_alert_statuses (name_alert, description, threshold_km, created_at, updated_at)
    VALUES (p_name_alert, p_description, p_threshold_km, NOW(), NOW());

    COMMIT;
END$$

DELIMITER ;

##Call insert


CALL sp_tbl_alert_statuses_insert('Alerta Azul', 'Monitoreo normal sin incidencias', 50.00);



## 2 Procedimiento update

DELIMITER $$

CREATE PROCEDURE sp_tbl_alert_statuses_update (
    IN p_id_alert INT,
    IN p_name_alert VARCHAR(50),
    IN p_description TEXT,
    IN p_threshold_km DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al actualizar en tbl_alert_statuses' AS ErrorMessage;
    END;

    START TRANSACTION;

    UPDATE tbl_alert_statuses
    SET
        name_alert   = p_name_alert,
        description  = p_description,
        threshold_km = p_threshold_km,
        updated_at   = NOW()
    WHERE id_alert = p_id_alert;

    COMMIT;
END$$

DELIMITER ;

##Call update

CALL sp_tbl_alert_statuses_update(1, 'Alerta Roja Crítica', 'Exceso de velocidad muy grave en autopista', 130.00);

## 3 Procedimiento Get All

DELIMITER $$

CREATE PROCEDURE sp_tbl_alert_statuses_get_all ()
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses;
END$$

DELIMITER ;

##Call Get All

CALL sp_tbl_alert_statuses_get_all();

## 4 Procedimiento Get By ID

DELIMITER $$

CREATE PROCEDURE sp_tbl_alert_statuses_get_by_id (IN p_id_alert INT)
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses
    WHERE id_alert = p_id_alert;
END$$

DELIMITER ;

##Call Get By ID

CALL sp_tbl_alert_statuses_get_by_id(2);


## 5 Procedimiento Delete

DELIMITER $$

CREATE PROCEDURE sp_tbl_alert_statuses_delete (IN p_id_alert INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al eliminar en tbl_alert_statuses' AS ErrorMessage;
    END;

    START TRANSACTION;

    DELETE FROM tbl_alert_statuses
    WHERE id_alert = p_id_alert;

    COMMIT;
END$$

DELIMITER ;

##Call Delete

CALL sp_tbl_alert_statuses_delete(3);
