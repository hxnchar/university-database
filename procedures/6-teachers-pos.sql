DROP PROCEDURE IF EXISTS findTeacherByPosition;
DELIMITER //
CREATE PROCEDURE findTeacherByPosition(inputedPosition VARCHAR(50))
BEGIN
	IF((SELECT COUNT(*) FROM `examdb`.`teacher_view` WHERE `examdb`.`teacher_view`.`Посада` = inputedPosition)!=0) THEN
		SELECT * FROM `examdb`.`teacher_view` WHERE `examdb`.`teacher_view`.`Посада` = inputedPosition;
    ELSE
		SELECT "Викладачі відсутні";
    END IF;
    
END //
DELIMITER ;