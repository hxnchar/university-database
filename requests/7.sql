SELECT * FROM (SELECT *, (SELECT COUNT(*) FROM examdb.discipline
  WHERE examdb.discipline.lector = examdb.teacher_view.`Унікальний номер`
    OR examdb.discipline.practic = examdb.teacher_view.`Унікальний номер`) +
    (SELECT COUNT(*) FROM examdb.comission
  WHERE examdb.comission.headTeacher = examdb.teacher_view.`Унікальний номер`
    OR examdb.comission.firstAssistant = examdb.teacher_view.`Унікальний номер`
    OR examdb.comission.secondAssistant = examdb.teacher_view.`Унікальний номер`) as `Коефіцінт навантаження` FROM examdb.teacher_view ) as dddddd
WHERE `Коефіцінт навантаження` > (SELECT AVG(`Коефіцінт навантаження`) FROM (SELECT * FROM (SELECT *, (SELECT COUNT(*) FROM examdb.discipline
  WHERE examdb.discipline.lector = examdb.teacher_view.`Унікальний номер`
    OR examdb.discipline.practic = examdb.teacher_view.`Унікальний номер`) +
    (SELECT COUNT(*) FROM examdb.comission
  WHERE examdb.comission.headTeacher = examdb.teacher_view.`Унікальний номер`
    OR examdb.comission.firstAssistant = examdb.teacher_view.`Унікальний номер`
    OR examdb.comission.secondAssistant = examdb.teacher_view.`Унікальний номер`) as `Коефіцінт навантаження` FROM examdb.teacher_view ) as ddddddd) as ff);
