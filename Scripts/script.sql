USE [master]
GO
/****** Object:  Database [AppleInc]    Script Date: 2/3/2021 9:35:18 AM ******/
CREATE DATABASE [AppleInc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AppleInc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.STOREAPP1\MSSQL\DATA\AppleInc.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AppleInc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.STOREAPP1\MSSQL\DATA\AppleInc_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AppleInc] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AppleInc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AppleInc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AppleInc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AppleInc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AppleInc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AppleInc] SET ARITHABORT OFF 
GO
ALTER DATABASE [AppleInc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AppleInc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AppleInc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AppleInc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AppleInc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AppleInc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AppleInc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AppleInc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AppleInc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AppleInc] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AppleInc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AppleInc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AppleInc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AppleInc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AppleInc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AppleInc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AppleInc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AppleInc] SET RECOVERY FULL 
GO
ALTER DATABASE [AppleInc] SET  MULTI_USER 
GO
ALTER DATABASE [AppleInc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AppleInc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AppleInc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AppleInc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AppleInc] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AppleInc', N'ON'
GO
ALTER DATABASE [AppleInc] SET QUERY_STORE = OFF
GO
USE [AppleInc]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [AppleInc]
GO
/****** Object:  Table [dbo].[StoreInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreInv](
	[SerialNo] [int] NOT NULL,
	[StoreID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductList]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductList](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](30) NULL,
	[StartingPrice] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ProductName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[SerialNo] [int] IDENTITY(10000,10) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Price] [money] NULL,
	[SSN] [int] NULL,
	[PassPortNo] [int] NULL,
	[Condition] [varchar](20) NULL,
	[CurrentLoc] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[StoreInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[StoreInventory]
as
Select 
	   StoreInv.StoreID as [Store],
	   ProductList.ProductName as [Apple Product],
	   Count(StoreInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as Price
From StoreInv Join Product on 
StoreInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,StoreInv.StoreID
GO
/****** Object:  Table [dbo].[ContinentRef]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContinentRef](
	[ContId] [int] IDENTITY(1,1) NOT NULL,
	[ContName] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryRef]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryRef](
	[CountryId] [int] IDENTITY(500,1) NOT NULL,
	[CountryName] [varchar](20) NULL,
	[DistributorID] [int] NULL,
	[ContID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionHouse]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionHouse](
	[ProdHouseID] [int] IDENTITY(100,10) NOT NULL,
	[ProdHouseName] [varchar](20) NULL,
	[ContId] [int] NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProdHouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllProductionHouses]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllProductionHouses]
as
select ProdHouseName as [Production House],
	   CountryName as [Country],
	   ContName as [Continent] from ProductionHouse
	   join CountryRef on ProductionHouse.CountryID = CountryRef.CountryId 
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[WareHouseID] [int] IDENTITY(100,10) NOT NULL,
	[WareHouseName] [varchar](50) NULL,
	[CountryID] [int] NULL,
	[ProdHouseID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[WareHouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllWarehouses]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[AllWarehouses]
as
select WareHouseName as [WareHouse Name],
	   CountryName as [Country],
	   ContName as [Continent] from WareHouse
	   join CountryRef on WareHouse.CountryID = CountryRef.CountryId 
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId

GO
/****** Object:  Table [dbo].[Distributors]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distributors](
	[DistributorID] [int] NOT NULL,
	[DistributorName] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DistributorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllDistributors]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllDistributors]
as
select distinct Distributors.DistributorID as [Distributor ID],
	   DistributorName as [Distributor Name],
	   ContName as [Continent] from Distributors
	   join CountryRef on Distributors.DistributorID = CountryRef.DistributorID 
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[SubDistributors]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubDistributors](
	[SubDistributorID] [int] IDENTITY(1,1) NOT NULL,
	[SubDistributorName] [varchar](20) NULL,
	[DistributorID] [int] NULL,
	[CountryID] [int] NULL,
 CONSTRAINT [PK__SubDistr__954B9BED58E21270] PRIMARY KEY CLUSTERED 
(
	[SubDistributorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllSubDistributors]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllSubDistributors]
as
select SubDistributors.SubDistributorName as [SubDistributor Name],
	   CountryRef.CountryName as [Country Name],
	   ContName as [Continent] from SubDistributors
	   join CountryRef on SubDistributors.CountryID = CountryRef.CountryId
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[ChannelPartner]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelPartner](
	[ChannelPartnerID] [int] IDENTITY(1,1) NOT NULL,
	[ChannelPartnerName] [varchar](20) NULL,
	[SubDistributorID] [int] NULL,
	[CountryID] [int] NULL,
 CONSTRAINT [PK__ChannelP__4DCBC5F1DBE9D890] PRIMARY KEY CLUSTERED 
(
	[ChannelPartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllChannelPartners]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllChannelPartners]
as
select ChannelPartner.ChannelPartnerName as [Channel Partner Name],
	   CountryRef.CountryName as [Country Name],
	   ContName as [Continent] from ChannelPartner
	   join CountryRef on ChannelPartner.CountryID = CountryRef.CountryId
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[Zone]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zone](
	[zoneId] [int] IDENTITY(1,1) NOT NULL,
	[zoneName] [varchar](20) NULL,
	[ChannelPartnerID] [int] NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[zoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllZones]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllZones]
as
select Zone.zoneName as [Zone Name],
	   CountryRef.CountryName as [Country Name],
	   ContName as [Continent] from Zone
	   join CountryRef on Zone.CountryID = CountryRef.CountryId
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[Store]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [int] IDENTITY(1,1) NOT NULL,
	[StoreName] [varchar](20) NULL,
	[Address] [varchar](50) NULL,
	[ZoneID] [int] NULL,
	[CountryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllStores]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllStores]
as
select Store.StoreName as [Store Name],
	   CountryRef.CountryName as [Country Name],
	   ContName as [Continent] from Store
	   join CountryRef on Store.CountryID = CountryRef.CountryId
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  Table [dbo].[ProdHouseInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdHouseInv](
	[SerialNo] [int] NULL,
	[ProdHouseID] [int] NULL,
UNIQUE NONCLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ProductInventory]
as
Select ProdHouseInv.ProdHouseId as [ProductionHouse ID],
	   ProductList.ProductName as [Apple Product],
	   Count(ProdHouseInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from ProdHouseInv join Product on
ProdHouseInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,ProdHouseInv.ProdHouseID
GO
/****** Object:  Table [dbo].[WareHouseInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WareHouseInv](
	[SerialNo] [int] NOT NULL,
	[WareHouseID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[WareHouseInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[WareHouseInventory]
as
Select WareHouseInv.WareHouseID as [WareHouse ID],
	   ProductList.ProductName as [Apple Product],
	   Count(WareHouseInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from WareHouseInv join Product on
WareHouseInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,WareHouseInv.WareHouseID
GO
/****** Object:  Table [dbo].[DistributorInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DistributorInv](
	[SerialNo] [int] NOT NULL,
	[DistributorID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DistributorInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[DistributorInventory]
as
Select DistributorInv.DistributorID as [Distributor ID],
	   ProductList.ProductName as [Apple Product],
	   Count(DistributorInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from DistributorInv join Product on
DistributorInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,DistributorInv.DistributorID
GO
/****** Object:  Table [dbo].[SubDistributorInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubDistributorInv](
	[SerialNo] [int] NOT NULL,
	[SubDistributorID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SubDistributorInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[SubDistributorInventory]
as
Select SubDistributorInv.SubDistributorID as [SubDistributor ID],
	   ProductList.ProductName as [Apple Product],
	   Count(SubDistributorInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from SubDistributorInv join Product on
SubDistributorInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,SubDistributorInv.SubDistributorID
GO
/****** Object:  Table [dbo].[ChannelPartnerInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChannelPartnerInv](
	[SerialNo] [int] NOT NULL,
	[ChannelPartnerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ChannelPartnerInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ChannelPartnerInventory]
as
Select ChannelPartnerInv.ChannelPartnerID as [ChannelPartner ID],
	   ProductList.ProductName as [Apple Product],
	   Count(ChannelPartnerInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from ChannelPartnerInv join Product on
ChannelPartnerInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,ChannelPartnerInv.ChannelPartnerID
GO
/****** Object:  Table [dbo].[ZoneInv]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZoneInv](
	[SerialNo] [int] NOT NULL,
	[ZoneID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ZoneInventory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ZoneInventory]
as
Select ZoneInv.ZoneID as [Zone ID],
	   ProductList.ProductName as [Apple Product],
	   Count(ZoneInv.SerialNo) as [Quantity],
	   AVG(Product.Price) as [Price]
from ZoneInv join Product on
ZoneInv.SerialNo = Product.SerialNo
Join ProductList on Product.ProductID = ProductList.ProductID
Group by ProductList.ProductName,ZoneInv.ZoneID
GO
/****** Object:  UserDefinedFunction [dbo].[GetStoreInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetStoreInv_Fun]
(
	@StoreID int
)
returns table
as
	return select * from StoreInventory where Store = @StoreID
GO
/****** Object:  UserDefinedFunction [dbo].[GetProdHouseInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetProdHouseInv_Fun]
(
	@ProdHouseID int
)
returns table
as
	return select * from ProductInventory where [ProductionHouse ID] = @ProdHouseID
GO
/****** Object:  UserDefinedFunction [dbo].[GetWareHouseInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetWareHouseInv_Fun]
(
	@WareHouseID int
)
returns table
as
	return select * from WareHouseInventory where [WareHouse ID] = @WareHouseID
GO
/****** Object:  UserDefinedFunction [dbo].[GetDistributorInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetDistributorInv_Fun]
(
	@DistributorID int
)
returns table
as
	return select * from DistributorInventory where [Distributor ID] = @DistributorID
GO
/****** Object:  UserDefinedFunction [dbo].[GetSubDistributorInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetSubDistributorInv_Fun]
(
	@SubDistributorID int
)
returns table
as
	return select * from SubDistributorInventory where [SubDistributor ID] = @SubDistributorID
GO
/****** Object:  UserDefinedFunction [dbo].[GetChannelPartnerInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetChannelPartnerInv_Fun]
(
	@ChannelPartnerID int
)
returns table
as
	return select * from ChannelPartnerInventory where [ChannelPartner ID] = @ChannelPartnerID
GO
/****** Object:  UserDefinedFunction [dbo].[GetZoneInv_Fun]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetZoneInv_Fun]
(
	@ZoneID int
)
returns table
as
	return select * from ZoneInventory where [Zone ID] = @ZoneID
GO
/****** Object:  View [dbo].[AllProductList]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AllProductList]
as
Select ProductName as [Apple Product],
	   StartingPrice as [Starting Price]
	   from ProductList
GO
/****** Object:  View [dbo].[WarehouseMatch]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[WarehouseMatch]
as
select ProdHouseID as [ProdHouse ID],
	   WareHouseName as [WareHouse Name],
	   CountryName as [Country],
	   ContName as [Continent] from WareHouse
	   join CountryRef on WareHouse.CountryID = CountryRef.CountryId 
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId
GO
/****** Object:  UserDefinedFunction [dbo].[MatchingWareHouses]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MatchingWareHouses]
(
	@ProdHouseID int
)
returns table
as
	return select [WareHouse Name],[Country],[Continent] from WarehouseMatch where [ProdHouse ID] = @ProdHouseID
GO
/****** Object:  View [dbo].[SubDistribMatch]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[SubDistribMatch]
as
select SubDistributors.DistributorID as [Distributor ID],
	   SubDistributorName as [SubDistributor Name],
	   CountryName as [Country]
	   from SubDistributors
	   join CountryRef on SubDistributors.CountryID = CountryRef.CountryId 
GO
/****** Object:  UserDefinedFunction [dbo].[MatchingSubDistribs]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MatchingSubDistribs]
(
	@DistributorID int
)
returns table
as
	return select [SubDistributor Name],[Country] from SubDistribMatch where [Distributor ID] = @DistributorID
GO
/****** Object:  View [dbo].[ChanPartMatch]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ChanPartMatch]
as
select ChannelPartner.SubDistributorID as [SubDistributor ID],
	   ChannelPartner.ChannelPartnerName as [Channel Partner Name],
	   CountryName as [Country]
	   from ChannelPartner
	   join CountryRef on ChannelPartner.CountryID = CountryRef.CountryId 
GO
/****** Object:  UserDefinedFunction [dbo].[MatchingChanPart]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MatchingChanPart]
(
	@SubDistributorID int
)
returns table
as
	return select [Channel Partner Name],[Country] from ChanPartMatch where [SubDistributor ID] = @SubDistributorID
GO
/****** Object:  View [dbo].[ZoneMatch]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ZoneMatch]
as
select Zone.ChannelPartnerID as [Channel Partner ID],
	   Zone.ZoneName as [Zone Name],
	   CountryName as [Country]
	   from Zone
	   join CountryRef on Zone.CountryID = CountryRef.CountryId 
GO
/****** Object:  UserDefinedFunction [dbo].[MatchingZone]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MatchingZone]
(
	@ChanPartID int
)
returns table
as
	return select [Zone Name],[Country] from ZoneMatch where [Channel Partner ID] = @ChanPartID
GO
/****** Object:  View [dbo].[StoreMatch]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[StoreMatch]
as
select Store.ZoneID as [Zone ID],
	   Store.StoreName as [Store Name],
	   CountryName as [Country]
	   from Store
	   join CountryRef on Store.CountryID = CountryRef.CountryId 
GO
/****** Object:  UserDefinedFunction [dbo].[MatchingStore]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MatchingStore]
(
	@ZoneID int
)
returns table
as
	return select [Store Name],[Country] from StoreMatch where [Zone ID] = @ZoneID
GO
/****** Object:  Table [dbo].[History]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SerialNo] [int] NULL,
	[Action] [varchar](20) NULL,
	[Destination] [varchar](25) NULL,
	[Timestamp] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[HistoryView]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[HistoryView]
as
select SerialNo as [Serial Number],
	   Action as [Action],
	   Destination as [Location],
	   Timestamp as [TimeStamp]
	   from History
GO
ALTER TABLE [dbo].[ChannelPartner]  WITH CHECK ADD  CONSTRAINT [fk_ChannelPartner_CountryRef] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[ChannelPartner] CHECK CONSTRAINT [fk_ChannelPartner_CountryRef]
GO
ALTER TABLE [dbo].[ChannelPartner]  WITH CHECK ADD  CONSTRAINT [fk_ChannelPartner_SubDistributor] FOREIGN KEY([SubDistributorID])
REFERENCES [dbo].[SubDistributors] ([SubDistributorID])
GO
ALTER TABLE [dbo].[ChannelPartner] CHECK CONSTRAINT [fk_ChannelPartner_SubDistributor]
GO
ALTER TABLE [dbo].[ChannelPartnerInv]  WITH CHECK ADD  CONSTRAINT [fk_ChannelPartnerInv_ChannelPartner] FOREIGN KEY([ChannelPartnerID])
REFERENCES [dbo].[ChannelPartner] ([ChannelPartnerID])
GO
ALTER TABLE [dbo].[ChannelPartnerInv] CHECK CONSTRAINT [fk_ChannelPartnerInv_ChannelPartner]
GO
ALTER TABLE [dbo].[ChannelPartnerInv]  WITH CHECK ADD  CONSTRAINT [fk_ChannelPartnerInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[ChannelPartnerInv] CHECK CONSTRAINT [fk_ChannelPartnerInv_Product]
GO
ALTER TABLE [dbo].[CountryRef]  WITH CHECK ADD  CONSTRAINT [fk_CountryRef_ContinentRef] FOREIGN KEY([ContID])
REFERENCES [dbo].[ContinentRef] ([ContId])
GO
ALTER TABLE [dbo].[CountryRef] CHECK CONSTRAINT [fk_CountryRef_ContinentRef]
GO
ALTER TABLE [dbo].[CountryRef]  WITH CHECK ADD  CONSTRAINT [fk_CountryRef_Distributors] FOREIGN KEY([DistributorID])
REFERENCES [dbo].[Distributors] ([DistributorID])
GO
ALTER TABLE [dbo].[CountryRef] CHECK CONSTRAINT [fk_CountryRef_Distributors]
GO
ALTER TABLE [dbo].[DistributorInv]  WITH CHECK ADD  CONSTRAINT [fk_DistributorInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[DistributorInv] CHECK CONSTRAINT [fk_DistributorInv_Product]
GO
ALTER TABLE [dbo].[DistributorInv]  WITH CHECK ADD  CONSTRAINT [fk_DistributorInv_Warehouse] FOREIGN KEY([DistributorID])
REFERENCES [dbo].[Distributors] ([DistributorID])
GO
ALTER TABLE [dbo].[DistributorInv] CHECK CONSTRAINT [fk_DistributorInv_Warehouse]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [fk_History_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [fk_History_Product]
GO
ALTER TABLE [dbo].[ProdHouseInv]  WITH CHECK ADD  CONSTRAINT [fk_ProdHouseInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[ProdHouseInv] CHECK CONSTRAINT [fk_ProdHouseInv_Product]
GO
ALTER TABLE [dbo].[ProdHouseInv]  WITH CHECK ADD  CONSTRAINT [fk_ProdHouseInv_ProductionHouse] FOREIGN KEY([ProdHouseID])
REFERENCES [dbo].[ProductionHouse] ([ProdHouseID])
GO
ALTER TABLE [dbo].[ProdHouseInv] CHECK CONSTRAINT [fk_ProdHouseInv_ProductionHouse]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [fk_Product_ProductList] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductList] ([ProductID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [fk_Product_ProductList]
GO
ALTER TABLE [dbo].[ProductionHouse]  WITH CHECK ADD  CONSTRAINT [fk_ProductionHouse_ContinentRef] FOREIGN KEY([ContId])
REFERENCES [dbo].[ContinentRef] ([ContId])
GO
ALTER TABLE [dbo].[ProductionHouse] CHECK CONSTRAINT [fk_ProductionHouse_ContinentRef]
GO
ALTER TABLE [dbo].[ProductionHouse]  WITH CHECK ADD  CONSTRAINT [fk_ProductionHouse_CountryRef] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[ProductionHouse] CHECK CONSTRAINT [fk_ProductionHouse_CountryRef]
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD  CONSTRAINT [fk_Store_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [fk_Store_Country]
GO
ALTER TABLE [dbo].[Store]  WITH CHECK ADD  CONSTRAINT [fk_Store_Zone] FOREIGN KEY([ZoneID])
REFERENCES [dbo].[Zone] ([zoneId])
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [fk_Store_Zone]
GO
ALTER TABLE [dbo].[StoreInv]  WITH CHECK ADD  CONSTRAINT [fk_StoreInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[StoreInv] CHECK CONSTRAINT [fk_StoreInv_Product]
GO
ALTER TABLE [dbo].[StoreInv]  WITH CHECK ADD  CONSTRAINT [fk_StoreInv_Zone] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[StoreInv] CHECK CONSTRAINT [fk_StoreInv_Zone]
GO
ALTER TABLE [dbo].[SubDistributorInv]  WITH CHECK ADD  CONSTRAINT [fk_SubDistributorInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[SubDistributorInv] CHECK CONSTRAINT [fk_SubDistributorInv_Product]
GO
ALTER TABLE [dbo].[SubDistributorInv]  WITH CHECK ADD  CONSTRAINT [fk_SubDistributorInv_SubDistributor] FOREIGN KEY([SubDistributorID])
REFERENCES [dbo].[SubDistributors] ([SubDistributorID])
GO
ALTER TABLE [dbo].[SubDistributorInv] CHECK CONSTRAINT [fk_SubDistributorInv_SubDistributor]
GO
ALTER TABLE [dbo].[SubDistributors]  WITH CHECK ADD  CONSTRAINT [fk_SubDistributor_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[SubDistributors] CHECK CONSTRAINT [fk_SubDistributor_Country]
GO
ALTER TABLE [dbo].[SubDistributors]  WITH CHECK ADD  CONSTRAINT [fk_SubDistributor_Distributor] FOREIGN KEY([DistributorID])
REFERENCES [dbo].[Distributors] ([DistributorID])
GO
ALTER TABLE [dbo].[SubDistributors] CHECK CONSTRAINT [fk_SubDistributor_Distributor]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [fk_WareHouse_CountryID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [fk_WareHouse_CountryID]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [fk_WareHouse_ProductionHouse] FOREIGN KEY([ProdHouseID])
REFERENCES [dbo].[ProductionHouse] ([ProdHouseID])
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [fk_WareHouse_ProductionHouse]
GO
ALTER TABLE [dbo].[WareHouseInv]  WITH CHECK ADD  CONSTRAINT [fk_WareHouseInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[WareHouseInv] CHECK CONSTRAINT [fk_WareHouseInv_Product]
GO
ALTER TABLE [dbo].[WareHouseInv]  WITH CHECK ADD  CONSTRAINT [fk_WareHouseInv_Warehouse] FOREIGN KEY([WareHouseID])
REFERENCES [dbo].[Warehouse] ([WareHouseID])
GO
ALTER TABLE [dbo].[WareHouseInv] CHECK CONSTRAINT [fk_WareHouseInv_Warehouse]
GO
ALTER TABLE [dbo].[Zone]  WITH CHECK ADD  CONSTRAINT [fk_Zone_ChannelPartner] FOREIGN KEY([ChannelPartnerID])
REFERENCES [dbo].[ChannelPartner] ([ChannelPartnerID])
GO
ALTER TABLE [dbo].[Zone] CHECK CONSTRAINT [fk_Zone_ChannelPartner]
GO
ALTER TABLE [dbo].[Zone]  WITH CHECK ADD  CONSTRAINT [fk_Zone_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryRef] ([CountryId])
GO
ALTER TABLE [dbo].[Zone] CHECK CONSTRAINT [fk_Zone_Country]
GO
ALTER TABLE [dbo].[ZoneInv]  WITH CHECK ADD  CONSTRAINT [fk_ZoneInv_Product] FOREIGN KEY([SerialNo])
REFERENCES [dbo].[Product] ([SerialNo])
GO
ALTER TABLE [dbo].[ZoneInv] CHECK CONSTRAINT [fk_ZoneInv_Product]
GO
ALTER TABLE [dbo].[ZoneInv]  WITH CHECK ADD  CONSTRAINT [fk_ZoneInv_Zone] FOREIGN KEY([ZoneID])
REFERENCES [dbo].[Zone] ([zoneId])
GO
ALTER TABLE [dbo].[ZoneInv] CHECK CONSTRAINT [fk_ZoneInv_Zone]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [chk_CurrentPrice] CHECK  (([Price]>(0.00)))
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [chk_CurrentPrice]
GO
ALTER TABLE [dbo].[ProductList]  WITH CHECK ADD  CONSTRAINT [chk_startingPrice] CHECK  (([StartingPrice]>(0.00)))
GO
ALTER TABLE [dbo].[ProductList] CHECK CONSTRAINT [chk_startingPrice]
GO
/****** Object:  StoredProcedure [dbo].[ChannelPartnerInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ChannelPartnerInv_Proc]
(
	@ChannelPartnerName varchar(20)
)
as
begin
	declare @ChannelPartnerID int = (Select ChannelPartnerID from ChannelPartner where ChannelPartnerName = @ChannelPartnerName)
	select [Apple Product],[Quantity],[Price] from GetChannelPartnerInv_Fun(@ChannelPartnerID)
end
GO
/****** Object:  StoredProcedure [dbo].[create_products]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[create_products]
as
begin
declare @ProductID int = 0
declare @Price money = 0.00
declare @pno int = 0
declare @ProductCount int = (select Count(*) from ProductList)
declare @SnoCount int = 0
while @pno < 90
begin
	select @pno = @pno + 1
	select @ProductID = ( @pno % @ProductCount ) + 1
	begin tran
	select @Price = (select StartingPrice from ProductList where ProductID = @ProductID)
	insert into Product values(@ProductID,@Price,null,null)
	declare @newProductNo int = (select Max(SerialNo) from Product)
	insert into ProdHouseInv values(@newProductNo,100)
	commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[create_products_byType]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[create_products_byType]
(
	@ProductName varchar(20),
	@Count int,
	@ProdHouseName varchar(20)

)
as
begin
declare @ProductID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @Price money = (select StartingPrice from ProductList where ProductName = @ProductName)
declare @ProdHouseID int = (select ProdHouseID from ProductionHouse where ProdHouseName = @ProdHouseName)
declare @pno int = 0
while @pno < @Count
begin 
	select @pno = @pno + 1
	begin tran
		insert into Product values(@ProductID,@Price,null,null,'Good',@ProdHouseName)
		declare @newProductNo int = (select Max(SerialNo) from Product)
		insert into ProdHouseInv values(@newProductNo,@ProdHouseID)
	commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[GetASerialNo]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetASerialNo]
as
begin
	select Max(SerialNo) from Product 
end
GO
/****** Object:  StoredProcedure [dbo].[GetDistributorInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetDistributorInv_Proc]
(
	@DistributorName varchar(20)
)
as
begin
	declare @DistributorID int = (Select DistributorID from Distributors where DistributorName = @DistributorName)
	select [Apple Product],[Quantity],[Price] from GetDistributorInv_Fun(@DistributorID)
end
GO
/****** Object:  StoredProcedure [dbo].[GetProdHouseInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProdHouseInv_Proc]
(
	@ProdHouseName varchar(20)
)
as
begin
	declare @ProdHouseID int = (Select ProdHouseID from ProductionHouse where ProdHouseName = @ProdHouseName)
	select [Apple Product],[Quantity],[Price] from GetProdHouseInv_Fun(@ProdHouseID)
end
GO
/****** Object:  StoredProcedure [dbo].[GetStoreInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetStoreInv_Proc]
(
	@StoreName varchar(20)
)
as
begin
	declare @StoreID int = (Select StoreID from Store where StoreName = @StoreName)
	select [Apple Product],[Quantity],[Price] from GetStoreInv_Fun(@StoreID)
end
GO
/****** Object:  StoredProcedure [dbo].[GetSubDistributorInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetSubDistributorInv_Proc]
(
	@SubDistributorName varchar(20)
)
as
begin
	declare @SubDistributorID int = (Select SubDistributorID from SubDistributors where SubDistributorName = @SubDistributorName)
	select [Apple Product],[Quantity],[Price] from GetSubDistributorInv_Fun(@SubDistributorID)
end
GO
/****** Object:  StoredProcedure [dbo].[GetWareHouseInv_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetWareHouseInv_Proc]
(
	@WareHouseName varchar(20)
)
as
begin
	declare @WareHouseID int = (Select WareHouseID from WareHouse where WareHouseName = @WareHouseName)
	select [Apple Product],[Quantity],[Price] from GetWareHouseInv_Fun(@WareHouseID)
end
GO
/****** Object:  StoredProcedure [dbo].[GetZone_Proc]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetZone_Proc]
(
	@ZoneName varchar(20)
)
as
begin
	declare @ZoneID int = (Select ZoneID from Zone where ZoneName = @ZoneName)
	select [Apple Product],[Quantity],[Price] from GetZoneInv_Fun(@ZoneID)
end
GO
/****** Object:  StoredProcedure [dbo].[move_ChannelPartner_SubDistributor]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_ChannelPartner_SubDistributor]
(
	@SerialNo int,
	@ChannelPartnerName varchar(20)
)
as
begin
declare @SubDistributorId int = (select SubDistributorID from ChannelPartner where ChannelPartnerName = @ChannelPartnerName)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into SubDistributorInv values(@SerialNo,@SubDistributorId)
	delete from ChannelPartnerInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_ChanPart_Zone]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_ChanPart_Zone]
(@Count int,
 @ProductName varchar(20),
 @ZoneName varchar(20))
as
begin
declare @pno int = 0
declare @ChanPartId int = (select ChannelPartnerID from Zone where zoneName = @ZoneName)
declare @ZoneID int = (select ZoneID from Zone where zoneName = @ZoneName)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 ChannelPartnerInv.SerialNo from ChannelPartnerInv join Product on ChannelPartnerInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where ChannelPartnerID = @ChanPartID and ProductList.ProductName = @ProductName)
	insert into ZoneInv values (@serialNo,@ZoneID)
	delete from ChannelPartnerInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[move_Dis_SubDis]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_Dis_SubDis]
(@Count int,
 @ProductName varchar(20),
 @CountryName varchar(20),
 @SubDisName varchar(20))
as
begin
declare @pno int = 0
declare @DistributorId int = (select DistributorID from CountryRef where CountryName = @CountryName)
declare @SubDisID int = (select SubDistributorID from SubDistributors where SubDistributorName = @SubDisName)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 DistributorInv.SerialNo from DistributorInv join Product on DistributorInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where DistributorID = @DistributorID and ProductList.ProductName = @ProductName)
	insert into SubDistributorInv values (@serialNo,@SubDisID)
	delete from DistributorInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[move_Distributor_WareHouse]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[move_Distributor_WareHouse]
(
	@SerialNo int,
	@CountryName varchar(20),
	@DistributorName varchar(20)
)
as
begin
declare @DistributorID int = (select DistributorID from Distributors where DistributorName = @DistributorName)
declare @CountryId int = (select CountryID from CountryRef where CountryName = @CountryName and DistributorID = @DistributorID)
declare @WarehouseID int = (select top 1 WarehouseID from Warehouse where CountryID = @CountryId)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into WareHouseInv values(@SerialNo,@WareHouseId)
	delete from DistributorInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_products]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[move_products]
(@Count int,
 @ProductName varchar(20),
 @Destination varchar(20))
as
begin
declare @pno int = 0
declare @ProdHouseId int = (select ProdHouseID from Warehouse where WareHouseName = @Destination)
declare @WareHouseID int = (select WareHouseID from Warehouse where WarehouseName = @Destination)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
declare @addedProdID int
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 ProdHouseInv.SerialNo from ProdHouseInv join Product on ProdHouseInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where ProdHouseID = @ProdHouseID and ProductList.ProductName = @ProductName)
	set @addedProdID = (select ProductID from Product where SerialNo = @serialNo)
	insert into WareHouseInv values (@serialNo,@WareHouseID)
	delete from ProdHouseInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[move_Store_Zone]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_Store_Zone]
(
	@SerialNo int,
	@StoreName varchar(20)
)
as
begin
declare @ZoneId int = (select ZoneID from Store where StoreName = @StoreName)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into ZoneInv values(@SerialNo,@ZoneId)
	delete from StoreInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_SubDis_ChanPart]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_SubDis_ChanPart]
(@Count int,
 @ProductName varchar(20),
 @ChanPartName varchar(20))
as
begin
declare @pno int = 0
declare @SubDisId int = (select SubDistributorID from ChannelPartner where ChannelPartnerName = @ChanPartName)
declare @ChanPartID int = (select ChannelPartnerID from ChannelPartner where ChannelPartnerName = @ChanPartName)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 SubDistributorInv.SerialNo from SubDistributorInv join Product on SubDistributorInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where SubDistributorID = @SubDisID and ProductList.ProductName = @ProductName)
	insert into ChannelPartnerInv values (@serialNo,@ChanPartID)
	delete from SubDistributorInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[move_SubDistributor_Distributor]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[move_SubDistributor_Distributor]
(
	@SerialNo int,
	@SubDistributorName varchar(20)
)
as
begin
declare @DistributorId int = (select DistributorID from SubDistributors where SubDistributorName = @SubDistributorName)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into DistributorInv values(@SerialNo,@DistributorId)
	delete from SubDistributorInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_Ware_Dis]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[move_Ware_Dis]
(@Count int,
 @ProductName varchar(20),
 @CountryName varchar(20),
 @WareHouseName varchar(20))
as
begin
declare @pno int = 0
declare @DistributorId int = (select DistributorID from CountryRef where CountryName = @CountryName)
declare @WareHouseID int = (select WareHouseID from Warehouse where WarehouseName = @WareHouseName)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
declare @addedProdID int
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 WareHouseInv.SerialNo from WareHouseInv join Product on WareHouseInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where WareHouseID = @WareHouseID and ProductList.ProductName = @ProductName)
	insert into DistributorInv values (@serialNo,@DistributorID)
	delete from WareHouseInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[move_WareHouse_ProductHouse]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_WareHouse_ProductHouse]
(
	@SerialNo int,
	@WareHouseName varchar(20)
)
as
begin
declare @ProdHouseId int = (select ProdHouseID from Warehouse where WareHouseName = @WareHouseName)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into ProdHouseInv values(@SerialNo,@ProdHouseId)
	delete from WareHouseInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_Zone_ChannelPartner]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_Zone_ChannelPartner]
(
	@SerialNo int,
	@ZoneName varchar(20)
)
as
begin
declare @ChannelPartnerId int = (select ChannelPartnerID from Zone where ZoneName = @ZoneName)
begin tran
	update Product set Condition = 'Broken' where SerialNo = @SerialNo
	insert into ChannelPartnerInv values(@SerialNo,@ChannelPartnerId)
	delete from ZoneInv where SerialNo = @SerialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[move_Zone_Store]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[move_Zone_Store]
(@Count int,
 @ProductName varchar(20),
 @StoreName varchar(20))
as
begin
declare @pno int = 0
declare @ZoneId int = (select ZoneID from Store where StoreName = @StoreName)
declare @StoreID int = (select StoreID from Store where StoreName = @StoreName)
declare @ProductListID int = (select ProductID from ProductList where ProductName = @ProductName)
declare @serialNo int = 0
while @pno < @Count
begin
begin tran
	set @pno = @pno + 1
	set @serialNo = (select top 1 ZoneInv.SerialNo from ZoneInv join Product on ZoneInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where ZoneID = @ZoneID and ProductList.ProductName = @ProductName)
	insert into StoreInv values (@serialNo,@StoreID)
	delete from ZoneInv where SerialNo = @serialNo
commit transaction
end
end
GO
/****** Object:  StoredProcedure [dbo].[purchase_product]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[purchase_product]
(
	@ProductName varchar(20),
	@StoreName varchar(20),
	@SSN int,
	@PassportNo int
)
as
begin
declare @StoreId int = (select StoreId from Store where StoreName = @StoreName)
declare @serialNo int
begin tran
	set @serialNo = (select top 1 StoreInv.SerialNo from StoreInv join Product on StoreInv.SerialNo = Product.SerialNo
	join ProductList on Product.ProductID = ProductList.ProductID
	where StoreID = @StoreID and ProductList.ProductName = @ProductName)
	update Product set Condition = 'Purchased' where SerialNo = @serialNo
	update Product set SSN = @SSN where SerialNo = @serialNo
	update Product set PassPortNo = @PassportNo where SerialNo = @serialNo
	delete from StoreInv where SerialNo = @serialNo
	insert into History values(@serialNo,'Purchased','Bought',GetDate())
	select @serialNo
commit transaction
end
GO
/****** Object:  StoredProcedure [dbo].[ShowMatchingChanPart]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowMatchingChanPart]
(
	@SubDistribName varchar(20)
)
as
begin
	declare @SubDistributorId int = (Select SubDistributorID from SubDistributors where SubDistributorName = @SubDistribName)
	select * from MatchingChanPart(@SubDistributorId)
end
GO
/****** Object:  StoredProcedure [dbo].[ShowMatchingStore]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowMatchingStore]
(
	@ZoneName varchar(20)
)
as
begin
	declare @ZoneId int = (Select ZoneID from Zone where ZoneName = @ZoneName)
	select * from MatchingStore(@ZoneId)
end
GO
/****** Object:  StoredProcedure [dbo].[ShowMatchingSubDistribs]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ShowMatchingSubDistribs]
(
	@DistribName varchar(20)
)
as
begin
	declare @DistributorId int = (Select DistributorID from Distributors where DistributorName = @DistribName)
	select * from MatchingSubDistribs(@DistributorId)
end
GO
/****** Object:  StoredProcedure [dbo].[ShowMatchingWareHouses]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowMatchingWareHouses]
(
	@ProdHouseName varchar(20)
)
as
begin
	declare @ProdHouseId int = (Select ProdHouseID from ProductionHouse where ProdHouseName = @ProdHouseName)
	select * from MatchingWareHouses(@ProdHouseId)
end
GO
/****** Object:  StoredProcedure [dbo].[ShowMatchingZone]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ShowMatchingZone]
(
	@ChanPartName varchar(20)
)
as
begin
	declare @ChanPartId int = (Select ChannelPartnerID from ChannelPartner where ChannelPartnerName = @ChanPartName)
	select * from MatchingZone(@ChanPartId)
end
GO
/****** Object:  StoredProcedure [dbo].[ViewProductHistory]    Script Date: 2/3/2021 9:35:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ViewProductHistory]
(
	@SerialNo int
)
as
begin
	Select * from HistoryView where [Serial Number] = @SerialNo
end
GO
USE [master]
GO
ALTER DATABASE [AppleInc] SET  READ_WRITE 
GO
