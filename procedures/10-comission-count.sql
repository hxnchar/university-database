DROP PROCEDURE IF EXISTS showComissionsByCount;
DELIMITER //
CREATE PROCEDURE showComissionsByCount(countTeachers INT)
BEGIN
	IF(countTeachers <= 0 OR countTeachers > 3) THEN
		SELECT "Таких комісій не існує";
    ELSEIF(countTeachers = 1) THEN
		SELECT * FROM `examdb`.`comission_view` WHERE `examdb`.`comission_view`.`Перший асистент` IS NULL AND `examdb`.`comission_view`.`Другий асистент` IS NULL;
    ELSEIF(countTeachers = 2) THEN
		SELECT * FROM `examdb`.`comission_view` WHERE `examdb`.`comission_view`.`Перший асистент` IS NOT NULL AND `examdb`.`comission_view`.`Другий асистент` IS NULL;
	ELSEIF(countTeachers = 3) THEN
		SELECT * FROM `examdb`.`comission_view` WHERE `examdb`.`comission_view`.`Другий асистент` IS NOT NULL;
    END IF;
    
END //
DELIMITER ;