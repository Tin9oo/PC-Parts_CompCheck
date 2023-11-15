
DROP PROCEDURE IF EXISTS separate_string;
DELIMITER $$
CREATE PROCEDURE separate_string(
	IN input_string VARCHAR(30),
    OUT front VARCHAR(15),
    OUT back VARCHAR(15))
BEGIN
	SET front = (SELECT SUBSTRING_INDEX (input_string, '!@#', 1));
	SET back = (SELECT SUBSTRING_INDEX (input_string, '!@#', -1));
END$$
DELIMITER  ;

DROP PROCEDURE IF EXISTS case_size_str_to_int;
DELIMITER $$
CREATE PROCEDURE case_size_str_to_int(INOUT case_size_int VARCHAR(30))
BEGIN
	SET case_size_int = (SELECT CASE case_size_int
		WHEN 'micro_tower' THEN 1
        WHEN 'mini_tower' THEN 2
        WHEN 'middle_tower' THEN 3
        WHEN 'big_tower' THEN 4
	END);
END$$
DELIMITER  ;

-- DROP PROCEDURE IF EXISTS comp_chk_proc;
-- DELIMITER $$
-- CREATE PROCEDURE comp_chk_proc(
-- 	
-- )
-- BEGIN
-- 	
-- END$$
-- DELIMITER ;

DROP PROCEDURE IF EXISTS comp_chk_proc;
DELIMITER $$
CREATE PROCEDURE comp_chk_proc(
	IN user_id VARCHAR(5)
)
BEGIN
	DECLARE comp_mb_1 INT DEFAULT 0;
   	DECLARE comp_mb_2 INT DEFAULT 0;
    DECLARE comp_mb_3 INT DEFAULT 0;
    DECLARE comp_mb_4 INT DEFAULT 0;
    DECLARE comp_mb_5 INT DEFAULT 0;
    DECLARE comp_mb_6 INT DEFAULT 0;
    DECLARE comp_mb_7 INT DEFAULT 0;
    DECLARE comp_mb_8 INT DEFAULT 0;
    
    DECLARE comp_ca_1 INT DEFAULT 0;
    DECLARE comp_ca_2 INT DEFAULT 0;
    DECLARE comp_ca_3 INT DEFAULT 0;
    DECLARE comp_ca_4 INT DEFAULT 0;
    DECLARE comp_ca_5 INT DEFAULT 0;
    DECLARE comp_ca_6 INT DEFAULT 0;
    
    DECLARE comp_cp_1 INT DEFAULT 0;
    DECLARE comp_cp_2 INT DEFAULT 0;
    
    DECLARE comp_po_1 INT DEFAULT 0;
    
    DECLARE comp_mb INT DEFAULT 0;
    DECLARE comp_ca INT DEFAULT 0;
    DECLARE comp_cp INT DEFAULT 0;
    DECLARE comp_po INT DEFAULT 0;
    
    DECLARE comp INT DEFAULT 0;
    
    DECLARE expect_spec VARCHAR(30) DEFAULT '';
    DECLARE genuine_spec VARCHAR(30) DEFAULT '';
    
    DECLARE mb_rmport_amount INT DEFAULT 0;
	DECLARE rm_amount INT DEFAULT 0;
    
    DECLARE mb_m2port_amount INT DEFAULT 0;
	DECLARE ss_amount INT DEFAULT 0;
    
    DECLARE mb_sata3port_amount INT DEFAULT 0;
	DECLARE st_amount INT DEFAULT 0;
    
	DECLARE mb_gp_amount INT DEFAULT 0;
	DECLARE gp_amount INT DEFAULT 0;
    
    DECLARE startpoint VARCHAR(15) DEFAULT '';
    DECLARE endpoint VARCHAR(15) DEFAULT '';
    
    DECLARE ca_hd_amount INT DEFAULT 0;
	DECLARE hd_amount INT DEFAULT 0;
    
    DECLARE ca_ss_amount INT DEFAULT 0;
-- 	DECLARE ss_amount INT DEFAULT 0;

	DECLARE ca_co_amount INT DEFAULT 0;
	DECLARE co_amount INT DEFAULT 0;
    
    DECLARE watt_max INT DEFAULT 0;
	DECLARE watt_cpu INT DEFAULT 0;
    DECLARE watt_gpu INT DEFAULT 0;
	DECLARE watt_cooler INT DEFAULT 0;
	DECLARE watt_sum INT DEFAULT 0;

    -- 사용자 꾸러미 안의 목록을 가져온다.
