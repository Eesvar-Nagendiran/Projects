select * from nashvillehousingclean;

--it is to decide whether or not give permission to make changed in the database
SET SQL_SAFE_UPDATES = 1;

-- Changing SaleDate column into Date only column
select SaleDate, date(SaleDate)
from nashvillehousingclean;

alter table nashvillehousingclean
add column ConvertedSaleDate date;

update nashvillehousingclean
set ConvertedSaleDate = date(SaleDate);

-- Fill in PropertyAddress

UPDATE nashvillehousingclean
SET PropertyAddress = NULL
WHERE PropertyAddress = '';


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, coalesce(a.PropertyAddress,b.PropertyAddress)
from nashvillehousingclean a
join nashvillehousingclean b on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null;

update nashvillehousingclean a
join nashvillehousingclean b on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
set a.PropertyAddress = coalesce(a.PropertyAddress,b.PropertyAddress) 
where a.PropertyAddress is null;


-- Spliting PropertyAddress
select substring_index(PropertyAddress, ',', 1),
substring_index(PropertyAddress, ',', -1)
from nashvillehousingclean;

alter table nashvillehousingclean
add column PropertySplitAddress nvarchar(255);

update nashvillehousingclean
set PropertySplitAddress = substring_index(PropertyAddress, ',', 1);

alter table nashvillehousingclean
add column PropertySplitCity nvarchar(255);

update nashvillehousingclean
set PropertySplitCity = substring_index(PropertyAddress, ',', -1);


-- Split OwnerAddress

select substring_index(OwnerAddress, ',', 1),
substring_index(substring_index(OwnerAddress, ',', -2), ',',1),
substring_index(OwnerAddress, ',', -1)
from nashvillehousingclean;

alter table nashvillehousingclean
add column OwnerSplitAddress nvarchar(255);

update nashvillehousingclean
set OwnerSplitAddress = substring_index(OwnerAddress, ',', 1);

alter table nashvillehousingclean
add column OwnerSplitCity nvarchar(255);

update nashvillehousingclean
set OwnerSplitCity = substring_index(substring_index(OwnerAddress, ',', -2), ',',1);

alter table nashvillehousingclean
add column OwnerSplitState nvarchar(255);

update nashvillehousingclean
set OwnerSplitState = substring_index(OwnerAddress, ',', -1);


-- Change 'N' and 'Y' to 'No' and 'Yes' in SoldAsVacant Field
select SoldAsVacant, count(SoldAsVacant) 
from nashvillehousingclean
group by SoldAsVacant;

select 
case when SoldAsVacant = 'N' then 'No'
     when SoldAsVacant = 'Y' then 'Yes'
     else SoldAsVacant
     end
from nashvillehousingclean;

update nashvillehousingclean
set SoldAsVacant = case when SoldAsVacant = 'N' then 'No'
     when SoldAsVacant = 'Y' then 'Yes'
     else SoldAsVacant
     end;


-- Remove Duplicate Rows
with rn as (
select *,
row_number() over(partition by ParcelID, SalePrice, LegalReference, OwnerName, Acreage, ConvertedSaleDate) as row_num
from nashvillehousingclean)

select * from rn
where row_num > 1;


delete n
from nashvillehousingclean n
join(
select *,
row_number() over(partition by ParcelID, SalePrice, LegalReference, OwnerName, Acreage, ConvertedSaleDate) as row_num
from nashvillehousingclean) as rn
on n.ParcelID = rn.ParcelID
where rn.row_num > 1;

-- Drop Unnecessary Columns
alter table nashvillehousingclean
drop column PropertyAddress, drop OwnerAddress, drop FillInPropertyAddress, drop SaleDate;

