/*
 Navicat Premium Dump SQL

 Source Server         : SQL Server Docker
 Source Server Type    : SQL Server
 Source Server Version : 16004175 (16.00.4175)
 Source Host           : localhost:1433
 Source Catalog        : proyectoBD
 Source Schema         : logistics

 Target Server Type    : SQL Server
 Target Server Version : 16004175 (16.00.4175)
 File Encoding         : 65001

 Date: 01/06/2025 20:53:45
*/


-- ----------------------------
-- Table structure for tbl_alert_statuses
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_alert_statuses]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_alert_statuses]
GO

CREATE TABLE [logistics].[tbl_alert_statuses] (
  [id_alert] int  IDENTITY(1,1) NOT NULL,
  [name_alert] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [description] text COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [threshold_km] decimal(10,2)  NOT NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_alert_statuses] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_alert_statuses
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_alert_statuses] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_alert_statuses] OFF
GO


-- ----------------------------
-- Table structure for tbl_customers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_customers]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_customers]
GO

CREATE TABLE [logistics].[tbl_customers] (
  [id_customer] int  IDENTITY(1,1) NOT NULL,
  [name] varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [nit] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [phone] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [email] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [address] text COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [id_municipality] int  NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_customers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_customers
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_customers] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_customers] OFF
GO


-- ----------------------------
-- Table structure for tbl_deliveries
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_deliveries]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_deliveries]
GO

CREATE TABLE [logistics].[tbl_deliveries] (
  [id_delivery] int  IDENTITY(1,1) NOT NULL,
  [delivery_date] date  NOT NULL,
  [delivery_status] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [id_route] int  NOT NULL,
  [id_status] int DEFAULT 1 NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_deliveries] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_deliveries
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_deliveries] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_deliveries] OFF
GO


-- ----------------------------
-- Table structure for tbl_delivery_assignments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_delivery_assignments]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_delivery_assignments]
GO

CREATE TABLE [logistics].[tbl_delivery_assignments] (
  [id_delivery] int  NOT NULL,
  [id_vehicle] int  NOT NULL,
  [id_driver] int  NOT NULL,
  [assignment_date] date  NOT NULL
)
GO

ALTER TABLE [logistics].[tbl_delivery_assignments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_delivery_assignments
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_delivery_guides
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_delivery_guides]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_delivery_guides]
GO

CREATE TABLE [logistics].[tbl_delivery_guides] (
  [id_guide] int  IDENTITY(1,1) NOT NULL,
  [id_delivery] int  NOT NULL,
  [guide_number] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_delivery_guides] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_delivery_guides
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_delivery_guides] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_delivery_guides] OFF
GO

-- ESTO ES UNA PRUEBA

-- ----------------------------
-- Table structure for tbl_delivery_statuses
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_delivery_statuses]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_delivery_statuses]
GO

CREATE TABLE [logistics].[tbl_delivery_statuses] (
  [id_status] int  IDENTITY(1,1) NOT NULL,
  [name_status] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [description] text COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_delivery_statuses] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_delivery_statuses
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_delivery_statuses] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_delivery_statuses] OFF
GO


-- ----------------------------
-- Table structure for tbl_departments
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_departments]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_departments]
GO

CREATE TABLE [logistics].[tbl_departments] (
  [id_department] int  IDENTITY(1,1) NOT NULL,
  [name_department] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status_department] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_departments] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_departments
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_departments] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_departments] OFF
GO


-- ----------------------------
-- Table structure for tbl_drivers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_drivers]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_drivers]
GO

CREATE TABLE [logistics].[tbl_drivers] (
  [id_driver] int  IDENTITY(1,1) NOT NULL,
  [name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [license] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_drivers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_drivers
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_drivers] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_drivers] OFF
GO


-- ----------------------------
-- Table structure for tbl_expense_types
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_expense_types]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_expense_types]
GO

