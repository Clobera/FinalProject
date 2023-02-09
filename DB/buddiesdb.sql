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
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
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
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (1, 'admin@admin.com', 'admin', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-01', '2023-01-01', 1, 'admin', 0, 'admin', 'admin', NULL, NULL, 1, 'US');
INSERT INTO `user` (`id`, `email`, `username`, `password`, `date_created`, `last_login`, `enabled`, `role`, `sponsor`, `first_name`, `last_name`, `image_url`, `bio`, `address_id`, `origin_country`) VALUES (2, 'joe@shmoe.com', 'joeshmoe', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', '2023-01-01', '2023-01-01', 1, 'admin', 0, 'Joe', 'Shmoe', NULL, NULL, 3, 'US');

COMMIT;


-- -----------------------------------------------------
-- Data for table `post`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `post` (`id`, `user_id`, `content`, `image_url`, `post_date`, `enabled`) VALUES (1, 1, 'This is so cool!', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT92-R1QhOfOpRc9FmRhePfW3eBBwLWSO4GVC72iqGDoA&s', '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `team` (`id`, `owner_id`, `content`, `image_url`, `name`, `create_date`, `enabled`) VALUES (1, 1, 'We are a group who just wants to make the world a better place', 'https://d3mvlb3hz2g78.cloudfront.net/wp-content/uploads/2020/11/thumb_720_450_dreamstime_m_44810592_(1).jpg', 'Better People Better World', '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `meetup` (`id`, `meetup_date`, `content`, `address_id`, `enabled`, `owner_id`, `team_id`, `start_time`, `end_time`, `created_date`, `image_url`, `title`) VALUES (1, '2023-01-01', 'Meet Here to Learn English', 2, 1, 1, 1, NULL, NULL, '2023-01-01', 'https://www.lakewood.org/files/assets/public/community-resources/parks/holbrook-park.jpg?w=1200', 'English Time');

COMMIT;


-- -----------------------------------------------------
-- Data for table `alert`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `alert` (`id`, `sender_id`, `content`, `receiver_id`, `meetup_id`, `notification_date`, `seen`) VALUES (1, 1, 'Learn English', 2, 1, '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `comment` (`id`, `post_id`, `user_id`, `content`, `comment_date`, `enabled`) VALUES (1, 1, 1, 'I agree!', '2023-01-01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `team_has_member`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `team_has_member` (`group_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `language` (`id`, `name`, `description`) VALUES (1, 'English', 'Most spoken language in the world');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_has_meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `user_has_meetup` (`user_id`, `event_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `language_has_user`
-- -----------------------------------------------------
START TRANSACTION;
USE `bilingualbuddiesdb`;
INSERT INTO `language_has_user` (`language_id`, `user_id`) VALUES (1, 1);

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

