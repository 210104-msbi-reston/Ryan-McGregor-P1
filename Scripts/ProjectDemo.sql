Use AppleInc

--View the List of Products--

Select * from AllProductList --Show all the products one can make

Select * from AllProductionHouses --Show All production houses in DB

exec GetProdHouseInv_Proc 'ProdHouse_UK' --Get Production House Inventory using ProdHouse Name

exec create_products_byType 'IPad Mini',1000,'ProdHouse_UK' --Create a number of products at a production house

exec GetProdHouseInv_Proc 'ProdHouse_UK'


/*


Below is the procedure used to create the products

Create procedure create_products_byType
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

*/

/*

Below is the trigger used to capture the history of a product

alter trigger AddToHistoryProdHouse
on ProdHouseInv
after insert
as
begin
	declare @SrNo int
	set @SrNo = (select i.SerialNo from inserted i)
	declare @ProdId int = (select i.ProdHouseID from inserted i)
	declare @ProdHouseName varchar(20) = (select ProdHouseName from ProductionHouse where ProdHouseID = @ProdId)
	update Product set CurrentLoc = @ProdHouseName where SerialNo = @SrNo
	insert into History values (@SrNo,'Moved to ProdHouse',@ProdHouseName,GetDate())
end

*/

exec GetASerialNo

exec ViewProductHistory 1720090

exec ShowMatchingWareHouses 'ProdHouse_UK'

/*

Code used to show the matching warehouses


create procedure ShowMatchingWareHouses
(
	@ProdHouseName varchar(20)
)
as
begin
	declare @ProdHouseId int = (Select ProdHouseID from ProductionHouse where ProdHouseName = @ProdHouseName)
	select * from MatchingWareHouses(@ProdHouseId)
end

create view WarehouseMatch
as
select ProdHouseID as [ProdHouse ID],
	   WareHouseName as [WareHouse Name],
	   CountryName as [Country],
	   ContName as [Continent] from WareHouse
	   join CountryRef on WareHouse.CountryID = CountryRef.CountryId 
	   join ContinentRef on CountryRef.ContID = ContinentRef.ContId

create function MatchingWareHouses
(
	@ProdHouseID int
)
returns table
as
	return select [WareHouse Name],[Country],[Continent] from WarehouseMatch where [ProdHouse ID] = @ProdHouseID

*/

exec GetWareHouseInv_Proc 'WH1UK'

exec move_products 10,'IPad Air','WH1UK'

exec GetWareHouseInv_Proc 'WH1UK'

--=====================================================================================================================

--=====================================================================================================================

exec GetDistributorInv_Proc 'Distrib1'

exec move_Ware_Dis 10,'IPad Air','United Kingdom','WH1UK'

exec GetDistributorInv_Proc 'Distrib1'

--=====================================================================================================================


exec ShowMatchingSubDistribs 'Distrib1'

exec GetSubDistributorInv_Proc 'SD2_UK'

exec move_Dis_SubDis 10,'IPad Air','United Kingdom','SD2_UK'

exec GetSubDistributorInv_Proc 'SD2_UK'

--=====================================================================================================================

exec ShowMatchingChanPart 'SD2_UK'

exec ChannelPartnerInv_Proc 'ChanP3_UK'

exec move_SubDis_ChanPart 10,'IPad Air','ChanP3_UK'

exec ChannelPartnerInv_Proc 'ChanP3_UK'

--=====================================================================================================================

exec ShowMatchingZone 'ChanP3_UK'

exec GetZone_Proc 'Zone3_UK'

exec move_ChanPart_Zone 10,'IPad Air', 'Zone3_UK'

--=====================================================================================================================

exec ShowMatchingStore 'Zone3_UK'

exec GetStoreInv_Proc 'Store5_UK'

exec move_Zone_Store 10, 'IPhone 12' ,'Store5_UK'

exec GetStoreInv_Proc 'Store5_UK'

--=====================================================================================================================

--Purchasing a product


exec purchase_product 'IPhone XR','Store5_UK',9999999,9999999

select * from Product where SerialNo = 19450

exec move_Store_Zone 19450,'Store5_UK'

exec move_Zone_ChannelPartner 19450, 'Zone3_UK'

exec move_ChannelPartner_SubDistributor 19450, 'ChanP3_UK'

exec move_SubDistributor_Distributor 19450, 'SD2_UK'

exec move_Distributor_WareHouse 19450, 'United Kingdom','Distrib1'

exec move_WareHouse_ProductHouse 19450, 'WH1UK'

exec FixProduct 19450

exec ViewProductHistory 19450

select * from Product where SerialNo = 19450

--------------------------------------------------------------