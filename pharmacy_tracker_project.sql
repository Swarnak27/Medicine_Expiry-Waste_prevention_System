create database pharmacy_tracker;
use pharmacy_tracker;
create table Medicines (medicine_id int auto_increment primary key, name varchar(100), category varchar(100),manufacturer varchar(100));

create table Batches (batch_id int auto_increment primary key,medicine_id int,batch_number varchar(50),quantity int,expiry_date date,received_date date, foreign key (medicine_id) references Medicines(medicine_id));

create table Branches(branch_id int auto_increment primary key,branch_name varchar(100),location varchar(100));

create table Stock(stock_id int auto_increment primary key,branch_id int,batch_id int,quantity_available int,foreign key(branch_id)references Branches(branch_id),foreign key(batch_id)references Batches(batch_id));

create table Waste_log(waste_id int auto_increment primary key, batch_id int,reason varchar(100),quantity_wasted int,waste_date date, foreign key(batch_id)references Batches(batch_id));

insert Medicines (name, category, manufacturer) values 
('Paracetamol', 'Painkiller', 'Cipla'),
('Amoxicillin', 'Antibiotic', 'Sun Pharma'),
('Cetirizine', 'Antihistamine', 'Dr Reddy'),
('Metformin', 'Diabetes', 'Lupin'),
('Ibuprofen', 'Painkiller', 'Dr Reddy'),
('Dolo 650', 'Painkiller', 'Micro Labs'),
('Azithromycin', 'Antibiotic', 'Cipla'),
('Pantoprazole', 'Gastric Relief', 'Alkem'),
('Montelukast', 'Anti-Allergy', 'Lupin'),
('Cough Syrup', 'Cold & Cough', 'Himalaya');

insert Batches (medicine_id, batch_number, quantity, expiry_date, received_date) values
(1, 'P103', 120, '2026-02-10', '2025-02-01'),
(2, 'A202', 180, '2025-12-15', '2024-12-01'),
(3, 'C302', 250, '2026-03-05', '2025-03-01'),
(4, 'M402', 170, '2025-10-25', '2024-07-15'),
(1, 'P104', 130, '2025-09-30', '2024-05-10');

insert Branches (branch_name, location) values
('Central Pharmacy', 'Chennai'),
('Health Plus', 'Kallakurichi'),
('QuickMeds', 'Salem'),
('MedKart', 'Coimbatore'),
('CureWell', 'Madurai'),
('PharmaCare', 'Tiruchirappalli'),
('MediPoint', 'Erode'),
('LifeLine Pharmacy', 'Vellore'),
('Apollo Meds', 'Tirunelveli'),
('Trust Pharmacy', 'Thanjavur');

insert Stock (branch_id, batch_id, quantity_available) values
(3, 6, 70),
(1, 7, 85),
(2, 8, 90),
(3, 9, 60),
(1, 10, 100);

insert Waste_log (batch_id, reason, quantity_wasted, waste_date) values
(6, 'Damaged packaging', 10, '2025-07-10'),
(7, 'Expired', 15, '2025-08-01'),
(8, 'Broken seal', 5, '2025-09-20'),
(9, 'Improper storage', 12, '2025-10-01'),
(10, 'Spoiled', 8, '2025-10-15');
-- query to list all medicines
Select*from Medicines

-- query to Find all medicines by a specific manufacturer
Select name, category from Medicines where manufacturer = 'Cipla';

-- query to Count the number of medicines in each category
Select category, COUNT(*) AS total from Medicines group by category;

-- query to Show all batches of a specific medicine
Select * from Batches where medicine_id = 1;

-- query to List batches expiring this year
Select batch_number, expiry_date from Batches where year(expiry_date) = 2025;

-- query to Show batches received before a specific date
Select batch_number, received_date from Batches where received_date < '2024-07-01';

-- query to Show all branches and their locations
select*from Branches

-- query to Find branches located in 'Chennai'
select branch_name from Branches where location = 'Chennai';

-- query to Count the number of branches in each city
Select location, COUNT(*) AS total_branches from Branches group by location

-- query to List all stocks with batch and branch ID
Select* from Stock

-- query to Find total stock quantity for each branch
select branch_id, SUM(quantity_available) AS total_quantity from Stock group by branch_id;

-- query to Show stocks where quantity is less than 50
select * from Stock where quantity_available < 50;

-- query to List all waste records
select * from Waste_log

-- query to Find total quantity wasted for a batch
Select batch_id, SUM(quantity_wasted) AS total_waste from Waste_Log group by batch_id;

-- query to Show waste logs where reason is 'Expired'
Select batch_id, quantity_wasted from Waste_Log where reason = 'Expired';

-- query to retrieve top 3 batches that expire soon
Select medicine_id,batch_number,expiry_date from Batches order by expiry_date desc limit 3;

-- query to find medicines with 'mol' in their names
Select * from Medicines where name like "%mol";

