USE [master]
GO
/****** Object:  Database [WorkManagerment]    Script Date: 12/13/2018 11:03:39 AM ******/
CREATE DATABASE [WorkManagerment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WorkManagerment', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WorkManagerment.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
/****** Object:  StoredProcedure [dbo].[sp_GetAllEmployeeByDepartment]    Script Date: 12/13/2018 11:03:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[sp_GetAllEmployeeByDepartment]
as
begin
	select e.EmployeeId,e.EmployeeAddress,e.EmployeeAvatar,e.EmployeeBirthday,e.EmployeeCoverPicture,
	e.EmployeeEmail,e.EmployeeFullname,e.EmployeeIdCard,e.EmployeePassword,e.EmployeePhone,
	e.EmployeeStatus,e.EmployeeGender,d.DepartmentName,d.DepartmentStatus,d.ParentId from Employees as e , Departments as d,DepartmentEmployees as de
	where e.EmployeeId = de.EmployeeId and d.DepartmentId = de.DepartmentId and e.EmployeeStatus != 2 and d.DepartmentStatus = 1
end

GO
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereDepartmentId]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereEmployeeId]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_getEmployeeByDepartmentWhereEmployeeIds]    Script Date: 12/13/2018 11:03:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getEmployeeByDepartmentWhereEmployeeIds]
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
/****** Object:  Table [dbo].[ChatDetails]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Chats]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Comments]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[DepartmentEmployees]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Departments]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Emotions]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Employees]    Script Date: 12/13/2018 11:03:39 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Files]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Folders]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Forms]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Forwards]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[GrantPermissions]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[GroupChatDetails]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[GroupChatMembers]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[GroupChats]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[GroupMembers]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Groups]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Likes]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[ManagerZones]    Script Date: 12/13/2018 11:03:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerZones](
	[ManagerZoneId] [int] IDENTITY(1,1) NOT NULL,
	[ManagerZoneName] [nvarchar](250) NOT NULL,
	[ManagerZoneStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManagerZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MemberDiscussions]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Notes]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Permissions]    Script Date: 12/13/2018 11:03:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [nvarchar](250) NOT NULL,
	[PermissionStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Plans]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[PostImages]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Posts]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[ProjectDiscussions]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[ProjectMembers]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Projects]    Script Date: 12/13/2018 11:03:39 AM ******/
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
	[DepartmentId] [int] NOT NULL,
	[ProjectStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reminds]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Reports]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[SetPermissions]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Shares]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[SmallStepMembers]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[SmallSteps]    Script Date: 12/13/2018 11:03:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SmallSteps](
	[SmallStepId] [int] IDENTITY(1,1) NOT NULL,
	[StepId] [int] NOT NULL,
	[SmallStepDescription] [ntext] NOT NULL,
	[SmallStepStatus] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SmallStepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StepMembers]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[Steps]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[TimeLineDetails]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[TimeLineImages]    Script Date: 12/13/2018 11:03:39 AM ******/
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
/****** Object:  Table [dbo].[TimeLines]    Script Date: 12/13/2018 11:03:39 AM ******/
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
SET IDENTITY_INSERT [dbo].[DepartmentEmployees] OFF
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (1, N'Phòng Kế Toán', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (2, N'Phòng Lập Trình', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (3, N'Phòng Tổng Hợp', 0, 1)
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [ParentId], [DepartmentStatus]) VALUES (4, N'Phòng Hành Chính', 0, 1)
SET IDENTITY_INSERT [dbo].[Departments] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender]) VALUES (1, N'admin', CAST(0x091B0B00 AS Date), N'10059001000', N'0934342020', NULL, N'admin@devhitech.vn', N'81dc9bdb52d04dc20036dbd8313ed055', N'avatar_defaulte.png', N'anh_bia.jpg', 1, 1)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender]) VALUES (2, N'demo1', CAST(0x091B0B00 AS Date), N'10059001001', N'0934342021', N'só 8 ngách 14 ngõ 124 Minh khai', N'demo@gmail.com', N'81dc9bdb52d04dc20036dbd8313ed055', N'select.png', N'sort_asc.png', 1, 1)
INSERT [dbo].[Employees] ([EmployeeId], [EmployeeFullname], [EmployeeBirthday], [EmployeeIdCard], [EmployeePhone], [EmployeeAddress], [EmployeeEmail], [EmployeePassword], [EmployeeAvatar], [EmployeeCoverPicture], [EmployeeStatus], [EmployeeGender]) VALUES (3, N'demo2', CAST(0x091B0B00 AS Date), N'10059001002', N'0934342022', N'só 8 ngách 14 ngõ 124 Minh khai', N'demo2@gmail.com', N'81dc9bdb52d04dc20036dbd8313ed055', N'sort_both.png', N'sort_desc_disabled.png', 1, 1)
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (1, N'Project1', CAST(0x0000A9B400000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'a', 1, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (2, N'Project2', CAST(0x0000A9B400000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'b', 2, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (3, N'Project3', CAST(0x0000A84700000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'c', 3, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (4, N'Project4', CAST(0x0000A6DA00000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'd', 4, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (5, N'Project5', CAST(0x0000A84700000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'e', 2, 1)
INSERT [dbo].[Projects] ([ProjectId], [ProjectName], [StartTime], [EndTime], [ProjectDescription], [DepartmentId], [ProjectStatus]) VALUES (6, N'Project6', CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000AB2100000000 AS DateTime), N'f', 2, 1)
SET IDENTITY_INSERT [dbo].[Projects] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Comments__02D47A0C527D5F1D]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Comments] ADD UNIQUE NONCLUSTERED 
(
	[CommentImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Departme__D949CC349E004E7F]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Departments] ADD UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Emotions__1ECBFC664E27B69E]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Emotions] ADD UNIQUE NONCLUSTERED 
(
	[EmotionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Emotions__3A37C6922CDB4754]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Emotions] ADD UNIQUE NONCLUSTERED 
(
	[EmotionIcon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__6E8498AAD770C3ED]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__C58F72EACE659C79]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeIdCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Employee__D02FBE444B9106D4]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Employees] ADD UNIQUE NONCLUSTERED 
(
	[EmployeePhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__ManagerZ__E5B1DDD8D7DFD43E]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[ManagerZones] ADD UNIQUE NONCLUSTERED 
(
	[ManagerZoneName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Permissi__0FFDA3572697FCBF]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Permissions] ADD UNIQUE NONCLUSTERED 
(
	[PermissionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__PostImag__FEC001A8C932C339]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[PostImages] ADD UNIQUE NONCLUSTERED 
(
	[PostImage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Projects__BCBE781CF92AB059]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Projects] ADD UNIQUE NONCLUSTERED 
(
	[ProjectName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Roles__8A2B61601C1F56A7]    Script Date: 12/13/2018 11:03:39 AM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__TimeLine__F1B7FDF06C9BBC10]    Script Date: 12/13/2018 11:03:39 AM ******/
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
ALTER TABLE [dbo].[Projects]  WITH CHECK ADD FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
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
ALTER TABLE [dbo].[SmallStepMembers]  WITH CHECK ADD FOREIGN KEY([SmallStepId])
REFERENCES [dbo].[SmallSteps] ([SmallStepId])
GO
ALTER TABLE [dbo].[SmallStepMembers]  WITH CHECK ADD FOREIGN KEY([StepMemberId])
REFERENCES [dbo].[StepMembers] ([StepMemberId])
GO
ALTER TABLE [dbo].[SmallSteps]  WITH CHECK ADD FOREIGN KEY([StepId])
REFERENCES [dbo].[Steps] ([StepId])
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
