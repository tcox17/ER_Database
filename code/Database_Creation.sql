# Start by creating the database
CREATE DATABASE IF NOT EXISTS er_db;

# Creating all tables for the database. Include drop to make make it easier to update tables
#DROP TABLE patients;
CREATE TABLE IF NOT EXISTS patients(
	patient_id			INT 			PRIMARY KEY			AUTO_INCREMENT,
	patient_name		VARCHAR(100),
	address				VARCHAR(250),
	phone_number		VARCHAR(50),
	insurance_id		INT
)ENGINE = InnoDB;

#DROP TABLE patients_audit;
CREATE TABLE IF NOT EXISTS patients_audit(
	patient_id			INT 			,
	patient_name		VARCHAR(100),
	address				VARCHAR(250),
	phone_number		VARCHAR(50),
	insurance_id		INT,
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
)ENGINE = InnoDB;

#DROP TABLE provider_audit;
CREATE TABLE IF NOT EXISTS provider(
	employee_id			INT				PRIMARY KEY,
	provider_name		VARCHAR(100),
	provider_specialty	VARCHAR(50),
	provider_position	VARCHAR(100)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS provider_audit(
	employee_id			INT	,
	provider_name		VARCHAR(100),
	provider_specialty	VARCHAR(50),
	provider_position	VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
)ENGINE = InnoDB;


#DROP TABLE visit_audit;
CREATE TABLE IF NOT EXISTS visit(
	visit_id			INT				PRIMARY KEY,
	patient_id			INT,
	facility			VARCHAR(100),
	time_in				TIME,
	time_out			TIME,
    CONSTRAINT fk_visit_patients
		FOREIGN KEY (patient_id)
		REFERENCES patients (patient_id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS visit_audit(
	visit_id			INT,
	patient_id			INT,
	facility			VARCHAR(100),
	time_in				TIME,
	time_out			TIME,
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
)ENGINE = InnoDB;


#DROP TABLE clinical_care;
CREATE TABLE IF NOT EXISTS clinical_care(
	care_id				INT				 PRIMARY KEY,
	patient_id			INT,
    employee_id			INT,
	diagnosis			VARCHAR(100),
	height				DECIMAL(5,2),
	weight				DECIMAL(5,2),
	date_of_visit		DATE,
	CONSTRAINT fk_care_patients
		FOREIGN KEY (patient_id)
		REFERENCES patients (patient_id),
	CONSTRAINT fk_visit_provider
		FOREIGN KEY (employee_id)
		REFERENCES provider (employee_id)
)ENGINE = InnoDB;

#DROP TABLE clinical_care_audit;
CREATE TABLE IF NOT EXISTS clinical_care_audit(
	care_id				INT,
	patient_id			INT,
    employee_id			INT,
	diagnosis			VARCHAR(100),
	height				DECIMAL(5,2),
	weight				DECIMAL(5,2),
	date_of_visit		DATE,
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
);

#DROP TABLE symptoms;
CREATE TABLE IF NOT EXISTS symptoms(
	care_id				INT		NOT NULL,
    symptom_id			INT,
    symptom_name		VARCHAR(100),
    CONSTRAINT fk_care_symptoms
		FOREIGN KEY (care_id)
		REFERENCES clinical_care (care_id),
	PRIMARY KEY (symptom_id, care_id)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS symptoms_audit(
	care_id				INT		NOT NULL,
    symptom_id			INT,
    symptom_name		VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
    );

#DROP TABLE procedures;
CREATE TABLE IF NOT EXISTS procedures(
	procedure_id		INT		PRIMARY KEY,
    care_id				INT		NOT NULL,
	procedure_name		VARCHAR(100),
    procedure_result	VARCHAR(100),
    CONSTRAINT fk_care_procedure
		FOREIGN KEY (care_id)
		REFERENCES clinical_care (care_id)
)ENGINE = InnoDB;

#DROP TABLE procedures_audit;
CREATE TABLE IF NOT EXISTS procedures_audit(
	procedure_id		INT,
    care_id				INT		NOT NULL,
	procedure_name		VARCHAR(100),
    procedure_result	VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
    );

#DROP TABLE tests;
CREATE TABLE IF NOT EXISTS tests(
	test_id				INT		PRIMARY KEY,
    care_id				INT		NOT NULL,
	test_name			VARCHAR(100),
    test_result			VARCHAR(100),
    CONSTRAINT fk_care_test
		FOREIGN KEY (care_id)
		REFERENCES clinical_care (care_id)
)ENGINE = InnoDB;

#DROP TABLE tests_audit;
CREATE TABLE IF NOT EXISTS tests_audit(
	test_id				INT		PRIMARY KEY,
    care_id				INT		NOT NULL,
	test_name			VARCHAR(100),
    test_result			VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
    );

#DROP TABLE exams;
CREATE TABLE IF NOT EXISTS exams(
	exam_id				INT				PRIMARY KEY,
	care_id				INT				NOT NULL,
    exam_name			VARCHAR(100),
    exam_result			VARCHAR(100),
    CONSTRAINT fk_care_exam
		FOREIGN KEY (care_id)
		REFERENCES clinical_care (care_id)
)ENGINE = InnoDB;

#DROP TABLE exams_audit;
CREATE TABLE IF NOT EXISTS exams_audit(
	exam_id				INT,
	care_id				INT				NOT NULL,
    exam_name			VARCHAR(100),
    exam_result			VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
    );

#DROP TABLE IF EXISTS treatment_given;
CREATE TABLE IF NOT EXISTS treatment_given(
	treatment_id		INT 			PRIMARY KEY,
    care_id				INT				NOT NULL,
    quantity	 		INT,
    prescription_name	VARCHAR(100),
    prescription_price	DECIMAL,
    notes				VARCHAR(250),
    CONSTRAINT fk_care_treatment
		FOREIGN KEY (care_id)
		REFERENCES clinical_care (care_id)
)ENGINE = InnoDB;

#DROP TABLE treatment_given_audit;
CREATE TABLE IF NOT EXISTS treatment_given_audit(
	treatment_id		INT 			NOT NULL,
    care_id				INT				NOT NULL,
    quantity	 		INT,
    prescription_name	VARCHAR(100),
    prescription_price	DECIMAL,
    notes				VARCHAR(250),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
    );

#DROP TABLE ER_beds;
CREATE TABLE IF NOT EXISTS ER_beds(
	bed_number			INT				PRIMARY KEY,
	available			BOOLEAN,
    bed_status			VARCHAR(100)
)ENGINE = InnoDB;

#DROP TABLE ER_beds_audit;
CREATE TABLE IF NOT EXISTS ER_beds_audit(
	bed_number			INT,
	available			BOOLEAN,
    bed_status			VARCHAR(100),
    action_type		VARCHAR(50)		NOT NULL,
	action_date		DATETIME		NOT NULL,
    username		VARCHAR(50)
)ENGINE = InnoDB;

#DROP TABLE billing_audit;
CREATE TABLE IF NOT EXISTS billing(
	bill_id				INT,
    patient_id			INT,
	date_sent			DATE,
    amount				DECIMAL(10,2),
    paid				BOOLEAN,
    CONSTRAINT fk_billing_patients
		FOREIGN KEY (patient_id)
		REFERENCES patients (patient_id)
)ENGINE = InnoDB;

CREATE TABLE billing_audit
 (
 bill_id		INT 		NOT NULL,
 patient_id		INT			NOT NULL,
 date_sent		DATE,
 amount			DECIMAL(10,2) NOT NULL,
 paid			BOOLEAN,
 action_type	VARCHAR(50)		NOT NULL,
 action_date	DATETIME		NOT NULL,
 username		VARCHAR(50)
 );

#DROP TABLE supplies_audit;
CREATE TABLE IF NOT EXISTS supplies(
	supply_id			INT				PRIMARY KEY,
	name_of_material	VARCHAR(100),
    quantity			INT,
    supplier			VARCHAR(100)
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS supplies_audit(
	supply_id			INT,
	name_of_material	VARCHAR(100),
    quantity			INT,
    supplier			VARCHAR(100),
    action_type			VARCHAR(50)		NOT NULL,
	action_date			DATETIME		NOT NULL,
	username			VARCHAR(50)
)ENGINE = InnoDB;
