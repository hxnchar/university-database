SELECT 	`examdb`.`student_session`.`Група`, `examdb`.`student_session`.`Тип контролю`, ROUND(AVG(`Оцінка`), 2) as 'Середня оцінка'
FROM `examdb`.`student_session`
GROUP BY `examdb`.`student_session`.`Група`, `examdb`.`student_session`.`Тип контролю`
ORDER BY `examdb`.`student_session`.`Група`;