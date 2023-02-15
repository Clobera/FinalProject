-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bilingualbuddiesdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bilingualbuddiesdb` ;

-- -----------------------------------------------------
-- Schema bilingualbuddiesdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bilingualbuddiesdb` DEFAULT CHARACTER SET utf8 ;
USE `bilingualbuddiesdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(50) NULL,
  `state` VARCHAR(50) NULL,
  `postal_code` VARCHAR(10) NULL,
  `city` VARCHAR(100) NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE TABLE IF NOT EXISTS `country` (
  `country_code` CHAR(2) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`country_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(200) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` TEXT NOT NULL,
  `date_created` DATETIME NULL,
  `last_login` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `role` VARCHAR(45) NULL DEFAULT 'base',
  `sponsor` TINYINT NULL DEFAULT 0,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `image_url` TEXT NULL,
  `bio` TEXT NULL,
  `address_id` INT NULL,
  `origin_country` CHAR(2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
  INDEX `fk_user_country1_idx` (`origin_country` ASC),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_country1`
    FOREIGN KEY (`origin_country`)
    REFERENCES `country` (`country_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `post` ;

CREATE TABLE IF NOT EXISTS `post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `image_url` TEXT NULL,
  `post_date` DATETIME NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_id` INT NOT NULL,
  `content` TEXT NULL,
  `image_url` TEXT NULL,
  `name` VARCHAR(100) NULL,
  `create_date` DATETIME NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_group_user1_idx` (`owner_id` ASC),
  CONSTRAINT `fk_group_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meetup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup` ;

CREATE TABLE IF NOT EXISTS `meetup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `meetup_date` DATE NOT NULL,
  `content` TEXT NULL,
  `address_id` INT NOT NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  `owner_id` INT NOT NULL,
  `team_id` INT NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  `created_date` DATETIME NULL,
  `image_url` TEXT NULL,
  `title` VARCHAR(150) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_address1_idx` (`address_id` ASC),
  INDEX `fk_event_user1_idx` (`owner_id` ASC),
  INDEX `fk_event_group1_idx` (`team_id` ASC),
  CONSTRAINT `fk_event_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_group1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alert` ;

CREATE TABLE IF NOT EXISTS `alert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `content` VARCHAR(200) NULL,
  `receiver_id` INT NOT NULL,
  `meetup_id` INT NULL,
  `notification_date` DATETIME NOT NULL,
  `seen` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_notification_user1_idx` (`receiver_id` ASC),
  INDEX `fk_notification_meetup1_idx` (`meetup_id` ASC),
  CONSTRAINT `fk_notification_user`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_user1`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_meetup1`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `comment_date` DATETIME NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team_has_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team_has_member` ;

CREATE TABLE IF NOT EXISTS `team_has_member` (
  `group_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`group_id`, `user_id`),
  INDEX `fk_group_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_group_has_user_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_group_has_user_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` VARCHAR(45) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_meetup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_meetup` ;

CREATE TABLE IF NOT EXISTS `user_has_meetup` (
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `event_id`),
  INDEX `fk_user_has_event_event1_idx` (`event_id` ASC),
  INDEX `fk_user_has_event_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_event_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_event_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language_has_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language_has_user` ;

CREATE TABLE IF NOT EXISTS `language_has_user` (
  `language_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`language_id`, `user_id`),
  INDEX `fk_language_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_language_has_user_language1_idx` (`language_id` ASC),
  CONSTRAINT `fk_language_has_user_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country_has_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country_has_language` ;

