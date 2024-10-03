CREATE TABLE IF NOT EXISTS usuarios (
	name varchar(50),
    email varchar(100),
    password varchar(100),
    uid integer PRIMARY KEY
    );
    
CREATE TABLE IF NOT EXISTS clientes (
	client_id integer PRIMARY KEY,
	FOREIGN KEY (client_id) REFERENCES usuarios(uid),
    plan_type varchar(1),
    username varchar(50),
    gender bit,
    phone_number char(50)
);

CREATE TABLE IF NOT EXISTS roles (
	empleado_id integer,
    rol varchar(50)
);

CREATE TABLE IF NOT EXISTS empleados (
	emp_id integer PRIMARY KEY,
    FOREIGN KEY (emp_id) REFERENCES usuarios(uid),
    FOREIGN KEY (emp_id) REFERENCES roles(empleado_id)
);