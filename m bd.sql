--
-- PostgreSQL database dump
--

\restrict zdQ2KYjnCfulgurvzT13ImnurM7v75fu4pUVoGp3rCs3WLGpbIfUoyKKWNwiYly

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-04 10:37:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 222 (class 1259 OID 24662)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    sender_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    read_at timestamp with time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24687)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    student_id uuid NOT NULL,
    rating integer NOT NULL,
    comment text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24714)
-- Name: session_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id uuid NOT NULL,
    tutor_id uuid NOT NULL,
    problem_description text NOT NULL,
    solution_description text NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.session_reports OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24615)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    student_id uuid NOT NULL,
    tutor_id uuid NOT NULL,
    status character varying(20) DEFAULT 'WAITING'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    finished_at timestamp with time zone,
    CONSTRAINT check_different_users CHECK ((student_id <> tutor_id)),
    CONSTRAINT sessions_status_check CHECK (((status)::text = ANY ((ARRAY['WAITING'::character varying, 'ACTIVE'::character varying, 'FINISHED'::character varying, 'CANCELED'::character varying])::text[])))
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24594)
-- Name: tutor_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tutor_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    bio text,
    technologies text[] DEFAULT '{}'::text[],
    is_online boolean DEFAULT false,
    rating double precision DEFAULT 0.0,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tutor_profiles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24577)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['STUDENT'::character varying, 'TUTOR'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 4972 (class 0 OID 24662)
-- Dependencies: 222
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, session_id, sender_id, content, created_at, read_at) FROM stdin;
\.


--
-- TOC entry 4973 (class 0 OID 24687)
-- Dependencies: 223
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, session_id, student_id, rating, comment, created_at) FROM stdin;
\.


--
-- TOC entry 4974 (class 0 OID 24714)
-- Dependencies: 224
-- Data for Name: session_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session_reports (id, session_id, tutor_id, problem_description, solution_description, notes, created_at) FROM stdin;
\.


--
-- TOC entry 4971 (class 0 OID 24615)
-- Dependencies: 221
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, student_id, tutor_id, status, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 4970 (class 0 OID 24594)
-- Dependencies: 220
-- Data for Name: tutor_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tutor_profiles (id, user_id, bio, technologies, is_online, rating, created_at) FROM stdin;
\.


--
-- TOC entry 4969 (class 0 OID 24577)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password_hash, role, created_at) FROM stdin;
\.


--
-- TOC entry 4801 (class 2606 OID 24674)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 4804 (class 2606 OID 24700)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4806 (class 2606 OID 24702)
-- Name: reviews reviews_session_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_session_id_key UNIQUE (session_id);


--
-- TOC entry 4810 (class 2606 OID 24727)
-- Name: session_reports session_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_reports
    ADD CONSTRAINT session_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4812 (class 2606 OID 24729)
-- Name: session_reports session_reports_session_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_reports
    ADD CONSTRAINT session_reports_session_id_key UNIQUE (session_id);


--
-- TOC entry 4797 (class 2606 OID 24628)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 24607)
-- Name: tutor_profiles tutor_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutor_profiles
    ADD CONSTRAINT tutor_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 24609)
-- Name: tutor_profiles tutor_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutor_profiles
    ADD CONSTRAINT tutor_profiles_user_id_key UNIQUE (user_id);


--
-- TOC entry 4789 (class 2606 OID 24593)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4791 (class 2606 OID 24591)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 1259 OID 24685)
-- Name: idx_messages_history; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_messages_history ON public.messages USING btree (session_id, created_at DESC);


--
-- TOC entry 4807 (class 1259 OID 24741)
-- Name: idx_reports_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_session_id ON public.session_reports USING btree (session_id);


--
-- TOC entry 4808 (class 1259 OID 24740)
-- Name: idx_reports_tutor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reports_tutor_id ON public.session_reports USING btree (tutor_id);


--
-- TOC entry 4802 (class 1259 OID 24713)
-- Name: idx_reviews_student_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_student_id ON public.reviews USING btree (student_id);


--
-- TOC entry 4799 (class 1259 OID 24686)
-- Name: idx_unread_count; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_unread_count ON public.messages USING btree (session_id) WHERE (read_at IS NULL);


--
-- TOC entry 4816 (class 2606 OID 24680)
-- Name: messages messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- TOC entry 4817 (class 2606 OID 24675)
-- Name: messages messages_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4818 (class 2606 OID 24703)
-- Name: reviews reviews_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4819 (class 2606 OID 24708)
-- Name: reviews reviews_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 4820 (class 2606 OID 24730)
-- Name: session_reports session_reports_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_reports
    ADD CONSTRAINT session_reports_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4821 (class 2606 OID 24735)
-- Name: session_reports session_reports_tutor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session_reports
    ADD CONSTRAINT session_reports_tutor_id_fkey FOREIGN KEY (tutor_id) REFERENCES public.users(id);


--
-- TOC entry 4814 (class 2606 OID 24629)
-- Name: sessions sessions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4815 (class 2606 OID 24634)
-- Name: sessions sessions_tutor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_tutor_id_fkey FOREIGN KEY (tutor_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4813 (class 2606 OID 24610)
-- Name: tutor_profiles tutor_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutor_profiles
    ADD CONSTRAINT tutor_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-04-04 10:37:24

--
-- PostgreSQL database dump complete
--

\unrestrict zdQ2KYjnCfulgurvzT13ImnurM7v75fu4pUVoGp3rCs3WLGpbIfUoyKKWNwiYly

