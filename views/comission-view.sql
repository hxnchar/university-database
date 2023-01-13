DROP VIEW IF EXISTS comission_view;
CREATE VIEW comission_view AS
SELECT `examdb`.`comission`.`id`, headTeacherTable.`ПІБ` as `Голова комісії`,
		firstAsTable.`ПІБ` as `Перший асистент`,
        secondAsTable.`ПІБ`  as `Другий асистент` FROM `examdb`.`comission`
LEFT JOIN `examdb`.`teacher_view` headTeacherTable ON headTeacherTable.`Унікальний номер` = `examdb`.`comission`.`headTeacher`
LEFT JOIN `examdb`.`teacher_view` firstAsTable ON firstAsTable.`Унікальний номер` = `examdb`.`comission`.`firstAssistant`
LEFT JOIN `examdb`.`teacher_view`  secondAsTable ON secondAsTable.`Унікальний номер` = `examdb`.`comission`.`secondAssistant`