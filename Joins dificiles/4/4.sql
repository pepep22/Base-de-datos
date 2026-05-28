CREATE DATABASE consorcio_db;
USE consorcio_db;

CREATE TABLE EDIFICIOS (
    id_edif INT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

CREATE TABLE UNIDADES (
    id_unidad INT PRIMARY KEY,
    nro_piso INT,
    id_edif INT,
    FOREIGN KEY (id_edif) REFERENCES EDIFICIOS(id_edif)
);

CREATE TABLE EXPENSAS (
    id_exp INT PRIMARY KEY,
    id_unidad INT,
    monto DECIMAL(10,2),
    estado VARCHAR(20),
    FOREIGN KEY (id_unidad) REFERENCES UNIDADES(id_unidad)
);

INSERT INTO EDIFICIOS VALUES
(1,'Torre Norte','Av Siempre Viva 123'),
(2,'Torre Sur','Calle Falsa 456'),
(3,'Edificio Sol','Mitre 789'),
(4,'Edificio Luna','Belgrano 321'),
(5,'Altos del Centro','Rivadavia 654');

INSERT INTO UNIDADES VALUES
(1,1,1),
(2,2,1),
(3,3,2),
(4,4,3),
(5,5,4);

INSERT INTO EXPENSAS VALUES
(1,1,50000,'Pago'),
(2,2,70000,'Impago'),
(3,3,90000,'Impago'),
(4,4,40000,'Pago'),
(5,5,120000,'Impago');

-- CONSULTAS

SELECT E.nombre, SUM(EX.monto) AS deuda_total
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unidad = EX.id_unidad
WHERE EX.estado = 'Impago'
GROUP BY E.nombre
HAVING deuda_total > 1000000;

SELECT E.nombre, AVG(EX.monto) AS promedio_expensas
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unidad = EX.id_unidad
WHERE EX.estado = 'Pago'
GROUP BY E.nombre
HAVING promedio_expensas > 20000;

SELECT E.nombre, SUM(EX.monto) AS recaudacion
FROM EDIFICIOS E
INNER JOIN UNIDADES U ON E.id_edif = U.id_edif
INNER JOIN EXPENSAS EX ON U.id_unidad = EX.id_unidad
WHERE EX.estado = 'Pago'
GROUP BY E.nombre
ORDER BY recaudacion DESC
LIMIT 3;
