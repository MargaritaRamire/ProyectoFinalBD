-- =========================================================
-- MySQL 8.0 - Conversión directa desde SQL Server
-- Base de datos objetivo: logistics
-- =========================================================

CREATE DATABASE IF NOT EXISTS `logistics`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE `logistics`;

SET FOREIGN_KEY_CHECKS = 0;

-- Drops seguros (si existen)
DROP TABLE IF EXISTS `tbl_roles_has_users`;
DROP TABLE IF EXISTS `tbl_delivery_assignments`;
DROP TABLE IF EXISTS `tbl_incomes`;
DROP TABLE IF EXISTS `tbl_expenses`;
DROP TABLE IF EXISTS `tbl_delivery_guides`;
DROP TABLE IF EXISTS `tbl_kilometers`;
DROP TABLE IF EXISTS `tbl_maintenances`;
DROP TABLE IF EXISTS `tbl_maintenance_requests`;
DROP TABLE IF EXISTS `tbl_deliveries`;
DROP TABLE IF EXISTS `tbl_routes`;
DROP TABLE IF EXISTS `tbl_customers`;
DROP TABLE IF EXISTS `tbl_municipalities`;
DROP TABLE IF EXISTS `tbl_departments`;
DROP TABLE IF EXISTS `tbl_vehicles`;
DROP TABLE IF EXISTS `tbl_drivers`;
DROP TABLE IF EXISTS `tbl_expense_types`;
DROP TABLE IF EXISTS `tbl_users`;
DROP TABLE IF EXISTS `tbl_delivery_statuses`;
DROP TABLE IF EXISTS `tbl_alert_statuses`;
DROP TABLE IF EXISTS `tbl_roles`;

-- =========================
-- Tablas base
-- =========================

