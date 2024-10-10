--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.0

-- Started on 2024-07-12 11:16:15

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

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--



ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16398)
-- Name: event_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    display_order integer NOT NULL
);


ALTER TABLE public.event_categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16403)
-- Name: event_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_categories_id_seq OWNER TO postgres;

--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_categories_id_seq OWNED BY public.event_categories.id;


--
-- TOC entry 218 (class 1259 OID 16404)
-- Name: event_enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_enrollments (
    id integer NOT NULL,
    id_event integer NOT NULL,
    id_user integer NOT NULL,
    description character varying NOT NULL,
    registration_date_time timestamp without time zone NOT NULL,
    attended boolean NOT NULL,
    observations character varying NOT NULL,
    rating integer NOT NULL
);


ALTER TABLE public.event_enrollments OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16409)
-- Name: event_enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_enrollments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_enrollments_id_seq OWNER TO postgres;

--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 219
-- Name: event_enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_enrollments_id_seq OWNED BY public.event_enrollments.id;


--
-- TOC entry 220 (class 1259 OID 16410)
-- Name: event_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_locations (
    id integer NOT NULL,
    id_location integer NOT NULL,
    name character varying NOT NULL,
    full_address character varying NOT NULL,
    max_capacity character varying NOT NULL,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    id_creator_user integer NOT NULL
);


ALTER TABLE public.event_locations OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16415)
-- Name: event_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_locations_id_seq OWNER TO postgres;

--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 221
-- Name: event_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_locations_id_seq OWNED BY public.event_locations.id;


--
-- TOC entry 222 (class 1259 OID 16416)
-- Name: event_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_tags (
    id integer NOT NULL,
    id_event integer NOT NULL,
    id_tag integer NOT NULL
);


ALTER TABLE public.event_tags OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16419)
-- Name: event_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_tags_id_seq OWNER TO postgres;

--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 223
-- Name: event_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_tags_id_seq OWNED BY public.event_tags.id;


--
-- TOC entry 224 (class 1259 OID 16420)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    id_event_category integer,
    id_event_location integer,
    start_date timestamp without time zone NOT NULL,
    duration_in_minutes integer NOT NULL,
    price numeric NOT NULL,
    enabled_for_enrollment boolean NOT NULL,
    max_assistance integer NOT NULL,
    id_creator_user integer NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16425)
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 225
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- TOC entry 226 (class 1259 OID 16426)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying NOT NULL,
    id_province integer NOT NULL,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16431)
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO postgres;

--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 227
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- TOC entry 228 (class 1259 OID 16432)
-- Name: provinces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provinces (
    id integer NOT NULL,
    name character varying NOT NULL,
    full_name character varying NOT NULL,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    display_order integer NOT NULL
);


ALTER TABLE public.provinces OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16437)
-- Name: provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provinces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.provinces_id_seq OWNER TO postgres;

--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 229
-- Name: provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provinces_id_seq OWNED BY public.provinces.id;


--
-- TOC entry 230 (class 1259 OID 16438)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16443)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 231
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 232 (class 1259 OID 16444)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16449)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 233
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4675 (class 2604 OID 16450)
-- Name: event_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_categories ALTER COLUMN id SET DEFAULT nextval('public.event_categories_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 16451)
-- Name: event_enrollments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments ALTER COLUMN id SET DEFAULT nextval('public.event_enrollments_id_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 16452)
-- Name: event_locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations ALTER COLUMN id SET DEFAULT nextval('public.event_locations_id_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 16453)
-- Name: event_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags ALTER COLUMN id SET DEFAULT nextval('public.event_tags_id_seq'::regclass);


--
-- TOC entry 4679 (class 2604 OID 16454)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 16455)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- TOC entry 4681 (class 2604 OID 16456)
-- Name: provinces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 16457)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 16458)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4854 (class 0 OID 16398)
-- Dependencies: 216
-- Data for Name: event_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_categories VALUES (1, 'Music', 1);
INSERT INTO public.event_categories VALUES (2, 'Art', 2);
INSERT INTO public.event_categories VALUES (3, 'Technology', 3);


