DROP PROCEDURE IF EXISTS showVidrahuvannya;
DELIMITER //
CREATE PROCEDURE showVidrahuvannya()
BEGIN
	SELECT * FROM `examdb`.`student_session`
	WHERE 	`examdb`.`student_session`.`Кінець сесії` = (SELECT MAX(finishDate) FROM examdb.session)
			AND `examdb`.`student_session`.`Оцінка` < 60;
END //
DELIMITER ;