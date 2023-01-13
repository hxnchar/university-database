DROP VIEW IF EXISTS student_group;
CREATE VIEW student_group AS
SELECT   `examdb`.`group`.`code` AS 'Група', `examdb`.`group`.`year` AS 'Рік формування',
    CONCAT(`examdb`.`student`.`surname`, ' ', `examdb`.`student`.`name`, ' ', `examdb`.`student`.`patronymic`) as 'ПІБ',
    `examdb`.`speciality`.`code` AS 'Код спеціальності' FROM `examdb`.`group`
INNER JOIN `examdb`.`student` ON `examdb`.`student`.`group` = `examdb`.`group`.`code`
INNER JOIN `examdb`.`speciality` ON `examdb`.`speciality`.`code` = `examdb`.`group`.`speciality`;