--
-- TOC entry 4856 (class 0 OID 16404)
-- Dependencies: 218
-- Data for Name: event_enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_enrollments VALUES (1, 1, 1, 'Registered for concert', '2024-05-01 10:00:00', false, '', 0);
INSERT INTO public.event_enrollments VALUES (2, 2, 2, 'Registered for exhibition', '2024-05-02 11:00:00', false, '', 0);
INSERT INTO public.event_enrollments VALUES (3, 3, 3, 'Registered for tech talk', '2024-05-03 12:00:00', false, '', 0);


--
-- TOC entry 4858 (class 0 OID 16410)
-- Dependencies: 220
-- Data for Name: event_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_locations VALUES (3, 3, 'Open Space', '789 Oak St', '200', 37.7749, -122.4194, 3);
INSERT INTO public.event_locations VALUES (4, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 1);
INSERT INTO public.event_locations VALUES (5, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 1);
INSERT INTO public.event_locations VALUES (6, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 2);
INSERT INTO public.event_locations VALUES (7, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 2);
INSERT INTO public.event_locations VALUES (8, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 2);
INSERT INTO public.event_locations VALUES (9, 2, 'Office', '123 Elm St', '100', 40.7128, -74.006, 2);


--
-- TOC entry 4860 (class 0 OID 16416)
-- Dependencies: 222
-- Data for Name: event_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_tags VALUES (1, 1, 1);
INSERT INTO public.event_tags VALUES (2, 2, 2);
INSERT INTO public.event_tags VALUES (3, 3, 3);


--
-- TOC entry 4862 (class 0 OID 16420)
-- Dependencies: 224
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.events VALUES (3, 'Tech Talk', 'Latest in technology', 3, 3, '2024-06-03 14:00:00', 90, 0.00, true, 200, 3);
INSERT INTO public.events VALUES (1, 'Concert', 'Live music event', 1, NULL, '2024-06-01 18:00:00', 120, 50.00, true, 100, 1);
INSERT INTO public.events VALUES (4, 'Evento de prueba', 'Descripción del evento de prueba', 1, NULL, '2024-07-05 10:00:00', 120, 50, true, 100, 1);
INSERT INTO public.events VALUES (5, 'Evento de prueba', 'Descripción del evento de prueba', 1, NULL, '2024-07-05 10:00:00', 120, 50, true, 100, 1);
INSERT INTO public.events VALUES (2, 'Art Exhibition', 'Modern art gallery', 2, NULL, '2024-06-02 10:00:00', 180, 20.00, true, 50, 2);


--
-- TOC entry 4864 (class 0 OID 16426)
-- Dependencies: 226
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.locations VALUES (1, 'New York', 1, 40.7128, -74.0060);
INSERT INTO public.locations VALUES (2, 'Los Angeles', 2, 34.0522, -118.2437);
INSERT INTO public.locations VALUES (3, 'San Francisco', 3, 37.7749, -122.4194);


--
-- TOC entry 4866 (class 0 OID 16432)
-- Dependencies: 228
-- Data for Name: provinces; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.provinces VALUES (1, 'NY', 'New York', 40.7128, -74.0060, 1);
INSERT INTO public.provinces VALUES (2, 'CA', 'California', 34.0522, -118.2437, 2);
INSERT INTO public.provinces VALUES (3, 'CA', 'California', 37.7749, -122.4194, 3);


--
-- TOC entry 4868 (class 0 OID 16438)
-- Dependencies: 230
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tags VALUES (1, 'Music');
INSERT INTO public.tags VALUES (2, 'Art');
INSERT INTO public.tags VALUES (3, 'Technology');


