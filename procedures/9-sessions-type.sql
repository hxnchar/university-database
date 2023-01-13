DROP PROCEDURE IF EXISTS showSessionsByType;
DELIMITER //
CREATE PROCEDURE showSessionsByType(inputedType VARCHAR(15))
BEGIN
	IF(SELECT COUNT(*) FROM `examdb`.`student_session` WHERE `examdb`.`student_session`.`Тип контролю` LIKE CONCAT(inputedType, '%')!=0) THEN
		SELECT * FROM `examdb`.`student_session` WHERE `examdb`.`student_session`.`Тип контролю` LIKE CONCAT(inputedType, '%');
    ELSE
		SELECT "Записи відсутні";
    END IF;
    
END //
DELIMITER ;