-- 	SELECT * FROM pocket
-- 		WHERE pocket.ID=user_id;

	-- --------------------------------------------------
	-- 메인보드 호환성 검사
	-- 1. cpu 소켓
	SET expect_spec = '';
	SET genuine_spec = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		INNER JOIN spec
			ON mainboard.Socket = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='mainboard');

	SET genuine_spec = (SELECT  Socket FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cpu
			ON part.product_number = cpu.product_number
		WHERE pocket.ID = user_id);

    SET comp_mb_1 = (SELECT
    CASE expect_spec
		WHEN genuine_spec THEN 2
        ELSE 1
	END
    );

-- 	SELECT comp_mb_1;

	-- 2. ram 개수
	-- 개수를 셀 때 램 전체에 대한 개수를 세어야한다.
	SET mb_rmport_amount = 0;
	SET rm_amount = 0;

	SET mb_rmport_amount = (SELECT mainboard.Amount_of_ram_port FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		WHERE pocket.ID = user_id);
        
	SET rm_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'ram' AND pocket.ID = user_id);

-- 	SELECT IF (mb_rmport_amount >= rm_amount, comp_mb_2 = 2, comp_mb_2 = 1);
    SET comp_mb_2 = (SELECT
    CASE
		WHEN mb_rmport_amount >= rm_amount THEN 2
        ELSE 1
	END
    );

-- 	SELECT comp_mb_2;


	-- 3. ssd 개수
	SET mb_m2port_amount = 0;
	SET ss_amount = 0;

	SET mb_m2port_amount = (SELECT mainboard.Amount_of_m2 FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		WHERE pocket.ID = user_id);
        
	SET ss_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'ssd' AND pocket.ID = user_id);

-- 	SELECT IF (mb_m2port_amount >= ss_amount, comp_mb_3 = 2, comp_mb_3 = 1);
    SET comp_mb_3 = (SELECT
    CASE
		WHEN mb_m2port_amount >= ss_amount THEN 2
        ELSE 1
	END
    );

-- 	SELECT comp_mb_3;

	-- 4. sata3를 쓰는 hdd와 ssd의 개수
	SET mb_sata3port_amount = 0;
	SET st_amount = 0;

	SET mb_sata3port_amount = (SELECT mainboard.Amount_of_sata3 FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		WHERE pocket.ID = user_id);
        
	SET st_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type IN ('ssd', 'hdd') AND pocket.ID = user_id);
    
--  	SELECT IF (mb_sata3port_amount >= st_amount, comp_mb_4 = 2, comp_mb_4 = 1);
    SET comp_mb_4 = (SELECT
    CASE 
		WHEN mb_sata3port_amount >= st_amount THEN 2
        ELSE 1
	END
    );
    
--  SELECT comp_mb_4;

	-- 5. gpu 개수
	SET mb_gp_amount = 0;
	SET gp_amount = 0;

	SET mb_gp_amount = (SELECT mainboard.Amount_of_GPU_port FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		WHERE pocket.ID = user_id);
        
	SET gp_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'gpu' AND pocket.ID = user_id);
    
-- 	SELECT IF (mb_gp_amount >= gp_amount, comp_mb_5 = 2, comp_mb_5 = 1);
    SET comp_mb_5 = (SELECT
    CASE
		WHEN mb_gp_amount >= gp_amount THEN 2
        ELSE 1
	END
    );

--     SELECT comp_mb_5;

	-- 6. case 사이즈 (micro=1, mini=2, middle=3, big=4)
	SET expect_spec = '';
	SET genuine_spec = '';

	SET startpoint = '';
	SET endpoint = '';

	SET expect_spec = (SELECT specName FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		INNER JOIN spec
			ON mainboard.case_size = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='mainboard');

	-- CALL separate_string(expect_spec, startpoint, endpoint);
	CALL case_size_str_to_int(expect_spec);
	-- CALL case_size_str_to_int(endpoint);

	SET genuine_spec = (SELECT Case_size FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		WHERE pocket.ID = user_id);
	CALL case_size_str_to_int(genuine_spec);

-- 	SELECT IF (startpoint <= genuine_spec AND genuine_spec <= endpoint, comp_mb_6 = 2, comp_mb_6 = 1);
    SET comp_mb_6 = (SELECT
    CASE
		WHEN expect_spec = genuine_spec THEN 2
  		WHEN expect_spec < genuine_spec THEN 3
        ELSE 1
	END
    );
--     select startpoint;
--     select genuine_spec;

--     SELECT comp_mb_6;

	-- 7. ram 세대
	SET expect_spec = '';
	SET genuine_spec = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		INNER JOIN spec
			ON mainboard.Ram_generation = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='mainboard');

	SET genuine_spec = (SELECT Generation FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN ram
			ON part.product_number = ram.product_number
		WHERE pocket.ID = user_id);

