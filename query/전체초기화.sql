USE mydb;

DROP TABLE IF EXISTS `mydb`.`account`, `mydb`.`cooler`, `mydb`.`cpu`, `mydb`.`gpu`, `mydb`.`hdd`, `mydb`.`mainboard`, `mydb`.`opinion`, `mydb`.`part`, `mydb`.`pc_case`, `mydb`.`pocket`, `mydb`.`power`, `mydb`.`ram`, `mydb`.`spec`, `mydb`.`ssd`;

DROP TABLE IF EXISTS collect_chosen_cpu;
DROP TABLE IF EXISTS collect_chosen_gpu;
DROP TABLE IF EXISTS collect_chosen_ram;
DROP TABLE IF EXISTS collect_chosen_ssd;
DROP TABLE IF EXISTS collect_chosen_mainboard;
DROP TABLE IF EXISTS collect_chosen_pc_case;
DROP TABLE IF EXISTS collect_chosen_power;
DROP TABLE IF EXISTS collect_chosen_cooler;
DROP TABLE IF EXISTS recommand1;
DROP TABLE IF EXISTS recommand2;
DROP TABLE IF EXISTS recommand3;
DROP TABLE IF EXISTS recommand4;
-- DROP TABLE IF EXISTS etc_parts;
DROP PROCEDURE IF EXISTS which_one;
-- DELETE FROM pocket WHERE ID=@user_pick;

DROP TABLE IF EXISTS cur_watt;
DROP PROCEDURE IF EXISTS separate_string;
DROP PROCEDURE IF EXISTS change_case_size;

DROP TABLE IF EXISTS choosen_cpu;
DROP TABLE IF EXISTS choosen_gpu;
DROP TABLE IF EXISTS choosen_power;
DROP TABLE IF EXISTS choosen_ram;
DROP TABLE IF EXISTS choosen_pc_case;
DROP TABLE IF EXISTS choosen_ssd;
DROP TABLE IF EXISTS choosen_hdd;
DROP TABLE IF EXISTS choosen_cooler;
DROP TABLE IF EXISTS choosen_mainboard;