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
