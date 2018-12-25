USE [master]
GO
/****** Object:  Database [WorkManagerment]    Script Date: 12/21/2018 9:31:31 PM ******/
CREATE DATABASE [WorkManagerment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WorkManagerment', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WorkManagerment.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WorkManagerment_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WorkManagerment_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WorkManagerment] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WorkManagerment].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WorkManagerment] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WorkManagerment] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WorkManagerment] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WorkManagerment] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WorkManagerment] SET ARITHABORT OFF 
GO
ALTER DATABASE [WorkManagerment] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [WorkManagerment] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [WorkManagerment] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WorkManagerment] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WorkManagerment] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WorkManagerment] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WorkManagerment] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WorkManagerment] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WorkManagerment] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WorkManagerment] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WorkManagerment] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WorkManagerment] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WorkManagerment] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WorkManagerment] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WorkManagerment] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WorkManagerment] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WorkManagerment] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WorkManagerment] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WorkManagerment] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WorkManagerment] SET  MULTI_USER 
GO
ALTER DATABASE [WorkManagerment] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WorkManagerment] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WorkManagerment] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WorkManagerment] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WorkManagerment]
GO
/****** Object:  StoredProcedure [dbo].[sp_getAllByProjectIdAndEmployeeId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getAllByProjectIdAndEmployeeId]
@ProjectId int,
@EmployeeId int
as
begin
select pm.ProjectMemberId,pm.ProjectMemberStatus,gp.GrantPermissionId,gp.GrantPermissionStatus,
de.DepartmentEmployeeId,de.DepartmentEmployeeStatus,d.DepartmentId,d.DepartmentName,d.DepartmentStatus,
e.EmployeeId,e.EmployeeFullname,r.RoleId,r.RoleName,r.RoleStatus,pt.ProjectTypeId,pt.ProjectTypeName,pt.ProjectTypeStatus,
p.ProjectId,p.ProjectName from ProjectMembers as pm , GrantPermissions as gp , DepartmentEmployees as de, Departments as d, Employees as e, Roles as r, ProjectType as pt ,Projects as p
where pm.GrantPermissionId = gp.GrantPermissionId and pm.ProjectId = p.ProjectId and p.ProjectTypeId = pt.ProjectTypeId and gp.DepartmentEmployeeId = de.DepartmentEmployeeId and
de.DepartmentId = d.DepartmentId and de.EmployeeId  = e.EmployeeId and gp.RoleId = r.RoleId and p.ProjectId = @ProjectId and e.EmployeeId =@EmployeeId
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getAllDepartmentByEmployeeId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getAllDepartmentByEmployeeId]
@so int
as
begin 
select DISTINCT d.DepartmentName,d.DepartmentId from Employees as e , Departments as d, DepartmentEmployees as de
where e.EmployeeId = de.EmployeeId and d.DepartmentId = de.DepartmentId and e.EmployeeId = @so
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllEmployeeByDepartment]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[sp_GetAllEmployeeByDepartment]
as
begin
	select e.EmployeeId,e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,
	e.EmployeeEmail,e.EmployeeFullname,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,
	e.EmployeeStatus,e.EmployeeGender,d.DepartmentId,d.DepartmentName,d.DepartmentStatus,d.ParentId from Employees as e , Departments as d,DepartmentEmployees as de
	where e.EmployeeId = de.EmployeeId and d.DepartmentId = de.DepartmentId and e.EmployeeStatus != 2 and d.DepartmentStatus = 1
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllEmployeeByProjectID]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_GetAllEmployeeByProjectID]
@so int
as
begin
select pm.ProjectId,pm.ProjectMemberStatus,pm.ProjectMemberId,gp.GrantPermissionId,gp.GrantPermissionStatus,gp.RoleId,
de.DepartmentEmployeeId,de.DepartmentEmployeeStatus,e.EmployeeId,e.EmployeeFullname,d.DepartmentId,d.DepartmentName from ProjectMembers as pm , GrantPermissions as gp , DepartmentEmployees as de, Employees as e,Departments as d
where pm.GrantPermissionId = gp.GrantPermissionId and gp.DepartmentEmployeeId = de.DepartmentEmployeeId and
de.EmployeeId = e.EmployeeId and de.DepartmentId = d.DepartmentId and pm.ProjectId = @so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getAllEmployeeByRoleID]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getAllEmployeeByRoleID]
@so int
as
begin
select gp.GrantPermissionId,gp.GrantPermissionStatus,de.DepartmentEmployeeId,de.DepartmentEmployeeStatus,d.DepartmentId,d.DepartmentName,
e.EmployeeId,e.EmployeeFullname,r.RoleId,r.RoleName from GrantPermissions as gp , DepartmentEmployees as de , Departments as d, Employees as e,Roles as r where
gp.RoleId = r.RoleId and gp.DepartmentEmployeeId = de.DepartmentEmployeeId and de.DepartmentId = d.DepartmentId and de.EmployeeId = e.EmployeeId and
r.RoleId = @so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getAllPermissionsNameByRoleId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getAllPermissionsNameByRoleId]
@so int
as
begin
select p.PermissionName from Permissions as p , ManagerZones as m , SetPermissions as sp 
where p.PermissionId = sp.PermissionId and m.ManagerZoneId = sp.ManagerZoneId and sp.RoleId = @so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getAllProjectDiscussionsByProjectId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getAllProjectDiscussionsByProjectId]
@so int
as
begin
select pd.DiscussionContent,pd.ProjectDiscussionId,pd.ProjectDiscussionStatus,
md.MemberDiscussionId,md.MemberDiscussionStatus,md.ProjectId,md.ProjectMemberId,e.EmployeeId,e.EmployeeAvatar,e.EmployeeFullname from ProjectDiscussions as pd , MemberDiscussions as md, Employees as e
where pd.MemberDiscussionId = md.MemberDiscussionId and md.EmployeeId = e.EmployeeId and md.ProjectId = @so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllYEARByProjectType]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_GetAllYEARByProjectType]
as
begin
select DISTINCT YEAR(StartTime) as ProjectYear from Projects where ProjectTypeId =2
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereDepartmentId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getEmployeeByDepartmentWhereDepartmentId]
@so int 
as
begin
select e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,e.EmployeeEmail,
e.EmployeeFullname,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,e.EmployeeStatus,
e.EmployeeGender,d.DepartmentName,d.DepartmentStatus,d.ParentId,de.DepartmentEmployeeId
,de.DepartmentEmployeeStatus,de.DepartmentId,de.EmployeeId from Employees as e, Departments as d, DepartmentEmployees as de
where d.DepartmentId=de.DepartmentId and e.EmployeeId=de.EmployeeId and e.EmployeeStatus =1 and d.DepartmentStatus=1 and d.DepartmentId=@so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereEmployeeId]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getEmployeeByDepartmentWhereEmployeeId]
@so int 
as
begin
select e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,e.EmployeeEmail,
e.EmployeeFullname,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,e.EmployeeStatus,
e.EmployeeGender,d.DepartmentName,d.DepartmentStatus,d.ParentId,de.DepartmentEmployeeId
,de.DepartmentEmployeeStatus,de.DepartmentId,de.EmployeeId from Employees as e, Departments as d, DepartmentEmployees as de
where d.DepartmentId=de.DepartmentId and e.EmployeeId=de.EmployeeId and e.EmployeeStatus =1 and d.DepartmentStatus=1 and e.EmployeeId=@so
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereEmployeeIds]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getEmployeeByDepartmentWhereEmployeeIds]
@so int 
as
begin
select e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,e.EmployeeEmail,
e.EmployeeFullname,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,e.EmployeeStatus,
e.EmployeeGender,e.EmployeeAccountName,e.EmployeeAccountNumber,e.EmployeeCode,e.EmployeeType,d.DepartmentName,d.DepartmentStatus,d.ParentId,de.DepartmentEmployeeId
,de.DepartmentEmployeeStatus,de.DepartmentId,de.EmployeeId from Employees as e, Departments as d, DepartmentEmployees as de
where d.DepartmentId=de.DepartmentId and e.EmployeeId=de.EmployeeId and e.EmployeeStatus =1 and d.DepartmentStatus=1 and e.EmployeeId=@so
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByRole]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getEmployeeByRole]
as
begin
select e.EmployeeId,e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,e.EmployeeEmail,e.EmployeeFullname,
e.EmployeeGender,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,e.EmployeeStatus,d.DepartmentName,d.DepartmentId,d.DepartmentStatus,d.ParentId,
de.DepartmentEmployeeId,de.DepartmentEmployeeStatus,r.RoleId,r.RoleName,r.RoleStatus,g.GrantPermissionId from Employees as e , Departments as d ,DepartmentEmployees as de,Roles as r,GrantPermissions as g
where e.EmployeeId = de.EmployeeId and d.DepartmentId = de.DepartmentId and de.DepartmentEmployeeId = g.DepartmentEmployeeId and r.RoleId = g.RoleId and e.EmployeeStatus =1 and d.DepartmentStatus =1 and de.DepartmentEmployeeStatus = 1 and r.RoleStatus =1
end
GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByRoleByDepartment]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_getEmployeeByRoleByDepartment]
@so int
as
begin
select e.EmployeeId,e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,e.EmployeeEmail,e.EmployeeFullname,
e.EmployeeGender,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,e.EmployeeStatus,d.DepartmentName,d.DepartmentId,d.DepartmentStatus,d.ParentId,
de.DepartmentEmployeeId,de.DepartmentEmployeeStatus,r.RoleId,r.RoleName,r.RoleStatus,g.GrantPermissionId from Employees as e , Departments as d ,DepartmentEmployees as de,Roles as r,GrantPermissions as g
where e.EmployeeId = de.EmployeeId and d.DepartmentId = de.DepartmentId and de.DepartmentEmployeeId = g.DepartmentEmployeeId and r.RoleId = g.RoleId and e.EmployeeStatus =1 and d.DepartmentStatus =1 and de.DepartmentEmployeeStatus = 1 and r.RoleStatus =1 and d.DepartmentId = @so
end
GO
/****** Object:  Table [dbo].[ChatDetails]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatDetails](
	[ChatDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ChatId] [int] NOT NULL,
	[Content] [ntext] NOT NULL,
	[Sender] [int] NOT NULL,
	[SendTime] [datetime] NOT NULL,
	[ChatDetailStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChatDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chats]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chats](
	[ChatId] [int] IDENTITY(1,1) NOT NULL,
	[FirstMember] [int] NOT NULL,
	[SecondMember] [int] NOT NULL,
	[ChatStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Comments](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[CommentContent] [ntext] NOT NULL,
	[CommentImage] [varchar](250) NULL,
	[ParentId] [int] NOT NULL,
	[PostId] [int] NULL,
	[TimeLineDetailId] [int] NULL,
	[EmployeeId] [int] NOT NULL,
	[CommentTime] [datetime] NOT NULL,
	[CommentStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DepartmentEmployees]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentEmployees](
	[DepartmentEmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[DepartmentEmployeeStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentEmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Departments]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](250) NOT NULL,
	[ParentId] [int] NOT NULL,
	[DepartmentStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Emotions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Emotions](
	[EmotionId] [int] IDENTITY(1,1) NOT NULL,
	[EmotionType] [nvarchar](250) NOT NULL,
	[EmotionIcon] [varchar](250) NOT NULL,
	[EmotionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeFullname] [nvarchar](250) NOT NULL,
	[EmployeeBirthday] [date] NOT NULL,
	[EmployeeIdCard] [varchar](20) NOT NULL,
	[EmployeePhone] [varchar](20) NOT NULL,
	[EmployeeAddress] [ntext] NULL,
	[EmployeeEmail] [varchar](250) NOT NULL,
	[EmployeePassword] [varchar](250) NOT NULL,
	[EmployeeAvatar] [varchar](250) NOT NULL,
	[EmployeeCoverPicture] [varchar](250) NOT NULL,
	[EmployeeStatus] [int] NOT NULL,
	[EmployeeGender] [int] NULL,
	[EmployeeCode] [varchar](20) NULL,
	[EmployeeAccountNumber] [varchar](20) NULL,
	[EmployeeAccountName] [varchar](20) NULL,
	[EmployeeType] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Files]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Files](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](250) NOT NULL,
	[FolderId] [int] NULL,
	[EmployeeId] [int] NULL,
	[ProjectId] [int] NULL,
	[FileStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Folders]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Folders](
	[FolderId] [int] IDENTITY(1,1) NOT NULL,
	[FolderName] [nvarchar](250) NOT NULL,
	[ParentId] [int] NOT NULL,
	[EmployeeId] [int] NULL,
	[ProjectId] [int] NULL,
	[FolderStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FolderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forms]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forms](
	[FormId] [int] IDENTITY(1,1) NOT NULL,
	[FormContent] [ntext] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[FormStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FormId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Forwards]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forwards](
	[ForwardId] [int] IDENTITY(1,1) NOT NULL,
	[SmallStepId] [int] NULL,
	[SendStepId] [int] NULL,
	[ReceiverStepId] [int] NOT NULL,
	[TypeSend] [int] NOT NULL,
	[ForwardStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ForwardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GrantPermissions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrantPermissions](
	[GrantPermissionId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[DepartmentEmployeeId] [int] NOT NULL,
	[GrantPermissionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GrantPermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupChatDetails]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupChatDetails](
	[GroupChatDetailId] [int] IDENTITY(1,1) NOT NULL,
	[GroupChatMemberId] [int] NOT NULL,
	[GroupChatDetailContent] [ntext] NOT NULL,
	[GroupChatDetailTime] [datetime] NOT NULL,
	[GroupChatMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupChatDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupChatMembers]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupChatMembers](
	[GroupChatMemberId] [int] IDENTITY(1,1) NOT NULL,
	[GroupChatId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Adder] [int] NOT NULL,
	[AddedTime] [datetime] NOT NULL,
	[GroupChatMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupChatMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupChats]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupChats](
	[GroupChatId] [int] IDENTITY(1,1) NOT NULL,
	[GroupChatName] [nvarchar](250) NULL,
	[EmployeeId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[GroupChatStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupChatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupMembers]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMembers](
	[GroupMemberId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[GroupRole] [nvarchar](250) NOT NULL,
	[GroupMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Groups]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](250) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[EmployeeId] [int] NULL,
	[GroupType] [int] NOT NULL,
	[GroupStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Likes]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[LikeId] [int] IDENTITY(1,1) NOT NULL,
	[CommentId] [int] NULL,
	[PostId] [int] NULL,
	[TimeLineDetailId] [int] NULL,
	[EmployeeId] [int] NULL,
	[EmotionId] [int] NOT NULL,
	[LikeStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LikeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ManagerZones]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerZones](
	[ManagerZoneId] [int] IDENTITY(1,1) NOT NULL,
	[ManagerZoneName] [nvarchar](250) NOT NULL,
	[ManagerZoneStatus] [int] NOT NULL,
	[DisplayNameController] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ManagerZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MemberDiscussions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MemberDiscussions](
	[MemberDiscussionId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[ProjectMemberId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[MemberDiscussionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberDiscussionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Notes]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[NoteId] [int] IDENTITY(1,1) NOT NULL,
	[NoteContent] [ntext] NOT NULL,
	[EmployeeId] [int] NULL,
	[SmallStepMemberId] [int] NULL,
	[NoteStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [nvarchar](250) NOT NULL,
	[PermissionStatus] [int] NOT NULL,
	[ManagerZoneID] [nvarchar](250) NULL,
	[DisplayNameAction] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Plans]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plans](
	[PlanId] [int] IDENTITY(1,1) NOT NULL,
	[PlanContent] [ntext] NOT NULL,
	[GrantPermissionId] [int] NOT NULL,
	[PlanStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostImages]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PostImages](
	[PostImageId] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[PostImage] [varchar](250) NOT NULL,
	[PostImageStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[GroupMemberId] [int] NOT NULL,
	[PostContent] [ntext] NOT NULL,
	[PostedTime] [datetime] NOT NULL,
	[PostStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectDiscussions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectDiscussions](
	[ProjectDiscussionId] [int] IDENTITY(1,1) NOT NULL,
	[MemberDiscussionId] [int] NOT NULL,
	[DiscussionContent] [ntext] NOT NULL,
	[ProjectDiscussionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectDiscussionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectMembers](
	[ProjectMemberId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[GrantPermissionId] [int] NOT NULL,
	[ProjectMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Projects]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](250) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ProjectDescription] [ntext] NOT NULL,
	[ProjectStatus] [int] NOT NULL,
	[ProjectTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProjectType]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectType](
	[ProjectTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectTypeName] [nvarchar](50) NOT NULL,
	[ProjectTypeStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reminds]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reminds](
	[RemindId] [int] IDENTITY(1,1) NOT NULL,
	[RemindContent] [ntext] NOT NULL,
	[RemindTime] [datetime] NOT NULL,
	[EmployeeId] [int] NULL,
	[ProjectId] [int] NULL,
	[DepartmentId] [int] NULL,
	[RemindStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RemindId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reports]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reports](
	[ReportId] [int] IDENTITY(1,1) NOT NULL,
	[ReportContent] [ntext] NOT NULL,
	[ReportTime] [datetime] NOT NULL,
	[ReportStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](250) NOT NULL,
	[RoleStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SetPermissions]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetPermissions](
	[SetPermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[ManagerZoneId] [int] NOT NULL,
	[SetPermissionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SetPermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shares]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shares](
	[ShareId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[TimeLineId] [int] NULL,
	[TimeLineDetailId] [int] NULL,
	[GroupId] [int] NULL,
	[PostId] [int] NULL,
	[ShareType] [int] NOT NULL,
	[SharePrivacy] [int] NOT NULL,
	[ShareStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ShareId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SmallStepComment]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SmallStepComment](
	[SmallStepCommentId] [int] IDENTITY(1,1) NOT NULL,
	[SmallStepCommentContent] [ntext] NOT NULL,
	[SmallStepCommentImage] [varchar](250) NULL,
	[SmallStepId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[SmallStepCommentTime] [datetime] NOT NULL,
	[SmallStepCommentStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SmallStepMembers]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SmallStepMembers](
	[SmallStepMemberId] [int] IDENTITY(1,1) NOT NULL,
	[SmallStepId] [int] NOT NULL,
	[StepMemberId] [int] NOT NULL,
	[SmallStepMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SmallStepPriorityLevel]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SmallStepPriorityLevel](
	[SmallStepPriorityLevelId] [int] IDENTITY(1,1) NOT NULL,
	[SmallStepPriorityLevelColor] [varchar](50) NOT NULL,
	[SmallStepId] [int] NOT NULL,
	[SmallStepPriorityLevelStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepPriorityLevelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SmallSteps]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SmallSteps](
	[SmallStepId] [int] IDENTITY(1,1) NOT NULL,
	[StepId] [int] NOT NULL,
	[SmallStepDescription] [ntext] NOT NULL,
	[SmallStepStatus] [int] NOT NULL,
	[SmallStepDescriptionDetail] [ntext] NULL,
	[SmallStepLocation] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SmallStepWorkToDo]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SmallStepWorkToDo](
	[SmallStepWorkToDoId] [int] IDENTITY(1,1) NOT NULL,
	[SmallStepWorkToDoContent] [ntext] NOT NULL,
	[SmallStepId] [int] NOT NULL,
	[SmallStepWorkToDoStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepWorkToDoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StepMembers]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StepMembers](
	[StepMemberId] [int] IDENTITY(1,1) NOT NULL,
	[StepId] [int] NOT NULL,
	[ProjectMemberId] [int] NOT NULL,
	[StepMemberStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StepMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Steps]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Steps](
	[StepId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[StepName] [nvarchar](250) NOT NULL,
	[StepDescription] [ntext] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[StepStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimeLineDetails]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeLineDetails](
	[TimeLineDetailId] [int] IDENTITY(1,1) NOT NULL,
	[TimeLineId] [int] NOT NULL,
	[TimeLineDetailContent] [ntext] NOT NULL,
	[TimeLineDetailPostedTime] [datetime] NOT NULL,
	[TimeLineDetailType] [int] NOT NULL,
	[TimeLineDetailStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeLineDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimeLineImages]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeLineImages](
	[TimeLineImageId] [int] IDENTITY(1,1) NOT NULL,
	[TimeLineDetailId] [int] NOT NULL,
	[TimeLineImage] [varchar](250) NOT NULL,
	[TimeLineImageStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeLineImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TimeLines]    Script Date: 12/21/2018 9:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeLines](
	[TimeLineId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NULL,
	[TimeLineStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[DepartmentEmployees] ON 

INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (1, 2, 2, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (2, 3, 3, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (3, 2, 1, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (4, 5, 4, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (5, 4, 5, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (6, 1, 6, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (7, 2, 7, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (8, 3, 8, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (9, 5, 9, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (10, 3, 11, 1)
INSERT [dbo].[DepartmentEmployees] ([DepartmentEmployeeId], [DepartmentId], [EmployeeId], [DepartmentEmployeeStatus]) VALUES (11, 5, 12, 1)
SET IDENTITY_INSERT [dbo].[DepartmentEmployees] OFF
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (1, N'Phòng Kế Toán', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (2, N'Phòng Lập Trình', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (3, N'Phòng Tổng Hợp', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (4, N'Phòng Hành Chính', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (5, N'Phòng DEMO', 0, 1)
SET IDENTITY_INSERT [dbo].[Departments] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (1, N'admin', CAST(0x091B0B00 AS Date), N'10059001000', N'0934342020', N'aaaaaaaaaaaaaaaa', N'admin@devhitech.vn', N'ae1d48c817ca14b5fa0706b638a8d376', N'avatar_defaulte.png', N'anh_bia.jpg', 1, 1, N'DevHiTech-3', N'', N'', 1)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (2, N'demo1', CAST(0x091B0B00 AS Date), N'10059001001', N'0934342021', N'só 8 ngách 14 ngõ 124 Minh khai', N'demo@gmail.com', N'81dc9bdb52d04dc20036dbd8313ed055', N'avata.jpg', N'sort_asc.png', 1, 1, N'DevHiTech-1', N'aaaaa1216', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (3, N'demo2', CAST(0x091B0B00 AS Date), N'10059001002', N'0934342022', N'só 8 ngách 14 ngõ 124 Minh khai', N'demo2@gmail.com', N'81dc9bdb52d04dc20036dbd8313ed055', N'avata.jpg', N'sort_desc_disabled.png', 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (4, N'demo3', CAST(0x091B0B00 AS Date), N'10059001003', N'0934342023', N'số 8 ngách 14 ngõ 124 minh khai', N'demo3@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'yahoo_icon3.jpg', N'yahoo_icon2.jpg', 1, 1, NULL, N'aaaaa12', N'aaaaa1212', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (5, N'demo4', CAST(0x091B0B00 AS Date), N'10059001004', N'0934342024', N'số 8 ngách 14 ngõ 124 minh khai hà nội', N'demo4@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'yahoo_icon1.png', N'edit_img.png', 1, 1, NULL, N'aaaaa12111', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (6, N'demo5', CAST(0x091B0B00 AS Date), N'10059001005', N'0934342025', N'số 8 ngách 14 ngõ 124 minh khai', N'demo5@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'clipboard_clear.png', N'copy.png', 1, 1, NULL, N'aaaaa1216', N'aaaaa121211111122', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (7, N'demo6', CAST(0x091B0B00 AS Date), N'10059001006', N'0934342026', N'số 8 ngách 14 ngõ 124 minh khai', N'demo6@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'url.png', N'zip.png', 1, 1, NULL, N'aaaaa12111', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (8, N'demo7', CAST(0x091B0B00 AS Date), N'10059001007', N'0934342027', N'số 8 ngách 124 minh ', N'demo7@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'duplicate.png', N'download.png', 1, 1, NULL, N'aaaaa1216', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (9, N'demo8', CAST(0x091B0B00 AS Date), N'10059001008', N'0934342028', N'số 8 ngách 14 ngõ 124 minh khai', N'demo8@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'mdb.jpg', N'mid.jpg', 1, 1, NULL, N'aaaaa1216', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (11, N'demo9', CAST(0x091B0B00 AS Date), N'10059001009', N'0934342029', N'số 8 ngách 14 ngõ 124 minh khai', N'demo9@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'docx.jpg', N'ade.jpg', 1, 1, NULL, N'aaaaa1216', N'aaaaa121211111', 0)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender], [EmployeeCode], [EmployeeAccountNumber], [EmployeeAccountName], [EmployeeType]) VALUES (12, N'demo10', CAST(0x091B0B00 AS Date), N'10059001010', N'0934342030', N'số 8 ngách 14 ngõ 124 minh khai', N'demo10@gmail.com', N'ae1d48c817ca14b5fa0706b638a8d376', N'iso.jpg', N'gz.jpg', 1, 1, NULL, N'aaaaa12', N'aaaaa1212', 0)
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (1, N'demo', 2, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (2, N'project', 3, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (3, N'Cá nhân', 4, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (4, N'Quan Trọng', 5, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (5, N'Cục Quan trọng', 6, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (6, N'SubDemo', 7, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (7, N'SubProject', 8, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (8, N'Mẫu', 9, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (9, N'Mẫu1', 10, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (10, N'demo1', 11, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (11, N'demo2', 5, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (12, N'demo3', 5, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (13, N'demo4', 6, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (14, N'demo5', 6, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (15, N'demo7', 12, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (16, N'demo8', 12, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (17, N'Bao-cao-CV-tuần-Phạm-Sỹ-Hưng.xlsx', 4, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (18, N'yêu câu bổ sung và giải thích chức năng CSDL web quản lý công việc.docx', 5, 1, NULL, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (19, N'animations.html', 2, NULL, 1, 1)
INSERT [dbo].[Files] ([FileId], [FileName], [FolderId], [EmployeeId], [ProjectId], [FileStatus]) VALUES (20, N'buttons.html', 2, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[Folders] ON 

INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (1, N'This PC', 0, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (2, N'Thưc Mục Demo12', 1, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (3, N'Thư Mục Project123123123123', 1, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (4, N'Thư Mục Cá Nhân', 0, 1, NULL, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (5, N'Thư Mục Quan Trọng', 4, 1, NULL, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (6, N'Thư Mục Cực Quan Trọng', 4, 1, NULL, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (7, N'Thư Mục SubDemo', 2, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (8, N'Thư Mục SubProject', 3, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (9, N'Thư Mục Mẫu', 1, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (10, N'Thư Mục Mẫu1', 1, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (11, N'Thư Mục Demo 1', 2, NULL, 1, 1)
INSERT [dbo].[Folders] ([FolderId], [FolderName], [ParentId], [EmployeeId], [ProjectId], [FolderStatus]) VALUES (12, N'Thư Mục Mẫu 01', 4, 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[Folders] OFF
SET IDENTITY_INSERT [dbo].[Forms] ON 

INSERT [dbo].[Forms] ([FormId], [FormContent], [DepartmentId], [FormStatus]) VALUES (1, N'{key:''b1'',value:''dfd''},{key:''b2'',value:''dfId''},{key:''b3'',value:''abc''}', 2, 1)
INSERT [dbo].[Forms] ([FormId], [FormContent], [DepartmentId], [FormStatus]) VALUES (2, N'{key:''b1'',value:''abc''},{key:''b2'',value:''cab''},{key:''b3'',value:''def''},{key:''b4'',value:''opc''},{key:''b5'',value:''opcP''}', 2, 1)
INSERT [dbo].[Forms] ([FormId], [FormContent], [DepartmentId], [FormStatus]) VALUES (4, N'{key:''b1'',value:''abcd''},{key:''b2'',value:''klo''},{key:''b3'',value:''lkj''},{key:''b4'',value:''opi''},{key:''b5'',value:''oiedjd''},{key:''b6'',value:''opiedj''},{key:''b7'',value:''hoan thanh''}', 2, 1)
SET IDENTITY_INSERT [dbo].[Forms] OFF
SET IDENTITY_INSERT [dbo].[GrantPermissions] ON 

INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (1, 3, 1, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (2, 3, 2, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (3, 6, 3, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (5, 3, 4, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (6, 3, 5, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (7, 3, 6, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (8, 3, 7, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (9, 2, 8, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (10, 3, 9, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (11, 2, 10, 1)
INSERT [dbo].[GrantPermissions] ([GrantPermissionId], [RoleId], [DepartmentEmployeeId], [GrantPermissionStatus]) VALUES (12, 3, 11, 1)
SET IDENTITY_INSERT [dbo].[GrantPermissions] OFF
SET IDENTITY_INSERT [dbo].[ManagerZones] ON 

INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (1, N'DepartmentController', 1, N'Quản Lý Phòng Ban')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (2, N'EmployeeController', 1, N'Quản Lý Nhân Viên')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (3, N'FoldersController', 1, N'Quản Lý Thư Mục')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (4, N'GroupPageController', 1, N'Quản Lý Nhóm')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (5, N'HomeController', 1, N'Quản Lý Trang Chủ')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (6, N'InfomationController', 1, N'Quản Lý Thông Tin Cá Nhân')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (7, N'LoginController', 1, N'Quản Lý Đăng nhập')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (8, N'ManagerZonesController', 1, N'Quản Lý Các Khu Vực')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (9, N'RoleController', 1, N'Quản Lý Chức Vụ')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (10, N'StatisticalController', 1, N'Quản Lý Thông Kê')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (11, N'TimeLineController', 1, N'Quản Lý Dòng Thời Gian')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (13, N'PermissionsController', 1, N'Quản Lý Quyền')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (14, N'GrantPermissionsController', 1, N'Quản Lý Set Quyền Cho Chức Vụ')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (15, N'SetPermissionsController', 1, N'Quản Lý Sét Quyền')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (16, N'ManagementProtfolioController', 1, N'Quản Lý Danh Mục Quản Lý')
INSERT [dbo].[ManagerZones] ([ManagerZoneId], [ManagerZoneName], [ManagerZoneStatus], [DisplayNameController]) VALUES (17, N'NoteController', 1, N'Quản Lý Ghi Chú')
SET IDENTITY_INSERT [dbo].[ManagerZones] OFF
SET IDENTITY_INSERT [dbo].[MemberDiscussions] ON 

INSERT [dbo].[MemberDiscussions] ([MemberDiscussionId], [ProjectId], [ProjectMemberId], [EmployeeId], [MemberDiscussionStatus]) VALUES (1, 1, 1, 2, 1)
INSERT [dbo].[MemberDiscussions] ([MemberDiscussionId], [ProjectId], [ProjectMemberId], [EmployeeId], [MemberDiscussionStatus]) VALUES (2, 1, 2, 1, 1)
INSERT [dbo].[MemberDiscussions] ([MemberDiscussionId], [ProjectId], [ProjectMemberId], [EmployeeId], [MemberDiscussionStatus]) VALUES (3, 1, 3, 6, 1)
INSERT [dbo].[MemberDiscussions] ([MemberDiscussionId], [ProjectId], [ProjectMemberId], [EmployeeId], [MemberDiscussionStatus]) VALUES (4, 1, 14, 3, 1)
SET IDENTITY_INSERT [dbo].[MemberDiscussions] OFF
SET IDENTITY_INSERT [dbo].[Notes] ON 

INSERT [dbo].[Notes] ([NoteId], [NoteContent], [EmployeeId], [SmallStepMemberId], [NoteStatus]) VALUES (1, N'hhh87', 1, NULL, 1)
INSERT [dbo].[Notes] ([NoteId], [NoteContent], [EmployeeId], [SmallStepMemberId], [NoteStatus]) VALUES (2, N'bbbbbbbbbbbbbbbbbbbbbbb8', 1, NULL, 1)
INSERT [dbo].[Notes] ([NoteId], [NoteContent], [EmployeeId], [SmallStepMemberId], [NoteStatus]) VALUES (3, N'cccccccccccccccccc', 1, NULL, 2)
INSERT [dbo].[Notes] ([NoteId], [NoteContent], [EmployeeId], [SmallStepMemberId], [NoteStatus]) VALUES (4, N'ffffffffffffffffffffffffffffffffffffffffffff 55555', 1, NULL, 2)
INSERT [dbo].[Notes] ([NoteId], [NoteContent], [EmployeeId], [SmallStepMemberId], [NoteStatus]) VALUES (5, N'tttttttttttttttttt6', 1, NULL, 2)
SET IDENTITY_INSERT [dbo].[Notes] OFF
SET IDENTITY_INSERT [dbo].[Permissions] ON 

INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (64, N'DepartmentController-Create', 1, N'DepartmentController', N'Thêm mới Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (65, N'DepartmentController-Delete', 1, N'DepartmentController', N'Xóa Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (66, N'DepartmentController-Index', 1, N'DepartmentController', N'Xem Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (67, N'DepartmentController-Update', 1, N'DepartmentController', N'Sửa Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (68, N'DepartmentController-ViewCreate', 1, N'DepartmentController', N'Xem From Thêm Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (69, N'DepartmentController-ViewUpdate', 1, N'DepartmentController', N'Xem From Sửa Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (70, N'EmployeeController-CreateEmployee', 1, N'EmployeeController', N'Thêm mới Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (71, N'EmployeeController-deleteEmployee', 1, N'EmployeeController', N'Xóa Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (72, N'EmployeeController-Index', 1, N'EmployeeController', N'Xem Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (73, N'EmployeeController-loadListEmployeeByDepartment', 1, N'EmployeeController', N'Danh Sách Nhân Viên Theo Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (74, N'EmployeeController-loadModelEditEmployee', 1, N'EmployeeController', N'Xem Form Sửa Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (75, N'EmployeeController-updateEmployee', 1, N'EmployeeController', N'Sửa Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (76, N'FoldersController-Index', 1, N'FoldersController', N'Xem Thư Mục')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (77, N'GroupPageController-Index', 1, N'GroupPageController', N'Xem Nhóm')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (78, N'HomeController-About', 1, N'HomeController', N'Xem Thông Tin')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (79, N'HomeController-Contact', 1, N'HomeController', N'Xem Liên Hệ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (80, N'HomeController-Index', 1, N'HomeController', N'Xem Trang Chủ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (81, N'InfomationController-ChangePassword', 1, N'InfomationController', N'Đổi Mật khẩu ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (82, N'InfomationController-Index', 1, N'InfomationController', N'Xem Thông Tin Cá Nhân')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (83, N'InfomationController-UpdateInfomation', 1, N'InfomationController', N'Sửa Thông Tin Cá Nhân')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (84, N'InfomationController-ViewChangePassword', 1, N'InfomationController', N'Xem Form Đổi Mật Khẩu')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (85, N'LoginController-ForgotPassword', 1, N'LoginController', N'Quên Mật Khẩu')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (86, N'LoginController-Index', 1, N'LoginController', N'Xem From Đăng Nhập')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (87, N'LoginController-login', 1, N'LoginController', N'Đăng Nhập')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (88, N'LoginController-logout', 1, N'LoginController', N'Đăng Xuất')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (90, N'LoginController-ViewForgotPassword', 1, N'LoginController', N'Xem From Quên Mật Khẩu')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (92, N'ManagerZonesController-Create', 1, N'ManagerZonesController', N'Thêm Mới Khu Vục Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (93, N'ManagerZonesController-Delete', 1, N'ManagerZonesController', N'Xóa Khu Vực Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (94, N'ManagerZonesController-Index', 1, N'ManagerZonesController', N'Xem Khu Vực Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (95, N'ManagerZonesController-Update', 1, N'ManagerZonesController', N'Sửa Khu Vực Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (96, N'ManagerZonesController-ViewUpdate', 1, N'ManagerZonesController', N'Xem From Sửa Khu Vực Quản lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (97, N'RoleController-Create', 1, N'RoleController', N'Thêm Mới Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (98, N'RoleController-Delete', 1, N'RoleController', N'Xóa Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (99, N'RoleController-Index', 1, N'RoleController', N'Xem Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (100, N'RoleController-Update', 1, N'RoleController', N'Sửa Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (101, N'RoleController-ViewCreate', 1, N'RoleController', N'Xem From Thêm Mới Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (102, N'RoleController-ViewUpdate', 1, N'RoleController', N'Xem From Sửa Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (103, N'StatisticalController-Index', 1, N'StatisticalController', N'Xem Thông Kê')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (104, N'TimeLineController-Index', 1, N'TimeLineController', N'Xem Dòng Thời Gian')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (105, N'PermissionsController-Create', 1, N'PermissionsController', N'Thêm Mới Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (106, N'PermissionsController-Index', 1, N'PermissionsController', N'Xem Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (107, N'PermissionsController-Delete', 1, N'PermissionsController', N'Xóa Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (109, N'PermissionsController-ViewUpdate', 1, N'PermissionsController', N'Xem From Sửa Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (110, N'PermissionsController-loadListPermissionsManagerZone', 1, N'PermissionsController', N'Danh Sách Quyền Theo Khu Vực')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (111, N'PermissionsController-UpdatePermissions', 1, N'PermissionsController', N'Sửa Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (112, N'GrantPermissionsController-Index', 1, N'GrantPermissionsController', N'Xem Cấp Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (113, N'GrantPermissionsController-insertGrantPermissions', 1, N'GrantPermissionsController', N'Cấp Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (114, N'GrantPermissionsController-loadListEmployeeByDepartmentGranPermissions', 1, N'GrantPermissionsController', N'Danh Sách Nhân Viên Theo Phòng Ban')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (115, N'GrantPermissionsController-setGrantPermissions', 1, N'GrantPermissionsController', N'Xem From Cấp Quyền')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (116, N'HomeController-Error', 1, N'HomeController', N'Trang Lỗi ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (119, N'SetPermissionsController-deleteSetPermissions', 1, N'SetPermissionsController', N' Xóa Quyền Cho Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (120, N'SetPermissionsController-Index', 1, N'SetPermissionsController', N'Xem Quyền Cho Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (121, N'SetPermissionsController-insertSetPermissions', 1, N'SetPermissionsController', N'Cấp Quyền Cho Chức Vụ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (122, N'SetPermissionsController-loadListPermissionsManagerZone', 1, N'SetPermissionsController', N'Danh Sách Quyền Theo Khu Vực ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (123, N'SetPermissionsController-setPermissionsByManagerZone', 1, N'SetPermissionsController', N'Xem From Danh Sách Quyền Theo Khu Vực')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (124, N'NoteController-Index', 1, N'NoteController', N'Xem Ghi Chú')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (125, N'EmployeeController-loadTableEmployee', 1, N'EmployeeController', N'Danh Sách Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (126, N'ManagementProtfolioController-Index', 1, N'ManagementProtfolioController', N'Xem Danh Mục Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (127, N'HomeController-CreateProject', 1, N'HomeController', N'Thêm mới Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (128, N'HomeController-loadlistProject', 1, N'HomeController', N'Xem Danh Sách Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (129, N'HomeController-loadProgressWorking', 1, N'HomeController', N'Xem Danh Mục Quản Lý')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (130, N'NoteController-Create', 1, N'NoteController', N'Thêm Mới Ghi Chú')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (131, N'NoteController-DeleteNote', 1, N'NoteController', N'Xóa Ghi Chú')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (132, N'NoteController-LoadContentNote', 1, N'NoteController', N'Xem Nội Dung Ghi Chú')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (133, N'NoteController-updateNote', 1, N'NoteController', N'Sửa Ghi Chú')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (134, N'HomeController-CreateFolderByProject', 1, N'HomeController', N'Thêm Mới Thư Mục Trong Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (135, N'HomeController-DeleteFolder', 1, N'HomeController', N'Xóa Thư Mục')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (136, N'HomeController-insertProjectDiscussions', 1, N'HomeController', N'Thêm Mới Nội Dung Thảo Luận ')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (137, N'HomeController-loadContentChat', 1, N'HomeController', N'Xem Nội Dung Thảo Luận')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (138, N'HomeController-loadlistFileByFolderId', 1, N'HomeController', N'Xem Danh Sách File Theo Thư Mục')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (139, N'HomeController-loadlistFileByFolderIdCol6', 1, N'HomeController', N'Xem Danh Sách File Theo Thư Mục 2 Cột')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (140, N'HomeController-loadListFolderByProjectId', 1, N'HomeController', N'Xem Danh Sách Thư Mục theo Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (141, N'HomeController-loadModelAddFolder', 1, N'HomeController', N'Xem From Thêm Mới Thư Mục')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (142, N'HomeController-UpdateNameFolder', 1, N'HomeController', N'Sửa Tên Thư Mục')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (143, N'StatisticalController-GetAllProjectByYearAndMonth', 1, N'StatisticalController', N'Danh Sách Dự Án theo Năm và Tháng')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (144, N'StatisticalController-LoadListEmployeeByProject', 1, N'StatisticalController', N'Danh Sách Nhân Viên Theo Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (145, N'StatisticalController-LoadModelDetailWork', 1, N'StatisticalController', N'Xem From Nhân Viên trong Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (146, N'FoldersController-addFileByFolderId', 1, N'FoldersController', N'Thêm Mới File Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (147, N'FoldersController-addFolderByEmployee', 1, N'FoldersController', N'Thêm Mới Thư Mục Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (148, N'FoldersController-DeleteFolderByEmployee', 1, N'FoldersController', N'Xóa Thư Mục Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (149, N'FoldersController-loadlistFileByFolderIdByEmployee', 1, N'FoldersController', N'Xem Danh Sách File Theo Nhân viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (150, N'FoldersController-loadlistFileByFolderIdByEmployeeCol6', 1, N'FoldersController', N'Xem Danh Sách File Theo Nhân Viên Kiểu 2')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (151, N'FoldersController-loadListFolderByEmployee', 1, N'FoldersController', N'Xem Danh Dách Thư Mục Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (152, N'FoldersController-LoadModelAddFileByEmployee', 1, N'FoldersController', N'Xem From Thêm Mới File Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (153, N'FoldersController-LoadModelAddFolderByEmployee', 1, N'FoldersController', N'Xem From Thêm Mới Thư Mục Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (154, N'FoldersController-searchFile', 1, N'FoldersController', N'Tìm Kiếm File Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (155, N'FoldersController-UpdateNameFolderByEmployee', 1, N'FoldersController', N'Sửa Tên Thư Mục Theo Nhân Viên')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (156, N'HomeController-addFileByFolderIdByProject', 1, N'HomeController', N'Thêm Mới File Theo Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (157, N'HomeController-LoadModelAddFileByProject', 1, N'HomeController', N'Xem From Thêm Mới File Theo Dự Án')
INSERT [dbo].[Permissions] ([PermissionId], [PermissionName], [PermissionStatus], [ManagerZoneID], [DisplayNameAction]) VALUES (158, N'HomeController-searchFileByProject', 1, N'HomeController', N'Tìm Kiếm File Theo Dự Án')
SET IDENTITY_INSERT [dbo].[Permissions] OFF
SET IDENTITY_INSERT [dbo].[ProjectDiscussions] ON 

INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (1, 2, N'heloo ae', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (2, 1, N'helu', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (3, 3, N'lu he', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (4, 4, N'he he lu lu', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (5, 2, N'lu lu lolo', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (6, 2, N'lelelelelelel
', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (7, 2, N'lelelelelelel
123213123123', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (8, 2, N'zxdfcsdfdsfds', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (9, 2, N'qwe12312321312', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (10, 2, N'', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (11, 2, N'', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (12, 2, N'', 1)
INSERT [dbo].[ProjectDiscussions] ([ProjectDiscussionId], [MemberDiscussionId], [DiscussionContent], [ProjectDiscussionStatus]) VALUES (13, 2, N'aaa', 1)
SET IDENTITY_INSERT [dbo].[ProjectDiscussions] OFF
SET IDENTITY_INSERT [dbo].[ProjectMembers] ON 

INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (2, 1, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (3, 1, 7, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (4, 2, 2, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (5, 2, 8, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (6, 2, 10, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (9, 3, 5, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (10, 4, 6, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (11, 5, 10, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (12, 6, 12, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (13, 6, 9, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (14, 1, 2, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (15, 2, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (16, 3, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (17, 4, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (18, 5, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (19, 6, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (21, 7, 7, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (22, 7, 1, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (23, 7, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (24, 8, 7, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (25, 8, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (26, 8, 8, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (27, 8, 2, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (29, 9, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (30, 11, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (31, 11, 9, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (32, 11, 10, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (33, 12, 3, 1)
INSERT [dbo].[ProjectMembers] ([ProjectMemberId], [ProjectId], [GrantPermissionId], [ProjectMemberStatus]) VALUES (34, 12, 5, 1)
SET IDENTITY_INSERT [dbo].[ProjectMembers] OFF
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (1, N'Project1', CAST(0x0000A9B400000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'a', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (2, N'Project2', CAST(0x0000A9B400000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'b', 1, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (3, N'Project3', CAST(0x0000A84700000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'c', 1, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (4, N'Project4', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'd', 1, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (5, N'Project5', CAST(0x0000A84700000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'e', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (6, N'Project6', CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'f', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (7, N'Project 7', CAST(0x0000A9BB00000000 AS DateTime), CAST(0x0000A86D00000000 AS DateTime), N'aaaaaaaaaaaaa', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (8, N'Project 8', CAST(0x0000A9BB00000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'abc', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (9, N'Project 9', CAST(0x0000A2A600000000 AS DateTime), CAST(0x0000A9C700000000 AS DateTime), N'bbbbbbbttt', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (11, N'Project 10', CAST(0x0000A9BC00000000 AS DateTime), CAST(0x0000AB2900000000 AS DateTime), N'không có mô tả nào', 1, 2)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [ProjectStatus], [ProjectTypeId]) VALUES (12, N'project 11', CAST(0x0000A5AA00000000 AS DateTime), CAST(0x0000A9F200000000 AS DateTime), N'aaaaaaaaaa', 1, 1)
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET IDENTITY_INSERT [dbo].[ProjectType] ON 

INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectTypeName], [ProjectTypeStatus]) VALUES (1, N'Thường', 1)
INSERT [dbo].[ProjectType] ([ProjectTypeId], [ProjectTypeName], [ProjectTypeStatus]) VALUES (2, N'Dự Án', 2)
SET IDENTITY_INSERT [dbo].[ProjectType] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (1, N'Trưởng phòng', 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (2, N'Phó Phòng', 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (3, N'Nhân Viên', 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (4, N'nhan viên', 2)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (5, N'Thực Tập', 1)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleStatus]) VALUES (6, N'Giám Đốc', 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[SetPermissions] ON 

INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (26, 125, 1, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (70, 64, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (71, 65, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (72, 66, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (73, 67, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (74, 68, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (75, 69, 6, 1, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (76, 70, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (77, 71, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (78, 72, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (79, 73, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (80, 74, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (81, 75, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (82, 125, 6, 2, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (83, 76, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (84, 146, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (85, 147, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (86, 148, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (87, 149, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (88, 150, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (89, 151, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (90, 152, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (91, 153, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (92, 154, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (93, 155, 6, 3, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (94, 77, 6, 4, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (95, 78, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (96, 79, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (97, 80, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (98, 116, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (99, 127, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (100, 128, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (101, 129, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (102, 134, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (103, 135, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (104, 136, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (105, 137, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (106, 138, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (107, 139, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (108, 140, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (109, 141, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (110, 142, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (111, 156, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (112, 157, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (113, 158, 6, 5, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (114, 81, 6, 6, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (115, 82, 6, 6, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (116, 83, 6, 6, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (117, 84, 6, 6, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (118, 85, 6, 7, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (119, 86, 6, 7, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (120, 87, 6, 7, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (121, 88, 6, 7, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (122, 90, 6, 7, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (123, 92, 6, 8, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (124, 93, 6, 8, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (125, 94, 6, 8, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (126, 95, 6, 8, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (127, 96, 6, 8, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (128, 97, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (129, 98, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (130, 99, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (131, 100, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (132, 101, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (133, 102, 6, 9, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (134, 103, 6, 10, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (135, 143, 6, 10, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (136, 145, 6, 10, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (137, 144, 6, 10, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (138, 104, 6, 11, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (139, 105, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (140, 106, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (141, 107, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (142, 109, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (143, 110, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (144, 111, 6, 13, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (145, 112, 6, 14, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (146, 113, 6, 14, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (147, 114, 6, 14, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (148, 115, 6, 14, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (149, 119, 6, 15, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (150, 120, 6, 15, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (151, 121, 6, 15, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (152, 122, 6, 15, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (153, 123, 6, 15, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (154, 126, 6, 16, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (155, 124, 6, 17, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (156, 130, 6, 17, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (157, 131, 6, 17, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (158, 132, 6, 17, 1)
INSERT [dbo].[SetPermissions] ([SetPermissionId], [PermissionId], [RoleId], [ManagerZoneId], [SetPermissionStatus]) VALUES (159, 133, 6, 17, 1)
SET IDENTITY_INSERT [dbo].[SetPermissions] OFF
SET IDENTITY_INSERT [dbo].[TimeLines] ON 

INSERT [dbo].[TimeLines] ([TimeLineId], [EmployeeId], [TimeLineStatus]) VALUES (1, 1, 1)
INSERT [dbo].[TimeLines] ([TimeLineId], [EmployeeId], [TimeLineStatus]) VALUES (2, 2, 1)
INSERT [dbo].[TimeLines] ([TimeLineId], [EmployeeId], [TimeLineStatus]) VALUES (3, 3, 1)
SET IDENTITY_INSERT [dbo].[TimeLines] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Comments__02D47A0C527D5F1D]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Comments] ADD UNIQUE NONCLUSTERED 
(
	[CommentImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Departme__D949CC349E004E7F]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Departments] ADD UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Emotions__1ECBFC664E27B69E]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Emotions] ADD UNIQUE NONCLUSTERED 
(
	[EmotionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Emotions__3A37C6922CDB4754]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Emotions] ADD UNIQUE NONCLUSTERED 
(
	[EmotionIcon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__6E8498AAD770C3ED]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__C58F72EACE659C79]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeIdCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__D02FBE444B9106D4]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__ManagerZ__E5B1DDD8D7DFD43E]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[ManagerZones] ADD UNIQUE NONCLUSTERED 
(
	[ManagerZoneName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Permissi__0FFDA3572697FCBF]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Permissions] ADD UNIQUE NONCLUSTERED 
(
	[PermissionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__PostImag__FEC001A8C932C339]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[PostImages] ADD UNIQUE NONCLUSTERED 
(
	[PostImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Projects__BCBE781CF92AB059]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Projects] ADD UNIQUE NONCLUSTERED 
(
	[ProjectName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Roles__8A2B61601C1F56A7]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__TimeLine__F1B7FDF06C9BBC10]    Script Date: 12/21/2018 9:31:32 PM ******/
