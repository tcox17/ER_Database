#Creating and Granting User Privileges, Creating the audit trail
#Indexes, Views, and Triggers/Stored Procedures

# Granting Privileges/Authorization
/*
CREATE USER 'doctor1'@'localhost' IDENTIFIED BY 'doctor1';
CREATE USER 'doctor2'@'localhost' IDENTIFIED BY 'doctor2';
CREATE USER 'doctor3'@'localhost' IDENTIFIED BY 'doctor3';
CREATE USER 'reception1'@'localhost' IDENTIFIED BY 'reception1';
CREATE USER 'reception2'@'localhost' IDENTIFIED BY 'reception2';
CREATE USER 'nurse'@'localhost' IDENTIFIED BY 'nurse';
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager';
CREATE USER 'pharm'@'localhost' IDENTIFIED BY 'medicine';

GRANT ALL ON emergency_room_db.* TO 'doctor1'@'localhost', 'doctor2'@'localhost', 'doctor3'@'localhost';
GRANT SELECT, ALTER, INSERT, UPDATE, DELETE ON emergency_room_db.patients TO 'reception2'@'localhost', 'reception1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON emergency_room_db.billing TO 'reception2'@'localhost', 'reception1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON emergency_room_db.visit TO 'reception2'@'localhost', 'reception1'@'localhost';
GRANT SELECT ON emergency_room_db.* TO 'reception2'@'localhost', 'reception1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON emergency_room_db.supplies TO 'manager'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON emergency_room_db.provider TO 'manager'@'localhost';
GRANT ALL ON emergency_room_db.billing TO 'pharm'@'localhost';
GRANT SELECT ON emergency_room_db.treatment_given TO 'pharm'@'localhost';
GRANT SELECT (diagnosis, patient_id) ON emergency_room_db.clinical_care TO 'pharm'@'localhost';
GRANT SELECT ON emergency_room_db.visit_information TO 'pharm'@'localhost';
GRANT ALL ON procedure insert_new_patient TO 'reception1'@'localhost'; 
*/

# Creating an Audit Trail - Triggers

# All triggers for all tables after updating the table
DROP TRIGGER IF EXISTS billing_after_update;

DELIMITER //

CREATE TRIGGER billing_after_update
  AFTER UPDATE ON billing
  FOR EACH ROW