-- query to retrieve the stocks available in selected branches
Select * from Stock where branch_id in(1,2);

-- query to retrieve stocks available in each branch
Select Br.branch_name,Br.location,M.name AS medicine_name,B.batch_number,S.quantity_available from Stock S join Batches B on S.batch_id = B.batch_id
join Medicines M on B.medicine_id = M.medicine_id
join Branches Br on S.branch_id = Br.branch_id
order by Br.branch_name, M.name;

-- query to show the batches that expiring between August and december 2025 with their medicine names
select B.batch_number,M.name as Medicine_name,B.expiry_date,B.received_date,B.quantity from Batches B join Medicines M on 
B.medicine_id = M.medicine_id Where B.expiry_date between '2025-08-01' and '2025-12-31' order by B.expiry_date;

-- query to retrieve the All Batch Expiry Details with Branch Info
Select Br.branch_name,M.name as medicine_name,B.batch_number,B.expiry_date,B.quantity,S.quantity_available from Batches B join Medicines M on B.medicine_id = M.medicine_id
join Stock S on B.batch_id = S.batch_id join Branches Br on S.branch_id = Br.branch_id order by B.expiry_date;

-- query to identify whether the medicines in stock or in waste
Select B.batch_number,M.name as medicine_name,S.quantity_available, null as quantity_wasted from Medicines M join Batches B on M.medicine_id = B.medicine_id join Stock S on B.batch_id = S.batch_id
union
Select B.batch_number, M.name as medicine_name,W.quantity_wasted, null as quantity_available from Medicines M join Batches B on M.medicine_id = B.medicine_id join Waste_log W on B.batch_id = W.batch_id;

-- query Shows expired medicines per branch 
Select Br.branch_name,M.name AS medicine_name,B.batch_number,B.expiry_date,S.quantity_available from Stock S join Batches B on S.batch_id = B.batch_id join Medicines M on B.medicine_id = M.medicine_id
join Branches Br on S.branch_id = Br.branch_id
where B.expiry_date < CURDATE();

-- query shows how much medicine was wasted from which batch and in which branch
Select Br.branch_name,M.name AS medicine_name,B.batch_number,W.quantity_wasted,W.reason,W.waste_date from Waste_Log W join Batches B on W.batch_id = B.batch_id join Medicines M on B.medicine_id = M.medicine_id
join Stock S on B.batch_id = S.batch_id
join Branches Br on S.branch_id = Br.branch_id
order by Br.branch_name, W.waste_date;

-- query to retrieve Total quantity wasted per medicine
Select M.name, SUM(W.quantity_wasted) AS total_waste from Waste_Log W join Batches B on W.batch_id = B.batch_id join Medicines M on B.medicine_id = M.medicine_id
group by M.name;

-- query to retrieve Medicines with batches expiring before the average expiry date
Select M.name AS medicine_name,B.batch_number,B.expiry_date,W.reason from Batches B join Medicines M on B.medicine_id = M.medicine_id left join Waste_Log W on B.batch_id = W.batch_id
where B.expiry_date < (Select AVG(expiry_date) from Batches);

-- query to retrieve Medicines Not Yet Expired But Less in Stock
Select Br.branch_name,M.name AS medicine_name,B.batch_number,S.quantity_available,B.expiry_date from Stock S join Batches B on S.batch_id = B.batch_id join Medicines M on B.medicine_id = M.medicine_id
join Branches Br on S.branch_id = Br.branch_id where B.expiry_date > CURDATE() and S.quantity_available < 50 order by S.quantity_available ASC;

-- query to retrieve Batches with no waste log
Select B.batch_number, M.name,W.quantity_wasted from Batches B join Medicines M on B.medicine_id = M.medicine_id Left join Waste_Log W on B.batch_id = W.batch_id
Where W.waste_id is null;

-- query to list older batches first to sell 
select M.name AS medicine_name,B.batch_number,B.expiry_date,B.received_date,S.quantity_available from Batches B join Medicines M on B.medicine_id = M.medicine_id
join Stock S on B.batch_id = S.batch_id order by M.name, B.expiry_date;

-- query to Identify understocked branches
Select Br.branch_name,M.name AS medicine_name,SUM(S.quantity_available) AS total_stock from Stock S
join Batches B on S.batch_id = B.batch_id join Medicines M on B.medicine_id = M.medicine_id join Branches Br on S.branch_id = Br.branch_id
group by Br.branch_id, M.medicine_id having total_stock < 50;

-- query to alert staff before medicines expire
Select M.name AS medicine_name,B.batch_number,B.expiry_date,Br.branch_name,Br.location,S.quantity_available
from Batches B join Medicines M on B.medicine_id = M.medicine_id join Stock S on B.batch_id = S.batch_id join Branches Br on S.branch_id = Br.branch_id
where B.expiry_date <= CURDATE() + INTERVAL 30 DAY order by B.expiry_date;








