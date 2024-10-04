-- Formatos de querys tipicas

-- Crear tabla
CREATE TABLE IF NOT EXISTS nombre (
	col1 int PRIMARY KEY NOT NULL,
    col2 varchar(50),
    FOREIGN KEY (col2) REFERENCES tabla2(colN)
);

-- Agregar columna
ALTER TABLE nombre
ADD COLUMN nombre int default 0;

-- Actualizar valores por fila
UPDATE nombre_tabla
SET columna = valor
WHERE condicion;
-- O también, actualizando las filas de t1 que sobrevivan a la condición
UPDATE t1
INNER JOIN t2
ON condicion
SET t1.columna = valor
WHERE otra_condicion;

-- Agregar valores a una tabla
INSERT INTO tabla (col1, col2, col3)
VALUES (v1, v2, v3),
	   (v1b, v2b, v3b);
-- O tambien, agregar resultado de una query a una tabla
INSERT INTO tabla (col1, col2)
SELECT val1, val2 FROM tabla2
WHERE condicion;

-- Uso de GROUP BY y funciones de agregacion
-- Agrupar por ID permite seleccionar cualquier columna.
-- Agrupar por columnas no PK sólo permite seleccionar a esas.
-- Algunos ejemplos:
-- Si tabla1 tiene una relacion uno a varios con tabla2, 
-- y queremos saber cuántos de tabla2 hay por cada valor de tabla1, podemos hacer:
SELECT col1, count(*) as cantidadDeAlgo
FROM tabla1 INNER JOIN tabla2 ON condicion
GROUP BY id_tabla_1;

-- Si queremos buscar el máximo valor para algun conjunto de valores dependientes de un id:
SELECT col1, max(colName) AS maxValueOfSmth
FROM tabla1 INNER JOIN tabla2 ON condicion
GROUP BY id_tabla_1;

-- Vista
CREATE VIEW nombre_vista (nombreCol1, nombreCol2) AS
SELECT col1, col2
FROM tabla
WHERE condicion;

-- Función
DELIMITER //
CREATE FUNCTION nombre_funcion (
	arg1 int,
    arg2 varchar(50)
) returns int
READS SQL DATA
BEGIN
	DECLARE varname int default 0; -- variable local
    
    SELECT col1 INTO varname
    FROM tabla WHERE something LIMIT 1;
    
    IF (condicion) THEN
		set varname = valor;
	END IF;
	return varname;
END //

DELIMITER ;

-- Procedimiento
DELIMITER //
CREATE PROCEDURE nombre_proc (
	in arg1 int,
    in arg2 varchar(50)
) 
BEGIN
	DECLARE varname int default 0;
    
    SELECT col1 INTO varname
    FROM tabla WHERE something LIMIT 1;
    -- Se suele utilizar una variable para luego verificar si una condicion se cumple.
    IF (condicion) THEN
		INSERT INTO tabla VALUES (a, b, c);
	END IF;
	return varname;
END //

DELIMITER ;


-- Roles y permisos
CREATE ROLE rol;
CREATE ROLE rol2;
GRANT UPDATE (colN), DELETE ON tabla TO rol;
GRANT rol2 TO rol;
SHOW GRANTS FOR rol;

-- Extras
/*
LEFT JOIN -> PUEDE DEJAR NULOS DEL LADO DERECHO (a, b, c, NULL, NULL, NULL) si no encuentra match.
INNER JOIN -> NO DEJA NULOS
SELECT id, data INTO @x, @y FROM tabla LIMIT 1; -> User-defined variables

DECIMAL(M,D) indica M digitos en total de los cuales habrá hasta D después de la coma y hasta M-D en la parte entera.
*/




