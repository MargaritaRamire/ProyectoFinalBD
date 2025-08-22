create
    definer = root@localhost procedure sp_tbl_alert_statuses_update(IN p_id_alert int, IN p_name_alert varchar(50),
                                                                    IN p_description text,
                                                                    IN p_threshold_km decimal(10, 2))
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
END;

