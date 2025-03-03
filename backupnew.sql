--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255),
    email character varying(255) NOT NULL,
    email_verified_at timestamp without time zone,
    password character varying(255) NOT NULL,
    phone character varying(255),
    school character varying(255),
    profile_photo character varying(255),
    role character varying(255),
    remember_token character varying(100),
    jwt_token_version integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, dirty) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, phone, school, profile_photo, role, remember_token, jwt_token_version, created_at, updated_at) FROM stdin;
1735736366	John Doe	john.doe@example.com	\N	$2a$10$rYD14oOyKkv7si3Bhd1KD.rfL0w0WHiFbHPQsD3zbh.54WTn4K2KC	\N	\N	\N	\N	\N	1	2025-01-01 19:59:26.828615	2025-01-01 19:59:26.828615
1735736553	Arva	arva@example.com	\N	$2a$10$uGbu6LxgYN5WXcxwdPyrxOOasUR4Hacz9rO2CNbLcxXtynSTjsI62	\N	\N	\N	\N	\N	1	2025-01-01 20:02:33.481334	2025-01-01 20:02:33.481334
1735736706	Arvazaki	arvaz@example.com	\N	$2a$10$XSBQIUznP3sfFq1wXcguxOEHpB6tA4D2JjRKkMxMLAMUqIpvfim3q	\N	\N	\N	\N	\N	1	2025-01-01 20:05:06.559591	2025-01-01 20:05:06.559591
1735736792	arvauhuy	arvauhuy@example.com	\N	$2a$10$6IaelVkJk/mmOkplRMcpGu73TsprHwp7gyZ4WY96XRCc4drPFtbWm	\N	\N	\N	\N	\N	1	2025-01-01 20:06:32.177746	2025-01-01 20:06:32.177746
1	a	a@example.com	\N	$2a$10$nhjQ3pNYz9GBHKuoXHt3COsqCLOFLjuTUUWVTowgf23v.AIo5Sy9K	\N	\N	\N	\N	\N	1	2025-01-01 20:09:26.995818	2025-01-01 20:09:26.995818
2	arvazf	arvazf@example.com	\N	$2a$10$Sw65XULuCRYUrVUZjr2hoek1jflneLYqW0wX3HdPBWRAphNVhcD.q	\N	\N	\N	\N	\N	1	2025-01-01 20:11:51.196401	2025-01-01 20:11:51.196401
3	arvaa	arvaa@example.com	\N	$2a$10$6ImvfzQab7V3yZzCqF3yjOKxhkVAmewQAsFP652FjyCpfNLLhIN2e			\N	student	\N	1	2025-01-01 20:16:58.367866	2025-01-01 20:16:58.367866
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

