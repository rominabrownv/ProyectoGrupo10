-- GRUPO 10 BASE DE DATOS DE ESPORTS
CREATE DATABASE esports;
USE esports;

-- ====================================
-- TABLA JUGADORES
-- ====================================
CREATE TABLE jugadores (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_jugador VARCHAR(100) NOT NULL,
    edad INT Check(edad >=18) NOT NULL
);

-- ====================================
-- TABLA ROLES
-- ====================================
CREATE TABLE roles (
    id_rol CHAR(3) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- ====================================
-- TABLA EQUIPOS
-- ====================================
CREATE TABLE equipos (
    id_equipo CHAR(5) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);

-- ====================================
-- TABLA UBICACIONES
-- ====================================
CREATE TABLE ubicacion (
    id_ubicacion CHAR(2) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);

-- ====================================
-- TABLA COMPETENCIAS
-- ====================================
CREATE TABLE competencias (
    id_competencia INT Auto_increment PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    premio DECIMAL(15,2) Unsigned NOT NULL,
    id_ubicacion CHAR(2) NOT NULL,
    Constraint fecha_valida Check (fecha_fin >= fecha_inicio),
    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_ubicacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ====================================
-- TABLA ESTADISTICAS JUGADOR POR COMPETENCIA
-- ====================================
CREATE TABLE estadisticas_jugador_competencia (
    id_jugador INT NOT NULL,
    id_competencia INT NOT NULL,
    kills INT Unsigned DEFAULT 0,
    deaths INT Unsigned DEFAULT 0,
    assists INT Unsigned DEFAULT 0,
    PRIMARY KEY (id_jugador, id_competencia),
    FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia) REFERENCES competencias(id_competencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ====================================
-- TABLA ESTADISTICAS EQUIPO POR COMPETENCIA
-- ====================================
CREATE TABLE estadisticas_equipo_competencia (
    id_equipo CHAR(5) NOT NULL,
    id_competencia INT NOT NULL,
    victorias INT UNSIGNED NOT NULL,
    derrotas INT UNSIGNED NOT NULL,
	PRIMARY KEY (id_equipo, id_competencia),
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia) REFERENCES competencias(id_competencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
-- ====================================
-- TABLA ROSTER
-- ====================================
CREATE TABLE roster (
    id_roster INT  Auto_increment PRIMARY KEY,
    id_equipo CHAR(5) NOT NULL,
    id_competencia INT NOT NULL,
    Constraint unq_equipo_competencia Unique (id_equipo, id_competencia),
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia) REFERENCES competencias(id_competencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ====================================
-- TABLA JUGADORES_ROSTER
-- ====================================
CREATE TABLE jugadores_roster (
    id_roster INT NOT NULL,
    id_jugador INT NOT NULL,
    id_rol CHAR(3) NOT NULL,
    es_titular Boolean Default False,
    PRIMARY KEY (id_roster, id_jugador),
    FOREIGN KEY (id_roster) REFERENCES roster(id_roster)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- INSERT CON DATOS DE EJEMPLO ----------------------------------------------------------------------------
-- ====================================

INSERT INTO ubicacion (id_ubicacion, descripcion) VALUES
('Co', 'Copenhague'),
('Lo', 'Londres');

INSERT INTO equipos (id_equipo, descripcion) VALUES
('T1', 'Team Spirit'),
('T2', 'Equipo T1'),
('T3', 'G2 Esports');

INSERT INTO roles (id_rol, descripcion) VALUES
('ADC', 'Adcarry'),
('M', 'Midlaner'),
('S', 'Support'),
('JG', 'Jungler'),
('T', 'Toplaner');


INSERT INTO jugadores (id_jugador, nombre_jugador, edad) VALUES
(1, 'Dreampull', 20),
(2, 'Diamondprox', 22),
(3, 'Griffon', 30),
(4, 'Mytant', 27),
(5, 'Edward', 32),
(6, 'Zeus', 28),
(7, 'Oner', 29),
(8, 'Faker', 28),
(9, 'Gumayusi', 30),
(10, 'Keria', 31),
(11, 'Wunder', 30),
(12, 'Jankos', 27),
(13, 'Caps', 37),
(14, 'Flakked', 25),
(15, 'Targamas', 28);

INSERT INTO competencias (id_competencia, nombre, fecha_inicio, fecha_fin, premio, id_ubicacion) VALUES
(101, 'TI 2024', '2024-10-12', '2024-10-20', 32500000.00, 'Co'),
(102, 'Worlds 2024', '2024-11-20', '2024-12-02', 22250000.00, 'Lo');

INSERT INTO estadisticas_jugador_competencia (id_jugador, id_competencia, kills, deaths, assists) VALUES
(1, 101, 4, 6, 5),
(2, 101, 3, 5, 10),
(3, 101, 4, 6, 5),
(4, 101, 6, 4, 4),
(5, 101, 1, 6, 8),
(6, 101, 6, 3, 4),
(7, 101, 7, 4, 15),
(8, 101, 10, 2, 9),
(9, 101, 8, 3, 7),
(10, 101, 2, 5, 17),
(6, 102, 4, 3, 5),
(7, 102, 2, 2, 12),
(8, 102, 7, 1, 10),
(9, 102, 8, 2, 6),
(10, 102, 1, 4, 15),
(11, 102, 3, 5, 2),
(12, 102, 2, 6, 5),
(13, 102, 5, 4, 4),
(14, 102, 6, 3, 3),
(15, 102, 0, 5, 7);

INSERT INTO estadisticas_equipo_competencia (id_equipo, id_competencia, victorias, derrotas) 
VALUES
('T1', 101, 0, 1),
('T2', 101, 1, 0),
('T3', 102, 0, 1),
('T2', 102, 1, 0);

Show create table estadisticas_equipo_competencia;
Select id_equipo, length(id_equipo) from equipos;
Select * From equipos where id_equipo In ('T1', 'T2', 'T3');
Select * from competencias;
Describe competencias;

INSERT INTO roster (id_roster, id_equipo, id_competencia) VALUES
(1000, 'T1', 101),
(1001, 'T2', 101),
(1002, 'T3', 102),
(1003, 'T2', 102);

INSERT INTO jugadores_roster (id_roster, id_jugador, id_rol, es_titular) VALUES
(1000, 1, 'T', 1),
(1000, 2, 'JG', 1),
(1000, 3, 'M', 1),
(1000, 4, 'ADC', 1),
(1000, 5, 'S', 1),
(1001, 6, 'T', 1),
(1001, 7, 'JG', 1),
(1001, 8, 'M', 1),
(1001, 9, 'ADC', 1),
(1001, 10, 'S', 1),
(1002, 11, 'T', 1),
(1002, 12, 'JG', 1),
(1002, 13, 'M', 1),
(1002, 14, 'ADC', 1),
(1002, 15, 'S', 1),
(1003, 6, 'T', 1),
(1003, 7, 'JG', 1),
(1003, 8, 'M', 1),
(1003, 9, 'ADC', 1),
(1003, 10, 'S', 1);



