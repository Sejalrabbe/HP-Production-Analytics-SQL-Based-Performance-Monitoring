CREATE DATABASE hp_production_analysis;
USE hp_production_analysis;

# Table 1: PRODUCTION
CREATE TABLE production (
    prod_id INT PRIMARY KEY,
    prod_date DATE,
    plant VARCHAR(50),
    product VARCHAR(50),
    units_produced INT,
    production_target INT,
    shift VARCHAR(10)
);
select * from production;
INSERT INTO production VALUES
(1,'2025-01-01','Delhi','Laptop',1200,1300,'A'),
(2,'2025-01-01','Bangalore','Desktop',900,850,'A'),
(3,'2025-01-01','Pune','Printer',700,750,'B'),
(4,'2025-01-02','Delhi','Laptop',1300,1400,'B'),
(5,'2025-01-02','Pune','Desktop',800,780,'C'),
(6,'2025-01-03','Bangalore','Printer',600,650,'A'),
(7,'2025-01-03','Delhi','Desktop',950,900,'C'),
(8,'2025-01-03','Pune','Laptop',1400,1500,'B'),
(9,'2025-01-04','Delhi','Printer',650,700,'A'),
(10,'2025-01-04','Bangalore','Laptop',1500,1600,'C'),
(11,'2025-01-05','Pune','Desktop',820,800,'B'),
(12,'2025-01-05','Delhi','Laptop',1350,1400,'A'),
(13,'2025-01-06','Bangalore','Printer',720,760,'C'),
(14,'2025-01-06','Pune','Laptop',1450,1500,'A'),
(15,'2025-01-07','Delhi','Desktop',980,950,'B'),
(16,'2025-01-07','Bangalore','Laptop',1550,1600,'A'),
(17,'2025-01-08','Pune','Printer',680,700,'C'),
(18,'2025-01-08','Delhi','Laptop',1380,1400,'B'),
(19,'2025-01-09','Bangalore','Desktop',910,900,'C'),
(20,'2025-01-09','Pune','Laptop',1480,1500,'A');

#Table 2: QUALITY
CREATE TABLE quality (
    q_id INT PRIMARY KEY,
    prod_date DATE,
    product VARCHAR(50),
    defective_units INT,
    defect_type VARCHAR(50),
    rework_units INT
);
select * from quality;
INSERT INTO quality VALUES
(1,'2025-01-01','Laptop',45,'Assembly',20),
(2,'2025-01-01','Desktop',20,'Electrical',10),
(3,'2025-01-01','Printer',25,'Packaging',12),
(4,'2025-01-02','Laptop',50,'Assembly',15),
(5,'2025-01-02','Desktop',18,'Alignment',9),
(6,'2025-01-03','Printer',30,'Packaging',14),
(7,'2025-01-03','Desktop',22,'Electrical',8),
(8,'2025-01-03','Laptop',40,'Assembly',10),
(9,'2025-01-04','Laptop',38,'Packaging',11),
(10,'2025-01-04','Printer',28,'Assembly',12),
(11,'2025-01-05','Desktop',25,'Electrical',10),
(12,'2025-01-05','Laptop',42,'Alignment',16),
(13,'2025-01-06','Printer',33,'Packaging',15),
(14,'2025-01-06','Laptop',48,'Electrical',18),
(15,'2025-01-07','Desktop',20,'Alignment',7),
(16,'2025-01-07','Laptop',44,'Assembly',17),
(17,'2025-01-08','Printer',32,'Packaging',14),
(18,'2025-01-08','Laptop',39,'Electrical',13),
(19,'2025-01-09','Laptop',50,'Packaging',20),
(20,'2025-01-09','Desktop',23,'Assembly',9);

#Table 3: MACHINE UTILIZATION
CREATE TABLE machine_utilization (
    m_id INT PRIMARY KEY,
    machine_name VARCHAR(50),
    runtime_hours INT,
    downtime_hours INT,
    plant VARCHAR(50)
);
select * from machine_utilization;
INSERT INTO machine_utilization VALUES
(1,'M1',20,5,'Delhi'),
(2,'M2',22,3,'Delhi'),
(3,'M3',18,6,'Bangalore'),
(4,'M4',25,2,'Pune'),
(5,'M5',19,7,'Bangalore'),
(6,'M6',21,4,'Delhi'),
(7,'M7',23,5,'Pune'),
(8,'M8',17,6,'Bangalore'),
(9,'M9',26,3,'Delhi'),
(10,'M10',20,4,'Pune'),
(11,'M11',24,2,'Bangalore'),
(12,'M12',16,7,'Delhi'),
(13,'M13',22,5,'Pune'),
(14,'M14',19,6,'Bangalore'),
(15,'M15',23,3,'Delhi'),
(16,'M16',21,4,'Pune'),
(17,'M17',18,5,'Bangalore'),
(18,'M18',24,3,'Delhi'),
(19,'M19',20,6,'Pune'),
(20,'M20',25,2,'Bangalore');