CREATE TABLE [logistics].[tbl_expense_types] (
  [id_expense_type] int  IDENTITY(1,1) NOT NULL,
  [name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_expense_types] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_expense_types
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_expense_types] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_expense_types] OFF
GO


-- ----------------------------
-- Table structure for tbl_expenses
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_expenses]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_expenses]
GO

CREATE TABLE [logistics].[tbl_expenses] (
  [id_expense] int  IDENTITY(1,1) NOT NULL,
  [id_expense_type] int  NOT NULL,
  [id_user] int  NOT NULL,
  [id_vehicle] int  NULL,
  [description] text COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [amount] decimal(10,2)  NOT NULL,
  [expense_date] date  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_expenses] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_expenses
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_expenses] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_expenses] OFF
GO


-- ----------------------------
-- Table structure for tbl_incomes
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_incomes]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_incomes]
GO

CREATE TABLE [logistics].[tbl_incomes] (
  [id_income] int  IDENTITY(1,1) NOT NULL,
  [amount] decimal(10,2)  NULL,
  [description] text COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [income_date] date DEFAULT getdate() NOT NULL,
  [id_user] int  NOT NULL,
  [id_delivery] int  NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_incomes] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_incomes
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_incomes] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_incomes] OFF
GO


-- ----------------------------
-- Table structure for tbl_kilometers
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_kilometers]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_kilometers]
GO

CREATE TABLE [logistics].[tbl_kilometers] (
  [id_kilometer] int  IDENTITY(1,1) NOT NULL,
  [id_delivery] int  NOT NULL,
  [id_vehicle] int  NOT NULL,
  [kilometers_traveled] decimal(10,2)  NOT NULL,
  [id_alert] int  NULL,
  [record_date] date  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_kilometers] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_kilometers
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_kilometers] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_kilometers] OFF
GO


-- ----------------------------
-- Table structure for tbl_maintenance_requests
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_maintenance_requests]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_maintenance_requests]
GO

CREATE TABLE [logistics].[tbl_maintenance_requests] (
  [id_request] int  IDENTITY(1,1) NOT NULL,
  [id_vehicle] int  NOT NULL,
  [request_date] date  NOT NULL,
  [reason] text COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [approved_by] int  NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_maintenance_requests] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_maintenance_requests
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_maintenance_requests] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_maintenance_requests] OFF
GO


-- ----------------------------
-- Table structure for tbl_maintenances
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_maintenances]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_maintenances]
GO

CREATE TABLE [logistics].[tbl_maintenances] (
  [id_maintenance] int  IDENTITY(1,1) NOT NULL,
  [id_vehicle] int  NOT NULL,
  [type] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [maintenance_date] date  NOT NULL,
  [approved] bit DEFAULT 0 NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_maintenances] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_maintenances
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_maintenances] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_maintenances] OFF
GO


-- ----------------------------
-- Table structure for tbl_municipalities
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_municipalities]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_municipalities]
GO

CREATE TABLE [logistics].[tbl_municipalities] (
  [id_municipality] int  IDENTITY(1,1) NOT NULL,
  [name_municipality] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [id_department] int  NOT NULL,
  [status_municipality] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_municipalities] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_municipalities
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_municipalities] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_municipalities] OFF
GO


-- ----------------------------
-- Table structure for tbl_roles
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_roles]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_roles]
GO

CREATE TABLE [logistics].[tbl_roles] (
  [id_role] int  IDENTITY(1,1) NOT NULL,
  [name_role] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_roles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_roles
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_roles] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_roles] OFF
GO


-- ----------------------------
-- Table structure for tbl_roles_has_users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_roles_has_users]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_roles_has_users]
GO

CREATE TABLE [logistics].[tbl_roles_has_users] (
  [id_user] int  NOT NULL,
  [id_role] int  NOT NULL
)
GO

ALTER TABLE [logistics].[tbl_roles_has_users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_roles_has_users
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_routes
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_routes]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_routes]
GO

