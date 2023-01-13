DROP PROCEDURE IF EXISTS sessionByMarks;
DELIMITER //
CREATE PROCEDURE sessionByMarks(minMark INT, maxMark INT)
BEGIN
	IF((minMark < 0 OR minMark > 100) OR (maxMark < 0 OR maxMark > 100)) THEN
		SELECT 'Введіть оцінку від 0 до 100';
    ELSEIF (minMark<maxMark) THEN
		SELECT * FROM `examdb`.`student_session` WHERE `examdb`.`student_session`.`Оцінка` BETWEEN minMark AND maxMark;
	ELSEIF (maxMark<minMark) THEN
		SELECT * FROM `examdb`.`student_session` WHERE `examdb`.`student_session`.`Оцінка` BETWEEN maxMark AND minMark;
    END IF;
END //
DELIMITER ;
