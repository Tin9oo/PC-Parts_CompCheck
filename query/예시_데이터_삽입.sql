USE mydb;

-- Insert account data
INSERT INTO account (ID, Password) VALUES
	('hkd', '1234'), ('kjh', '12345'), ('psu', '123456'),
    ('ahg', '1234567'), ('kdmom', '12345678')
    ON DUPLICATE KEY UPDATE ID=ID;
SELECT * FROM account;

-- Insert opinion data
INSERT INTO opinion (product_number, ID, Star, Creation_time) VALUES
 ('co1', 'kjh', 4, DEFAULT), ('co2', 'kjh', 2, DEFAULT), ('co3', 'psu', 3, DEFAULT), ('co4', 'kjh', 5, DEFAULT), 
    ('hd1', 'psu', 1, DEFAULT), ('hd2', 'ahg', 4, DEFAULT), ('hd3', 'kjh', 3, DEFAULT), ('hd4', 'kjh', 2, DEFAULT), 
    ('ss1', 'kjh', 5, DEFAULT), ('ss2', 'kjh', 3, DEFAULT), ('ss3', 'kjh', 1, DEFAULT), ('ss4', 'psu', 3, DEFAULT), 
    ('ca1', 'kjh', 3, DEFAULT), ('ca2', 'psu', 5, DEFAULT), ('ca3', 'ahg', 4, DEFAULT), ('ca4', 'ahg', 1, DEFAULT), 
    ('cp1', 'kjh', 2, DEFAULT), ('cp2', 'kjh', 1, DEFAULT), ('cp3', 'kjh', 5, DEFAULT), ('cp4', 'kjh', 4, DEFAULT),  ('cp5', 'kjh', 3, DEFAULT), ('cp6', 'kjh', 4, DEFAULT), 
    ('gp1', 'ahg', 4, DEFAULT), ('gp2', 'psu', 3, DEFAULT), ('gp3', 'ahg', 2, DEFAULT), ('gp4', 'kjh', 1, DEFAULT), ('gp5', 'psu', 5, DEFAULT), 
    ('mb1', 'kjh', 2, DEFAULT), ('mb2', 'kjh', 4, DEFAULT), ('mb3', 'kjh', 1, DEFAULT), 
    ('rm1', 'ahg', 3, DEFAULT), ('rm2', 'kjh', 2, DEFAULT), ('rm3', 'ahg', 2, DEFAULT), ('rm4', 'psu', 5, DEFAULT),
    ('pw1', 'kjh', 1, DEFAULT), ('pw2', 'psu', 1, DEFAULT), ('pw3', 'ahg', 3, DEFAULT), ('pw4', 'kjh', 2, DEFAULT)
    ON DUPLICATE KEY UPDATE ID=ID;
SELECT * FROM opinion;