ALTER TABLE [dbo].[TimeLineImages] ADD UNIQUE NONCLUSTERED 
(
	[TimeLineImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT ((1)) FOR [Sender]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT (getdate()) FOR [SendTime]
GO
ALTER TABLE [dbo].[ChatDetails] ADD  DEFAULT ((1)) FOR [ChatDetailStatus]
GO
ALTER TABLE [dbo].[Chats] ADD  DEFAULT ((1)) FOR [ChatStatus]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT (getdate()) FOR [CommentTime]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((1)) FOR [CommentStatus]
GO
ALTER TABLE [dbo].[DepartmentEmployees] ADD  DEFAULT ((1)) FOR [DepartmentEmployeeStatus]
GO
ALTER TABLE [dbo].[Departments] ADD  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[Departments] ADD  DEFAULT ((1)) FOR [DepartmentStatus]
GO
ALTER TABLE [dbo].[Emotions] ADD  DEFAULT ((1)) FOR [EmotionStatus]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT (getdate()) FOR [EmployeeBirthday]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((1)) FOR [EmployeeStatus]
GO
ALTER TABLE [dbo].[Files] ADD  DEFAULT ((1)) FOR [FileStatus]
GO
ALTER TABLE [dbo].[Folders] ADD  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [dbo].[Folders] ADD  DEFAULT ((1)) FOR [FolderStatus]
GO
ALTER TABLE [dbo].[Forms] ADD  DEFAULT ((1)) FOR [FormStatus]
GO
ALTER TABLE [dbo].[Forwards] ADD  DEFAULT ((1)) FOR [TypeSend]
GO
ALTER TABLE [dbo].[Forwards] ADD  DEFAULT ((1)) FOR [ForwardStatus]
GO
ALTER TABLE [dbo].[GrantPermissions] ADD  DEFAULT ((1)) FOR [GrantPermissionStatus]
GO
ALTER TABLE [dbo].[GroupChatDetails] ADD  DEFAULT (getdate()) FOR [GroupChatDetailTime]
GO
ALTER TABLE [dbo].[GroupChatDetails] ADD  DEFAULT ((1)) FOR [GroupChatMemberStatus]
GO
ALTER TABLE [dbo].[GroupChatMembers] ADD  DEFAULT (getdate()) FOR [AddedTime]
GO
ALTER TABLE [dbo].[GroupChatMembers] ADD  DEFAULT ((1)) FOR [GroupChatMemberStatus]
GO
ALTER TABLE [dbo].[GroupChats] ADD  DEFAULT (getdate()) FOR [CreateTime]
GO
ALTER TABLE [dbo].[GroupChats] ADD  DEFAULT ((1)) FOR [GroupChatStatus]
GO
ALTER TABLE [dbo].[GroupMembers] ADD  DEFAULT (N'Thành Viên') FOR [GroupRole]
GO
ALTER TABLE [dbo].[GroupMembers] ADD  DEFAULT ((1)) FOR [GroupMemberStatus]
GO
ALTER TABLE [dbo].[Groups] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
ALTER TABLE [dbo].[Groups] ADD  DEFAULT ((1)) FOR [GroupType]
GO
ALTER TABLE [dbo].[Groups] ADD  DEFAULT ((1)) FOR [GroupStatus]
GO
ALTER TABLE [dbo].[Likes] ADD  DEFAULT ((1)) FOR [LikeStatus]
GO
ALTER TABLE [dbo].[ManagerZones] ADD  DEFAULT ((1)) FOR [ManagerZoneStatus]
GO
ALTER TABLE [dbo].[MemberDiscussions] ADD  DEFAULT ((1)) FOR [MemberDiscussionStatus]
GO
ALTER TABLE [dbo].[Notes] ADD  DEFAULT ((1)) FOR [NoteStatus]
GO
ALTER TABLE [dbo].[Permissions] ADD  DEFAULT ((1)) FOR [PermissionStatus]
GO
ALTER TABLE [dbo].[Plans] ADD  DEFAULT ((1)) FOR [PlanStatus]
GO
ALTER TABLE [dbo].[PostImages] ADD  DEFAULT ((1)) FOR [PostImageStatus]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT (getdate()) FOR [PostedTime]
GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT ((1)) FOR [PostStatus]
GO
ALTER TABLE [dbo].[ProjectDiscussions] ADD  DEFAULT ((1)) FOR [ProjectDiscussionStatus]
GO
ALTER TABLE [dbo].[ProjectMembers] ADD  DEFAULT ((1)) FOR [ProjectMemberStatus]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT (getdate()) FOR [EndTime]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT ((1)) FOR [ProjectStatus]
GO
ALTER TABLE [dbo].[Reminds] ADD  DEFAULT (getdate()) FOR [RemindTime]
GO
ALTER TABLE [dbo].[Reminds] ADD  DEFAULT ((1)) FOR [RemindStatus]
GO
ALTER TABLE [dbo].[Reports] ADD  DEFAULT (getdate()) FOR [ReportTime]
GO
ALTER TABLE [dbo].[Reports] ADD  DEFAULT ((1)) FOR [ReportStatus]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((1)) FOR [RoleStatus]
GO
ALTER TABLE [dbo].[SetPermissions] ADD  DEFAULT ((1)) FOR [SetPermissionStatus]
GO
ALTER TABLE [dbo].[Shares] ADD  DEFAULT ((1)) FOR [ShareType]
GO
ALTER TABLE [dbo].[Shares] ADD  DEFAULT ((1)) FOR [SharePrivacy]
GO
ALTER TABLE [dbo].[Shares] ADD  DEFAULT ((1)) FOR [ShareStatus]
GO
ALTER TABLE [dbo].[SmallStepMembers] ADD  DEFAULT ((1)) FOR [SmallStepMemberStatus]
GO
ALTER TABLE [dbo].[SmallSteps] ADD  DEFAULT ((1)) FOR [SmallStepStatus]
GO
ALTER TABLE [dbo].[StepMembers] ADD  DEFAULT ((1)) FOR [StepMemberStatus]
GO
ALTER TABLE [dbo].[Steps] ADD  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[Steps] ADD  DEFAULT (getdate()) FOR [EndTime]
GO
ALTER TABLE [dbo].[Steps] ADD  DEFAULT ((1)) FOR [StepStatus]
GO
ALTER TABLE [dbo].[TimeLineDetails] ADD  DEFAULT (getdate()) FOR [TimeLineDetailPostedTime]
GO
ALTER TABLE [dbo].[TimeLineDetails] ADD  DEFAULT ((1)) FOR [TimeLineDetailType]
GO
ALTER TABLE [dbo].[TimeLineDetails] ADD  DEFAULT ((1)) FOR [TimeLineDetailStatus]
GO
ALTER TABLE [dbo].[TimeLineImages] ADD  DEFAULT ((1)) FOR [TimeLineImageStatus]
GO
ALTER TABLE [dbo].[TimeLines] ADD  DEFAULT ((1)) FOR [TimeLineStatus]
GO
ALTER TABLE [dbo].[ChatDetails]  WITH CHECK ADD FOREIGN KEY([ChatId])
REFERENCES [dbo].[Chats] ([ChatId])
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([FirstMember])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Chats]  WITH CHECK ADD FOREIGN KEY([SecondMember])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([TimeLineDetailId])
REFERENCES [dbo].[TimeLineDetails] ([TimeLineDetailId])
GO
ALTER TABLE [dbo].[DepartmentEmployees]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[DepartmentEmployees]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Files]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Files]  WITH CHECK ADD FOREIGN KEY([FolderId])
REFERENCES [dbo].[Folders] ([FolderId])
GO
ALTER TABLE [dbo].[Files]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[Folders]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Folders]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[Forms]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Forwards]  WITH CHECK ADD FOREIGN KEY([ReceiverStepId])
REFERENCES [dbo].[Steps] ([StepId])
GO
ALTER TABLE [dbo].[Forwards]  WITH CHECK ADD FOREIGN KEY([SendStepId])
REFERENCES [dbo].[Steps] ([StepId])
GO
ALTER TABLE [dbo].[Forwards]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[GrantPermissions]  WITH CHECK ADD FOREIGN KEY([DepartmentEmployeeId])
REFERENCES [dbo].[DepartmentEmployees] ([DepartmentEmployeeId])
GO
ALTER TABLE [dbo].[GrantPermissions]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[GroupChatDetails]  WITH CHECK ADD FOREIGN KEY([GroupChatMemberId])
REFERENCES [dbo].[GroupChatMembers] ([GroupChatMemberId])
GO
ALTER TABLE [dbo].[GroupChatMembers]  WITH CHECK ADD FOREIGN KEY([Adder])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[GroupChatMembers]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[GroupChatMembers]  WITH CHECK ADD FOREIGN KEY([GroupChatId])
REFERENCES [dbo].[GroupChats] ([GroupChatId])
GO
ALTER TABLE [dbo].[GroupChats]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[GroupMembers]  WITH CHECK ADD FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comments] ([CommentId])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([EmotionId])
REFERENCES [dbo].[Emotions] ([EmotionId])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([TimeLineDetailId])
REFERENCES [dbo].[TimeLineDetails] ([TimeLineDetailId])
GO
ALTER TABLE [dbo].[MemberDiscussions]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[MemberDiscussions]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[MemberDiscussions]  WITH CHECK ADD FOREIGN KEY([ProjectMemberId])
REFERENCES [dbo].[ProjectMembers] ([ProjectMemberId])
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD FOREIGN KEY([SmallStepMemberId])
REFERENCES [dbo].[SmallStepMembers] ([SmallStepMemberId])
GO
ALTER TABLE [dbo].[Plans]  WITH CHECK ADD FOREIGN KEY([GrantPermissionId])
REFERENCES [dbo].[GrantPermissions] ([GrantPermissionId])
GO
ALTER TABLE [dbo].[PostImages]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([GroupMemberId])
REFERENCES [dbo].[GroupMembers] ([GroupMemberId])
GO
ALTER TABLE [dbo].[ProjectDiscussions]  WITH CHECK ADD FOREIGN KEY([MemberDiscussionId])
REFERENCES [dbo].[MemberDiscussions] ([MemberDiscussionId])
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD FOREIGN KEY([GrantPermissionId])
REFERENCES [dbo].[GrantPermissions] ([GrantPermissionId])
GO
ALTER TABLE [dbo].[ProjectMembers]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[Reminds]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Reminds]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Reminds]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[SetPermissions]  WITH CHECK ADD FOREIGN KEY([ManagerZoneId])
REFERENCES [dbo].[ManagerZones] ([ManagerZoneId])
GO
ALTER TABLE [dbo].[SetPermissions]  WITH CHECK ADD FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([PermissionId])
GO
ALTER TABLE [dbo].[SetPermissions]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Posts] ([PostId])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([TimeLineId])
REFERENCES [dbo].[TimeLines] ([TimeLineId])
GO
ALTER TABLE [dbo].[Shares]  WITH CHECK ADD FOREIGN KEY([TimeLineDetailId])
REFERENCES [dbo].[TimeLineDetails] ([TimeLineDetailId])
GO
ALTER TABLE [dbo].[SmallStepComment]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[SmallStepComment]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[SmallStepMembers]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[SmallStepMembers]  WITH CHECK ADD FOREIGN KEY([StepMemberId])
REFERENCES [dbo].[StepMembers] ([StepMemberId])
GO
ALTER TABLE [dbo].[SmallStepPriorityLevel]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[SmallSteps]  WITH CHECK ADD FOREIGN KEY([StepId])
REFERENCES [dbo].[Steps] ([StepId])
GO
ALTER TABLE [dbo].[SmallStepWorkToDo]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[StepMembers]  WITH CHECK ADD FOREIGN KEY([ProjectMemberId])
REFERENCES [dbo].[ProjectMembers] ([ProjectMemberId])
GO
ALTER TABLE [dbo].[StepMembers]  WITH CHECK ADD FOREIGN KEY([StepId])
REFERENCES [dbo].[Steps] ([StepId])
GO
ALTER TABLE [dbo].[Steps]  WITH CHECK ADD FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([ProjectId])
GO
ALTER TABLE [dbo].[TimeLineDetails]  WITH CHECK ADD FOREIGN KEY([TimeLineId])
REFERENCES [dbo].[TimeLines] ([TimeLineId])
GO
ALTER TABLE [dbo].[TimeLineImages]  WITH CHECK ADD FOREIGN KEY([TimeLineDetailId])
REFERENCES [dbo].[TimeLineDetails] ([TimeLineDetailId])
GO
ALTER TABLE [dbo].[TimeLines]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
USE [master]
GO
ALTER DATABASE [WorkManagerment] SET  READ_WRITE 
GO
