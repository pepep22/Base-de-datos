CREATE DATABASE gimnasio_db;
USE gimnasio_db;

CREATE TABLE SOCIOS (
    id_socio INT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_alta DATE
);

CREATE TABLE PLANES (
    id_plan INT PRIMARY KEY,
    tipo VARCHAR(50),
    costo DECIMAL(10,2)
);

CREATE TABLE PAGOS (
    id_pago INT PRIMARY KEY,
    id_socio INT,
    id_plan INT,
    monto DECIMAL(10,2),
    fecha DATE,
    FOREIGN KEY (id_socio) REFERENCES SOCIOS(id_socio),
    FOREIGN KEY (id_plan) REFERENCES PLANES(id_plan)
);

INSERT INTO SOCIOS VALUES
(1,'Juan','2025-01-10'),
(2,'Ana','2025-02-15'),
(3,'Lucas','2025-03-12'),
(4,'Maria','2025-04-08'),
(5,'Pedro','2025-05-01');

INSERT INTO PLANES VALUES
(1,'Basico',10000),
(2,'Premium',25000),
(3,'VIP',40000),
(4,'Mensual',15000),
(5,'Anual',80000);

INSERT INTO PAGOS VALUES
(1,1,2,30000,'2025-05-01'),
(2,2,1,10000,'2025-05-02'),
(3,3,2,26000,'2025-05-03'),
(4,4,3,45000,'2025-05-04'),
(5,5,2,27000,'2025-05-05');

-- CONSULTAS

SELECT S.nombre, COUNT(P.id_pago) AS cantidad_pagos
FROM SOCIOS S
INNER JOIN PAGOS P ON S.id_socio = P.id_socio
INNER JOIN PLANES PL ON P.id_plan = PL.id_plan
WHERE PL.tipo = 'Premium'
GROUP BY S.nombre
HAVING SUM(P.monto) > PL.costo;

SELECT PL.tipo, SUM(P.monto) AS ingreso_total
FROM PLANES PL
INNER JOIN PAGOS P ON PL.id_plan = P.id_plan
GROUP BY PL.tipo
HAVING ingreso_total > 100000;

SELECT S.nombre, COUNT(P.id_pago) AS pagos_mismo_plan
FROM SOCIOS S
INNER JOIN PAGOS P ON S.id_socio = P.id_socio
GROUP BY S.nombre, P.id_plan
HAVING pagos_mismo_plan > 3;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE CATEGORIAS (
    id_cat INT PRIMARY KEY,
    nombre_cat VARCHAR(50)
);

CREATE TABLE PRODUCTOS (
    id_prod INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),
    id_cat INT,
    FOREIGN KEY (id_cat) REFERENCES CATEGORIAS(id_cat)
);

CREATE TABLE DETALLE_VENTA (
    id_detalle INT PRIMARY KEY,
    id_prod INT,
    cantidad INT,
    precio_unit DECIMAL(10,2),
    FOREIGN KEY (id_prod) REFERENCES PRODUCTOS(id_prod)
);

INSERT INTO CATEGORIAS VALUES
(1,'Celulares'),
(2,'Notebooks'),
(3,'Auriculares'),
(4,'Monitores'),
(5,'Teclados');

INSERT INTO PRODUCTOS VALUES
(1,'Samsung A54',250000,1),
(2,'Lenovo i5',700000,2),
(3,'Redragon Zeus',50000,3),
(4,'LG 24',180000,4),
(5,'HyperX Alloy',90000,5);

INSERT INTO DETALLE_VENTA VALUES
(1,1,100,250000),
(2,2,50,700000),
(3,3,200,50000),
(4,4,80,180000),
(5,5,120,90000);

-- CONSULTAS

SELECT C.nombre_cat, P.nombre, SUM(D.cantidad) AS total_vendido
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
GROUP BY C.nombre_cat, P.nombre
HAVING total_vendido > 500;

SELECT C.nombre_cat, AVG(P.precio) AS promedio_precio
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
GROUP BY C.nombre_cat
HAVING promedio_precio > 1500;

SELECT C.nombre_cat, SUM(D.cantidad * D.precio_unit) AS total_ventas
FROM CATEGORIAS C
INNER JOIN PRODUCTOS P ON C.id_cat = P.id_cat
INNER JOIN DETALLE_VENTA D ON P.id_prod = D.id_prod
WHERE P.precio < 100
GROUP BY C.nombre_cat
HAVING total_ventas < 5000;
