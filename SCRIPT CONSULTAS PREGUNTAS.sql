-- SCRIPT DE CONSULTAS
USE esports;

-- 1. Equipos con más victorias
EXPLAIN
SELECT 
    e.descripcion AS Equipo,
    SUM(sec.victorias) AS Total_Victorias,
    SUM(sec.derrotas) AS Total_Derrotas
FROM estadisticas_equipo_competencia sec
JOIN equipos e ON sec.id_equipo = e.id_equipo
GROUP BY e.id_equipo
ORDER BY Total_Victorias DESC;

CREATE INDEX idx_sec_equipo_victorias_derrotas
ON estadisticas_equipo_competencia (id_equipo, victorias, derrotas);

-- Otra forma de hacer la búsqueda para optimizar, tomando el group by de la tabla sec
EXPLAIN
SELECT 
    e.descripcion AS Equipo,
    SUM(sec.victorias) AS Total_Victorias,
    SUM(sec.derrotas) AS Total_Derrotas
FROM estadisticas_equipo_competencia sec
JOIN equipos e ON sec.id_equipo = e.id_equipo
GROUP BY sec.id_equipo
ORDER BY Total_Victorias DESC;


-- 2. Jugador con mayor promedio de victorias (Basado en el KDA)
EXPLAIN
SELECT sjk.id_competencia,
    j.nombre_jugador, Round((sjk.kills+sjk.Assists) / (sjk.deaths),2) as KDA
FROM jugadores j
JOIN estadisticas_jugador_competencia sjk ON j.id_jugador = sjk.id_jugador
Where sjk.id_competencia = 1
Group by j.id_jugador, j.nombre_jugador
Order by KDA DESC;

CREATE INDEX idx_sjk_competencia_jugador 
ON estadisticas_jugador_competencia (id_competencia, id_jugador, kills, assists, deaths);

-- 2. Otra forma (Basado en las kills)
EXPLAIN
SELECT 
    j.nombre_jugador,
    SUM(sjk.kills) AS Total_Kills,
    SUM(sjk.assists) AS Total_Assists,
    SUM(sjk.deaths) AS Total_Deaths
FROM jugadores j
JOIN estadisticas_jugador_competencia sjk ON j.id_jugador = sjk.id_jugador
GROUP BY j.id_jugador
ORDER BY Total_Kills DESC
LIMIT 1;

CREATE INDEX idx_sjk_jugador_kad 
ON estadisticas_jugador_competencia (id_jugador, kills, assists, deaths);

-- 3. Competencias con mayor participación de equipos
EXPLAIN
SELECT 
    c.nombre AS Competencia,
    COUNT(DISTINCT r.id_equipo) AS Total_Equipos
FROM competencias c
JOIN roster r ON c.id_competencia = r.id_competencia
GROUP BY c.id_competencia
ORDER BY Total_Equipos DESC;

CREATE INDEX idx_roster_id_competencia ON roster(id_competencia);