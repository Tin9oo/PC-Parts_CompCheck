-- MySQL Workbench Forward Engineering

SET FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `ID` VARCHAR(10) NOT NULL,
  -- `E_mail` VARCHAR(30) NOT NULL,
  -- `Nickname` VARCHAR(7) NOT NULL,
  `Password` VARCHAR(30) NOT NULL,
--   `Authority` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT pw_chk CHECK (length(Password)>=1 AND length(Password)<=10),
CONSTRAINT id_chk CHECK (length(ID)>=1 AND length(ID)<=10)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pocket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pocket` (
  `Type` VARCHAR(10) NOT NULL,
  `Quantity` INT NOT NULL,
--   `Name_of_product` VARCHAR(45) NOT NULL UNIQUE,
  `ID` VARCHAR(10) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`, `ID`),
  INDEX `fk_Pocket_Account1_idx` (`ID` ASC) VISIBLE,
  CONSTRAINT quantity_chk CHECK (Quantity>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Part` (
  `part_type` VARCHAR(10) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  `Name_of_product` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_Part_Pocket1_idx` (`Name_of_product` ASC) VISIBLE,
  UNIQUE INDEX `Name_of_product_UNIQUE` (`Name_of_product` ASC) VISIBLE
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mainboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mainboard` (
--   `Name_of_product` VARCHAR(25) NOT NULL,
  `Amount_of_ram_port` INT NOT NULL,
  `Amount_of_m2` INT NOT NULL,
  `Amount_of_sata3` INT NOT NULL,
  `Amount_of_GPU_port` INT NOT NULL,
  `Price` INT NOT NULL,
  `case_size` VARCHAR(30) NOT NULL,
  `Socket` VARCHAR(30) NOT NULL,
  `Latest_storage_interface` VARCHAR(30) NOT NULL,
  `Manufacturer` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  `Ram_generation` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_Mainboard_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`Product_number` ASC) VISIBLE,
  CONSTRAINT main_price_chk CHECK (Price>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SSD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SSD` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `Interface` VARCHAR(30) NOT NULL,
  `Price` INT NOT NULL,
  `Capacity` VARCHAR(5) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_SSD_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT ssd_price_chk CHECK (Price>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RAM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RAM` (
--   `Name_of_product` VARCHAR(25) NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `Price` INT NOT NULL,
  `Capacity` VARCHAR(10) NOT NULL,
  `Class` INT NOT NULL,
  `Generation` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  `Ram_operating_speed` INT NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_RAM_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT ram_price_chk CHECK (Price>0),
CONSTRAINT ram_class_chk CHECK (Class>0),
CONSTRAINT ram_oper_speed_chk CHECK (Ram_operating_speed>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PC_case`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PC_case` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `Amount_of_extra_cooler` INT NOT NULL,
  `Amount_of_sata3_SSD` INT NOT NULL,
  `Amount_of_HDD_slot` INT NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `Price` INT NOT NULL,
  `Case_size` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_PC_case_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT case_price_chk CHECK (Price>0),
CONSTRAINT amount_cooler_chk CHECK (Amount_of_extra_cooler>0),
CONSTRAINT amount_ssd_chk CHECK (Amount_of_sata3_SSD>0),
CONSTRAINT amount_hdd_chk CHECK (Amount_of_HDD_slot>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GPU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GPU` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `Price` INT NOT NULL,
  `Generation` VARCHAR(10) NOT NULL,
  `GPU_Ram_Capacity` VARCHAR(10) NOT NULL,
  `case_size` VARCHAR(30) NOT NULL,
  `Max_watt` INT NOT NULL,
  `Class` INT NOT NULL,
  `Fabless` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_GPU_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT gpu_price_chk CHECK (Price>0),
CONSTRAINT gpu_watt_chk CHECK (Max_watt>0),
CONSTRAINT gpu_class_chk CHECK (Class>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Power`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Power` (
--   `Name_of_product` VARCHAR(25) NOT NULL,
  `Manufacturer` VARCHAR(45) NOT NULL,
  `Price` INT NOT NULL,
  `case_size` VARCHAR(30) NOT NULL,
  `Max_watt` INT NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_Power_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT power_price_chk CHECK (Price>0),
CONSTRAINT power_watt_chk CHECK (Max_watt>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cooler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cooler` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `case_size` VARCHAR(30) NOT NULL,
  `Max_watt` INT NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `Price` INT NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  -- `Product` VARCHAR(30) NOT NULL,
  `Purpose` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_Cooler_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT cooler_price_chk CHECK (Price>0),
CONSTRAINT cooler_watt_chk CHECK (Max_watt>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CPU`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CPU` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `generation` VARCHAR(10) NOT NULL,
  `Socket` VARCHAR(30) NOT NULL,
  `Built_in_graphics_status` TINYINT NOT NULL,
  `Core` INT NOT NULL,
  `Price` INT NOT NULL,
  `RAM_generation` VARCHAR(30) NOT NULL,
  `Class` INT NOT NULL,
  `Fabless` VARCHAR(30) NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  `Max_watt` INT NOT NULL,
  `Ram_operating_speed` INT NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_CPU_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`product_number` ASC) VISIBLE,
  CONSTRAINT cpu_price_chk CHECK (Price>0),
CONSTRAINT grapic_status_chk CHECK (Built_in_graphics_status>=0),
CONSTRAINT cpu_core_chk CHECK (Core>0),
CONSTRAINT cpu_class_chk CHECK (Class>0),
CONSTRAINT cpu_watt_chk CHECK (Max_watt>0),
CONSTRAINT cpu_ram_speed_chk CHECK (Ram_operating_speed>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Spec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Spec` (
  `Part_type` VARCHAR(10) NOT NULL,
  `specName` VARCHAR(30) NOT NULL,
  `RnC` CHAR(1) NOT NULL,
  `specCompatibility` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Part_type`, `specName`),
  INDEX `fk_Spec_Mainboard_idx` (`specName` ASC) VISIBLE
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HDD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HDD` (
--   `Name_of_product` VARCHAR(45) NOT NULL,
  `Capacity` VARCHAR(5) NOT NULL,
  `Price` INT NOT NULL,
  `Manufacturer` VARCHAR(20) NOT NULL,
  `RPM` INT NOT NULL,
  `product_number` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`product_number`),
  INDEX `fk_HDD_Part1_idx` (`product_number` ASC) VISIBLE,
  UNIQUE INDEX `Product_number_UNIQUE` (`Product_number` ASC) VISIBLE,
  CONSTRAINT hdd_price_chk CHECK (Price>0)
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Opinion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Opinion` (
  `product_number` VARCHAR(45) NOT NULL,
  `ID` VARCHAR(10) NOT NULL,
  `Star` INT NOT NULL,
  `Creation_time` DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (`product_number`, `ID`),
  INDEX `fk_Opinion_Account1_idx` (`ID` ASC) VISIBLE
--  , UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE
,CONSTRAINT opn_star_chk CHECK (Star>0)
  )
ENGINE = InnoDB;

SHOW FULL COLUMNS FROM opinion;

-- -------------------------------------------------------
-- Constraint Addition
-- -------------------------------------------------------
ALTER TABLE pocket
   ADD CONSTRAINT `fk_Pocket_Account1`
    FOREIGN KEY (`ID`)
    REFERENCES `mydb`.`account`(`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE pocket
   ADD CONSTRAINT `fk_Part_Pocket1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`Part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE mainboard
   ADD CONSTRAINT `fk_Mainboard_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE SSD
   ADD CONSTRAINT `fk_SSD_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE RAM
   ADD CONSTRAINT `fk_RAM_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE PC_case
   ADD CONSTRAINT `fk_PC_case_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE gpu
   ADD CONSTRAINT `fk_GPU_Part1`
    FOREIGN KEY (`Product_number`)
    REFERENCES `mydb`.`part` (`Product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Power
   ADD CONSTRAINT `fk_Power_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE cooler
   ADD CONSTRAINT `fk_Cooler_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE CPU
   ADD CONSTRAINT `fk_CPU_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Mainboard
   ADD CONSTRAINT `fk_Spec_Mainboard`
    FOREIGN KEY (`case_size`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Mainboard
   ADD CONSTRAINT `fk_Spec_Mainboard1`
    FOREIGN KEY (`Socket`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Mainboard
   ADD CONSTRAINT `fk_Spec_Mainboard2`
    FOREIGN KEY (`Latest_storage_interface`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE SSD
   ADD CONSTRAINT `fk_Spec_SSD1`
    FOREIGN KEY (`Interface`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE RAM
   ADD CONSTRAINT `fk_Spec_RAM1`
    FOREIGN KEY (`Generation`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE PC_case
   ADD CONSTRAINT `fk_Spec_PC_case1`
    FOREIGN KEY (`Case_size`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE GPU
   ADD CONSTRAINT `fk_Spec_GPU1`
    FOREIGN KEY (`case_size`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Power
   ADD CONSTRAINT `fk_Spec_Power1`
    FOREIGN KEY (`case_size`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Cooler
   ADD CONSTRAINT `fk_Spec_Cooler1`
    FOREIGN KEY (`case_size`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE CPU
   ADD CONSTRAINT `fk_Spec_CPU1`
    FOREIGN KEY (`Socket`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE CPU
   ADD CONSTRAINT `fk_Spec_CPU2`
    FOREIGN KEY (`RAM_generation`)
    REFERENCES `mydb`.`Spec` (`specName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
-- 
ALTER TABLE HDD
      ADD  CONSTRAINT `fk_HDD_Part1`
    FOREIGN KEY (`product_number`)
    REFERENCES `mydb`.`Part` (`product_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Account
   ADD CONSTRAINT `fk_Opinion_Account1`
    FOREIGN KEY (`ID`)
    REFERENCES `mydb`.`Opinion` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE Opinion
   ADD CONSTRAINT `fk_Part_Opinion1`
    FOREIGN KEY (`product_number`)
    REFERENCES mydb.part (product_number)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;