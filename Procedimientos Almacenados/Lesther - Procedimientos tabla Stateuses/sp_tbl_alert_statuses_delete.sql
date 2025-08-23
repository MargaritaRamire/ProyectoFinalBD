create
    definer = root@localhost procedure sp_tbl_alert_statuses_delete(IN p_id_alert int)
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
END;

