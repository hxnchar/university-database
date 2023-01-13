SELECT `examdb`.`student_session`.`ПІБ`, `examdb`.`student_session`.`Тип контролю`,
ROUND(AVG(`examdb`.`student_session`.`Оцінка`), 2) as 'Середнє значення' FROM examdb.student_session
GROUP BY `examdb`.`student_session`.`ПІБ`, `examdb`.`student_session`.`Тип контролю`
ORDER BY `examdb`.`student_session`.`ПІБ`;