CREATE TABLE `tbl_alert_statuses` (
  `id_alert` INT NOT NULL AUTO_INCREMENT,
  `name_alert` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `threshold_km` DECIMAL(10,2) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_alert`),
  UNIQUE KEY `UQ__tbl_aler__DEB047212A80A008` (`name_alert`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_customers` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `nit` VARCHAR(20) NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  `address` TEXT NULL,
  `id_municipality` INT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_deliveries` (
  `id_delivery` INT NOT NULL AUTO_INCREMENT,
  `delivery_date` DATE NOT NULL,
  `delivery_status` VARCHAR(50) NOT NULL,
  `id_route` INT NOT NULL,
  `id_status` INT NOT NULL DEFAULT 1,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_delivery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_delivery_assignments` (
  `id_delivery` INT NOT NULL,
  `id_vehicle` INT NOT NULL,
  `id_driver` INT NOT NULL,
  `assignment_date` DATE NOT NULL,
  PRIMARY KEY (`id_delivery`, `id_vehicle`, `id_driver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_delivery_guides` (
  `id_guide` INT NOT NULL AUTO_INCREMENT,
  `id_delivery` INT NOT NULL,
  `guide_number` VARCHAR(50) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_guide`),
  UNIQUE KEY `UQ__tbl_deli__3B88FE57F23B3729` (`guide_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_delivery_statuses` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `name_status` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE KEY `UQ__tbl_deli__D6CF2EDFA33C0128` (`name_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_departments` (
  `id_department` INT NOT NULL AUTO_INCREMENT,
  `name_department` VARCHAR(100) NOT NULL,
  `status_department` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_department`),
  UNIQUE KEY `UQ__tbl_depa__585CA65BDC9BCA22` (`name_department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_drivers` (
  `id_driver` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `license` VARCHAR(50) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_driver`),
  UNIQUE KEY `UQ__tbl_driv__A4E54DE4EC1F79A4` (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_expense_types` (
  `id_expense_type` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_expense_type`),
  UNIQUE KEY `UQ__tbl_expe__72E12F1B5657E8C3` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_expenses` (
  `id_expense` INT NOT NULL AUTO_INCREMENT,
  `id_expense_type` INT NOT NULL,
  `id_user` INT NOT NULL,
  `id_vehicle` INT NULL,
  `description` TEXT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `expense_date` DATE NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_expense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_incomes` (
  `id_income` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(10,2) NULL,
  `description` TEXT NOT NULL,
  `income_date` DATE NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `id_user` INT NOT NULL,
  `id_delivery` INT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_income`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_kilometers` (
  `id_kilometer` INT NOT NULL AUTO_INCREMENT,
  `id_delivery` INT NOT NULL,
  `id_vehicle` INT NOT NULL,
  `kilometers_traveled` DECIMAL(10,2) NOT NULL,
  `id_alert` INT NULL,
  `record_date` DATE NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_kilometer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_maintenance_requests` (
  `id_request` INT NOT NULL AUTO_INCREMENT,
  `id_vehicle` INT NOT NULL,
  `request_date` DATE NOT NULL,
  `reason` TEXT NOT NULL,
  `approved_by` INT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_request`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_maintenances` (
  `id_maintenance` INT NOT NULL AUTO_INCREMENT,
  `id_vehicle` INT NOT NULL,
  `type` VARCHAR(100) NOT NULL,
  `maintenance_date` DATE NOT NULL,
  `approved` TINYINT(1) NULL DEFAULT 0,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_maintenance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_municipalities` (
  `id_municipality` INT NOT NULL AUTO_INCREMENT,
  `name_municipality` VARCHAR(100) NOT NULL,
  `id_department` INT NOT NULL,
  `status_municipality` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_municipality`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_roles` (
  `id_role` INT NOT NULL AUTO_INCREMENT,
  `name_role` VARCHAR(100) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `UQ__tbl_role__E22A6879FF3BA2E6` (`name_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_roles_has_users` (
  `id_user` INT NOT NULL,
  `id_role` INT NOT NULL,
  PRIMARY KEY (`id_user`, `id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_routes` (
  `id_route` INT NOT NULL AUTO_INCREMENT,
  `id_origin` INT NOT NULL,
  `id_destination` INT NOT NULL,
  `distance_km` DECIMAL(10,2) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_route`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `jwt_token` VARCHAR(500) NULL,
  `jwt_expiration` DATETIME NULL,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `UQ__tbl_user__AB6E6164838F40F8` (`email`),
  UNIQUE KEY `UQ__tbl_user__F3DBC572C3BBE3E9` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_vehicles` (
  `id_vehicle` INT NOT NULL AUTO_INCREMENT,
  `license_plate` VARCHAR(20) NOT NULL,
  `capacity` INT NOT NULL,
  `plates` VARCHAR(20) NOT NULL,
  `available` TINYINT(1) NOT NULL DEFAULT 1,
  `status` TINYINT(1) NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id_vehicle`),
  UNIQUE KEY `UQ__tbl_vehi__F72CD56E5C187A21` (`license_plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =========================
-- Foreign Keys
-- =========================

ALTER TABLE `tbl_customers`
  ADD CONSTRAINT `FK__tbl_custo__id_mu__5165187F`
    FOREIGN KEY (`id_municipality`) REFERENCES `tbl_municipalities` (`id_municipality`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_deliveries`
  ADD CONSTRAINT `FK__tbl_deliv__id_ro__6EF57B66`
    FOREIGN KEY (`id_route`) REFERENCES `tbl_routes` (`id_route`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_deliv__id_st__6FE99F9F`
    FOREIGN KEY (`id_status`) REFERENCES `tbl_delivery_statuses` (`id_status`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_delivery_assignments`
  ADD CONSTRAINT `FK__tbl_deliv__id_de__787EE5A0`
    FOREIGN KEY (`id_delivery`) REFERENCES `tbl_deliveries` (`id_delivery`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_deliv__id_ve__797309D9`
    FOREIGN KEY (`id_vehicle`) REFERENCES `tbl_vehicles` (`id_vehicle`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_deliv__id_dr__7A672E12`
    FOREIGN KEY (`id_driver`) REFERENCES `tbl_drivers` (`id_driver`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_delivery_guides`
  ADD CONSTRAINT `FK__tbl_deliv__id_de__75A278F5`
    FOREIGN KEY (`id_delivery`) REFERENCES `tbl_deliveries` (`id_delivery`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_expenses`
  ADD CONSTRAINT `FK__tbl_expen__id_ex__0F624AF8`
    FOREIGN KEY (`id_expense_type`) REFERENCES `tbl_expense_types` (`id_expense_type`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_expen__id_us__10566F31`
    FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id_user`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_expen__id_ve__114A936A`
    FOREIGN KEY (`id_vehicle`) REFERENCES `tbl_vehicles` (`id_vehicle`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_incomes`
  ADD CONSTRAINT `FK__tbl_incom__id_us__1DB06A4F`
    FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id_user`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_incom__id_de__1EA48E88`
    FOREIGN KEY (`id_delivery`) REFERENCES `tbl_deliveries` (`id_delivery`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_kilometers`
  ADD CONSTRAINT `FK__tbl_kilom__id_de__160F4887`
    FOREIGN KEY (`id_delivery`) REFERENCES `tbl_deliveries` (`id_delivery`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_kilom__id_ve__17036CC0`
    FOREIGN KEY (`id_vehicle`) REFERENCES `tbl_vehicles` (`id_vehicle`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_kilom__id_al__17F790F9`
    FOREIGN KEY (`id_alert`) REFERENCES `tbl_alert_statuses` (`id_alert`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_maintenance_requests`
  ADD CONSTRAINT `FK__tbl_maint__id_ve__04E4BC85`
    FOREIGN KEY (`id_vehicle`) REFERENCES `tbl_vehicles` (`id_vehicle`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_maint__appro__05D8E0BE`
    FOREIGN KEY (`approved_by`) REFERENCES `tbl_users` (`id_user`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_maintenances`
  ADD CONSTRAINT `FK__tbl_maint__id_ve__00200768`
    FOREIGN KEY (`id_vehicle`) REFERENCES `tbl_vehicles` (`id_vehicle`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_municipalities`
  ADD CONSTRAINT `FK__tbl_munic__id_de__3E52440B`
    FOREIGN KEY (`id_department`) REFERENCES `tbl_departments` (`id_department`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_roles_has_users`
  ADD CONSTRAINT `FK__tbl_roles__id_us__4BAC3F29`
    FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id_user`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_roles__id_ro__4CA06362`
    FOREIGN KEY (`id_role`) REFERENCES `tbl_roles` (`id_role`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `tbl_routes`
  ADD CONSTRAINT `FK__tbl_route__id_or__68487DD7`
    FOREIGN KEY (`id_origin`) REFERENCES `tbl_municipalities` (`id_municipality`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK__tbl_route__id_de__693CA210`
    FOREIGN KEY (`id_destination`) REFERENCES `tbl_municipalities` (`id_municipality`)
    ON DELETE RESTRICT ON UPDATE RESTRICT;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------ALTER TABLES --------------------------------
-- ALTER TABLE PARA tbl_delivery_statuses --
ALTER TABLE logistics.tbl_delivery_statuses
ADD status BIT DEFAULT 1;

ALTER TABLE tbl_delivery_assignments
ADD COLUMN status TINYINT(1) NULL DEFAULT 1 AFTER assignment_date,
ADD COLUMN created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP AFTER status,
ADD COLUMN updated_at DATETIME NULL AFTER created_at;
