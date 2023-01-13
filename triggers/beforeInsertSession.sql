DROP TRIGGER IF EXISTS `examdb`.`beforeInsertSession`;
DELIMITER $$
USE `examdb`$$
CREATE TRIGGER `beforeInsertSession` BEFORE INSERT ON `session` FOR EACH ROW BEGIN
    IF (NEW.startDate > Curdate() OR NEW.finishdate > Curdate()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Дату введено неправильно';
    ELSEIF (NEW.startDate > NEW.finishdate) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Дата окінчення сесії має бути пізніше за дату початку';
    END IF;
END$$
DELIMITER ;
