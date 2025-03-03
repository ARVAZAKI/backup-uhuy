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
-- Name: event_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_participants (
    id uuid NOT NULL,
    nama_lengkap character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    no_whatsapp character varying(255) NOT NULL,
    instansi character varying(255),
    sumber_informasi character varying(255) NOT NULL,
    event_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.event_participants OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    event_name character varying(255) NOT NULL,
    event_slug character varying(255) NOT NULL,
    event_poster text,
    event_date timestamp without time zone NOT NULL,
    location text NOT NULL,
    group_link text,
    status character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    dirty boolean NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: subtest_question_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subtest_question_answers (
    id uuid NOT NULL,
    answer character varying(255),
    subtest_question_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subtest_question_answers OWNER TO postgres;

--
-- Name: subtest_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subtest_questions (
    id uuid NOT NULL,
    question_photo character varying(255),
    question text NOT NULL,
    answer_type character varying(20) NOT NULL,
    correct_answer text NOT NULL,
    link_pembahasan text,
    subtest_id uuid NOT NULL,
    tryout_id uuid NOT NULL,
    weight double precision DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subtest_questions OWNER TO postgres;

--
-- Name: subtests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subtests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    subtest_name character varying(255) NOT NULL,
    subtest_slug character varying(255) NOT NULL,
    duration integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.subtests OWNER TO postgres;

--
-- Name: tryout_subtests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tryout_subtests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    link_pembahasan_text text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.tryout_subtests OWNER TO postgres;

--
-- Name: tryouts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tryouts (
    id uuid NOT NULL,
    tryout_name character varying(255),
    tryout_slug character varying(255),
    tryout_image character varying(255),
    tryout_poster character varying(255),
    status character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.tryouts OWNER TO postgres;

--
-- Name: user_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_answers (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    subtest_question_id uuid NOT NULL,
    subtest_question_answer_id uuid,
    essay_answer character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_answers OWNER TO postgres;

--
-- Name: user_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_results (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    score integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_results OWNER TO postgres;

--
-- Name: user_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_results_id_seq OWNER TO postgres;

--
-- Name: user_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_results_id_seq OWNED BY public.user_results.id;


--
-- Name: user_surveys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_surveys (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    tryout_id uuid NOT NULL,
    message character varying(255) NOT NULL,
    rating smallint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_surveys_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.user_surveys OWNER TO postgres;

--
-- Name: user_surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_surveys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_surveys_id_seq OWNER TO postgres;

--
-- Name: user_surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_surveys_id_seq OWNED BY public.user_surveys.id;


--
-- Name: user_tryout_subtests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_tryout_subtests (
    id uuid NOT NULL,
    tryout_id uuid NOT NULL,
    subtest_id uuid NOT NULL,
    user_id bigint NOT NULL,
    status character varying(10) DEFAULT 'belum'::character varying,
    end_time timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_tryout_subtests OWNER TO postgres;

--
-- Name: user_universities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_universities (
    id uuid NOT NULL,
    user_id bigint NOT NULL,
    university_name character varying(255) NOT NULL,
    university_major character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_universities OWNER TO postgres;

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
    level integer DEFAULT 0,
    xp integer DEFAULT 0,
    coin integer DEFAULT 0,
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
-- Name: user_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_results ALTER COLUMN id SET DEFAULT nextval('public.user_results_id_seq'::regclass);


--
-- Name: user_surveys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_surveys ALTER COLUMN id SET DEFAULT nextval('public.user_surveys_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_participants (id, nama_lengkap, email, no_whatsapp, instansi, sumber_informasi, event_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, event_name, event_slug, event_poster, event_date, location, group_link, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, dirty) FROM stdin;
13	f
\.


--
-- Data for Name: subtest_question_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subtest_question_answers (id, answer, subtest_question_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subtest_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subtest_questions (id, question_photo, question, answer_type, correct_answer, link_pembahasan, subtest_id, tryout_id, weight, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: subtests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subtests (id, subtest_name, subtest_slug, duration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tryout_subtests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tryout_subtests (id, tryout_id, subtest_id, link_pembahasan_text, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: tryouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tryouts (id, tryout_name, tryout_slug, tryout_image, tryout_poster, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_answers (id, user_id, subtest_question_id, subtest_question_answer_id, essay_answer, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_results (id, user_id, tryout_id, subtest_id, score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_surveys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_surveys (id, user_id, tryout_id, message, rating, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_tryout_subtests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_tryout_subtests (id, tryout_id, subtest_id, user_id, status, end_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_universities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_universities (id, user_id, university_name, university_major, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, phone, school, profile_photo, role, level, xp, coin, remember_token, jwt_token_version, created_at, updated_at) FROM stdin;
\.


--
-- Name: user_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_results_id_seq', 1, false);


--
-- Name: user_surveys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_surveys_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: event_participants event_participants_email_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_email_event_id_key UNIQUE (email, event_id);


--
-- Name: event_participants event_participants_nama_lengkap_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_nama_lengkap_event_id_key UNIQUE (nama_lengkap, event_id);


--
-- Name: event_participants event_participants_no_whatsapp_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_no_whatsapp_event_id_key UNIQUE (no_whatsapp, event_id);


--
-- Name: event_participants event_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_pkey PRIMARY KEY (id);


--
-- Name: events events_event_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_event_slug_key UNIQUE (event_slug);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: subtest_question_answers subtest_question_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtest_question_answers
    ADD CONSTRAINT subtest_question_answers_pkey PRIMARY KEY (id);


--
-- Name: subtest_questions subtest_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT subtest_questions_pkey PRIMARY KEY (id);


--
-- Name: subtests subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtests
    ADD CONSTRAINT subtests_pkey PRIMARY KEY (id);


--
-- Name: subtests subtests_subtest_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtests
    ADD CONSTRAINT subtests_subtest_slug_key UNIQUE (subtest_slug);


--
-- Name: tryout_subtests tryout_subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT tryout_subtests_pkey PRIMARY KEY (id);


--
-- Name: tryouts tryouts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tryouts
    ADD CONSTRAINT tryouts_pkey PRIMARY KEY (id);


--
-- Name: user_answers user_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_pkey PRIMARY KEY (id);


--
-- Name: user_results user_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT user_results_pkey PRIMARY KEY (id);


--
-- Name: user_surveys user_surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT user_surveys_pkey PRIMARY KEY (id);


--
-- Name: user_tryout_subtests user_tryout_subtests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT user_tryout_subtests_pkey PRIMARY KEY (id);


--
-- Name: user_universities user_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_universities
    ADD CONSTRAINT user_universities_pkey PRIMARY KEY (id);


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
-- Name: event_participants fk_event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: tryout_subtests fk_subtest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT fk_subtest FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON DELETE CASCADE;


--
-- Name: user_tryout_subtests fk_subtest_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT fk_subtest_id FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_results fk_subtest_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT fk_subtest_id FOREIGN KEY (subtest_id) REFERENCES public.subtests(id) ON DELETE CASCADE;


--
-- Name: subtest_questions fk_subtest_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT fk_subtest_id FOREIGN KEY (subtest_id) REFERENCES public.subtests(id);


--
-- Name: user_answers fk_subtest_question_answer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT fk_subtest_question_answer_id FOREIGN KEY (subtest_question_answer_id) REFERENCES public.subtest_question_answers(id) ON DELETE CASCADE;


--
-- Name: subtest_question_answers fk_subtest_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtest_question_answers
    ADD CONSTRAINT fk_subtest_question_id FOREIGN KEY (subtest_question_id) REFERENCES public.subtest_questions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_answers fk_subtest_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT fk_subtest_question_id FOREIGN KEY (subtest_question_id) REFERENCES public.subtest_questions(id) ON DELETE CASCADE;


--
-- Name: tryout_subtests fk_tryout; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tryout_subtests
    ADD CONSTRAINT fk_tryout FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: user_tryout_subtests fk_tryout_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT fk_tryout_id FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_results fk_tryout_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT fk_tryout_id FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: subtest_questions fk_tryout_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subtest_questions
    ADD CONSTRAINT fk_tryout_id FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON DELETE CASCADE;


--
-- Name: user_surveys fk_tryout_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT fk_tryout_id FOREIGN KEY (tryout_id) REFERENCES public.tryouts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_universities fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_universities
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_tryout_subtests fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_tryout_subtests
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_results fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_results
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_answers fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_surveys fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_surveys
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

