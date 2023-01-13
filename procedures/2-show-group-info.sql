DROP PROCEDURE IF EXISTS showInfoGroup;
DELIMITER //
CREATE PROCEDURE showInfoGroup(groupCode VARCHAR(5))
BEGIN
	SELECT * FROM `examdb`.`student_group`
	WHERE `examdb`.`student_group`.`Група` = groupCode;
END //
DELIMITER ;

CALL showInfoGroup("ІП-02");