DROP PROCEDURE IF EXISTS comissionsWithTeacher;
DELIMITER //
CREATE PROCEDURE comissionsWithTeacher(inputedName VARCHAR(75))
BEGIN
	SELECT * FROM `examdb`.`comission_view` WHERE 	`examdb`.`comission_view`.`Голова комісії` LIKE CONCAT(inputedName, '%')
													OR `examdb`.`comission_view`.`Перший асистент` LIKE CONCAT(inputedName, '%')
                                                    OR `examdb`.`comission_view`.`Другий асистент` LIKE CONCAT(inputedName, '%');
END //
DELIMITER ;