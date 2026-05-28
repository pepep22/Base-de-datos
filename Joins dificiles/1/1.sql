

CREATE DATABASE vuelos_db;
USE vuelos_db;

CREATE TABLE AVIONES (
    id_avion INT PRIMARY KEY,
    modelo VARCHAR(50),
    capacidad INT
);

CREATE TABLE VUELOS (
    nro_vuelo INT PRIMARY KEY,
    origen VARCHAR(50),
    destino VARCHAR(50),
    id_avion INT,
    FOREIGN KEY (id_avion) REFERENCES AVIONES(id_avion)
);

CREATE TABLE PASAJEROS_VUELO (
    id_ticket INT PRIMARY KEY,
    nro_vuelo INT,
    precio_ticket DECIMAL(10,2),
    dni_pasajero VARCHAR(20),
    FOREIGN KEY (nro_vuelo) REFERENCES VUELOS(nro_vuelo)
);

INSERT INTO AVIONES VALUES
(1,'Boeing 737',180),
(2,'Airbus A320',200),
(3,'Boeing 747',400),
(4,'Embraer 190',100),
(5,'Airbus A380',500);

INSERT INTO VUELOS VALUES
(101,'EZEIZA','CORDOBA',1),
(102,'EZEIZA','MENDOZA',2),
(103,'ROSARIO','SALTA',3),
(104,'EZEIZA','BARILOCHE',1),
(105,'USHUAIA','EZEIZA',5);

INSERT INTO PASAJEROS_VUELO VALUES
(1,101,600000,'40111222'),
(2,101,700000,'40222333'),
(3,102,800000,'40333444'),
(4,103,900000,'40444555'),
(5,104,1000000,'40555666');

-- CONSULTAS

SELECT A.modelo, SUM(P.precio_ticket) AS total_recaudado
FROM AVIONES A
INNER JOIN VUELOS V ON A.id_avion = V.id_avion
INNER JOIN PASAJEROS_VUELO P ON V.nro_vuelo = P.nro_vuelo
GROUP BY A.modelo
HAVING total_recaudado > 2000000;

SELECT V.nro_vuelo, AVG(P.precio_ticket) AS promedio_ticket
FROM VUELOS V
INNER JOIN PASAJEROS_VUELO P ON V.nro_vuelo = P.nro_vuelo
WHERE V.origen = 'EZEIZA'
GROUP BY V.nro_vuelo
HAVING promedio_ticket > 500;

SELECT A.modelo, COUNT(V.nro_vuelo) AS cantidad_vuelos
FROM AVIONES A
INNER JOIN VUELOS V ON A.id_avion = V.id_avion
GROUP BY A.modelo
HAVING cantidad_vuelos > 50;