#Table 4: COST
CREATE TABLE cost (
    c_id INT PRIMARY KEY,
    prod_date DATE,
    product VARCHAR(50),
    cost_per_unit DECIMAL(10,2),
    scrap_cost DECIMAL(10,2)
);
select * from cost;
INSERT INTO cost VALUES
(1,'2025-01-01','Laptop',35000,5000),
(2,'2025-01-01','Desktop',25000,3000),
(3,'2025-01-01','Printer',15000,2000),
(4,'2025-01-02','Laptop',36000,6000),
(5,'2025-01-02','Desktop',25500,3200),
(6,'2025-01-02','Printer',15500,2100),
(7,'2025-01-03','Laptop',35500,5200),
(8,'2025-01-03','Desktop',27000,3500),
(9,'2025-01-03','Printer',16000,2300),
(10,'2025-01-04','Laptop',36500,6100),
(11,'2025-01-04','Desktop',26000,3300),
(12,'2025-01-05','Printer',16500,2500),
(13,'2025-01-05','Laptop',37000,6200),
(14,'2025-01-06','Desktop',27500,3600),
(15,'2025-01-06','Printer',15800,2400),
(16,'2025-01-07','Laptop',38000,6500),
(17,'2025-01-07','Desktop',28000,3700),
(18,'2025-01-08','Printer',16200,2600),
(19,'2025-01-08','Laptop',38500,6800),
(20,'2025-01-09','Desktop',29000,3900);

#----------------------------------------------------------------------------
 # TOTAL UNITS PRODUCES #
SELECT SUM(units_produced) AS total_units_produced
FROM Production;
---------------------------------------------------------------------------------------------------------
 #TOTAL PRODUCTION BY PRODUCT#
 SELECT product, SUM(units_produced) AS total_units
FROM Production
GROUP BY product;
--------------------------------------------------------------------------------------------------------------
 #PLANT-WISE PRODUCTION PERFORMANCE#
 SELECT plant, SUM(units_produced) AS total_units
FROM Production
GROUP BY plant
ORDER BY total_units DESC;
-----------------------------------------------------------------------------------------------------------------
# Target vs Achievement% #
SELECT 
    product,
    SUM(production_target) AS total_target,
    SUM(units_produced) AS total_produced,
    (SUM(units_produced) * 100.0 / SUM(production_target)) AS achievement_percent
FROM Production
GROUP BY product;
--------------------------------------------------------------------------------------------------------------
 # Defect rate(overall) #
 SELECT 
    SUM(defective_units) AS total_defects,
    SUM(units_produced) AS total_produced,
    (SUM(defective_units) * 100.0 / SUM(units_produced)) AS defect_rate_percent
FROM Quality q
JOIN Production p ON q.q_id = p.prod_id;
---------------------------------------------------------------------------------------------------------------
 #Defect Rate by Product#
 SELECT 
    p.product,
    SUM(q.defective_units) AS defects,
    SUM(p.units_produced) AS produced,
    (SUM(q.defective_units) * 100.0 / SUM(p.units_produced)) AS defect_rate_percent
FROM Quality q
JOIN Production p ON q.q_id = p.prod_id
GROUP BY p.product
ORDER BY defect_rate_percent DESC;
------------------------------------------------------------------------------------------------------------------ 
#Plant Downtime Summary#
SELECT 
    plant,
    SUM(downtime_hours) AS total_downtime
FROM Machine_utilization
GROUP BY plant
ORDER BY total_downtime DESC;
------------------------------------------------------------------------------------------------------------------
#Machine Utilization % #
SELECT 
    machine_name,
    SUM(runtime_hours) AS total_runtime,
    SUM(downtime_hours) AS total_downtime,
    (SUM(runtime_hours) * 100.0 / (SUM(runtime_hours) + SUM(downtime_hours))) AS utilization_percent
FROM Machine_utilization
GROUP BY machine_name
ORDER BY utilization_percent DESC;
--------------------------------------------------------------------------------------------------------------------------

#Scrap Cost Contribution#
SELECT 
    product,
    SUM(scrap_cost) AS total_scrap_cost
FROM Cost
GROUP BY product
ORDER BY total_scrap_cost DESC;
--------------------------------------------------------------------------------------------------------
#Production Efficiency (Good Units %)#
SELECT 
    p.product,
    SUM(p.units_produced - q.defective_units) AS good_units,
    SUM(p.units_produced) AS total_units,
    (SUM(p.units_produced - q.defective_units) * 100.0 / SUM(p.units_produced)) AS efficiency_percent
FROM Production p
JOIN Quality q ON p.prod_id = q.q_id
GROUP BY p.product;
-------------------------------------------------------end--------------------------------------------------------------------







