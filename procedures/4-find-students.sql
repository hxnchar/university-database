DROP PROCEDURE IF EXISTS findStudent;
DELIMITER //
CREATE PROCEDURE findStudent(unsplitted VARCHAR(75))
BEGIN
	DECLARE tempString TEXT;
    DECLARE studentSurname TEXT;
    DECLARE studentName TEXT;
    DECLARE studentPatronymic TEXT;
    DECLARE studentPatronymicEnd INT;
    DECLARE studentPatronymicBegin INT;
    DECLARE countSpaces INT;
    SET unsplitted = removeSpaces(unsplitted);
    SET countSpaces = CHAR_LENGTH(unsplitted) - CHAR_LENGTH(REPLACE(unsplitted, ' ', ''));
    IF (countSpaces = 2) THEN
		SET tempString = CONCAT(unsplitted, ' ');
		SET studentPatronymicEnd = POSITION('вич ' IN tempString)+2;
		IF studentPatronymicEnd = 2 THEN SET studentPatronymicEnd = POSITION('вна ' IN tempString)+2;
		END IF;
		SET tempString = SUBSTR(tempString, 1, studentPatronymicEnd); -- видаляємо усе, що знаходиться після
		IF (CHAR_LENGTH(tempString) - CHAR_LENGTH(REPLACE(tempString, ' ', '')) = 0) THEN 
			SET studentPatronymic = tempString;
		ELSE
			SET studentPatronymic = REVERSE(SUBSTR(REVERSE(tempString), 1, POSITION(' ' IN REVERSE(tempString))));
		END IF;
		SET tempString = REPLACE (unsplitted, studentPatronymic, '');
		SET tempString = removeSpaces(tempString);
		SET studentName = SUBSTR(tempString, 1, POSITION(' ' IN tempString));
		SET tempString = REPLACE (tempString, studentName, '');
		SET studentPatronymic = removeSpaces(studentPatronymic);
		SET studentSurname = removeSpaces(tempString);
		SET studentName = removeSpaces(studentName);
		IF ((SELECT COUNT(`examdb`.`student`.`surname`) FROM `examdb`.`student` WHERE `examdb`.`student`.`surname` = studentSurname) = 0) THEN
			SET tempString = studentName;
			SET studentName = studentSurname;
			SET studentSurname = tempString;
			SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
					`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
					`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
					`examdb`.`session`.`mark` AS `Оцінка`
			FROM   	`examdb`.`student`
			INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
			INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
			INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
			INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
			WHERE   `examdb`.`student`.`surname` = studentSurname AND `examdb`.`student`.`name` = studentName
					AND `examdb`.`student`.`patronymic` = studentPatronymic
			ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
					`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
		ELSE
			SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
					`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
					`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
					`examdb`.`session`.`mark` AS `Оцінка`
			FROM   	`examdb`.`student`
			INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
			INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
			INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
			INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
			WHERE   `examdb`.`student`.`surname` = studentSurname AND `examdb`.`student`.`name` = studentName
					AND `examdb`.`student`.`patronymic` = studentPatronymic
			ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
					`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
		END IF;
	ELSEIF (countSpaces = 1) THEN
		SET tempString = CONCAT(unsplitted, ' ');
		SET studentPatronymicEnd = POSITION('вич ' IN tempString)+2;
		IF studentPatronymicEnd = 2 THEN SET studentPatronymicEnd = POSITION('вна ' IN tempString)+2;
		END IF;
        IF studentPatronymicEnd != 2 THEN
			SET tempString = SUBSTR(tempString, 1, studentPatronymicEnd); -- видаляємо усе, що знаходиться після
			-- "Василівна"
            IF (CHAR_LENGTH(tempString) - CHAR_LENGTH(REPLACE(tempString, ' ', '')) = 0) THEN 
				SET studentPatronymic = tempString;
			ELSE
				SET studentPatronymic = REVERSE(SUBSTR(REVERSE(tempString), 1, POSITION(' ' IN REVERSE(tempString))));
			END IF;
            SET tempString = unsplitted;
            SET studentName = removeSpaces(REPLACE(tempString, studentPatronymic, ''));
            select studentName;
            SET studentPatronymic = removeSpaces(studentPatronymic);
            IF ((SELECT COUNT(`examdb`.`student`.`surname`) FROM `examdb`.`student` WHERE `examdb`.`student`.`name` = studentName) != 0) THEN
				SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
						`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
						`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
						`examdb`.`session`.`mark` AS `Оцінка`
				FROM   	`examdb`.`student`
				INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
				INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
				INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
				INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
				WHERE   `examdb`.`student`.`name` = studentName AND `examdb`.`student`.`patronymic` = studentPatronymic
				ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
						`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
				-- select studentName as st, studentSurname, studentPatronymic;
			ELSE
				SET studentSurname = studentName;
				SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
						`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
						`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
						`examdb`.`session`.`mark` AS `Оцінка`
				FROM   	`examdb`.`student`
				INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
				INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
				INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
				INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
				WHERE   `examdb`.`student`.`surname` = studentSurname AND `examdb`.`student`.`patronymic` = studentPatronymic
				ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
						`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
				-- select studentName as nd, studentSurname, studentPatronymic;
			END IF;
        ELSE
			SET tempString = unsplitted;
			SET studentName = removeSpaces(SUBSTR(tempString, 1, POSITION(' ' IN tempString)));
            SET studentSurname = removeSpaces(REPLACE(tempString, studentName, ''));
            IF ((SELECT COUNT(`examdb`.`student`.`surname`) FROM `examdb`.`student` WHERE `examdb`.`student`.`surname` = studentSurname) != 0) THEN
				SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
						`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
						`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
						`examdb`.`session`.`mark` AS `Оцінка`
				FROM   	`examdb`.`student`
				INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
				INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
				INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
				INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
				WHERE   `examdb`.`student`.`surname` = studentSurname AND `examdb`.`student`.`name` = studentName
				ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
						`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
			ELSE
				SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
						`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
						`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
						`examdb`.`session`.`mark` AS `Оцінка`
				FROM   	`examdb`.`student`
				INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
				INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
				INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
				INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
				WHERE   `examdb`.`student`.`surname` = studentName AND `examdb`.`student`.`name` = studentSurname
				ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
						`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
        END IF;
        END IF;

	ELSEIF (countSpaces = 0) THEN
        SET studentName = unsplitted;
        IF ((SELECT COUNT(`examdb`.`student`.`surname`) FROM `examdb`.`student` WHERE `examdb`.`student`.`name` = studentName) != 0) THEN
			SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
					`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
					`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
					`examdb`.`session`.`mark` AS `Оцінка`
			FROM   	`examdb`.`student`
			INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
			INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
			INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
			INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
			WHERE   `examdb`.`student`.`name` = studentName
            ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
					`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
		ELSEIF ((SELECT COUNT(`examdb`.`student`.`surname`) FROM `examdb`.`student` WHERE `examdb`.`student`.`surname` = studentName) != 0) THEN
			SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
					`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
					`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
					`examdb`.`session`.`mark` AS `Оцінка`
			FROM   	`examdb`.`student`
			INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
			INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
			INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
			INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
			WHERE   `examdb`.`student`.`surname` = studentName
			ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
					`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
		ELSE
			SELECT  `examdb`.`student`.`surname` AS `Прізвище`, `examdb`.`student`.`name`  AS `Ім'я`,
					`examdb`.`student`.`patronymic` AS `По-батькові`, `examdb`.`student`.`group` AS `Група`,
					`examdb`.`type`.`name` AS `Тип контролю`, `examdb`.`discipline`.`name` AS `Назва предмету`,
					`examdb`.`session`.`mark` AS `Оцінка`
			FROM   	`examdb`.`student`
			INNER JOIN 	`examdb`.`student_session` ON  `examdb`.`student`.`id` = `examdb`.`student_session`.`studentID`
			INNER JOIN	`examdb`.`session` ON `examdb`.`student_session`.`sessionID` = `examdb`.`session`.`id`
			INNER JOIN	`examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
			INNER JOIN	`examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
			WHERE   `examdb`.`student`.`patronymic` = studentName
			ORDER BY `examdb`.`student`.`group`, `examdb`.`student`.`surname`, `examdb`.`student`.`name`,
					`examdb`.`student`.`patronymic`, `examdb`.`session`.`mark` DESC;
        END IF;
        ELSE
			SELECT "Введіть ПІБ" as "Результат";
	END IF;
END //
DELIMITER ;

-- CALL findStudent(" Горбань   Василівна Єва");