-- Insert Part data
INSERT INTO part (part_type, product_number, Name_of_product) VALUES
 ('cooler', 'co1', 'zalman cnps9x optima white led'),('cooler', 'co2', 'pcccooler paladin 400'),('cooler', 'co3', 'pcccooler paladin 400 argb'),('cooler', 'co4', '3rsys socoool rc400 (black)'),
    ('hdd', 'hd1', 'seagate barracuda 7200/256m'), ('hdd', 'hd2', 'western digital wd blue 7200/256m'), ('hdd', 'hd3', 'western digital wd blue 7200/64m'), ('hdd', 'hd4', 'seagate barracuda 5400/256m'),
    ('ssd', 'ss1', 'sk hynix platinum p41 m.2 nvme'), ('ssd', 'ss2', 'micron crucial p5 plus m.2 nvme'), ('ssd', 'ss3', 'sk hynix gold p31 m.2 nvme'), ('ssd', 'ss4', 'samsung 980 m.2 nvme'), 
    ('pc_case', 'ca1', 'micronics master m60 mesh'), ('pc_case', 'ca2', 'darkflash dlx21 rgb mesh tempered glass'), ('pc_case', 'ca3', 'abko ncore g30 trueforce'), ('pc_case', 'ca4', 'micronics em1-woofer tempered glass'),('pc_case', 'ca5', 'micronics GH4-LETO MESH'),  
    ('cpu', 'cp1', 'intel코어i5-12세대12400f'), ('cpu', 'cp2', 'intel코어i3-12세대12100f'), ('cpu', 'cp3', 'intel코어i7-12세대12700k'), ('cpu', 'cp4', 'intel코어i9-12세대12900k'), ('cpu', 'cp5', 'amdryzen5-4세대5600g'), ('cpu', 'cp6', 'amdryzen9-5세대7950x'), 
    ('gpu', 'gp1', 'msi 지포스 rtx 3060 ti 게이밍 x d6 8gb 트윈프로져8 lhr'), ('gpu', 'gp2', '이엠텍 지포스 rtx 3060 storm x dual oc d6 12gb'), ('gpu', 'gp3', 'msi 지포스 rtx 3070 게이밍 z 트리오 d6 8gb 트라이프로져2 lhr'),
    ('gpu', 'gp4', '갤럭시 galax 지포스 gtx 1650 black ex d6 4gb'), ('gpu', 'gp5', '갤럭시 galax 지포스 gt1030 d5 2gb'), 
    ('main board', 'mb1', 'asus prime b660m-a d4 stcom'), ('main board', 'mb2', 'gigabyte b650 aorus elite'), ('main board', 'mb3', 'asrock b550m pro4'),
    ('ram', 'rm1', 'samsung ddr4-3200(8gb)'),('ram', 'rm2', 'samsung ddr4-3200(16gb)'),('ram', 'rm3', 'micron crucial ddr4-3200 cl22(8gb)'),('ram', 'rm4', 'samsung ddr4-2666(8gb)'),
    ('power', 'pw1', 'zalman megamax 600s 80plus'), ('power', 'pw2', 'micronix classic ll full change 600w 80plus'), ('power', 'pw3', 'zalman megamax 500w 80plus'), ('power', 'pw4', 'zalman ecomax 700w')
    ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM part;

-- Insert cooler data
INSERT INTO cooler (case_size, Max_watt, Manufacturer, Price, Type, Purpose, product_number) VALUES
  
  ('mini_tower', 180, 'zalman', '24000', 'air', 'cpu', 'co1'),
    ('mini_tower', 200, 'pcccooler', '30000', 'air', 'cpu', 'co2'),
    ('mini_tower', 200, 'pcccooler', '35000', 'air', 'cpu', 'co3'),
    ('mini_tower', 180, '3rsys', '28500', 'air', 'cpu', 'co4')
    ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM cooler;

-- Insert HDD data
INSERT INTO HDD (Capacity, Price, Manufacturer, RPM, product_number) VALUES
  
 ('2tb', 75000, 'seagate', 7200, 'hd1'),
    ('2tb', 74000, 'western digital', 7200, 'hd2'),
    ('1tb', 62000, 'western digital', 7200, 'hd3'),
    ('4tb', 114500, 'seagate', 5400, 'hd4')
    ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM HDD;

-- Insert SSD data
INSERT INTO SSD (Manufacturer, Interface, Price, Capacity, product_number) VALUES

  ('sk hynix', 'm2', 192500, '1tb', 'ss1'),
    ('micron', 'm2', 81500, '500gb', 'ss2'),
    ('sk hynix', 'm2', 71000, '500gb', 'ss3'),
    ('samsung', 'm2', 114500, '1tb', 'ss4')
    ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM SSD;

-- Insert pc_case data
INSERT INTO pc_case (Amount_of_extra_cooler, Amount_of_sata3_SSD, Amount_of_HDD_slot, Manufacturer, Price, Case_size, product_number) VALUES
 
  (6, 2, 3, 'micronics', 40500, 'middle_tower', 'ca1'),
    (4, 2, 2, 'darkflash', 89000, 'middle_tower', 'ca2'),
    (6, 1, 1, 'abko', 43500, 'middle_tower', 'ca3'),
    (2, 2, 2, 'micronics', 47000, 'mini_tower', 'ca4'),
    (2, 2, 2, 'micronics', 58000, 'mini_tower', 'ca5')

    ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM pc_case;

