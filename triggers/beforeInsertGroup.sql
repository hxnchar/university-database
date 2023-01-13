DROP TRIGGER IF EXISTS `examdb`.` beforeInsertGroup`;

DELIMITER $$
USE `examdb`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `group_BEFORE_INSERT` BEFORE INSERT ON `group` FOR EACH ROW BEGIN
    IF (SUBSTR(NEW.code, 4, 1) != SUBSTR(NEW.year, 4, 1)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Шифр групи введено неправильно';
    ELSEIF (new.year > YEAR(CURDATE()) OR new.year < 2000) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Рік заснування групи введено неправильно';
    END IF;
END$$
DELIMITER ;
