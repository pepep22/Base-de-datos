CREATE DATABASE streaming_musica;
USE streaming_musica;

CREATE TABLE ARTISTAS (
    id_art INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE ALBUMES (
    id_alb INT PRIMARY KEY,
    titulo VARCHAR(100),
    id_art INT,
    FOREIGN KEY (id_art) REFERENCES ARTISTAS(id_art)
);

CREATE TABLE REPRODUCCIONES (
    id_rep INT PRIMARY KEY,
    id_alb INT,
    cant_repro INT,
    FOREIGN KEY (id_alb) REFERENCES ALBUMES(id_alb)
);

-- CARGA DE DATOS

INSERT INTO ARTISTAS VALUES
(1, 'Duki'),
(2, 'Bad Bunny'),
(3, 'Taylor Swift'),
(4, 'Drake'),
(5, 'Trueno');

INSERT INTO ALBUMES VALUES
(1, 'Desde el Fin del Mundo', 1),
(2, 'Un Verano Sin Ti', 2),
(3, '1989', 3),
(4, 'Scorpion', 4),
(5, 'Bien o Mal', 5);

INSERT INTO REPRODUCCIONES VALUES
(1, 1, 600000),
(2, 2, 2000000),
(3, 3, 800000),
(4, 4, 1200000),
(5, 5, 300000);

-- CONSULTAS

-- 1
SELECT a.nombre,
       SUM(r.cant_repro) AS total_reproducciones
FROM ARTISTAS a
INNER JOIN ALBUMES al ON a.id_art = al.id_art
INNER JOIN REPRODUCCIONES r ON al.id_alb = r.id_alb
GROUP BY a.nombre
HAVING COUNT(al.id_alb) > 3
   AND SUM(r.cant_repro) > 1000000;

-- 2
SELECT al.titulo,
       a.nombre,
       AVG(r.cant_repro) AS promedio_reproduccion
FROM ALBUMES al
INNER JOIN ARTISTAS a ON al.id_art = a.id_art
INNER JOIN REPRODUCCIONES r ON al.id_alb = r.id_alb
GROUP BY al.titulo, a.nombre
HAVING AVG(r.cant_repro) > 50000;

-- 3
SELECT a.nombre,
       SUM(r.cant_repro) AS total_reproducciones
FROM ARTISTAS a
INNER JOIN ALBUMES al ON a.id_art = al.id_art
INNER JOIN REPRODUCCIONES r ON al.id_alb = r.id_alb
GROUP BY a.nombre
HAVING SUM(r.cant_repro) = (
    SELECT MIN(total)
    FROM (
        SELECT SUM(r2.cant_repro) AS total
        FROM ARTISTAS a2
        INNER JOIN ALBUMES al2 ON a2.id_art = al2.id_art
        INNER JOIN REPRODUCCIONES r2 ON al2.id_alb = r2.id_alb
        GROUP BY a2.nombre
    ) AS subconsulta
);
