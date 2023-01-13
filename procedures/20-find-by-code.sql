DROP PROCEDURE IF EXISTS findGroup;
DELIMITER //
CREATE PROCEDURE findGroup(groupCode INT)
BEGIN
	SELECT `examdb`.`speciality`.`code`, `examdb`.`speciality`.`name`, `examdb`.`group`.`code`,
    (SELECT COUNT(*) FROM  `examdb`.`student` WHERE `examdb`.`student`.`group` = `examdb`.`group`.`code`) AS `Студентів у групі` FROM `examdb`.`speciality`
    INNER JOIN `examdb`.`group` ON `examdb`.`group`.`speciality` = `examdb`.`speciality`.`code`
    INNER JOIN `examdb`.`student` ON `examdb`.`student`.`group` = `examdb`.`group`.`code`
	WHERE `examdb`.`speciality`.`code` = groupCode
    GROUP BY `examdb`.`group`.`code`;
END //
DELIMITER ;