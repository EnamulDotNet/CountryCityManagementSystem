USE [master]
GO
/****** Object:  Database [CountryCityInfoMangementDB]    Script Date: 04-Jan-16 2:01:22 PM ******/
CREATE DATABASE [CountryCityInfoMangementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CountryCityInfoMangementDB', FILENAME = N'd:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CountryCityInfoMangementDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CountryCityInfoMangementDB_log', FILENAME = N'd:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\CountryCityInfoMangementDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CountryCityInfoMangementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET  MULTI_USER 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CountryCityInfoMangementDB]
GO
/****** Object:  Table [dbo].[City]    Script Date: 04-Jan-16 2:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](50) NOT NULL,
	[CityAbout] [varchar](max) NOT NULL,
	[Dwellers] [bigint] NOT NULL,
	[Location] [varchar](50) NULL,
	[Weather] [varchar](50) NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 04-Jan-16 2:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
	[CountryAbout] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[CityView]    Script Date: 04-Jan-16 2:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[CityView] AS
SELECT CityName,CityAbout,Dwellers AS 'NoOfDwellers',Location,Weather,CountryName,CountryAbout FROM City  LEFT JOIN Country ON City.CountryId=Country.Id ORDER BY City.CityName ASC OFFSET 0 ROWS

GO
/****** Object:  View [dbo].[CountryView]    Script Date: 04-Jan-16 2:01:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[CountryView]  AS
SELECT CountryName,CountryAbout,COUNT(CityName) AS 'NoOfCities' ,SUM(Dwellers) AS 'NoOfDwellers' FROM City  FULL JOIN Country    ON City.CountryId=Country.Id   GROUP BY CountryName,CountryAbout ORDER BY Country.CountryName ASC OFFSET 0 ROWS;

GO
USE [master]
GO
ALTER DATABASE [CountryCityInfoMangementDB] SET  READ_WRITE 
GO
