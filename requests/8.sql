SELECT * FROM `examdb`.`teacher_view`
WHERE `examdb`.`teacher_view`.`Кафедра`= (SELECT MAX(`examdb`.`teacher_view`.`Кафедра`) FROM `examdb`.`teacher_view`);