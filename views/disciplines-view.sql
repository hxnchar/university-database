DROP VIEW IF EXISTS discipline_view;
CREATE VIEW discipline_view AS
SELECT 	`examdb`.`discipline`.`id` as 'Унікальний номер',
		lector.`ПІБ` as `Лектор`, practic.`ПІБ` as `Практик` FROM `examdb`.`discipline`
LEFT JOIN `examdb`.`teacher_view` lector ON lector.`Унікальний номер` = `examdb`.`discipline`.`lector`
LEFT JOIN `examdb`.`teacher_view` practic ON practic.`Унікальний номер` = `examdb`.`discipline`.`practic`;