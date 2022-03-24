CREATE TABLE IF NOT EXISTS employee(
	id_employee SERIAL PRIMARY KEY,
	name_employee VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	date_of_birth date NOT NULL,
	place_of_birth VARCHAR(50) NOT NULL,
	contract_date_from date NOT NULL,
	contract_date_to date NOT NULL,
	salary DECIMAL NOT NULL,
	id_gender INT NOT NULL,
	id_civil_state INT NOT NULL,
	id_departament INT NOT NULL,
	id_payroll INT NOT NULL,
	id_job_place INT NOT NULL
);

CREATE TABLE IF NOT EXISTS users(
	id_user SERIAL PRIMARY KEY,
	u_email VARCHAR(100) NOT NULL,
	u_password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS gender(
	id_gender SERIAL PRIMARY KEY,
	gender_name VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS civil_state(
	id_civil_state SERIAL PRIMARY KEY NOT NULL,
	name_civil_state VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS roles(
	id_rol SERIAL PRIMARY KEY,
	rol_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS departament(
	id_departament SERIAL PRIMARY KEY,
	departament_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS payroll(
	id_payroll SERIAL PRIMARY KEY,
	payroll_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS job_place(
	id_job_place SERIAL PRIMARY KEY,
	job_place_name VARCHAR(50) NOT NULL
);