DROP TRIGGER IF EXISTS `examdb`.`beforeInsertStudent`;

DELIMITER $$
USE `examdb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `examdb`.`beforeInsertStudent` BEFORE INSERT ON `student` FOR EACH ROW
BEGIN
    IF ((SELECT COUNT(*) FROM `examdb`.`student` WHERE `examdb`.`student`.`group` = new.group)>=35) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'У групі забагато студентів';
    END IF;
END$$
DELIMITER ;
