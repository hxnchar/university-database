SELECT 	`examdb`.`student_session`.`Тип контролю`, AVG(`Оцінка`) as 'Середня оцінка'
FROM `examdb`.`student_session`
GROUP BY `examdb`.`student_session`.`Тип контролю`;