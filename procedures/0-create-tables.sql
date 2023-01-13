CREATE schema `examdb`;
use `exambd`;
CREATE TABLE `speciality` (
  `code` int NOT NULL,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  CONSTRAINT `codeCheck` CHECK ((`code` between 1 and 293))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `group` (
  `code` varchar(5) NOT NULL,
  `speciality` int NOT NULL,
  `year` int NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `speciality_idx` (`speciality`),
  CONSTRAINT `speciality` FOREIGN KEY (`speciality`) REFERENCES `speciality` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `groupCheck` CHECK ((`year` between 2000 and 2021))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `patronymic` varchar(25) NOT NULL,
  `group` varchar(5) NOT NULL,
  `contract` tinyint(1) NOT NULL,
  `phone` varchar(19) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  KEY `group_idx` (`group`),
  CONSTRAINT `group` FOREIGN KEY (`group`) REFERENCES `group` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `studentCheck` CHECK (`contract` between 0 and 1)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `position` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `position_name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(25) NOT NULL,
  `name` varchar(25) NOT NULL,
  `patronymic` varchar(25) NOT NULL,
  `position` int NOT NULL,
  `department` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `position_idx` (`position`),
  KEY `department_idx` (`department`),
  CONSTRAINT `department` FOREIGN KEY (`department`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `position` FOREIGN KEY (`position`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `comission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `headTeacher` int NOT NULL,
  `firstAssistant` int DEFAULT NULL,
  `secondAssistant` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `comissionCheck` CHECK (((((`firstAssistant` is not null) and (`secondAssistant` is not null)) or ((`firstAssistant` is not null) and (`secondAssistant` is null)) or ((`firstAssistant` is null) and (`secondAssistant` is null))) and (`headTeacher` <> `firstAssistant`) and (`headTeacher` <> `secondAssistant`) and (`firstAssistant` <> `secondAssistant`)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `discipline` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `lector` int NOT NULL,
  `practic` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `format` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `discipline_teacher` (
  `disciplineID` int NOT NULL,
  `teacherID` int NOT NULL,
  PRIMARY KEY (`disciplineID`,`teacherID`),
  KEY `teacherID_idx` (`teacherID`),
  CONSTRAINT `disciplineID` FOREIGN KEY (`disciplineID`) REFERENCES `discipline` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `teacherID` FOREIGN KEY (`teacherID`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `comission_teacher` (
  `comissionID` int NOT NULL,
  `teacherID` int NOT NULL,
  PRIMARY KEY (`comissionID`,`teacherID`),
  KEY `teacheID_idx` (`teacherID`),
  CONSTRAINT `cteacherID` FOREIGN KEY (`teacherID`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tcomissionID` FOREIGN KEY (`comissionID`) REFERENCES `comission` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `startDate` date NOT NULL,
  `finishDate` date NOT NULL,
  `type` int NOT NULL,
  `discipline` int NOT NULL,
  `comission` int NOT NULL,
  `semester` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_idx` (`type`),
  KEY `discipline_idx` (`discipline`),
  KEY `comission_idx` (`comission`),
  CONSTRAINT `comission` FOREIGN KEY (`comission`) REFERENCES `comission` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `discipline` FOREIGN KEY (`discipline`) REFERENCES `discipline` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `type` FOREIGN KEY (`type`) REFERENCES `type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `sessionCheck` CHECK (((`startDate` < `finishDate`) and (`semester` between 1 and 6)))
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `grade` (
  `studentID` int NOT NULL,
  `sessionID` int NOT NULL,
  `mark` int NOT NULL,
  PRIMARY KEY (`sessionID`,`studentID`),
  KEY `sStudentID_idx` (`studentID`),
  KEY `sSessionID_idx` (`sessionID`),
  CONSTRAINT `sSessionID` FOREIGN KEY (`sessionID`) REFERENCES `session` (`id`),
  CONSTRAINT `sStudentID` FOREIGN KEY (`studentID`) REFERENCES `student` (`id`),
  CONSTRAINT `gradeCheck` CHECK ((`mark` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;