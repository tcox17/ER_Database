# Inserting information into all of the tables
INSERT INTO patients VALUES (001,'John Doe', '123 Main St.', '(123)456-7890',001),
							(002,'Sarah Smith', '9200 University City', '(704)223-2334', 074);

INSERT INTO provider VALUES (712, 'Doctor 1', 'Neuro', 'Head of Surgery'),
							(327, 'Doctor 2', 'Pediatrics', 'Nurse'),
                            (329, 'Doctor 3', 'Cardio', 'Nurse');

INSERT INTO visit VALUES (987, 002,'Charlotte', '09:32:38', NOW()),
						(1003, 001,'Raleigh', '14:52:19', NOW());

INSERT INTO clinical_care VALUES (67, 001, 712, 'Flu', 67, 202.5, CURDATE()),
								(122, 002, 327, 'Covid Test Negative', 55, 190, '2020-10-09'),
                                (234, NULL, 327, 'Deceased', 55, 190, '2020-10-09'),
								(89, 002, 712,'Covid-19', 28, 129.3, CURDATE());
                                
INSERT INTO symptoms VALUES (067, 0023, 'Runny Nose'),
							(067, 034, 'Cough');

INSERT INTO procedures VALUES (072, 067, 'Surgery', 'Success'),
							  (031, 089,'Surgery', 'Infection');
                              
INSERT INTO tests VALUES (134, 067, 'Dye Test', 'Success'),
						 (234, 089,'COVID-19 Test', 'Positive'),
                         (097, 067, 'COVID-19 Test', 'Negative'),
						(876, 089, 'COVID Test', 'Negative'),
						(65, 067, 'COVid', 'Neg');
                         
INSERT INTO exams VALUES (087, 067, 'GSW', 'Bullet Fragments'),
						 (098, 067,'Wound Exam', 'Laceration'),
						(27, 089, 'GSW', 'GSW to Abdomen');
                         
INSERT INTO treatment_given VALUES (346, 067, 14, 'Advil', 19.45, 'Take twice a day for a week'),
									(987, 089,30, 'IB', 12.99, NULL);
                                
INSERT INTO ER_beds VALUES (5, FALSE, 'Taken'),
						   (7, TRUE, 'Sanitized'),
                           (3, FALSE, 'Broken'),
                           (9, TRUE, 'Sanitized'),
                           (10, TRUE, 'Cardio Only'),
                           (1, FALSE, 'Cleaning'),
                           (2, FALSE, 'IN USE');
                           
INSERT INTO billing VALUES (123456, 001, CURDATE(), 12378.84, FALSE),
						   (35789, 001, CURDATE(), 987.29, TRUE),
                           (3564, 001, CURDATE(), 25.42, FALSE);
                           
INSERT INTO supplies VALUES (9876, 'Guaze', 237, 'CVS'),
						   (23, 'Bed Pans', 45, 'Bed Pan Central');