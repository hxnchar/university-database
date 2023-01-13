DROP VIEW student_session;
CREATE VIEW student_session AS
SELECT `examdb`.`student`.`id` AS 'Унікальний номер',  `examdb`.`student`.`group` AS 'Група',
    CONCAT(`examdb`.`student`.`surname`, ' ', `examdb`.`student`.`name`, ' ', `examdb`.`student`.`patronymic`) as 'ПІБ',
        `examdb`.`type`.`name` AS 'Тип контролю', `examdb`.`discipline`.`name` as 'Дисципліна',
        `examdb`.`grade`.`mark` as 'Оцінка' FROM `examdb`.`student`
INNER JOIN `examdb`.`grade` ON `examdb`.`grade`.`studentID` = `examdb`.`student`.`id`
INNER JOIN `examdb`.`session` ON `examdb`.`session`.`id` = `examdb`.`grade`.`sessionID`
INNER JOIN `examdb`.`discipline` ON `examdb`.`session`.`discipline` = `examdb`.`discipline`.`id`
INNER JOIN `examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`;
