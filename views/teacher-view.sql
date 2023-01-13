DROP VIEW teacher_view;
CREATE VIEW teacher_view AS
SELECT 	`examdb`.`teacher`.`id` AS 'Унікальний номер',
CONCAT(`examdb`.`teacher`.`surname`, ' ', `examdb`.`teacher`.`name`, ' ', `examdb`.`teacher`.`patronymic`) as 'ПІБ',
        `examdb`.`position`.`name` AS 'Посада',	`examdb`.`department`.`name` as 'Кафедра' FROM `examdb`.`teacher`
INNER JOIN `examdb`.`position` ON `examdb`.`teacher`.`position` = `examdb`.`position`.`id`
INNER JOIN `examdb`.`department` ON `examdb`.`teacher`.`department` = `examdb`.`department`.`id`;
