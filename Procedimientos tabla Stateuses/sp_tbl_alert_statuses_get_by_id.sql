create
    definer = root@localhost procedure sp_tbl_alert_statuses_get_by_id(IN p_id_alert int)
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses
    WHERE id_alert = p_id_alert;
END;