-- 	SELECT IF (expect_spec = genuine_spec, comp_mb_7 = 2, comp_mb_7 = 1);
    SET comp_mb_7 = (SELECT
    CASE expect_spec
		WHEN genuine_spec THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_mb_7;

	-- 8. ssd, hdd 인터페이스 세대
	SET expect_spec = '';
	SET genuine_spec = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		INNER JOIN spec
			ON mainboard.Latest_storage_interface = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='mainboard');

	SET genuine_spec = (SELECT Interface FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN ssd
			ON part.product_number = ssd.product_number
		WHERE pocket.ID = user_id);

-- 	SELECT IF (expect_spec = genuine_spec, comp_mb_8 = 2, comp_mb_8 = 1);
    SET comp_mb_8 = (SELECT
    CASE expect_spec
		WHEN genuine_spec THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_mb_8;


	-- --------------------------------------------------
	-- case 호환성 검사
	-- 1. cooler 사이즈
	SET expect_spec = '';
	SET genuine_spec = '';

	SET startpoint = '';
	SET endpoint = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		INNER JOIN spec
			ON pc_case.Case_size = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='pc_case');

	CALL separate_string(expect_spec, startpoint, endpoint);
	CALL case_size_str_to_int(startpoint);
	CALL case_size_str_to_int(endpoint);

	SET genuine_spec = (SELECT case_size FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cooler
			ON part.product_number = cooler.product_number
		WHERE pocket.ID = user_id);
	CALL case_size_str_to_int(genuine_spec);

-- 	SELECT IF (startpoint <= genuine_spec AND genuine_spec <= endpoint, comp_ca_1 = 2, comp_ca_1 = 1);
    SET comp_ca_1 = (SELECT
    CASE
		WHEN startpoint <= genuine_spec THEN 2
        ELSE 1
	END
    );

-- 	SELECT comp_ca_1;

	-- 2. power 사이즈
	SET expect_spec = '';
	SET genuine_spec = '';

	SET startpoint = '';
	SET endpoint = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		INNER JOIN spec
			ON pc_case.Case_size = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='pc_case');

	CALL separate_string(expect_spec, startpoint, endpoint);
	CALL case_size_str_to_int(startpoint);
	CALL case_size_str_to_int(endpoint);

	SET genuine_spec = (SELECT case_size FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN power
			ON part.product_number = power.product_number
		WHERE pocket.ID = user_id);
	CALL case_size_str_to_int(genuine_spec);

-- 	SELECT IF (startpoint <= genuine_spec AND genuine_spec <= endpoint, comp_ca_2 = 2, comp_ca_2 = 1);
    SET comp_ca_2 = (SELECT
    CASE
		WHEN startpoint <= genuine_spec THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_ca_2;

	-- 3. gpu 사이즈
	SET expect_spec = '';
	SET genuine_spec = '';

	SET startpoint = '';
	SET endpoint = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		INNER JOIN spec
			ON pc_case.Case_size = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='pc_case');

	CALL separate_string(expect_spec, startpoint, endpoint);
	CALL case_size_str_to_int(startpoint);
	CALL case_size_str_to_int(endpoint);

	SET genuine_spec = (SELECT case_size FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN gpu
			ON part.product_number = gpu.product_number
		WHERE pocket.ID = user_id);
	CALL case_size_str_to_int(genuine_spec);

-- 	SELECT IF (startpoint <= genuine_spec AND genuine_spec <= endpoint, comp_ca_3 = 2, comp_ca_3 = 1);
    SET comp_ca_3 = (SELECT
    CASE
		WHEN startpoint <= genuine_spec THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_ca_3;

	-- 4. hdd 개수
	SET ca_hd_amount = 0;
	SET hd_amount = 0;

	SET ca_hd_amount = (SELECT pc_case.Amount_of_HDD_slot FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		WHERE pocket.ID = user_id);
			
	SET hd_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'gpu' AND pocket.ID = user_id);
		
-- 	SELECT IF (ca_hd_amount >= hd_amount, comp_ca_4 = 2, comp_ca_4 = 1);
    SET comp_ca_4 = (SELECT
    CASE
		WHEN ca_hd_amount >= hd_amount THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_ca_4;

	-- 5. ssd 개수
	SET ca_ss_amount = 0;
	SET ss_amount = 0;

	SET ca_ss_amount = (SELECT pc_case.Amount_of_sata3_SSD FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		WHERE pocket.ID = user_id);
			
	SET ss_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'gpu' AND pocket.ID = user_id);
		