CREATE TABLE IF NOT EXISTS `country_has_language` (
  `country_country_code` CHAR(2) NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`country_country_code`, `language_id`),
  INDEX `fk_country_has_language_language1_idx` (`language_id` ASC),
  INDEX `fk_country_has_language_country1_idx` (`country_country_code` ASC),
  CONSTRAINT `fk_country_has_language_country1`
    FOREIGN KEY (`country_country_code`)
    REFERENCES `country` (`country_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_country_has_language_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language_resource` ;

CREATE TABLE IF NOT EXISTS `language_resource` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `resource_url` TEXT NULL,
  `description` TEXT NULL,
  `language_id` INT NOT NULL,
  `added_by` INT NOT NULL,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_language_resource_language1_idx` (`language_id` ASC),
  INDEX `fk_language_resource_user1_idx` (`added_by` ASC),
  CONSTRAINT `fk_language_resource_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_language_resource_user1`
    FOREIGN KEY (`added_by`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS admin@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'admin'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (1, '810 Garrison St.', 'Colorado', '80215', 'Lakewood', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (2, '715 Street St.', 'Colorado', '80312', 'Lakewood', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (3, '515 Big St.', 'Colorado', '80721', 'Lakewood', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (4, '435 Fat St.', 'Colorado', '81234', 'Lakewood', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (6, '126 Main st', 'OR', '97301', 'Salem', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (7, '127 Main st', 'NY', '12207', 'Albany', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (8, '128 Main st', 'FL', '32301', 'Tallahassee', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (9, '129 Main st', 'VA', '23219', 'Richmond', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (10, '130 Main st', 'NV', '89701', 'Carson City', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (11, '131 Main st', 'CA', '94203', 'Sacramento', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (12, '132 Main st', 'AK', '99801', 'Juneau', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (13, '133 Main st', 'TX', '78701', 'Austin', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (14, '134 Main st', 'VA', '23219', 'Richmond', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (15, '135 Main st', 'MN', '55102', 'Saint Paul', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (16, '136 Main st', 'OH', '43215', 'Columbus', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (17, '137 Main st', 'TX', '78701', 'Austin', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (18, '138 Main st', 'AZ', '85001', 'Phoenix', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (19, '139 Main st', 'WA', '98507', 'Olympia', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (20, '140 Main st', 'MN', '55102', 'Saint Paul', 1);
INSERT INTO `address` (`id`, `address`, `state`, `postal_code`, `city`, `enabled`) VALUES (5, '141 Main st', 'MI', '48933', 'Lansing', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `country`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `country` (`country_code`, `country`) VALUES ('US', 'United States');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AF', 'Afghanistan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AX', 'Aland Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AL', 'Albania');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DZ', 'Algeria');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AS', 'American Samoa');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AD', 'Andorra');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AO', 'Angola');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AI', 'Anguilla');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AQ', 'Antarctica');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AG', 'Antigua and Barbuda');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AR', 'Argentina');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AM', 'Armenia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AW', 'Aruba');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AU', 'Australia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AT', 'Austria');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AZ', 'Azerbaijan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BS', 'Bahamas');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BH', 'Bahrain');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BD', 'Bangladesh');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BB', 'Barbados');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BY', 'Belarus');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BE', 'Belgium');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BZ', 'Belize');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BJ', 'Benin');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BM', 'Bermuda');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BT', 'Bhutan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BO', 'Bolivia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BA', 'Bosnia and Herzegovina');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BW', 'Botswana');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BV', 'Bouvet Island');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BR', 'Brazil');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VG', 'British Virgin Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IO', 'British Indian Ocean Territory');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BN', 'Brunei Darussalam');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BG', 'Bulgaria');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BF', 'Burkina Faso');
INSERT INTO `country` (`country_code`, `country`) VALUES ('BI', 'Burundi');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KH', 'Cambodia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CM', 'Cameroon');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CA', 'Canada');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CV', 'Cape Verde');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KY', 'Cayman Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CF', 'Central African Republic');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TD', 'Chad');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CL', 'Chile');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CN', 'China');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HK', 'Hong Kong');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MO', 'Macao');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CX', 'Christmas Island');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CC', 'Cocos Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CO', 'Colombia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KM', 'Comoros');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CG', 'Congo (Brazzaville)');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CD', 'Congo(Kinshasa)');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CK', 'Cook Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CR', 'Costa Rica');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CI', 'Côte d\'Ivoire');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HR', 'Croatia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CU', 'Cuba');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CY', 'Cyprus');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CZ', 'Czech Republic');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DK', 'Denmark');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DJ', 'Djibouti');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DM', 'Dominica');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DO', 'Dominican Republic');
INSERT INTO `country` (`country_code`, `country`) VALUES ('EC', 'Ecuador');
INSERT INTO `country` (`country_code`, `country`) VALUES ('EG', 'Egypt');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SV', 'El Salvador');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GQ', 'Equatorial Guinea');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ER', 'Eritrea');
INSERT INTO `country` (`country_code`, `country`) VALUES ('EE', 'Estonia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ET', 'Ethiopia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FK', 'Falkland Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FO', 'Faroe Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FJ', 'Fiji');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FI', 'Finland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FR', 'France');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GF', 'French Guiana');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PF', 'French Polynesia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TF', 'French Southern Territories');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GA', 'Gabon');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GM', 'Gambia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GE', 'Georgia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('DE', 'Germany');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GH', 'Ghana');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GI', 'Gibraltar');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GR', 'Greece');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GL', 'Greenland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GD', 'Grenada');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GP', 'Guadeloupe');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GU', 'Guam');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GT', 'Guatemala');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GG', 'Guernsey');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GN', 'Guinea');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GW', 'Guinea-Bissau');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GY', 'Guyana');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HT', 'Haiti');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HM', 'Heard and Mcdonald Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VA', 'Holy See (Vatican City State)');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HN', 'Honduras');
INSERT INTO `country` (`country_code`, `country`) VALUES ('HU', 'Hungary');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IS', 'Iceland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IN', 'India');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ID', 'Indonesia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IR', 'Iran');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IQ', 'Iraq');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IE', 'Ireland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IL', 'Israel');
INSERT INTO `country` (`country_code`, `country`) VALUES ('IT', 'Italy');
INSERT INTO `country` (`country_code`, `country`) VALUES ('JM', 'Jamaica');
INSERT INTO `country` (`country_code`, `country`) VALUES ('JP', 'Japan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('JE', 'Jersey');
INSERT INTO `country` (`country_code`, `country`) VALUES ('JO', 'Jordan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KZ', 'Kazakhstan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KE', 'Kenya');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KI', 'Kiribati');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KP', 'Korea (North)');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KR', 'Korea (South)');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KW', 'Kuwait');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KG', 'Kyrgyzstan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LA', 'Lao PDR');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LV', 'Latvia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LB', 'Lebanon');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LS', 'Lesotho');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LR', 'Liberia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LY', 'Libya');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LI', 'Liechtenstein');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LT', 'Lithuania');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LU', 'Luxembourg');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MK', 'Macedonia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MG', 'Madagascar');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MW', 'Malawi');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MY', 'Malaysia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MV', 'Maldives');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ML', 'Mali');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MT', 'Malta');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MH', 'Marshall Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MQ', 'Martinique');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MR', 'Mauritania');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MU', 'Mauritius');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MX', 'Mexico');
INSERT INTO `country` (`country_code`, `country`) VALUES ('FM', 'Micronesia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MD', 'Moldova');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MC', 'Monaco');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MN', 'Mongolia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ME', 'Montenegro');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MS', 'Montserrat');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MA', 'Morocco');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MZ', 'Mozambique');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MM', 'Myanmar');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NA', 'Namibia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NR', 'Nauru');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NP', 'Nepal');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NL', 'Netherlands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AN', 'Netherlands Antilles');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NC', 'New Caledonia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NZ', 'New Zealand');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NI', 'Nicaragua');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NE', 'Niger');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NG', 'Nigeria');
INSERT INTO `country` (`country_code`, `country`) VALUES ('MP', 'Northern Mariana Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('NO', 'Norway');
INSERT INTO `country` (`country_code`, `country`) VALUES ('OM', 'Oman');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PK', 'Pakistan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PW', 'Palau');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PS', 'Palestinian Territory');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PA', 'Panama');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PG', 'Papua New Guinea');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PY', 'Paraguay');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PE', 'Peru');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PH', 'Philippines');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PN', 'Pitcairn');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PL', 'Poland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PT', 'Portugal');
INSERT INTO `country` (`country_code`, `country`) VALUES ('PR', 'Puerto Rico');
INSERT INTO `country` (`country_code`, `country`) VALUES ('QA', 'Qatar');
INSERT INTO `country` (`country_code`, `country`) VALUES ('RE', 'Réunion');
INSERT INTO `country` (`country_code`, `country`) VALUES ('RO', 'Romania');
INSERT INTO `country` (`country_code`, `country`) VALUES ('RU', 'Russia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('RW', 'Rwanda');
INSERT INTO `country` (`country_code`, `country`) VALUES ('KN', 'Saint Kitts and Nevis');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LC', 'Saint Lucia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VC', 'Saint Vincent and Grenadines');
INSERT INTO `country` (`country_code`, `country`) VALUES ('WS', 'Samoa');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SM', 'San Marino');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ST', 'Sao Tome and Principe');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SA', 'Saudi Arabia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SN', 'Senegal');
INSERT INTO `country` (`country_code`, `country`) VALUES ('RS', 'Serbia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SC', 'Syechelles');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SL', 'Sierra Leone');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SG', 'Singapore');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SK', 'Slovakia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SI', 'Slovenia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SB', 'Solomon Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SO', 'Somalia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ZA', 'South Africa');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ES', 'Spain');
INSERT INTO `country` (`country_code`, `country`) VALUES ('LK', 'Sri Lanka');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SD', 'Sudan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SR', 'Suriname');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SZ', 'Swaziland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SE', 'Sweden');
INSERT INTO `country` (`country_code`, `country`) VALUES ('CH', 'Switzerland');
INSERT INTO `country` (`country_code`, `country`) VALUES ('SY', 'Syria');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TW', 'Taiwan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TJ', 'Tajikistan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TZ', 'Tanzania');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TH', 'Thailand');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TL', 'Timor-Leste');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TG', 'Togo');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TO', 'Tonga');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TT', 'Trinidad and Tobago');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TN', 'Tunisia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TR', 'Turkey');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TM', 'Turkmenistan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('TV', 'Tuvalu');
INSERT INTO `country` (`country_code`, `country`) VALUES ('UG', 'Uganda');
INSERT INTO `country` (`country_code`, `country`) VALUES ('UA', 'Ukraine');
INSERT INTO `country` (`country_code`, `country`) VALUES ('AE', 'United Arab Emirates');
INSERT INTO `country` (`country_code`, `country`) VALUES ('GB', 'United Kingdom');
INSERT INTO `country` (`country_code`, `country`) VALUES ('UM', 'US Minor Outlying Islands');
INSERT INTO `country` (`country_code`, `country`) VALUES ('UY', 'Uruguay');
INSERT INTO `country` (`country_code`, `country`) VALUES ('UZ', 'Uzbekistan');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VU', 'Vanuatu');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VE', 'Venezuela');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VN', 'Viet Nam');
INSERT INTO `country` (`country_code`, `country`) VALUES ('VI', 'Virgin Islands, US');
INSERT INTO `country` (`country_code`, `country`) VALUES ('YE', 'Yemen');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ZM', 'Zambia');
INSERT INTO `country` (`country_code`, `country`) VALUES ('ZW', 'Zimbabwe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (1, 'admin@admin.com', 'admin', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-01', '2023-01-01', 1, 'admin', 0, 'admin', 'admin', 'https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg', 'If You Smell What the Rock is Cooking!', 1, 'US');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (2, 'joe@shmoe.com', 'joeshmoe', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-02', '2023-01-02', 1, 'admin', 0, 'John', 'Jackson', 'https://www.rd.com/wp-content/uploads/2019/09/Cute-cat-lying-on-his-back-on-the-carpet.-Breed-British-mackerel-with-yellow-eyes-and-a-bushy-mustache.-Close-up-e1573490045672.jpg', '', 3, 'DZ');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (3, 'Jerryberry@gerbal.com', 'jerbil34', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-03', '2023-01-03', 1, 'admin', 0, 'Jerry', 'Gerbal', 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_2x3.jpg', '', 4, 'AR');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (4, 'samcassidy22@gmail.com', 'samcassidy4', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-04', '2023-01-04', 1, 'admin', 0, 'Sam', 'Cassidy', 'https://hips.hearstapps.com/hmg-prod/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg?crop=0.670xw:1.00xh;0.147xw,0&resize=1200:*', '', 5, 'IT');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (5, 'lolo297@gmail.com', 'lolo297', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-05', '2023-01-05', 1, 'admin', 0, 'Carlos', 'Lobera', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 6, 'BB');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (6, 'lowelb@gmail.com', 'beastbay97', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-06', '2023-01-06', 1, 'admin', 0, 'Lowell', 'Belany', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 7, 'BR');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (7, 'amcmike3@gmail.com', 'amcmike3', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-07', '2023-01-07', 1, 'admin', 0, 'Alex', 'McMichael', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 8, 'CN');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (8, 'lucabu@aol.com', 'lucuabu34', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-08', '2023-01-08', 1, 'admin', 0, 'Harry', 'Barry', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 9, 'CO');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (9, 'barryharry@email.com', 'harbare21', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-09', '2023-01-09', 1, 'admin', 0, 'Barry', 'Harry', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 10, 'CR');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (10, 'harryBarry@email.com', 'Barehare12', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-10', '2023-01-10', 1, 'admin', 0, 'Al E.', 'Gator', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 1, 'DK');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (11, 'aliegator@gmail.com', 'crunch56', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-11', '2023-01-11', 1, 'admin', 0, 'Helen', 'Hywater', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 3, 'DJ');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (12, 'anitaroom@gmail.com', 'needaroom87', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-12', '2023-01-12', 1, 'admin', 0, 'Anita', 'Room', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 4, 'EG');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (13, 'hatchet@ratchet.com', 'hatchetratchet57', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-13', '2023-01-13', 1, 'admin', 0, 'Barry D. ', 'Hatchet', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 5, 'GR');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (14, 'ben@dover.com', 'bendover12', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-14', '2023-01-14', 1, 'admin', 0, 'Ben', 'Dover', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 6, 'GN');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (15, 'jack@pot.com', 'luckymuney45', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-15', '2023-01-15', 1, 'admin', 0, 'Crystal ', 'Ball', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 7, 'HT');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (16, 'crystal@ball.com', 'forseeablefuture99', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-16', '2023-01-16', 1, 'admin', 0, 'Jack', 'Pot', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 2, 'ZW');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (17, 'mite@dina.com', 'bigboomboom78', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-17', '2023-01-17', 1, 'admin', 0, 'Dinah', 'Mite', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 3, 'ZM');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (18, 'chester@minit.com', 'chestermint56', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-18', '2023-01-18', 1, 'admin', 0, 'Chester', 'Minit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 4, 'UY');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (19, 'don@keigh.com', 'eeehaw45', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-19', '2023-01-19', 1, 'admin', 0, 'Don', 'Keigh', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', '', 5, 'UG');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (20, 'don@cheadle.com', 'donCheadle34', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-01', '2023-01-01', 1, 'admin', 0, 'Don', 'Cheadle', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSARxgqb4YX-s02OxYQjqdRKRhH41hOfqh0Cw&usqp=CAU', NULL, 5, 'GR');

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (1, 1, 'This is so cool!', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT92-R1QhOfOpRc9FmRhePfW3eBBwLWSO4GVC72iqGDoA&s', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (2, 4, 'Anyone know where I can find a cheap ham?', 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Ham_%284%29.jpg', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (3, 5, 'I found this great restaurant near me', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS59xulEC0P_e5zfB8vgCzik5sW4nbMBTx0zw&usqp=CAU', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (4, 6, 'Does anybody know where a good vietnamese grocery store is?', 'https://s3-media0.fl.yelpcdn.com/bphoto/loHFGc62bH6grR8GD4s4Eg/348s.jpg', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (5, 7, 'My son is having a birthday party this weekend and I\'d like to invite all of you!', 'https://berkscountyliving.com/downloads/18196/download/iStock-918933880.jpg?cb=1155e4a7652ab617e102986ad35ab972', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (6, 9, 'Come eat pan de muerto and watch the desfile :D', 'https://images.ctfassets.net/ore4bgrjwvxy/3VJlsqU8JTy1jQNKSM3UDj/3013206b0448b6a74e28cb81987d031d/Holidays-Candelaria.jpg', '2023-01-14', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (7, 10, 'Practice your english/spanish tonight at the martini corner club', 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/meet---greet-flyer-template-6c12013c44e0a954fda3638e39aec7c9_screen.jpg?ts=1636975007', '2023-01-16', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (8, 3, 'Ultimate Frisbee today at noon', 'https://cdn.dribbble.com/users/15617/screenshots/3838596/thumb-58-frisbee-drb.jpg', '2023-01-18', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (9, 4, 'vinyl dj master class at loose blues', 'https://i.scdn.co/image/ab67616d0000b273342a1e969ebbe5e51b2fe508', '2023-01-20', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (10, 7, 'pick up soccer at the park', 'https://soccerhandbook.com/files/2020/06/pickup-soccer-outdoor.jpg', '2023-01-22', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (11, 9, 'come dance salsa at the park', 'http://mmsalsainthepark.weebly.com/uploads/4/5/6/5/45650065/7537728_orig.jpg', '2023-01-24', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (12, 5, 'Latinos in Tech web seminar, come watch and get inspired to find a tech job as a ESL', 'https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg', '2023-01-26', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (13, 2, 'Job fair at the omni hotel', 'https://resources.workable.com/wp-content/uploads/2017/12/job-fair-feaured.png', '2023-01-28', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (14, 7, 'Come play board games with a group of people and practice your english in a comfortable setting', 'https://images.squarespace-cdn.com/content/v1/56df568062cd94a042ccbfa7/1490867784715-50GQ99X5CYMFAWPAC349/D75A3386.jpg?format=750w', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (15, 3, 'Come watch birds with us!', 'https://upload.wikimedia.org/wikipedia/commons/c/c0/A_group_of_men_stand_birdwatching.jpg', '2023-01-12', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (16, 5, 'Come to my book club!', 'https://media.istockphoto.com/id/1055903384/vector/espanol.jpg?s=612x612&w=0&k=20&c=C-ECjXQxLQmFj7rczqvqpWlmaPOljpFAVPfJ3Nvxxp8=', '2023-01-14', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (17, 8, 'Come to my mexican indepenedance day party!', 'https://s3.envato.com/files/125138866/02%20cinco2.jpg', '2023-01-16', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (18, 9, 'Dia De los muertos parade happening tonight at 8pm', 'https://res.cloudinary.com/sagacity/image/upload/c_crop,h_1825,w_2737,x_0,y_0/c_limit,dpr_2.625,f_auto,fl_lossy,q_80,w_412/DDLM_FLAT_enxu0c.jpg', '2023-01-18', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (19, 10, 'Come eat pan de muerto and watch the desfile :D', 'https://images.ctfassets.net/ore4bgrjwvxy/3VJlsqU8JTy1jQNKSM3UDj/3013206b0448b6a74e28cb81987d031d/Holidays-Candelaria.jpg', '2023-01-20', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (20, 3, 'Practice your english/spanish tonight at the martini corner club', 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/meet---greet-flyer-template-6c12013c44e0a954fda3638e39aec7c9_screen.jpg?ts=1636975007', '2023-01-22', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (21, 4, 'Ultimate Frisbee today at noon', 'https://cdn.dribbble.com/users/15617/screenshots/3838596/thumb-58-frisbee-drb.jpg', '2023-01-24', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (22, 7, 'vinyl dj master class at loose blues', 'https://i.scdn.co/image/ab67616d0000b273342a1e969ebbe5e51b2fe508', '2023-01-26', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (23, 9, 'pick up soccer at the park', 'https://soccerhandbook.com/files/2020/06/pickup-soccer-outdoor.jpg', '2023-01-28', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (24, 5, 'come dance salsa at the park', 'http://mmsalsainthepark.weebly.com/uploads/4/5/6/5/45650065/7537728_orig.jpg', '2023-01-01', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (25, 2, 'Latinos in Tech web seminar, come watch and get inspired to find a tech job as a ESL', 'https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg', '2023-01-12', 1);
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (26, 7, 'Job fair at the omni hotel', 'https://resources.workable.com/wp-content/uploads/2017/12/job-fair-feaured.png', '2023-01-14', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (1, 1, 'We are a group who just wants to make the world a better place', 'https://d3mvlb3hz2g78.cloudfront.net/wp-content/uploads/2020/11/thumb_720_450_dreamstime_m_44810592_(1).jpg', 'Better People Better World', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (2, 4, 'We are dedicated to cleaning up trash around town.', 'https://ibanplastic.com/wp-content/uploads/2018/05/Clean-The-World.jpg', 'Green Clean people machine', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (3, 5, 'If you need a friend, we\'re here for you', 'https://www.healthyplace.com/sites/default/files/2020-11/making-friends-with-someone.jpg', 'Friend Finder', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (4, 6, 'Healthy people healthy office', 'https://energyresourcing.com/wp-content/uploads/2022/07/man-making-a-plan-for-the-year-ahead.jpg', 'Work Life Balance', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (5, 7, 'We are a videogame club', 'https://www.materacademybay.com/ourpages/auto/2019/9/5/38352958/gaming%20club-photo.jpg', 'Videogame Club', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (6, 1, 'not the one you eat with soup', 'https://www.facebook.com/photo/?fbid=461481396029711&set=a.461481366029714', 'Frenchies', '2023-01-16', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (7, 6, 'SOUP!!', 'https://www.happyfoodstube.com/wp-content/uploads/2016/04/spring-vegetable-soup-1.jpg', 'French Onion', '2023-01-18', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (8, 2, 'Cronch Cronch Cronch!', 'https://assets-eu-01.kc-usercontent.com/559bb7d3-88a4-01c1-79a3-dd4d5b2d2bb0/b952b71e-20ff-4434-9486-5aa0b4378145/1-French-Baguettes.jpg?w=1920&q=85&auto=format&lossless=1', 'French Baguette', '2023-01-20', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (9, 10, 'Carolina De Bilbao', 'https://ychef.files.bbci.co.uk/1600x900/p0bw7p4c.webp', 'Spain Spirals', '2023-01-22', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (10, 9, 'Party Time', 'https://cdn.britannica.com/33/4233-050-3A1705E7/Flag-Zimbabwe.jpg', 'Zimbabwe Zanzibar', '2023-01-24', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (11, 4, 'Better Party Time', 'https://st2.depositphotos.com/1074452/7714/i/450/depositphotos_77145159-stock-photo-afrikaans-word-indicates-study-language.jpg', 'Afrikaans Alakazams', '2023-01-26', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (12, 2, 'Your one location of potato Information', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2013/11/14/2/fnm_120113-potato-puffs-recipe_s4x3.jpg.rend.hgtvcom.826.620.suffix/1385047425933.jpeg', 'Potato Puff Pumpernickel', '2023-01-28', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (13, 10, 'Join here if you want to win a clown', 'https://up-magazine.info/wp-content/uploads/2018/03/paparazzi.jpg', 'Plaza Prizes Paparazi', '2023-01-01', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (14, 1, 'Our group knows the spot for the best pizza', 'https://www.foodandwine.com/thmb/4qg95tjf0mgdHqez5OLLYc0PNT4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg', 'Pizza Pie Primates', '2023-01-12', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (15, 8, 'We ripped off pringles', 'https://kellogg-h.assetsadobe.com/is/image/content/dam/kelloggs/kna/us/digital-shelf/pringles/00038000138652_D1CF_s01.jpg', 'Plump Prongles Plunger', '2023-01-14', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (16, 1, 'Don\'t ask', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Austin_Roberts-vo%C3%ABlreservaat%2C_dam_en_skuiling.jpg/800px-Austin_Roberts-vo%C3%ABlreservaat%2C_dam_en_skuiling.jpg?20120930091528', 'Skyline Chili Chuggers', '2023-01-16', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (17, 4, 'wombat1', 'https://ca.slack-edge.com/T052X7BAZ-U052X7BBK-24590cb12c7e-512', 'Rob\'s Favorite Passwords', '2023-01-18', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (18, 10, 'A group dedicated to the search of the Skill Distillery Dog', 'https://ca.slack-edge.com/T052X7BAZ-U718GEBK8-85e990aa8065-512', 'Skill Distillery Dog', '2023-01-20', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (19, 2, 'I thought mars was red.', 'https://ca.slack-edge.com/T052X7BAZ-U718GEBK8-85e990aa8065-512', 'Blue Mars', '2023-01-22', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (20, 4, 'forty-two', 'https://images.squarespace-cdn.com/content/v1/59932285c534a5589c0f696a/1502817144610-HEMH8XRLPYZ4IQU6AIKE/image1.PNG?format=1500w', 'The Meaning of Life', '2023-01-24', 1);
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (21, 4, 'How can a bagel be everything?', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/20090424_Bagels_001.JPG/250px-20090424_Bagels_001.JPG', 'Everything Bagel', '2023-01-26', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (1, '2023-01-01', 'Meet Here to Learn English', 2, 1, 1, 1, NULL, NULL, '2023-01-01', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1200', 'English Time');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (4, '2023-02-20', 'Meet here to party', 3, 1, 2, 2, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-02', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1201', 'Party Time');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (5, '2023-01-03', 'Birthday Party', 4, 1, 3, 3, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-03', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1202', 'Mike\'s B-day');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (6, '2023-05-02', 'New Season Watch party', 5, 1, 4, 4, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-04', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1203', 'Game of Thrones');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (7, '2023-04-21', 'Spa day', 6, 1, 5, 5, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-05', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1204', 'Girls Night');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (8, '2023-04-23', 'Taste testing', 7, 1, 6, 6, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-06', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1205', 'Wine Wednesday');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (9, '2023-04-23', 'Park Day', 8, 1, 7, 7, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-07', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1206', 'Powerful Parks');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (10, '2023-04-26', 'Videogame Marathon', 9, 1, 8, 8, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-08', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1207', 'VideoMan');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (11, '2023-01-30', 'Coding party', 10, 1, 9, 9, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-09', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1208', 'Coding cunundrum');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (12, '2023-01-17', 'Arts and crafts day', 11, 1, 10, 10, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-10', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1209', 'Artsy fartsy');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (13, '2023-01-01', 'Meet Here to Learn English', 2, 1, 1, 1, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-01', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1200', 'English Time');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (14, '2023-02-20', 'Meet here to party', 3, 1, 2, 2, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-02', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1201', 'Party Time');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (15, '2023-01-03', 'Birthday Party', 4, 1, 3, 3, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-03', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1202', 'Mike\'s B-day');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (16, '2023-05-02', 'New Season Watch party', 5, 1, 4, 4, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-04', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1203', 'Game of Thrones');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (17, '2023-04-21', 'Spa day', 6, 1, 5, 5, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-05', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1204', 'Girls Night');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (18, '2023-04-23', 'Taste testing', 7, 1, 6, 6, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-06', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1205', 'Wine Wednesday');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (19, '2023-04-23', 'Park Day', 8, 1, 7, 7, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-07', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1206', 'Powerful Parks');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (20, '2023-04-26', 'Videogame Marathon', 9, 1, 8, 8, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-08', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1207', 'VideoMan');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (2, '2023-01-30', 'Coding party', 10, 1, 9, 9, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-09', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1208', 'Coding cunundrum');
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (3, '2023-01-17', 'Arts and crafts day', 11, 1, 10, 10, '2022-12-31 01:02:03.000123', '2023-12-31 01:02:03.000123', '2023-01-10', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1209', 'Artsy fartsy');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alert`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (1, 1, 'Learn English', 2, 1, '2023-01-01', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (4, 4, 'anyone looking for Kaleesh learning?', 3, 6, '2023-01-12', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (5, 2, 'You Joined a new Team', 3, 6, '2023-01-14', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (6, 3, 'Your Friend just posted', 10, 8, '2023-01-16', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (7, 7, 'New Friend Request', 4, 6, '2023-01-18', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (8, 7, 'anyone looking for Kaleesh learning?', 7, 5, '2023-01-20', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (9, 8, 'You Joined a new Team', 1, 4, '2023-01-22', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (10, 5, 'Your Friend just posted', 7, 10, '2023-01-24', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (11, 3, 'New Friend Request', 8, 10, '2023-01-26', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (12, 6, 'anyone looking for Kaleesh learning?', 10, 7, '2023-01-28', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (13, 8, 'You Joined a new Team', 9, 3, '2023-01-30', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (14, 7, 'Your Friend just posted', 7, 5, '2023-02-01', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (15, 9, 'New Friend Request', 5, 4, '2023-02-03', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (16, 4, 'anyone looking for Kaleesh learning?', 9, 7, '2023-02-05', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (17, 8, 'You Joined a new Team', 7, 4, '2023-01-01', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (18, 4, 'Your Friend just posted', 1, 6, '2023-01-12', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (19, 8, 'New Friend Request', 8, 9, '2023-01-14', 0);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (2, 6, 'anyone looking for Kaleesh learning?', 6, 1, '2023-01-16', 1);
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (3, 2, 'You Joined a new Team', 7, 3, '2023-01-18', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (1, 1, 1, 'I agree!', '2023-01-01', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (3, 10, 6, 'That is Hilarious', '2023-01-01', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (4, 1, 5, 'OOO Love That!', '2023-01-12', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (5, 8, 7, 'This site has the coolest Stuff!', '2023-01-14', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (6, 7, 3, 'Would someone mind teaching me?', '2023-01-16', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (7, 1, 7, 'I need some help learning Mandarin', '2023-01-18', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (8, 5, 9, 'Is that reccomened?', '2023-01-20', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (9, 3, 7, 'Once upon a time...', '2023-01-22', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (10, 1, 7, 'We have been trying to reach you about your cars extended warranty', '2023-01-24', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (11, 4, 8, 'oof Wouldn\'t that be awful', '2023-01-26', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (12, 7, 8, 'We have been trying to reach you about your cars extended warranty', '2023-01-28', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (13, 4, 4, 'So when will the next meetup be?', '2023-01-01', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (14, 7, 9, 'So when will the next meetup be?', '2023-01-12', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (15, 10, 1, 'We have been trying to reach you about your cars extended warranty', '2023-01-14', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (16, 8, 6, 'We have been trying to reach you about your cars extended warranty', '2023-01-16', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (17, 4, 6, 'We have been trying to reach you about your cars extended warranty', '2023-01-18', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (18, 5, 7, 'This site has the coolest Stuff!', '2023-01-20', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (19, 9, 10, 'Would someone mind teaching me?', '2023-01-22', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (20, 3, 7, 'I need some help learning Mandarin', '2023-01-24', 1);
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (2, 10, 2, 'Is that reccomened?', '2023-01-26', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team_has_member`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (1, 1);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (9, 10);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (10, 7);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (3, 5);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (3, 4);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (7, 1);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (3, 8);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (4, 9);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (9, 9);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (3, 1);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (4, 2);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (9, 6);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (10, 4);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (4, 7);
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (2, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (15, 'Afrikaans', 'AF', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (2, 'Albanian', 'SQ', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (3, 'Arabic', 'AR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (4, 'Armenian', 'HY', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (5, 'Basque', 'EU', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (6, 'Bengali', 'BN', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (7, 'Bulgarian', 'BG', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (8, 'Catalan', 'CA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (9, 'Cambodian', 'KM', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (10, 'Chinese (Mandarin)', 'ZH', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (11, 'Croatian', 'HR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (12, 'Czech', 'CS', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (13, 'Danish', 'DA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (14, 'Dutch', 'NL', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (1, 'English', 'EN', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (16, 'Estonian', 'ET', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (17, 'Fiji', 'FJ', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (18, 'Finnish', 'FI', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (19, 'French', 'FR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (20, 'Georgian', 'KA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (21, 'German', 'DE', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (22, 'Greek', 'EL', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (23, 'Gujarati', 'GU', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (24, 'Hebrew', 'HE', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (25, 'Hindi', 'HI', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (26, 'Hungarian', 'HU', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (27, 'Icelandic', 'IS', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (28, 'Indonesian', 'ID', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (29, 'Irish', 'GA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (30, 'Italian', 'IT', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (31, 'Japanese', 'JA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (32, 'Javanese', 'JW', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (33, 'Korean', 'KO', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (34, 'Latin', 'LA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (35, 'Latvian', 'LV', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (36, 'Lithuanian', 'LT', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (37, 'Macedonian', 'MK', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (38, 'Malay', 'MS', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (39, 'Malayalam', 'ML', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (40, 'Maltese', 'MT', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (41, 'Maori', 'MI', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (42, 'Marathi', 'MR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (43, 'Mongolian', 'MN', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (44, 'Nepali', 'NE', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (45, 'Norwegian', 'NO', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (46, 'Persian', 'FA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (47, 'Polish', 'PL', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (48, 'Portuguese', 'PT', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (49, 'Punjabi', 'PA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (50, 'Quechua', 'QU', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (51, 'Romanian', 'RO', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (52, 'Russian', 'RU', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (53, 'Samoan', 'SM', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (54, 'Serbian', 'SR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (55, 'Slovak', 'SK', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (56, 'Slovenian', 'SL', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (57, 'Spanish', 'ES', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (58, 'Swahili', 'SW', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (59, 'Swedish', 'SV', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (60, 'Tamil', 'TA', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (61, 'Tatar', 'TT', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (62, 'Telugu', 'TE', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (63, 'Thai', 'TH', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (64, 'Tibetan', 'BO', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (65, 'Tonga', 'TO', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (66, 'Turkish', 'TR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (67, 'Ukrainian', 'UK', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (68, 'Urdu', 'UR', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (69, 'Uzbek', 'UZ', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (70, 'Vietnamese', 'VI', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (71, 'Welsh', 'CY', '.');
INSERT INTO `language` (`id`, `name`, `code`, `description`) VALUES (72, 'Xhosa', 'XH', '.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (1, 1);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (3, 8);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (4, 2);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (5, 4);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (6, 8);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (7, 7);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (8, 9);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (9, 10);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (10, 6);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (11, 9);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (12, 5);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (13, 1);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (14, 5);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (15, 6);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (16, 3);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (17, 4);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (18, 3);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (19, 7);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (20, 8);
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (2, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language_has_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 1);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 4);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 5);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 6);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 7);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (10, 1);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (9, 2);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (2, 4);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 8);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (2, 5);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (6, 9);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (5, 6);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (7, 10);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (3, 7);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (2, 8);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (10, 5);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (3, 9);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (3, 3);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (7, 4);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (4, 6);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (6, 2);
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (9, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `country_has_language`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `country_has_language` (`country_country_code`, `language_id`) VALUES ('US', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language_resource`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `language_resource` (`id`, `name`, `resource_url`, `description`, `language_id`, `added_by`, `create_date`) VALUES (1, 'Learn English', 'https://learnenglishkids.britishcouncil.org/', 'A website where a user can read, write, listen, watch, speak, and spell.', 1, 1, '2023-01-01');

COMMIT;

