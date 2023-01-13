DROP FUNCTION IF EXISTS removeSpaces;
DELIMITER //
CREATE FUNCTION removeSpaces(unremoved VARCHAR(1000)) RETURNS VARCHAR(1000) DETERMINISTIC
BEGIN
    SET unremoved = TRIM(BOTH ' ' FROM unremoved);
    removing: WHILE (INSTR(unremoved, '  ') > 0) DO
		SET unremoved = REPLACE (unremoved, '  ', ' ');
	END WHILE removing;
    return unremoved;
END //