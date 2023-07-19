use master
go
drop  database ATM
go 
Create database ATM
go 
use ATM
go
create Table UserType(
userTypeID int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType(UserTypeID),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table TransactionType(
transTypeID int primary key,
typeName varchar(20) not null,
[description] varchar (40) null
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)




GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (4, N'Common')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (1, N'Ali', 2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (2, N'Ahmed', 1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel', 3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman', 4, N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez', 2, N'03036061000', N'Lahore')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1324327436569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325423336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325436566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325666456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2343243253436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1324327436569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'2343243253436')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'2324325423336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'2324325436566')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (1, N'Withdraw', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (2, N'Deposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (3, N'ScheduledDeposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (4, N'Failed', NULL)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1324327436569', 500, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'2343243253436', 3000, 3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'2324325436566', 2500, 2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'2324325436566', 2000, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'2324325423336', 6000, 4)
GO


Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType



-- q1

CREATE function returncardnum(@num varchar(20))
returns float
AS
begin
declare @blance float
select @blance = card.balance from Card where Card.cardNum = @num;
return @blance
END

Select dbo.returncardnum(1324327436569)

-- q2

CREATE function returndetals(@ID int)
returns table
as
return select * from [User] where [user].userid = @ID;

select * from dbo.returndetals(3)

-- q3

create procedure dbo.detalsfromname
@name varchar(20)
as 
begin
select * from [user] where [user].name = @name;
end

execute dbo.detalsfromname @name = 'aqeel'

-- q4:

CREATE PROCEDURE dbo.getUserCardsAndBalance
    @userId int
AS
BEGIN
    SELECT [Card].cardNum, dbo.getBalance([Card].cardNum) AS balance
    FROM [Card] JOIN UserCard ON [Card].cardNum = UserCard.cardNum  
    WHERE UserCard.userID = @userId;
END
----------------------
DECLARE @input int = 1
EXECUTE dbo.getUserCardsAndBalance
@userId =  @input

--q5:
CREATE FUNCTION dbo.getUserCardsAndBalance2(@id int)
RETURNS TABLE
AS

RETURN SELECT [Card].cardNum, dbo.getBalance([Card].cardNum) AS balance
    FROM [Card] JOIN UserCard ON [Card].cardNum = UserCard.cardNum  
    WHERE UserCard.userID = @id;
	
SELECT * FROM dbo.getUserCardsAndBalance2(1)


-------------------------------------------Q6

CREATE PROCEDURE dbo.getUserCardsCount
    @userId int
AS
BEGIN
    SELECT COUNT(*) AS NoOfCards
    FROM [Card] JOIN UserCard ON [Card].cardNum = UserCard.cardNum  
    WHERE UserCard.userID = @userId;
END
----------------------
DECLARE @input int = 2
EXECUTE dbo.getUserCardsCount
@userId =  @input



CREATE PROCEDURE Loginn
@cardNum varchar(20),
@pin varchar(4) ,
@status int OUTPUT
AS

if exists(Select * FROM [Card] WHERE [Card].PIN = @pin AND [Card].cardNum = @cardNum)
BEGIN
		set @status=1
END

else
BEGIN
		set @status = 0
END
GO
------------
Declare @input1 varchar(20) = '1234'
, @input2 int = 9004
, @output int


EXECUTE Loginn
@cardNum = @input1,
@pin = @input2,

@status =  @output OUTPUT

SELECT @output
GO
--While it is possible to write a UDF that works similarly to the Login stored procedure, it is not recommended.The main reason is that UDFs are not allowed to have side effects, such as modifying data, which is required in a login scenario where the status output parameter is being modified based on the input values.


-------------------------------------------Q8
CREATE PROCEDURE Updatee
@cardNum varchar(20),
@pin varchar(4) ,
@new_pin varchar(4) 
AS

if exists(Select * FROM [Card] WHERE [Card].PIN = @pin AND [Card].cardNum = @cardNum)
BEGIN
		Update [Card] SET PIN = @new_pin WHERE PIN = @pin
		print 'Pin Updated.'

END

else
BEGIN
		print 'Error!'
END
GO
------------
Declare @input1 varchar(20) = '1235'
, @input2 varchar(4) = '9235'
, @input3 varchar(4) = '9234'


EXECUTE Updatee
@cardNum = @input1,
@pin = @input2,
@new_pin = @input3
GO



-------------------------------------------Q9
CREATE PROCEDURE Withdraw 
    @cardNum varchar(20),
    @pin varchar(4),
    @amount float
AS
BEGIN
    DECLARE @status int

    -- Check if the card number and pin are valid
    EXECUTE Loginn 
        @cardNum = @cardNum, 
        @pin = @pin, 
        @status = @status OUTPUT

    -- If login is successful, insert transaction details
    IF @status = 1 AND dbo.getLength(@cardNum) = 16
    BEGIN
        -- Get the next transaction ID
        DECLARE @nextTransID1 int = (SELECT MAX(transID) + 1 FROM [Transaction])

        -- Insert transaction details into Transaction table
        INSERT INTO [Transaction] (transID, transDate, cardNum, transAmount, transType)
        VALUES (@nextTransID1, GETDATE(), @cardNum, @amount, 1)

        -- Update the balance of the card
        UPDATE [Card] 
        SET balance = balance - @amount 
        WHERE cardNum = @cardNum
    END
    -- If login fails or card number is invalid, insert failed transaction
    ELSE
    BEGIN
        -- Get the next transaction ID
        DECLARE @nextTransID1 int = (SELECT MAX(transID) + 1 FROM [Transaction])

        -- Insert failed transaction details into Transaction table
        INSERT INTO [Transaction] (transID, transDate, cardNum, transAmount, transType)
        VALUES (@nextTransID1, GETDATE(), @cardNum, @amount, 4)
    END
END



Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]



