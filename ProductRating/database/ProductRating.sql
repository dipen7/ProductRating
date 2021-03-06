USE [master]
GO
/****** Object:  Database [ProductRating]    Script Date: 4/11/2022 2:10:12 AM ******/
CREATE DATABASE [ProductRating]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProductRating', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ProductRating.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProductRating_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ProductRating_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ProductRating] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductRating].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductRating] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductRating] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductRating] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductRating] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductRating] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductRating] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProductRating] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductRating] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductRating] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductRating] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductRating] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductRating] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductRating] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductRating] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductRating] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProductRating] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductRating] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductRating] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductRating] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductRating] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductRating] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductRating] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductRating] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProductRating] SET  MULTI_USER 
GO
ALTER DATABASE [ProductRating] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductRating] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductRating] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductRating] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProductRating] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProductRating] SET QUERY_STORE = OFF
GO
USE [ProductRating]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 4/11/2022 2:10:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorProcedure] [varchar](max) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDate] [date] NULL,
	[ErrorTime] [time](7) NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](250) NOT NULL,
	[ProductDesc] [nvarchar](500) NOT NULL,
	[ProductCode] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductRating]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductRating](
	[ProductRatingID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Ratings] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[RatingRemarks] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_ProductRating] PRIMARY KEY CLUSTERED 