-- 	SELECT IF (ca_ss_amount >= ss_amount, comp_ca_5 = 2, comp_ca_5 = 1);
    SET comp_ca_5 = (SELECT
    CASE
		WHEN ca_ss_amount >= ss_amount THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_ca_5;

	-- 6. cooler 개수
	SET ca_co_amount = 0;
	SET co_amount = 0;

	SET ca_co_amount = (SELECT pc_case.Amount_of_extra_cooler FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		WHERE pocket.ID = user_id);
			
	SET co_amount = (SELECT SUM(Quantity) FROM pocket
		WHERE Type = 'gpu' AND pocket.ID = user_id);
		
-- 	SELECT IF (ca_co_amount >= co_amount, comp_ca_6 = 2, comp_ca_6 = 1);
    SET comp_ca_6 = (SELECT
    CASE
		WHEN ca_co_amount >= co_amount THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_ca_6;


	-- --------------------------------------------------
	-- cpu 호환성 검사
	-- 1. ram 동작속도
	SET expect_spec = '';
	SET genuine_spec = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cpu
			ON part.product_number = cpu.product_number
		INNER JOIN spec
			ON CAST(cpu.Ram_operating_speed AS CHAR(30)) = CAST(spec.specName AS CHAR(30))
		WHERE pocket.ID = user_id);

	SET genuine_spec = (SELECT Ram_operating_speed FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN ram
			ON part.product_number = ram.product_number
		WHERE pocket.ID = user_id);

-- 	SELECT IF (expect_spec = genuine_spec, comp_cp_1 = 2, comp_cp_1 = 1);
    SET comp_cp_1 = (SELECT
    CASE expect_spec
		WHEN genuine_spec THEN 2
        ELSE 1
	END
    );
    
--  	SELECT comp_cp_1;

	-- 2. ram 세대
	SET expect_spec = '';
	SET genuine_spec = '';

	SET expect_spec = (SELECT specCompatibility FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cpu
			ON part.product_number = cpu.product_number
		INNER JOIN spec
			ON cpu.Ram_generation = spec.specName
		WHERE pocket.ID = user_id AND spec.Part_type='cpu');

	SET genuine_spec = (SELECT Generation FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN ram
			ON part.product_number = ram.product_number
		WHERE pocket.ID = user_id);

-- 	SELECT IF (expect_spec = genuine_spec, comp_cp_2 = 2, comp_cp_2 = 1);
    SET comp_cp_2 = (SELECT
    CASE expect_spec
		WHEN genuine_spec THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_cp_2;


	-- --------------------------------------------------
	-- power 호환성 검사
	-- 1. cpu, gpu, cooler의 전력 합
	SET watt_max = 0;
	SET watt_cpu = 0;
	SET watt_gpu = 0;
	SET watt_cooler = 0;
	SET watt_sum = 0;

	SET watt_max = (SELECT power.Max_watt FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN power
			ON part.product_number = power.product_number
		WHERE pocket.ID = user_id);

	SET watt_cpu = (SELECT cpu.Max_watt FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cpu
			ON part.product_number = cpu.product_number
		WHERE pocket.ID = user_id);

	SET watt_gpu = (SELECT gpu.Max_watt FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN gpu
			ON part.product_number = gpu.product_number
		WHERE pocket.ID = user_id);

	SET watt_cooler = (SELECT cooler.Max_watt FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number
		INNER JOIN cooler
			ON part.product_number = cooler.product_number
		WHERE pocket.ID = user_id);

	DROP TABLE IF EXISTS cur_watt;
	CREATE TEMPORARY TABLE IF NOT EXISTS cur_watt (watt INT);
	INSERT INTO cur_watt VALUES
		(watt_cpu), (watt_gpu), (watt_cooler);
	SET watt_sum = (SELECT SUM(watt) FROM cur_watt);

	SET watt_sum = watt_sum + 100;
-- 	SELECT IF (watt_sum <= watt_max, comp_po_1 = 2, comp_po_1 = 1);
    SET comp_po_1 = (SELECT
    CASE
		WHEN watt_sum <= watt_max THEN 2
        ELSE 1
	END
    );

--  	SELECT comp_po_1;


	-- --------------------------------------------------
	-- 호환가능성 변수 종합해서 호환성 여부 출력
	DROP TABLE IF EXISTS comp_stat;
	CREATE TEMPORARY TABLE IF NOT EXISTS comp_stat (comp_code VARCHAR(10), stat INT, comp_error_mesg VARCHAR(50), not_good VARCHAR(50));
	INSERT INTO comp_stat VALUES
		('comp_mb_1', comp_mb_1, '메인보드가 허용하는 cpu 소켓에 해당하지 않습니다.',''), ('comp_mb_2', comp_mb_2, '메인보드가 허용하는 ram 포트 수에 해당하지 않습니다.',''), 
        ('comp_mb_3', comp_mb_3, '메인보드가 허용하는 ssd 포트 수에 해당하지 않습니다.',''), ('comp_mb_4', comp_mb_4, '메인보드가 허용하는 sata3를 사용하는 storage의 수에 해당하지 않습니다.',''), 
        ('comp_mb_5', comp_mb_5, '메인보드가 허용하는 gpu 포트 수에 해당하지 않습니다.',''), ('comp_mb_6', comp_mb_6, '메인보드가 허용하는 사이즈에 해당하지 않는 pc_case입니다.', '케이스에 비해 메인보드가 작습니다.'), 
        ('comp_mb_7', comp_mb_7, '메인보드가 허용하는 ram 세대에 해당하지 않습니다.',''), ('comp_mb_8', comp_mb_8, '메인보드가 허용하는 저장장치 인터페이스에 해당하지 않습니다.',''), 
        ('comp_ca_1', comp_ca_1, '케이스가 허용하는 쿨러 사이즈에 해당하지 않습니다.',''), ('comp_ca_2', comp_ca_2, '케이스가 허용하는 파워 사이즈에 해당하지 않습니다.',''), 
        ('comp_ca_3', comp_ca_3, '케이스가 허용하는 gpu 사이즈에 해당하지 않습니다.',''), ('comp_ca_4', comp_ca_4, '케이스가 허용하는 hdd 포트 수에 해당하지 않습니다.',''), 
        ('comp_ca_5', comp_ca_5, '케이스가 허용하는 ssd의 수에 해당하지 않습니다.',''), ('comp_ca_6', comp_ca_6, '케이스가 허용하는 쿨러의 수에 해당하지 않습니다.',''), 
        ('comp_cp_1', comp_cp_1, 'cpu가 허용하는 ram 동작속도에 해당하지 않습니다.',''), ('comp_cp_2', comp_cp_2, 'cpu가 허용하는 ram 세대에 해당하지 않습니다.',''), 
        ('comp_po_1', comp_po_1, '파워가 허용하는 총 Watt 수에 해당하지 않습니다.','');
	SELECT * FROM comp_stat;
    
-- 	SELECT IF (comp_mb_1 =2 AND comp_mb_2 =2 AND comp_mb_3 =2 AND comp_mb_4 =2 AND comp_mb_5 =2 AND comp_mb_6 =2 AND comp_mb_7 =2 AND comp_mb_8 =2, comp_mb = 1, comp_mb = 0);
	SET comp_mb = (SELECT
    CASE 
		WHEN comp_mb_1 =2 AND comp_mb_2 =2 AND comp_mb_3 =2 AND comp_mb_4 =2 AND comp_mb_5 =2 AND comp_mb_6 =2 AND comp_mb_7 =2 AND comp_mb_8 =2 THEN 1
        ELSE 0
	END
    );
        
	SELECT comp_mb;

-- 	SELECT IF (comp_ca_1 =2 AND comp_ca_2 =2 AND comp_ca_3 =2 AND comp_ca_4 =2 AND comp_ca_5 =2 AND comp_ca_6 =2, comp_ca = 1, comp_ca = 0);
	SET comp_ca = (SELECT
    CASE 
		WHEN comp_ca_1 =2 AND comp_ca_2 =2 AND comp_ca_3 =2 AND comp_ca_4 =2 AND comp_ca_5 =2 AND comp_ca_6 =2 THEN 1
        ELSE 0
	END
    );

	SELECT comp_ca;

-- 	SELECT IF (comp_cp_1 =2 AND comp_cp_2 =2, comp_cp = 1, comp_cp = 0);
	SET comp_cp = (SELECT
    CASE 
		WHEN comp_cp_1 =2 AND comp_cp_2 =2 THEN 1
        ELSE 0
	END
    );
	SELECT comp_cp;

-- 	SELECT IF (comp_po_1 = 2, comp_po = 1, comp_po = 0);
	SET comp_po = (SELECT
    CASE comp_po_1
		WHEN 2 THEN 1
        ELSE 0
	END
    );

	SELECT comp_po;

-- 	SELECT IF (comp_mb = 1 AND comp_ca = 1 AND comp_cp = 1 AND comp_po = 1, comp = 1, comp = 0);
    SET comp = (SELECT
    CASE
		WHEN comp_mb = 1 AND comp_ca = 1 AND comp_cp = 1 AND comp_po = 1 THEN 1
        ELSE 0
	END
    );

	SELECT comp; -- 호환성 결과

END$$
DELIMITER ;