--
-- TOC entry 4870 (class 0 OID 16444)
-- Dependencies: 232
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (4, 'Maxi', 'Garbarino', 'maxi@gmail.com', 'HolaProfe');
INSERT INTO public.users VALUES (1, 'John', 'Doe', 'jdoe@gmail.com', 'password1');
INSERT INTO public.users VALUES (5, 'Maxi', 'Garbarino', 'maxi@gmail.com', 'HolaProfe');
INSERT INTO public.users VALUES (2, 'Jane', 'Smith', 'jsmith@gmail.com', 'password2');
INSERT INTO public.users VALUES (3, 'Alice', 'Johnson', 'ajohnson@gmail.com', 'password3');


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_categories_id_seq', 1, false);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 219
-- Name: event_enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_enrollments_id_seq', 1, false);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 221
-- Name: event_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_locations_id_seq', 1, false);


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 223
-- Name: event_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_tags_id_seq', 1, false);


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 225
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 5, true);


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 227
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 229
-- Name: provinces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provinces_id_seq', 1, false);


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 231
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 1, false);


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 233
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4685 (class 2606 OID 16460)
-- Name: event_categories PK_EventCategories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT "PK_EventCategories" PRIMARY KEY (id);


--
-- TOC entry 4687 (class 2606 OID 16462)
-- Name: event_enrollments PK_EventEnrollments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT "PK_EventEnrollments" PRIMARY KEY (id);


--
-- TOC entry 4689 (class 2606 OID 16464)
-- Name: event_locations PK_EventLocations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT "PK_EventLocations" PRIMARY KEY (id);


--
-- TOC entry 4691 (class 2606 OID 16466)
-- Name: event_tags PK_EventTags; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT "PK_EventTags" PRIMARY KEY (id);


--
-- TOC entry 4693 (class 2606 OID 16468)
-- Name: events PK_Events; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT "PK_Events" PRIMARY KEY (id);


--
-- TOC entry 4697 (class 2606 OID 16470)
-- Name: provinces PK_Provinces ; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT "PK_Provinces " PRIMARY KEY (id);


--
-- TOC entry 4699 (class 2606 OID 16472)
-- Name: tags PK_Tags; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "PK_Tags" PRIMARY KEY (id);


--
-- TOC entry 4701 (class 2606 OID 16474)
-- Name: users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_Users" PRIMARY KEY (id);


--
-- TOC entry 4695 (class 2606 OID 16476)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 16477)
-- Name: event_enrollments FK_Event_enrollments_Events; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT "FK_Event_enrollments_Events" FOREIGN KEY (id_event) REFERENCES public.events(id) NOT VALID;


--
-- TOC entry 4703 (class 2606 OID 16482)
-- Name: event_enrollments FK_Event_enrollments_Users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_enrollments
    ADD CONSTRAINT "FK_Event_enrollments_Users" FOREIGN KEY (id_user) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 4705 (class 2606 OID 16487)
-- Name: event_tags FK_Event_tags_Event; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT "FK_Event_tags_Event" FOREIGN KEY (id_event) REFERENCES public.events(id) NOT VALID;


--
-- TOC entry 4706 (class 2606 OID 16492)
-- Name: event_tags FK_Event_tags_Tags; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_tags
    ADD CONSTRAINT "FK_Event_tags_Tags" FOREIGN KEY (id_tag) REFERENCES public.tags(id) NOT VALID;


--
-- TOC entry 4704 (class 2606 OID 16497)
-- Name: event_locations FK_EventlocationLocations; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_locations
    ADD CONSTRAINT "FK_EventlocationLocations" FOREIGN KEY (id_location) REFERENCES public.locations(id) NOT VALID;


--
-- TOC entry 4707 (class 2606 OID 16502)
-- Name: events FK_EventsEvent_categories; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT "FK_EventsEvent_categories" FOREIGN KEY (id_event_category) REFERENCES public.event_categories(id) NOT VALID;


--
-- TOC entry 4708 (class 2606 OID 16507)
-- Name: events FK_EventsEvent_locations; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT "FK_EventsEvent_locations" FOREIGN KEY (id_event_location) REFERENCES public.event_locations(id) NOT VALID;


--
-- TOC entry 4709 (class 2606 OID 16512)
-- Name: events FK_EventsUsers; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT "FK_EventsUsers" FOREIGN KEY (id_creator_user) REFERENCES public.users(id) NOT VALID;


--
-- TOC entry 4710 (class 2606 OID 16517)
-- Name: locations FK_LocationsProvince; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT "FK_LocationsProvince" FOREIGN KEY (id_province) REFERENCES public.provinces(id) NOT VALID;


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-07-12 11:16:15

--
-- PostgreSQL database dump complete
--

