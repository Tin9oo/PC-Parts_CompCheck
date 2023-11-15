USE mydb;

DROP PROCEDURE IF EXISTS recommand_proc;
DELIMITER $$
CREATE PROCEDURE recommand_proc(
	IN cpu_class INT,
    IN gpu_class INT,
    IN ram_class INT,
    IN ssd_capacity VARCHAR(5)
    )
BEGIN
	DROP TABLE IF EXISTS collect_chosen_cpu;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_cpu (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_cpu
	SELECT part.Name_of_product, part.part_type, part.product_number, cpu.Price, opinion.star FROM part
		INNER JOIN cpu
			ON part.product_number = cpu.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number
		WHERE class = cpu_class;
-- SELECT * FROM collect_chosen_cpu ORDER BY star DESC, Price ASC;
 
 -- 사용 목적에 맞는 gpu 선택
DROP TABLE IF EXISTS collect_chosen_gpu;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_gpu (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_gpu
	SELECT part.Name_of_product, part.part_type, part.product_number, gpu.Price, opinion.star FROM part
		INNER JOIN gpu
			ON part.product_number = gpu.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number
		WHERE class = gpu_class;
-- SELECT * FROM collect_chosen_gpu ORDER BY star DESC, Price ASC;
   
-- 사용 목적에 맞는 ram 선택
DROP TABLE IF EXISTS collect_chosen_ram;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_ram (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT, Generation VARCHAR(30));
INSERT IGNORE collect_chosen_ram
	SELECT part.Name_of_product, part.part_type, part.product_number, ram.Price, opinion.star, ram.Generation FROM part
		INNER JOIN ram
			ON part.product_number = ram.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number
		WHERE class = ram_class;
-- SELECT * FROM collect_chosen_ram ORDER BY star DESC, Price ASC;

-- 사용 목적에 맞는 ssd 선택
DROP TABLE IF EXISTS collect_chosen_ssd;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_ssd (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_ssd
	SELECT part.Name_of_product, part.part_type, part.product_number, ssd.Price, opinion.star FROM part
		INNER JOIN ssd
			ON part.product_number = ssd.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number
		WHERE Capacity= ssd_capacity;
-- SELECT * FROM collect_chosen_ssd ORDER BY star DESC, Price ASC;

END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS recommand_follow_proc;
DELIMITER $$
CREATE PROCEDURE recommand_follow_proc(
	IN user_id VARCHAR(10)
)
BEGIN

DECLARE cpu_top VARCHAR(5) DEFAULT '';
DECLARE mainboard_comp_w_cpu VARCHAR(5) DEFAULT '';

DECLARE ram_gen_comp_w_mb VARCHAR(10) DEFAULT '';

SET cpu_top = (SELECT product_number FROM collect_chosen_cpu ORDER BY star DESC, Price ASC LIMIT 1 );
-- SELECT cpu_top;
-- SELECT Socket FROM cpu WHERE product_number = cpu_top;
SET mainboard_comp_w_cpu = (SELECT product_number FROM mainboard WHERE mainboard.Socket = (SELECT Socket FROM cpu WHERE product_number = cpu_top)); -- 호환되는 메인보드의 제품 번호
-- SELECT mainboard_comp_w_cpu;
-- mainboard 정보를 담고있는 임시테이블 생성
DROP TABLE IF EXISTS collect_chosen_mainboard;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_mainboard (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_mainboard
	SELECT part.Name_of_product, part.part_type, part.product_number, mainboard.Price, opinion.star FROM part
		INNER JOIN mainboard
			ON part.product_number = mainboard.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number;

-- pc_case 정보를 담고있는 임시테이블 생성
DROP TABLE IF EXISTS collect_chosen_pc_case;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_pc_case (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_pc_case
	SELECT part.Name_of_product, part.part_type, part.product_number, pc_case.Price, opinion.star FROM part
		INNER JOIN pc_case
			ON part.product_number = pc_case.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number;
-- SELECT * FROM collect_chosen_pc_case ORDER BY star DESC, Price ASC;

-- power 정보를 담고있는 임시테이블 생성
DROP TABLE IF EXISTS collect_chosen_power;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_power (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_power
	SELECT part.Name_of_product, part.part_type, part.product_number, power.Price, opinion.star FROM part
		INNER JOIN power
			ON part.product_number = power.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number;
-- SELECT * FROM collect_chosen_power ORDER BY star DESC, Price ASC;

-- cooler 정보를 담고있는 임시테이블 생성
DROP TABLE IF EXISTS collect_chosen_cooler;
CREATE TEMPORARY TABLE IF NOT EXISTS collect_chosen_cooler (Name_of_Product VARCHAR(45), part_type VARCHAR(30), product_number VARCHAR(30) PRIMARY KEY, Price INT, star INT);
INSERT IGNORE collect_chosen_cooler
	SELECT part.Name_of_product, part.part_type, part.product_number, cooler.Price, opinion.star FROM part
		INNER JOIN cooler
			ON part.product_number = cooler.product_number
		INNER JOIN opinion
			ON part.product_number = opinion.product_number;
-- SELECT * FROM collect_chosen_cooler ORDER BY star DESC, Price ASC;

SET ram_gen_comp_w_mb = (SELECT RAM_generation FROM mainboard WHERE product_number = mainboard_comp_w_cpu);

DELETE FROM collect_chosen_ram WHERE Generation != ram_gen_comp_w_mb;
ALTER TABLE collect_chosen_ram DROP COLUMN Generation;
-- SELECT * FROM collect_chosen_ram;

DELETE FROM pocket WHERE ID=user_id; -- 여기 나중에 실제로 시연할 때는 지워야함
INSERT INTO pocket SELECT part_type, 1, user_id, product_number FROM collect_chosen_cpu WHERE product_number = cpu_top ORDER BY star DESC, Price ASC;
INSERT INTO pocket SELECT part_type, 1, user_id, product_number FROM collect_chosen_mainboard WHERE product_number = mainboard_comp_w_cpu ORDER BY star DESC, Price ASC;
INSERT INTO pocket SELECT part_type, 1, user_id, product_number FROM collect_chosen_pc_case WHERE product_number = 'ca1' ORDER BY star DESC, Price ASC;
INSERT INTO pocket SELECT part_type, 1, user_id, product_number FROM collect_chosen_power WHERE product_number = 'pw1' ORDER BY star DESC, Price ASC;
INSERT INTO pocket SELECT part_type, 1, user_id, product_number FROM collect_chosen_cooler WHERE product_number = 'co1' ORDER BY star DESC, Price ASC;

END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS recommand_list_proc;
DELIMITER $$
CREATE PROCEDURE recommand_list_proc(
	IN user_id VARCHAR(10)
)
-- 선택한 번호에 해당하는 조합을 반환
BEGIN

	-- recommand 1
DROP TABLE IF EXISTS recommand_list;
CREATE TEMPORARY TABLE IF NOT EXISTS recommand_list (rcm_num INT, part_type VARCHAR(30), quantity INT, own_user VARCHAR(10), product_number VARCHAR(30));
ALTER TABLE recommand_list
	ADD CONSTRAINT pk_rcm_list_tbl
	PRIMARY KEY (rcm_num, product_number);
INSERT INTO recommand_list SELECT 1, part_type, 1, user_id, product_number FROM collect_chosen_cpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 1, part_type, 1, user_id, product_number FROM collect_chosen_gpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 1, part_type, 1, user_id, product_number FROM collect_chosen_ram ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 1, part_type, 1, user_id, product_number FROM collect_chosen_ssd ORDER BY star DESC, Price ASC LIMIT 1 ;
-- DROP TABLE recommand1;

-- recommand 2
INSERT INTO recommand_list SELECT 2, part_type, 1, user_id, product_number FROM collect_chosen_cpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 2, part_type, 1, user_id, product_number FROM collect_chosen_gpu ORDER BY star DESC, Price ASC LIMIT 1,1 ;
INSERT INTO recommand_list SELECT 2, part_type, 1, user_id, product_number FROM collect_chosen_ram ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 2, part_type, 1, user_id, product_number FROM collect_chosen_ssd ORDER BY star DESC, Price ASC LIMIT 1 ;
-- DROP TABLE recommand2;

-- recommand 3
INSERT INTO recommand_list SELECT 3, part_type, 1, user_id, product_number FROM collect_chosen_cpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 3, part_type, 1, user_id, product_number FROM collect_chosen_gpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 3, part_type, 1, user_id, product_number FROM collect_chosen_ram ORDER BY star DESC, Price ASC LIMIT 1,1 ;
INSERT INTO recommand_list SELECT 3, part_type, 1, user_id, product_number FROM collect_chosen_ssd ORDER BY star DESC, Price ASC LIMIT 1 ;
-- DROP TABLE recommand3;

-- recommand 4
INSERT INTO recommand_list SELECT 4, part_type, 1, user_id, product_number FROM collect_chosen_cpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 4, part_type, 1, user_id, product_number FROM collect_chosen_gpu ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 4, part_type, 1, user_id, product_number FROM collect_chosen_ram ORDER BY star DESC, Price ASC LIMIT 1 ;
INSERT INTO recommand_list SELECT 4, part_type, 1, user_id, product_number FROM collect_chosen_ssd ORDER BY star DESC, Price ASC LIMIT 1,1 ;
-- DROP TABLE recommand4;

SELECT * FROM recommand_list;

END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS recommand_all_proc;
DELIMITER $$
CREATE PROCEDURE recommand_all_proc(
	IN cpu_class INT,
    IN gpu_class INT,
    IN ram_class INT,
    IN ssd_capacity VARCHAR(5),
    IN user_id VARCHAR(10)
)
-- 선택한 번호에 해당하는 조합을 반환
BEGIN
	CALL recommand_proc(cpu_class,gpu_class,ram_class,ssd_capacity);
    CALL recommand_follow_proc(user_id);
    CALL recommand_list_proc(user_id);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS rcm_insert;
DELIMITER $$
CREATE PROCEDURE rcm_insert(
	IN rcm_cpu VARCHAR(5),
    IN rcm_gpu VARCHAR(5),
    IN rcm_ram VARCHAR(5),
    IN rcm_ssd VARCHAR(5),
    IN user_id VARCHAR(10)
)
-- 선택한 번호에 해당하는 조합을 반환
BEGIN
	INSERT IGNORE pocket SELECT part_type, 1, user_id, product_number FROM part WHERE product_number = rcm_gpu;
	INSERT IGNORE pocket SELECT part_type, 1, user_id, product_number FROM part WHERE product_number = rcm_ram;
	INSERT IGNORE pocket SELECT part_type, 1, user_id, product_number FROM part WHERE product_number = rcm_ssd;
    
    SELECT * FROM pocket
		INNER JOIN part
			ON pocket.product_number = part.product_number;
            
END$$
DELIMITER ;