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
