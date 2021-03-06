Create Database if not exists `order-directory` ;
use `order-directory`;



create table if not exists `supplier`(
`SUPP_ID` int primary key,
`SUPP_NAME` varchar(50) ,
`SUPP_CITY` varchar(50),
`SUPP_PHONE` varchar(10)
);




CREATE TABLE IF NOT EXISTS `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));

 

CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );



  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `PRO_DESC` VARCHAR(60) NULL DEFAULT NULL,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)
  
  );


 CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );


 
CREATE TABLE IF NOT EXISTS `orders` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );






CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );

-- 2)

insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');




  
INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');


 



  
INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
  

  
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);
  


  
  
INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);
  

  
INSERT INTO `ORDERS` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDERS` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDERS` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDERS` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDERS` VALUES(30,3500,"2021-08-16",4,3);
  
  

  
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);


-- 3) Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000. 
SELECT c.CUS_GENDER, count(c.CUS_GENDER)
FROM CUSTOMER c, ORDERS o
WHERE c.CUS_ID = o.CUS_ID
and o.ORD_AMOUNT >= 3000
GROUP BY c.CUS_GENDER;

-- 4) Display all the orders along with the product name ordered by a customer having
-- Customer_Id=2. 
SELECT o.*, p.PRO_NAME
FROM ORDERS o inner join PRODUCT_DETAILS pd ON o.PROD_ID = pd.PROD_ID
inner join PRODUCT p ON pd.PRO_ID = p.PRO_ID
WHERE o.CUS_ID = 2;

-- 5) Display the Supplier details who can supply more than one product

SELECT s.*
FROM SUPPLIER s left join PRODUCT_DETAILS pd on s.SUPP_ID = pd.SUPP_ID
WHERE s.SUPP_ID = pd.SUPP_ID
group by s.SUPP_ID
having count(pd.SUPP_ID)>1;

    
-- 6)	Find the category of the product whose order amount is minimum.
SELECT c.*
FROM ORDERS o 
	inner join PRODUCT_DETAILS pd ON o.PROD_ID = pd.PROD_ID
	inner join PRODUCT p ON pd.PRO_ID = p.PRO_ID
	inner join CATEGORY c ON p.CAT_ID = c.CAT_ID
WHERE o.ORD_AMOUNT

-- 7)	Display the Id and Name of the Product ordered after ???2021-10-05???.

select p.PRO_ID, p.PRO_NAME
from ORDERS o inner join PRODUCT_DETAILS pd ON o.PROD_ID=pd.PROD_ID  
inner join PRODUCT p ON pd.PRO_ID=p.PRO_ID
where o.ORD_DATE>'2021-10-05';

-- 8)	Print the top 3 supplier name and id and their rating on the basis of 
--their rating along with the customer name who has given the rating.
SELECT s.SUPP_NAME, s.SUPP_ID, r.RAT_RATSTARS
from CUSTOMER c 
inner join RATING r on c.CUS_ID=r.CUS_ID
inner join SUPPLIER s on r.SUPP_ID = s.SUPP_ID
order by r.RAT_RATSTARS des limit 3;


-- 9)	Display customer name and gender whose names start or end with character 'A'.
select c.CUS_NAME, c.CUS_GENDER 
from CUSTOMER c
where c.CUS_NAME like '%A' or c.CUS_NAME like 'A%';

-- 10)	Display the total order amount of the male customers.
select sum(o.ORD_AMOUNT)
from CUSTOMER c 
inner join ORDER o ON c.CUS_ID=o.CUS_ID
where  CUS_GENDER = 'M';

-- 11)	Display all the Customers left outer join with  the orders.
select c.*
from CUSTOMER c 
left join ORDER o ON c.CUS_ID = o.CUS_ID

-- 12)	 Create a stored procedure to display the Rating for a Supplier if any 
--along with the Verdict on that rating if any like if rating >4 then ???Genuine Supplier??? if rating >2 
--???Average Supplier??? else ???Supplier should not be considered???.

delimiter &&
create procedure proc()
begin
select s.SUPP_ID,s.SUPP_NAME, r.RAT_RATSTARS,
case 
when r.RAT_RATSTARS>4 then 'Genuine Supplier'
when r.RAT_RATSTARS>2 then 'Average Supplier'
else 'Supplier should not be considered'
end as Verdict
from SUPPLIER s
inner join RATING r ON s.SUPP_ID=r.SUPP_ID
end &&

call proc();


