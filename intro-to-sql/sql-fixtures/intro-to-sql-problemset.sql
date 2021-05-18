--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-03-13 20:00:58 PST

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

-- Exists just to be deleted
CREATE TABLE public.books();
ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16663)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(32),
    publisher_id integer,
    description text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16669)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 202 (class 1259 OID 16671)
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name character varying(32),
    address character varying(64)
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16674)
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.publishers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.publishers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 204 (class 1259 OID 16676)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(32),
    last_name character varying(32),
    email character varying(32)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16679)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3262 (class 0 OID 16663)
-- Dependencies: 200
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, publisher_id, description) FROM stdin;
1	Nimona	1	Wonderful comic by Noelle Stevenson
2	Watchmen	2	Dark, very dark
3	Maus: A Survivors Tale	1	Two volume historical memoir.
4	Daytripper	3	Death retroactively imposes a shape on a personâs life.
5	This One Summer	103	Written by Mariko Tamaki and illustrated by Jillian Tamaki.
6	Sweet Tooth	103	Interesting tale.
7	Through The Woods	99	It came from the woods. Most strange things do.
8	Blankets	3	Semiautobiographical story of a young man raised in a strict evangelical tradition.
\.

--
-- TOC entry 3264 (class 0 OID 16671)
-- Dependencies: 202
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publishers (id, name, address) FROM stdin;
1	Blue Gem Publishers	123 Elm Street Tuscon AZ 12837
2	Ruby Comics	P.O. Box Portland, OR 96545
3	Developers Academy	315 5th Ave S Suite 200, Seattle, WA 98104
4	Angry Elf Ltd	111 East Down Street London England 11111
5	Shueishan Comics	P.O. Box 11231 New York, NY 01754
\.


--
-- TOC entry 3266 (class 0 OID 16676)
-- Dependencies: 204
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email) FROM stdin;
2	Sujay	Rosemary	sujay.rosemary@email.com
3	Vittorio	Oliver	voliver@email.com
4	Sofija	MaraÄµa	smaraja@email.com
5	Bendik	Genoveva	bendik.genoveva@safemail.com
6	Auster	Alexandra	auster.alexandra@safemail.com
7	Deepali	Efrem	deepali.Efrem@email.com
8	Coade	OMoore	cade.omoore@gmail.com
\.


--
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 201
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 10, true);


--
-- TOC entry 3274 (class 0 OID 0)
-- Dependencies: 203
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publishers_id_seq', 5, true);


--
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 205
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3129 (class 2606 OID 16682)
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- TOC entry 3131 (class 2606 OID 16684)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2021-03-13 20:00:58 PST

--
-- PostgreSQL database dump complete
--
