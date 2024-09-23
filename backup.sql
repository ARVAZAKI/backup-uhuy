--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

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
-- Name: cache; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO nusajar_fagaihhve;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO nusajar_fagaihhve;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO nusajar_fagaihhve;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO nusajar_fagaihhve;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nusajar_fagaihhve
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO nusajar_fagaihhve;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO nusajar_fagaihhve;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO nusajar_fagaihhve;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nusajar_fagaihhve
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO nusajar_fagaihhve;

--
-- Name: share_tryouts; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.share_tryouts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    tryout_id uuid NOT NULL,
    post_screenshot character varying(255),
    status character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.share_tryouts OWNER TO nusajar_fagaihhve;

--
-- Name: share_tryouts_id_seq; Type: SEQUENCE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE SEQUENCE public.share_tryouts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.share_tryouts_id_seq OWNER TO nusajar_fagaihhve;

--
-- Name: share_tryouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nusajar_fagaihhve
--

ALTER SEQUENCE public.share_tryouts_id_seq OWNED BY public.share_tryouts.id;


--
-- Name: subtest_question_answers; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.subtest_question_answers (
    id uuid NOT NULL,
    answer character varying(255),
    subtest_question_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.subtest_question_answers OWNER TO nusajar_fagaihhve;

--
-- Name: subtest_questions; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.subtest_questions (
    id uuid NOT NULL,
    question_photo character varying(255),
    question text NOT NULL,
    answer_type character varying(255) NOT NULL,
    correct_answer text NOT NULL,
    link_pembahasan text,
    subtest_id uuid NOT NULL,
    tryout_id uuid NOT NULL,
    weight double precision DEFAULT '0'::double precision NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT subtest_questions_answer_type_check CHECK (((answer_type)::text = ANY ((ARRAY['multiple choices'::character varying, 'essay'::character varying])::text[])))
);


ALTER TABLE public.subtest_questions OWNER TO nusajar_fagaihhve;

--
-- Name: subtests; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.subtests (
    id uuid NOT NULL,
    subtest_name character varying(255) NOT NULL,
    subtest_slug character varying(255) NOT NULL,
    subtest_category character varying(255) NOT NULL,
    duration integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.subtests OWNER TO nusajar_fagaihhve;

--
-- Name: tryout_subtests; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.tryout_subtests (
    id uuid NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    link_pembahasan_text text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tryout_subtests OWNER TO nusajar_fagaihhve;

--
-- Name: tryouts; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.tryouts (
    id uuid NOT NULL,
    tryout_name character varying(255) NOT NULL,
    tryout_slug character varying(255) NOT NULL,
    tryout_image character varying(255) NOT NULL,
    tryout_poster character varying(255) NOT NULL,
    kode character varying(255) NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT tryouts_status_check CHECK (((status)::text = ANY ((ARRAY['development'::character varying, 'launched'::character varying, 'closed'::character varying])::text[])))
);


ALTER TABLE public.tryouts OWNER TO nusajar_fagaihhve;

--
-- Name: user_answers; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.user_answers (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    subtest_question_id uuid NOT NULL,
    subtest_question_answer_id uuid,
    essay_answer character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_answers OWNER TO nusajar_fagaihhve;

--
-- Name: user_results; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.user_results (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    score integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_results OWNER TO nusajar_fagaihhve;

--
-- Name: user_results_id_seq; Type: SEQUENCE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE SEQUENCE public.user_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_results_id_seq OWNER TO nusajar_fagaihhve;

--
-- Name: user_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nusajar_fagaihhve
--

ALTER SEQUENCE public.user_results_id_seq OWNED BY public.user_results.id;


--
-- Name: user_surveys; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.user_surveys (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    tryout_id uuid NOT NULL,
    message character varying(255) NOT NULL,
    rating smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_surveys OWNER TO nusajar_fagaihhve;

--
-- Name: user_tryout_subtests; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.user_tryout_subtests (
    id uuid NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    user_id bigint NOT NULL,
    status character varying(255) DEFAULT 'belum'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT user_tryout_subtests_status_check CHECK (((status)::text = ANY ((ARRAY['selesai'::character varying, 'belum'::character varying, 'mulai'::character varying])::text[])))
);


ALTER TABLE public.user_tryout_subtests OWNER TO nusajar_fagaihhve;

--
-- Name: user_universities; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.user_universities (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    university_name character varying(255) NOT NULL,
    university_major character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_universities OWNER TO nusajar_fagaihhve;

--
-- Name: users; Type: TABLE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255),
    phone character varying(255),
    school character varying(255),
    profile_photo character varying(255),
    role character varying(255) NOT NULL,
    ip_address character varying(45),
    user_agent text,
    is_logged_in boolean DEFAULT false NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO nusajar_fagaihhve;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: nusajar_fagaihhve
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO nusajar_fagaihhve;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nusajar_fagaihhve
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: share_tryouts id; Type: DEFAULT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.share_tryouts ALTER COLUMN id SET DEFAULT nextval('public.share_tryouts_id_seq'::regclass);


--
-- Name: user_results id; Type: DEFAULT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_results ALTER COLUMN id SET DEFAULT nextval('public.user_results_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.cache (key, value, expiration) FROM stdin;
mentor1@gmail.com|140.213.169.1:timer	i:1727085146;	1727085146
mentor1@gmail.com|140.213.169.1	i:1;	1727085146
mentor@gmail.com|140.213.169.1:timer	i:1727085171;	1727085171
mentor@gmail.com|140.213.169.1	i:1;	1727085171
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	2024_07_06_115458_create_tryouts_table	1
4	2024_07_06_115530_create_subtests_table	1
5	2024_07_06_115531_create_tryout_subtests_table	1
6	2024_07_06_115656_create_subtest_questions_table	1
7	2024_07_06_123058_create_subtest_question_answers_table	1
8	2024_07_06_172856_create_share_tryouts_table	1
9	2024_07_12_074116_create_user_answers_table	1
10	2024_07_12_074345_create_user_results_table	1
11	2024_07_20_003328_create_personal_access_tokens_table	1
12	2024_07_23_100741_create_user_tryout_subtests_table	1
13	2024_07_28_135647_create_user_universities_table	1
14	2024_09_14_073622_create_user_surveys_table	1
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
pRDv6uaf88dwOvGGynQSTQBlBh091U526HhH3Ole	\N	104.28.215.132	Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1	YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGpsM3pJNldDUWVsYmoycFplNFFJcDVuM0xyVHFWbkxnM0xhMHJnTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1727087177
e3QJdAbWTYgoQ22MaFv67j4LcpdTkj5OSHHITjZ5	\N	182.1.103.110	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiYlFvUmREalBhd0Z6NUt1MHhnVjk3YUdRWW1aMWw1OTl4MndrWkFSSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwIjt9fQ==	1727087999
NpVq8hXM9YMWf1DynOcoXNx60T51j5YItsGIXHww	\N	185.16.39.118	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36 Edg/90.0.818.46	YToyOntzOjY6Il90b2tlbiI7czo0MDoibWUwellJaDROZzYzMWRHMjNZbnhXUXg2dFJXeEVRY3h4bFZNcU1UQyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1727088019
PQUexPIK2n9B7GdvCRTFXkDPSgZPHADfC1txx9s6	\N	207.46.13.54	Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm) Chrome/116.0.1938.76 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiMHVNRWV4Y1pxOFVjQzdzSWUycFFXbWVJV3VZMndicWV3dUdYdExueCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1727087333
hR3XMYPRfKXLHYFaRKk7k20Z7SdgdFEipva5nYMG	\N	185.191.126.213		YTozOntzOjY6Il90b2tlbiI7czo0MDoibjNPQnRyYkZ5ZjB0ald0Z1laYlM3anlwNk82V2prQ0NFN3BkeThKMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xNTkuMjIzLjQyLjE0MSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1727087356
GLGdrrTMe1d3H1LhIJgXL1KbRSy7GkSS9lUCFkkB	\N	185.191.126.213		YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3dIM0J2V3JBTTdlVzRNVkVEN1l6S0VMSTdhV2wyZzByd204WHpxaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjA6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1727088177
OAlzsNZ0iF4hfSQAbCv8VgHqG80efWYyLQ23XYXD	\N	114.5.104.2	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0 Safari/605.1.15	YTo0OntzOjY6Il90b2tlbiI7czo0MDoibmhWR3NjdU5KTEVadHhTTUVGTmc0eG5YNGZ0bjk1UTM4ZkJhUzh2OCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwL2xvZ2luIjt9czoxMzoibGFzdF9hY3Rpdml0eSI7aToxNzI3MDg3NTU4O30=	1727087692
m6OYyslKgSWY7oM5N1ugAlbrCHbvC3kKFBHqtD2C	2	140.213.42.92	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:130.0) Gecko/20100101 Firefox/130.0	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaDVwaGpIMldlT2pYcnNDUFV2cjhXcFJSUUI5Y2lOaktDRjh3aDNNbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTE4OiJodHRwOi8vMTU3LjI0NS42Mi45MC9tZW50b3IvdHJ5b3V0L3F1ZXN0aW9ucy85ZDEzZTg0Mi02MDExLTQzMTgtYTk3ZC0zMDRiMmIwYzkzYTYvOWQxM2NiOTktNzFiMS00MjlhLThhYzYtNWVjNTQ1ZmMxNDNjIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czoxMzoibGFzdF9hY3Rpdml0eSI7aToxNzI3MDg4MzM1O3M6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=	1727088335
bFiIGFPukkm75scC3n1qUpiVLDPyTbKRRq0nTwLP	16	182.1.120.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36	YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUHUySzA1NHFqMjkwc0JXWXRBMXVkdjNES2N6YUNrR2xPVldwRmNZbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xNTcuMjQ1LjYyLjkwL21lbnRvci90cnlvdXQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxNjtzOjEzOiJsYXN0X2FjdGl2aXR5IjtpOjE3MjcwODc3NjA7fQ==	1727087760
\.


--
-- Data for Name: share_tryouts; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.share_tryouts (id, user_id, tryout_id, post_screenshot, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subtest_question_answers; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.subtest_question_answers (id, answer, subtest_question_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subtest_questions; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.subtest_questions (id, question_photo, question, answer_type, correct_answer, link_pembahasan, subtest_id, tryout_id, weight, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subtests; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.subtests (id, subtest_name, subtest_slug, subtest_category, duration, created_at, updated_at) FROM stdin;
9d13cb99-6f3d-4987-a23d-a7b0a9ae468f	Kemampuan Penalaran Umum	Kemampuan-Penalaran-Umum	TES POTENSI SKOLIASTIK	30	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-7129-438a-af54-e0fb91fa2861	Pengetahuan dan Pemahaman Umum	Pengetahuan-dan-Pemahaman-Umum	TES POTENSI SKOLIASTIK	15	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-71b1-429a-8ac6-5ec545fc143c	Kemampuan Memahami Bacaan dan Menulis	kemampuan-Memahami-Bacaan-dan-Menulis	TES POTENSI SKOLIASTIK	25	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-7229-43c6-830d-97f8d7f250c7	Pengetahuan Kuantitatif	Pengetahuan-Kuantitatif	TES POTENSI SKOLIASTIK	20	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-729f-427f-829e-7fb8ab452427	Literasi Dalam Bahasa Indonesia	Literasi-Dalam-Bahasa-Indonesia	TES LITERASI	38	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-7310-4549-a854-99803fddeb67	Literasi Dalam Bahasa Inggris	Literasi-Dalam-Bahasa-inggris	TES LITERASI	30	2024-09-23 09:24:17	2024-09-23 09:24:17
9d13cb99-739d-4d40-a8fb-7df4464e963d	Penalaran Matematika	Penalaran-Matematika	TES PENALARAN MATEMATIKA	38	2024-09-23 09:24:17	2024-09-23 09:24:17
\.


--
-- Data for Name: tryout_subtests; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.tryout_subtests (id, tryout_id, subtest_id, link_pembahasan_text, created_at, updated_at) FROM stdin;
9d13e842-6188-4c69-b88f-02a3698d205a	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-6f3d-4987-a23d-a7b0a9ae468f	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-625d-4867-9a68-4e59cd606769	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-7129-438a-af54-e0fb91fa2861	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-62f6-46aa-9f3e-1b31a83cefca	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-71b1-429a-8ac6-5ec545fc143c	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-6387-4ba7-a41a-969f6b590579	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-7229-43c6-830d-97f8d7f250c7	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-640f-4168-9860-b2490e3ca05c	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-729f-427f-829e-7fb8ab452427	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-64a7-480c-8fd5-afd0cf72a261	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-7310-4549-a854-99803fddeb67	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
9d13e842-654e-4ea0-94c2-61ccc9173d3d	9d13e842-6011-4318-a97d-304b2b0c93a6	9d13cb99-739d-4d40-a8fb-7df4464e963d	\N	2024-09-23 10:44:26	2024-09-23 10:44:26
\.


--
-- Data for Name: tryouts; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.tryouts (id, tryout_name, tryout_slug, tryout_image, tryout_poster, kode, status, created_at, updated_at) FROM stdin;
9d13e842-6011-4318-a97d-304b2b0c93a6	LANGKAH AWAL MENUJU UTBK 2025	LANGKAH-AWAL-MENUJU-UTBK-2025	LANGKAH AWAL MENUJU UTBK 2025_LKu.jpg	LANGKAH AWAL MENUJU UTBK 2025_tHu.jpg	TONUSA	development	2024-09-23 10:44:26	2024-09-23 10:44:26
\.


--
-- Data for Name: user_answers; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.user_answers (id, user_id, subtest_question_id, subtest_question_answer_id, essay_answer, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_results; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.user_results (id, user_id, tryout_id, subtest_id, score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_surveys; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.user_surveys (id, user_id, tryout_id, message, rating, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_tryout_subtests; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.user_tryout_subtests (id, tryout_id, subtest_id, user_id, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_universities; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.user_universities (id, user_id, university_name, university_major, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: nusajar_fagaihhve
--

COPY public.users (id, name, email, email_verified_at, password, phone, school, profile_photo, role, ip_address, user_agent, is_logged_in, remember_token, created_at, updated_at, deleted_at) FROM stdin;
1	student	student@gmail.com	\N	$2y$12$tU3HwKGc7spT6jVriIvmvu9UbNoTjLsWR/QcZnZ0Um4fFEwy6uUpm	\N	\N	\N	student	\N	\N	f	\N	2024-09-23 09:24:12	2024-09-23 09:24:12	\N
3	student2	student2@gmail.com	\N	$2y$12$gkFVTRub2FOHZcJh2eb21.JjNhGMb433mSRXw31.pE7ebtey2kKvW	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
4	student3	student3@gmail.com	\N	$2y$12$sFB3MsCnZ/bUU8gpFod81uSgsRbJtZDDfoE0hwS9iQxUI.q0hXMCC	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
5	student4	student4@gmail.com	\N	$2y$12$jyex6E7dsnXrUtJk2uCKd.hrUIic.byl01dkjsPJbgPACG8YWm/Cu	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
6	student5	student5@gmail.com	\N	$2y$12$fmFnWFSbi6g9rbxhJrHS5./nBOJjXoiVJIq2T1q9cC1mvozt7ZShC	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
7	student6	student6@gmail.com	\N	$2y$12$3FQJZ9jY/xfGOPDLAh6YxOozPqZAua2U7OvHhmmk3oviEC6TunKCO	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
8	student7	student7@gmail.com	\N	$2y$12$3GH5VR9WZi/44YGA.Suiaupyc/EnZmx15LUccAgoRRcm2Xt06OQni	\N	\N	\N	student	\N	\N	f	\N	\N	\N	\N
11	mentor4	mentor4@gmail.com	\N	$2y$12$u.KuqdwEtaOz2gkTYK2EpuluVx/FCSVygyvrA7acsozTygMG2U9Be	\N	\N	\N	mentor	\N	\N	f	\N	\N	\N	\N
13	mentor6	mentor6@gmail.com	\N	$2y$12$YGHXIiObzYTiR.SZXBeuHemV0eP3Bn7xLtsbr278OUi9fIJUnCAFK	\N	\N	\N	mentor	\N	\N	f	\N	\N	\N	\N
14	mentor7	mentor7@gmail.com	\N	$2y$12$P6hupHaGy3vK/z97VQr7OOKL1uQfMTNFNw8bIKSVZ/gvrKUFILKYK	\N	\N	\N	mentor	\N	\N	f	04p1AvxwgJlXzcbhkbr3aQFvkvFCplhYwAZm4SoGMWSGDUguUOsp6KVYCVRE	\N	2024-09-23 10:24:09	\N
9	mentor2	mentor2@gmail.com	\N	$2y$12$iGCr5TKxGS/wjhACREZ.L.ZCXtWa6fuZ6aCY49KJjpYW/nyzVYSE6	\N	\N	\N	mentor	\N	\N	f	\N	\N	2024-09-23 10:25:53	\N
10	mentor3	mentor3@gmail.com	\N	$2y$12$hbqMbb9647TdNPbroQMBwOcSWKL3t7YNWo0jNJ.NLDI40EqY2BvqW	\N	\N	\N	mentor	\N	\N	f	\N	\N	2024-09-23 09:50:56	\N
17	mentor10	mentor10@gmail.com	\N	$2y$12$phpzRAMy3tK3SRyEjQ1jUOjE74OOAHbUQFNPOZ485RvnTFjEdpu9.	\N	\N	\N	mentor	\N	\N	f	0EVWpvDX9RcAdn4wXntid8xRbwhIvVDBuELP91Pco8ld5kFSziw6nqKG4xmr	\N	2024-09-23 09:52:08	\N
12	mentor5	mentor5@gmail.com	\N	$2y$12$k7WwQkU40zFTwat9olIxyuT9ikE47UaXixVN2xmD92HfSFdbhx3oC	\N	\N	\N	mentor	\N	\N	f	\N	\N	2024-09-23 10:26:41	\N
15	mentor8	mentor8@gmail.com	\N	$2y$12$uEa9ndl0j99MHM0Ex3lbr.jqVx/toR4kVMZehUeL83WCWcPttMvjK	\N	\N	\N	mentor	\N	\N	f	\N	\N	2024-09-23 10:23:56	\N
16	mentor9	mentor9@gmail.com	\N	$2y$12$iWQjpAX/9UsRWiPo8TuKX.PiYYWhlRn2o9pyF9nu2mokYnCwYHIP.	\N	\N	\N	mentor	182.1.120.138	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36	t	qi7ePsaduSGGR7iiRg4M25EWkibnTohlldSD8NfHMjAThe8cCiqPrXYCCab8	\N	2024-09-23 10:33:07	\N
2	mentor	mentor@gmail.com	\N	$2y$12$EWvZwS2.omLkl5NLq.d.yOe2hx4jeOAn6TaXkQSyd2MFFZZ3haQbW	\N	\N	\N	mentor	\N	\N	f	\N	2024-09-23 09:24:12	2024-09-23 10:39:59	\N
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nusajar_fagaihhve
--

SELECT pg_catalog.setval('public.migrations_id_seq', 14, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nusajar_fagaihhve
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: share_tryouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nusajar_fagaihhve
--

SELECT pg_catalog.setval('public.share_tryouts_id_seq', 1, true);


--
-- Name: user_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nusajar_fagaihhve
--

SELECT pg_catalog.setval('public.user_results_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nusajar_fagaihhve
--

SELECT pg_catalog.setval('public.users_id_seq', 17, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: share_tryouts share_tryouts_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.share_tryouts
    ADD CONSTRAINT share_tryouts_pkey PRIMARY KEY (id);


--
-- Name: subtest_question_answers subtest_question_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtest_question_answers
    ADD CONSTRAINT subtest_question_answers_pkey PRIMARY KEY (id);


--
-- Name: subtest_questions subtest_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT subtest_questions_pkey PRIMARY KEY (id);


--
-- Name: subtests subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtests
    ADD CONSTRAINT subtests_pkey PRIMARY KEY (id);


--
-- Name: tryout_subtests tryout_subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT tryout_subtests_pkey PRIMARY KEY (id);


--
-- Name: tryouts tryouts_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.tryouts
    ADD CONSTRAINT tryouts_pkey PRIMARY KEY (id);


--
-- Name: user_answers user_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_pkey PRIMARY KEY (id);


--
-- Name: user_results user_results_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT user_results_pkey PRIMARY KEY (id);


--
-- Name: user_surveys user_surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT user_surveys_pkey PRIMARY KEY (id);


--
-- Name: user_tryout_subtests user_tryout_subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT user_tryout_subtests_pkey PRIMARY KEY (id);


--
-- Name: user_universities user_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_universities
    ADD CONSTRAINT user_universities_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: nusajar_fagaihhve
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: nusajar_fagaihhve
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: nusajar_fagaihhve
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: share_tryouts share_tryouts_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.share_tryouts
    ADD CONSTRAINT share_tryouts_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: share_tryouts share_tryouts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.share_tryouts
    ADD CONSTRAINT share_tryouts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: subtest_question_answers subtest_question_answers_subtest_question_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtest_question_answers
    ADD CONSTRAINT subtest_question_answers_subtest_question_id_foreign FOREIGN KEY (subtest_question_id) REFERENCES public.subtest_questions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subtest_questions subtest_questions_subtest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT subtest_questions_subtest_id_foreign FOREIGN KEY (subtest_id) REFERENCES public.subtests(id);


--
-- Name: subtest_questions subtest_questions_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT subtest_questions_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: tryout_subtests tryout_subtests_subtest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT tryout_subtests_subtest_id_foreign FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tryout_subtests tryout_subtests_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT tryout_subtests_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_answers user_answers_subtest_question_answer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_subtest_question_answer_id_foreign FOREIGN KEY (subtest_question_answer_id) REFERENCES public.subtest_question_answers(id) ON DELETE CASCADE;


--
-- Name: user_answers user_answers_subtest_question_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_subtest_question_id_foreign FOREIGN KEY (subtest_question_id) REFERENCES public.subtest_questions(id) ON DELETE CASCADE;


--
-- Name: user_answers user_answers_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_results user_results_subtest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT user_results_subtest_id_foreign FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON DELETE CASCADE;


--
-- Name: user_results user_results_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT user_results_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: user_results user_results_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT user_results_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_surveys user_surveys_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT user_surveys_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_surveys user_surveys_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT user_surveys_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_tryout_subtests user_tryout_subtests_subtest_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT user_tryout_subtests_subtest_id_foreign FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_tryout_subtests user_tryout_subtests_tryout_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT user_tryout_subtests_tryout_id_foreign FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_tryout_subtests user_tryout_subtests_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT user_tryout_subtests_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_universities user_universities_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: nusajar_fagaihhve
--

ALTER TABLE ONLY public.user_universities
    ADD CONSTRAINT user_universities_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

