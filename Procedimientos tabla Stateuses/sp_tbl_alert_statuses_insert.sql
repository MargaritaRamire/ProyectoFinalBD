create
    definer = root@localhost procedure sp_tbl_alert_statuses_insert(IN p_name_alert varchar(50), IN p_description text,
                                                                    IN p_threshold_km decimal(10, 2))
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
END;