INSERT INTO CPU (generation,Socket,Built_in_graphics_status,Core,Price,RAM_generation,Class,Fabless,product_number,Max_watt,Ram_operating_speed) VALUES
('intel12세대','intel1700',0,6,253410,'ddr4',2,'intel','cp1',117,4800),
('intel12세대','intel1700',0,4,144590,'ddr4',1,'intel','cp2',89,4800),
('intel12세대','intel1700',1,12,529000,'ddr4',3,'intel','cp3',190,4800),
('intel12세대','intel1700',1,16,771410,'ddr4',4,'intel','cp4',241,4800),
('ryzen4세대','am4',1,6,201000,'ddr4',2,'amd','cp5',65,3200),
('ryzen5세대','am5',1,16,1103200,'ddr5',4,'amd','cp6',140,5200)
 ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM CPU;


INSERT INTO GPU (Manufacturer,Price,Generation,GPU_Ram_Capacity,case_size,Max_watt,Class,Fabless,product_number) VALUES
('msi',679000,'30','8g','middle_tower',220,3,'nvidia','gp1'),
('이엠텍',465590,'30','12g','middle_tower',180,4,'nvidia','gp2'),
('msi',793000,'30','8g','middle_tower',240,3,'nvidia','gp3'),
('갤럭시',290000,'16','4g','middle_tower',75,2,'nvidia','gp4'),
('갤럭시',114000,'10','2g','middle_tower',30,2,'nvidia','gp5')

 ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM GPU;

INSERT INTO Mainboard (Amount_of_ram_port,Amount_of_m2,Amount_of_sata3,Amount_of_GPU_port,Price,case_size,Socket,Latest_storage_interface,Manufacturer,product_number,Ram_generation) VALUES
(4,2,4,3,174600,'middle_tower','intel1700','m2','asus','mb1','ddr4'),
(4,3,4,1,369000,'middle_tower','am5','m2','gigabyte','mb2','ddr5'),
(4,2,6,2,149000,'middle_tower','am4','m2','asrock','mb3','ddr4')
 ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM Mainboard;

-- ram 입력
INSERT INTO ram VALUES
 ('samsung', '27000','8gb','2','ddr4','rm1',3200),
('samsung','57500','16gb','3','ddr4','rm2',3200),
('micron','26500','8gb','2','ddr4','rm3',3200),
('samsung','38000','8gb','2','ddr4','rm4',3200)
ON DUPLICATE KEY UPDATE product_number=product_number;
SELECT * FROM ram;

-- Insert power
INSERT INTO Power VALUES
('zalman', 49500,'mini_tower',600,'pw1'),
('micronix', 58500,'mini_tower',600,'pw2'),
('zalman', 44500,'mini_tower',500,'pw3'),
('zalman', 58000,'mini_tower',700,'pw4')

ON DUPLICATE KEY UPDATE Product_number=Product_number;
SELECT * FROM Power;

-- Insert spec
INSERT INTO Spec(Part_type,specName,RnC,specCompatibility) VALUES
('mainboard','intel1700','c','intel1700'),-- 소켓
('mainboard','am5','c','am5'),
('mainboard','am4','c','am4'),
('mainboard','middle_tower','r','micro_tower!@#middle_tower'), -- case_size
('mainboard','ddr4','c','ddr4'), -- 램 세대
('mainboard','ddr5','c','ddr5'),
('mainboard','m2','c','m2'), -- 인터페이스
('pc_case','middle_tower','r','micro_tower!@#middle_tower'), -- case_size
('pc_case','mini_tower','r','micro_tower!@#mini_tower'),
('pc_case','1','r','1'), -- hdd 슬롯 수
('pc_case','2','r','1!@#2'),
('pc_case','3','r','1!@#3'),
('pc_case','1','r','1'), -- sata3 ssd 수
('pc_case','2','r','1!@#2'),
('pc_case','2','r','1!@#2'), -- cooler 수
('pc_case','4','r','1!@#4'),
('pc_case','6','r','1!@#6'),
('cpu','3200','c','3200'), -- 램 속도
('cpu','5200','c','5200'),
('cpu','4800','c','4800'),
('cpu','ddr4','c','ddr4'), -- 램 세대
('cpu','ddr5','c','ddr5'),
('power','500','r','1!@#500'), -- 파워 전력
('power','600','r','1!@#600'),
('power','700','r','1!@#700')
ON DUPLICATE KEY UPDATE RnC=RnC;
SELECT * FROM Spec;