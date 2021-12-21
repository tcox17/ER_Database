# This code houses the rest of my queries for Database exploration

# Get the number of  beds in the ER that are available
SELECT available AS 'Bed Available?', COUNT(available) AS count
FROM ER_beds
#WHERE available = TRUE
GROUP BY available;

# Bills sent to patient 1
SELECT *
FROM billing
WHERE patient_id = 001;

# Change of address for Patient John Doe
UPDATE patients
SET patient_name = 'New Name'
WHERE patient_id = 1;

SELECT *
FROM patients;

# Updating supplies quantity
SELECT *
FROM supplies;

UPDATE supplies
SET quantity = quantity - 45
WHERE name_of_material = 'Guaze';

# Return patient ID, tests, test results, and diagnosis for patients who came in to get a Covid Test in the last 2 weeks
SELECT patient_id, test_name, test_result, diagnosis
FROM clinical_care ca
  JOIN tests t
   ON ca.care_id = t.care_id
WHERE date_of_visit BETWEEN '2020-10-30' AND CURDATE()
HAVING test_name LIKE 'COVID%';

# Return information insurance may need
SELECT patient_name, insurance_id, provider_name, provider_specialty, date_of_visit
FROM patients
	JOIN clinical_care
		ON clinical_care.patient_id = patients.patient_id
	JOIN provider
		ON provider.employee_id = clinical_care.employee_id;
        
# Return Dr. Name for patient with infection from surgery
SELECT patient_name, provider_name, provider_specialty, date_of_visit, procedure_result, exam_name
FROM patients
	JOIN clinical_care
		ON clinical_care.patient_id = patients.patient_id
	JOIN provider
		ON provider.employee_id = clinical_care.employee_id
	JOIN procedures
		ON clinical_care.care_id = procedures.care_id
	JOIN exams
		ON clinical_care.care_id = exams.care_id
	WHERE procedure_result = 'Infection';


