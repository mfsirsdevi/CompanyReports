USE [master]
GO
/****** Object:  Database [CompanyReports]    Script Date: 6/8/2017 1:08:26 PM ******/
CREATE DATABASE [CompanyReports]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CompanyReports', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CompanyReports.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CompanyReports_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CompanyReports_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CompanyReports] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CompanyReports].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CompanyReports] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CompanyReports] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CompanyReports] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CompanyReports] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CompanyReports] SET ARITHABORT OFF 
GO
ALTER DATABASE [CompanyReports] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CompanyReports] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CompanyReports] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CompanyReports] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CompanyReports] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CompanyReports] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CompanyReports] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CompanyReports] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CompanyReports] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CompanyReports] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CompanyReports] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CompanyReports] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CompanyReports] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CompanyReports] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CompanyReports] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CompanyReports] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CompanyReports] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CompanyReports] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CompanyReports] SET  MULTI_USER 
GO
ALTER DATABASE [CompanyReports] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CompanyReports] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CompanyReports] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CompanyReports] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CompanyReports] SET DELAYED_DURABILITY = DISABLED 
GO
USE [CompanyReports]
GO
/****** Object:  Table [dbo].[tbl_report]    Script Date: 6/8/2017 1:08:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_report](
	[int_reportid] [int] IDENTITY(1,1) NOT NULL,
	[str_title] [varchar](50) NULL,
	[int_subscriptionid] [int] NULL,
	[str_summary] [varchar](50) NULL,
	[str_analyst] [varchar](50) NULL,
	[str_url] [varchar](50) NULL,
	[bit_active] [bit] NULL,
	[dtm_createddate] [datetime] NULL,
	[dtm_lastmodifieddate] [datetime] NULL,
	[bit_urlupdated] [bit] NULL,
	[int_analystid] [int] NULL,
	[str_teaser] [varchar](50) NULL,
	[bit_featured_webinar] [bit] NULL,
	[str_src_path] [varchar](50) NULL,
	[bit_dummy] [bit] NULL,
	[bit_addtoapp] [bit] NULL,
	[str_webinarurl] [varchar](50) NULL,
	[bit_admindisplay] [bit] NULL,
	[bit_secondlookhide] [bit] NULL,
	[bit_secondlookhide_cnt] [bit] NULL,
	[bit_secondlookhide_fd] [bit] NULL,
 CONSTRAINT [PK_tbl_report] PRIMARY KEY CLUSTERED 
(
	[int_reportid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_user_info]    Script Date: 6/8/2017 1:08:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_user_info](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[UserEmail] [varchar](50) NULL,
	[UserPassword] [varchar](50) NULL,
	[UserTokenId] [varchar](50) NULL,
	[UserCreatedAt] [datetime] NULL CONSTRAINT [DF_tbl_user_info_UserCreatedAt]  DEFAULT (getdate()),
	[UserUpdatedAt] [datetime] NULL CONSTRAINT [DF_tbl_user_info_UserUpdatedAt]  DEFAULT (getdate()),
 CONSTRAINT [PK_tbl_user_info] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_report] ON 

INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (1, N'Duckwall-Alco Stores, Inc', 5, N'3Q Ended October 31, 2004', N'David Silverman', N'DUCKWALL3Q.swf', 1, CAST(N'2005-06-16 12:43:00.000' AS DateTime), CAST(N'2005-01-04 00:00:00.000' AS DateTime), 0, 0, NULL, NULL, N'DUCKWALL3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (2, N'Charming Shoppes, Inc', 5, N'3Q Ended October 30, 2004', N'Joe Sforza', N'CHARMING3Q.swf', 1, CAST(N'2005-06-16 12:37:00.000' AS DateTime), CAST(N'2005-01-05 00:00:00.000' AS DateTime), 0, 5, NULL, NULL, N'CHARMING3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (3, N'Federated Department Stores', 5, N'Third Quarter Ended October 30, 2004', N'Joe Sforza', N'FEDERATED3Q.swf', 1, CAST(N'2005-06-16 12:57:00.000' AS DateTime), CAST(N'2005-01-07 00:00:00.000' AS DateTime), 0, 5, NULL, NULL, N'FEDERATED3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (4, N'Freds, Inc.', 5, N'3Q Ended October 30, 2004', N'Joe Stigler', N'FREDS3Q.swf', 1, CAST(N'2005-06-16 12:59:00.000' AS DateTime), CAST(N'2005-01-06 00:00:00.000' AS DateTime), 0, 7, NULL, NULL, N'FREDS3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (5, N'J.C. Penney Corporation', 5, N'3Q Ended October 30, 2004', N'Joe Sforza', N'JCPENNEY3Q.swf', 1, CAST(N'2005-06-16 13:28:00.000' AS DateTime), CAST(N'2005-01-05 00:00:00.000' AS DateTime), 0, 5, NULL, NULL, N'JCPENNEY3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (6, N'PETsMART, Inc.', 5, N'3Q Ended October 31, 2004', N'Dave Silverman', N'PETSMART3Q.swf', 1, CAST(N'2005-06-16 13:39:00.000' AS DateTime), CAST(N'2005-01-05 00:00:00.000' AS DateTime), 0, 1, NULL, NULL, N'PETSMART3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (7, N'Ross Stores, Inc', 5, N'3Q Ended October 30, 2004', N'David Silverman', N'ROSS3Q.swf', 1, CAST(N'2005-06-16 15:03:00.000' AS DateTime), CAST(N'2005-01-06 00:00:00.000' AS DateTime), 0, 0, NULL, NULL, N'ROSS3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (8, N'Shoe Carnival, Inc.', 5, N'3Q Ended October 30, 2004', N'david Silverman', N'SHOECARNIVAL3Q.swf', 1, CAST(N'2005-06-16 15:09:00.000' AS DateTime), CAST(N'2005-01-03 00:00:00.000' AS DateTime), 0, 0, NULL, NULL, N'SHOECARNIVAL3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (9, N'Hip Interactive Corp.', 5, N'3Q Ended December 31, 2004', N'David Silverman', N'HIP_INTERACTIVE3Q.swf', 1, CAST(N'2005-06-17 09:33:00.000' AS DateTime), CAST(N'2005-03-04 00:00:00.000' AS DateTime), 0, 0, NULL, NULL, N'HIP_INTERACTIVE3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (10, N'Sears, Roebuck & Co.', 5, N'FYE January 1, 2005', N'Joe Sforza', N'SEARS4Q.swf', 1, CAST(N'2005-06-17 09:35:00.000' AS DateTime), CAST(N'2005-03-03 00:00:00.000' AS DateTime), 0, 5, NULL, NULL, N'SEARS4Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (11, N'Sport Chalet, Inc.', 5, N'3Q Ended December 31, 2004', N'Michael Blackburn', N'SPORTCHALET3Q.swf', 1, CAST(N'2005-06-17 09:38:00.000' AS DateTime), CAST(N'2005-03-04 00:00:00.000' AS DateTime), 0, 8, NULL, NULL, N'SPORTCHALET3Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[tbl_report] ([int_reportid], [str_title], [int_subscriptionid], [str_summary], [str_analyst], [str_url], [bit_active], [dtm_createddate], [dtm_lastmodifieddate], [bit_urlupdated], [int_analystid], [str_teaser], [bit_featured_webinar], [str_src_path], [bit_dummy], [bit_addtoapp], [str_webinarurl], [bit_admindisplay], [bit_secondlookhide], [bit_secondlookhide_cnt], [bit_secondlookhide_fd]) VALUES (12, N'Staples, Inc.', 5, N'Staples, Inc.', N'David Silverman', N'STAPLES4Q.swf', 1, CAST(N'2005-06-17 09:48:00.000' AS DateTime), CAST(N'2005-03-03 00:00:00.000' AS DateTime), 0, 0, NULL, NULL, N'STAPLES4Q.swf', NULL, NULL, NULL, 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_report] OFF
SET IDENTITY_INSERT [dbo].[tbl_user_info] ON 

INSERT [dbo].[tbl_user_info] ([UserId], [UserName], [UserEmail], [UserPassword], [UserTokenId], [UserCreatedAt], [UserUpdatedAt]) VALUES (1, N'satya', N'satyapriya.baral@gmail.com', N'C827E7A28167122EB7E96E9A3CE629FA', NULL, CAST(N'2017-06-06 16:34:09.630' AS DateTime), CAST(N'2017-06-06 16:34:09.630' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbl_user_info] OFF
USE [master]
GO
ALTER DATABASE [CompanyReports] SET  READ_WRITE 
GO
