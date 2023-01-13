DROP PROCEDURE IF EXISTS sessionByDate;
DELIMITER //
CREATE PROCEDURE sessionByDate(input DATE)
BEGIN
	IF ((SELECT COUNT(*) FROM `examdb`.`session_view` WHERE input < `examdb`.`session_view`.`Кінцева дата` AND input > `examdb`.`session_view`.`Початкова дата`) != 0) THEN
		SELECT * FROM `examdb`.`session_view` WHERE input < `examdb`.`session_view`.`Кінцева дата` AND input > `examdb`.`session_view`.`Початкова дата`;
	ELSE
		SELECT 'Записи відсутні';
    END IF;
END //
DELIMITER ;