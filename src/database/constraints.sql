ALTER TABLE employee ADD CONSTRAINT fk_employee_gender
FOREIGN KEY(id_gender) REFERENCES gender(id_gender)


ALTER TABLE employee ADD CONSTRAINT fk_employee_civil_state
FOREIGN KEY (id_civil_state) REFERENCES civil_state(id_civil_state)


ALTER TABLE employee ADD CONSTRAINT fk_employee_departament
FOREIGN KEY (id_departament) REFERENCES departament(id_departament)

ALTER TABLE employee ADD CONSTRAINT fk_employee_payroll
FOREIGN KEY (id_payroll) REFERENCES payroll(id_payroll)

ALTER TABLE employee ADD CONSTRAINT fk_employee_job_place
FOREIGN KEY (id_job_place) REFERENCES job_place(id_job_place)


--RETURN EMPLOYEES
select name_employee, lastname, phone_number, date_of_birth, place_of_birth, contract_date_from,
contract_date_to, salary, gg.gender_name, cc.name_civil_state, dd.departament_name, pp.payroll_name, jj.job_place_name
from employee ee inner join gender gg on ee.id_gender = gg.id_gender
inner join civil_state cc on ee.id_civil_state = cc.id_civil_state
inner join departament dd on ee.id_departament = dd.id_departament
inner join payroll pp on ee.id_payroll = pp.id_payroll
inner join job_place jj on ee.id_job_place = jj.id_job_place


-- FUNCTION RETURN EMPLOYEES TABLES


CREATE OR REPLACE FUNCTION get_employees () 
    RETURNS TABLE (
        name_employee VARCHAR,
        lastname VARCHAR,
		phone_number VARCHAR,
		date_of_birth TEXT,
		place_of_birth VARCHAR,
		contract_date_from TEXT,
		contract_date_to TEXT,
		salary NUMERIC,
		gender VARCHAR,
		civil_state VARCHAR,
		departament_name VARCHAR,
		payroll VARCHAR,
		job_place VARCHAR
		
	) 
AS $$
BEGIN
    RETURN QUERY (SELECT ee.name_employee, ee.lastname, ee.phone_number, to_char(ee.date_of_birth, 'DD/MM/YYYY'), ee.place_of_birth, to_char(ee.contract_date_from, 'DD/MM/YYYY'),
to_char(ee.contract_date_to, 'DD/MM/YYYY'), ee.salary, gg.gender_name, cc.name_civil_state, dd.departament_name, pp.payroll_name, jj.job_place_name
from employee ee inner join gender gg on ee.id_gender = gg.id_gender
inner join civil_state cc on ee.id_civil_state = cc.id_civil_state
inner join departament dd on ee.id_departament = dd.id_departament
inner join payroll pp on ee.id_payroll = pp.id_payroll
inner join job_place jj on ee.id_job_place = jj.id_job_place);
END; $$ 

LANGUAGE 'plpgsql';
DROP FUNCTION get_employees()
 select * from get_employees()




---------------------------- Update employees procedure ----------------------------
CREATE PROCEDURE update_employee(	_name_employee VARCHAR,
								  	_lastname VARCHAR,
									_phone_number VARCHAR,
									_departament INT,
									_payroll INT,
									_job_place INT,
									_id_employee INT)
LANGUAGE SQL
AS $$
	
UPDATE employee SET name_employee = _name_employee, 
					lastname = _lastname, 
					phone_number = _phone_number, 
					id_departament = _departament, 
					id_payroll = _payroll, 
					id_job_place = _job_place 
					WHERE id_employee = _id_employee

$$


CALL update_employee('Updated Name', 'Updated Last name', '7878', 1,1,1,1);



---------------get employee by id function u
CREATE OR REPLACE FUNCTION get_employee_by_id (_lastname VARCHAR) 
    RETURNS TABLE (
		id_employee INT,
        name_employee VARCHAR,
        lastname VARCHAR,
		phone_number VARCHAR,
		date_of_birth TEXT,
		place_of_birth VARCHAR,
		contract_date_from TEXT,
		contract_date_to TEXT,
		salary NUMERIC,
		gender VARCHAR,
		civil_state VARCHAR,
		departament_name VARCHAR,
		payroll VARCHAR,
		job_place VARCHAR
		
	) 
	
AS $$
BEGIN
    RETURN QUERY (SELECT ee.id_employee, ee.name_employee, ee.lastname, ee.phone_number, to_char(ee.date_of_birth, 'DD/MM/YYYY'), ee.place_of_birth, to_char(ee.contract_date_from, 'DD/MM/YYYY'),
to_char(ee.contract_date_to, 'DD/MM/YYYY'), ee.salary, gg.gender_name, cc.name_civil_state, dd.departament_name, pp.payroll_name, jj.job_place_name
from employee ee inner join gender gg on ee.id_gender = gg.id_gender
inner join civil_state cc on ee.id_civil_state = cc.id_civil_state
inner join departament dd on ee.id_departament = dd.id_departament
inner join payroll pp on ee.id_payroll = pp.id_payroll
inner join job_place jj on ee.id_job_place = jj.id_job_place where ee.id_employee = (select ee.id_employee where ee.lastname = _lastname));
END; $$ 

LANGUAGE 'plpgsql';

drop FUNCTION get_employee_by_id(character varying)

SELECT * FROM get_employee_by_id('Martinez actu');




-----------delete employee procedure
CREATE PROCEDURE delete_employee(_lastname VARCHAR)
LANGUAGE SQL
AS $$
	
DELETE FROM employee WHERE id_employee = (SELECT id_employee WHERE lastname = _lastname)

$$


CALL delete_employee('apellido');


