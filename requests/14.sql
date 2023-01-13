SELECT * FROM (SELECT *, (SELECT COUNT(*) FROM `examdb`.`session` WHERE
		`examdb`.`session`.`comission` = `examdb`.`comission_view`.`id`) as 'Кількість'
FROM `examdb`.`comission_view`) as preq
ORDER BY `preq`.`Кількість` DESC
LIMIT 5;