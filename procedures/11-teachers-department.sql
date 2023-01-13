DROP PROCEDURE IF EXISTS teachersByDepartment;
DELIMITER //
CREATE PROCEDURE teachersByDepartment(inputedDepartment VARCHAR(150))
BEGIN
	IF(SELECT COUNT(*) FROM `examdb`.`teacher_view` WHERE `examdb`.`teacher_view`.`Кафедра` LIKE CONCAT(inputedDepartment, '%')!=0) THEN
		SELECT * FROM `examdb`.`teacher_view` WHERE `examdb`.`teacher_view`.`Кафедра` LIKE CONCAT(inputedDepartment, '%');
    ELSE
		SELECT "Записи відсутні";
    END IF;
    
END //
DELIMITER ;