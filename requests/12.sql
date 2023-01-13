SELECT 	`examdb`.`student_session`.`Унікальний номер`, `examdb`.`student_session`.`Група`,
		`examdb`.`student_session`.`ПІБ`, ROUND(AVG(`examdb`.`student_session`.`Оцінка`),2) as 'Середня оцінка'
        FROM `examdb`.`student_session`
WHERE `examdb`.`student_session`.`Кінець сесії` = (SELECT MAX(finishDate) FROM examdb.session)
GROUP BY `examdb`.`student_session`.`Унікальний номер`
ORDER BY ROUND(AVG(`examdb`.`student_session`.`Оцінка`),2) DESC
LIMIT 40;
