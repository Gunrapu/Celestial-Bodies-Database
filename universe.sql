--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    distance_kpc integer,
    distance_mly integer,
    apparent_magnitude numeric(5,2),
    absolute_magnitude numeric(5,2),
    designations text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer,
    name character varying(30) NOT NULL,
    adjectives text,
    symbol text,
    surface_area text,
    volume text,
    mass text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer,
    name character varying(30) NOT NULL,
    adjectives text,
    symbol text,
    surface_area text,
    volume text,
    mass text,
    living boolean,
    life boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: space_words; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.space_words (
    space_words_id integer NOT NULL,
    name character varying(30) NOT NULL,
    meaning text
);


ALTER TABLE public.space_words OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer,
    name character varying(30) NOT NULL,
    designation text,
    approval_date text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda Galaxy', 765, 3, 3.44, -21.50, 'M31, NGC 224, UGC 454, PGC 2557');
INSERT INTO public.galaxy VALUES (2, 'Backward Galaxy', NULL, 2, 12.60, NULL, 'NGC 4622, PGC 42701');
INSERT INTO public.galaxy VALUES (3, 'Cigar Galaxy', NULL, 12, 8.41, NULL, 'M82, NGC 3034, UGC 5322, PGC 28655');
INSERT INTO public.galaxy VALUES (4, 'Eye of Sauron', NULL, 53, 11.50, NULL, 'NGC 4151, UGC 7166, PGC 38739');
INSERT INTO public.galaxy VALUES (5, 'Fireworks Galaxy', NULL, 25, 9.60, NULL, 'NGC 6946, UGC 11597, PGC 65001');
INSERT INTO public.galaxy VALUES (6, 'Sunflower Galaxy', 9, 29, 9.30, 90.72, 'M63, NGC 5055, PGC 46153, UGC 8334');
INSERT INTO public.galaxy VALUES (7, 'Milky Way', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 4, 'Moon', 'Lunar', '☾ or ☽', '3.793×10^7 km^2', '2.1958×10^10 km^3', '7.342×10^22 kg');
INSERT INTO public.moon VALUES (2, 5, 'Phobos', 'Phobian', NULL, '1640±8 km^2', '5695±32 km^3', '1.060×10^16 kg');
INSERT INTO public.moon VALUES (3, 5, 'Deimos', 'Deimian', NULL, '522±8 km^2', '1033±19 km^3', '1.51×10^15 kg');
INSERT INTO public.moon VALUES (4, 7, 'Ganymede', 'Ganymedian', NULL, '8.72×107 km^2', '7.66×10^10 km^3', '1.4819×1023 kg');
INSERT INTO public.moon VALUES (5, 7, 'Callisto', 'Callistoan', NULL, '7.30×10^7 km^2', '5.9×10^10 km^3', '(1.075938±0.000137)×10^23 kg');
INSERT INTO public.moon VALUES (6, 7, 'Io', 'Ionian', NULL, '41698064.7357 km^2', '2.5319064907×10^10 km^3', '(8.931938±0.000018)×10^22 kg');
INSERT INTO public.moon VALUES (7, 7, 'Europa', 'Europan', NULL, '3.09×10^7 km^2', '1.593×10^10 km^3', '4.79984×10^22 kg');
INSERT INTO public.moon VALUES (8, 8, 'Titan', 'Titanian', NULL, '8.3×10^7 km^2', '7.16×10^10 km^3', '(1.3452±0.0002)×10^23 kg');
INSERT INTO public.moon VALUES (9, 8, 'Rhea', 'Rhean', NULL, '7337000 km^2', NULL, '(2.3064854±0.0000522)×10^21 kg');
INSERT INTO public.moon VALUES (10, 8, 'Iapetus', 'Iapetian', NULL, '6700000 km^2', NULL, '1.80565×10^21 kg');
INSERT INTO public.moon VALUES (11, 8, 'Dione', 'Dionean', NULL, '3964776.51 km^2', NULL, '(1.0954868±0.0000246)×10^21 kg');
INSERT INTO public.moon VALUES (12, 8, 'Tethys', 'Tethyan', NULL, NULL, NULL, '6.1749×10^20 kg');
INSERT INTO public.moon VALUES (13, 8, 'Enceladus', 'Enceladean', NULL, NULL, NULL, '(1.080318±0.00028)×10^20 kg');
INSERT INTO public.moon VALUES (14, 8, 'Mimas', 'Mimantean', NULL, '490000–500000 km^2', '32600000±200000 km^3', '(3.75094±0.00023)×10^19 kg');
INSERT INTO public.moon VALUES (15, 8, 'Hyperion', 'Hyperionian', NULL, NULL, NULL, '(5.5510±0.0007)×10^18 kg');
INSERT INTO public.moon VALUES (16, 8, 'Phoebe', 'Phoebean', NULL, NULL, NULL, '(8.3123±0.0162)×10^18 kg');
INSERT INTO public.moon VALUES (17, 9, 'Titania', 'Titanian', NULL, '7820000 km^2', '2054000000 km^3', '(3.4550±0.0509)×10^21 kg');
INSERT INTO public.moon VALUES (18, 9, 'Oberon', 'Oberonian', NULL, '7285000 km^2', '1849000000 km^3', '(3.1104±0.0749)×10^21 kg');
INSERT INTO public.moon VALUES (19, 9, 'Umbriel', 'Umbrielian', NULL, '4296000 km^2 (0.008 Earths)', '837300000 km3 (0.0008 Earths)', '(1.2885±0.0225)×10^21 kg');
INSERT INTO public.moon VALUES (20, 9, 'Ariel', 'Arielian', NULL, '4211300 km^2', '812600000 km^3', '(1.2331±0.0180)×10^21 kg');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (3, 7, 'Venus', 'Venusian', '♀', '4.6023×10^8 km^2', '9.2843×10^11 km^3', '4.8675×10^24 kg', false, false);
INSERT INTO public.planet VALUES (2, 7, 'Mercury', 'Mercurian', '☿', '7.48×10^7 km^2', '6.083×10^10 km^3', '3.3011×10^23 kg', false, false);
INSERT INTO public.planet VALUES (4, 7, 'Earth', 'Earthly', '🜨 and ♁', '510072000 km^2', '1.08321×10^12 km^3', '5.972168×10^24 kg', true, true);
INSERT INTO public.planet VALUES (5, 7, 'Mars', 'Martian', '♂', '1.4437×10^8 km^2', '1.63118×10^11 km^3', '6.4171×10^23 kg', false, false);
INSERT INTO public.planet VALUES (6, 7, 'Ceres', 'Cererian', '⚳', '2,772,368 km^2', '434,000,000 km^3', '9.3839×10^20 kg', false, false);
INSERT INTO public.planet VALUES (7, 7, 'Jupiter', 'Jovian', '♃', '6.1469×10^10 km^2', '1.4313×10^15 km^3', '1.8982×10^27 kg', false, false);
INSERT INTO public.planet VALUES (8, 7, 'Saturn', 'Saturnian', '♄', '4.27×10^10 km^2', '8.2713×10^14 km^3', '5.6834×10^26 kg', false, false);
INSERT INTO public.planet VALUES (9, 7, 'Uranus', 'Uranian', '⛢ or ♅', '8.1156×10^9 km^2', '6.833×10^13 km^3', '(8.6810±0.0013)×10^25 kg', false, false);
INSERT INTO public.planet VALUES (10, 7, 'Neptune', 'Neptunian', '♆', '7.6187×10^9 km^2', '6.253×10^13 km^3', '1.02409×10^26 kg', false, false);
INSERT INTO public.planet VALUES (11, 7, 'Pluto', 'Plutonian', '♇', '1.774443×10^7 km^2', '(7.057±0.004)×10^9 km^3', '(1.3025±0.0006)×10^22 kg', false, false);
INSERT INTO public.planet VALUES (12, 7, 'Haumea', 'Haumean', NULL, '≈ 8.14×10^6 km^2', '≈ 1.98×10^9 km^3', '(4.006±0.040)×10^21 kg', false, false);
INSERT INTO public.planet VALUES (1, 7, 'Sun', 'Solar', '☉', '6.09×10^12 km^2', '1.412×10^18 km^3', '1.9885×10^30 kg', false, false);