(
	[ProductRatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[UserPass] [varbinary](max) NOT NULL,
	[FullName] [nvarchar](100) NULL,
 CONSTRAINT [PK_UserTable] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ErrorLog] ON 

INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (1, N'dbo', 515, 16, 2, N'usp_Product', 18, N'Cannot insert the value NULL into column ''ProductID'', table ''ProductRating.dbo.Product''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-09' AS Date), CAST(N'16:44:50.9800000' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (2, N'dbo', 515, 16, 2, N'usp_Product', 18, N'Cannot insert the value NULL into column ''ProductID'', table ''ProductRating.dbo.Product''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-09' AS Date), CAST(N'16:45:24.7666667' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (3, N'dbo', 515, 16, 2, N'usp_Product', 18, N'Cannot insert the value NULL into column ''ProductID'', table ''ProductRating.dbo.Product''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-09' AS Date), CAST(N'16:48:36.5066667' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (4, N'dbo', 547, 16, 0, N'usp_ProductRating', 18, N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ProductRating_Product". The conflict occurred in database "ProductRating", table "dbo.Product", column ''ProductID''.', CAST(N'2022-04-09' AS Date), CAST(N'17:40:33.7500000' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (5, N'dbo', 547, 16, 0, N'usp_ProductRating', 18, N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ProductRating_Product". The conflict occurred in database "ProductRating", table "dbo.Product", column ''ProductID''.', CAST(N'2022-04-09' AS Date), CAST(N'17:44:44.1300000' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (6, N'dbo', 547, 16, 0, N'usp_ProductRating', 18, N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ProductRating_Product". The conflict occurred in database "ProductRating", table "dbo.Product", column ''ProductID''.', CAST(N'2022-04-09' AS Date), CAST(N'17:48:12.8633333' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (7, N'dbo', 547, 16, 0, N'usp_ProductRating', 18, N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ProductRating_Product". The conflict occurred in database "ProductRating", table "dbo.Product", column ''ProductID''.', CAST(N'2022-04-09' AS Date), CAST(N'17:51:27.2666667' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (8, N'dbo', 547, 16, 0, N'usp_ProductRating', 18, N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ProductRating_Product". The conflict occurred in database "ProductRating", table "dbo.Product", column ''ProductID''.', CAST(N'2022-04-09' AS Date), CAST(N'17:52:12.7166667' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (9, N'dbo', 515, 16, 2, N'dbo.usp_ProductRating', 18, N'Cannot insert the value NULL into column ''UserID'', table ''ProductRating.dbo.ProductRating''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-11' AS Date), CAST(N'00:14:59.3466667' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (10, N'dbo', 515, 16, 2, N'dbo.usp_ProductRating', 18, N'Cannot insert the value NULL into column ''UserID'', table ''ProductRating.dbo.ProductRating''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-11' AS Date), CAST(N'00:26:56.7300000' AS Time))
INSERT [dbo].[ErrorLog] ([id], [UserName], [ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [ErrorLine], [ErrorMessage], [ErrorDate], [ErrorTime]) VALUES (11, N'dbo', 515, 16, 2, N'dbo.usp_ProductRating', 18, N'Cannot insert the value NULL into column ''UserID'', table ''ProductRating.dbo.ProductRating''; column does not allow nulls. INSERT fails.', CAST(N'2022-04-11' AS Date), CAST(N'00:32:37.1833333' AS Time))
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDesc], [ProductCode]) VALUES (1, N'Apple', N'Organic Apple From Mustang', N'F-1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [ProductDesc], [ProductCode]) VALUES (2, N'Mango', N'Organic Mango From Tarai', N'F-2')
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductRating] ON 

INSERT [dbo].[ProductRating] ([ProductRatingID], [ProductID], [Ratings], [UserID], [RatingRemarks]) VALUES (1, 1, 3, 1, N'asas')
INSERT [dbo].[ProductRating] ([ProductRatingID], [ProductID], [Ratings], [UserID], [RatingRemarks]) VALUES (2, 2, 4, 1, N'tasty mangoes')
SET IDENTITY_INSERT [dbo].[ProductRating] OFF
SET IDENTITY_INSERT [dbo].[UserTable] ON 

INSERT [dbo].[UserTable] ([UserID], [UserName], [UserPass], [FullName]) VALUES (1, N'Dipen', 0x02000000BCC4536E1F2AC3277CAF4D204B3BAFAA3785B57B3963800AE0501972116FCF61DC716BD1E4ED1128C2113C3602A0CDC2, N'Dipendra Manandhar')
SET IDENTITY_INSERT [dbo].[UserTable] OFF
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ProductDesc]  DEFAULT ('') FOR [ProductDesc]
GO
ALTER TABLE [dbo].[ProductRating]  WITH CHECK ADD  CONSTRAINT [FK_ProductRating_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductRating] CHECK CONSTRAINT [FK_ProductRating_Product]
GO
ALTER TABLE [dbo].[ProductRating]  WITH CHECK ADD  CONSTRAINT [FK_ProductRating_UserTable] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserTable] ([UserID])
GO
ALTER TABLE [dbo].[ProductRating] CHECK CONSTRAINT [FK_ProductRating_UserTable]
GO
/****** Object:  StoredProcedure [dbo].[ups_Error_log]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[ups_Error_log]
			@ID int=NULL,
			@UserName Varchar(50)=NULL, 
            @ErrorNumber int =NULL, 
            @ErrorSeverity int=NULL, 
            @ErrorState int =NULL, 
            @ErrorProcedure varchar(max)=NULL, 
            @ErrorLine int=NULL, 
            @ErrorMessage Varchar(max)=NULL,
            @ErrorDate date=NULL,
            @ErrorTime time=NULL,
            @flag char(1)
            as 
            if @flag='i'
            Begin
		BEGIN TRY
        INSERT into [ErrorLog] 
            (
            [UserName], 
            [ErrorNumber], 
            [ErrorSeverity], 
            [ErrorState], 
            [ErrorProcedure], 
            [ErrorLine], 
            [ErrorMessage],
            [ErrorDate],
            [ErrorTime]
            ) 
        VALUES 
            (
            CONVERT(sysname, CURRENT_USER), 
            ERROR_NUMBER(),
            ERROR_SEVERITY(),
            ERROR_STATE(),
            ERROR_PROCEDURE(),
            ERROR_LINE(),
            ERROR_MESSAGE(),
            GetDate(),
            cast(getDate() as time(7))
                       
            )
			print(SCOPE_IDENTITY());
            select 0 errorCode,
            --ERROR_PROCEDURE() [ErrorProcedure],
            ErrorMessage mes from [ErrorLog] where id= SCOPE_IDENTITY();
            	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
				SELECT 0 errorCode, ERROR_MESSAGE() mes, @ErrorSeverity id
		END CATCH
		
		
	END
GO
/****** Object:  StoredProcedure [dbo].[usp_Product]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create     PROC [dbo].[usp_Product] 
		@ProductID			int	=NULL,
		@ProductName		nvarchar(250)	=NULL,
		@ProductCode		nvarchar(250)	=NULL,
		@ProductDesc		nvarchar(500)	=NULL,
		@Flag			char(15)
AS 
begin
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

IF @Flag='i' 
BEGIN
	BEGIN TRY
		if not exists(select 'x' from Product where ProductCode=@ProductCode COLLATE Latin1_General_CS_AS)
		begin
			print('no duplication')
			INSERT INTO Product (ProductName, ProductCode, ProductDesc)
			SELECT @ProductName, @ProductCode, @ProductDesc
			
			
			SELECT 0 errorCode, 'Record Successfully Inserted.' mes,SCOPE_IDENTITY() id
		end
		else
		begin
			print('duplication')
			SELECT 1 errorCode, 'Product Code already exists.' mes, @ProductCode id 
		end
	 END TRY          
	BEGIN CATCH
	print('excep')
	exec ups_error_log @flag='i'
	END CATCH
END

if @Flag = 'a'
begin	
	if exists(select 'x' from Product)	
	begin
		SELECT 0 errorcode, 'logged in' mes
		SELECT ProductID,ProductName,ProductDesc,ProductCode from Product
	end
	else
	begin
		select 1 errorcode, 'no products found' mes 
		SELECT ProductID,ProductName,ProductDesc,ProductCode from Product
	end
end

if @flag = 's'
begin
	select ProductID,ProductName,ProductDesc,ProductCode from Product where ProductID=@ProductID or ProductCode=@ProductCode COLLATE Latin1_General_CS_AS
end

end

--exec usp_Product @ProductID=1,@ProductName=N'Mango',@ProductCode=N'F-2',@ProductDesc=N'Organic Mango From Tarai', @Flag=N'i'
--exec usp_Product @ProductID=1,@ProductName=N'Apple',@ProductCode=N'F-1',@ProductDesc=N'Organic Apple From Mustang', @Flag=N'i'
--exec usp_Product @ProductID=1,@ProductName=N'Apple',@ProductCode=N'F-1',@ProductDesc=N'Organic Apple From Mustang', @Flag=N'a'
--exec usp_Product @ProductCode=N'f-1', @Flag=N's'
--select * from ErrorLog
GO
/****** Object:  StoredProcedure [dbo].[usp_ProductRating]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     PROC [dbo].[usp_ProductRating] 
		@ProductRatingID	int	=NULL,
		@ProductID			int	=NULL,
		@UserID				int	=NULL,
		@RatingRemarks		nvarchar(100)	=NULL,
		@Ratings			int	=NULL,
		@searchText nvarchar(75) ='',
		@sortColumn nvarchar(75)='ProductID',
		@sortOrder nvarchar(10)='asc',
		@skip int=0,
		@take int=10,
		@Flag			char(15)
AS 
begin
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
IF @Flag='r' --rate the product
BEGIN
	BEGIN TRY
		if not exists(select 'x' from ProductRating where UserID=@UserID and ProductID=@ProductID)
		begin
		
			INSERT INTO ProductRating (ProductID, Ratings, UserID,RatingRemarks)
			SELECT @ProductID, @Ratings, @UserID,@RatingRemarks		
		end
		else
		begin
			update ProductRating set Ratings=@Ratings,RatingRemarks=@RatingRemarks where UserID=@UserID and ProductID=@ProductID
		end
		SELECT 0 errorCode, 'Ratings Successfully recorded.' mes,SCOPE_IDENTITY() id
	 END TRY          
	BEGIN CATCH
	select 1 errorCode,error_message() mes
	exec ups_error_log @flag='i'
	--select CONVERT(sysname, CURRENT_USER), ERROR_NUMBER(),ERROR_SEVERITY(), ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE(),GetDate(),cast(getDate() as time(7))
	END CATCH
END

if @Flag = 'a'
begin		
	select ProductRatingID,ProductID, Ratings, UserID,RatingRemarks from ProductRating
end

if @flag = 's'
begin
	select ProductRatingID,ProductID, Ratings, UserID,RatingRemarks from ProductRating where ProductRatingID=@ProductRatingID
end

if @flag = 'd' 
begin
	delete ProductRating where ProductRatingID=@ProductRatingID
end
if @flag='t'
begin
	if object_id('tempdb..#temp')  is not null drop table #temp
	if object_id('tempdb..#temp2')  is not null drop table #temp2
	create table #temp  
	(  
		SN int,ProductName nvarchar(250), Ratings nvarchar(50), Remarks  nvarchar(100)
	)
	create table #temp2
	(  
		SN int,ProductName nvarchar(250), Ratings nvarchar(50), Remarks  nvarchar(100)
	)
	declare @sqlquery nvarchar(MAX) = 'insert into #temp(Ratings,ProductName,Remarks) 
	select CASE
    WHEN pr.ratings=3 THEN ''worst''
    WHEN pr.ratings=2 THEN ''bad''
    ELSE ''good'' end as Ratings,p.productname ProductName,pr.ratingremarks Remarks from ProductRating pr left join product p on p.productid=pr.productid left join usertable u on u.userid=pr.userid';--order by '+@sortColumn+ ' ' +@sortOrder;
	print(@sqlquery);
	exec(@sqlquery);
	declare @sqlquery2 nvarchar(MAX) = 'insert into #temp2(SN,Ratings,ProductName,Remarks) 
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@sortColumn+ ' ' +@sortOrder+') AS SN,Ratings,ProductName,Remarks
	FROM  #temp where Ratings like N''%'+@searchText+'%'' order by '+@sortColumn+ ' ' +@sortOrder;
	print(@sqlquery2);
	exec(@sqlquery2);
	select * from #temp2 order by SN
        OFFSET @skip ROWS FETCH NEXT @take ROWS ONLY
	
	select count(*) recordsTotal, (select count(*) from #temp2) recordsFiltered from #temp
end
end

--exec usp_ProductRating @Flag=N'r',@ProductID=1,@UserID=1,@RatingRemarks=N'best product',@Ratings=5
--exec usp_ProductRating @Flag=N'r',@ProductID=2,@UserID=1,@RatingRemarks=N'tasty mangoes',@Ratings=4
--exec usp_ProductRating @Flag=N'r',@ProductID=3,@UserID=1,@RatingRemarks=N'tasty mangoes',@Ratings=4
--exec usp_ProductRating @Flag=N'a'--,@ProductID=1,@UserID=1,@RatingRemarks=N'best product',@Ratings=5
--exec usp_ProductRating @Flag=N's',@ProductRatingID=1 --,@ProductID=1,@UserID=1,@RatingRemarks=N'best product',@Ratings=5
--select * from errorlog
GO
/****** Object:  StoredProcedure [dbo].[usp_UserTable]    Script Date: 4/11/2022 2:10:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[usp_UserTable] 
		@UserID			int	=NULL,
		@FullName		nvarchar(100)	=NULL,
		@UserName		nvarchar(100)	=NULL,
		@Password		nvarchar(MAX)	=NULL,
		--@Role			nvarchar(50)	=NULL,
		--@Status			nvarchar(50)	=NULL,
		@Flag			char(15)
AS 
begin
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

declare @key as varchar(50)
set @key = 'BlueBird'
IF @Flag='i' 
BEGIN
	BEGIN TRY
		if not exists(select 'x' from Usertable where UserName=@UserName)
		begin
		
			INSERT INTO Usertable ([FullName], [UserName], [UserPass])
			SELECT @FullName, @UserName, ENCRYPTBYPASSPHRASE(@key,@Password)
			
			
			SELECT 0 errorCode, 'Record Successfully Inserted.' mes,SCOPE_IDENTITY() id
		end
		else
		begin
			SELECT 1 errorCode, 'User Name already exists.' mes, @UserName id
		end
	 END TRY          
	BEGIN CATCH
	exec ups_error_log @flag='i'
	--select CONVERT(sysname, CURRENT_USER), ERROR_NUMBER(),ERROR_SEVERITY(), ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE(),GetDate(),cast(getDate() as time(7))
	END CATCH
END

if @Flag = 'l'
begin		
	if ( SELECT count(*) FROM UserTable WHERE 
		UserName=@UserName AND CONVERT(nvarchar(50),DECRYPTBYPASSPHRASE (@key,[UserPass])) = @Password COLLATE Latin1_General_CS_AS  )>0
	BEGIN
		SELECT 0 errorcode, 'logged in' mes
		select UserName, FullName, UserID from UserTable WHERE 
		UserName=@UserName AND CONVERT(nvarchar(50),DECRYPTBYPASSPHRASE (@key,[UserPass])) = @Password
	END
	ELSE
	BEGIN
		select 1 errorcode, 'UserName or Password did not Matched.' mes 
	END
end

end
--exec usp_UserTable @FullName=N'Dipendra Manandhar',@UserName=N'Dipen',@Password='12qw!@QW',@Flag=N'i'
--exec usp_UserTable @FullName=N'Dipendra Manandhar',@UserName=N'Dipen',@Password='12qw!@qw',@Flag=N'l'
GO
USE [master]
GO
ALTER DATABASE [ProductRating] SET  READ_WRITE 
GO
