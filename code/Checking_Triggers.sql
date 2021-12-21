# Performing queries to ensure triggers work properly

SELECT * FROM er_db.er_beds_view;

UPDATE ER_beds
SET available = TRUE, bed_status = 'Sanitized'
WHERE bed_number = 5;

SELECT * FROM er_db.er_beds_view;

#Trigger to update available
UPDATE ER_beds
SET bed_status = 'in use'
WHERE bed_number = 5;

UPDATE treatment_given
SET notes = "quantity changed again", quantity = 40
WHERE treatment_id = 987;

SELECT *
FROM treatment_given;

SELECT *
FROM treatment_given_audit;

# Update vs view for treatment table

UPDATE treatment_given
SET note = "quantity changed", quantity = 15
WHERE treatment_id = 346;


#Viewing View(visit information)
SELECT * FROM er_db.visit_information;