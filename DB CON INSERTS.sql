-- ==========================================
-- DROP DATABASE IF EXISTS
-- ==========================================
DROP DATABASE IF EXISTS esports;
CREATE DATABASE esports;
USE esports;

-- ==========================================
-- TABLA JUGADORES
-- ==========================================
CREATE TABLE jugadores (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_jugador VARCHAR(100) NOT NULL,
    edad INT CHECK(edad >= 18) NOT NULL
);

-- ==========================================
-- TABLA ROLES
-- ==========================================
CREATE TABLE roles (
    id_rol CHAR(3) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE
);

-- ==========================================
-- TABLA EQUIPOS
-- ==========================================
CREATE TABLE equipos (
    id_equipo CHAR(5) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================
-- TABLA UBICACION
-- ==========================================
CREATE TABLE ubicacion (
    id_ubicacion CHAR(2) PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================
-- TABLA COMPETENCIAS
-- ==========================================
CREATE TABLE competencias (
    id_competencia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    premio DECIMAL(15,2) UNSIGNED NOT NULL,
    id_ubicacion CHAR(2) NOT NULL,
    CONSTRAINT fecha_valida CHECK (fecha_fin >= fecha_inicio),
    FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_ubicacion)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLA ESTADISTICAS JUGADOR POR COMPETENCIA
-- ==========================================
CREATE TABLE estadisticas_jugador_competencia (
    id_jugador INT NOT NULL,
    id_competencia INT NOT NULL,
    kills INT UNSIGNED DEFAULT 0,
    deaths INT UNSIGNED DEFAULT 0,
    assists INT UNSIGNED DEFAULT 0,
    PRIMARY KEY (id_jugador, id_competencia),
    FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia) REFERENCES competencias(id_competencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLA ESTADISTICAS EQUIPO POR COMPETENCIA
-- ==========================================
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

-- ==========================================
-- TABLA ROSTER
-- ==========================================
CREATE TABLE roster (
    id_roster INT AUTO_INCREMENT PRIMARY KEY,
    id_equipo CHAR(5) NOT NULL,
    id_competencia INT NOT NULL,
    CONSTRAINT unq_equipo_competencia UNIQUE (id_equipo, id_competencia),
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_competencia) REFERENCES competencias(id_competencia)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLA JUGADORES_ROSTER
-- ==========================================
CREATE TABLE jugadores_roster (
    id_roster INT NOT NULL,
    id_jugador INT NOT NULL,
    id_rol CHAR(3) NOT NULL,
    es_titular BOOLEAN DEFAULT FALSE,
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

-- ==========================================
-- INSERTS UBICACIONES
-- ==========================================
INSERT INTO ubicacion (id_ubicacion, descripcion) VALUES
('CO', 'Copenhague'),
('LO', 'Londres'),
('NY', 'Nueva York'),
('TK', 'Tokio'),
('SG', 'Singapur');

-- ==========================================
-- INSERTS EQUIPOS
-- ==========================================
INSERT INTO equipos (id_equipo, descripcion) VALUES
('T1', 'Team Spirit'),
('T2', 'G2 Esports'),
('T3', 'Fnatic'),
('T4', 'Cloud9'),
('T5', 'DRX'),
('T6', 'Evil Geniuses'),
('T7', 'T1 Academy'),
('T8', 'Team Liquid'),
('T9', 'Ninjas in Pyjamas'),
('T10','100 Thieves');

-- ==========================================
-- INSERTS ROLES
-- ==========================================
INSERT INTO roles (id_rol, descripcion) VALUES
('ADC', 'Adcarry'),
('MID', 'Midlaner'),
('SUP', 'Support'),
('JG', 'Jungler'),
('TOP', 'Toplaner');

-- ==========================================
-- INSERTS JUGADORES
-- ==========================================
INSERT INTO jugadores (nombre_jugador, edad) VALUES
('Faker', 28), ('Caps', 26), ('Rekkles', 25), ('Perkz', 27), ('Bjergsen', 28),
('Uzi', 30), ('Doinb', 29), ('ShowMaker', 24), ('Nisqy', 25), ('Ming', 27),
('CoreJJ', 28), ('Tian', 26), ('Oner', 23), ('Clid', 27), ('Khan', 28),
('Bwipo', 24), ('Jensen', 29), ('Hylissang', 26), ('Santorin', 27), ('Zven', 28),
('Viper', 23), ('Lwx', 22), ('Rookie', 27), ('Knight', 25), ('Fudge', 24),
('JackeyLove', 28), ('Canyon', 26), ('ShowGun', 27), ('Gala', 24), ('BeryL', 25);

-- ==========================================
-- INSERTS COMPETENCIAS
-- ==========================================
INSERT INTO competencias (nombre, fecha_inicio, fecha_fin, premio, id_ubicacion) VALUES
('TI 2024', '2024-10-12', '2024-10-22', 32500000, 'CO'),
('Worlds 2024', '2024-11-20', '2024-12-02', 22250000, 'LO'),
('MSI 2024', '2024-06-15', '2024-06-25', 15000000, 'NY'),
('LCK Spring 2024', '2024-02-01', '2024-03-15', 8000000, 'TK'),
('LEC Summer 2024', '2024-07-01', '2024-08-10', 9000000, 'SG');

-- ==========================================
-- INSERTS ROSTER
-- ==========================================
INSERT INTO roster (id_equipo, id_competencia) VALUES
('T1', 1), ('T2',1), ('T3',1), ('T4',2), ('T5',2),
('T6',2), ('T7',3), ('T8',3), ('T9',3), ('T10',4);

-- ==========================================
-- INSERTS JUGADORES_ROSTER
-- ==========================================
INSERT INTO jugadores_roster (id_roster, id_jugador, id_rol, es_titular) VALUES
(1,1,'MID',1),(1,2,'TOP',1),(1,3,'ADC',1),(1,4,'SUP',1),(1,5,'JG',1),
(2,6,'MID',1),(2,7,'TOP',1),(2,8,'ADC',1),(2,9,'SUP',1),(2,10,'JG',1),
(3,11,'MID',1),(3,12,'TOP',1),(3,13,'ADC',1),(3,14,'SUP',1),(3,15,'JG',1),
(4,16,'MID',1),(4,17,'TOP',1),(4,18,'ADC',1),(4,19,'SUP',1),(4,20,'JG',1);

-- ==========================================
-- INSERTS ESTADISTICAS JUGADOR POR COMPETENCIA
-- ==========================================
INSERT INTO estadisticas_jugador_competencia (id_jugador, id_competencia, kills, deaths, assists) VALUES
(1,1,10,2,5),(2,1,8,4,7),(3,1,12,3,6),(4,1,5,5,10),(5,1,7,3,8),
(6,2,9,1,6),(7,2,7,3,5),(8,2,4,6,9),(9,2,6,2,7),(10,2,10,4,8),
(11,3,5,5,7),(12,3,6,3,4),(13,3,7,2,5),(14,3,4,6,6),(15,3,8,3,7);

-- ==========================================
-- INSERTS ESTADISTICAS EQUIPO POR COMPETENCIA
-- ==========================================
INSERT INTO estadisticas_equipo_competencia (id_equipo, id_competencia, victorias, derrotas) VALUES
('T1',1,3,1),('T2',1,4,0),('T3',1,2,2),('T4',2,1,3),('T5',2,3,1),
('T6',2,2,2),('T7',3,5,0),('T8',3,4,1),('T9',3,3,2),('T10',4,2,3);


