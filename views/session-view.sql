DROP VIEW IF EXISTS session_view;
CREATE VIEW session_view AS
SELECT 	`examdb`.`session`.`id` AS 'Унікальний номер',
        `examdb`.`session`.`startDate` AS 'Початкова дата',	`examdb`.`session`.`finishDate` AS 'Кінцева дата',
        `examdb`.`type`.`name` AS 'Тип контролю', `examdb`.`discipline_view`.`Назва` AS 'Предмет',
        `examdb`.`comission_view`.`Голова комісії`,
        IFNULL(`examdb`.`comission_view`.`Перший асистент`, 'Відсутній') AS 'Перший асистент',
        IFNULL(`examdb`.`comission_view`.`Другий асистент`, 'Відсутній') AS 'Другий асистент'
        FROM `examdb`.`session`
INNER JOIN `examdb`.`type` ON `examdb`.`session`.`type` = `examdb`.`type`.`id`
INNER JOIN `examdb`.`comission_view` ON `examdb`.`session`.`type` = `examdb`.`comission_view`.`id`
INNER JOIN `examdb`.`discipline_view` ON `examdb`.`session`.`discipline` = `examdb`.`discipline_view`.`Унікальний номер`;