--
-- PostgreSQL database dump for the universe database
--

-- Drop the existing database if it exists
DROP DATABASE IF EXISTS universe;

-- Create the universe database
CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';
ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

--
-- Create Tables for the Universe Database
--

-- Create blackhole table
CREATE TABLE public.blackhole (
    blackhole_id serial PRIMARY KEY,
    name varchar(100) NOT NULL UNIQUE,  -- NOT NULL and UNIQUE
    galaxy_id integer NOT NULL REFERENCES public.galaxy(galaxy_id),  -- NOT NULL
    is_wormhole boolean NOT NULL DEFAULT false  -- NOT NULL
);

ALTER TABLE public.blackhole OWNER TO freecodecamp;

-- Create galaxy table
CREATE TABLE public.galaxy (
    galaxy_id serial PRIMARY KEY,
    radius integer NOT NULL,  -- NOT NULL
    gname varchar(100) NOT NULL UNIQUE,  -- NOT NULL and UNIQUE
    ispresent boolean NOT NULL DEFAULT true,  -- NOT NULL
    rotation_speed integer NOT NULL DEFAULT 1999990  -- NOT NULL
);

ALTER TABLE public.galaxy OWNER TO freecodecamp;

-- Create moon table
CREATE TABLE public.moon (
    moon_id serial PRIMARY KEY,
    name varchar(256) NOT NULL,  -- NOT NULL
    has_water boolean NOT NULL,  -- NOT NULL
    name_code varchar(50) UNIQUE,  -- UNIQUE
    planet_id integer NOT NULL REFERENCES public.planet(planet_id)  -- NOT NULL
);

ALTER TABLE public.moon OWNER TO freecodecamp;

-- Create planet table
CREATE TABLE public.planet (
    planet_id serial PRIMARY KEY,
    name varchar(100) NOT NULL UNIQUE,  -- NOT NULL and UNIQUE
    timetravel boolean NOT NULL DEFAULT false,  -- NOT NULL
    amount_of_people numeric NOT NULL,  -- NOT NULL
    star_id integer NOT NULL REFERENCES public.star(star_id)  -- NOT NULL
);

ALTER TABLE public.planet OWNER TO freecodecamp;

-- Create star table
CREATE TABLE public.star (
    star_id serial PRIMARY KEY,
    radius integer NOT NULL,  -- NOT NULL
    name varchar(100) NOT NULL UNIQUE,  -- NOT NULL and UNIQUE
    galaxy_id integer NOT NULL REFERENCES public.galaxy(galaxy_id)  -- NOT NULL
);

ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Insert Data into Tables
--

-- Insert data into galaxy table
INSERT INTO public.galaxy (radius, gname, ispresent, rotation_speed) VALUES
(20000, 'andromeda', true, 1999990),
(20000, 'andromeda2', true, 1999990),
(30000, 'andromeda3', true, 1999990),
(30000, 'andromeda4', true, 1999990),
(30000, 'andromeda5', true, 1999990),
(30000, 'andromeda6', true, 1999990);

-- Insert data into star table
INSERT INTO public.star (radius, name, galaxy_id) VALUES
(12345678, 'a', 6),
(12345678, 'b', 5),
(12345678, 'c', 4),
(12345678, 'd', 3),
(12345678, 'e', 2),
(12345678, 'f', 1);

-- Insert data into planet table
INSERT INTO public.planet (name, timetravel, amount_of_people, star_id) VALUES
('jolo', false, 3000000, 1),
('molo', false, 3000000, 2),
('kolo', false, 3000000, 3),
('lolo', false, 3000000, 5);

-- Insert data into moon table
INSERT INTO public.moon (name, has_water, name_code, planet_id) VALUES
('mom', false, 'nun', 3),
('mom', false, 'num', 3),
('mom', false, 'nul', 3),
('mom', false, 'nulk', 3),
('mom', false, 'mulk', 3),
('mom', false, 'kmulk', 3),
('mom', false, 'lkmulk', 3),
('mom', false, 'lmmulk', 3),
('mom', false, 'lmmmulk', 3),
('mom', false, 'lmmmulko', 3),
('mom', false, 'lmmmlko', 3),
('mom', false, 'lmmmlk', 3),
('mom', false, 'lmmml', 3),
('mom', false, 'mmml', 3),
('mom', false, 'nmmml', 3),
('mom', false, 'nsmml', 3),
('mom', false, 'nsmzml', 3),
('mom', false, 'lnsmzml', 3),
('mom', false, 'lbnsmzml', 3),
('mom', false, 'lbnsmzm', 3);

-- Insert data into blackhole table
INSERT INTO public.blackhole (name, galaxy_id, is_wormhole) VALUES
('Blackhole 1', 1, false),
('Blackhole 2', 2, false);

--
-- Set Sequences to Correct Values
--

SELECT pg_catalog.setval('public.blackhole_blackhole_id_seq', 1, false);
SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 1, true);
SELECT pg_catalog.setval('public.moon_moon_id_seq', 1, false);
SELECT pg_catalog.setval('public.planet_planet_id_seq', 1, false);
SELECT pg_catalog.setval('public.star_star_id_seq', 1, false);

--
-- Add Foreign Key Constraints
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);

-- PostgreSQL database dump complete
