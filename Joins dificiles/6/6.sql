CREATE DATABASE delivery_comida;
USE delivery_comida;

CREATE TABLE RESTAURANTES (
    id_rest INT PRIMARY KEY,
    nombre VARCHAR(100),
    zona VARCHAR(100)
);

CREATE TABLE PLATOS (
    id_plato INT PRIMARY KEY,
    nombre_p VARCHAR(100),
    precio DECIMAL(10,2),
    id_rest INT,
    FOREIGN KEY (id_rest) REFERENCES RESTAURANTES(id_rest)
);

CREATE TABLE PEDIDOS (
    id_ped INT PRIMARY KEY,
    id_plato INT,
    cantidad INT,
    FOREIGN KEY (id_plato) REFERENCES PLATOS(id_plato)
);

-- CARGA DE DATOS

INSERT INTO RESTAURANTES VALUES
(1, 'Pizza Loca', 'Centro'),
(2, 'Burger House', 'Norte'),
(3, 'Pizza Max', 'Sur'),
(4, 'Sushi Time', 'Este'),
(5, 'Empanadas Ya', 'Oeste');

INSERT INTO PLATOS VALUES
(1, 'Pizza Muzza', 2500, 1),
(2, 'Hamburguesa Doble', 3200, 2),
(3, 'Pizza Especial', 4000, 3),
(4, 'Combo Sushi', 5500, 4),
(5, 'Empanadas Docena', 3000, 5);

INSERT INTO PEDIDOS VALUES
(1, 1, 50),
(2, 2, 20),
(3, 3, 60),
(4, 4, 15),
(5, 5, 40);

-- CONSULTAS

-- 1
SELECT r.nombre,
       SUM(p.cantidad) AS total_pedidos
FROM RESTAURANTES r
INNER JOIN PLATOS pl ON r.id_rest = pl.id_rest
INNER JOIN PEDIDOS p ON pl.id_plato = p.id_plato
GROUP BY r.nombre
HAVING COUNT(pl.id_plato) > 5
   AND SUM(pl.precio * p.cantidad) > 200;

-- 2
SELECT r.nombre,
       AVG(pl.precio * p.cantidad) AS promedio_ingresos
FROM RESTAURANTES r
INNER JOIN PLATOS pl ON r.id_rest = pl.id_rest
INNER JOIN PEDIDOS p ON pl.id_plato = p.id_plato
WHERE pl.precio > 1500
GROUP BY r.nombre;

-- 3
SELECT pl.nombre_p,
       r.nombre
FROM PLATOS pl
INNER JOIN RESTAURANTES r
ON pl.id_rest = r.id_rest
WHERE r.nombre LIKE '%Pizza%'
LIMIT 10;