CREATE TABLE [logistics].[tbl_routes] (
  [id_route] int  IDENTITY(1,1) NOT NULL,
  [id_origin] int  NOT NULL,
  [id_destination] int  NOT NULL,
  [distance_km] decimal(10,2)  NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_routes] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_routes
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_routes] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_routes] OFF
GO


-- ----------------------------
-- Table structure for tbl_users
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_users]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_users]
GO

CREATE TABLE [logistics].[tbl_users] (
  [id_user] int  IDENTITY(1,1) NOT NULL,
  [first_name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [last_name] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [username] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [email] varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [password] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [jwt_token] varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
  [jwt_expiration] datetime  NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_users] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_users
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_users] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_users] OFF
GO


-- ----------------------------
-- Table structure for tbl_vehicles
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[logistics].[tbl_vehicles]') AND type IN ('U'))
	DROP TABLE [logistics].[tbl_vehicles]
GO

CREATE TABLE [logistics].[tbl_vehicles] (
  [id_vehicle] int  IDENTITY(1,1) NOT NULL,
  [license_plate] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [capacity] int  NOT NULL,
  [plates] varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [available] bit DEFAULT 1 NOT NULL,
  [status] bit DEFAULT 1 NULL,
  [created_at] datetime DEFAULT getdate() NULL,
  [updated_at] datetime  NULL
)
GO

ALTER TABLE [logistics].[tbl_vehicles] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of tbl_vehicles
-- ----------------------------
SET IDENTITY_INSERT [logistics].[tbl_vehicles] ON
GO

SET IDENTITY_INSERT [logistics].[tbl_vehicles] OFF
GO


