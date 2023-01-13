SELECT 	`examdb`.`student_group`.`Група`,  `examdb`.`student_group`.`Унікальний номер`, `examdb`.`student_group`.`ПІБ`,
		IFNULL((SELECT count FROM (SELECT studentID, COUNT(*) as 'count' FROM examdb.grade WHERE mark < 60 GROUP BY studentID)
        as t WHERE `examdb`.`student_group`.`Унікальний номер` = studentID), 0) as 'Кількість нескладених'
FROM `examdb`.`student_group`
INNER JOIN `examdb`.`student_session` ON `examdb`.`student_session`.`Унікальний номер` = `examdb`.`student_group`.`Унікальний номер`
WHERE `examdb`.`student_group`.`Група` = (
SELECT `examdb`.most.`Група`  FROM (
SELECT `examdb`.`student_session`.`Група`, COUNT(*) AS 'Кількість' FROM `examdb`.`student_session`
WHERE `examdb`.`student_session`.`Оцінка` < 60
GROUP BY `examdb`.`student_session`.`Група`
ORDER BY `Кількість` DESC  LIMIT 1
) as most)
GROUP BY `examdb`.`student_group`.`ПІБ`;