BEGIN
    INSERT INTO billing_audit VALUES
    (OLD.bill_id, OLD.patient_id, OLD.date_sent, OLD.amount,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS care_after_update//

DELIMITER //

CREATE TRIGGER care_after_update
  AFTER UPDATE ON clinical_care
  FOR EACH ROW
BEGIN
    INSERT INTO clinical_care_audit VALUES
    (OLD.care_id, OLD.patient_id, OLD.employee_id, OLD.diagnosis, OLD.height, OLD.weight, OLD.date_of_visit,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS beds_after_update//
CREATE TRIGGER beds_after_update
  AFTER UPDATE ON ER_beds
  FOR EACH ROW
BEGIN
    INSERT INTO ER_beds_audit VALUES
    (OLD.bed_number, OLD.available, OLD.bed_status,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS exams_after_update//
CREATE TRIGGER exams_after_update
  AFTER UPDATE ON exams
  FOR EACH ROW
BEGIN
    INSERT INTO exams_audit VALUES
    (OLD.exam_id, OLD.care_id, OLD.exam_name, OLD.exam_result,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS patients_after_update//
CREATE TRIGGER patients_after_update
  AFTER UPDATE ON patients
  FOR EACH ROW
BEGIN
    INSERT INTO patients_audit VALUES
    (OLD.patient_id, OLD.patient_name, OLD.address, OLD.phone_number, OLD.insurance_id,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS procedure_after_update//
CREATE TRIGGER procedure_after_update
  AFTER UPDATE ON procedures
  FOR EACH ROW
BEGIN
    INSERT INTO procedures_audit VALUES
    (OLD.procedure_id, OLD.care_id, OLD.procedure_name, OLD.procedure_result,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS provider_after_update//
CREATE TRIGGER provider_after_update
  AFTER UPDATE ON provider
  FOR EACH ROW
BEGIN
    INSERT INTO provider_audit VALUES
    (OLD.employee_id, OLD.provider_name, OLD.provider_specialty, OLD.provider_position,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS supplies_after_update//
CREATE TRIGGER supplies_after_update
  AFTER UPDATE ON supplies
  FOR EACH ROW
BEGIN
    INSERT INTO supplies_audit VALUES
    (OLD.supply_id, OLD.name_of_material, OLD.quantity, OLD.supplier,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS symptoms_after_update//
CREATE TRIGGER symptoms_after_update
  AFTER UPDATE ON symptoms
  FOR EACH ROW
BEGIN
    INSERT INTO symptoms_audit VALUES
    (OLD.care_id, OLD.symptom_id, OLD.symptom_name,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS tests_after_update//
CREATE TRIGGER tests_after_update
  AFTER UPDATE ON tests
  FOR EACH ROW
BEGIN
    INSERT INTO tests_audit VALUES
    (OLD.test_id, OLD.care_id, OLD.test_name, OLD.test_result,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS treatment_after_update//
CREATE TRIGGER treatment_after_update
  AFTER UPDATE ON treatment_given
  FOR EACH ROW
BEGIN
    INSERT INTO treatment_given_audit VALUES
    (OLD.treatment_id, OLD.care_id, OLD.quantity, OLD.prescription_name, OLD.prescription_price, OLD.notes,
    'UPDATED', NOW(), user());
END//

DROP TRIGGER IF EXISTS visit_after_update//
CREATE TRIGGER visit_after_update
  AFTER UPDATE ON visit
  FOR EACH ROW
BEGIN
    INSERT INTO visit_audit VALUES
    (OLD.visit_id, OLD.patient_id, OLD.facility, OLD.time_in, OLD.time_out,
    'UPDATED', NOW(), user());
END//


# After insert Triggers
DROP TRIGGER IF EXISTS billing_after_insert//
CREATE TRIGGER billing_after_insert
  AFTER INSERT ON billing
  FOR EACH ROW
BEGIN
    INSERT INTO billing_audit VALUES
    (NEW.bill_id, NEW.patient_id, NEW.date_sent, NEW.amount,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS care_after_insert//
CREATE TRIGGER care_after_insert
  AFTER INSERT ON clinical_care
  FOR EACH ROW
BEGIN
    INSERT INTO clinical_care_audit VALUES
    (NEW.care_id, NEW.patient_id, NEW.employee_id, NEW.diagnosis, NEW.height, NEW.weight, NEW.date_of_visit,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS beds_after_insert//
CREATE TRIGGER beds_after_insert
  AFTER INSERT ON ER_beds
  FOR EACH ROW
BEGIN
    INSERT INTO ER_beds_audit VALUES
    (NEW.bed_number, NEW.available, NEW.bed_status,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS exams_after_insert//
CREATE TRIGGER exams_after_insert
  AFTER INSERT ON exams
  FOR EACH ROW
BEGIN
    INSERT INTO exams_audit VALUES
    (NEW.exam_id, NEW.care_id, NEW.exam_name, NEW.exam_result,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS patients_after_insert//
CREATE TRIGGER patients_after_insert
  AFTER INSERT ON patients
  FOR EACH ROW
BEGIN
    INSERT INTO patients_audit VALUES
    (NEW.patient_id, NEW.patient_name, NEW.address, NEW.phone_number, NEW.insurance_id,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS procedure_after_insert//
CREATE TRIGGER procedure_after_insert
  AFTER INSERT ON procedures
  FOR EACH ROW
BEGIN
    INSERT INTO procedures_audit VALUES
    (NEW.procedure_id, NEW.care_id, NEW.procedure_name, NEW.procedure_result,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS provider_after_insert//
CREATE TRIGGER provider_after_insert
  AFTER INSERT ON provider
  FOR EACH ROW
BEGIN
    INSERT INTO provider_audit VALUES
    (NEW.employee_id, NEW.provider_name, NEW.provider_specialty, NEW.provider_position,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS supplies_after_insert//
CREATE TRIGGER supplies_after_insert
  AFTER INSERT ON supplies
  FOR EACH ROW
BEGIN
    INSERT INTO supplies_audit VALUES
    (NEW.supply_id, NEW.name_of_material, NEW.quantity, NEW.supplier,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS symptoms_after_insert//
CREATE TRIGGER symptoms_after_insert
  AFTER INSERT ON symptoms
  FOR EACH ROW
BEGIN
    INSERT INTO symptoms_audit VALUES
    (NEW.care_id, NEW.symptom_id, NEW.symptom_name,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS tests_after_insert//
CREATE TRIGGER tests_after_insert
  AFTER INSERT ON tests
  FOR EACH ROW
BEGIN
    INSERT INTO tests_audit VALUES
    (NEW.test_id, NEW.care_id, NEW.test_name, NEW.test_result,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS treatment_after_insert//
CREATE TRIGGER treatment_after_insert
  AFTER INSERT ON treatment_given
  FOR EACH ROW
BEGIN
    INSERT INTO treatment_given_audit VALUES
    (NEW.treatment_id, NEW.care_id, NEW.quantity, NEW.prescription_name, NEW.prescription_price, NEW.notes,
    'INSERTED', NOW(), user());
END//

DROP TRIGGER IF EXISTS visit_after_insert//
CREATE TRIGGER visit_after_insert
  AFTER INSERT ON visit
  FOR EACH ROW
BEGIN
    INSERT INTO visit_audit VALUES
    (NEW.visit_id, NEW.patient_id, NEW.facility, NEW.time_in, NEW.time_out,
    'INSERTED', NOW(), user());
END//

# After delete Triggers
DROP TRIGGER IF EXISTS billing_after_delete//
DELIMITER //
CREATE TRIGGER billing_after_delete
  AFTER DELETE ON billing
  FOR EACH ROW
BEGIN
    INSERT INTO billing_audit VALUES
    (OLD.bill_id, OLD.patient_id, OLD.date_sent, OLD.amount,
    'DELETE', NOW(), user());
END//

DROP TRIGGER IF EXISTS care_after_delete//
CREATE TRIGGER care_after_delete
  AFTER DELETE ON clinical_care
  FOR EACH ROW
BEGIN
    INSERT INTO clinical_care_audit VALUES
    (OLD.care_id, OLD.patient_id, OLD.employee_id, OLD.diagnosis, OLD.height, OLD.weight, OLD.date_of_visit,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS beds_after_delete//
CREATE TRIGGER beds_after_delete
  AFTER DELETE ON ER_beds
  FOR EACH ROW
BEGIN
    INSERT INTO ER_beds_audit VALUES
    (OLD.bed_number, OLD.available, OLD.bed_status,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS exams_after_delete//
CREATE TRIGGER exams_after_delete
  AFTER DELETE ON exams
  FOR EACH ROW
BEGIN
    INSERT INTO exams_audit VALUES
    (OLD.exam_id, OLD.care_id, OLD.exam_name, OLD.exam_result,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS patients_after_delete//
CREATE TRIGGER patients_after_delete
  AFTER DELETE ON patients
  FOR EACH ROW
BEGIN
    INSERT INTO patients_audit VALUES
    (OLD.patient_id, OLD.patient_name, OLD.address, OLD.phone_number, OLD.insurance_id,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS procedure_after_delete//
CREATE TRIGGER procedure_after_delete
  AFTER DELETE ON procedures
  FOR EACH ROW
BEGIN
    INSERT INTO procedures_audit VALUES
    (OLD.procedure_id, OLD.care_id, OLD.procedure_name, OLD.procedure_result,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS provider_after_delete//
CREATE TRIGGER provider_after_delete
  AFTER DELETE ON provider
  FOR EACH ROW
BEGIN
    INSERT INTO provider_audit VALUES
    (OLD.employee_id, OLD.provider_name, OLD.provider_specialty, OLD.provider_position,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS supplies_after_delete//
CREATE TRIGGER supplies_after_delete
  AFTER DELETE ON supplies
  FOR EACH ROW
BEGIN
    INSERT INTO supplies_audit VALUES
    (OLD.supply_id, OLD.name_of_material, OLD.quantity, OLD.supplier,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS symptoms_after_delete//
CREATE TRIGGER symptoms_after_delete
  AFTER DELETE ON symptoms
  FOR EACH ROW
BEGIN
    INSERT INTO symptoms_audit VALUES
    (OLD.care_id, OLD.symptom_id, OLD.symptom_name,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS tests_after_delete//
CREATE TRIGGER tests_after_delete
  AFTER DELETE ON tests
  FOR EACH ROW
BEGIN
    INSERT INTO tests_audit VALUES
    (OLD.test_id, OLD.care_id, OLD.test_name, OLD.test_result,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS treatment_after_delete//
CREATE TRIGGER treatment_after_delete
  AFTER DELETE ON treatment_given
  FOR EACH ROW
BEGIN
    INSERT INTO treatment_given_audit VALUES
    (OLD.treatment_id, OLD.care_id, OLD.quantity, OLD.prescription_name, OLD.prescription_price, OLD.notes,
    'DELETED', NOW(), user());
END//

DROP TRIGGER IF EXISTS visit_after_delete//
CREATE TRIGGER visit_after_delete
  AFTER DELETE ON visit
  FOR EACH ROW
BEGIN
    INSERT INTO visit_audit VALUES
    (OLD.visit_id, OLD.patient_id, OLD.facility, OLD.time_in, OLD.time_out,
    'DELETED', NOW(), user());
END//

DELIMITER ;


# Creating Indexes
CREATE INDEX provider_info
ON provider (provider_name, provider_specialty);

CREATE INDEX insurance_info
ON patients (patient_name, insurance_id);

# Creating Views
CREATE VIEW ER_beds_VIEW AS
SELECT *
FROM ER_beds;

CREATE VIEW visit_information AS
SELECT diagnosis, patient_id, prescription_name, quantity, notes
FROM clinical_care JOIN treatment_given
	ON clinical_care.care_id = treatment_given.care_id;
    
# Creating triggers and stored procedures
# Trigger to automatically update if available to false when status becomes in use
DROP TRIGGER IF EXISTS update_bed_status;

DELIMITER //

CREATE TRIGGER update_bed_status
  BEFORE UPDATE ON ER_beds
  FOR EACH ROW
BEGIN
    IF NEW.bed_status = 'IN USE' THEN
		SET NEW.available = FALSE;
	END IF;
END//

DELIMITER ;

# Stored Procedure
DELIMITER // 
Create PROCEDURE insert_new_patient(IN p_id int, IN p_name varchar(20),IN p_Address Varchar(20), IN p_phone Varchar(20), IN p_insurance Varchar(20))
BEGIN
insert into patients(patient_id, patient_name, address, phone_number, insurance_id) 
values (p_id, p_name,p_address, p_phone, p_insurance);
END//

DELIMITER ;

SELECT *
FROM patients;

SELECT *
FROM patients_audit;