-- ----------------------------
-- Auto increment value for tbl_alert_statuses
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_alert_statuses]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_alert_statuses
-- ----------------------------
ALTER TABLE [logistics].[tbl_alert_statuses] ADD CONSTRAINT [UQ__tbl_aler__DEB047212A80A008] UNIQUE NONCLUSTERED ([name_alert] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_alert_statuses
-- ----------------------------
ALTER TABLE [logistics].[tbl_alert_statuses] ADD CONSTRAINT [PK__tbl_aler__60E7B1FE013AA0F5] PRIMARY KEY CLUSTERED ([id_alert])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_customers
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_customers]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_customers
-- ----------------------------
ALTER TABLE [logistics].[tbl_customers] ADD CONSTRAINT [PK__tbl_cust__8CC9BA46D3574423] PRIMARY KEY CLUSTERED ([id_customer])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_deliveries
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_deliveries]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_deliveries
-- ----------------------------
ALTER TABLE [logistics].[tbl_deliveries] ADD CONSTRAINT [PK__tbl_deli__D75136875DC4196E] PRIMARY KEY CLUSTERED ([id_delivery])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_delivery_assignments
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_assignments] ADD CONSTRAINT [PK__tbl_deli__5D25DA84CD160B22] PRIMARY KEY CLUSTERED ([id_delivery], [id_vehicle], [id_driver])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_delivery_guides
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_delivery_guides]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_delivery_guides
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_guides] ADD CONSTRAINT [UQ__tbl_deli__3B88FE57F23B3729] UNIQUE NONCLUSTERED ([guide_number] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_delivery_guides
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_guides] ADD CONSTRAINT [PK__tbl_deli__657932768931C30E] PRIMARY KEY CLUSTERED ([id_guide])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_delivery_statuses
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_delivery_statuses]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_delivery_statuses
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_statuses] ADD CONSTRAINT [UQ__tbl_deli__D6CF2EDFA33C0128] UNIQUE NONCLUSTERED ([name_status] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_delivery_statuses
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_statuses] ADD CONSTRAINT [PK__tbl_deli__5D2DC6E837F51914] PRIMARY KEY CLUSTERED ([id_status])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_departments
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_departments]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_departments
-- ----------------------------
ALTER TABLE [logistics].[tbl_departments] ADD CONSTRAINT [UQ__tbl_depa__585CA65BDC9BCA22] UNIQUE NONCLUSTERED ([name_department] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_departments
-- ----------------------------
ALTER TABLE [logistics].[tbl_departments] ADD CONSTRAINT [PK__tbl_depa__0FC1D23F0543FB9B] PRIMARY KEY CLUSTERED ([id_department])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_drivers
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_drivers]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_drivers
-- ----------------------------
ALTER TABLE [logistics].[tbl_drivers] ADD CONSTRAINT [UQ__tbl_driv__A4E54DE4EC1F79A4] UNIQUE NONCLUSTERED ([license] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_drivers
-- ----------------------------
ALTER TABLE [logistics].[tbl_drivers] ADD CONSTRAINT [PK__tbl_driv__AB9FCDDD7799DD7A] PRIMARY KEY CLUSTERED ([id_driver])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_expense_types
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_expense_types]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_expense_types
-- ----------------------------
ALTER TABLE [logistics].[tbl_expense_types] ADD CONSTRAINT [UQ__tbl_expe__72E12F1B5657E8C3] UNIQUE NONCLUSTERED ([name] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_expense_types
-- ----------------------------
ALTER TABLE [logistics].[tbl_expense_types] ADD CONSTRAINT [PK__tbl_expe__CE1A9242367A4559] PRIMARY KEY CLUSTERED ([id_expense_type])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_expenses
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_expenses]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_expenses
-- ----------------------------
ALTER TABLE [logistics].[tbl_expenses] ADD CONSTRAINT [PK__tbl_expe__FBB0BABFA609C8C8] PRIMARY KEY CLUSTERED ([id_expense])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_incomes
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_incomes]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_incomes
-- ----------------------------
ALTER TABLE [logistics].[tbl_incomes] ADD CONSTRAINT [PK__tbl_inco__47D7D934BC5D8019] PRIMARY KEY CLUSTERED ([id_income])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_kilometers
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_kilometers]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_kilometers
-- ----------------------------
ALTER TABLE [logistics].[tbl_kilometers] ADD CONSTRAINT [PK__tbl_kilo__4909130BAAB5E93D] PRIMARY KEY CLUSTERED ([id_kilometer])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_maintenance_requests
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_maintenance_requests]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_maintenance_requests
-- ----------------------------
ALTER TABLE [logistics].[tbl_maintenance_requests] ADD CONSTRAINT [PK__tbl_main__7ADC39FCB0494AA3] PRIMARY KEY CLUSTERED ([id_request])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_maintenances
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_maintenances]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_maintenances
-- ----------------------------
ALTER TABLE [logistics].[tbl_maintenances] ADD CONSTRAINT [PK__tbl_main__7330D23D11F2991B] PRIMARY KEY CLUSTERED ([id_maintenance])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_municipalities
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_municipalities]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_municipalities
-- ----------------------------
ALTER TABLE [logistics].[tbl_municipalities] ADD CONSTRAINT [PK__tbl_muni__8060473B62A3957B] PRIMARY KEY CLUSTERED ([id_municipality])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_roles
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_roles]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_roles
-- ----------------------------
ALTER TABLE [logistics].[tbl_roles] ADD CONSTRAINT [UQ__tbl_role__E22A6879FF3BA2E6] UNIQUE NONCLUSTERED ([name_role] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_roles
-- ----------------------------
ALTER TABLE [logistics].[tbl_roles] ADD CONSTRAINT [PK__tbl_role__3D48441DBAA4407F] PRIMARY KEY CLUSTERED ([id_role])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_roles_has_users
-- ----------------------------
ALTER TABLE [logistics].[tbl_roles_has_users] ADD CONSTRAINT [PK__tbl_role__1105C2761C83C1AB] PRIMARY KEY CLUSTERED ([id_user], [id_role])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_routes
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_routes]', RESEED, 1)
GO


