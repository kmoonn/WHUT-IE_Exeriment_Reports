/*
 Navicat Premium Data Transfer

 Source Server         : MSSQL
 Source Server Type    : SQL Server
 Source Server Version : 15002000
 Source Host           : localhost:1433
 Source Catalog        : students
 Source Schema         : dbo

 Target Server Type    : SQL Server
 Target Server Version : 15002000
 File Encoding         : 65001

 Date: 01/11/2022 13:28:10
*/


-- ----------------------------
-- Table structure for Student
-- ----------------------------
IF EXISTS (SELECT * FROM sys.all_objects WHERE object_id = OBJECT_ID(N'[dbo].[Student]') AND type IN ('U'))
	DROP TABLE [dbo].[Student]
GO

CREATE TABLE [dbo].[Student] (
  [sno] int  NOT NULL,
  [sname] varchar(50) COLLATE Chinese_PRC_CI_AS  NULL,
  [ssex] nchar(10) COLLATE Chinese_PRC_CI_AS DEFAULT '男' NOT NULL
)
GO

ALTER TABLE [dbo].[Student] SET (LOCK_ESCALATION = TABLE)
GO


-- ----------------------------
-- Records of Student
-- ----------------------------
INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121031323', N'文章 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121031324', N'罗杰 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121031325', N'卫佳 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121031326', N'郭昱 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121031329', N'闻锋 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121096011', N'李四 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121096012', N'张洁 ', N'女         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'121096018', N'夏林 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'312020001', N'胡姗 ', N'女         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'312021001', N'张三 ', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'312021520', N'李佳明', N'男         ')
GO

INSERT INTO [dbo].[Student] ([sno], [sname], [ssex]) VALUES (N'2018', N'hushan', N'男         ')
GO