--
-- Data for Name: space_words; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.space_words VALUES (1, 'Absolute Magnitude', 'Measure of a celestial object’s intrinsic brightness.');
INSERT INTO public.space_words VALUES (2, 'Absolute Zero', 'Lowest possible temperature, 0 Kelvin or -273.15 degrees Celsius.');
INSERT INTO public.space_words VALUES (3, 'Accretion', 'Process of matter accumulating onto a celestial object.');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Adhil', 'HR 390', '2016-08-21');
INSERT INTO public.star VALUES (2, 1, 'Almach', 'HR 603', '2016-07-20');
INSERT INTO public.star VALUES (3, 1, 'Mirach', 'HR 337', '2016-06-30');
INSERT INTO public.star VALUES (4, 1, 'Nembus', 'HR 464', '2017-09-05');
INSERT INTO public.star VALUES (5, 1, 'Titawin', 'HR 458', '2015-12-15');
INSERT INTO public.star VALUES (6, 1, 'Veritate', 'HR 8930', '2015-12-15');
INSERT INTO public.star VALUES (7, 7, 'Antares', NULL, NULL);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: space_words space_words_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.space_words
    ADD CONSTRAINT space_words_pkey PRIMARY KEY (space_words_id);


--
-- Name: space_words space_words_word_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.space_words
    ADD CONSTRAINT space_words_word_key UNIQUE (name);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