-- ----------------------------
-- Primary Key structure for table tbl_routes
-- ----------------------------
ALTER TABLE [logistics].[tbl_routes] ADD CONSTRAINT [PK__tbl_rout__3C8882D02B4BCAAF] PRIMARY KEY CLUSTERED ([id_route])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_users
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_users]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_users
-- ----------------------------
ALTER TABLE [logistics].[tbl_users] ADD CONSTRAINT [UQ__tbl_user__AB6E6164838F40F8] UNIQUE NONCLUSTERED ([email] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO

ALTER TABLE [logistics].[tbl_users] ADD CONSTRAINT [UQ__tbl_user__F3DBC572C3BBE3E9] UNIQUE NONCLUSTERED ([username] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_users
-- ----------------------------
ALTER TABLE [logistics].[tbl_users] ADD CONSTRAINT [PK__tbl_user__D2D14637991169C8] PRIMARY KEY CLUSTERED ([id_user])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Auto increment value for tbl_vehicles
-- ----------------------------
DBCC CHECKIDENT ('[logistics].[tbl_vehicles]', RESEED, 1)
GO


-- ----------------------------
-- Uniques structure for table tbl_vehicles
-- ----------------------------
ALTER TABLE [logistics].[tbl_vehicles] ADD CONSTRAINT [UQ__tbl_vehi__F72CD56E5C187A21] UNIQUE NONCLUSTERED ([license_plate] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Primary Key structure for table tbl_vehicles
-- ----------------------------
ALTER TABLE [logistics].[tbl_vehicles] ADD CONSTRAINT [PK__tbl_vehi__6DF73CE49B8A2157] PRIMARY KEY CLUSTERED ([id_vehicle])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  
ON [PRIMARY]
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_customers
-- ----------------------------
ALTER TABLE [logistics].[tbl_customers] ADD CONSTRAINT [FK__tbl_custo__id_mu__5165187F] FOREIGN KEY ([id_municipality]) REFERENCES [logistics].[tbl_municipalities] ([id_municipality]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_deliveries
-- ----------------------------
ALTER TABLE [logistics].[tbl_deliveries] ADD CONSTRAINT [FK__tbl_deliv__id_ro__6EF57B66] FOREIGN KEY ([id_route]) REFERENCES [logistics].[tbl_routes] ([id_route]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_deliveries] ADD CONSTRAINT [FK__tbl_deliv__id_st__6FE99F9F] FOREIGN KEY ([id_status]) REFERENCES [logistics].[tbl_delivery_statuses] ([id_status]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_delivery_assignments
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_assignments] ADD CONSTRAINT [FK__tbl_deliv__id_de__787EE5A0] FOREIGN KEY ([id_delivery]) REFERENCES [logistics].[tbl_deliveries] ([id_delivery]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_delivery_assignments] ADD CONSTRAINT [FK__tbl_deliv__id_ve__797309D9] FOREIGN KEY ([id_vehicle]) REFERENCES [logistics].[tbl_vehicles] ([id_vehicle]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_delivery_assignments] ADD CONSTRAINT [FK__tbl_deliv__id_dr__7A672E12] FOREIGN KEY ([id_driver]) REFERENCES [logistics].[tbl_drivers] ([id_driver]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_delivery_guides
-- ----------------------------
ALTER TABLE [logistics].[tbl_delivery_guides] ADD CONSTRAINT [FK__tbl_deliv__id_de__75A278F5] FOREIGN KEY ([id_delivery]) REFERENCES [logistics].[tbl_deliveries] ([id_delivery]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_expenses
-- ----------------------------
ALTER TABLE [logistics].[tbl_expenses] ADD CONSTRAINT [FK__tbl_expen__id_ex__0F624AF8] FOREIGN KEY ([id_expense_type]) REFERENCES [logistics].[tbl_expense_types] ([id_expense_type]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_expenses] ADD CONSTRAINT [FK__tbl_expen__id_us__10566F31] FOREIGN KEY ([id_user]) REFERENCES [logistics].[tbl_users] ([id_user]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_expenses] ADD CONSTRAINT [FK__tbl_expen__id_ve__114A936A] FOREIGN KEY ([id_vehicle]) REFERENCES [logistics].[tbl_vehicles] ([id_vehicle]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_incomes
-- ----------------------------
ALTER TABLE [logistics].[tbl_incomes] ADD CONSTRAINT [FK__tbl_incom__id_us__1DB06A4F] FOREIGN KEY ([id_user]) REFERENCES [logistics].[tbl_users] ([id_user]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_incomes] ADD CONSTRAINT [FK__tbl_incom__id_de__1EA48E88] FOREIGN KEY ([id_delivery]) REFERENCES [logistics].[tbl_deliveries] ([id_delivery]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_kilometers
-- ----------------------------
ALTER TABLE [logistics].[tbl_kilometers] ADD CONSTRAINT [FK__tbl_kilom__id_de__160F4887] FOREIGN KEY ([id_delivery]) REFERENCES [logistics].[tbl_deliveries] ([id_delivery]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_kilometers] ADD CONSTRAINT [FK__tbl_kilom__id_ve__17036CC0] FOREIGN KEY ([id_vehicle]) REFERENCES [logistics].[tbl_vehicles] ([id_vehicle]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_kilometers] ADD CONSTRAINT [FK__tbl_kilom__id_al__17F790F9] FOREIGN KEY ([id_alert]) REFERENCES [logistics].[tbl_alert_statuses] ([id_alert]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_maintenance_requests
-- ----------------------------
ALTER TABLE [logistics].[tbl_maintenance_requests] ADD CONSTRAINT [FK__tbl_maint__id_ve__04E4BC85] FOREIGN KEY ([id_vehicle]) REFERENCES [logistics].[tbl_vehicles] ([id_vehicle]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_maintenance_requests] ADD CONSTRAINT [FK__tbl_maint__appro__05D8E0BE] FOREIGN KEY ([approved_by]) REFERENCES [logistics].[tbl_users] ([id_user]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_maintenances
-- ----------------------------
ALTER TABLE [logistics].[tbl_maintenances] ADD CONSTRAINT [FK__tbl_maint__id_ve__00200768] FOREIGN KEY ([id_vehicle]) REFERENCES [logistics].[tbl_vehicles] ([id_vehicle]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_municipalities
-- ----------------------------
ALTER TABLE [logistics].[tbl_municipalities] ADD CONSTRAINT [FK__tbl_munic__id_de__3E52440B] FOREIGN KEY ([id_department]) REFERENCES [logistics].[tbl_departments] ([id_department]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_roles_has_users
-- ----------------------------
ALTER TABLE [logistics].[tbl_roles_has_users] ADD CONSTRAINT [FK__tbl_roles__id_us__4BAC3F29] FOREIGN KEY ([id_user]) REFERENCES [logistics].[tbl_users] ([id_user]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_roles_has_users] ADD CONSTRAINT [FK__tbl_roles__id_ro__4CA06362] FOREIGN KEY ([id_role]) REFERENCES [logistics].[tbl_roles] ([id_role]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO


-- ----------------------------
-- Foreign Keys structure for table tbl_routes
-- ----------------------------
ALTER TABLE [logistics].[tbl_routes] ADD CONSTRAINT [FK__tbl_route__id_or__68487DD7] FOREIGN KEY ([id_origin]) REFERENCES [logistics].[tbl_municipalities] ([id_municipality]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE [logistics].[tbl_routes] ADD CONSTRAINT [FK__tbl_route__id_de__693CA210] FOREIGN KEY ([id_destination]) REFERENCES [logistics].[tbl_municipalities] ([id_municipality]) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

