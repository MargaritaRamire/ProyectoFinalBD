create
    definer = root@localhost procedure sp_tbl_alert_statuses_get_all()
BEGIN
    SELECT id_alert, name_alert, description, threshold_km, created_at, updated_at
    FROM tbl_alert_statuses;
END;

