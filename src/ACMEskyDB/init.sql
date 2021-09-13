CREATE DATABASE acmesky;
GRANT ALL PRIVILEGES ON DATABASE acmesky TO soseng;
\connect acmesky;

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3

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
ALTER SYSTEM SET max_prepared_transactions = 200;



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
-- TOC entry 201 (class 1259 OID 16388)
-- Name: airlines; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.airlines (
    id bigint NOT NULL,
    ws_address character varying(255) NOT NULL,
    entity_id bigint NOT NULL
);


ALTER TABLE public.airlines OWNER TO soseng;

--
-- TOC entry 200 (class 1259 OID 16386)
-- Name: airlines_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.airlines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.airlines_id_seq OWNER TO soseng;

--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 200
-- Name: airlines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.airlines_id_seq OWNED BY public.airlines.id;


--
-- TOC entry 203 (class 1259 OID 16396)
-- Name: airports; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.airports (
    id bigint NOT NULL,
    city_name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    country_code character varying(255) NOT NULL,
    latitude real NOT NULL,
    longitude real NOT NULL,
    name character varying(255) NOT NULL,
    timezone integer NOT NULL
);


ALTER TABLE public.airports OWNER TO soseng;

--
-- TOC entry 202 (class 1259 OID 16394)
-- Name: airports_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.airports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.airports_id_seq OWNER TO soseng;

--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 202
-- Name: airports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.airports_id_seq OWNED BY public.airports.id;


--
-- TOC entry 205 (class 1259 OID 16407)
-- Name: banks; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.banks (
    id bigint NOT NULL,
    ws_address character varying(255) NOT NULL,
    entity_id bigint NOT NULL,
    login_username character varying(255) NOT NULL,
    login_password character varying(255) NOT NULL
);


ALTER TABLE public.banks OWNER TO soseng;

--
-- TOC entry 204 (class 1259 OID 16405)
-- Name: banks_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banks_id_seq OWNER TO soseng;

--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 204
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;


--
-- TOC entry 207 (class 1259 OID 16415)
-- Name: domain_entities; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.domain_entities (
    id bigint NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    salt character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.domain_entities OWNER TO soseng;

--
-- TOC entry 206 (class 1259 OID 16413)
-- Name: domain_entities_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.domain_entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domain_entities_id_seq OWNER TO soseng;

--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 206
-- Name: domain_entities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.domain_entities_id_seq OWNED BY public.domain_entities.id;


--
-- TOC entry 209 (class 1259 OID 16426)
-- Name: flights; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.flights (
    id bigint NOT NULL,
    arrival_date_time timestamp with time zone NOT NULL,
    available boolean NOT NULL,
    booked boolean NOT NULL,
    departure_date_time timestamp with time zone NOT NULL,
    expire_date timestamp with time zone NOT NULL,
    flight_code character varying(255) NOT NULL,
    price real NOT NULL,
    airline_id bigint NOT NULL,
    arrival_airport_id bigint NOT NULL,
    departure_airport_id bigint NOT NULL
);


ALTER TABLE public.flights OWNER TO soseng;

--
-- TOC entry 208 (class 1259 OID 16424)
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.flights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_id_seq OWNER TO soseng;

--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 208
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- TOC entry 211 (class 1259 OID 16434)
-- Name: flights_interest; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.flights_interest (
    id bigint NOT NULL,
    departure_date_time timestamp with time zone NOT NULL,
    used boolean NOT NULL,
    arrival_airport_id bigint,
    departure_airport_id bigint,
    user_id bigint
);


ALTER TABLE public.flights_interest OWNER TO soseng;

--
-- TOC entry 210 (class 1259 OID 16432)
-- Name: flights_interest_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.flights_interest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flights_interest_id_seq OWNER TO soseng;

--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 210
-- Name: flights_interest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.flights_interest_id_seq OWNED BY public.flights_interest.id;


--
-- TOC entry 213 (class 1259 OID 16442)
-- Name: generated_offers; Type: TABLE; Schema: public; Owner: soseng
--
CREATE TABLE public.generated_offers (
    id bigint NOT NULL,
    available boolean,
    booked boolean,
    expire_date timestamp with time zone NOT NULL,
    token character varying(255),
    total_price double precision,
    flight_back_id bigint NOT NULL,
    outbound_flight_id bigint NOT NULL,
    user_id bigint NOT NULL,
    rent boolean
);

ALTER TABLE public.generated_offers OWNER TO soseng;

--
-- TOC entry 212 (class 1259 OID 16440)
-- Name: generated_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.generated_offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.generated_offers_id_seq OWNER TO soseng;

--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 212
-- Name: generated_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.generated_offers_id_seq OWNED BY public.generated_offers.id;


--
-- TOC entry 215 (class 1259 OID 16450)
-- Name: rent_services; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.rent_services (
    id bigint NOT NULL,
    address character varying(255) NOT NULL,
    ws_address character varying(255) NOT NULL,
    entity_id bigint
);


ALTER TABLE public.rent_services OWNER TO soseng;

--
-- TOC entry 214 (class 1259 OID 16448)
-- Name: rent_services_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.rent_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rent_services_id_seq OWNER TO soseng;

--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 214
-- Name: rent_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.rent_services_id_seq OWNED BY public.rent_services.id;


--
-- TOC entry 217 (class 1259 OID 16461)
-- Name: users; Type: TABLE; Schema: public; Owner: soseng
--
CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    prontogram_username character varying(255) NOT NULL,
    surname character varying(255) NOT NULL,
    entity_id bigint NOT NULL
);

ALTER TABLE public.users OWNER TO soseng;

--
-- TOC entry 216 (class 1259 OID 16459)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO soseng;

--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 219 (class 1259 OID 16472)
-- Name: users_interests; Type: TABLE; Schema: public; Owner: soseng
--

CREATE TABLE public.users_interests (
    id bigint NOT NULL,
    expire_date timestamp with time zone NOT NULL,
    price_limit double precision NOT NULL,
    used boolean NOT NULL,
    flight_back_interest_id bigint NOT NULL,
    outbound_flight_interest_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.users_interests OWNER TO soseng;

--
-- TOC entry 218 (class 1259 OID 16470)
-- Name: users_interests_id_seq; Type: SEQUENCE; Schema: public; Owner: soseng
--

CREATE SEQUENCE public.users_interests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_interests_id_seq OWNER TO soseng;

--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_interests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: soseng
--

ALTER SEQUENCE public.users_interests_id_seq OWNED BY public.users_interests.id;


--
-- TOC entry 2908 (class 2604 OID 16391)
-- Name: airlines id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airlines ALTER COLUMN id SET DEFAULT nextval('public.airlines_id_seq'::regclass);


--
-- TOC entry 2909 (class 2604 OID 16399)
-- Name: airports id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airports ALTER COLUMN id SET DEFAULT nextval('public.airports_id_seq'::regclass);


--
-- TOC entry 2910 (class 2604 OID 16410)
-- Name: banks id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);


--
-- TOC entry 2911 (class 2604 OID 16418)
-- Name: domain_entities id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.domain_entities ALTER COLUMN id SET DEFAULT nextval('public.domain_entities_id_seq'::regclass);


--
-- TOC entry 2912 (class 2604 OID 16429)
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 16437)
-- Name: flights_interest id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights_interest ALTER COLUMN id SET DEFAULT nextval('public.flights_interest_id_seq'::regclass);


--
-- TOC entry 2914 (class 2604 OID 16445)
-- Name: generated_offers id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.generated_offers ALTER COLUMN id SET DEFAULT nextval('public.generated_offers_id_seq'::regclass);


--
-- TOC entry 2915 (class 2604 OID 16453)
-- Name: rent_services id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.rent_services ALTER COLUMN id SET DEFAULT nextval('public.rent_services_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 16464)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 2917 (class 2604 OID 16475)
-- Name: users_interests id; Type: DEFAULT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users_interests ALTER COLUMN id SET DEFAULT nextval('public.users_interests_id_seq'::regclass);


--
-- TOC entry 2919 (class 2606 OID 16393)
-- Name: airlines airlines_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airlines
    ADD CONSTRAINT airlines_pkey PRIMARY KEY (id);


--
-- TOC entry 2921 (class 2606 OID 16404)
-- Name: airports airports_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airports
    ADD CONSTRAINT airports_pkey PRIMARY KEY (id);


--
-- TOC entry 2925 (class 2606 OID 16412)
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);


--
-- TOC entry 2927 (class 2606 OID 16423)
-- Name: domain_entities domain_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.domain_entities
    ADD CONSTRAINT domain_entities_pkey PRIMARY KEY (id);


--
-- TOC entry 2933 (class 2606 OID 16439)
-- Name: flights_interest flights_interest_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights_interest
    ADD CONSTRAINT flights_interest_pkey PRIMARY KEY (id);


--
-- TOC entry 2931 (class 2606 OID 16431)
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- TOC entry 2935 (class 2606 OID 16447)
-- Name: generated_offers generated_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.generated_offers
    ADD CONSTRAINT generated_offers_pkey PRIMARY KEY (id);


--
-- TOC entry 2937 (class 2606 OID 16458)
-- Name: rent_services rent_services_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.rent_services
    ADD CONSTRAINT rent_services_pkey PRIMARY KEY (id);


--
-- TOC entry 2923 (class 2606 OID 16479)
-- Name: airports uk_8x5wlokxte7yksdsllxtxbjf0; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airports
    ADD CONSTRAINT uk_8x5wlokxte7yksdsllxtxbjf0 UNIQUE (code);


--
-- TOC entry 2929 (class 2606 OID 16481)
-- Name: domain_entities uk_l408l4s7tg5f3dj5dlpai34vj; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.domain_entities
    ADD CONSTRAINT uk_l408l4s7tg5f3dj5dlpai34vj UNIQUE (username);


--
-- TOC entry 2941 (class 2606 OID 16477)
-- Name: users_interests users_interests_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users_interests
    ADD CONSTRAINT users_interests_pkey PRIMARY KEY (id);


--
-- TOC entry 2939 (class 2606 OID 16469)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2946 (class 2606 OID 16502)
-- Name: flights fk27lt4nklvbrwsw7x32dw0d05q; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT fk27lt4nklvbrwsw7x32dw0d05q FOREIGN KEY (departure_airport_id) REFERENCES public.airports(id);


--
-- TOC entry 2957 (class 2606 OID 16557)
-- Name: users_interests fkcfbenfemx5v0f8pj7nl1ysvem; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users_interests
    ADD CONSTRAINT fkcfbenfemx5v0f8pj7nl1ysvem FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2950 (class 2606 OID 16522)
-- Name: generated_offers fkcqdy5o0q5pbu3xplut6ytx369; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.generated_offers
    ADD CONSTRAINT fkcqdy5o0q5pbu3xplut6ytx369 FOREIGN KEY (flight_back_id) REFERENCES public.flights(id);


--
-- TOC entry 2951 (class 2606 OID 16527)
-- Name: generated_offers fkd19d020bc3wscbwgs8coy1hs5; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.generated_offers
    ADD CONSTRAINT fkd19d020bc3wscbwgs8coy1hs5 FOREIGN KEY (outbound_flight_id) REFERENCES public.flights(id);


--
-- TOC entry 2954 (class 2606 OID 16542)
-- Name: users fkd2mlyge6xfe7q29kj8lsffgoq; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkd2mlyge6xfe7q29kj8lsffgoq FOREIGN KEY (entity_id) REFERENCES public.domain_entities(id);


--
-- TOC entry 2955 (class 2606 OID 16547)
-- Name: users_interests fkgc4ctcslxvhv4ihkq34fk57ha; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users_interests
    ADD CONSTRAINT fkgc4ctcslxvhv4ihkq34fk57ha FOREIGN KEY (flight_back_interest_id) REFERENCES public.flights_interest(id);


--
-- TOC entry 2942 (class 2606 OID 16482)
-- Name: airlines fkggs4sdi8k2swbvbndd7xclqtx; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.airlines
    ADD CONSTRAINT fkggs4sdi8k2swbvbndd7xclqtx FOREIGN KEY (entity_id) REFERENCES public.domain_entities(id);


--
-- TOC entry 2944 (class 2606 OID 16492)
-- Name: flights fkieor4j3ivp3xu584qenhfh0gd; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT fkieor4j3ivp3xu584qenhfh0gd FOREIGN KEY (airline_id) REFERENCES public.airlines(id);


--
-- TOC entry 2947 (class 2606 OID 16507)
-- Name: flights_interest fkmtk217st0vrjs6jiiywibsgr8; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights_interest
    ADD CONSTRAINT fkmtk217st0vrjs6jiiywibsgr8 FOREIGN KEY (arrival_airport_id) REFERENCES public.airports(id);


--
-- TOC entry 2948 (class 2606 OID 16512)
-- Name: flights_interest fknbpvf7lem2po3lpwloh7pm6lk; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights_interest
    ADD CONSTRAINT fknbpvf7lem2po3lpwloh7pm6lk FOREIGN KEY (departure_airport_id) REFERENCES public.airports(id);


--
-- TOC entry 2952 (class 2606 OID 16532)
-- Name: generated_offers fkntdjb3w7ysfkukm7u2exd6jl; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.generated_offers
    ADD CONSTRAINT fkntdjb3w7ysfkukm7u2exd6jl FOREIGN KEY (user_id) REFERENCES public.domain_entities(id);


--
-- TOC entry 2943 (class 2606 OID 16487)
-- Name: banks fknwn1ico5ip2e23ad9ofmrrtkt; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT fknwn1ico5ip2e23ad9ofmrrtkt FOREIGN KEY (entity_id) REFERENCES public.domain_entities(id);


--
-- TOC entry 2953 (class 2606 OID 16537)
-- Name: rent_services fko5sl16fr39bd1xt68u41x70pd; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.rent_services
    ADD CONSTRAINT fko5sl16fr39bd1xt68u41x70pd FOREIGN KEY (entity_id) REFERENCES public.domain_entities(id);


--
-- TOC entry 2956 (class 2606 OID 16552)
-- Name: users_interests fko9gc9nrwph3oku9xwtt1wo341; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.users_interests
    ADD CONSTRAINT fko9gc9nrwph3oku9xwtt1wo341 FOREIGN KEY (outbound_flight_interest_id) REFERENCES public.flights_interest(id);


--
-- TOC entry 2945 (class 2606 OID 16497)
-- Name: flights fkr90ujcvdphv3co3ry7aiel6l4; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT fkr90ujcvdphv3co3ry7aiel6l4 FOREIGN KEY (arrival_airport_id) REFERENCES public.airports(id);


--
-- TOC entry 2949 (class 2606 OID 16517)
-- Name: flights_interest fkt2yvd2ld5hwv0c4cb028ovrd7; Type: FK CONSTRAINT; Schema: public; Owner: soseng
--

ALTER TABLE ONLY public.flights_interest
    ADD CONSTRAINT fkt2yvd2ld5hwv0c4cb028ovrd7 FOREIGN KEY (user_id) REFERENCES public.users(id);




--
-- DB data
--

INSERT INTO public.airports VALUES (1, 'Ainsworth', 'ANW', 'US', 42.58, -99.9933, 'Ainsworth Minicipal Arpt', -100);
INSERT INTO public.airports VALUES (2, 'Antigua', 'ANU', 'AG', 17.13675, -61.792667, 'V C Bird Intl Arpt', -4);
INSERT INTO public.airports VALUES (3, 'Antwerp', 'ANR', 'BE', 51.189445, 4.460278, 'Antwerp Brussels North', 1);
INSERT INTO public.airports VALUES (4, 'Annapolis', 'ANP', 'US', 0, 0, 'Lee Annapolis Arpt', -100);
INSERT INTO public.airports VALUES (5, 'Aniak', 'ANI', 'US', 61.5816, -159.543, 'Aniak Arpt', -9);
INSERT INTO public.airports VALUES (6, 'Ankara', 'ESB', 'TR', 40.128082, 32.995083, 'Esenboga Arpt', 2);
INSERT INTO public.airports VALUES (7, 'Angouleme', 'ANG', 'FR', 45.729248, 0.221456, 'Brie Champniers', 1);
INSERT INTO public.airports VALUES (8, 'Antofagasta', 'ANF', 'CL', -23.444477, -70.4451, 'Cerro Moreno Arpt', -4);
INSERT INTO public.airports VALUES (9, 'Angers', 'ANE', 'FR', 47.5603, -0.312222, 'Marce Arpt', 1);
INSERT INTO public.airports VALUES (10, 'Anderson', 'AND', 'US', 34.494583, -82.70939, 'Anderson Arpt', -5);
INSERT INTO public.airports VALUES (11, 'Anchorage', 'ANC', 'US', 61.174362, -149.99637, 'Anchorage Intl Arpt', -9);
INSERT INTO public.airports VALUES (12, 'Anniston', 'ANB', 'US', 33.588165, -85.85811, 'Anniston Municipal Arpt', -6);
INSERT INTO public.airports VALUES (13, 'Anaheim', 'ANA', 'US', 0, 0, 'Anaheim Arpt', -100);
INSERT INTO public.airports VALUES (14, 'Ames', 'AMW', 'US', 0, 0, 'Ames Minicipal Arpt', -100);
INSERT INTO public.airports VALUES (15, 'Amderma Airport', 'AMV', 'RU', 69.7633, 61.5564, 'Amderma Airport', 4);
INSERT INTO public.airports VALUES (16, 'Amsterdam', 'AMS', 'NL', 52.308613, 4.763889, 'Schiphol Arpt', 1);
INSERT INTO public.airports VALUES (17, 'Amsterdam', 'ZYA', 'NL', 52.7873, 4.90074, 'Amsterdam Central Rail Station', 1);
INSERT INTO public.airports VALUES (18, 'Ambon', 'AMQ', 'ID', -3.710264, 128.08914, 'Pattimura Arpt', 9);
INSERT INTO public.airports VALUES (19, 'Amman', 'AMM', 'JO', 31.722555, 35.993214, 'Queen Alia Intl Arpt', 2);
INSERT INTO public.airports VALUES (20, 'Amman', 'ADJ', 'JO', 31.972704, 35.99157, 'Civil Marka Arpt', 2);
INSERT INTO public.airports VALUES (21, 'Mataram', 'AMI', 'ID', -8.560708, 116.09466, 'Selaparang Airport', 8);
INSERT INTO public.airports VALUES (22, 'Ahmedabad', 'AMD', 'IN', 23.077242, 72.63465, 'Sardar Vallabh Bhai Patel Intl Arpt', 5);
INSERT INTO public.airports VALUES (23, 'Amarillo', 'AMA', 'US', 35.219368, -101.70593, 'Amarillo Intl Arpt', -6);
INSERT INTO public.airports VALUES (24, 'Amarillo', 'TDW', 'US', 0, 0, 'Tradewind Airport', -100);
INSERT INTO public.airports VALUES (25, 'Alexandria', 'ALY', 'EG', 31.183903, 29.948889, 'El Nouzha Arpt', 2);
INSERT INTO public.airports VALUES (26, 'Alexander City', 'ALX', 'US', 38.806347, -77.0621, 'Thomas C Russell Field', -5);
INSERT INTO public.airports VALUES (27, 'Walla Walla', 'ALW', 'US', 46.0949, -118.288, 'Walla Walla City County', -8);
INSERT INTO public.airports VALUES (28, 'Alamosa', 'ALS', 'US', 37.435, -105.86667, 'Alamosa Municipal', -7);
INSERT INTO public.airports VALUES (29, 'Alexandra', 'ALR', 'NZ', -45.211666, 169.37334, 'Alexandra Arpt', 12);
INSERT INTO public.airports VALUES (30, 'Aleppo', 'ALP', 'SY', 36.180676, 37.224358, 'Nejrab Arpt', 2);
INSERT INTO public.airports VALUES (31, 'Waterloo', 'ALO', 'US', 42.5571, -92.4003, 'Livingston Betsworth Fld', -6);
INSERT INTO public.airports VALUES (32, 'Alamogordo', 'ALM', 'US', 32.8399, -105.991, 'Alamogordo Municipal', -7);
INSERT INTO public.airports VALUES (33, 'Albenga', 'ALL', 'IT', 44.05061, 8.127428, 'Albenga Arpt', 1);
INSERT INTO public.airports VALUES (34, 'Alexander Bay', 'ALJ', 'ZA', -28.575, 16.533333, 'Kortdoorn Arpt', 2);
INSERT INTO public.airports VALUES (35, 'Albany', 'ALH', 'AU', -34.9433, 117.809, 'Albany Airport', 8);
INSERT INTO public.airports VALUES (36, 'Algiers', 'ALG', 'DZ', 36.691013, 3.215408, 'Houari Boumedienne Arpt', 1);
INSERT INTO public.airports VALUES (37, 'Alta', 'ALF', 'NO', 69.97611, 23.371668, 'Elvebakken Arpt', 1);
INSERT INTO public.airports VALUES (38, 'Alpine', 'ALE', 'US', 0, 0, 'Alpine Aprt', -100);
INSERT INTO public.airports VALUES (39, 'Alicante', 'ALC', 'ES', 38.28217, -0.558156, 'Alicante Arpt', 1);
INSERT INTO public.airports VALUES (40, 'Albany', 'ALB', 'US', 42.74827, -73.80169, 'Albany Cty Arpt', -5);
INSERT INTO public.airports VALUES (41, 'Almaty', 'ALA', 'KZ', 43.352074, 77.040504, 'Almaty Arpt', 6);
INSERT INTO public.airports VALUES (42, 'Aqtobe', 'AKX', 'KZ', 50.245834, 57.20667, 'Aqtobe Arpt', 5);
INSERT INTO public.airports VALUES (43, 'Akulivik', 'AKV', 'CA', 60.8186, -78.1486, 'Akulivik Arpt', -5);
INSERT INTO public.airports VALUES (44, 'Aksu', 'AKU', 'CN', 41.2625, 80.2917, 'Aksu Arpt', 8);
INSERT INTO public.airports VALUES (45, 'King Salmon', 'AKN', 'US', 58.676777, -156.64928, 'King Salmon Arpt', -9);
INSERT INTO public.airports VALUES (46, 'Auckland', 'AKL', 'NZ', -37.008057, 174.79167, 'Auckland Arpt', 12);
INSERT INTO public.airports VALUES (47, 'Asahikawa', 'AKJ', 'JP', 43.670834, 142.4475, 'Asahikawa Arpt', 9);
INSERT INTO public.airports VALUES (48, 'Aracaju', 'AJU', 'BR', -10.984, -37.07033, 'Santa Maria Arpt', -3);
INSERT INTO public.airports VALUES (49, 'Arvidsjaur', 'AJR', 'SE', 65.59028, 19.281944, 'Arvidsjaur Arpt', 1);
INSERT INTO public.airports VALUES (50, 'Agri', 'AJI', 'TR', 39.6546, 43.0271, 'Agri Airport', 2);
INSERT INTO public.airports VALUES (51, 'Al Jouf', 'AJF', 'SA', 0, 0, 'JOUF', 1);
INSERT INTO public.airports VALUES (52, 'Ajaccio', 'AJA', 'FR', 41.923637, 8.802917, 'Campo Dell Oro Arpt', 1);
INSERT INTO public.airports VALUES (53, 'Lake Of The Ozarks', 'AIZ', 'US', 38.096035, -92.549484, 'Lee C Fine Memorial', -5);
INSERT INTO public.airports VALUES (54, 'Atlantic City', 'ACY', 'US', 39.457584, -74.57716, 'Pomona Field', -5);
INSERT INTO public.airports VALUES (55, 'Atlantic City', 'AIY', 'US', 0, 0, 'Bader Field', -100);
INSERT INTO public.airports VALUES (56, 'Aitutaki', 'AIT', 'CK', -18.830921, -159.76424, 'Aitutaki Arpt', -10);
INSERT INTO public.airports VALUES (57, 'Wainwright', 'AIN', 'US', 70.638054, -159.99472, 'Wainwright Municipal Arpt', -9);
INSERT INTO public.airports VALUES (58, 'Aiken', 'AIK', 'US', 0, 0, 'Aiken Municipal Arpt', -100);
INSERT INTO public.airports VALUES (59, 'Anderson', 'AID', 'US', 40.1087, -85.613, 'Anderson Municipal Arpt', -100);
INSERT INTO public.airports VALUES (60, 'Alliance', 'AIA', 'US', 42.053333, -102.80389, 'Alliance Municipal', -7);
INSERT INTO public.airports VALUES (61, 'Al Hoceima', 'AHU', 'MA', 35.1771, -3.839525, 'Charif Al Idrissi Arpt', 0);
INSERT INTO public.airports VALUES (62, 'Alghero', 'AHO', 'IT', 40.632133, 8.290772, 'Fertilia Arpt', 1);
INSERT INTO public.airports VALUES (63, 'Athens', 'AHN', 'US', 33.9486, -83.3263, 'Athens Municipal', -5);
INSERT INTO public.airports VALUES (64, 'Amahai', 'AHI', 'ID', 0, 0, 'Amahai Airport', -100);
INSERT INTO public.airports VALUES (65, 'Abha', 'AHB', 'SA', 18.240368, 42.656624, 'Abha Airport', 3);
INSERT INTO public.airports VALUES (66, 'Aguascalientes', 'AGU', 'MX', 21.705559, -102.317856, 'Aguascalientes Municipal Arpt', -6);
INSERT INTO public.airports VALUES (67, 'Ciudad Del Este', 'AGT', 'PY', -25.4555, -54.843594, 'Alejo Garcia Arpt', -4);
INSERT INTO public.airports VALUES (68, 'Augusta', 'AGS', 'US', 33.369946, -81.9645, 'Bush Field', -5);
INSERT INTO public.airports VALUES (69, 'Augusta', 'DNL', 'US', 33.466503, -82.03938, 'Daniel Airport', -4);
INSERT INTO public.airports VALUES (70, 'Agra', 'AGR', 'IN', 27.15583, 77.96089, 'Kheria Arpt', 5);
INSERT INTO public.airports VALUES (71, 'Agrinion', 'AGQ', 'GR', 38.60202, 21.351208, 'Agrinion Arpt', 2);
INSERT INTO public.airports VALUES (72, 'Malaga', 'AGP', 'ES', 36.6749, -4.499106, 'Malaga Arpt', 1);
INSERT INTO public.airports VALUES (73, 'Magnolia', 'AGO', 'US', 0, 0, 'Magnolia Municipal', -100);
INSERT INTO public.airports VALUES (74, 'Angoon', 'AGN', 'US', 57.503613, -134.585, 'Angoon Arpt', -9);
INSERT INTO public.airports VALUES (75, 'Angelholm', 'AGH', 'SE', 56.2961, 12.8471, 'Angelholm Helsingborg Arpt', 1);
INSERT INTO public.airports VALUES (76, 'Agen', 'AGF', 'FR', 44.17472, 0.590556, 'La Garenne Arpt', 1);
INSERT INTO public.airports VALUES (77, 'Wangerooge', 'AGE', 'DE', 53.7828, 7.91389, 'Flugplatz Arpt', 1);
INSERT INTO public.airports VALUES (78, 'Augsburg', 'AGB', 'DE', 48.42516, 10.931764, 'Muehlhausen Arpt', 1);
INSERT INTO public.airports VALUES (79, 'Agadir', 'AGA', 'MA', 30.381353, -9.546311, 'Agadir Almassira Arpt', 0);
INSERT INTO public.airports VALUES (80, 'Afyon Arpt', 'AFY', 'TR', 38.726425, 30.601114, 'Afyon Arpt', 2);
INSERT INTO public.airports VALUES (81, 'Alta Floresta', 'AFL', 'BR', -9.866092, -56.106205, 'Alta Floresta Arpt', -4);
INSERT INTO public.airports VALUES (82, 'Ampara', 'AFK', 'LK', 0, 0, 'Kondavattavan Tank Arpt', -100);
INSERT INTO public.airports VALUES (83, 'San Rafael', 'AFA', 'AR', -34.588314, -68.403854, 'San Rafael Arpt', -3);
INSERT INTO public.airports VALUES (84, 'Akureyri', 'AEY', 'IS', 65.659996, -18.072702, 'Akureyri', 0);
INSERT INTO public.airports VALUES (85, 'Alexandria', 'ESF', 'US', 31.394903, -92.29577, 'Esler Field', -6);
INSERT INTO public.airports VALUES (86, 'Alexandria', 'AEX', 'US', 31.3274, -92.549835, 'Alexandria Intl Arpt', -6);
INSERT INTO public.airports VALUES (87, 'Aalesund', 'AES', 'NO', 62.56037, 6.110164, 'Vigra Airport', 1);
INSERT INTO public.airports VALUES (88, 'UDJ', 'UA', 'UA', 0, 0, 'UDJ', 0);
INSERT INTO public.airports VALUES (89, 'Adler Sochi', 'AER', 'RU', 43.44993, 39.95659, 'Alder Sochi Arpt', 4);
INSERT INTO public.airports VALUES (90, 'Albert Lea', 'AEL', 'US', 0, 0, 'Albert Lea Arpt', -100);
INSERT INTO public.airports VALUES (91, 'Algeciras', 'AEI', 'ES', 0, 0, 'Algeciras Arpt', -100);
INSERT INTO public.airports VALUES (92, 'San Andres', 'ADZ', 'CO', 12.583594, -81.71119, 'San Andres Island Arpt', -5);
INSERT INTO public.airports VALUES (93, 'St Andrews', 'ADX', 'GB', 56.37289, -2.868444, 'Leuchars Arpt', 0);
INSERT INTO public.airports VALUES (94, 'Camp Springs', 'ADW', 'US', 38.810806, -76.86703, 'Andrews Air Force Base', -5);
INSERT INTO public.airports VALUES (95, 'Ardabil', 'ADU', 'IR', 38.32568, 48.424355, 'Ardabil Arpt', 3);
INSERT INTO public.airports VALUES (96, 'Ada OK', 'ADT', 'US', 0, 0, 'Ada Municipal Arpt', -100);
INSERT INTO public.airports VALUES (97, 'Kodiak', 'ADQ', 'US', 57.749966, -152.49385, 'Kodiak Arpt', -9);
INSERT INTO public.airports VALUES (98, 'Kodiak', 'KDK', 'US', 0, 0, 'Kodiak Municipal', -100);
INSERT INTO public.airports VALUES (99, 'Ardmore', 'ADM', 'US', 34.300835, -97.00889, 'Ardmore Municipal Arpt', -6);
INSERT INTO public.airports VALUES (100, 'Adelaide', 'ADL', 'AU', -34.945, 138.53056, 'Adelaide Arpt', 9);
INSERT INTO public.airports VALUES (101, 'Adak Island', 'ADK', 'US', 51.878, -176.646, 'Adak Island Ns', -10);
INSERT INTO public.airports VALUES (102, 'Aldan Airport', 'ADH', 'RU', 0, 0, 'Aldan Airport', -2);
INSERT INTO public.airports VALUES (103, 'Adrian', 'ADG', 'US', 0, 0, 'Lenawee County Arpt', -100);
INSERT INTO public.airports VALUES (104, 'Adiyaman', 'ADF', 'TR', 37.7314, 38.4689, 'Adiyaman Airport', 2);
INSERT INTO public.airports VALUES (105, 'Aden', 'ADE', 'YE', 12.829542, 45.028793, 'Yemen Intl Arpt', 3);
INSERT INTO public.airports VALUES (106, 'Addis Ababa', 'ADD', 'ET', 8.977889, 38.79932, 'Bole Airport', 3);
INSERT INTO public.airports VALUES (107, 'Adana', 'ADA', 'TR', 36.982166, 35.280388, 'Adana Arpt', 2);
INSERT INTO public.airports VALUES (108, 'Xingyi', 'ACX', 'CN', 25.0882, 104.9587, 'Xingyi Arpt', 8);
INSERT INTO public.airports VALUES (109, 'Eureka', 'ACV', 'US', 40.97811, -124.10861, 'Arcata Eureka Arpt', -8);
INSERT INTO public.airports VALUES (110, 'Waco', 'ACT', 'US', 31.611288, -97.23052, 'Madison Cooper Arpt', -6);
INSERT INTO public.airports VALUES (111, 'Achinsk Airport', 'ACS', 'RU', 0, 0, 'Achinsk Airport', -2);
INSERT INTO public.airports VALUES (112, 'Ascona', 'ACO', 'CH', 0, 0, 'Ascona Arpt', -100);
INSERT INTO public.airports VALUES (113, 'Nantucket', 'ACK', 'US', 41.25305, -70.06018, 'Nantucket Memorial', -5);
INSERT INTO public.airports VALUES (114, 'Alderney', 'ACI', 'GB', 49.706112, -2.214722, 'The Blaye Arpt', 0);
INSERT INTO public.airports VALUES (115, 'Altenrhein', 'ACH', 'CH', 47.48503, 9.560775, 'Altenrhein Arpt', 1);
INSERT INTO public.airports VALUES (116, 'Lanzarote', 'ACE', 'ES', 28.945463, -13.605225, 'Lanzarote Airport', 0);
INSERT INTO public.airports VALUES (117, 'Accra', 'ACC', 'GH', 5.605186, -0.166786, 'Kotoka Airport', 0);
INSERT INTO public.airports VALUES (118, 'Acapulco', 'ACA', 'MX', 16.757061, -99.75395, 'Alvarez Intl Arpt', -6);
INSERT INTO public.airports VALUES (119, 'Aberdeen', 'ABZ', 'GB', 57.201942, -2.197778, 'Dyce Airport', 0);
INSERT INTO public.airports VALUES (120, 'Aberdeen', 'ZXA', 'GB', 0, 0, 'Aberdeen ScotRail Station', -100);
INSERT INTO public.airports VALUES (121, 'Albany', 'ABY', 'US', 31.5355, -84.1945, 'Dougherty Cty Arpt', -5);
INSERT INTO public.airports VALUES (122, 'Albury', 'ABX', 'AU', -36.06778, 146.95805, 'Albury Airport', 10);
INSERT INTO public.airports VALUES (123, 'Abuja', 'ABV', 'NG', 9.006792, 7.263172, 'Abuja Intl', 1);
INSERT INTO public.airports VALUES (124, 'Al Baha', 'ABT', 'SA', 20.296139, 41.634277, 'Al Aqiq', 3);
INSERT INTO public.airports VALUES (125, 'Abu Simbel', 'ABS', 'EG', 22.375954, 31.611723, 'Abu Simbel Arpt', 2);
INSERT INTO public.airports VALUES (126, 'Aberdeen', 'ABR', 'US', 45.4491, -98.4218, 'Aberdeen Arpt', -6);
INSERT INTO public.airports VALUES (127, 'Albuquerque', 'ABQ', 'US', 35.040222, -106.60919, 'Albuquerque Intl Arpt', -7);
INSERT INTO public.airports VALUES (128, 'Bamaga', 'ABM', 'AU', -10.950833, 142.45944, 'Bamaga Arpt', 10);
INSERT INTO public.airports VALUES (129, 'Ambler', 'ABL', 'US', 67.10639, -157.8575, 'Ambler Arpt', -9);
INSERT INTO public.airports VALUES (130, 'Abilene', 'ABI', 'US', 32.41132, -99.6819, 'Abilene Municipal Arpt', -6);
INSERT INTO public.airports VALUES (131, 'Allentown', 'ABE', 'US', 40.652084, -75.4408, 'Lehigh Valley Intl Arpt', -5);
INSERT INTO public.airports VALUES (132, 'Abadan', 'ABD', 'IR', 30.37111, 48.228333, 'Abadan Arpt', 4);
INSERT INTO public.airports VALUES (133, 'Albacete', 'ABC', 'ES', 38.948, -1.863, 'Los Llanos Arpt', -100);
INSERT INTO public.airports VALUES (134, 'Abakan', 'ABA', 'RU', 53.74, 91.385, 'Abakan Arpt', 8);
INSERT INTO public.airports VALUES (135, 'Al Ghaydah', 'AAY', 'YE', 16.191668, 52.175, 'Al Ghaydah Arpt', 3);
INSERT INTO public.airports VALUES (136, 'Altay', 'AAT', 'CN', 47.86667, 88.11667, 'Altay Arpt', 8);
INSERT INTO public.airports VALUES (137, 'Aarhus', 'AAR', 'DK', 56.30002, 10.619008, 'Tirstrup Arpt', 1);
INSERT INTO public.airports VALUES (138, 'Aarhus', 'ZID', 'DK', 0, 0, 'Aarhus Bus Service', -100);
INSERT INTO public.airports VALUES (139, 'Anapa', 'AAQ', 'RU', 45.002098, 37.34727, 'Anapa Arpt', 4);
INSERT INTO public.airports VALUES (140, 'Al Ain', 'AAN', 'AE', 24.261667, 55.609165, 'Al Ain Arpt', 4);
INSERT INTO public.airports VALUES (141, 'Mala Mala', 'AAM', 'ZA', -24.818111, 31.544584, 'Mala Mala Arpt', 2);
INSERT INTO public.airports VALUES (142, 'Aalborg', 'AAL', 'DK', 57.09279, 9.849164, 'Aalborg Arpt', 1);
INSERT INTO public.airports VALUES (143, 'Aachen', 'AAH', 'DE', 50.823193, 6.186389, 'Aachen Merzbruck Arpt', 1);
INSERT INTO public.airports VALUES (144, 'Arapoti', 'AAG', 'BR', -24.1036, -49.79, 'Arapoti Arpt', -100);
INSERT INTO public.airports VALUES (145, 'Apalachicola', 'AAF', 'US', 29.727608, -85.02744, 'Apalachicola Municipal Arpt', -6);
INSERT INTO public.airports VALUES (146, 'Annaba', 'AAE', 'DZ', 36.822224, 7.809167, 'Les Salines Arpt', 1);
INSERT INTO public.airports VALUES (147, 'Andenes', 'ANX', 'NO', 69.2925, 16.144167, 'Andenes Arpt', 1);
INSERT INTO public.airports VALUES (148, 'Altenburg', 'AOC', 'DE', 50.981815, 12.506361, 'Altenburg Nobitz Arpt', 1);
INSERT INTO public.airports VALUES (149, 'Eskisehir', 'AOE', 'TR', 39.809856, 30.519379, 'Anadolu University Airport', 2);
INSERT INTO public.airports VALUES (150, 'Lima', 'AOH', 'US', 0, 0, 'Allen County Arpt', -100);
INSERT INTO public.airports VALUES (151, 'Ancona', 'AOI', 'IT', 43.61639, 13.362222, 'Falconara Arpt', 1);
INSERT INTO public.airports VALUES (152, 'Aomori', 'AOJ', 'JP', 40.734722, 140.69083, 'Aomori Arpt', 9);
INSERT INTO public.airports VALUES (153, 'Karpathos', 'AOK', 'GR', 35.42141, 27.146008, 'Karpathos Arpt', 2);
INSERT INTO public.airports VALUES (154, 'Paso De Los Libres', 'AOL', 'AR', -29.689425, -57.152077, 'Paso De Los Libres Arpt', -3);
INSERT INTO public.airports VALUES (155, 'Altoona', 'AOO', 'US', 40.29637, -78.32002, 'Blair Cty Arpt', -5);
INSERT INTO public.airports VALUES (156, 'Alor Setar', 'AOR', 'MY', 6.189667, 100.398186, 'Sultan Abdul Hamlin Arpt', 8);
INSERT INTO public.airports VALUES (157, 'Aosta', 'AOT', 'IT', 45.738457, 7.368719, 'Corrado Gex Arpt', 1);
INSERT INTO public.airports VALUES (158, 'Napa', 'APC', 'US', 38.213196, -122.28069, 'Napa Cty Arpt', -7);
INSERT INTO public.airports VALUES (159, 'Naples', 'APF', 'US', 26.152618, -81.77529, 'Naples Municipal', -5);
INSERT INTO public.airports VALUES (160, 'Nampula', 'APL', 'MZ', -15.105611, 39.2818, 'Nampula Arpt', 2);
INSERT INTO public.airports VALUES (161, 'Alpena', 'APN', 'US', 45.0781, -83.5603, 'Phelps Collins Arpt', -5);
INSERT INTO public.airports VALUES (162, 'Apartado', 'APO', 'CO', 7.033, -77.2, 'Apartado Arpt', -5);
INSERT INTO public.airports VALUES (163, 'Anapolis', 'APS', 'BR', -16.3619, -48.9275, 'Anapolis Arpt', -100);
INSERT INTO public.airports VALUES (164, 'Apia', 'APW', 'WS', -13.829969, -172.00833, 'Apia Airport', -11);
INSERT INTO public.airports VALUES (165, 'Apia', 'FGI', 'WS', -13.848611, -171.74083, 'Fagali Arpt', -11);
INSERT INTO public.airports VALUES (166, 'Araraquara', 'AQA', 'BR', -21.812, -48.133026, 'Araraquara Arpt', -3);
INSERT INTO public.airports VALUES (167, 'Anqing', 'AQG', 'CN', 30.5822, 117.0502, 'Anqing Arpt', 8);
INSERT INTO public.airports VALUES (168, 'Qaisumah', 'AQI', 'SA', 28.335192, 46.12507, 'Qaisumah Arpt', 3);
INSERT INTO public.airports VALUES (169, 'Aqaba', 'AQJ', 'JO', 29.61162, 35.018066, 'Aqaba Airport', 2);
INSERT INTO public.airports VALUES (170, 'Arequipa', 'AQP', 'PE', -16.341072, -71.583084, 'Rodriguez Ballon Arpt', -5);
INSERT INTO public.airports VALUES (171, 'Ann Arbor', 'ARB', 'US', 0, 0, 'Ann Arbor Municipal', -100);
INSERT INTO public.airports VALUES (172, 'Arkhangelsk', 'ARH', 'RU', 64.36028, 40.43017, 'Arkhangelsk Arpt', 4);
INSERT INTO public.airports VALUES (173, 'Arica', 'ARI', 'CL', -18.348532, -70.338745, 'Chacalluta Arpt', -4);
INSERT INTO public.airports VALUES (174, 'Arusha', 'ARK', 'TZ', -3.367794, 36.63333, 'Arusha Arpt', 3);
INSERT INTO public.airports VALUES (175, 'Armidale', 'ARM', 'AU', -30.528055, 151.61722, 'Armidale Arpt', 10);
INSERT INTO public.airports VALUES (176, 'Watertown', 'ART', 'US', 43.99192, -76.021736, 'Watertown Arpt', -5);
INSERT INTO public.airports VALUES (177, 'Aracatuba', 'ARU', 'BR', -21.141342, -50.42472, 'Aracatuba Arpt', -3);
INSERT INTO public.airports VALUES (178, 'Minocqua', 'ARV', 'US', 45.927776, -89.730835, 'Noble F Lee Memorial Field', -6);
INSERT INTO public.airports VALUES (179, 'Arad', 'ARW', 'RO', 46.17655, 21.262022, 'Arad Arpt', 2);
INSERT INTO public.airports VALUES (180, 'Ararat', 'ARY', 'AU', -37.3119, 142.9906, 'Ararat Arpt', -100);
INSERT INTO public.airports VALUES (181, 'Ashgabat', 'ASB', 'TM', 37.986813, 58.360966, 'Ashgabat Arpt', 5);
INSERT INTO public.airports VALUES (182, 'Andros Town', 'ASD', 'BS', 24.698282, -77.79561, 'Andros Town Arpt', -5);
INSERT INTO public.airports VALUES (183, 'Aspen', 'ASE', 'US', 39.2232, -106.869, 'Pitkin Cty Arptt Sardy Fld', -7);
INSERT INTO public.airports VALUES (184, 'Astrakhan', 'ASF', 'RU', 46.283333, 48.00628, 'Astrakhan Arpt', 6);
INSERT INTO public.airports VALUES (185, 'Nashua', 'ASH', 'US', 42.78175, -71.51478, 'Boire Field Arpt', -4);
INSERT INTO public.airports VALUES (186, 'Amami O Shima', 'ASJ', 'JP', 28.430634, 129.71254, 'Amami O Shima Arpt', 9);
INSERT INTO public.airports VALUES (187, 'Yamoussouro', 'ASK', 'CI', 6.903167, -5.365581, 'Yamoussoukro Arpt', 0);
INSERT INTO public.airports VALUES (188, 'Marshall', 'ASL', 'US', 0, 0, 'Harrison County Arpt', -100);
INSERT INTO public.airports VALUES (189, 'Asmara', 'ASM', 'ER', 15.291853, 38.910667, 'Asmara Intl Arpt', 3);
INSERT INTO public.airports VALUES (190, 'Talladega', 'ASN', 'US', 0, 0, 'Talladega Arpt', -100);
INSERT INTO public.airports VALUES (191, 'Alice Springs', 'ASP', 'AU', -23.806667, 133.90222, 'Alice Springs Arpt', 9);
INSERT INTO public.airports VALUES (192, 'Kayseri', 'ASR', 'TR', 38.770386, 35.495426, 'Kayseri Arpt', 2);
INSERT INTO public.airports VALUES (193, 'Astoria', 'AST', 'US', 46.15797, -123.87869, 'Astoria Arpt', -8);
INSERT INTO public.airports VALUES (194, 'Asuncion', 'ASU', 'PY', -25.23985, -57.519135, 'Salvio Pettirosse Arpt', -4);
INSERT INTO public.airports VALUES (195, 'Aswan', 'ASW', 'EG', 23.964355, 32.819977, 'Daraw Arpt', 2);
INSERT INTO public.airports VALUES (196, 'Arthurs Town', 'ATC', 'BS', 24.629417, -75.673775, 'Arthurs Town Arpt', -5);
INSERT INTO public.airports VALUES (197, 'Athens', 'ATH', 'GR', 37.93636, 23.944468, 'Eleftherios Venizelos Intl Arpt', 2);
INSERT INTO public.airports VALUES (198, 'Athens', 'HEW', 'GR', 37.8933, 23.7261, 'Athens Hellinikon Arpt', 2);
INSERT INTO public.airports VALUES (199, 'Artigas', 'ATI', 'UY', 0, 0, 'Artigas Arpt', -100);
INSERT INTO public.airports VALUES (200, 'Atlanta', 'PDK', 'US', 33.87561, -84.30197, 'Dekalb Peachtree', -4);
INSERT INTO public.airports VALUES (201, 'Atlanta', 'FTY', 'US', 33.7791, -84.5214, 'Fulton Cty Arpt', -5);
INSERT INTO public.airports VALUES (202, 'Atlanta', 'ATL', 'US', 33.63672, -84.42807, 'Hartsfield Jackson Intl Arpt', -5);
INSERT INTO public.airports VALUES (203, 'Altamira', 'ATM', 'BR', -3.253906, -52.25398, 'Altamira Arpt', -3);
INSERT INTO public.airports VALUES (204, 'Athens', 'ATO', 'US', 0, 0, 'Ohio University Arpt', -100);
INSERT INTO public.airports VALUES (205, 'Amritsar', 'ATQ', 'IN', 31.709595, 74.797264, 'Raja Sansi Arpt', 5);
INSERT INTO public.airports VALUES (206, 'Atar', 'ATR', 'MR', 20.506828, -13.043194, 'Mouakchott Arpt', 0);
INSERT INTO public.airports VALUES (207, 'Appleton', 'ATW', 'US', 44.257526, -88.507576, 'Outagamie Cty Arpt', -6);
INSERT INTO public.airports VALUES (208, 'Watertown', 'ATY', 'US', 44.914, -97.1547, 'Watertown Municipal', -6);
INSERT INTO public.airports VALUES (209, 'Aruba', 'AUA', 'AW', 12.501389, -70.01522, 'Reina Beatrix Arpt', -4);
INSERT INTO public.airports VALUES (210, 'Augusta', 'AUG', 'US', 44.32065, -69.79732, 'Maine State Arpt', -5);
INSERT INTO public.airports VALUES (211, 'Abu Dhabi', 'ZVJ', 'AE', 0, 0, 'Abu Dhabi-bus Station', -100);
INSERT INTO public.airports VALUES (212, 'Abu Dhabi', 'AUH', 'AE', 24.432972, 54.65114, 'Dhabi Intl Arpt', 4);
INSERT INTO public.airports VALUES (213, 'Auburn', 'AUO', 'US', 0, 0, 'Auburn Opelika', -100);
INSERT INTO public.airports VALUES (214, 'Atuona', 'AUQ', 'PF', -9.768794, -139.01126, 'Atuona Arpt', -9);
INSERT INTO public.airports VALUES (215, 'Aurillac', 'AUR', 'FR', 44.891388, 2.421944, 'Tronquieres Arpt', 1);
INSERT INTO public.airports VALUES (216, 'Austin', 'AUS', 'US', 30.194529, -97.66989, 'Bergstrom Intl Arpt', -6);
INSERT INTO public.airports VALUES (217, 'Aurukun Mission', 'AUU', 'AU', -13.3539, 141.721, 'Aurukin Arpt', 10);
INSERT INTO public.airports VALUES (218, 'Wausau', 'AUW', 'US', 44.926285, -89.627, 'Wausau Municipal Arpt', -6);
INSERT INTO public.airports VALUES (219, 'Wausau', 'CWA', 'US', 44.772724, -89.64664, 'Central Wisconsin Arpt', -6);
INSERT INTO public.airports VALUES (220, 'Araguaina', 'AUX', 'BR', -7.228333, -48.240833, 'Araguaina Arpt', -3);
INSERT INTO public.airports VALUES (221, 'Aurora', 'AUZ', 'US', 0, 0, 'Aurora Municipal Arpt', -100);
INSERT INTO public.airports VALUES (222, 'Ciego De Avila', 'AVI', 'CU', 22.027054, -78.78962, 'Maximo Gomez Arpt', -5);
INSERT INTO public.airports VALUES (223, 'Asheville', 'AVL', 'US', 35.436195, -82.54181, 'Asheville Municipal Arpt', -5);
INSERT INTO public.airports VALUES (224, 'Avignon', 'XZN', 'FR', 46.4, 5.8333, 'Avignon Railway Station', -100);
INSERT INTO public.airports VALUES (225, 'Avignon', 'AVN', 'FR', 43.9073, 4.901831, 'Avignon Caumont Arpt', 1);
INSERT INTO public.airports VALUES (226, 'Scranton', 'AVP', 'US', 41.338478, -75.723404, 'Wilkes Barre Scranton Intl Arpt', -5);
INSERT INTO public.airports VALUES (227, 'Catalina Island', 'SXC', 'US', 0, 0, 'Catalina Arpt', -100);
INSERT INTO public.airports VALUES (228, 'Anguilla', 'AXA', 'AI', 18.204834, -63.055084, 'Wallblake Municipal', -4);
INSERT INTO public.airports VALUES (229, 'Alexandroupolis', 'AXD', 'GR', 40.85587, 25.956264, 'Dhmokritos Arpt', 2);
INSERT INTO public.airports VALUES (230, 'Armenia', 'AXM', 'CO', 4.452775, -75.76645, 'El Eden Arpt', -5);
INSERT INTO public.airports VALUES (231, 'Akita', 'AXT', 'JP', 39.615555, 140.21861, 'Akita Airport', 9);
INSERT INTO public.airports VALUES (232, 'Wapakoneta', 'AXV', 'US', 0, 0, 'Neil Armstrong Arpt', -100);
INSERT INTO public.airports VALUES (233, 'Ayacucho', 'AYP', 'PE', -13.154819, -74.204414, 'Yanamilla Arpt', -5);
INSERT INTO public.airports VALUES (234, 'Ayers Rock', 'AYQ', 'AU', -25.186111, 130.97556, 'Connellan Arpt', 9);
INSERT INTO public.airports VALUES (235, 'Ayr Au', 'AYR', 'AU', -19.5958, 147.3258, 'Ayr Arpt', -100);
INSERT INTO public.airports VALUES (236, 'Waycross', 'AYS', 'US', 31.2491, -82.3955, 'Ware County Arpt', -100);
INSERT INTO public.airports VALUES (237, 'Antalya', 'AYT', 'TR', 36.89873, 30.80046, 'Antalya Airport', 2);
INSERT INTO public.airports VALUES (238, 'Yazd', 'AZD', 'IR', 31.904907, 54.276505, 'Yazd Arpt', 4);
INSERT INTO public.airports VALUES (239, 'Apatzingan', 'AZG', 'MX', 0, 0, 'Apatzingan Arpt', -100);
INSERT INTO public.airports VALUES (240, 'Andizhan', 'AZN', 'UZ', 40.7277, 72.294, 'Andizhan', 5);
INSERT INTO public.airports VALUES (241, 'Kalamazoo', 'AZO', 'US', 42.234875, -85.552055, 'Kalamazoo Cty Arpt', -5);
INSERT INTO public.airports VALUES (242, 'Samana', 'AZS', 'DO', 19.267, -69.742, 'Samana International Arpt', -4);
INSERT INTO public.airports VALUES (243, 'Baguio', 'BAG', 'PH', 16.375103, 120.61964, 'Loakan Arpt', 8);
INSERT INTO public.airports VALUES (244, 'Muharraq', 'BAH', 'BH', 26.270834, 50.63361, 'Bahrain Intl Arpt', 3);
INSERT INTO public.airports VALUES (245, 'Baku', 'GYD', 'AZ', 40.4675, 50.046665, 'Heydar Aliyev Intl Arpt', 4);
INSERT INTO public.airports VALUES (246, 'Baku', 'ZXT', 'AZ', 0, 0, 'Zabrat Arpt', -100);
INSERT INTO public.airports VALUES (247, 'Baku', 'BAK', 'AZ', 40.4675, 50.046665, 'Baku Airport', 4);
INSERT INTO public.airports VALUES (248, 'Batman', 'BAL', 'TR', 37.92897, 41.116585, 'Batman Arpt', 2);
INSERT INTO public.airports VALUES (249, 'Ban Mak Khaen', 'BAO', 'TH', 0, 0, 'Udorn Arpt', -100);
INSERT INTO public.airports VALUES (250, 'Barranquilla', 'BAQ', 'CO', 10.889589, -74.78082, 'E Cortissoz Arpt', -5);
INSERT INTO public.airports VALUES (251, 'Balalae', 'BAS', 'SB', -6.967, 155.883, 'Balalae Arpt', 11);
INSERT INTO public.airports VALUES (252, 'Barretos', 'BAT', 'BR', -20.585, -48.5953, 'Barretos Arpt', -100);
INSERT INTO public.airports VALUES (253, 'Bauru', 'BAU', 'BR', -22.345041, -49.0538, 'Bauru Arpt', -3);
INSERT INTO public.airports VALUES (254, 'Baotou', 'BAV', 'CN', 40.56, 109.997, 'Baotou Arpt', 8);
INSERT INTO public.airports VALUES (255, 'Barnaul', 'BAX', 'RU', 53.363773, 83.538536, 'Barnaul Arpt', 7);
INSERT INTO public.airports VALUES (256, 'Baia Mare', 'BAY', 'RO', 47.65839, 23.470022, 'Baia Mare Arpt', 2);
INSERT INTO public.airports VALUES (257, 'Balmaceda', 'BBA', 'CL', -45.916058, -71.689476, 'Teniente Vidal Airport', -3);
INSERT INTO public.airports VALUES (258, 'Barth', 'BBH', 'DE', 54.33754, 12.699705, 'Barth Arpt', 1);
INSERT INTO public.airports VALUES (259, 'Bhubaneswar', 'BBI', 'IN', 20.244364, 85.81778, 'Biju Patnaik Arpt', 6);
INSERT INTO public.airports VALUES (260, 'Bitburg', 'BBJ', 'DE', 51.19353, 14.519747, 'Bitburg Air Base', 1);
INSERT INTO public.airports VALUES (261, 'Kasane', 'BBK', 'BW', -17.832874, 25.1624, 'Kasane Arpt', 2);
INSERT INTO public.airports VALUES (262, 'Bario', 'BBN', 'MY', 3.73389, 115.479, 'Bario Arpt', 8);
INSERT INTO public.airports VALUES (263, 'Basse Terre', 'BBR', 'GP', 16.0133, -61.7422, 'Baillif Arpt', -4);
INSERT INTO public.airports VALUES (264, 'Broken Bow', 'BBW', 'US', 41.4367, -99.6417, 'Broken Bow Municipal', -100);
INSERT INTO public.airports VALUES (265, 'Blacksburg', 'BCB', 'US', 0, 0, 'Virginia Tech Arpt', -100);
INSERT INTO public.airports VALUES (266, 'Bacolod', 'BCD', 'PH', 10.642511, 122.92962, 'Bacolod Arpt', 8);
INSERT INTO public.airports VALUES (267, 'Bryce', 'BCE', 'US', 37.706444, -112.145805, 'Bryce Arpt', -7);
INSERT INTO public.airports VALUES (268, 'Baucau', 'BCH', 'TL', -8.4854, 126.3993, 'English Madeira Arpt', -100);
INSERT INTO public.airports VALUES (269, 'Barcaldine', 'BCI', 'AU', -23.5653, 145.307, 'Barcaldine Arpt', 10);
INSERT INTO public.airports VALUES (270, 'Bacau', 'BCM', 'RO', 46.521946, 26.910278, 'Bacau Arpt', 2);
INSERT INTO public.airports VALUES (271, 'Barcelona', 'BCN', 'ES', 41.297077, 2.078464, 'Barcelona Arpt', 1);
INSERT INTO public.airports VALUES (272, 'Bermuda', 'BDA', 'BM', 32.36404, -64.6787, 'Bermuda International', -4);
INSERT INTO public.airports VALUES (273, 'Bundaberg', 'BDB', 'AU', -24.903889, 152.3186, 'Bundaberg Arpt', 10);
INSERT INTO public.airports VALUES (274, 'Badu Island', 'BDD', 'AU', -10.15, 141.175, 'Badu Island Arpt', 9);
INSERT INTO public.airports VALUES (275, 'Banjarmasin', 'BDJ', 'ID', -3.442356, 114.76255, 'Sjamsudin Noor Arpt', 8);
INSERT INTO public.airports VALUES (276, 'Bandirma Arpt', 'BDM', 'TR', 40.31797, 27.977694, 'Bandirma Arpt', 2);
INSERT INTO public.airports VALUES (277, 'Bandung', 'BDO', 'ID', -6.900625, 107.576294, 'Husein Sastranegara Arpt', 7);
INSERT INTO public.airports VALUES (278, 'Vadodara', 'BDQ', 'IN', 22.336164, 73.22629, 'Vadodara Arpt', 5);
INSERT INTO public.airports VALUES (279, 'Bridgeport', 'BDR', 'US', 41.16347, -73.12617, 'Sikorsky Memorial Arpt', -5);
INSERT INTO public.airports VALUES (280, 'Brindisi', 'BDS', 'IT', 40.657635, 17.947033, 'Papola Casale Arpt', 1);
INSERT INTO public.airports VALUES (281, 'Bardufoss', 'BDU', 'NO', 69.055756, 18.540356, 'Bardufoss Arpt', 1);
INSERT INTO public.airports VALUES (282, 'Benbecula', 'BEB', 'GB', 57.48111, -7.362778, 'Benbecula Arpt', 0);
INSERT INTO public.airports VALUES (283, 'Bedford', 'BED', 'US', 42.46995, -71.28903, 'Bedford Arpt', -5);
INSERT INTO public.airports VALUES (284, 'Belgrade', 'BJY', 'RS', 44.9236, 20.279, 'Batajnica Arpt', -100);
INSERT INTO public.airports VALUES (285, 'Belgrade', 'BEG', 'RS', 44.818443, 20.30914, 'Belgrade Beograd Arpt', 1);
INSERT INTO public.airports VALUES (286, 'Benton Harbor', 'BEH', 'US', 42.128582, -86.4285, 'Ross Field', -5);
INSERT INTO public.airports VALUES (287, 'Belem', 'BEL', 'BR', -1.37925, -48.47629, 'Val De Cans Arpt', -3);
INSERT INTO public.airports VALUES (288, 'Benghazi', 'BEN', 'LY', 32.096786, 20.269472, 'Benina Intl Arpt', 1);
INSERT INTO public.airports VALUES (289, 'Bury St Edmunds', 'BEQ', 'GB', 52.34261, 0.772939, 'Honington Arpt', 0);
INSERT INTO public.airports VALUES (290, 'Berlin', 'BML', 'DE', 44.574722, -71.17639, 'Berlin Arpt', -4);
INSERT INTO public.airports VALUES (291, 'Berlin', 'SXF', 'DE', 52.38, 13.5225, 'Schoenefeld Arpt', 1);
INSERT INTO public.airports VALUES (292, 'Berlin', 'TXL', 'DE', 52.559685, 13.287711, 'Tegel Airport', 1);
INSERT INTO public.airports VALUES (293, 'Brest', 'BES', 'FR', 48.44791, -4.418539, 'Guipavas Arpt', 1);
INSERT INTO public.airports VALUES (294, 'Bethel', 'BET', 'US', 60.779778, -161.838, 'Bethel Airport', -9);
INSERT INTO public.airports VALUES (295, 'Bedourie', 'BEU', 'AU', -24.3461, 139.46, 'Bedourie Arpt', 10);
INSERT INTO public.airports VALUES (296, 'Beira', 'BEW', 'MZ', -19.79642, 34.907555, 'Beira Arpt', 2);
INSERT INTO public.airports VALUES (297, 'Beirut', 'BEY', 'LB', 33.82093, 35.488388, 'Beirut Intl Arpt', 2);
INSERT INTO public.airports VALUES (298, 'Beru', 'BEZ', 'KI', -1.254722, 176.00722, 'Beru Arpt', 10);
INSERT INTO public.airports VALUES (299, 'Bradford', 'BFD', 'US', 41.8031, -78.6401, 'Bradford Regional Arpt', -5);
INSERT INTO public.airports VALUES (300, 'Bielefeld', 'BFE', 'DE', 0, 0, 'Bielefeld Arpt', -100);
INSERT INTO public.airports VALUES (301, 'Scottsbluff', 'BFF', 'US', 41.874, -103.596, 'Scottsbluff Municipal', -7);
INSERT INTO public.airports VALUES (302, 'Bullfrog Basin', 'BFG', 'US', 0, 0, 'Bullfrog Basin Arpt', -100);
INSERT INTO public.airports VALUES (303, 'Ba City', 'BFJ', 'FJ', 0, 0, 'Ba Arpt', -100);
INSERT INTO public.airports VALUES (304, 'Bakersfield', 'BFL', 'US', 35.433598, -119.05677, 'Meadows Field', -8);
INSERT INTO public.airports VALUES (305, 'Bloemfontein', 'BFN', 'ZA', -29.092722, 26.302444, 'Bloemfontein International', 2);
INSERT INTO public.airports VALUES (306, 'Beaver Falls', 'BFP', 'US', 40.7725, -80.3915, 'Beaver Falls Arpt', -100);
INSERT INTO public.airports VALUES (307, 'Bedford', 'BFR', 'US', 0, 0, 'Virgil I Grissom Municipal', -100);
INSERT INTO public.airports VALUES (308, 'Belfast', 'BFS', 'GB', 54.6575, -6.215833, 'Belfast Intl Arpt', 0);
INSERT INTO public.airports VALUES (309, 'Belfast', 'BHD', 'GB', 54.618057, -5.8725, 'Belfast City Arpt', 0);
INSERT INTO public.airports VALUES (310, 'Beaufort', 'BFT', 'US', 32.41083, -80.635, 'Beaufort County Arpt', -5);
INSERT INTO public.airports VALUES (311, 'Buri Ram', 'BFV', 'TH', 15.229539, 103.25323, 'Buri Ram Arpt', 7);
INSERT INTO public.airports VALUES (312, 'Bucaramanga', 'BGA', 'CO', 7.1265, -73.18478, 'Palo Negro Arpt', -5);
INSERT INTO public.airports VALUES (313, 'Braganca', 'BGC', 'PT', 41.8578, -6.707125, 'Braganca Arpt', 0);
INSERT INTO public.airports VALUES (314, 'Bangui', 'BGF', 'CF', 4.398475, 18.518785, 'Bangui Airport', 1);
INSERT INTO public.airports VALUES (315, 'Bridgetown', 'BGI', 'BB', 13.074603, -59.492455, 'Grantley Adams Intl Arpt', -4);
INSERT INTO public.airports VALUES (316, 'Binghamton', 'BGM', 'US', 42.20869, -75.979836, 'Edwin A Link Field', -5);
INSERT INTO public.airports VALUES (317, 'Bergen', 'XKN', 'NO', 0, 0, 'Finse Rail Station', -100);
INSERT INTO public.airports VALUES (318, 'Bergen', 'BGO', 'NO', 60.293385, 5.218142, 'Flesland Airport', 1);
INSERT INTO public.airports VALUES (319, 'Bergen', 'XVK', 'NO', 0, 0, 'Voss Rail Station', -100);
INSERT INTO public.airports VALUES (320, 'Bangor', 'BGR', 'US', 44.807446, -68.82814, 'Bangor Intl Arpt', -5);
INSERT INTO public.airports VALUES (321, 'Bento Goncalves', 'BGV', 'BR', 0, 0, 'Bento Goncalves Arpt', -100);
INSERT INTO public.airports VALUES (322, 'Baghdad', 'BGW', 'IQ', 33.26254, 44.234577, 'Baghdad International Arpt', 3);
INSERT INTO public.airports VALUES (323, 'Bergamo', 'BGY', 'IT', 45.67389, 9.704166, 'Orio Al Serio Arpt', 1);
INSERT INTO public.airports VALUES (324, 'Bar Harbor', 'BHB', 'US', 44.449768, -68.361565, 'Hancock County', -5);
INSERT INTO public.airports VALUES (325, 'Blenheim', 'BHE', 'NZ', -41.518333, 173.87029, 'Woodbourne Arpt', 12);
INSERT INTO public.airports VALUES (326, 'Bahia Blanca', 'BHI', 'AR', -38.724968, -62.169315, 'Commandante Airport', -3);
INSERT INTO public.airports VALUES (327, 'Bhuj', 'BHJ', 'IN', 23.287828, 69.67015, 'Rudra Mata Arpt', 5);
INSERT INTO public.airports VALUES (328, 'Bukhara', 'BHK', 'UZ', 39.775, 64.48333, 'Bukhara Arpt', 5);
INSERT INTO public.airports VALUES (329, 'Bahia De Los Angeles', 'BHL', 'MX', 0, 0, 'Bahia De Los Angeles Arpt', -100);
INSERT INTO public.airports VALUES (330, 'Birmingham', 'BHM', 'US', 33.562943, -86.75355, 'Birmingham International Arpt', -6);
INSERT INTO public.airports VALUES (331, 'Bhopal', 'BHO', 'IN', 23.287466, 77.33737, 'Raja Bhoj Arpt', 5);
INSERT INTO public.airports VALUES (332, 'Broken Hill', 'BHQ', 'AU', -32.0014, 141.472, 'Broken Hill Arpt', 9);
INSERT INTO public.airports VALUES (333, 'Bathurst', 'BHS', 'AU', -33.4094, 149.652, 'Raglan Airport', 10);
INSERT INTO public.airports VALUES (334, 'Bhavnagar', 'BHU', 'IN', 21.752207, 72.18518, 'Bhavnagar Arpt', 5);
INSERT INTO public.airports VALUES (335, 'Bahawalpur', 'BHV', 'PK', 29.4, 71.683334, 'Bahawalpur Arpt', 5);
INSERT INTO public.airports VALUES (336, 'Birmingham', 'XVB', 'GB', 0, 0, 'Stafford Rail Station', -100);
INSERT INTO public.airports VALUES (337, 'Birmingham', 'XNV', 'GB', 31.2083, 35.0123, 'Nuneaton Rail Station', -100);
INSERT INTO public.airports VALUES (338, 'Birmingham', 'QQN', 'GB', 0, 0, 'Birmingham - New Street Rail Service', -100);
INSERT INTO public.airports VALUES (339, 'Birmingham', 'BHX', 'GB', 52.453857, -1.748028, 'Birmingham Intl Arpt', 0);
INSERT INTO public.airports VALUES (340, 'Beihai', 'BHY', 'CN', 21.5394, 109.294, 'Beihai Airport', 8);
INSERT INTO public.airports VALUES (341, 'Belo Horizonte', 'PLU', 'BR', -19.851181, -43.950626, 'Pampulha Arpt', -3);
INSERT INTO public.airports VALUES (342, 'Belo Horizonte', 'CNF', 'BR', -19.63375, -43.968857, 'Tancredo Neves Intl Arpt', -3);
INSERT INTO public.airports VALUES (343, 'Bastia', 'BIA', 'FR', 42.552666, 9.483731, 'Poretta Airport', 1);
INSERT INTO public.airports VALUES (344, 'Block Island', 'BID', 'US', 41.168056, -71.57778, 'Block Island Municipal', -5);
INSERT INTO public.airports VALUES (345, 'Bishop', 'BIH', 'US', 37.3731, -118.3636, 'Bishop Airport', -100);
INSERT INTO public.airports VALUES (346, 'Bikini Atoll', 'BII', 'MH', 11.5225, 165.565, 'Enyu Airfield', 12);
INSERT INTO public.airports VALUES (347, 'Biak', 'BIK', 'ID', -1.190017, 136.108, 'Mokmer Arpt', 9);
INSERT INTO public.airports VALUES (348, 'Billings', 'BIL', 'US', 45.80921, -108.53765, 'Logan Field', -7);
INSERT INTO public.airports VALUES (349, 'Bimini', 'BIM', 'BS', 25.69988, -79.264656, 'Bimini Airport', -5);
INSERT INTO public.airports VALUES (350, 'Bimini', 'NSB', 'BS', 25.767, -79.25, 'North Seaplane Base', -5);
INSERT INTO public.airports VALUES (351, 'Bilbao', 'BIO', 'ES', 43.301098, -2.910608, 'Bilbao Arpt', 1);
INSERT INTO public.airports VALUES (352, 'Biarritz', 'BIQ', 'FR', 43.46842, -1.523325, 'Bayonne Anglet Arpt', 1);
INSERT INTO public.airports VALUES (353, 'Bismarck', 'BIS', 'US', 46.77584, -100.757935, 'Bismarck Municipal Arpt', -6);
INSERT INTO public.airports VALUES (354, 'Bisho', 'BIY', 'ZA', -32.895, 27.285, 'Bisho Arpt', -100);
INSERT INTO public.airports VALUES (355, 'Bejaia', 'BJA', 'DZ', 36.711998, 5.069922, 'Bejaia Arpt', 1);
INSERT INTO public.airports VALUES (356, 'Broomfield', 'BJC', 'US', 39.90889, -105.117226, 'Jeffco Arpt', -7);
INSERT INTO public.airports VALUES (357, 'Batsfjord', 'BJF', 'NO', 70.60028, 29.6925, 'Batsfjord Arpt', 1);
INSERT INTO public.airports VALUES (358, 'Bemidji', 'BJI', 'US', 47.510723, -94.93472, 'Bemidji Municipal Arpt', -6);
INSERT INTO public.airports VALUES (359, 'Banjul', 'BJL', 'GM', 13.337961, -16.652206, 'Yundum Intl Arpt', 0);
INSERT INTO public.airports VALUES (360, 'Bujumbura', 'BJM', 'BI', -3.324019, 29.31852, 'Bujumbura Intl Arpt', 2);
INSERT INTO public.airports VALUES (361, 'Bahar Dar', 'BJR', 'ET', 11.608075, 37.321644, 'Bahar Dar Arpt', 3);
INSERT INTO public.airports VALUES (362, 'Beijing', 'NAY', 'CN', 39.7825, 116.38778, 'Nanyuan Arpt', 8);
INSERT INTO public.airports VALUES (363, 'Beijing', 'PEK', 'CN', 40.080112, 116.58456, 'Beijing Capital Arpt', 8);
INSERT INTO public.airports VALUES (364, 'Leon', 'BJX', 'MX', 20.993464, -101.48085, 'Del Bajio Arpt', -6);
INSERT INTO public.airports VALUES (365, 'Badajoz', 'BJZ', 'ES', 38.89125, -6.821333, 'Talaveral La Real Arpt', 1);
INSERT INTO public.airports VALUES (366, 'Bikaner', 'BKB', 'IN', 0, 0, 'Bikaner Arpt', -100);
INSERT INTO public.airports VALUES (367, 'Erfurt', 'ERF', 'DE', 50.979813, 10.958106, 'Erfurt Arpt', 1);
INSERT INTO public.airports VALUES (368, 'Branson', 'BKG', 'US', 36.531994, -93.200554, 'Branson Regional Arpt', -6);
INSERT INTO public.airports VALUES (369, 'Kota Kinabalu', 'BKI', 'MY', 5.937208, 116.05118, 'Kota Kinabalu Arpt', 8);
INSERT INTO public.airports VALUES (370, 'Bangkok', 'DMK', 'TH', 13.912583, 100.60675, 'Don Mueang International Arpt', 7);
INSERT INTO public.airports VALUES (371, 'Bangkok', 'BKK', 'TH', 13.681108, 100.747284, 'Suvarnabhumi Intl Arpt', 7);
INSERT INTO public.airports VALUES (372, 'Bakalalan', 'BKM', 'MY', 3.974, 115.618, 'Bakalalan Arpt', 8);
INSERT INTO public.airports VALUES (373, 'Bamako', 'BKO', 'ML', 12.533544, -7.949944, 'Senou Airport', 0);
INSERT INTO public.airports VALUES (374, 'Blackall', 'BKQ', 'AU', -24.427778, 145.4286, 'Blackall Arpt', 10);
INSERT INTO public.airports VALUES (375, 'Bengkulu', 'BKS', 'ID', -3.8637, 102.339035, 'Padangkemiling Arpt', 7);
INSERT INTO public.airports VALUES (376, 'Beckley', 'BKW', 'US', 37.7873, -81.1242, 'Raleigh Cty Memorial', -5);
INSERT INTO public.airports VALUES (377, 'Brookings', 'BKX', 'US', 44.3048, -96.8169, 'Brookings Municipal', -6);
INSERT INTO public.airports VALUES (378, 'Barcelona', 'BLA', 'VE', 10.107139, -64.68916, 'Gen J A Anzoategui Arpt', -4);
INSERT INTO public.airports VALUES (379, 'Borlange', 'XXO', 'SE', 28.615, -80.695, 'Leksand Rail Station', -100);
INSERT INTO public.airports VALUES (380, 'Borlange', 'XXU', 'SE', 0, 0, 'Hedemora Rail Station', -100);
INSERT INTO public.airports VALUES (381, 'Borlange', 'XYB', 'SE', 0, 0, 'Borlange Railway Service', -100);
INSERT INTO public.airports VALUES (382, 'Borlange', 'BLE', 'SE', 60.422016, 15.515211, 'Dala Airport', 1);
INSERT INTO public.airports VALUES (383, 'Bluefield', 'BLF', 'US', 37.2958, -81.2077, 'Mercer County', -5);
INSERT INTO public.airports VALUES (384, 'Belaga', 'BLG', 'MY', 2.65, 113.767, 'Belaga Arpt', 8);
INSERT INTO public.airports VALUES (385, 'Blythe', 'BLH', 'US', 33.619167, -114.71689, 'Blythe Airport', -8);
INSERT INTO public.airports VALUES (386, 'Bellingham', 'BLI', 'US', 48.792694, -122.53753, 'Bellingham Intl Arpt', -8);
INSERT INTO public.airports VALUES (387, 'Batna', 'BLJ', 'DZ', 35.752106, 6.308589, 'Batna Arpt', 1);
INSERT INTO public.airports VALUES (388, 'Blackpool', 'XQL', 'GB', 0, 0, 'Lancaster Rail Station', -100);
INSERT INTO public.airports VALUES (389, 'Blackpool', 'BLK', 'GB', 53.771667, -3.028611, 'Blackpool Airport', 0);
INSERT INTO public.airports VALUES (390, 'Billund', 'BLL', 'DK', 55.740322, 9.151778, 'Billund Airport', 1);
INSERT INTO public.airports VALUES (391, 'Bologna', 'BLQ', 'IT', 44.535442, 11.288667, 'Guglielmo Marconi', 1);
INSERT INTO public.airports VALUES (392, 'Bangalore', 'BLR', 'IN', 12.949986, 77.668205, 'Bengaluru Intl Arpt', 5);
INSERT INTO public.airports VALUES (393, 'Blackwater', 'BLT', 'AU', -23.6031, 148.807, 'Blackwater Arpt', 10);
INSERT INTO public.airports VALUES (394, 'Belleville', 'BLV', 'US', 38.545177, -89.83518, 'Scott AFB Mid America', -6);
INSERT INTO public.airports VALUES (395, 'Belluno', 'BLX', 'IT', 0, 0, 'Belluno Arpt', -100);
INSERT INTO public.airports VALUES (396, 'Blantyre', 'BLZ', 'MW', -15.679053, 34.974014, 'Chileka Airport', 2);
INSERT INTO public.airports VALUES (397, 'Broome', 'BME', 'AU', -17.8, 122.2, 'Broome Airport', 8);
INSERT INTO public.airports VALUES (398, 'Bloomington', 'BMG', 'US', 39.146023, -86.616684, 'Monroe Cty Arpt Indiana', -4);
INSERT INTO public.airports VALUES (399, 'Bloomington', 'BMI', 'US', 40.47711, -88.91592, 'Normal Airport', -6);
INSERT INTO public.airports VALUES (400, 'Brampton Island', 'BMP', 'AU', 0, 0, 'Brampton Island Arpt', -100);
INSERT INTO public.airports VALUES (401, 'Banmethuot', 'BMV', 'VN', 12.668311, 108.12027, 'Phung Duc Arpt', 7);
INSERT INTO public.airports VALUES (402, 'Nashville', 'BNA', 'US', 36.124474, -86.67819, 'Nashville International Arpt', -6);
INSERT INTO public.airports VALUES (403, 'Bandar Abbas', 'BND', 'IR', 27.218317, 56.37785, 'Bandar Abbas Arpt', 4);
INSERT INTO public.airports VALUES (404, 'Brisbane', 'BNE', 'AU', -27.384167, 153.1175, 'Brisbane Arpt', 10);
INSERT INTO public.airports VALUES (405, 'Bonn', 'BNJ', 'DE', 50.7319, 7.0967, 'Bonn Railroad Station', -100);
INSERT INTO public.airports VALUES (406, 'Ballina', 'BNK', 'AU', -28.833889, 153.5625, 'Ballina Arpt', 10);
INSERT INTO public.airports VALUES (407, 'Bronnoysund', 'BNN', 'NO', 65.46111, 12.2175, 'Bronnoy Arpt', 1);
INSERT INTO public.airports VALUES (408, 'Burns', 'BNO', 'US', 43.5919, -118.9554, 'Burns Municipal Arpt', -100);
INSERT INTO public.airports VALUES (409, 'Blumenau', 'BNU', 'BR', -26.834238, -49.091698, 'Blumenau Arpt', -3);
INSERT INTO public.airports VALUES (410, 'Banja Luka', 'BNX', 'BA', 44.941444, 17.2975, 'Banja Luka Arpt', 1);
INSERT INTO public.airports VALUES (411, 'Bora Bora', 'BOB', 'PF', -16.444378, -151.75128, 'Motu Mute Arpt', -10);
INSERT INTO public.airports VALUES (412, 'Bocas Del Toro', 'BOC', 'PA', 9.340853, -82.25084, 'Bocas Del Toro Arpt', -5);
INSERT INTO public.airports VALUES (413, 'Bordeaux', 'ZFQ', 'FR', 48.6833, 1.1, 'Gare de Bordeaux', -100);
INSERT INTO public.airports VALUES (414, 'Bordeaux', 'BOD', 'FR', 44.828335, -0.715556, 'Bordeaux Arpt', 1);
INSERT INTO public.airports VALUES (415, 'Bogota', 'BOG', 'CO', 4.701594, -74.14695, 'Eldorado Airport', -5);
INSERT INTO public.airports VALUES (416, 'Bournemouth', 'BOH', 'GB', 50.78, -1.8425, 'Bournemouth Intl Arpt', 0);
INSERT INTO public.airports VALUES (417, 'Boise', 'BOI', 'US', 43.56436, -116.22286, 'Boise Municipal Arpt Gowen Field', -7);
INSERT INTO public.airports VALUES (418, 'Bourgas', 'BOJ', 'BG', 42.569584, 27.515236, 'Bourgas Arpt', 2);
INSERT INTO public.airports VALUES (419, 'Brookings', 'BOK', 'US', 0, 0, 'Brookings State Arpt', -100);
INSERT INTO public.airports VALUES (420, 'Mumbai', 'BOM', 'IN', 19.088686, 72.86792, 'Chhatrapati Shivaji', 5);
INSERT INTO public.airports VALUES (421, 'Bonaire', 'BON', 'AN', 12.131044, -68.26851, 'Flamingo Field', -4);
INSERT INTO public.airports VALUES (422, 'Bodo', 'BOO', 'NO', 67.269165, 14.365278, 'Bodo Arpt', 1);
INSERT INTO public.airports VALUES (423, 'Bodo', 'ZXM', 'NO', 0, 0, 'Rognan Rail Station', -100);
INSERT INTO public.airports VALUES (424, 'Boston', 'BOS', 'US', 42.364346, -71.00518, 'Logan Intl Arpt', -5);
INSERT INTO public.airports VALUES (425, 'Bourges', 'BOU', 'FR', 47.058056, 2.370278, 'Bourges Arpt', 1);
INSERT INTO public.airports VALUES (426, 'Bartow', 'BOW', 'US', 27.9434, -81.7834, 'Bartow Arpt', -6);
INSERT INTO public.airports VALUES (427, 'Borroloola', 'BOX', 'AU', 51.478504, 7.2222, 'Borroloola Arpt', 3);
INSERT INTO public.airports VALUES (428, 'Bobo Dioulasso', 'BOY', 'BF', 11.160056, -4.330969, 'Borgo Arpt', 0);
INSERT INTO public.airports VALUES (429, 'Balikpapan', 'BPN', 'ID', -1.268272, 116.89448, 'Sepingan Arpt', 8);
INSERT INTO public.airports VALUES (430, 'Porto Seguro', 'BPS', 'BR', -16.43861, -39.080833, 'Porto Seguro Arpt', -3);
INSERT INTO public.airports VALUES (431, 'Beaumont', 'BPT', 'US', 29.950832, -94.02069, 'Jefferson Cty Arpt', -6);
INSERT INTO public.airports VALUES (432, 'Busselton', 'BQB', 'AU', -33.6867, 115.4, 'Busselton Arpt', -100);
INSERT INTO public.airports VALUES (433, 'Brunswick', 'BQK', 'US', 31.2588, -81.4665, 'Gylnco Jet Port', -5);
INSERT INTO public.airports VALUES (434, 'Boulia', 'BQL', 'AU', -22.9133, 139.9, 'Boulia Arpt', 10);
INSERT INTO public.airports VALUES (435, 'Aguadilla', 'BQN', 'US', 18.494862, -67.12944, 'Borinquen Municipal Arpt', -4);
INSERT INTO public.airports VALUES (436, 'Blagoveshchensk', 'BQS', 'RU', 50.425392, 127.412476, 'Blagoveshchensk Arpt', 10);
INSERT INTO public.airports VALUES (437, 'Brest', 'BQT', 'BY', 52.06, 23.53, 'Brest Arpt', 2);
INSERT INTO public.airports VALUES (438, 'Barreiras', 'BRA', 'BR', -12.083333, -45, 'Barreiras Arpt', -3);
INSERT INTO public.airports VALUES (439, 'San Carlos Bariloche', 'BRC', 'AR', -41.151173, -71.15754, 'San Carlos De Bariloche Intl Arpt', -3);
INSERT INTO public.airports VALUES (440, 'Brainerd', 'BRD', 'US', 46.398308, -94.13808, 'Crowwing Cty Arpt', -6);
INSERT INTO public.airports VALUES (441, 'Bremen', 'BRE', 'DE', 53.0475, 8.786667, 'Bremen Airport', 1);
INSERT INTO public.airports VALUES (442, 'Bradford', 'BRF', 'GB', 0, 0, 'Bradford Rail Station', -100);
INSERT INTO public.airports VALUES (443, 'Bari', 'BRI', 'IT', 41.138855, 16.760593, 'Bari Airport', 1);
INSERT INTO public.airports VALUES (444, 'Bourke', 'BRK', 'AU', -30.0392, 145.952, 'Bourke Airport', 10);
INSERT INTO public.airports VALUES (445, 'Burlington', 'BRL', 'US', 40.7832, -91.1255, 'Burlington Municipal Arpt', -6);
INSERT INTO public.airports VALUES (446, 'Barquisimeto', 'BRM', 'VE', 10.042747, -69.35862, 'Airport Barquisimeto', -4);
INSERT INTO public.airports VALUES (447, 'Berne', 'BRN', 'CH', 46.9141, 7.497153, 'Belp Airport', 1);
INSERT INTO public.airports VALUES (448, 'Berne', 'ZDJ', 'CH', 0, 0, 'Berne Railroad Station', -100);
INSERT INTO public.airports VALUES (449, 'Brownsville', 'BRO', 'US', 25.906834, -97.42586, 'South Padre Island Intl Arpt', -6);
INSERT INTO public.airports VALUES (450, 'Brno', 'BRQ', 'CZ', 49.151268, 16.694433, 'Turnay Arpt', 1);
INSERT INTO public.airports VALUES (451, 'Barra', 'BRR', 'GB', 57.0228, -7.44306, 'North Bay Arpt', 0);
INSERT INTO public.airports VALUES (452, 'Bristol', 'BRS', 'GB', 51.382668, -2.719089, 'Bristol Intl Arpt', 0);
INSERT INTO public.airports VALUES (453, 'Bathurst Isl', 'BRT', 'AU', -11.769167, 130.61972, 'Bathurst Island Arpt', 9);
INSERT INTO public.airports VALUES (454, 'Brussels', 'CRL', 'BE', 50.459198, 4.453817, 'Brussels South Charleroi Arpt', 1);
INSERT INTO public.airports VALUES (455, 'Brussels', 'ZYR', 'BE', 50.8, 4.4, 'Midi Railway Station', 1);
INSERT INTO public.airports VALUES (456, 'Brussels', 'ZYZ', 'BE', 51.2167, 4.4167, 'Antwerp Berchem Rail Station', -100);
INSERT INTO public.airports VALUES (457, 'Brussels', 'BRU', 'BE', 50.90139, 4.484444, 'Brussels National Arpt', 1);
INSERT INTO public.airports VALUES (458, 'Bremerhaven', 'BRV', 'DE', 53.50708, 8.572878, 'Bremerhaven Arpt', 1);
INSERT INTO public.airports VALUES (459, 'Barrow', 'BRW', 'US', 71.285446, -156.766, 'Barrow WBAS', -9);
INSERT INTO public.airports VALUES (460, 'Barahona', 'BRX', 'DO', 18.251465, -71.1204, 'Barahona Arpt', -4);
INSERT INTO public.airports VALUES (461, 'Brasilia', 'BSB', 'BR', -15.8711, -47.918625, 'Brasilia Intl Arpt', -3);
INSERT INTO public.airports VALUES (462, 'Baoshan', 'BSD', 'CN', 25.053333, 99.168335, 'Baoshan Arpt', 8);
INSERT INTO public.airports VALUES (463, 'Brighton', 'BSH', 'GB', 0, 0, 'Brighton Airport', -100);
INSERT INTO public.airports VALUES (464, 'Blairsville', 'BSI', 'US', 0, 0, 'Blairsville Arpt', -100);
INSERT INTO public.airports VALUES (465, 'Bairnsdale', 'BSJ', 'AU', -37.8883, 147.5683, 'Bairnsdale Airport', -100);
INSERT INTO public.airports VALUES (466, 'Biskra', 'BSK', 'DZ', 34.79329, 5.738231, 'Biskra Arpt', 1);
INSERT INTO public.airports VALUES (467, 'Basel', 'BSL', 'CH', 47.59, 7.529167, 'Basel EuroAirport Swiss', 1);
INSERT INTO public.airports VALUES (468, 'Bisbee', 'BSQ', 'US', 0, 0, 'Bisbee Municipal Arpt', -100);
INSERT INTO public.airports VALUES (469, 'Basra', 'BSR', 'IQ', 30.549068, 47.662144, 'Basra Intl Arpt', 3);
INSERT INTO public.airports VALUES (470, 'Batam', 'BTH', 'ID', 1.121028, 104.11875, 'Hang Nadim Arpt', 7);
INSERT INTO public.airports VALUES (471, 'Banda Aceh', 'BTJ', 'ID', 5.523522, 95.42037, 'Blang Bintang Arpt', 7);
INSERT INTO public.airports VALUES (472, 'Bratsk', 'BTK', 'RU', 56.370556, 101.69833, 'Bratsk Arpt', 9);
INSERT INTO public.airports VALUES (473, 'Battle Creek', 'BTL', 'US', 42.3075, -85.2517, 'WK Kellogg Regional', -100);
INSERT INTO public.airports VALUES (474, 'Butte', 'BTM', 'US', 45.954807, -112.497475, 'Bert Mooney Arpt', -7);
INSERT INTO public.airports VALUES (475, 'Baton Rouge', 'EBR', 'US', 0, 0, 'Baton Rouge Downtown Arpt', -100);
INSERT INTO public.airports VALUES (476, 'Baton Rouge', 'BTR', 'US', 30.533167, -91.149635, 'Ryan Airport', -6);
INSERT INTO public.airports VALUES (477, 'Bratislava', 'ZRG', 'SK', 0, 0, 'Bratislava Bus Station', -100);
INSERT INTO public.airports VALUES (478, 'Bratislava', 'BTS', 'SK', 48.170166, 17.212667, 'Ivanka Arpt', 1);
INSERT INTO public.airports VALUES (479, 'Bettles', 'BTT', 'US', 66.91394, -151.52905, 'Bettles Arpt', -9);
INSERT INTO public.airports VALUES (480, 'Bintulu', 'BTU', 'MY', 3.12385, 113.02047, 'Bintulu Arpt', 8);
INSERT INTO public.airports VALUES (481, 'Burlington', 'BTV', 'US', 44.471863, -73.153275, 'Burlington Intl Arpt', -5);
INSERT INTO public.airports VALUES (482, 'Bursa', 'YEI', 'TR', 40.255207, 29.562569, 'Yenisehir Arpt', 2);
INSERT INTO public.airports VALUES (483, 'Bursa', 'BTZ', 'TR', 40.2489, 29.5494, 'Bursa Arpt', 2);
INSERT INTO public.airports VALUES (484, 'Burketown', 'BUC', 'AU', -17.7486, 139.534, 'Burketown Arpt', 10);
INSERT INTO public.airports VALUES (485, 'Budapest', 'BUD', 'HU', 47.43693, 19.255592, 'Ferihegy Arpt', 1);
INSERT INTO public.airports VALUES (486, 'Buenos Aires', 'EZE', 'AR', -34.822224, -58.53583, 'Ministro Pistarini', -3);
INSERT INTO public.airports VALUES (487, 'Buenos Aires', 'AEP', 'AR', -34.559174, -58.415607, 'Jorge Newbery', -3);
INSERT INTO public.airports VALUES (488, 'Buffalo', 'BUF', 'US', 42.940525, -78.73217, 'Greater Buffalo Intl Arpt', -5);
INSERT INTO public.airports VALUES (489, 'Bucharest', 'OTP', 'RO', 44.572163, 26.102179, 'Otopeni International', 2);
INSERT INTO public.airports VALUES (490, 'Bucharest', 'BBU', 'RO', 44.503193, 26.102112, 'Baneasa Airport', 2);
INSERT INTO public.airports VALUES (491, 'Buenaventura', 'BUN', 'CO', 3.819628, -76.98977, 'Buenaventura Arpt', -5);
INSERT INTO public.airports VALUES (492, 'Bulawayo', 'BUQ', 'ZW', -20.017431, 28.617868, 'Bulawayo Arpt', 2);
INSERT INTO public.airports VALUES (493, 'Burbank', 'BUR', 'US', 34.20067, -118.358665, 'Burbank Glendale Pasadena Arpt', -8);
INSERT INTO public.airports VALUES (494, 'Batumi', 'BUS', 'GE', 41.61028, 41.599693, 'Batumi Arpt', 2);
INSERT INTO public.airports VALUES (495, 'Bunbury', 'BUY', 'AU', 36.048542, -79.47489, 'Bunbury Arpt', -4);
INSERT INTO public.airports VALUES (496, 'Bushehr', 'BUZ', 'IR', 28.94481, 50.834637, 'Bushehr Arpt', 4);
INSERT INTO public.airports VALUES (497, 'Boa Vista', 'BVB', 'BR', 2.846311, -60.690067, 'Boa Vista Arpt', -4);
INSERT INTO public.airports VALUES (498, 'Boa Vista', 'BVC', 'CV', 16.136532, -22.888897, 'Rabil Arpt', -1);
INSERT INTO public.airports VALUES (499, 'Brive La Gaill', 'BVE', 'FR', 45.150833, 1.469167, 'Laroche Airport', 1);
INSERT INTO public.airports VALUES (500, 'Vilhena', 'BVH', 'BR', -12.694375, -60.09827, 'Vilhena Arpt', -4);
INSERT INTO public.airports VALUES (501, 'Birdsville', 'BVI', 'AU', -25.8975, 139.348, 'Birdsville Arpt', 10);
INSERT INTO public.airports VALUES (502, 'Bartlesville', 'BVO', 'US', 0, 0, 'Bartlesville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (503, 'Brava', 'BVR', 'CV', 0, 0, 'Esperadinha', -100);
INSERT INTO public.airports VALUES (504, 'Batesville', 'BVX', 'US', 0, 0, 'Batesville Municipal', -100);
INSERT INTO public.airports VALUES (505, 'Beverly', 'BVY', 'US', 42.5842, -70.9165, 'Beverly Municipal Arpt', -100);
INSERT INTO public.airports VALUES (506, 'Brawley', 'BWC', 'US', 0, 0, 'Brawley Arpt', -100);
INSERT INTO public.airports VALUES (507, 'Brownwood', 'BWD', 'US', 31.793612, -98.9565, 'Brownwood Municipal Arpt', -6);
INSERT INTO public.airports VALUES (508, 'Braunschweig', 'BWE', 'DE', 52.319168, 10.556111, 'Braunschweig Arpt', 1);
INSERT INTO public.airports VALUES (509, 'Barrow In Furness', 'BWF', 'GB', 54.13117, -3.263667, 'Walney Island', 0);
INSERT INTO public.airports VALUES (510, 'Bowling Green', 'BWG', 'US', 36.964527, -86.41967, 'Warren Cty Arpt', -5);
INSERT INTO public.airports VALUES (511, 'Baltimore', 'BWI', 'US', 39.17536, -76.668335, 'Baltimore Washington Intl Arpt', -5);
INSERT INTO public.airports VALUES (512, 'Falls Creek', 'FLC', 'AU', 0, 0, 'Falls Creek Arpt', -100);
INSERT INTO public.airports VALUES (513, 'Baltimore', 'APG', 'US', 39.46622, -76.16881, 'Phillips Army Air Field', -5);
INSERT INTO public.airports VALUES (514, 'Bol Airport', 'BWK', 'HR', 43.28572, 16.67972, 'Bol Airport', 1);
INSERT INTO public.airports VALUES (515, 'Bandar Seri Begawan', 'BWN', 'BN', 4.9442, 114.92835, 'Brunei Intl Arpt', 8);
INSERT INTO public.airports VALUES (516, 'Balakovo Airport', 'BWO', 'RU', 51.8583, 47.7456, 'Balakovo Airport', 4);
INSERT INTO public.airports VALUES (517, 'Brewarrina', 'BWQ', 'AU', -29.9756, 146.8156, 'Brewarrina Arpt', -100);
INSERT INTO public.airports VALUES (518, 'Burnie', 'BWT', 'AU', -40.9989, 145.731, 'Burnie Wynyard Arpt', 10);
INSERT INTO public.airports VALUES (519, 'Bankstown', 'BWU', 'AU', -33.924442, 150.98833, 'Bankstown Aerodrome', 10);
INSERT INTO public.airports VALUES (520, 'Bodrum', 'BJV', 'TR', 37.82, 28.204, 'Milas Arpt', 2);
INSERT INTO public.airports VALUES (521, 'Borrego Springs', 'BXS', 'US', 33.25903, -116.32097, 'Borrego Valley Arpt', -7);
INSERT INTO public.airports VALUES (522, 'Butuan', 'BXU', 'PH', 8.951322, 125.477974, 'Butuan Arpt', 8);
INSERT INTO public.airports VALUES (523, 'Meaulte', 'BYF', 'FR', 49.97, 2.6928, 'Albert Arpt', -100);
INSERT INTO public.airports VALUES (524, 'Burley', 'BYI', 'US', 42.5433, -113.7717, 'Burley Arpt', -100);
INSERT INTO public.airports VALUES (525, 'Laeso Island', 'BYR', 'DK', 57.2772, 11.0001, 'Laeso Airport', -100);
INSERT INTO public.airports VALUES (526, 'Bayreuth', 'BYU', 'DE', 49.98443, 11.638569, 'Bindlacher Berg Arpt', 1);
INSERT INTO public.airports VALUES (527, 'Blakely Island', 'BYW', 'US', 48.56025, -122.80243, 'Blakely Is Municipal', -8);
INSERT INTO public.airports VALUES (528, 'Buzios', 'BZC', 'BR', -22.7656, -41.965, 'Buzios Arpt', -100);
INSERT INTO public.airports VALUES (529, 'Belize City', 'TZA', 'BZ', 17.5344, -88.298, 'Belize City Municipal', -6);
INSERT INTO public.airports VALUES (530, 'Belize City', 'BZE', 'BZ', 17.539145, -88.308205, 'Belize Intl Arpt', -6);
INSERT INTO public.airports VALUES (531, 'Bydgoszcz', 'BZG', 'PL', 53.0968, 17.9777, 'Bydgoszcz Arpt', 1);
INSERT INTO public.airports VALUES (532, 'Bumi Hills', 'BZH', 'ZW', 0, 0, 'Bumi Hills Arpt', -100);
INSERT INTO public.airports VALUES (533, 'Balikesir', 'BZI', 'TR', 39.61926, 27.925959, 'Balikesir', 2);
INSERT INTO public.airports VALUES (534, 'Balikesir', 'MQJ', 'TR', 0, 0, 'Merkez Arpt', 2);
INSERT INTO public.airports VALUES (535, 'Bozeman', 'BZN', 'US', 45.77764, -111.16015, 'Gallatin Field', -7);
INSERT INTO public.airports VALUES (536, 'Bolzano', 'BZO', 'IT', 46.460194, 11.326383, 'Bolzano Arpt', 1);
INSERT INTO public.airports VALUES (537, 'Beziers', 'BZR', 'FR', 43.32352, 3.353903, 'Beziers Vias Arpt', 1);
INSERT INTO public.airports VALUES (538, 'Brazoria', 'BZT', 'US', 0, 0, 'Brazoria County Arpt', -100);
INSERT INTO public.airports VALUES (539, 'Brazzaville', 'BZV', 'CG', -4.2517, 15.253031, 'Maya Maya Arpt', 1);
INSERT INTO public.airports VALUES (540, 'Cascavel', 'CAC', 'BR', -25.00034, -53.500763, 'Cascavel Arpt', -3);
INSERT INTO public.airports VALUES (541, 'Cadillac', 'CAD', 'US', 0, 0, 'Wexford County Arpt', -100);
INSERT INTO public.airports VALUES (542, 'Columbia', 'OGB', 'US', 0, 0, 'Orangeburg Municpal', -100);
INSERT INTO public.airports VALUES (543, 'Columbia', 'CAE', 'US', 33.93883, -81.11953, 'Columbia Metro Arpt', -5);
INSERT INTO public.airports VALUES (544, 'Cagliari', 'CAG', 'IT', 39.25147, 9.054283, 'Elmas Airport', 1);
INSERT INTO public.airports VALUES (545, 'Cairo', 'CAI', 'EG', 30.121944, 31.405556, 'Cairo Intl Arpt', 2);
INSERT INTO public.airports VALUES (546, 'Akron', 'CAK', 'US', 40.916084, -81.44219, 'Akron Canton Regional Arpt', -5);
INSERT INTO public.airports VALUES (547, 'Campbelltown', 'CAL', 'GB', 55.4372, -5.68639, 'Machrihanish Arpt', 0);
INSERT INTO public.airports VALUES (548, 'Camiri', 'CAM', 'BO', 0, 0, 'Choreti Arpt', -100);
INSERT INTO public.airports VALUES (549, 'Guangzhou', 'CAN', 'CN', 23.392435, 113.29878, 'Baiyun Airport', 8);
INSERT INTO public.airports VALUES (550, 'Cap Haitien', 'CAP', 'HT', 19.732988, -72.19474, 'Cap Haitien Numicipal', -5);
INSERT INTO public.airports VALUES (551, 'Caribou', 'CAR', 'US', 46.8715, -68.017914, 'Caribou Municipal Arpt', -4);
INSERT INTO public.airports VALUES (552, 'Casablanca', 'CMN', 'MA', 33.367466, -7.589967, 'Mohamed V Arpt', 0);
INSERT INTO public.airports VALUES (553, 'Casablanca', 'CAS', 'MA', 33.5533, -7.6614, 'Anfa Airport', -100);
INSERT INTO public.airports VALUES (554, 'Caruaru', 'CAU', 'BR', -8.28239, -36.0135, 'Caruaru Arpt', -3);
INSERT INTO public.airports VALUES (555, 'Campos', 'CAW', 'BR', -21.698334, -41.30167, 'Bartolomeu Lisandro Arpt', -3);
INSERT INTO public.airports VALUES (556, 'Carlisle', 'XPF', 'GB', 0, 0, 'Penrith Rail Station', -100);
INSERT INTO public.airports VALUES (557, 'Carlisle', 'CAX', 'GB', 54.9375, -2.809167, 'Carlisle Arpt', 0);
INSERT INTO public.airports VALUES (558, 'Cayenne', 'CAY', 'GF', 4.819808, -52.360447, 'Rochambeau Airport', -3);
INSERT INTO public.airports VALUES (559, 'Cobar', 'CAZ', 'AU', -31.5383, 145.794, 'Cobar Arpt', 10);
INSERT INTO public.airports VALUES (560, 'Cochabamba', 'CBB', 'BO', -17.421059, -66.17712, 'J Wilsterman Arpt', -4);
INSERT INTO public.airports VALUES (561, 'Cumberland', 'CBE', 'US', 0, 0, 'Cumberland Municipal Arpt', -100);
INSERT INTO public.airports VALUES (562, 'Council Bluffs', 'CBF', 'US', 0, 0, 'Council Bluffs Municipal Arpt', -100);
INSERT INTO public.airports VALUES (563, 'Cambridge', 'CBG', 'GB', 52.205, 0.175, 'Cambridge Arpt', 0);
INSERT INTO public.airports VALUES (564, 'Colby', 'CBK', 'US', 0, 0, 'Colby Municipal Arpt', -100);
INSERT INTO public.airports VALUES (565, 'Ciudad Bolivar', 'CBL', 'VE', 8.121898, -63.537354, 'Ciudad Bolivar Arpt', -4);
INSERT INTO public.airports VALUES (566, 'Cirebon', 'CBN', 'ID', -6.756144, 108.53967, 'Penggung Arpt', 7);
INSERT INTO public.airports VALUES (567, 'Cotabato', 'CBO', 'PH', 7.165242, 124.20962, 'Awang Arpt', 8);
INSERT INTO public.airports VALUES (568, 'Coimbra', 'CBP', 'PT', 0, 0, 'Coimbra Arpt', -100);
INSERT INTO public.airports VALUES (569, 'Canberra', 'CBR', 'AU', -35.306946, 149.195, 'Canberra Arpt', 10);
INSERT INTO public.airports VALUES (570, 'Cabimas', 'CBS', 'VE', 0, 0, 'Oro Negro Arpt', -100);
INSERT INTO public.airports VALUES (571, 'Cayo Coco', 'CCC', 'CU', 22.5132, -78.511, 'Cayo Coco Arpt', -5);
INSERT INTO public.airports VALUES (572, 'Saint Martin', 'CCE', 'GP', 18.1006, -63.0489, 'Grand Case Arpt', -100);
INSERT INTO public.airports VALUES (573, 'Carcassonne', 'CCF', 'FR', 43.215977, 2.306317, 'Salvaza', 1);
INSERT INTO public.airports VALUES (574, 'Kozhikode', 'CCJ', 'IN', 11.136839, 75.9553, 'Kozhikode Arpt', 5);
INSERT INTO public.airports VALUES (575, 'Cocos Islands', 'CCK', 'CC', -12.1883, 96.8339, 'Cocos Islands Arpt', 6);
INSERT INTO public.airports VALUES (576, 'Criciuma', 'CCM', 'BR', -28.725817, -49.42474, 'Criciuma Arpt', -3);
INSERT INTO public.airports VALUES (577, 'Concepcion', 'CCP', 'CL', -36.77265, -73.0631, 'Carriel Sur Arpt', -4);
INSERT INTO public.airports VALUES (578, 'Concord', 'CCR', 'US', 37.989666, -122.05689, 'Buchanan Field', -8);
INSERT INTO public.airports VALUES (579, 'Caracas', 'CCS', 'VE', 10.603117, -66.990585, 'Simon Bolivar Arpt', -4);
INSERT INTO public.airports VALUES (580, 'Kolkata', 'CCU', 'IN', 22.65474, 88.446724, 'Netaji Subhas Chandra Bose Intl', 5);
INSERT INTO public.airports VALUES (581, 'Craig Cove', 'CCV', 'VU', -16.265, 167.924, 'Craig Cove Arpt', 11);
INSERT INTO public.airports VALUES (582, 'Cooinda', 'CDA', 'AU', -12.9033, 132.532, 'Cooinda Airport', 9);
INSERT INTO public.airports VALUES (583, 'Cedar City', 'CDC', 'US', 37.700966, -113.09885, 'Cedar City Municipal', -7);
INSERT INTO public.airports VALUES (584, 'Cauquira', 'CDD', 'HN', 0, 0, 'Cauquira Arpt', -100);
INSERT INTO public.airports VALUES (585, 'Camden', 'CDH', 'US', 33.6233, -92.7633, 'Harrell Fieldsandro Arpt', -100);
INSERT INTO public.airports VALUES (586, 'Cachoeiro De Itapemirim', 'CDI', 'BR', 39.97503, -81.57758, 'Cachoeiro De Itapemirim Arpt', -5);
INSERT INTO public.airports VALUES (587, 'Chadron', 'CDR', 'US', 42.8375, -103.09556, 'Chadron Arpt', -7);
INSERT INTO public.airports VALUES (588, 'Cordova', 'CDV', 'US', 60.49178, -145.47755, 'Mudhole Smith Arpt', -9);
INSERT INTO public.airports VALUES (589, 'Caldwell', 'CDW', 'US', 40.87522, -74.281364, 'Caldwell Wright Arpt', -4);
INSERT INTO public.airports VALUES (590, 'Cebu', 'CEB', 'PH', 10.307542, 123.97944, 'Cebu Intl', 8);
INSERT INTO public.airports VALUES (591, 'Crescent City', 'CEC', 'US', 41.7802, -124.237, 'Crescent City Municipal Arpt', -8);
INSERT INTO public.airports VALUES (592, 'Ceduna', 'CED', 'AU', -32.1306, 133.71, 'Ceduna Arpt', 9);
INSERT INTO public.airports VALUES (593, 'Cherepovets Airport', 'CEE', 'RU', 59.2736, 38.0158, 'Cherepovets Airport', 4);
INSERT INTO public.airports VALUES (594, 'Chester', 'XRC', 'GB', 0, 0, 'Runcorn Rail Station', -100);
INSERT INTO public.airports VALUES (595, 'Chester', 'CEG', 'GB', 53.178055, -2.977778, 'Chester Arpt', 0);
INSERT INTO public.airports VALUES (596, 'Chelinda', 'CEH', 'MW', 0, 0, 'Chelinda Arpt', -100);
INSERT INTO public.airports VALUES (597, 'Chiang Rai', 'CEI', 'TH', 19.952341, 99.88293, 'Chaing Rai Arpt', 7);
INSERT INTO public.airports VALUES (598, 'Chelyabinsk', 'CEK', 'RU', 55.305836, 61.503334, 'Chelyabinsk Arpt', 6);
INSERT INTO public.airports VALUES (599, 'Ciudad Obregon', 'CEN', 'MX', 27.39264, -109.833115, 'Ciudad Obregon Arpt', -7);
INSERT INTO public.airports VALUES (600, 'Cannes', 'CEQ', 'FR', 43.54205, 6.953478, 'Mandelieu Arpt', 1);
INSERT INTO public.airports VALUES (601, 'Cherbourg', 'CER', 'FR', 49.650105, -1.470281, 'Maupertius Arpt', 1);
INSERT INTO public.airports VALUES (602, 'Cessnock', 'CES', 'AU', -32.7875, 151.342, 'Cessnock Arpt', 10);
INSERT INTO public.airports VALUES (603, 'Cholet', 'CET', 'FR', 47.082134, -0.877064, 'Le Pontreau Arpt', 1);
INSERT INTO public.airports VALUES (604, 'Clemson', 'CEU', 'US', 0, 0, 'Clemson Oconee Cty Arpt', -100);
INSERT INTO public.airports VALUES (605, 'Murray', 'CEY', 'US', 0, 0, 'Calloway Cty Arpt', -100);
INSERT INTO public.airports VALUES (606, 'Cortez', 'CEZ', 'US', 37.303, -108.62806, 'Montezuma County', -7);
INSERT INTO public.airports VALUES (607, 'Cabo Frio', 'CFB', 'BR', -22.921667, -42.074165, 'Cabo Frio Arpt', -3);
INSERT INTO public.airports VALUES (608, 'Clermont Ferrand', 'CFE', 'FR', 45.78666, 3.169169, 'Aulnat Arpt', 1);
INSERT INTO public.airports VALUES (609, 'Cienfuegos', 'CFG', 'CU', 22.15, -80.41417, 'Cienfuegos Arpt', -5);
INSERT INTO public.airports VALUES (610, 'Chlef', 'CFK', 'DZ', 36.21, 1.33, 'Chlef Arpt', -100);
INSERT INTO public.airports VALUES (611, 'Donegal', 'CFN', 'IE', 55.044193, -8.341, 'Donegal Arpt', 0);
INSERT INTO public.airports VALUES (612, 'Creston', 'CFQ', 'CA', 0, 0, 'Creston Arpt', -100);
INSERT INTO public.airports VALUES (613, 'Caen', 'CFR', 'FR', 49.173332, -0.45, 'Carpiquet Arpt', 1);
INSERT INTO public.airports VALUES (614, 'Coffs Harbour', 'CFS', 'AU', -30.320557, 153.1164, 'Coffs Harbour Arpt', 10);
INSERT INTO public.airports VALUES (615, 'Kerkyra', 'CFU', 'GR', 39.601944, 19.911667, 'I Kapodistrias Arpt', 2);
INSERT INTO public.airports VALUES (616, 'Craig', 'CGA', 'US', 55.47889, -133.14778, 'Craig Seaplane Base', -9);
INSERT INTO public.airports VALUES (617, 'Cuiaba', 'CGB', 'BR', -15.652931, -56.11672, 'Marechal Rondon Arpt', -4);
INSERT INTO public.airports VALUES (618, 'Changde', 'CGD', 'CN', 28.9189, 111.64, 'Changde Arpt', 8);
INSERT INTO public.airports VALUES (619, 'Cape Girardeau', 'CGI', 'US', 37.2253, -89.5708, 'Cape Girardeau Municipal Arpt', -6);
INSERT INTO public.airports VALUES (620, 'Cologne', 'QKL', 'DE', 50.9, 7.183, 'Cologne Railroad Station', 1);
INSERT INTO public.airports VALUES (621, 'Cologne', 'CGN', 'DE', 50.865917, 7.142744, 'Koeln Bonn Arpt', 1);
INSERT INTO public.airports VALUES (622, 'Zhengzhou', 'CGO', 'CN', 34.519672, 113.84089, 'Zhengzhou Arpt', 8);
INSERT INTO public.airports VALUES (623, 'Chittagong', 'CGP', 'BD', 22.24961, 91.813286, 'Patenga Arpt', 6);
INSERT INTO public.airports VALUES (624, 'Changchun', 'CGQ', 'CN', 43.5412, 125.1201, 'Changchun Arpt', 8);
INSERT INTO public.airports VALUES (625, 'Campogrande', 'CGR', 'BR', -20.468666, -54.6725, 'Internacional', -4);
INSERT INTO public.airports VALUES (626, 'Cagayan', 'CGY', 'PH', 8.415619, 124.61122, 'Lumbia Arpt', 8);
INSERT INTO public.airports VALUES (627, 'Chattanooga', 'CHA', 'US', 35.03528, -85.20381, 'Chattanooga Lovell Fld', -5);
INSERT INTO public.airports VALUES (628, 'Christchurch', 'CHC', 'NZ', -43.489357, 172.53223, 'Christchurch Arpt', 12);
INSERT INTO public.airports VALUES (629, 'Chandler', 'CHD', 'US', 0, 0, 'Williams AFB Airport', -100);
INSERT INTO public.airports VALUES (630, 'Chicago', 'PWK', 'US', 42.11429, -87.901535, 'Pal Waukee Arpt', -6);
INSERT INTO public.airports VALUES (631, 'Chicago', 'RFD', 'US', 42.195362, -89.09722, 'Chicago Rockford Arpt', -6);
INSERT INTO public.airports VALUES (632, 'Chicago', 'DPA', 'US', 41.90778, -88.24861, 'Dupage County Arpt', -6);
INSERT INTO public.airports VALUES (633, 'Chicago', 'ORD', 'US', 41.978603, -87.90484, 'O\''Hare Intl Arpt', -6);
INSERT INTO public.airports VALUES (634, 'Chicago', 'MDW', 'US', 41.785973, -87.75242, 'Midway', -6);
INSERT INTO public.airports VALUES (635, 'Charlottesville', 'CHO', 'US', 38.138638, -78.45286, 'Charlottesville Albemarle Arpt', -5);
INSERT INTO public.airports VALUES (636, 'Chania', 'CHQ', 'GR', 35.531746, 24.149677, 'Souda Arpt', 2);
INSERT INTO public.airports VALUES (637, 'Chateauroux', 'CHR', 'FR', 46.862194, 1.730667, 'Chateauroux Arpt', 1);
INSERT INTO public.airports VALUES (638, 'Charleston', 'CHS', 'US', 32.898647, -80.04053, 'Charleston Intl Arpt', -5);
INSERT INTO public.airports VALUES (639, 'Jiuquan', 'CHW', 'CN', 0, 0, 'Jiuquan Arpt', -100);
INSERT INTO public.airports VALUES (640, 'Changuinola', 'CHX', 'PA', 9.458636, -82.51681, 'Changuinola Arpt', -5);
INSERT INTO public.airports VALUES (641, 'Chico', 'CIC', 'US', 39.795383, -121.85842, 'Chico Municipal Arpt', -8);
INSERT INTO public.airports VALUES (642, 'Cedar Rapids', 'CID', 'US', 41.884693, -91.71081, 'Cedar Rapids Municipal Arpt', -6);
INSERT INTO public.airports VALUES (643, 'Craig', 'CIG', 'US', 40.495, -107.5214, 'Craig Moffat', -100);
INSERT INTO public.airports VALUES (644, 'Council', 'CIL', 'US', 64.89778, -163.70334, 'Melsing Creek Arpt', -9);
INSERT INTO public.airports VALUES (645, 'Concepcion', 'CIO', 'PY', 45.4715, 21.1136, 'Mcal Lopez Arpt', 2);
INSERT INTO public.airports VALUES (646, 'Shimkent', 'CIT', 'KZ', 42.364166, 69.47889, 'Shimkent Arpt', 6);
INSERT INTO public.airports VALUES (647, 'Canovan Island', 'CIW', 'DM', 12.699042, -61.34243, 'Canouan Island Minicipal', -4);
INSERT INTO public.airports VALUES (648, 'Chiclayo', 'CIX', 'PE', -6.787475, -79.828094, 'Cornel Ruiz Arpt', -5);
INSERT INTO public.airports VALUES (649, 'Comiso', 'CIY', 'IT', 0, 0, 'Comiso Arpt', -100);
INSERT INTO public.airports VALUES (650, 'Coimbatore', 'CJB', 'IN', 11.030031, 77.04338, 'Peelamedu Airport', 5);
INSERT INTO public.airports VALUES (651, 'Calama', 'CJC', 'CL', -22.498175, -68.90357, 'El Loa Arpt', -4);
INSERT INTO public.airports VALUES (652, 'Ciudad Real City', 'CJI', 'ES', 0, 0, 'Ciudad Real City Arpt', -100);
INSERT INTO public.airports VALUES (653, 'Cheongju', 'CJJ', 'KR', 36.7166, 127.49912, 'Cheongju Arpt', 9);
INSERT INTO public.airports VALUES (654, 'Chumphon', 'CJM', 'TH', 10.7112, 99.36171, 'Chumphon Arpt', 7);
INSERT INTO public.airports VALUES (655, 'El Cajon', 'CJN', 'US', 0, 0, 'El Cajon Arpt', -100);
INSERT INTO public.airports VALUES (656, 'Ciudad Juarez', 'CJS', 'MX', 31.636133, -106.428665, 'Intl Abraham Gonzalez', -6);
INSERT INTO public.airports VALUES (657, 'Jeju City', 'CJU', 'KR', 33.511307, 126.49303, 'Jeju Intl Arpt', 9);
INSERT INTO public.airports VALUES (658, 'Naxos', 'JNX', 'GR', 37.080555, 25.368055, 'Naxos Arpt', 2);
INSERT INTO public.airports VALUES (659, 'Clarksburg', 'CKB', 'US', 39.2966, -80.2281, 'Clarksburg Benedum Arpt', -5);
INSERT INTO public.airports VALUES (660, 'Chongqing', 'CKG', 'CN', 29.719217, 106.64168, 'Chongqing Arpt', 8);
INSERT INTO public.airports VALUES (661, 'Chokurdakh Airport', 'CKH', 'RU', 70.6231, 147.902, 'Chokurdakh Airport', 12);
INSERT INTO public.airports VALUES (662, 'Clarksdale', 'CKM', 'US', 0, 0, 'Fletcher Field', -100);
INSERT INTO public.airports VALUES (663, 'Carajas', 'CKS', 'BR', -6.11781, -50.0035, 'Carajas Arpt', -3);
INSERT INTO public.airports VALUES (664, 'Clarksville', 'CKV', 'US', 0, 0, 'Outlaw Field', -100);
INSERT INTO public.airports VALUES (665, 'Conakry', 'CKY', 'GN', 9.576889, -13.611961, 'Conakry Airport', 0);
INSERT INTO public.airports VALUES (666, 'Canakkale', 'CKZ', 'TR', 40.137722, 26.426777, 'Canakkale Arpt', 2);
INSERT INTO public.airports VALUES (667, 'Clear Lake City', 'CLC', 'US', 0, 0, 'Metroport', -100);
INSERT INTO public.airports VALUES (668, 'Carlsbad', 'CLD', 'US', 33.0742, -117.1648, 'Carlsbad Arpt', -8);
INSERT INTO public.airports VALUES (669, 'Cleveland', 'CGF', 'US', 41.565125, -81.48636, 'Cuyahoga County Airport', -5);
INSERT INTO public.airports VALUES (670, 'Cleveland', 'CLE', 'US', 41.41169, -81.84979, 'Hopkins Intl Arpt', -5);
INSERT INTO public.airports VALUES (671, 'Cleveland', 'BKL', 'US', 41.525, -81.6833, 'Burke Lakefront Arpt', -100);
INSERT INTO public.airports VALUES (672, 'Cluj', 'CLJ', 'RO', 46.785168, 23.686167, 'Napoca Arpt', 2);
INSERT INTO public.airports VALUES (673, 'College Station', 'CLL', 'US', 30.588583, -96.36383, 'Easterwood Field', -6);
INSERT INTO public.airports VALUES (674, 'Port Angeles', 'CLM', 'US', 48.1202, -123.5, 'William Fairchild Intl Arpt', -8);
INSERT INTO public.airports VALUES (675, 'Cali', 'CLO', 'CO', 3.543222, -76.381584, 'Alfonso Bonella Aragon Arpt', -5);
INSERT INTO public.airports VALUES (676, 'Colima', 'CLQ', 'MX', 19.277012, -103.5774, 'Colima Arpt', -6);
INSERT INTO public.airports VALUES (677, 'Charlotte', 'CLT', 'US', 35.214, -80.94314, 'Charlotte Douglas Intl Arpt', -5);
INSERT INTO public.airports VALUES (678, 'Columbus', 'CLU', 'US', 39.2617, -85.8967, 'Columbus Municipal Arpt', -100);
INSERT INTO public.airports VALUES (679, 'Clearwater', 'CLW', 'US', 0, 0, 'Clearwater Executive Airpark', -100);
INSERT INTO public.airports VALUES (680, 'Calvi', 'CLY', 'FR', 42.530754, 8.793189, 'Ste Catherine Arpt', 1);
INSERT INTO public.airports VALUES (681, 'Cunnamulla', 'CMA', 'AU', -28.03, 145.622, 'Cunnamulla Arpt', 10);
INSERT INTO public.airports VALUES (682, 'Colombo', 'CMB', 'LK', 7.180756, 79.88412, 'Bandaranaike Intl Arpt', 6);
INSERT INTO public.airports VALUES (683, 'Ciudad Del Carmen', 'CME', 'MX', 18.65374, -91.79902, 'Ciudad Del Carmen Arpt', -6);
INSERT INTO public.airports VALUES (684, 'Chambery', 'CMF', 'FR', 45.63805, 5.880225, 'Chambery Aix Les Bains Arpt', 1);
INSERT INTO public.airports VALUES (685, 'Corumba', 'CMG', 'BR', -19.01193, -57.673054, 'Internacional Corumba', -4);
INSERT INTO public.airports VALUES (686, 'Columbus', 'OSU', 'US', 40.0798, -83.073, 'Ohio State Univ Arpt', -5);
INSERT INTO public.airports VALUES (687, 'Columbus', 'LCK', 'US', 39.813786, -82.92782, 'Rickenbacker Intl Arpt', -5);
INSERT INTO public.airports VALUES (688, 'Columbus', 'CMH', 'US', 39.99797, -82.89189, 'Port Columbus Intl Arpt', -5);
INSERT INTO public.airports VALUES (689, 'Champaign', 'CMI', 'US', 40.03925, -88.27805, 'Univ Of Illinois Willard Arpt', -6);
INSERT INTO public.airports VALUES (690, 'Clermont', 'CMQ', 'AU', -22.7694, 147.6194, 'Clermont Arpt', -100);
INSERT INTO public.airports VALUES (691, 'Colmar', 'CMR', 'FR', 48.10985, 7.359011, 'Colmar Houssen Arpt', 1);
INSERT INTO public.airports VALUES (692, 'Coromandel', 'CMV', 'NZ', 0, 0, 'Coromandel Arpt', -100);
INSERT INTO public.airports VALUES (693, 'Camaguey', 'CMW', 'CU', 21.420427, -77.847435, 'Ign Agramonte Intl Arpt', -5);
INSERT INTO public.airports VALUES (694, 'Houghton', 'CMX', 'US', 47.1684, -88.4891, 'Houghton Cty Memorial Arpt', -5);
INSERT INTO public.airports VALUES (695, 'Sparta', 'CMY', 'US', 0, 0, 'Camp Mccoy Aaf', -100);
INSERT INTO public.airports VALUES (696, 'Coonamble', 'CNB', 'AU', -30.9833, 148.376, 'Coonamble Arpt', 10);
INSERT INTO public.airports VALUES (697, 'Coconut Island', 'CNC', 'AU', -10.05, 143.07, 'Coconut Island Arpt', 10);
INSERT INTO public.airports VALUES (698, 'Constanta', 'CND', 'RO', 44.36222, 28.488333, 'Kogalniceanu Arpt', 2);
INSERT INTO public.airports VALUES (699, 'Cognac', 'CNG', 'FR', 45.658333, -0.3175, 'Parvaud Arpt', 1);
INSERT INTO public.airports VALUES (700, 'Cloncurry', 'CNJ', 'AU', -20.6686, 140.504, 'Cloncurry Arpt', 10);
INSERT INTO public.airports VALUES (701, 'Carlsbad', 'CNM', 'US', 32.33747, -104.263275, 'Carlsbad Airport', -7);
INSERT INTO public.airports VALUES (702, 'Corrientes', 'CNQ', 'AR', -27.445503, -58.761864, 'Camba Punta Arpt', -3);
INSERT INTO public.airports VALUES (703, 'Cairns', 'CNS', 'AU', -16.885834, 145.75528, 'Cairns Airport', 10);
INSERT INTO public.airports VALUES (704, 'Chiang Mai', 'CNX', 'TH', 18.766848, 98.96265, 'Chiang Mai Intl Arpt', 7);
INSERT INTO public.airports VALUES (705, 'Moab', 'CNY', 'US', 38.755, -109.75472, 'Moab Municipal', -7);
INSERT INTO public.airports VALUES (706, 'Concordia', 'COC', 'AR', -31.296944, -57.99663, 'Concordia Arpt', -3);
INSERT INTO public.airports VALUES (707, 'Cody', 'COD', 'US', 44.520195, -109.0238, 'Yellowstone Regional Arpt', -7);
INSERT INTO public.airports VALUES (708, 'Coeur D Alene', 'COE', 'US', 47.7743, -116.8196, 'Coeur d Alene Municipal Arpt', -100);
INSERT INTO public.airports VALUES (709, 'Cocoa Metro Area', 'COF', 'US', 28.234922, -80.61012, 'Patrick AFB', -5);
INSERT INTO public.airports VALUES (710, 'Cocoa Metro Area', 'COI', 'US', 0, 0, 'Merrit Island Arpt', -100);
INSERT INTO public.airports VALUES (711, 'Coonabarabrn', 'COJ', 'AU', -31.335, 149.27, 'Coonabarabran Arpt', -100);
INSERT INTO public.airports VALUES (712, 'Kochi', 'COK', 'IN', 10.155556, 76.39139, 'Kochi Intl Arpt', 5);
INSERT INTO public.airports VALUES (713, 'Concord', 'CON', 'US', 43.20267, -71.50233, 'Concord Arpt', -5);
INSERT INTO public.airports VALUES (714, 'Cotonou', 'COO', 'BJ', 6.357228, 2.384353, 'Cotonou Airport', 1);
INSERT INTO public.airports VALUES (715, 'Cordoba', 'COR', 'AR', -31.32362, -64.207954, 'Pajas Blanco Arpt', -3);
INSERT INTO public.airports VALUES (716, 'Colorado Springs', 'COS', 'US', 38.805805, -104.700775, 'Colorado Springs Municipal Arpt', -7);
INSERT INTO public.airports VALUES (717, 'Columbia', 'COU', 'US', 38.818092, -92.21963, 'Columbia Regional', -6);
INSERT INTO public.airports VALUES (718, 'Chapelco', 'CPC', 'AR', -40.075382, -71.13729, 'Chapelco Arpt', -3);
INSERT INTO public.airports VALUES (719, 'Coober Pedy', 'CPD', 'AU', -29.04, 134.721, 'Coober Pedy Arpt', 9);
INSERT INTO public.airports VALUES (720, 'Campeche', 'CPE', 'MX', 19.816793, -90.50031, 'Campeche Intl Arpt', -6);
INSERT INTO public.airports VALUES (721, 'Copenhagen', 'ZGH', 'DK', 0, 0, 'Copenhagen Rail Station', -100);
INSERT INTO public.airports VALUES (722, 'Copenhagen', 'CPH', 'DK', 55.617916, 12.655972, 'Copenhagen Arpt', 1);
INSERT INTO public.airports VALUES (723, 'Copiapo', 'CPO', 'CL', -27, -70, 'Chamonate Arpt', -4);
INSERT INTO public.airports VALUES (724, 'Campinas', 'CPQ', 'BR', -22.8592, -47.1082, 'International Campinas', -4);
INSERT INTO public.airports VALUES (725, 'Casper', 'CPR', 'US', 42.908, -106.46442, 'Natrona Cty Intl Arpt', -7);
INSERT INTO public.airports VALUES (726, 'Cape Town', 'CPT', 'ZA', -33.964806, 18.601667, 'Cape Town International', 2);
INSERT INTO public.airports VALUES (727, 'Campina Grande', 'CPV', 'BR', -7.269917, -35.896362, 'Joao Suassuana Arpt', -3);
INSERT INTO public.airports VALUES (728, 'Culebra', 'CPX', 'US', 18.3127, -65.3034, 'Culebra Arpt', -4);
INSERT INTO public.airports VALUES (729, 'Shahre Kord', 'CQD', 'IR', 32.2972, 50.8422, 'Shahre Kord Arpt', 3);
INSERT INTO public.airports VALUES (730, 'Ciudad Real', 'CQM', 'ES', 38.856388, -3.97, 'Ciudad Real Central Arpt', 1);
INSERT INTO public.airports VALUES (731, 'Craiova', 'CRA', 'RO', 44.31814, 23.88861, 'Craiova Arpt', 2);
INSERT INTO public.airports VALUES (732, 'Comodoro Rivadavia', 'CRD', 'AR', -45.785347, -67.46551, 'Comodoro Rivadavia Arpt', -3);
INSERT INTO public.airports VALUES (733, 'Luzon Island', 'CRK', 'PH', 15.185833, 120.56028, 'Clark Field Arpt', 8);
INSERT INTO public.airports VALUES (734, 'Corpus Christi', 'CRP', 'US', 27.77036, -97.50122, 'Corpus Christi Intl Arpt', -6);
INSERT INTO public.airports VALUES (735, 'Crotone', 'CRV', 'IT', 38.997227, 17.08017, 'Crotone Arpt', 1);
INSERT INTO public.airports VALUES (736, 'Charleston', 'CRW', 'US', 38.373146, -81.593185, 'Yeager Arpt', -5);
INSERT INTO public.airports VALUES (737, 'Corinth', 'CRX', 'US', 0, 0, 'Roscoe Turner Arpt', -100);
INSERT INTO public.airports VALUES (738, 'Turkmenabad', 'CRZ', 'TM', 39.083332, 63.602222, 'Turkmenabad Arpt', 5);
INSERT INTO public.airports VALUES (739, 'Creil', 'CSF', 'FR', 49.253548, 2.519139, 'Creil Arpt', 1);
INSERT INTO public.airports VALUES (740, 'Columbus', 'CSG', 'US', 32.516335, -84.93886, 'Columbus Metro Ft Benning Arpt', -5);
INSERT INTO public.airports VALUES (741, 'Casino', 'CSI', 'AU', -28.8833, 153.0583, 'Casino Arpt', -100);
INSERT INTO public.airports VALUES (742, 'San Luis Obispo', 'SBP', 'US', 35.2368, -120.642, 'San Luis Obispo County Arpt', -8);
INSERT INTO public.airports VALUES (743, 'San Luis Obispo', 'CSL', 'US', 0, 0, 'O Sullivan Army Air Field', -100);
INSERT INTO public.airports VALUES (744, 'Clinton', 'CLK', 'US', 0, 0, 'Clinton Municipal Arpt', -100);
INSERT INTO public.airports VALUES (745, 'Clinton', 'CSM', 'US', 35.34, -99.2, 'Sherman Arpt', -100);
INSERT INTO public.airports VALUES (746, 'Carson City', 'CSN', 'US', 0, 0, 'Carson Arpt', -100);
INSERT INTO public.airports VALUES (747, 'Santa Cruz Do Sul', 'CSU', 'BR', 0, 0, 'Santa Cruz Do Sul Arpt', -100);
INSERT INTO public.airports VALUES (748, 'Changsha', 'CSX', 'CN', 28.189157, 113.219635, 'Changsha Arpt', 8);
INSERT INTO public.airports VALUES (749, 'Cheboksary', 'CSY', 'RU', 56.0903, 47.3473, 'Cheboksary Arpt', 4);
INSERT INTO public.airports VALUES (750, 'Catania', 'CTA', 'IT', 37.46678, 15.0664, 'Fontanarossa Arpt', 1);
INSERT INTO public.airports VALUES (751, 'Catamarca', 'CTC', 'AR', -28.593214, -65.75092, 'Choya Arpt', -3);
INSERT INTO public.airports VALUES (752, 'Chitre', 'CTD', 'PA', 7.98784, -80.4097, 'Chitre Airfield', -5);
INSERT INTO public.airports VALUES (753, 'Cartagena', 'CTG', 'CO', 10.442381, -75.51296, 'Rafael Nunez Arpt', -5);
INSERT INTO public.airports VALUES (754, 'Charleville', 'CTL', 'AU', -26.413334, 146.2625, 'Charleville Arpt', 10);
INSERT INTO public.airports VALUES (755, 'Chetumal', 'CTM', 'MX', 18.504667, -88.32684, 'Chetumal International', -6);
INSERT INTO public.airports VALUES (756, 'Cooktown', 'CTN', 'AU', -15.4447, 145.184, 'Cooktown Arpt', 10);
INSERT INTO public.airports VALUES (757, 'Chengdu', 'CTU', 'CN', 30.578527, 103.94708, 'Chengdu Arpt', 8);
INSERT INTO public.airports VALUES (758, 'Cottonwood', 'CTW', 'US', 0, 0, 'Cottonwood Airport', -100);
INSERT INTO public.airports VALUES (759, 'Ciudad Constitucion', 'CUA', 'MX', 25.0538, -111.615, 'Ciudad Constitucion Arpt', -7);
INSERT INTO public.airports VALUES (760, 'Cucuta', 'CUC', 'CO', 7.927567, -72.51154, 'Camilo Dazo Arpt', -5);
INSERT INTO public.airports VALUES (761, 'Cuenca', 'CUE', 'EC', -2.889467, -78.9844, 'Cuenca Arpt', -5);
INSERT INTO public.airports VALUES (762, 'Cuneo', 'CUF', 'IT', 44.54702, 7.623217, 'Levaldigi Arpt', 1);
INSERT INTO public.airports VALUES (763, 'Cudal', 'CUG', 'AU', -33.2783, 148.7633, 'Cudal Arpt', -100);
INSERT INTO public.airports VALUES (764, 'Culiacan', 'CUL', 'MX', 24.764547, -107.47472, 'Fedl De Bachigualato Arpt', -7);
INSERT INTO public.airports VALUES (765, 'Cumana', 'CUM', 'VE', 10.450333, -64.13047, 'Antonio Jose De Sucre', -4);
INSERT INTO public.airports VALUES (766, 'Cancun', 'CUN', 'MX', 21.036528, -86.87708, 'Cancun Aeropuerto Internacional', -6);
INSERT INTO public.airports VALUES (767, 'Coen', 'CUQ', 'AU', -13.7608, 143.114, 'Coen Arpt', 10);
INSERT INTO public.airports VALUES (768, 'Curacao', 'CUR', 'AN', 12.188853, -68.9598, 'Areopuerto Hato Arpt', -4);
INSERT INTO public.airports VALUES (769, 'Columbus', 'CUS', 'US', 0, 0, 'Columbus Municipal', -100);
INSERT INTO public.airports VALUES (770, 'Chihuahua', 'CUU', 'MX', 28.702875, -105.96457, 'Chihuahua Airport', -6);
INSERT INTO public.airports VALUES (771, 'Cuzco', 'CUZ', 'PE', -13.535722, -71.93878, 'Tte Velazco Astete Arpt', -5);
INSERT INTO public.airports VALUES (772, 'Courchevel', 'CVF', 'FR', 45.3967, 6.63472, 'Courchevel Arpt', 1);
INSERT INTO public.airports VALUES (773, 'Cincinnati', 'LUK', 'US', 39.103333, -84.41861, 'Cincinnati Municipal Arpt', -5);
INSERT INTO public.airports VALUES (774, 'Cincinnati', 'CVG', 'US', 39.048836, -84.66782, 'Cincinnati No Kentucky Intl Arpt', -5);
INSERT INTO public.airports VALUES (775, 'Cuernavaca', 'CVJ', 'MX', 18.834764, -99.2613, 'Cuernavaca Arpt', -6);
INSERT INTO public.airports VALUES (776, 'Ciudad Victoria', 'CVM', 'MX', 23.703337, -98.95649, 'Ciudad Victoria Arpt', -6);
INSERT INTO public.airports VALUES (777, 'Clovis', 'CVN', 'US', 34.42514, -103.07928, 'Clovis Airport', -6);
INSERT INTO public.airports VALUES (778, 'Corvallis', 'QWY', 'US', 0, 0, 'Albany Bus Service', -100);
INSERT INTO public.airports VALUES (779, 'Corvallis', 'CVO', 'US', 0, 0, 'Corvallis Municipal Arpt', -100);
INSERT INTO public.airports VALUES (780, 'Carnarvon', 'CVQ', 'AU', -24.8806, 113.672, 'Carnarvon Arpt', 8);
INSERT INTO public.airports VALUES (781, 'Coventry', 'CVT', 'GB', 52.36972, -1.479722, 'Baginton Arpt', 0);
INSERT INTO public.airports VALUES (782, 'Corvo Island', 'CVU', 'PT', 39.6715, -31.1136, 'Corvo Arpt', -1);
INSERT INTO public.airports VALUES (783, 'Curitiba', 'CWB', 'BR', -25.528475, -49.175774, 'Afonso Pena Arpt', -3);
INSERT INTO public.airports VALUES (784, 'Chernovtsy', 'CWC', 'UA', 48.259323, 25.980831, 'Chernovtsy Arpt', 2);
INSERT INTO public.airports VALUES (785, 'Clinton', 'CWI', 'US', 0, 0, 'Clinton Municipal', -100);
INSERT INTO public.airports VALUES (786, 'Cardiff', 'CWL', 'GB', 51.396667, -3.343333, 'Cardiff Wales Arpt', 0);
INSERT INTO public.airports VALUES (787, 'Cowra', 'CWT', 'AU', -33.8467, 148.6494, 'Cowra Arpt', -100);
INSERT INTO public.airports VALUES (788, 'Christmas Island', 'CXI', 'KI', 1.986161, -157.34978, 'Cassidy', -12);
INSERT INTO public.airports VALUES (789, 'Caxias Do Sul', 'CXJ', 'BR', -29.197063, -51.187534, 'Campo Dos Bugres Arpt', -3);
INSERT INTO public.airports VALUES (790, 'Calexico', 'CXL', 'US', 32.669502, -115.51333, 'Calexico Intl Arpt', -8);
INSERT INTO public.airports VALUES (791, 'Conroe', 'CXO', 'US', 30.351833, -95.41447, 'Montgomery Co Arpt', -6);
INSERT INTO public.airports VALUES (792, 'Cilacap', 'CXP', 'ID', -7.645056, 109.03391, 'Tunggul Wulung Arpt', 7);
INSERT INTO public.airports VALUES (793, 'Cam Ranh', 'CXR', 'VN', 11.998153, 109.219376, 'Cam Ranh Arpt', 7);
INSERT INTO public.airports VALUES (794, 'Cayman Brac', 'CYB', 'KY', 19.686981, -79.88279, 'Gerrard Smith Arpt', -5);
INSERT INTO public.airports VALUES (795, 'Cayo Largo Del Sur', 'CYO', 'CU', 21.616453, -81.54599, 'Cayo Largo Del Sur Arpt', -5);
INSERT INTO public.airports VALUES (796, 'Colonia', 'CYR', 'UY', -34.4564, -57.7706, 'Colonia Arpt', -4);
INSERT INTO public.airports VALUES (797, 'Cheyenne', 'CYS', 'US', 41.155724, -104.81184, 'Cheyenne Arpt', -7);
INSERT INTO public.airports VALUES (798, 'Chichen Itza', 'CZA', 'MX', 20.6413, -88.4462, 'Chichen Itza Arpt', -100);
INSERT INTO public.airports VALUES (799, 'Coro', 'CZE', 'VE', 11.414867, -69.681656, 'Coro Arpt', -4);
INSERT INTO public.airports VALUES (800, 'Constantine', 'CZL', 'DZ', 36.276028, 6.620386, 'Ain El Bey Arpt', 1);
INSERT INTO public.airports VALUES (801, 'Jinzhou', 'JNZ', 'CN', 41.1014, 121.062, 'Jinzhou Arpt', 8);
INSERT INTO public.airports VALUES (802, 'Cozumel', 'CZM', 'MX', 20.522404, -86.925644, 'Aeropuerto Intl De Cozumel', -6);
INSERT INTO public.airports VALUES (803, 'Cruzeiro Do Sul', 'CZS', 'BR', -7.599906, -72.769485, 'Campo Intl Arpt', -5);
INSERT INTO public.airports VALUES (804, 'Changzhou', 'CZX', 'CN', 31.941668, 119.71167, 'Changzhou Arpt', 8);
INSERT INTO public.airports VALUES (805, 'Daytona Beach', 'DAB', 'US', 29.179916, -81.05806, 'Daytona Beach Regional Arpt', -5);
INSERT INTO public.airports VALUES (806, 'Dhaka', 'DAC', 'BD', 23.843332, 90.39778, 'Zia Intl Airport', 6);
INSERT INTO public.airports VALUES (807, 'Da Nang', 'DAD', 'VN', 16.043917, 108.19937, 'Da Nang Arpt', 7);
INSERT INTO public.airports VALUES (808, 'Dakhla Oasis', 'DAK', 'EG', 25.4117, 29.0017, 'Dakhla Arpt', -100);
INSERT INTO public.airports VALUES (809, 'Damascus', 'DAM', 'SY', 33.410637, 36.514267, 'Damascus Intl', 2);
INSERT INTO public.airports VALUES (810, 'Danville', 'DAN', 'US', 36.5729, -79.3361, 'Danville Municipal', -100);
INSERT INTO public.airports VALUES (811, 'Dar Es Salaam', 'DAR', 'TZ', -6.878111, 39.202625, 'Es Salaam Intl', 3);
INSERT INTO public.airports VALUES (812, 'Datong', 'DAT', 'CN', 40.0603, 113.482, 'Datong Arpt', 8);
INSERT INTO public.airports VALUES (813, 'David', 'DAV', 'PA', 8.391003, -82.43499, 'Enrique Malek Arpt', -5);
INSERT INTO public.airports VALUES (814, 'Dayton', 'DAY', 'US', 39.902374, -84.219376, 'Dayton International Airport', -5);
INSERT INTO public.airports VALUES (815, 'Dublin', 'DBN', 'US', 0, 0, 'Dublin Municipal Arpt', -100);
INSERT INTO public.airports VALUES (816, 'Dubbo', 'DBO', 'AU', -32.216667, 148.57472, 'Dubbo Arpt', 10);
INSERT INTO public.airports VALUES (817, 'Dubuque', 'DBQ', 'US', 42.402, -90.70947, 'Dubuque Municipal Arpt', -6);
INSERT INTO public.airports VALUES (818, 'Dubrovnik', 'DBV', 'HR', 42.56135, 18.268244, 'Dubrovnik Arpt', 1);
INSERT INTO public.airports VALUES (819, 'Dalby', 'DBY', 'AU', -27.155, 151.2667, 'Dalby', -100);
INSERT INTO public.airports VALUES (820, 'Castres', 'DCM', 'FR', 43.55625, 2.289183, 'Mazamet Arpt', 1);
INSERT INTO public.airports VALUES (821, 'Decatur', 'DCU', 'US', 0, 0, 'Pyor Arpt', -100);
INSERT INTO public.airports VALUES (822, 'Dodge City', 'DDC', 'US', 37.7634, -99.9656, 'Dodge City Municipal Arpt', -6);
INSERT INTO public.airports VALUES (823, 'Dandong', 'DDG', 'CN', 40.0255, 124.2866, 'Dandong Arpt', 8);
INSERT INTO public.airports VALUES (824, 'Daydream Island', 'DDI', 'AU', 0, 0, 'Daydream Island Arpt', -100);
INSERT INTO public.airports VALUES (825, 'Debrecen', 'DEB', 'HU', 47.48892, 21.615334, 'Debrecen Arpt', 1);
INSERT INTO public.airports VALUES (826, 'Decatur', 'DEC', 'US', 39.834564, -88.86569, 'Decatur Municipal', -6);
INSERT INTO public.airports VALUES (827, 'Dehra Dun', 'DED', 'IN', 30.18969, 78.18026, 'Jolly Grant Airport', 5);
INSERT INTO public.airports VALUES (828, 'Decorah', 'DEH', 'US', 0, 0, 'Decorah Municipal', -100);
INSERT INTO public.airports VALUES (829, 'Delhi', 'DEL', 'IN', 28.5665, 77.10309, 'Delhi Indira Gandhi Intl', 5);
INSERT INTO public.airports VALUES (830, 'Denver', 'APA', 'US', 39.57013, -104.8493, 'Centennial Arpt', -7);
INSERT INTO public.airports VALUES (831, 'Denver', 'DEN', 'US', 39.861656, -104.67318, 'Denver Intl Arpt', -7);
INSERT INTO public.airports VALUES (832, 'Denver', 'QWM', 'US', 0, 0, 'Longmont Bus Service', -100);
INSERT INTO public.airports VALUES (833, 'Deirezzor', 'DEZ', 'SY', 35.285374, 40.17596, 'Al Jafrah Arpt', 2);
INSERT INTO public.airports VALUES (834, 'Defiance', 'DFI', 'US', 0, 0, 'Defiance Memorial Arpt', -100);
INSERT INTO public.airports VALUES (835, 'Dallas', 'AFW', 'US', 32.987778, -97.318886, 'Fort Worth Alliance Arpt', -6);
INSERT INTO public.airports VALUES (836, 'Dallas', 'DFW', 'US', 32.896828, -97.037994, 'Dallas Ft Worth Intl', -6);
INSERT INTO public.airports VALUES (837, 'Dallas', 'ADS', 'US', 32.96856, -96.83645, 'Addison Arpt', -5);
INSERT INTO public.airports VALUES (838, 'Dallas', 'DAL', 'US', 32.84711, -96.851776, 'Love Field', -6);
INSERT INTO public.airports VALUES (839, 'Mudgee', 'DGE', 'AU', -32.5625, 149.611, 'Mudgee Arpt', 10);
INSERT INTO public.airports VALUES (840, 'Dongguan', 'DGM', 'CN', 0, 0, 'Dongguan Arpt', -100);
INSERT INTO public.airports VALUES (841, 'Durango', 'DGO', 'MX', 24.124193, -104.528015, 'Guadalupe Victoria Arpt', -6);
INSERT INTO public.airports VALUES (842, 'Daugavpils', 'DGP', 'LV', 0, 0, 'Daugavpils Arpt', -100);
INSERT INTO public.airports VALUES (843, 'Dumaguete', 'DGT', 'PH', 9.333714, 123.30047, 'Dumaguete Arpt', 8);
INSERT INTO public.airports VALUES (844, 'Dhahran', 'DHA', 'SA', 26.265417, 50.152027, 'Dhahran Intl', 3);
INSERT INTO public.airports VALUES (845, 'Dharamsala', 'DHM', 'IN', 32.1651, 76.2634, 'Gaggal Arpt', 5);
INSERT INTO public.airports VALUES (846, 'Dothan', 'DHN', 'US', 31.321339, -85.44963, 'Dothan Municipal', -6);
INSERT INTO public.airports VALUES (847, 'Dibrugarh', 'DIB', 'IN', 27.4839, 95.0169, 'Mohanbari Arpt', 5);
INSERT INTO public.airports VALUES (848, 'Diegosuarez', 'DIE', 'MG', -12.3494, 49.291748, 'Antsiranana Arrachart Arpt', 3);
INSERT INTO public.airports VALUES (849, 'Diqing', 'DIG', 'CN', 27.7936, 99.6772, 'Diging Arpt', 8);
INSERT INTO public.airports VALUES (850, 'Dijon', 'DIJ', 'FR', 47.26889, 5.09, 'Longvic Airport', 1);
INSERT INTO public.airports VALUES (851, 'Dickinson', 'DIK', 'US', 46.7975, -102.80194, 'Dickinson Municipal', -5);
INSERT INTO public.airports VALUES (852, 'Dili', 'DIL', 'TL', -8.546553, 125.52472, 'Comoro Arpt', 8);
INSERT INTO public.airports VALUES (853, 'Dien Bien Phu', 'DIN', 'VN', 21.397482, 103.00783, 'Gialam Arpt', 7);
INSERT INTO public.airports VALUES (854, 'Dire Dawa', 'DIR', 'ET', 9.6247, 41.854202, 'Aba Tenna D Yilma Arpt', 3);
INSERT INTO public.airports VALUES (855, 'Diu In', 'DIU', 'IN', 20.7131, 70.9211, 'Diu Arpt', 5);
INSERT INTO public.airports VALUES (856, 'Diyarbakır', 'DIY', 'TR', 37.893898, 40.20102, 'Diyarbakir Arpt', 2);
INSERT INTO public.airports VALUES (857, 'Jambi', 'DJB', 'ID', -1.638017, 103.64438, 'Sultan Taha Syarifudin Arpt', 7);
INSERT INTO public.airports VALUES (858, 'Djerba', 'DJE', 'TN', 33.87503, 10.775461, 'Melita Airport', 1);
INSERT INTO public.airports VALUES (859, 'Jayapura', 'DJJ', 'ID', -2.576953, 140.51637, 'Sentani Arpt', 9);
INSERT INTO public.airports VALUES (860, 'Dunk Island', 'DKI', 'AU', -17.939722, 146.14194, 'Dunk Island Arpt', 10);
INSERT INTO public.airports VALUES (861, 'Dakar', 'DKR', 'SN', 14.739708, -17.490225, 'Leopold Sedar Senghor Arpt', 0);
INSERT INTO public.airports VALUES (862, 'Dikson Airport', 'DKS', 'RU', 0, 0, 'Dikson Airport', -2);
INSERT INTO public.airports VALUES (863, 'Douala', 'DLA', 'CM', 4.006081, 9.719481, 'Douala Arpt', 1);
INSERT INTO public.airports VALUES (864, 'Dalian', 'DLC', 'CN', 38.965668, 121.5386, 'Dalian Arpt', 8);
INSERT INTO public.airports VALUES (865, 'Geilo', 'DLD', 'NO', 0, 0, 'Dagali Arpt', -100);
INSERT INTO public.airports VALUES (866, 'Dole', 'DLE', 'FR', 47.039013, 5.42725, 'Tavaux Arpt', 1);
INSERT INTO public.airports VALUES (867, 'Dillingham', 'DLG', 'US', 59.044666, -158.5055, 'Dillingham Municipal Arpt', -9);
INSERT INTO public.airports VALUES (868, 'Duluth', 'DLH', 'US', 46.84209, -92.19365, 'Duluth Intl', -6);
INSERT INTO public.airports VALUES (869, 'Dalat', 'DLI', 'VN', 11.75, 108.367, 'Lienkhang', 7);
INSERT INTO public.airports VALUES (870, 'Dillon', 'DLL', 'US', 0, 0, 'Dillon Arpt', -100);
INSERT INTO public.airports VALUES (871, 'Dalaman', 'DLM', 'TR', 36.713055, 28.7925, 'Dalaman Airport', 2);
INSERT INTO public.airports VALUES (872, 'The Dalles', 'DLS', 'US', 45.6185, -121.1673, 'The Dalles Municipal Arpt', -100);
INSERT INTO public.airports VALUES (873, 'Dali City', 'DLU', 'CN', 25.649445, 100.31944, 'Dali Arpt', 8);
INSERT INTO public.airports VALUES (874, 'ZHAMBYL', 'DMB', 'KZ', 42.85361, 71.30361, 'ZHAMBYL', 6);
INSERT INTO public.airports VALUES (875, 'Doomadgee', 'DMD', 'AU', -17.9403, 138.822, 'Doomadgee Arpt', 10);
INSERT INTO public.airports VALUES (876, 'Dammam', 'DMM', 'SA', 26.47116, 49.79789, 'King Fahad Arpt', 3);
INSERT INTO public.airports VALUES (877, 'Sedalia', 'DMO', 'US', 0, 0, 'Sedalia Memorial Arpt', -100);
INSERT INTO public.airports VALUES (878, 'Dundee', 'ZDU', 'GB', 0, 0, 'Dundee ScotRail', -100);
INSERT INTO public.airports VALUES (879, 'Dundee', 'DND', 'GB', 56.4525, -3.025833, 'Riverside Park Arpt', 0);
INSERT INTO public.airports VALUES (880, 'Dunhuang', 'DNH', 'CN', 40.094, 94.4818, 'Dunhuang Arpt', 8);
INSERT INTO public.airports VALUES (881, 'Dnepropetrovsk', 'DNK', 'UA', 48.357224, 35.100555, 'Dnepropetrovsk Arpt', 2);
INSERT INTO public.airports VALUES (882, 'Denham', 'DNM', 'AU', -25.8939, 113.577, 'Denham Arpt', 8);
INSERT INTO public.airports VALUES (883, 'Deniliquin', 'DNQ', 'AU', -35.5597, 144.9472, 'Denilinquin Arpt', -100);
INSERT INTO public.airports VALUES (884, 'Dinard', 'DNR', 'FR', 48.587685, -2.079958, 'Pleurtuit Arpt', 1);
INSERT INTO public.airports VALUES (885, 'Danville', 'DNV', 'US', 40.1992, -87.5959, 'Vermillion Cty', -100);
INSERT INTO public.airports VALUES (886, 'Denizli', 'DNZ', 'TR', 37.78557, 29.701298, 'Cardak Arpt', 2);
INSERT INTO public.airports VALUES (887, 'Dornoch', 'DOC', 'GB', 0, 0, 'Dornoch Arpt', -100);
INSERT INTO public.airports VALUES (888, 'Doha', 'DOH', 'QA', 25.261126, 51.565056, 'Doha International Arpt', 4);
INSERT INTO public.airports VALUES (889, 'Donetsk', 'DOK', 'UA', 48.073612, 37.739723, 'Donetsk Arpt', 2);
INSERT INTO public.airports VALUES (890, 'Deauville', 'DOL', 'FR', 49.365337, 0.154306, 'Saint Gatien Arpt', 1);
INSERT INTO public.airports VALUES (891, 'Dominica', 'DCF', 'DM', 15.336719, -61.392212, 'Canefield Arpt', -4);
INSERT INTO public.airports VALUES (892, 'Dominica', 'DOM', 'DM', 15.547028, -61.3, 'Melville Hall Arpt', -4);
INSERT INTO public.airports VALUES (893, 'Dover', 'DVX', 'US', 0, 0, 'Delaware Airpark', -100);
INSERT INTO public.airports VALUES (894, 'Dover', 'DOV', 'US', 39.12954, -75.46596, 'Dover AFB', -5);
INSERT INTO public.airports VALUES (895, 'Dongara', 'DOX', 'AU', 0, 0, 'Dongara', -100);
INSERT INTO public.airports VALUES (896, 'Dieppe', 'DPE', 'FR', 0, 0, 'Dieppe Arpt', -100);
INSERT INTO public.airports VALUES (897, 'Dipolog', 'DPL', 'PH', 8.601261, 123.33448, 'Dipolog Arpt', 8);
INSERT INTO public.airports VALUES (898, 'Devonport', 'DPO', 'AU', -41.1697, 146.43, 'Devonport Arpt', 10);
INSERT INTO public.airports VALUES (899, 'Denpasar Bali', 'DPS', 'ID', -8.748169, 115.167175, 'Ngurah Rai Arpt', 8);
INSERT INTO public.airports VALUES (900, 'Derby', 'DRB', 'AU', -17.39, 123.68, 'Derby Airport', 8);
INSERT INTO public.airports VALUES (901, 'Drake Bay Arpt', 'DRK', 'CR', 8.71889, -83.6417, 'Drake Bay Arpt', -6);
INSERT INTO public.airports VALUES (902, 'Durango', 'DRO', 'US', 37.151516, -107.75377, 'Durango La Plata Cty Arpt', -7);
INSERT INTO public.airports VALUES (903, 'Durango', 'AMK', 'US', 0, 0, 'Animas Airpark', -100);
INSERT INTO public.airports VALUES (904, 'Dresden', 'DRS', 'DE', 51.132767, 13.767161, 'Dresden Arpt', 1);
INSERT INTO public.airports VALUES (905, 'Del Rio', 'DRT', 'US', 29.374208, -100.927155, 'International Del Rio', -6);
INSERT INTO public.airports VALUES (906, 'Darwin', 'DRW', 'AU', -12.408333, 130.87267, 'Darwin Airport', 9);
INSERT INTO public.airports VALUES (907, 'Doncaster', 'DSA', 'GB', 53.474724, -1.004444, 'Finningley Arpt', 0);
INSERT INTO public.airports VALUES (908, 'La Desirade', 'DSD', 'GP', 16.2969, -61.0844, 'La Desirade Arpt', -4);
INSERT INTO public.airports VALUES (909, 'Destin', 'DSI', 'US', 0, 0, 'Destin Arpt', -100);
INSERT INTO public.airports VALUES (910, 'Des Moines', 'DSM', 'US', 41.533974, -93.663086, 'Des Moines Municipal Airport', -6);
INSERT INTO public.airports VALUES (911, 'Dortmund', 'DTM', 'DE', 51.518314, 7.612242, 'Wickede Dortmund Arpt', 1);
INSERT INTO public.airports VALUES (912, 'Detroit', 'UIZ', 'US', 0, 0, 'Berz Macomb Arpt', -100);
INSERT INTO public.airports VALUES (913, 'Detroit', 'YIP', 'US', 42.237926, -83.53041, 'Willow Run Arpt', -5);
INSERT INTO public.airports VALUES (914, 'Detroit', 'MTC', 'US', 42.608334, -82.8355, 'Selfridge Air Natl Guard', -5);
INSERT INTO public.airports VALUES (915, 'Detroit', 'DET', 'US', 42.409195, -83.009865, 'Detroit City Apt', -5);
INSERT INTO public.airports VALUES (916, 'Detroit', 'DTW', 'US', 42.212444, -83.353386, 'Detroit Metro Wayne Cnty Arpt', -5);
INSERT INTO public.airports VALUES (917, 'Dublin', 'DUB', 'IE', 53.421333, -6.270075, 'Dublin Arpt', 0);
INSERT INTO public.airports VALUES (918, 'Duncan', 'DUC', 'US', 34.471306, -97.95986, 'Halliburton Arpt', -6);
INSERT INTO public.airports VALUES (919, 'Dunedin', 'DUD', 'NZ', -45.928055, 170.19833, 'Momona Airport', 12);
INSERT INTO public.airports VALUES (920, 'Douglas', 'DUG', 'US', 31.469028, -109.60367, 'Bisbee Douglas Intl', -7);
INSERT INTO public.airports VALUES (921, 'Dubois', 'DUJ', 'US', 41.1783, -78.8987, 'Dubois Jefferson Cty Arpt', -5);
INSERT INTO public.airports VALUES (922, 'Duncan', 'DUQ', 'CA', 0, 0, 'Duncan/Quam Rail Station', -100);
INSERT INTO public.airports VALUES (923, 'Durban', 'DUR', 'ZA', -29.970089, 30.95052, 'Durban International', 2);
INSERT INTO public.airports VALUES (924, 'Durban', 'VIR', 'ZA', -29.770605, 31.058407, 'Virginia Arpt', 2);
INSERT INTO public.airports VALUES (925, 'Dusseldorf', 'NRN', 'DE', 51.602222, 6.141944, 'Niederrhein Arpt', 1);
INSERT INTO public.airports VALUES (926, 'Dusseldorf', 'QDU', 'DE', 51.22028, 6.792778, 'Dusseldorf Rail Station', 1);
INSERT INTO public.airports VALUES (927, 'Dusseldorf', 'DUS', 'DE', 51.28945, 6.766775, 'Dusseldorf Arpt', 1);
INSERT INTO public.airports VALUES (928, 'Dusseldorf', 'MGL', 'DE', 51.230354, 6.504494, 'Moenchen Gi Dus Exp', 1);
INSERT INTO public.airports VALUES (929, 'Dutch Harbor', 'DUT', 'US', 53.90014, -166.5435, 'Emergency Field', -9);
INSERT INTO public.airports VALUES (930, 'Devils Lake', 'DVL', 'US', 48.114445, -98.90861, 'Devils Lake Arpt', -6);
INSERT INTO public.airports VALUES (931, 'Davenport', 'DVN', 'US', 0, 0, 'Davenport Airport', -100);
INSERT INTO public.airports VALUES (932, 'Davao', 'DVO', 'PH', 7.125522, 125.645775, 'Mati Airport', 8);
INSERT INTO public.airports VALUES (933, 'Dawadmi Airport', 'DWD', 'SA', 24.5, 44.4, 'Dawadmi Airport', 3);
INSERT INTO public.airports VALUES (934, 'Dubai', 'SHJ', 'AE', 25.328575, 55.51715, 'Sharjah Airport', 4);
INSERT INTO public.airports VALUES (935, 'Dubai', 'XNB', 'AE', 0, 0, 'Dubai Bus Station Arpt', -100);
INSERT INTO public.airports VALUES (936, 'Dubai', 'DXB', 'AE', 25.252777, 55.364445, 'Dubai Intl Arpt', 4);
INSERT INTO public.airports VALUES (937, 'Danbury', 'DXR', 'US', 41.371536, -73.48219, 'Danbury Municipal Arpt', -4);
INSERT INTO public.airports VALUES (938, 'Dayong', 'DYG', 'CN', 29.1028, 110.443, 'Dayong Arpt', 8);
INSERT INTO public.airports VALUES (939, 'Doylestown', 'DYL', 'US', 0, 0, 'Doylestown Arpt', -100);
INSERT INTO public.airports VALUES (940, 'Anadyr', 'DYR', 'RU', 64.73495, 177.74149, 'Anadyr Arpt', 12);
INSERT INTO public.airports VALUES (941, 'Dushanbe', 'DYU', 'TJ', 38.54333, 68.825, 'Dushanbe Arpt', 5);
INSERT INTO public.airports VALUES (942, 'Dzaoudzi', 'DZA', 'YT', -12.804722, 45.281113, 'Dzaoudzi Arpt', 3);
INSERT INTO public.airports VALUES (943, 'ZHEZKAZGAN', 'DZN', 'KZ', 47.708332, 67.73333, 'ZHEZKAZGAN', 6);
INSERT INTO public.airports VALUES (944, 'Eagle', 'EAA', 'US', 64.77805, -141.14972, 'Eagle Airport', -9);
INSERT INTO public.airports VALUES (945, 'Nejran', 'EAM', 'SA', 17.611437, 44.41917, 'Nejran Arpt', 3);
INSERT INTO public.airports VALUES (946, 'Mulhouse Basel', 'MHL', 'FR', 0, 0, 'Mulhouse', -100);
INSERT INTO public.airports VALUES (947, 'Mulhouse Basel', 'MLH', 'FR', 47.589584, 7.529914, 'Mulhouse Euroairport French', 1);
INSERT INTO public.airports VALUES (948, 'Mulhouse Basel', 'ZBA', 'CH', 0, 0, 'Basel/Mullhouse Rail Service', -100);
INSERT INTO public.airports VALUES (949, 'Mulhouse Basel', 'ZDH', 'CH', 47.6, 7.52, 'Basel/Mullhouse SBB Rail Service', -100);
INSERT INTO public.airports VALUES (950, 'Kearney', 'EAR', 'US', 40.727, -99.0068, 'Kearney Municipal Arrpt', -6);
INSERT INTO public.airports VALUES (951, 'San Sebastian', 'EAS', 'ES', 43.356518, -1.790611, 'San Sebastian Arpt', 1);
INSERT INTO public.airports VALUES (952, 'Wenatchee', 'EAT', 'US', 47.398, -120.206, 'Pangborn Memorial Fld', -8);
INSERT INTO public.airports VALUES (953, 'Eau Claire', 'EAU', 'US', 44.8658, -91.4843, 'Claire Municipal Airport', -6);
INSERT INTO public.airports VALUES (954, 'Elba Island', 'EBA', 'IT', 42.760277, 10.239445, 'Marina Di Campo Arpt', 1);
INSERT INTO public.airports VALUES (955, 'Entebbe', 'EBB', 'UG', 0.042386, 32.443504, 'Entebbe Airport', 3);
INSERT INTO public.airports VALUES (956, 'Esbjerg', 'EBJ', 'DK', 55.525944, 8.553403, 'Esbjerg Arpt', 1);
INSERT INTO public.airports VALUES (957, 'Erbil', 'EBL', 'IQ', 36.23761, 43.963158, 'Erbil Arpt', 3);
INSERT INTO public.airports VALUES (958, 'Ebon', 'EBO', 'MH', 51.478504, 7.222781, 'Ebon Arpt', 1);
INSERT INTO public.airports VALUES (959, 'St Etienne', 'EBU', 'FR', 45.540554, 4.296389, 'Boutheon Arpt', 1);
INSERT INTO public.airports VALUES (960, 'Elizabeth City', 'ECG', 'US', 36.260582, -76.174576, 'Elizabeth Municipal Cgas', -5);
INSERT INTO public.airports VALUES (961, 'Echuca', 'ECH', 'AU', -36.1567, 144.7617, 'Echuca Arpt', -100);
INSERT INTO public.airports VALUES (962, 'Ercan', 'ECN', 'CY', 35.1547, 33.4961, 'Ercan Airport', 2);
INSERT INTO public.airports VALUES (963, 'Edenton', 'EDE', 'US', 0, 0, 'Edenton Municipal Arpt', -100);
INSERT INTO public.airports VALUES (964, 'Edinburgh', 'ZXE', 'GB', 0, 0, 'Edinburgh ScotRail', -100);
INSERT INTO public.airports VALUES (965, 'Edinburgh', 'EDI', 'GB', 55.95, -3.3725, 'Edinburgh Arpt', 0);
INSERT INTO public.airports VALUES (966, 'Eldoret', 'EDL', 'KE', 0.404458, 35.23893, 'Eldoret Arpt', 3);
INSERT INTO public.airports VALUES (967, 'La Roche', 'EDM', 'FR', 46.701942, -1.378625, 'Les Ajoncs Arpt', 1);
INSERT INTO public.airports VALUES (968, 'Edremit', 'EDO', 'TR', 39.5546, 27.0138, 'Edremit Airport', 2);
INSERT INTO public.airports VALUES (969, 'Edward River', 'EDR', 'AU', -14.8967, 141.609, 'Edward River Arpt', 10);
INSERT INTO public.airports VALUES (970, 'Needles', 'EED', 'US', 34.7667, -114.6233, 'Needles Arpt', -100);
INSERT INTO public.airports VALUES (971, 'Keene', 'EEN', 'US', 0, 0, 'Dilliant Hopkins Arpt', -100);
INSERT INTO public.airports VALUES (972, 'Kefalonia', 'EFL', 'GR', 38.120068, 20.50048, 'Argostoli Arpt', 2);
INSERT INTO public.airports VALUES (973, 'Bergerac', 'EGC', 'FR', 44.82528, 0.518611, 'Roumaniere Arpt', 1);
INSERT INTO public.airports VALUES (974, 'Eagle', 'ZBV', 'US', 0, 0, 'Beaver Creek Van Service', -100);
INSERT INTO public.airports VALUES (975, 'Eagle', 'QBF', 'US', 0, 0, 'Vail Van Service', -100);
INSERT INTO public.airports VALUES (976, 'Eagle', 'EGE', 'US', 39.642555, -106.917694, 'Eagle County Arpt', -7);
INSERT INTO public.airports VALUES (977, 'Sege', 'EGM', 'SB', -8.57889, 157.876, 'Sege Arpt', 11);
INSERT INTO public.airports VALUES (978, 'Geneina', 'EGN', 'SD', 13.4817, 22.4672, 'Geneina Arpt', 2);
INSERT INTO public.airports VALUES (979, 'Belgorod', 'EGO', 'RU', 50.6438, 36.5901, 'Belgorod Arpt', 4);
INSERT INTO public.airports VALUES (980, 'Eagle Pass', 'EGP', 'US', 0, 0, 'Maverick County Arpt', -100);
INSERT INTO public.airports VALUES (981, 'Egilsstadir', 'EGS', 'IS', 65.28333, -14.401389, 'Egilsstadir Arpt', 0);
INSERT INTO public.airports VALUES (982, 'Eagle River', 'EGV', 'US', 45.932335, -89.26828, 'Eagle River Union Arpt', -6);
INSERT INTO public.airports VALUES (983, 'El Bolson', 'EHL', 'AR', -41.943188, -71.53229, 'El Bolson Arpt', -3);
INSERT INTO public.airports VALUES (984, 'East Hartford', 'EHT', 'US', 0, 0, 'Rentschler Arpt', -100);
INSERT INTO public.airports VALUES (985, 'Eisenach', 'EIB', 'DE', 0, 0, 'Eisenach Arpt', -100);
INSERT INTO public.airports VALUES (986, 'Eniseysk', 'EIE', 'RU', 58.4742, 92.1125, 'Eniseysk Airport', 8);
INSERT INTO public.airports VALUES (987, 'Eindhoven', 'ZYE', 'NL', 0, 0, 'Eindhoven Rail Station', -100);
INSERT INTO public.airports VALUES (988, 'Eindhoven', 'EIN', 'NL', 51.450138, 5.374528, 'Welschap Arpt', 1);
INSERT INTO public.airports VALUES (989, 'Beef Island', 'EIS', 'VG', 18.444834, -64.54298, 'Beef Island Arpt', -4);
INSERT INTO public.airports VALUES (990, 'Barrancabermeja', 'EJA', 'CO', 7.024331, -73.8068, 'Variguies Arpt', -5);
INSERT INTO public.airports VALUES (991, 'Elkhart', 'EKI', 'US', 37.0007, -101.88, 'Elkhart Municipal Arpt', -100);
INSERT INTO public.airports VALUES (992, 'Elkins', 'EKN', 'US', 38.889442, -79.85714, 'Randolph County Arpt', -5);
INSERT INTO public.airports VALUES (993, 'Elko', 'EKO', 'US', 40.8249, -115.792, 'J C Harris Field', -8);
INSERT INTO public.airports VALUES (994, 'Eskilstuna', 'EKT', 'SE', 59.3522, 16.7083, 'Eskilstuna Arpt', -100);
INSERT INTO public.airports VALUES (995, 'Eskilstuna', 'XFJ', 'SE', 0, 0, 'Eskilstuna Rail Station', -100);
INSERT INTO public.airports VALUES (996, 'Elizabethtown', 'EKX', 'US', 0, 0, 'Addington Field', -100);
INSERT INTO public.airports VALUES (997, 'El Dorado', 'ELD', 'US', 33.22097, -92.81328, 'Goodwin Field', -6);
INSERT INTO public.airports VALUES (998, 'North Eleuthera', 'ELH', 'BS', 25.474861, -76.68349, 'North Eleuthera Intl', -5);
INSERT INTO public.airports VALUES (999, 'Elk City', 'ELK', 'US', 0, 0, 'Elk City Municipal', -100);
INSERT INTO public.airports VALUES (1000, 'Elmira', 'ELM', 'US', 42.15989, -76.89161, 'Elmira Corning Regional Arpt', -5);
INSERT INTO public.airports VALUES (1001, 'El Paso', 'ELP', 'US', 31.80725, -106.37759, 'El Paso Intl Arpt', -7);
INSERT INTO public.airports VALUES (1002, 'El Paso', 'BIF', 'US', 31.849527, -106.380035, 'Biggs Army Air Field', -7);
INSERT INTO public.airports VALUES (1003, 'Gassim', 'ELQ', 'SA', 26.302822, 43.77391, 'Gassim Arpt', 3);
INSERT INTO public.airports VALUES (1004, 'East London', 'ELS', 'ZA', -33.03557, 27.82594, 'East London Arpt', 2);
INSERT INTO public.airports VALUES (1005, 'Ely NV', 'ELY', 'US', 39.29972, -114.84194, 'Yelland Field', -8);
INSERT INTO public.airports VALUES (1006, 'Emerald', 'EMD', 'AU', -23.5675, 148.17917, 'Emerald Arpt', 10);
INSERT INTO public.airports VALUES (1007, 'El Monte', 'EMT', 'US', 0, 0, 'El Monte Arpt', -100);
INSERT INTO public.airports VALUES (1008, 'Kenai', 'ENA', 'US', 60.573112, -151.245, 'Kenai Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1009, 'Nancy', 'ENC', 'FR', 48.69207, 6.230458, 'Essey Airport', 1);
INSERT INTO public.airports VALUES (1010, 'Enshi', 'ENH', 'CN', 30.3203, 109.485, 'Enshi Arpt', 8);
INSERT INTO public.airports VALUES (1011, 'Enniskillen', 'ENK', 'IE', 54.398888, -7.651667, 'St Angelo Arpt', 0);
INSERT INTO public.airports VALUES (1012, 'Centralia', 'ENL', 'US', 38.5151, -89.0911, 'Centralia Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1013, 'Enschede', 'ENS', 'NL', 52.27, 6.874167, 'Twente Airport', 1);
INSERT INTO public.airports VALUES (1014, 'Kenosha', 'ENW', 'US', 42.595695, -87.9278, 'Kenosha Municipal Arpt', -6);
INSERT INTO public.airports VALUES (1015, 'Yanan', 'ENY', 'CN', 36.6369, 109.554, 'Yanan Arpt', 8);
INSERT INTO public.airports VALUES (1016, 'Eday', 'EOI', 'GB', 59.1906, -2.77222, 'Eday Arpt', 0);
INSERT INTO public.airports VALUES (1017, 'Keokuk', 'EOK', 'US', 0, 0, 'Keokuk Arpt', -100);
INSERT INTO public.airports VALUES (1018, 'Epinal', 'EPL', 'FR', 48.324963, 6.069983, 'Mirecourt Arpt', 1);
INSERT INTO public.airports VALUES (1019, 'Esperance', 'EPR', 'AU', -33.6844, 121.823, 'Esperance Arpt', 8);
INSERT INTO public.airports VALUES (1020, 'El Portillo Samana', 'EPS', 'DO', 19.198586, -69.42977, 'El Portillo Arpt', -4);
INSERT INTO public.airports VALUES (1021, 'Parnu', 'EPU', 'EE', 58.419044, 24.472818, 'Parnu Arpt', 2);
INSERT INTO public.airports VALUES (1022, 'Esquel', 'EQS', 'AR', -42.90795, -71.13947, 'Esquel Airport', -3);
INSERT INTO public.airports VALUES (1023, 'Erzincan', 'ERC', 'TR', 39.7102, 39.527004, 'Erzincan Arpt', 2);
INSERT INTO public.airports VALUES (1024, 'Errachidia', 'ERH', 'MA', 31.9475, -4.398333, 'Errachidia Arpt', 0);
INSERT INTO public.airports VALUES (1025, 'Erie', 'ERI', 'US', 42.082024, -80.176216, 'Erie Intl', -5);
INSERT INTO public.airports VALUES (1026, 'Kerrville', 'ERV', 'US', 29.976667, -99.08547, 'Kerrville Arpt', -6);
INSERT INTO public.airports VALUES (1027, 'Erzurum', 'ERZ', 'TR', 39.9565, 41.170166, 'Erzurum Arpt', 2);
INSERT INTO public.airports VALUES (1028, 'Escanaba', 'ESC', 'US', 45.72278, -87.09361, 'Delta County', -5);
INSERT INTO public.airports VALUES (1029, 'East Sound', 'ESD', 'US', 48.708057, -122.91055, 'Eastsound Orcas Is Arpt', -8);
INSERT INTO public.airports VALUES (1030, 'Ensenada', 'ESE', 'MX', 31.79528, -116.602776, 'Ensenada Arpt', -8);
INSERT INTO public.airports VALUES (1031, 'Eskisehir Airport', 'ESK', 'TR', 39.784138, 30.582111, 'Eskisehir Airport', 2);
INSERT INTO public.airports VALUES (1032, 'Elista', 'ESL', 'RU', 46.3739, 44.3309, 'Elista Arpt', 4);
INSERT INTO public.airports VALUES (1033, 'Easton', 'ESN', 'US', 38.80417, -76.069, 'Easton Municipal Arpt', -5);
INSERT INTO public.airports VALUES (1034, 'East Stroudsburg', 'ESP', 'US', 0, 0, 'Birchwood Pocono Arpt', -100);
INSERT INTO public.airports VALUES (1035, 'El Salvador', 'ESR', 'CL', -26.3111, -69.7652, 'El Salvador Arpt', -4);
INSERT INTO public.airports VALUES (1036, 'Essen', 'ESS', 'DE', 51.402332, 6.937333, 'Essen Arpt', 1);
INSERT INTO public.airports VALUES (1037, 'Essaouira', 'ESU', 'MA', 31.3975, -9.681667, 'Essaouira Arpt', 0);
INSERT INTO public.airports VALUES (1038, 'West Bend', 'ETB', 'US', 0, 0, 'West Bend Arpt', -100);
INSERT INTO public.airports VALUES (1039, 'Elat', 'ETH', 'IL', 29.561281, 34.96008, 'Elat Airport', 2);
INSERT INTO public.airports VALUES (1040, 'Enterprise', 'ETS', 'US', 0, 0, 'Enterprise Municipal', -100);
INSERT INTO public.airports VALUES (1041, 'Metz Nancy', 'ETZ', 'FR', 48.982143, 6.251319, 'Metz Nancy Lorraine', 1);
INSERT INTO public.airports VALUES (1042, 'Metz Nancy', 'XZI', 'FR', 49.1203, 6.1778, 'Railway Station Metz', -100);
INSERT INTO public.airports VALUES (1043, 'Eufaula', 'EUF', 'US', 0, 0, 'Weedon Field', -100);
INSERT INTO public.airports VALUES (1044, 'Eugene', 'EUG', 'US', 44.124584, -123.211975, 'Eugene Arpt', -8);
INSERT INTO public.airports VALUES (1045, 'El Aaiun', 'EUN', 'MA', 27.1517, -13.2192, 'Hassan I Arpt', 0);
INSERT INTO public.airports VALUES (1046, 'St Eustatius', 'EUX', 'AN', 17.496492, -62.97944, 'Roosevelt Field', -4);
INSERT INTO public.airports VALUES (1047, 'Harstad Narvik', 'EVE', 'NO', 68.4913, 16.678108, 'Evenes Arpt', 1);
INSERT INTO public.airports VALUES (1048, 'Sveg', 'EVG', 'SE', 62.04781, 14.42295, 'Sveg Arpt', 1);
INSERT INTO public.airports VALUES (1049, 'Eveleth', 'EVM', 'US', 0, 0, 'Eveleth Virginia Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1050, 'Yerevan', 'EVN', 'AM', 40.147274, 44.39588, 'Yerevan Arpt', 4);
INSERT INTO public.airports VALUES (1051, 'Evansville', 'EVV', 'US', 38.037, -87.532364, 'Evansville Regional Arpt', -6);
INSERT INTO public.airports VALUES (1052, 'Evanston', 'EVW', 'US', 0, 0, 'Evanston Arpt', -100);
INSERT INTO public.airports VALUES (1053, 'Evreux', 'EVX', 'FR', 49.0286, 1.22, 'Evreux Arpt', -100);
INSERT INTO public.airports VALUES (1054, 'New Bedford', 'EWB', 'US', 41.6761, -70.9569, 'New Bedford Municipal', -5);
INSERT INTO public.airports VALUES (1055, 'Newton', 'EWK', 'US', 0, 0, 'Newton City County Arpt', -100);
INSERT INTO public.airports VALUES (1056, 'New Bern', 'EWN', 'US', 35.07297, -77.042946, 'Craven County Regional Arpt', -5);
INSERT INTO public.airports VALUES (1057, 'Newark', 'EWR', 'US', 40.6925, -74.16867, 'Newark Liberty Intl Arpt', -5);
INSERT INTO public.airports VALUES (1058, 'Excursion Inlet', 'EXI', 'US', 58.420555, -135.44917, 'Excursion Inlet Municipal', -9);
INSERT INTO public.airports VALUES (1059, 'Exmouth Gulf', 'EXM', 'AU', -21.933, 114.128, 'Exmouth Gulf', 8);
INSERT INTO public.airports VALUES (1060, 'Exeter', 'EXT', 'GB', 50.734444, -3.413889, 'Exeter Arpt', 0);
INSERT INTO public.airports VALUES (1061, 'Key West', 'EYW', 'US', 24.55611, -81.75956, 'Key West Intl', -5);
INSERT INTO public.airports VALUES (1062, 'Elazig', 'EZS', 'TR', 38.606926, 39.291416, 'Elazig Arpt', 2);
INSERT INTO public.airports VALUES (1063, 'Farnborough Hampshire', 'FAB', 'GB', 51.275833, -0.776333, 'Farnborough Arpt', 0);
INSERT INTO public.airports VALUES (1064, 'Faeroe Islands', 'FAE', 'DK', 62.06363, -7.277219, 'Faeroe Airport', 0);
INSERT INTO public.airports VALUES (1065, 'Fairbanks', 'FAI', 'US', 64.81512, -147.85626, 'Fairbanks Intl Arpt', -9);
INSERT INTO public.airports VALUES (1066, 'Fajardo', 'FAJ', 'US', 18.30889, -65.66186, 'Fajardo Arpt', -4);
INSERT INTO public.airports VALUES (1067, 'Faro', 'FAO', 'PT', 37.014423, -7.965911, 'Faro Airport', 0);
INSERT INTO public.airports VALUES (1068, 'Fargo', 'FAR', 'US', 46.92065, -96.815765, 'Hector Airport', -6);
INSERT INTO public.airports VALUES (1069, 'Fresno', 'FAT', 'US', 36.776196, -119.71814, 'Fresno Air Terminal', -8);
INSERT INTO public.airports VALUES (1070, 'Fresno', 'FCH', 'US', 0, 0, 'Fresno Chandler Arpt', -100);
INSERT INTO public.airports VALUES (1071, 'Fayetteville', 'FAY', 'US', 34.9912, -78.8803, 'Fayetteville Municipal', -5);
INSERT INTO public.airports VALUES (1072, 'Faizabad', 'FBD', 'AF', 37.1211, 70.5181, 'Faizabad Arpt', 4);
INSERT INTO public.airports VALUES (1073, 'Lubumbashi', 'FBM', 'CD', -11.591333, 27.53089, 'Luano', 2);
INSERT INTO public.airports VALUES (1074, 'Kalispell', 'FCA', 'US', 48.31047, -114.256, 'Glacier Park Intl', -7);
INSERT INTO public.airports VALUES (1075, 'Ficksburg', 'FCB', 'ZA', 0, 0, 'Ficksburg Sentra Oes', -100);
INSERT INTO public.airports VALUES (1076, 'Cuxhaven', 'FCN', 'DE', 53.7683, 8.6642, 'Cuxhaven Nordholz Arpt', -100);
INSERT INTO public.airports VALUES (1077, 'Forrest City', 'FCY', 'US', 0, 0, 'Forrest City Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1078, 'Forde', 'FDE', 'NO', 61.25, 5.45, 'Bringeland Arpt', 1);
INSERT INTO public.airports VALUES (1079, 'Ft De France', 'FDF', 'MQ', 14.591033, -61.003174, 'Lamentin Arpt', -4);
INSERT INTO public.airports VALUES (1080, 'Friedrichshafen', 'FDH', 'DE', 47.671318, 9.511486, 'Friedrichshafen Lowenthal', 1);
INSERT INTO public.airports VALUES (1081, 'Frederick', 'FDK', 'US', 39.4178, -77.3744, 'Frederick Municipal', -100);
INSERT INTO public.airports VALUES (1082, 'Fergana', 'FEG', 'UZ', 40.3588, 71.745, 'Fergana', 5);
INSERT INTO public.airports VALUES (1083, 'Fernando De Noronha', 'FEN', 'BR', -3.854928, -32.423336, 'Fernando De Noronha Arpt', -2);
INSERT INTO public.airports VALUES (1084, 'Fez Ma', 'FEZ', 'MA', 33.92726, -4.977958, 'Fez Airport', 0);
INSERT INTO public.airports VALUES (1085, 'Fergus Falls', 'FFM', 'US', 0, 0, 'Fergus Falls Municipal', -100);
INSERT INTO public.airports VALUES (1086, 'Ft Huachuca', 'FHU', 'US', 31.588472, -110.34439, 'Sierra Vista Municipal', -7);
INSERT INTO public.airports VALUES (1087, 'Fair Isle', 'FIE', 'GB', 59.5358, -1.62806, 'Fair Isle Arpt', 0);
INSERT INTO public.airports VALUES (1088, 'Kinshasa', 'FIH', 'CD', -4.38575, 15.444569, 'Kinshasa Arpt', 1);
INSERT INTO public.airports VALUES (1089, 'Kinshasa', 'NLO', 'CD', -4.326689, 15.327342, 'N Dolo Airport', 1);
INSERT INTO public.airports VALUES (1090, 'Al Fujairah', 'FJR', 'AE', 25.112225, 56.323963, 'Fujairah Intl Arpt', 4);
INSERT INTO public.airports VALUES (1091, 'Karlsruhe Baden Baden', 'FKB', 'DE', 48.7793, 8.08048, 'Soellingen Arpt', 1);
INSERT INTO public.airports VALUES (1092, 'Franklin', 'FKL', 'US', 41.377872, -79.86036, 'Chess Lamberton Arpt', -5);
INSERT INTO public.airports VALUES (1093, 'Fukushima', 'FKS', 'JP', 37.2274, 140.431, 'Fukushima Arpt', 9);
INSERT INTO public.airports VALUES (1094, 'Floriano', 'FLB', 'BR', -6.8458, -43.0775, 'Cangapara Arpt', -100);
INSERT INTO public.airports VALUES (1095, 'Flensburg', 'FLF', 'DE', 54.77177, 9.378214, 'Schaferhaus Arpt', 1);
INSERT INTO public.airports VALUES (1096, 'Flagstaff', 'FLG', 'US', 35.14032, -111.669235, 'Flagstaff Arpt', -7);
INSERT INTO public.airports VALUES (1097, 'Ft Lauderdale', 'FXE', 'US', 26.19728, -80.17071, 'Ft Lauderdale Excutive', -5);
INSERT INTO public.airports VALUES (1098, 'Ft Lauderdale', 'FLL', 'US', 26.072582, -80.15275, 'Ft Lauderdale Hollywood Intl Arpt', -5);
INSERT INTO public.airports VALUES (1099, 'Ft Lauderdale', 'BCT', 'US', 26.3785, -80.1077, 'Boca Raton Public', -5);
INSERT INTO public.airports VALUES (1100, 'Florianopolis', 'FLN', 'BR', -27.670488, -48.54718, 'Hercilio Luz Arpt', -3);
INSERT INTO public.airports VALUES (1101, 'Florence', 'FLO', 'US', 34.18536, -79.72389, 'Gilbert Field', -5);
INSERT INTO public.airports VALUES (1102, 'Flippin', 'FLP', 'US', 0, 0, 'Flippin Arpt', -100);
INSERT INTO public.airports VALUES (1103, 'Florence', 'FLR', 'IT', 43.80995, 11.2051, 'Amerigo Vespucci Arpt', 1);
INSERT INTO public.airports VALUES (1104, 'Santa Cruz Flores', 'FLW', 'PT', 39.455273, -31.131361, 'Aerodromo Das Flores', -1);
INSERT INTO public.airports VALUES (1105, 'Formosa', 'FMA', 'AR', -26.212723, -58.22811, 'El Pucu Arpt', -3);
INSERT INTO public.airports VALUES (1106, 'Falmouth', 'FMH', 'US', 41.65844, -70.521416, 'Otis AFB', -5);
INSERT INTO public.airports VALUES (1107, 'Memmingen Allgaeu', 'FMM', 'DE', 47.988758, 10.2395, 'Allgaeu Arpt', 1);
INSERT INTO public.airports VALUES (1108, 'Farmington', 'FMN', 'US', 36.74125, -108.22994, 'Four Corners Regional Arpt', -7);
INSERT INTO public.airports VALUES (1109, 'Muenster', 'FMO', 'DE', 52.134644, 7.684831, 'Muenster Airport', 1);
INSERT INTO public.airports VALUES (1110, 'Fort Madison', 'FMS', 'US', 0, 0, 'Fort Madison Municipal', -100);
INSERT INTO public.airports VALUES (1111, 'Fort Myers', 'RSW', 'US', 26.536167, -81.755165, 'Regional Southwest Arpt', -5);
INSERT INTO public.airports VALUES (1112, 'Freetown', 'FNA', 'SL', 8.616444, -13.195489, 'Lungi Intl Arpt', 0);
INSERT INTO public.airports VALUES (1113, 'Funchal', 'FNC', 'PT', 32.697887, -16.774452, 'Madeira Arpt', 0);
INSERT INTO public.airports VALUES (1114, 'Nimes', 'FNI', 'FR', 43.757442, 4.416347, 'Nimes Airport', 1);
INSERT INTO public.airports VALUES (1115, 'Pyongyang', 'FNJ', 'KP', 39.22406, 125.67015, 'Sunan Arpt', 9);
INSERT INTO public.airports VALUES (1116, 'Ft Collins', 'QWF', 'US', 0, 0, 'Fort Collins Bus Service', -100);
INSERT INTO public.airports VALUES (1117, 'Ft Collins', 'FNL', 'US', 40.451828, -105.01134, 'Municipal Airport', -7);
INSERT INTO public.airports VALUES (1118, 'Ft Collins', 'QWH', 'US', 0, 0, 'Loveland Bus Service', -100);
INSERT INTO public.airports VALUES (1119, 'Flint', 'FNT', 'US', 42.965424, -83.74363, 'Bishop Intl Arpt', -5);
INSERT INTO public.airports VALUES (1120, 'Fort Bragg', 'FOB', 'US', 0, 0, 'Fort Bragg Arpt', -100);
INSERT INTO public.airports VALUES (1121, 'Fuzhou', 'FOC', 'CN', 25.935064, 119.66327, 'Fuzhou Arpt', 8);
INSERT INTO public.airports VALUES (1122, 'Fort Dodge', 'FOD', 'US', 42.5512, -94.19184, 'Ft Dodge Municipal', -6);
INSERT INTO public.airports VALUES (1123, 'Foggia', 'FOG', 'IT', 41.43292, 15.535028, 'Gino Lisa Arpt', 1);
INSERT INTO public.airports VALUES (1124, 'Westhampton', 'FOK', 'US', 40.843655, -72.63179, 'Suffolk County Arpt', -5);
INSERT INTO public.airports VALUES (1125, 'Fortaleza', 'FOR', 'BR', -3.776283, -38.532555, 'Pinto Martines Arpt', -3);
INSERT INTO public.airports VALUES (1126, 'Forster', 'FOT', 'AU', 0, 0, 'Forster', -100);
INSERT INTO public.airports VALUES (1127, 'Freeport', 'FPO', 'BS', 26.558685, -78.69556, 'Grand Bahama Intl Arpt', -5);
INSERT INTO public.airports VALUES (1128, 'Fort Pierce', 'FPR', 'US', 27.495, -80.3683, 'St Lucie County Arpt', -100);
INSERT INTO public.airports VALUES (1129, 'Frankfurt', 'HHN', 'DE', 49.948673, 7.263892, 'Hahn Arpt', 1);
INSERT INTO public.airports VALUES (1130, 'Frankfurt', 'QGV', 'DE', 0, 0, 'Neu Isenburg Arpt', -100);
INSERT INTO public.airports VALUES (1131, 'Frankfurt', 'ZRB', 'DE', 50.107025, 8.662761, 'Frankfurt HBF Railway Service', 1);
INSERT INTO public.airports VALUES (1132, 'Frankfurt', 'FRF', 'DE', 50.1, 8.683333, 'Rhein-Main Air Force Base', 2);
INSERT INTO public.airports VALUES (1133, 'Frankfurt', 'FRA', 'DE', 50.02642, 8.543125, 'Frankfurt Intl', 1);
INSERT INTO public.airports VALUES (1134, 'Friday Harbor', 'FRD', 'US', 48.521942, -123.024445, 'Friday Harbor Airport', -8);
INSERT INTO public.airports VALUES (1135, 'Farmingdale', 'FRG', 'US', 40.7288, -73.4134, 'Republic Arpt', -100);
INSERT INTO public.airports VALUES (1136, 'French Lick', 'FRH', 'US', 0, 0, 'French Lick Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1137, 'Frejus', 'FRJ', 'FR', 43.416668, 6.733333, 'Frejus Arpt', 1);
INSERT INTO public.airports VALUES (1138, 'Forli', 'FRL', 'IT', 44.19475, 12.070094, 'Luigi Ridolfi Arpt', 1);
INSERT INTO public.airports VALUES (1139, 'Fairmont', 'FRM', 'US', 0, 0, 'Fairmont Municipal', -100);
INSERT INTO public.airports VALUES (1140, 'Floro', 'FRO', 'NO', 61.58361, 5.024722, 'Flora Arpt', 1);
INSERT INTO public.airports VALUES (1141, 'Front Royal', 'FRR', 'US', 0, 0, 'Warren County Arpt', -100);
INSERT INTO public.airports VALUES (1142, 'Flores', 'FRS', 'GT', 16.913818, -89.86639, 'Flores Airport', -6);
INSERT INTO public.airports VALUES (1143, 'Bishkek', 'FRU', 'KG', 43.061306, 74.477554, 'Bishkek Arpt', 5);
INSERT INTO public.airports VALUES (1144, 'Francistown', 'FRW', 'BW', -21.159597, 27.474525, 'Francistown Arpt', 2);
INSERT INTO public.airports VALUES (1145, 'Fritzlar', 'FRZ', 'DE', 51.1145, 9.2858, 'Fritzlar Airbase', -100);
INSERT INTO public.airports VALUES (1146, 'Figari', 'FSC', 'FR', 41.500557, 9.097777, 'Sud Corse Arpt', 1);
INSERT INTO public.airports VALUES (1147, 'Sioux Falls', 'FSD', 'US', 43.582012, -96.74191, 'Regional Joe Foss Field', -6);
INSERT INTO public.airports VALUES (1148, 'Ft Smith', 'FSM', 'US', 35.336582, -94.36745, 'Ft Smith Municipal', -6);
INSERT INTO public.airports VALUES (1149, 'St Pierre', 'FSP', 'CA', 46.762905, -56.173088, 'St Pierre Arpt', -4);
INSERT INTO public.airports VALUES (1150, 'Fort Stockton', 'FST', 'US', 30.915667, -102.91614, 'Pecos County Arpt', -6);
INSERT INTO public.airports VALUES (1151, 'El Calafate', 'FTE', 'AR', -50.280323, -72.0531, 'El Calafate Arpt', -3);
INSERT INTO public.airports VALUES (1152, 'Fort Dauphin', 'FTU', 'MG', -25.038055, 46.956112, 'Marillac Arpt', 3);
INSERT INTO public.airports VALUES (1153, 'Ft Worth', 'FTW', 'US', 32.81978, -97.36244, 'Meacham Field', -6);
INSERT INTO public.airports VALUES (1154, 'Puerto Del Rosario', 'FUE', 'ES', 28.452717, -13.863761, 'Fuerteventura Arpt', 0);
INSERT INTO public.airports VALUES (1155, 'Fuyang', 'FUG', 'CN', 32.9, 115.816666, 'Fuyang Aprt', 8);
INSERT INTO public.airports VALUES (1156, 'Fukue', 'FUJ', 'JP', 32.666267, 128.83281, 'Fukue Arpt', 9);
INSERT INTO public.airports VALUES (1157, 'Fukuoka', 'FUK', 'JP', 33.58594, 130.45068, 'Itazuke Arpt', 9);
INSERT INTO public.airports VALUES (1158, 'Fullerton', 'FUL', 'US', 33.521927, -117.584724, 'Fullerton Municipal Arpt', -7);
INSERT INTO public.airports VALUES (1159, 'Funafuti', 'FUN', 'TV', -8.525, 179.1964, 'Funafuti Intl Arpt', 12);
INSERT INTO public.airports VALUES (1160, 'Ft Wayne', 'FWA', 'US', 40.978474, -85.19514, 'Baer Field', -5);
INSERT INTO public.airports VALUES (1161, 'Fort William', 'FWM', 'GB', 56.816666, -5.116667, 'Fort William Arpt', 0);
INSERT INTO public.airports VALUES (1162, 'Fayetteville', 'FYV', 'US', 36.005093, -94.17006, 'Fayetteville Municipal Arpt', -6);
INSERT INTO public.airports VALUES (1163, 'Fayetteville', 'XNA', 'US', 36.281868, -94.30681, 'Northwest Arkansas Regional Arpt', -6);
INSERT INTO public.airports VALUES (1164, 'Gadsden', 'GAD', 'US', 33.97265, -86.08908, 'Gadsden Municipal', -5);
INSERT INTO public.airports VALUES (1165, 'Gaithersburg', 'GAI', 'US', 39.1006, -77.09576, 'Montgomery Cty Arpt', -5);
INSERT INTO public.airports VALUES (1166, 'Yamagata', 'GAJ', 'JP', 38.411896, 140.37134, 'Yamagata Airport', 9);
INSERT INTO public.airports VALUES (1167, 'Galena', 'GAL', 'US', 64.736176, -156.93742, 'Galena Arpt', -9);
INSERT INTO public.airports VALUES (1168, 'Gan Island', 'GAN', 'MV', -0.693342, 73.1556, 'Gan International Arpt', 5);
INSERT INTO public.airports VALUES (1169, 'Garaina', 'GAR', 'PG', 0, 0, 'Garaina Arpt', -100);
INSERT INTO public.airports VALUES (1170, 'Gap France', 'GAT', 'FR', 0, 0, 'Tallard Arpt', -100);
INSERT INTO public.airports VALUES (1171, 'Guwahati', 'GAU', 'IN', 26.106092, 91.58594, 'Lokpriya Gopinath Bordoloi Intl Arpt', 5);
INSERT INTO public.airports VALUES (1172, 'Gaya', 'GAY', 'IN', 24.744308, 84.95117, 'Gaya Arpt', 5);
INSERT INTO public.airports VALUES (1173, 'Great Bend', 'GBD', 'US', 38.3443, -98.8592, 'Greate Bend Municipal', -100);
INSERT INTO public.airports VALUES (1174, 'Gaborone', 'GBE', 'BW', -24.555225, 25.918207, 'Gaborone Arpt', 2);
INSERT INTO public.airports VALUES (1175, 'Galesburg', 'GBG', 'US', 0, 0, 'Galesburg Arpt', -100);
INSERT INTO public.airports VALUES (1176, 'Gbangbatok', 'GBK', 'SL', 7.767, -12.383, 'Gbangbatok Arpt', 0);
INSERT INTO public.airports VALUES (1177, 'San Giovanni Rotondo', 'GBN', 'IT', 38.344166, -98.85917, 'San Giovanni Rotondo Arpt', -5);
INSERT INTO public.airports VALUES (1178, 'Muharraq Town', 'GBQ', 'BH', 0, 0, 'Muharraq Arpt', -100);
INSERT INTO public.airports VALUES (1179, 'Great Barrington', 'GBR', 'US', 0, 0, 'Great Barrington Arpt', -100);
INSERT INTO public.airports VALUES (1180, 'Great Barrier Island', 'GBZ', 'NZ', -36.1429, 175.2819, 'Great Barrier Island Arpt', 11);
INSERT INTO public.airports VALUES (1181, 'Gillette', 'GCC', 'US', 44.348915, -105.53936, 'Campbell Cty Arpt', -7);
INSERT INTO public.airports VALUES (1182, 'Guernsey', 'GCI', 'GB', 49.434956, -2.601969, 'Guernsey Arpt', 0);
INSERT INTO public.airports VALUES (1183, 'Garden City', 'GCK', 'US', 37.92753, -100.72442, 'Garden City Municipal', -6);
INSERT INTO public.airports VALUES (1184, 'Grand Cayman Island', 'GCM', 'KY', 19.292778, -81.35775, 'Owen Roberts Arpt', -5);
INSERT INTO public.airports VALUES (1185, 'Grand Canyon', 'GCN', 'US', 35.952362, -112.14697, 'Grand Canyon Natl Park Arpt', -7);
INSERT INTO public.airports VALUES (1186, 'Gravatai', 'GCV', 'BR', 0, 0, 'Gravatai Arpt', -100);
INSERT INTO public.airports VALUES (1187, 'Greeneville', 'GCY', 'US', 0, 0, 'Municipal Greeneville Arpt', -100);
INSERT INTO public.airports VALUES (1188, 'Magdagachi Airport', 'GDG', 'RU', 0, 0, 'Magdagachi Airport', -2);
INSERT INTO public.airports VALUES (1189, 'Guadalajara', 'GDL', 'MX', 20.5218, -103.311165, 'Miguel Hidalgo Arpt', -6);
INSERT INTO public.airports VALUES (1190, 'Gdansk', 'GDN', 'PL', 54.377567, 18.466223, 'Rebiechowo', 1);
INSERT INTO public.airports VALUES (1191, 'Grand Turk', 'GDT', 'TC', 21.4445, -71.1423, 'Grand Turk Is Arpt', -5);
INSERT INTO public.airports VALUES (1192, 'Magadan', 'GDX', 'RU', 59.910988, 150.72044, 'Magadan Arpt', 12);
INSERT INTO public.airports VALUES (1193, 'Gelendzhik Arpt.', 'GDZ', 'RU', 44.566666, 38.016666, 'Gelendzhik Arpt.', 4);
INSERT INTO public.airports VALUES (1194, 'Georgetown', 'GED', 'US', 38.689194, -75.35889, 'Sussex County Arpt', -5);
INSERT INTO public.airports VALUES (1195, 'Spokane', 'SFF', 'US', 47.68282, -117.322556, 'Felts Field', -8);
INSERT INTO public.airports VALUES (1196, 'Spokane', 'GEG', 'US', 47.61986, -117.53384, 'Spokane Intl Arpt', -8);
INSERT INTO public.airports VALUES (1197, 'Georgetown', 'GEO', 'GY', 6.498553, -58.25412, 'Cheddi Jagan Intl', -4);
INSERT INTO public.airports VALUES (1198, 'Nueva Gerona', 'GER', 'CU', 21.834688, -82.78382, 'Rafael Cabrera Arpt', -5);
INSERT INTO public.airports VALUES (1199, 'General Santos', 'GES', 'PH', 6.106439, 125.2353, 'Buayan Arpt', 8);
INSERT INTO public.airports VALUES (1200, 'Geraldton', 'GET', 'AU', -28.7961, 114.707, 'Geraldton Arpt', 8);
INSERT INTO public.airports VALUES (1201, 'Gallivare', 'GEV', 'SE', 67.13241, 20.814636, 'Gallivare Arpt', 1);
INSERT INTO public.airports VALUES (1202, 'Geelong', 'GEX', 'AU', -38.225, 144.333, 'Geelong Arpt', 10);
INSERT INTO public.airports VALUES (1203, 'Greenfield', 'GFD', 'US', 0, 0, 'Pope Field Arpt', -100);
INSERT INTO public.airports VALUES (1204, 'Griffith', 'GFF', 'AU', -34.2508, 146.067, 'Griffith Arpt', 10);
INSERT INTO public.airports VALUES (1205, 'Grand Forks', 'GFK', 'US', 47.949257, -97.17611, 'Grand Forks Mark Andrews Intl', -6);
INSERT INTO public.airports VALUES (1206, 'Glens Falls', 'GFL', 'US', 43.3411, -73.6103, 'Warren County', -100);
INSERT INTO public.airports VALUES (1207, 'Grafton', 'GFN', 'AU', -29.7594, 153.03, 'Grafton Arpt', 10);
INSERT INTO public.airports VALUES (1208, 'Longview', 'GGG', 'US', 32.384014, -94.71149, 'Greg County Arpt', -6);
INSERT INTO public.airports VALUES (1209, 'George Town', 'GGT', 'BS', 23.562632, -75.87796, 'George Town Airport', -5);
INSERT INTO public.airports VALUES (1210, 'Glasgow', 'GGW', 'US', 48.2125, -106.615, 'International Glasgow', -7);
INSERT INTO public.airports VALUES (1211, 'Ghardaia', 'GHA', 'DZ', 32.384106, 3.794114, 'Noumerate Arpt', 1);
INSERT INTO public.airports VALUES (1212, 'Governor S Harbour', 'GHB', 'BS', 25.284706, -76.33101, 'Governors Harbour Municipal Arpt', -5);
INSERT INTO public.airports VALUES (1213, 'Gibraltar', 'GIB', 'GI', 36.15122, -5.349664, 'North Front Arpt', 1);
INSERT INTO public.airports VALUES (1214, 'Boigu Island', 'GIC', 'AU', -9.23278, 142.218, 'Boigu Island Arpt', 10);
INSERT INTO public.airports VALUES (1215, 'Winter Haven', 'GIF', 'US', 0, 0, 'Gilbert Fld', -100);
INSERT INTO public.airports VALUES (1216, 'Gilgit', 'GIL', 'PK', 35.918785, 74.33364, 'Gilgit Arpt', 5);
INSERT INTO public.airports VALUES (1217, 'Girardot', 'GIR', 'CO', 4.2761, -74.7958, 'Girardot Arpt', -100);
INSERT INTO public.airports VALUES (1218, 'Gisborne', 'GIS', 'NZ', -38.663334, 177.97833, 'Gisborne Arpt', 12);
INSERT INTO public.airports VALUES (1219, 'Gizan', 'GIZ', 'SA', 16.901112, 42.585835, 'Gizan Aprt', 3);
INSERT INTO public.airports VALUES (1220, 'Grand Junction', 'GJT', 'US', 39.122414, -108.52673, 'Walker Field Arpt', -7);
INSERT INTO public.airports VALUES (1221, 'Goroka', 'GKA', 'PG', -6.081689, 145.39188, 'Goroka Arpt', 10);
INSERT INTO public.airports VALUES (1222, 'GOKCEADA', 'GKD', 'TR', 0, 0, 'GOKCEADA', 1);
INSERT INTO public.airports VALUES (1223, 'Gatlinburg', 'GKT', 'US', 0, 0, 'Gatlinburg Arpt', -100);
INSERT INTO public.airports VALUES (1224, 'Glasgow', 'PIK', 'GB', 55.509445, -4.586667, 'Prestwick Arpt', 0);
INSERT INTO public.airports VALUES (1225, 'Glasgow', 'ZGG', 'GB', 0, 0, 'Glasgow ScotRail', -100);
INSERT INTO public.airports VALUES (1226, 'Glasgow', 'GLA', 'GB', 55.871944, -4.433056, 'Glasgow Intl', 0);
INSERT INTO public.airports VALUES (1227, 'Goodland', 'GLD', 'US', 39.37062, -101.69899, 'Goodland Municipal', -6);
INSERT INTO public.airports VALUES (1228, 'Gainesville', 'GLE', 'US', 33.6514, -97.1969, 'Gainesville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1229, 'Greenville', 'GLH', 'US', 33.4829, -90.9856, 'Greenville Municipal', -6);
INSERT INTO public.airports VALUES (1230, 'Glen Innes', 'GLI', 'AU', -29.6767, 151.6917, 'Glen Innes Arpt', -100);
INSERT INTO public.airports VALUES (1231, 'Gol City', 'XKZ', 'NO', 0, 0, 'Vinstra Rail Station', -100);
INSERT INTO public.airports VALUES (1232, 'Gol City', 'XGP', 'NO', 0, 0, 'Dombas Rail Station', -100);
INSERT INTO public.airports VALUES (1233, 'Gol City', 'GLL', 'NO', 0, 0, 'Klanten Arpt', -100);
INSERT INTO public.airports VALUES (1234, 'Gloucester', 'GLO', 'GB', 51.89417, -2.167222, 'Staverton Arpt', 0);
INSERT INTO public.airports VALUES (1235, 'Gaylord', 'GLR', 'US', 0, 0, 'Otsego Arpt', -100);
INSERT INTO public.airports VALUES (1236, 'Galveston', 'GLS', 'US', 29.265322, -94.860405, 'Scholes Field', -6);
INSERT INTO public.airports VALUES (1237, 'Gladstone', 'GLT', 'AU', -23.8697, 151.223, 'Gladstone Airport', 10);
INSERT INTO public.airports VALUES (1238, 'Glasgow', 'GLW', 'US', 0, 0, 'Glasgow Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1239, 'Gomel', 'GME', 'BY', 52.527023, 31.016691, 'Gomel Arpt', 2);
INSERT INTO public.airports VALUES (1240, 'Greymouth', 'GMN', 'NZ', -42.4617, 171.19, 'Greymouth Arpt', -100);
INSERT INTO public.airports VALUES (1241, 'Gambier Island', 'GMR', 'PF', -23.07986, -134.89034, 'Gambier Island Arpt', -9);
INSERT INTO public.airports VALUES (1242, 'San Sebastian De La Gomera', 'GMZ', 'ES', 28.0296, -17.2146, 'La Gomera Arpt', 0);
INSERT INTO public.airports VALUES (1243, 'Grodna', 'GNA', 'BY', 53.602, 24.0538, 'Grodna Arpt', 2);
INSERT INTO public.airports VALUES (1244, 'Grenoble', 'GNB', 'FR', 45.362946, 5.329375, 'Saint Geoirs Arpt', 1);
INSERT INTO public.airports VALUES (1245, 'Grenada', 'GND', 'DM', 12.004247, -61.786194, 'Port Saline Intl', -4);
INSERT INTO public.airports VALUES (1246, 'Gunungsitoli', 'GNS', 'ID', 1.166381, 97.70468, 'Gunungsitoli Arpt', 7);
INSERT INTO public.airports VALUES (1247, 'Grants', 'GNT', 'US', 35.167286, -107.90199, 'Grants Milan Municipal Arpt', -7);
INSERT INTO public.airports VALUES (1248, 'Gainesville', 'GNV', 'US', 29.690056, -82.271774, 'Gainesville Regional', -5);
INSERT INTO public.airports VALUES (1249, 'Genoa', 'GOA', 'IT', 44.413334, 8.8375, 'Christoforo Colombo', 1);
INSERT INTO public.airports VALUES (1250, 'Nuuk', 'GOH', 'GL', 64.190926, -51.678062, 'Nuuk Arpt', -3);
INSERT INTO public.airports VALUES (1251, 'Goa In', 'GOI', 'IN', 15.380833, 73.83142, 'Dabolim Arpt', 5);
INSERT INTO public.airports VALUES (1252, 'Nizhniy Novgorod', 'GOJ', 'RU', 56.230118, 43.784042, 'Nizhniy Novgorod Arpt', 4);
INSERT INTO public.airports VALUES (1253, 'New London', 'GON', 'US', 41.330055, -72.045135, 'Groton New London Arpt', -5);
INSERT INTO public.airports VALUES (1254, 'Goondiwindi', 'GOO', 'AU', -28.5217, 150.32, 'Goondiwindi Arpt', -100);
INSERT INTO public.airports VALUES (1255, 'Gorakhpur', 'GOP', 'IN', 26.739708, 83.44971, 'Gorakhpur Arpt', 5);
INSERT INTO public.airports VALUES (1256, 'Golmud', 'GOQ', 'CN', 34.633, 98.867, 'Golmud Arpt', 8);
INSERT INTO public.airports VALUES (1257, 'Gothenburg', 'GSE', 'SE', 57.774723, 11.870372, 'Saeve Arpt', 1);
INSERT INTO public.airports VALUES (1258, 'Gothenburg', 'GOT', 'SE', 57.662834, 12.279819, 'Landvetter Arpt', 1);
INSERT INTO public.airports VALUES (1259, 'Gothenburg', 'XWL', 'SE', 0, 0, 'Gothenburg Rail', -100);
INSERT INTO public.airports VALUES (1260, 'Garoua', 'GOU', 'CM', 9.335892, 13.370103, 'Garoua Arpt', 1);
INSERT INTO public.airports VALUES (1261, 'Gove', 'GOV', 'AU', -12.2694, 136.818, 'Nhulunbuy Arpt', 9);
INSERT INTO public.airports VALUES (1262, 'Patras', 'GPA', 'GR', 38.15111, 21.425556, 'Araxos Arpt', 2);
INSERT INTO public.airports VALUES (1263, 'Galapagos Is', 'GPS', 'EC', -0.453758, -90.265915, 'Baltra Arpt', -6);
INSERT INTO public.airports VALUES (1264, 'Gulfport', 'GPT', 'US', 30.407278, -89.070114, 'Biloxi Regional Arpt', -6);
INSERT INTO public.airports VALUES (1265, 'Grand Rapids', 'GPZ', 'US', 47.21111, -93.50972, 'Itasca County', -6);
INSERT INTO public.airports VALUES (1266, 'Galion', 'GQQ', 'US', 0, 0, 'Galion Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1267, 'Green Bay', 'GRB', 'US', 44.485073, -88.129585, 'Austin Straubel Fld', -6);
INSERT INTO public.airports VALUES (1268, 'Grand Island', 'GRI', 'US', 40.9675, -98.3096, 'Hall Cty Regional', -6);
INSERT INTO public.airports VALUES (1269, 'George', 'GRJ', 'ZA', -34.005554, 22.37889, 'George Arpt', 2);
INSERT INTO public.airports VALUES (1270, 'Gerona', 'GRO', 'ES', 41.90097, 2.760547, 'Costa Brava Arpt', 1);
INSERT INTO public.airports VALUES (1271, 'Groningen', 'GRQ', 'NL', 53.11972, 6.579444, 'Eelde Arpt', 1);
INSERT INTO public.airports VALUES (1272, 'Grand Rapids', 'GRR', 'US', 42.880833, -85.522804, 'Kent County Intl', -5);
INSERT INTO public.airports VALUES (1273, 'Grosseto', 'GRS', 'IT', 42.759747, 11.071897, 'Baccarini Arpt', 1);
INSERT INTO public.airports VALUES (1274, 'Groznyj', 'GRV', 'RU', 43.2981, 45.7841, 'Groznyj', 4);
INSERT INTO public.airports VALUES (1275, 'Graciosa Island', 'GRW', 'PT', 39.09217, -28.029846, 'Graciosa Arpt', -1);
INSERT INTO public.airports VALUES (1276, 'Granada', 'GRX', 'ES', 37.188732, -3.777356, 'Granada Arpt', 1);
INSERT INTO public.airports VALUES (1277, 'Graz', 'GRZ', 'AT', 46.991066, 15.439628, 'Thalerhof Arpt', 1);
INSERT INTO public.airports VALUES (1278, 'Goldsboro', 'GSB', 'US', 35.339382, -77.96059, 'Seymour Johnson AFB', -5);
INSERT INTO public.airports VALUES (1279, 'Greensboro', 'GSO', 'US', 36.09775, -79.93731, 'Piedmont Triad Intl', -5);
INSERT INTO public.airports VALUES (1280, 'Greenville', 'SPA', 'US', 0, 0, 'Downtown Memorial', -100);
INSERT INTO public.airports VALUES (1281, 'Greenville', 'GSP', 'US', 34.895557, -82.21889, 'Greenville Spartanburg Arpt', -5);
INSERT INTO public.airports VALUES (1282, 'Greenville', 'GMU', 'US', 34.8481, -82.35, 'Greenville Downtown Arpt', -100);
INSERT INTO public.airports VALUES (1283, 'Glacier Bay', 'GST', 'US', 58.4253, -135.707, 'Gustavus Arpt', -9);
INSERT INTO public.airports VALUES (1284, 'Grimsby', 'GSY', 'GB', 0, 0, 'Binbrook Arpt', -100);
INSERT INTO public.airports VALUES (1285, 'Groote Eylandt', 'GTE', 'AU', -13.975, 136.46, 'Alyangula Arpt', 9);
INSERT INTO public.airports VALUES (1286, 'Great Falls', 'GTF', 'US', 47.482, -111.37069, 'Great Falls Intl Arpt', -7);
INSERT INTO public.airports VALUES (1287, 'Guettin', 'GTI', 'DE', 54.38333, 13.325278, 'Guettin Arpt', 1);
INSERT INTO public.airports VALUES (1288, 'Gettysburg', 'GTY', 'US', 0, 0, 'Gettysburg Arpt', -100);
INSERT INTO public.airports VALUES (1289, 'Guatemala City', 'GUA', 'GT', 14.583272, -90.52747, 'La Aurora Arpt', -6);
INSERT INTO public.airports VALUES (1290, 'Gunnison', 'GUC', 'US', 38.53389, -106.93306, 'Gunnison Cty', -7);
INSERT INTO public.airports VALUES (1291, 'Gulf Shores', 'GUF', 'US', 0, 0, 'Edwards Arpt', -100);
INSERT INTO public.airports VALUES (1292, 'Gunnedah', 'GUH', 'AU', -30.9611, 150.2506, 'Gunnedah Airport', -100);
INSERT INTO public.airports VALUES (1293, 'Guam', 'UAM', 'GU', 13.583953, 144.93002, 'Anderson Air Force Base', 10);
INSERT INTO public.airports VALUES (1294, 'Guam', 'GUM', 'GU', 13.48345, 144.79599, 'Antonio B Won Pat Intl', 10);
INSERT INTO public.airports VALUES (1295, 'Gallup', 'GUP', 'US', 35.51106, -108.78931, 'Gallup Municipal', -7);
INSERT INTO public.airports VALUES (1296, 'Alotau', 'GUR', 'PG', -10.3115, 150.334, 'Gurney Arpt', 10);
INSERT INTO public.airports VALUES (1297, 'Gutersloh', 'GUT', 'DE', 51.922832, 8.306333, 'Guetersloh Arpt', 1);
INSERT INTO public.airports VALUES (1298, 'Atyrau', 'GUW', 'KZ', 47.121944, 51.82139, 'Atyrau Arpt', 5);
INSERT INTO public.airports VALUES (1299, 'Guymon', 'GUY', 'US', 36.6853, -101.5078, 'Guymon Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1300, 'Geneva', 'GVA', 'CH', 46.238064, 6.10895, 'Geneve Cointrin', 1);
INSERT INTO public.airports VALUES (1301, 'Governador Valadares', 'GVR', 'BR', -18.8952, -41.9822, 'Governador Valadares Arpt', -3);
INSERT INTO public.airports VALUES (1302, 'Gavle', 'XFU', 'SE', 0, 0, 'Tierp Rail Station', -100);
INSERT INTO public.airports VALUES (1303, 'Gavle', 'GVX', 'SE', 60.593334, 16.95139, 'Sandviken Arpt', 1);
INSERT INTO public.airports VALUES (1304, 'Gavle', 'QYU', 'SE', 0, 0, 'Gavle Rail Station', -100);
INSERT INTO public.airports VALUES (1305, 'Gweru', 'GWE', 'ZW', -19.436394, 29.861912, 'Gweru Airport', 2);
INSERT INTO public.airports VALUES (1306, 'Gwalior', 'GWL', 'IN', 26.293337, 78.22775, 'Gwalior Airport', 5);
INSERT INTO public.airports VALUES (1307, 'Greenwood', 'GWO', 'US', 33.494328, -90.08471, 'Leflore Arpt', -6);
INSERT INTO public.airports VALUES (1308, 'Glenwood Springs', 'GWS', 'US', 0, 0, 'Glenwood Springs Arpt', -100);
INSERT INTO public.airports VALUES (1309, 'Westerland', 'GWT', 'DE', 54.91325, 8.340472, 'Westerland Airport', 1);
INSERT INTO public.airports VALUES (1310, 'Galway', 'GWY', 'IE', 53.300175, -8.941592, 'Carnmore Arpt', 0);
INSERT INTO public.airports VALUES (1311, 'Coyhaique', 'GXQ', 'CL', -45.59421, -72.10613, 'Teniente Vidal Arpt', -4);
INSERT INTO public.airports VALUES (1312, 'Greeley', 'GXY', 'US', 0, 0, 'Weld County Regional Arpt', -100);
INSERT INTO public.airports VALUES (1313, 'Guayaquil', 'GYE', 'EC', -2.157419, -79.88356, 'Simon Bolivar Airport', -5);
INSERT INTO public.airports VALUES (1314, 'Gisenyi', 'GYI', 'RW', -1.677203, 29.258875, 'Gisenyi Arpt', 2);
INSERT INTO public.airports VALUES (1315, 'Guaymas', 'GYM', 'MX', 27.968983, -110.92517, 'Gen Jose M Yanez Arpt', -7);
INSERT INTO public.airports VALUES (1316, 'Goiania', 'GYN', 'BR', -16.632032, -49.220688, 'Santa Genoveva', -3);
INSERT INTO public.airports VALUES (1317, 'Gympie', 'GYP', 'AU', -26.2833, 152.7, 'Gympie Arpt', -100);
INSERT INTO public.airports VALUES (1318, 'Goodyear', 'GYR', 'US', 33.4237, -112.3745, 'Litchfield Goodyear Arpt', -100);
INSERT INTO public.airports VALUES (1319, 'Guang Yuan', 'GYS', 'CN', 32.3911, 105.702, 'Guang Yuan Arpt', 8);
INSERT INTO public.airports VALUES (1320, 'Gary', 'GYY', 'US', 41.6163, -87.4128, 'Gary International Arpt', -6);
INSERT INTO public.airports VALUES (1321, 'Gaza', 'GZA', 'PS', 31.24639, 34.27611, 'Gaza International Arpt', 2);
INSERT INTO public.airports VALUES (1322, 'Gozo', 'GZM', 'MT', 36.02722, 14.272778, 'Gozo Arpt', 1);
INSERT INTO public.airports VALUES (1323, 'Gizo', 'GZO', 'SB', -8.09778, 156.864, 'Gizo Arpt', 11);
INSERT INTO public.airports VALUES (1324, 'Gazipasa', 'GZP', 'TR', 36.2993, 32.3014, 'Gazipasa Arpt', 2);
INSERT INTO public.airports VALUES (1325, 'Gaziantep', 'GZT', 'TR', 36.94718, 37.478683, 'Gaziantep Arpt', 2);
INSERT INTO public.airports VALUES (1326, 'Hachijo Jima', 'HAC', 'JP', 33.115, 139.78583, 'Hachijo Jima Arpt', 9);
INSERT INTO public.airports VALUES (1327, 'Halmstad', 'HAD', 'SE', 56.691128, 12.820211, 'Halmstad Arpt', 1);
INSERT INTO public.airports VALUES (1328, 'Halmstad', 'XYM', 'SE', 0, 0, 'Falkenberg Rail Station', -100);
INSERT INTO public.airports VALUES (1329, 'Hanover', 'ZVR', 'DE', 52.376, 9.741, 'Hanover HBF Railway Service', -100);
INSERT INTO public.airports VALUES (1330, 'Hanover', 'HAJ', 'DE', 52.461056, 9.685078, 'Hanover Arpt', 1);
INSERT INTO public.airports VALUES (1331, 'Haikou', 'HAK', 'CN', 19.934856, 110.45896, 'Haikou Arpt', 8);
INSERT INTO public.airports VALUES (1332, 'Hamburg', 'ZMB', 'DE', 53.58, 9.98, 'Hamburg Railway Service', -100);
INSERT INTO public.airports VALUES (1333, 'Hamburg', 'HAM', 'DE', 53.63039, 9.988228, 'Fuhlsbuettel Arpt', 1);
INSERT INTO public.airports VALUES (1334, 'Hamburg', 'LBC', 'DE', 53.805367, 10.719222, 'Blankensee Arpt', 1);
INSERT INTO public.airports VALUES (1335, 'Hanoi', 'HAN', 'VN', 21.221191, 105.807175, 'Noibai Arpt', 7);
INSERT INTO public.airports VALUES (1336, 'Long Island', 'HAP', 'AU', 0, 0, 'Long Island Arpt', -100);
INSERT INTO public.airports VALUES (1337, 'Harrisburg', 'MDT', 'US', 40.193493, -76.763405, 'Harrisburg Intl', -5);
INSERT INTO public.airports VALUES (1338, 'Hail', 'HAS', 'SA', 27.437918, 41.68629, 'Hail Arpt', 3);
INSERT INTO public.airports VALUES (1339, 'Haugesund', 'HAU', 'NO', 59.34527, 5.208364, 'Karmoy Arpt', 1);
INSERT INTO public.airports VALUES (1340, 'Havana', 'HAV', 'CU', 22.989153, -82.40909, 'Jose Marti Intl Arpt', -5);
INSERT INTO public.airports VALUES (1341, 'Hobart', 'HBA', 'AU', -42.83611, 147.51028, 'Hobart International Arpt', 10);
INSERT INTO public.airports VALUES (1342, 'Borg El Arab', 'HBE', 'EG', 30.91767, 29.696407, 'Borg El Arab Arpt', 2);
INSERT INTO public.airports VALUES (1343, 'Hattiesburg', 'HBG', 'US', 0, 0, 'Bobby L Chain Municipal', -100);
INSERT INTO public.airports VALUES (1344, 'Harbour Island', 'HBI', 'BS', 0, 0, 'Harbour Island Arpt', -100);
INSERT INTO public.airports VALUES (1345, 'Hafr Albatin', 'HBT', 'SA', 27.900917, 45.528194, 'Hafr Albatin Arpt', 3);
INSERT INTO public.airports VALUES (1346, 'Hubli', 'HBX', 'IN', 15.3617, 75.0849, 'Hubli Arpt', 5);
INSERT INTO public.airports VALUES (1347, 'Hengchun', 'HCN', 'TW', 22.041075, 120.73021, 'Hengchun Arpt', 8);
INSERT INTO public.airports VALUES (1348, 'Halls Creek', 'HCQ', 'AU', -18.233889, 127.66972, 'Halls Creek Arpt', 8);
INSERT INTO public.airports VALUES (1349, 'Heidelberg', 'HDB', 'DE', 49.393333, 8.6525, 'Heidelberg Arpt', 1);
INSERT INTO public.airports VALUES (1350, 'Hyderabad', 'HDD', 'PK', 25.3181, 68.3661, 'Hyderabad', 5);
INSERT INTO public.airports VALUES (1351, 'Heringsdorf', 'HDF', 'DE', 53.878708, 14.152347, 'Heringsdorf Arpt', 1);
INSERT INTO public.airports VALUES (1352, 'Hayden', 'HDN', 'US', 40.481182, -107.21766, 'Hayden Arpt', -7);
INSERT INTO public.airports VALUES (1353, 'Hoedspruit', 'HDS', 'ZA', -24.368643, 31.048744, 'Hoedspruit Arpt', 2);
INSERT INTO public.airports VALUES (1354, 'Hat Yai', 'HDY', 'TH', 6.933206, 100.392975, 'Hat Yai Arpt', 7);
INSERT INTO public.airports VALUES (1355, 'Herat', 'HEA', 'AF', 34.21002, 62.2283, 'Herat Arpt', 5);
INSERT INTO public.airports VALUES (1356, 'Heho', 'HEH', 'MM', 20.747036, 96.792046, 'Heho Arpt', 6);
INSERT INTO public.airports VALUES (1357, 'Heide Buesum', 'HEI', 'DE', 54.1533, 8.90167, 'Heide Arpt', 1);
INSERT INTO public.airports VALUES (1358, 'Helsinki', 'HEL', 'FI', 60.317223, 24.963333, 'Helsinki Arpt', 2);
INSERT INTO public.airports VALUES (1359, 'Heraklion', 'HER', 'GR', 35.339718, 25.180298, 'N Kazantzakis Arpt', 2);
INSERT INTO public.airports VALUES (1360, 'Hohhot', 'HET', 'CN', 40.85142, 111.824104, 'Hohhot Arpt', 8);
INSERT INTO public.airports VALUES (1361, 'Natchez', 'HEZ', 'US', 31.6133, -91.2967, 'Natchez Adams Cty', -100);
INSERT INTO public.airports VALUES (1362, 'Haifa', 'HFA', 'IL', 32.809444, 35.043056, 'Haifa Arpt', 2);
INSERT INTO public.airports VALUES (1363, 'Hartford', 'BDL', 'US', 41.93889, -72.68322, 'Bradley Intl Arpt', -5);
INSERT INTO public.airports VALUES (1364, 'Hartford', 'HFD', 'US', 41.73672, -72.649445, 'Brainard Arpt', -5);
INSERT INTO public.airports VALUES (1365, 'Hefei', 'HFE', 'CN', 31.78002, 117.29844, 'Hefei Arpt', 8);
INSERT INTO public.airports VALUES (1366, 'Hornafjordur', 'HFN', 'IS', 64.295555, -15.227222, 'Hornafjordur Arpt', 0);
INSERT INTO public.airports VALUES (1367, 'Hammerfest', 'HFT', 'NO', 70.679726, 23.668888, 'Hammerfest Arpt', 1);
INSERT INTO public.airports VALUES (1368, 'Hargeisa', 'HGA', 'SO', 9.518167, 44.088757, 'Hargeisa Arpt', 3);
INSERT INTO public.airports VALUES (1369, 'Hughenden', 'HGD', 'AU', -20.815, 144.225, 'Hughenden Arpt', 10);
INSERT INTO public.airports VALUES (1370, 'Hangzhou', 'HGH', 'CN', 30.229504, 120.434456, 'Hangzhou Arpt', 8);
INSERT INTO public.airports VALUES (1371, 'Helgoland', 'HGL', 'DE', 54.1853, 7.91583, 'Helgoland Arpt', 1);
INSERT INTO public.airports VALUES (1372, 'Mae Hongson', 'HGN', 'TH', 19.301666, 97.975, 'Mae Hong Son Arpt', 7);
INSERT INTO public.airports VALUES (1373, 'Hagerstown', 'HGR', 'US', 39.7079, -77.7295, 'Washington Cty Regional', -5);
INSERT INTO public.airports VALUES (1374, 'Mt Hagen', 'HGU', 'PG', -5.826789, 144.29587, 'Kagamuga Arpt', 10);
INSERT INTO public.airports VALUES (1375, 'Huanghua', 'HHA', 'CN', 28.189157, 113.219635, 'Changsha Huanghua Arpt', 8);
INSERT INTO public.airports VALUES (1376, 'Hachinohe', 'HHE', 'JP', 40.5522, 141.4672, 'Hachinohe Arpt', -100);
INSERT INTO public.airports VALUES (1377, 'Hilton Head', 'HHH', 'US', 32.216, -80.752, 'Hilton Head Municipal', -5);
INSERT INTO public.airports VALUES (1378, 'Hua Hin', 'HHQ', 'TH', 12.636225, 99.95153, 'Hua Hin Arpt', 7);
INSERT INTO public.airports VALUES (1379, 'Hawthorne', 'HHR', 'US', 33.92284, -118.33518, 'Hawthorne Arpt', -8);
INSERT INTO public.airports VALUES (1380, 'Hibbing', 'HIB', 'US', 47.3866, -92.839, 'Hibbing Chisolm Arpt', -6);
INSERT INTO public.airports VALUES (1381, 'Horn Island', 'HID', 'AU', -10.5864, 142.29, 'Horn Island Arpt', 10);
INSERT INTO public.airports VALUES (1382, 'Whitefield', 'HIE', 'US', 0, 0, 'Mt washington Regional Arpt', -100);
INSERT INTO public.airports VALUES (1383, 'Lake Havasu Cty', 'HII', 'US', 34.57111, -114.35828, 'Lake Havasu City Municipal Airport', -7);
INSERT INTO public.airports VALUES (1384, 'Hiroshima', 'HIJ', 'JP', 34.43611, 132.91945, 'Hiroshima Airport', 9);
INSERT INTO public.airports VALUES (1385, 'Chinju', 'HIN', 'KR', 35.088543, 128.07037, 'Sacheon Arpt', 9);
INSERT INTO public.airports VALUES (1386, 'Hillsboro', 'HIO', 'US', 45.540394, -122.94982, 'Portland Hillsboro Arpt', -8);
INSERT INTO public.airports VALUES (1387, 'Honiara', 'HIR', 'SB', -9.428, 160.0548, 'Henderson Intl Arpt', 11);
INSERT INTO public.airports VALUES (1388, 'Hayman Island', 'HIS', 'AU', -20.066668, 148.86667, 'Hayman Island Arpt', 10);
INSERT INTO public.airports VALUES (1389, 'Khajuraho', 'HJR', 'IN', 24.817198, 79.918594, 'Khajuraho Arpt', 5);
INSERT INTO public.airports VALUES (1390, 'Blytheville', 'HKA', 'US', 0, 0, 'Blytheville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1391, 'Healy Lake', 'HKB', 'US', 63.8675, -148.96889, 'Healy Lake Arpt', -9);
INSERT INTO public.airports VALUES (1392, 'Hakodate', 'HKD', 'JP', 41.77, 140.82195, 'Hakodate Arpt', 9);
INSERT INTO public.airports VALUES (1393, 'Hong Kong', 'HKG', 'HK', 22.30892, 113.914604, 'Hong Kong Intl', 8);
INSERT INTO public.airports VALUES (1394, 'Hokitika', 'HKK', 'NZ', -42.71361, 170.98528, 'Hokitika Airport', 12);
INSERT INTO public.airports VALUES (1395, 'Hoskins', 'HKN', 'PG', -5.46217, 150.405, 'Hoskins Arpt', 10);
INSERT INTO public.airports VALUES (1396, 'Phuket', 'HKT', 'TH', 8.1132, 98.31687, 'Phuket Intl Airport', 7);
INSERT INTO public.airports VALUES (1397, 'Hickory', 'HKY', 'US', 35.741146, -81.38955, 'Hickory Municipal', -5);
INSERT INTO public.airports VALUES (1398, 'Batesville', 'HLB', 'US', 0, 0, 'Hillenbrand', -100);
INSERT INTO public.airports VALUES (1399, 'Hailar', 'HLD', 'CN', 49.204998, 119.825, 'Hailer Arpt', 8);
INSERT INTO public.airports VALUES (1400, 'Hultsfred', 'HLF', 'SE', 57.525833, 15.823333, 'Hultsfred Arpt', 1);
INSERT INTO public.airports VALUES (1401, 'Holland', 'HLM', 'US', 0, 0, 'Park Township', -100);
INSERT INTO public.airports VALUES (1402, 'Helena', 'HLN', 'US', 46.606808, -111.98275, 'Helena Municipal', -7);
INSERT INTO public.airports VALUES (1403, 'St Helens', 'HLS', 'AU', 0, 0, 'St Helens Arpt', -100);
INSERT INTO public.airports VALUES (1404, 'Hluhluwe', 'HLW', 'ZA', 0, 0, 'Hluhluwe Arpt', -100);
INSERT INTO public.airports VALUES (1405, 'Holyhead', 'HLY', 'GB', 53.248096, -4.535339, 'Holyhead Rail Station', 0);
INSERT INTO public.airports VALUES (1406, 'Hamilton', 'HLZ', 'NZ', -37.86666, 175.33206, 'Hamilton Arpt', 12);
INSERT INTO public.airports VALUES (1407, 'Khanty Mansiysk', 'HMA', 'RU', 61.02848, 69.08607, 'Khanty Mansiysk Arpt', 6);
INSERT INTO public.airports VALUES (1408, 'Mubarak International Arpt', 'HMB', 'EG', 26.341188, 31.742983, 'Mubarak International Arpt', 2);
INSERT INTO public.airports VALUES (1409, 'Hassi Messaoud', 'HME', 'DZ', 31.672972, 6.140444, 'Oued Irara Arpt', 1);
INSERT INTO public.airports VALUES (1410, '(HMJ) Khmelnitskiy Airport, UA', 'HMJ', 'UA', 0, 0, '(HMJ) Khmelnitskiy Airport, UA', 0);
INSERT INTO public.airports VALUES (1411, 'Hermosillo', 'HMO', 'MX', 29.095858, -111.04786, 'Gen Ignacio Pesqueira Garcia Arpt', -7);
INSERT INTO public.airports VALUES (1412, 'Hamar', 'HMR', 'NO', 60.8181, 11.068, 'Hamar Arpt', 1);
INSERT INTO public.airports VALUES (1413, 'Hemavan', 'HMV', 'SE', 65.806114, 15.082778, 'Hemavan Flyg', 1);
INSERT INTO public.airports VALUES (1414, 'Morioka', 'HNA', 'JP', 39.42861, 141.13528, 'Hanamaki Arpt', 9);
INSERT INTO public.airports VALUES (1415, 'Huntingburg', 'HNB', 'US', 0, 0, 'Huntingburg Municipal', -100);
INSERT INTO public.airports VALUES (1416, 'Hoonah', 'HNH', 'US', 58.09611, -135.40973, 'Hoonah Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1417, 'Honolulu', 'HIK', 'US', 21.3187, -157.9224, 'Hickam Air Force Base', -100);
INSERT INTO public.airports VALUES (1418, 'Honolulu', 'HNL', 'US', 21.318682, -157.92242, 'Honolulu Intl', -10);
INSERT INTO public.airports VALUES (1419, 'Hana', 'HNM', 'US', 20.795635, -156.01443, 'Hana Municipal', -10);
INSERT INTO public.airports VALUES (1420, 'Haines', 'HNS', 'US', 59.2438, -135.524, 'Haines Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1421, 'Hengyang', 'HNY', 'CN', 0, 0, 'Hengyang Arpt', -100);
INSERT INTO public.airports VALUES (1422, 'Hobbs', 'HOB', 'US', 32.687527, -103.217026, 'Lea County Arpt', -7);
INSERT INTO public.airports VALUES (1423, 'Hodeidah', 'HOD', 'YE', 14.753, 42.976337, 'Hodeidah Arpt', 3);
INSERT INTO public.airports VALUES (1424, 'Hofuf', 'HOF', 'SA', 25.285307, 49.485188, 'Alahsa Arpt', 3);
INSERT INTO public.airports VALUES (1425, 'Holguin', 'HOG', 'CU', 20.78559, -76.31511, 'Frank Pias Arpt', -5);
INSERT INTO public.airports VALUES (1426, 'Hao Island', 'HOI', 'PF', -18.074814, -140.94589, 'Hao Island Arpt', -10);
INSERT INTO public.airports VALUES (1427, 'Homer', 'HOM', 'US', 59.645557, -151.47658, 'Homer Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1428, 'Huron', 'HON', 'US', 44.3852, -98.22854, 'Huron Municipal', -6);
INSERT INTO public.airports VALUES (1429, 'Hopkinsville', 'HOP', 'US', 36.668568, -87.496185, 'Hopkinsville Christian Country Arpt', -6);
INSERT INTO public.airports VALUES (1430, 'Hof De', 'HOQ', 'DE', 50.288837, 11.854919, 'Hof Pirk Arpt', 1);
INSERT INTO public.airports VALUES (1431, 'Horta', 'HOR', 'PT', 38.519894, -28.715872, 'Horta Arpt', -1);
INSERT INTO public.airports VALUES (1432, 'Hot Springs', 'HOT', 'US', 34.478, -93.0962, 'Memorial Field', -6);
INSERT INTO public.airports VALUES (1433, 'Houston', 'IAH', 'US', 29.984432, -95.34144, 'George Bush Intercontinental', -6);
INSERT INTO public.airports VALUES (1434, 'Houston', 'IWS', 'US', 29.818193, -95.67261, 'West Houston', -6);
INSERT INTO public.airports VALUES (1435, 'Houston', 'HOU', 'US', 29.645418, -95.27889, 'Houston Hobby Arpt', -6);
INSERT INTO public.airports VALUES (1436, 'Houston', 'DWH', 'US', 30.063745, -95.554276, 'David Wayne Hooks Arpt', -6);
INSERT INTO public.airports VALUES (1437, 'Houston', 'EFD', 'US', 29.607332, -95.15875, 'Ellington Field', -6);
INSERT INTO public.airports VALUES (1438, 'Orsta Volda', 'HOV', 'NO', 62.18, 6.0742, 'Hovden Arpt', 1);
INSERT INTO public.airports VALUES (1439, 'Ha Apai', 'HPA', 'TO', -19.777, -174.341, 'Salote Pilolevu Arpt', 13);
INSERT INTO public.airports VALUES (1440, 'Haiphong', 'HPH', 'VN', 20.819386, 106.72499, 'Catbi Arpt', 7);
INSERT INTO public.airports VALUES (1441, 'White Plains', 'HPN', 'US', 41.06696, -73.70757, 'Westchester County Arpt', -5);
INSERT INTO public.airports VALUES (1442, 'Princeville', 'HPV', 'US', 0, 0, 'Princeville Arpt', -100);
INSERT INTO public.airports VALUES (1443, 'Baytown', 'HPY', 'US', 0, 0, 'Baytown Arpt', -100);
INSERT INTO public.airports VALUES (1444, 'Harbin', 'HRB', 'CN', 45.6234, 126.25033, 'Harbin Arpt', 8);
INSERT INTO public.airports VALUES (1445, 'Harare', 'HRE', 'ZW', -17.931807, 31.092848, 'Harare Arpt', 2);
INSERT INTO public.airports VALUES (1446, 'Hurghada', 'HRG', 'EG', 27.178316, 33.799435, 'Hurghada Airport', 2);
INSERT INTO public.airports VALUES (1447, 'Kharkov', 'HRK', 'UA', 49.924786, 36.289986, 'Kharkov Arpt', 2);
INSERT INTO public.airports VALUES (1448, 'Harlingen', 'HRL', 'US', 26.2285, -97.65439, 'Rio Grande Valley Intl Arpt', -6);
INSERT INTO public.airports VALUES (1449, 'Harrison', 'HRO', 'US', 36.26152, -93.15473, 'Boone County Arpt', -6);
INSERT INTO public.airports VALUES (1450, 'Harrismith', 'HRS', 'ZA', 0, 0, 'Harrismith Arpt', -100);
INSERT INTO public.airports VALUES (1451, 'Harrogate', 'XTK', 'GB', 0, 0, 'Thirsk Rail Station', -100);
INSERT INTO public.airports VALUES (1452, 'Harrogate', 'HRT', 'GB', 30.427803, -86.68928, 'Linton On Ouse', -6);
INSERT INTO public.airports VALUES (1453, 'Horizontina', 'HRZ', 'BR', 0, 0, 'Horizontina Arpt', -100);
INSERT INTO public.airports VALUES (1454, 'Saga', 'HSG', 'JP', 33.1497, 130.302, 'Saga Arpt', 9);
INSERT INTO public.airports VALUES (1455, 'Hastings', 'HSI', 'US', 40.6053, -98.4278, 'Hastings Municipal', -100);
INSERT INTO public.airports VALUES (1456, 'Huslia', 'HSL', 'US', 65.69778, -156.3514, 'Huslia Arpt', -9);
INSERT INTO public.airports VALUES (1457, 'Zhoushan', 'HSN', 'CN', 29.9342, 122.362, 'Zhoushan Arpt', 8);
INSERT INTO public.airports VALUES (1458, 'Hot Springs', 'HSP', 'US', 0, 0, 'Ingalls Field', -100);
INSERT INTO public.airports VALUES (1459, 'Homestead', 'HST', 'US', 25.48855, -80.38357, 'Homestead Municipal', -5);
INSERT INTO public.airports VALUES (1460, 'Huntsville', 'HSV', 'US', 34.637196, -86.775055, 'Huntsville Intl Arpt', -6);
INSERT INTO public.airports VALUES (1461, 'Hsinchun', 'HSZ', 'TW', 24.8167, 120.9333, 'Hsinchun Arpt', -100);
INSERT INTO public.airports VALUES (1462, 'Chita', 'HTA', 'RU', 52.026318, 113.30556, 'Chita Arpt', 10);
INSERT INTO public.airports VALUES (1463, 'Hatfield', 'HTF', 'GB', 51.765, -0.24833, 'Hatfield Arpt', 0);
INSERT INTO public.airports VALUES (1464, 'Khatanga Airport', 'HTG', 'RU', 71.97806, 102.49052, 'Khatanga Airport', 8);
INSERT INTO public.airports VALUES (1465, 'Hamilton Island', 'HTI', 'AU', -20.3581, 148.952, 'Hamilton Island Arpt', 10);
INSERT INTO public.airports VALUES (1466, 'East Hampton', 'HTO', 'US', 0, 0, 'East Hampton Arpt', -100);
INSERT INTO public.airports VALUES (1467, 'Huntington', 'HTS', 'US', 38.3667, -82.558, 'Tri State Milton Arpt', -5);
INSERT INTO public.airports VALUES (1468, 'Huntington', 'PMH', 'US', 0, 0, 'Portsmith Regional', -100);
INSERT INTO public.airports VALUES (1469, 'Huntsville', 'HTV', 'US', 0, 0, 'Huntsville Arpt', -100);
INSERT INTO public.airports VALUES (1470, 'Hatay', 'HTY', 'TR', 36.362778, 36.282223, 'Hatay Airport', 2);
INSERT INTO public.airports VALUES (1471, 'Humacao', 'HUC', 'US', 0, 0, 'Humacao Arpt', -100);
INSERT INTO public.airports VALUES (1472, 'Terre Haute', 'HUF', 'US', 39.451466, -87.30756, 'Hulman Field', -5);
INSERT INTO public.airports VALUES (1473, 'Huahine', 'HUH', 'PF', -16.687243, -151.02167, 'Huahine Arpt', -10);
INSERT INTO public.airports VALUES (1474, 'Hu PG', 'HUI', 'VN', 16.401499, 107.702614, 'Phu Bai Arpt', 7);
INSERT INTO public.airports VALUES (1475, 'Houlton', 'HUL', 'US', 46.12308, -67.79205, 'Houlton International', -4);
INSERT INTO public.airports VALUES (1476, 'Houma', 'HUM', 'US', 0, 0, 'Terrebonne Arpt', -100);
INSERT INTO public.airports VALUES (1477, 'Hualien', 'HUN', 'TW', 24.023726, 121.616905, 'Hualien Arpt', 8);
INSERT INTO public.airports VALUES (1478, 'Hughes', 'HUS', 'US', 66.03917, -154.26472, 'Hughes Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1479, 'Hutchinson', 'HUT', 'US', 38.0655, -97.8606, 'Hutchinson Municipal', -6);
INSERT INTO public.airports VALUES (1480, 'Huanuco', 'HUU', 'PE', -9.878811, -76.204796, 'Huanuco Arpt', -5);
INSERT INTO public.airports VALUES (1481, 'Hudiksvall', 'HUV', 'SE', 61.768093, 17.080719, 'Hudiksvall Arpt', 1);
INSERT INTO public.airports VALUES (1482, 'Santa Cruz Huatulco', 'HUX', 'MX', 15.775317, -96.26257, 'Bahia De Huatulco Arpt', -6);
INSERT INTO public.airports VALUES (1483, 'Humberside', 'HUY', 'GB', 53.574444, -0.350833, 'Humberside Arpt', 0);
INSERT INTO public.airports VALUES (1484, 'Huizhou', 'HUZ', 'CN', 23.083332, 114.36667, 'Huizhou Arpt', 8);
INSERT INTO public.airports VALUES (1485, 'Hervey Bay', 'HVB', 'AU', -25.31889, 152.88028, 'Hervey Bay', 10);
INSERT INTO public.airports VALUES (1486, 'Hanksville', 'HVE', 'US', 0, 0, 'Intermediate Arpt', -100);
INSERT INTO public.airports VALUES (1487, 'Honningsvag', 'HVG', 'NO', 70.99, 25.83, 'Valan Arpt', 1);
INSERT INTO public.airports VALUES (1488, 'New Haven', 'HVN', 'US', 41.26375, -72.8868, 'Tweed New Haven Arpt', -5);
INSERT INTO public.airports VALUES (1489, 'Havre', 'HVR', 'US', 48.542984, -109.762344, 'City County', -7);
INSERT INTO public.airports VALUES (1490, 'Hayward', 'HWD', 'US', 37.6589, -122.1217, 'Hayward Air Terminal', -100);
INSERT INTO public.airports VALUES (1491, 'Hwange', 'HWN', 'ZW', -18.6339, 27.0081, 'Hwange Arpt', -100);
INSERT INTO public.airports VALUES (1492, 'Hyannis', 'HYA', 'US', 41.669334, -70.28036, 'Barnstable Cty Arpt', -5);
INSERT INTO public.airports VALUES (1493, 'Shamshabad', 'HYD', 'IN', 17.453117, 78.46758, 'Rajiv Gandhi Intl Arpt', 5);
INSERT INTO public.airports VALUES (1494, 'Huangyan', 'HYN', 'CN', 28.5622, 121.429, 'Huangyan Arpt', 8);
INSERT INTO public.airports VALUES (1495, 'Hayward', 'HYR', 'US', 0, 0, 'Hayward Municipal', -100);
INSERT INTO public.airports VALUES (1496, 'Hays', 'HYS', 'US', 38.8422, -99.2732, 'Hays Municipal', -5);
INSERT INTO public.airports VALUES (1497, 'Hazebrouck', 'HZB', 'FR', 50.6167, 2.64, 'Merville Calonne Arpt', -100);
INSERT INTO public.airports VALUES (1498, 'Hanzhong', 'HZG', 'CN', 33.0636, 107.008, 'Hanzhong Arpt', 8);
INSERT INTO public.airports VALUES (1499, 'Husavik', 'HZK', 'IS', 65.95233, -17.425978, 'Husavik Arpt', 0);
INSERT INTO public.airports VALUES (1500, 'Igarka Airport', 'IAA', 'RU', 67.4372, 86.6219, 'Igarka Airport', 8);
INSERT INTO public.airports VALUES (1501, 'Niagara Falls', 'IAG', 'US', 43.107334, -78.9462, 'Niagara Falls Intl Arpt', -5);
INSERT INTO public.airports VALUES (1502, 'Yaroslavl', 'IAR', 'RU', 57.560665, 40.157368, 'Yaroslavl Arpt', 4);
INSERT INTO public.airports VALUES (1503, 'Iasi', 'IAS', 'RO', 47.178493, 27.62063, 'Iasi Arpt', 2);
INSERT INTO public.airports VALUES (1504, 'Ibague', 'IBE', 'CO', 4.421608, -75.1333, 'Ibague Arpt', -5);
INSERT INTO public.airports VALUES (1505, 'Ibiza', 'IBZ', 'ES', 38.872856, 1.373117, 'Ibiza Airport', 1);
INSERT INTO public.airports VALUES (1506, 'Wichita', 'ICT', 'US', 37.649944, -97.43306, 'Mid Continent Arpt', -6);
INSERT INTO public.airports VALUES (1507, 'Idaho Falls', 'IDA', 'US', 43.514557, -112.07075, 'Fanning Field', -7);
INSERT INTO public.airports VALUES (1508, 'Indiana', 'IDI', 'US', 0, 0, 'Indiana County Arpt', -100);
INSERT INTO public.airports VALUES (1509, 'Indore', 'IDR', 'IN', 22.721786, 75.80109, 'Devi Ahilya Bai Holkar Arpt', 5);
INSERT INTO public.airports VALUES (1510, 'Zielona', 'IEG', 'PL', 52.138515, 15.798556, 'Babimost Arpt', 1);
INSERT INTO public.airports VALUES (1511, 'Kiev', 'IEV', 'UA', 50.401695, 30.449697, 'Zhulhany Arpt', 2);
INSERT INTO public.airports VALUES (1512, 'Kiev', 'KBP', 'UA', 50.345, 30.894722, 'Borispol Arpt', 2);
INSERT INTO public.airports VALUES (1513, 'Isafjordur', 'IFJ', 'IS', 66.05806, -23.135279, 'Isafjordur Arpt', 0);
INSERT INTO public.airports VALUES (1514, 'Isfahan', 'IFN', 'IR', 32.750835, 51.861267, 'Isfahan Arpt', 3);
INSERT INTO public.airports VALUES (1515, 'Ivano Frankovsk', 'IFO', 'UA', 48.884167, 24.686111, 'Ivano Frankovsk Arpt', 2);
INSERT INTO public.airports VALUES (1516, 'Bullhead City', 'IFP', 'US', 35.1574, -114.56, 'Laughlin Bullhead Intl Arpt', -7);
INSERT INTO public.airports VALUES (1517, 'Iğdır Havalimanı', 'IGD', 'TR', 0, 0, 'Iğdır Havalimanı', 3);
INSERT INTO public.airports VALUES (1518, 'Ingham', 'IGH', 'AU', -18.6656, 146.1475, 'Ingham Arpt', -100);
INSERT INTO public.airports VALUES (1519, 'Kingman', 'IGM', 'US', 35.2595, -113.938, 'Mohave County', -7);
INSERT INTO public.airports VALUES (1520, 'Iguazu', 'IGR', 'AR', -25.737282, -54.473446, 'Iguazu Intl', -3);
INSERT INTO public.airports VALUES (1521, 'Iguassu Falls', 'IGU', 'BR', -25.59615, -54.487206, 'Cataratas Arpt', -3);
INSERT INTO public.airports VALUES (1522, 'Izhevsk', 'IJK', 'RU', 56.8281, 53.4575, 'Izhevsk Arpt', 6);
INSERT INTO public.airports VALUES (1523, 'Jacksonville', 'IJX', 'US', 39.7744, -90.2386, 'Jacksonville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1524, 'Kankakee', 'IKK', 'US', 41.07139, -87.846275, 'Greater Kankakee Arpt', -6);
INSERT INTO public.airports VALUES (1525, 'Tiksi Airport', 'IKS', 'RU', 71.6977, 128.903, 'Tiksi Airport', 10);
INSERT INTO public.airports VALUES (1526, 'Irkutsk', 'IKT', 'RU', 52.26803, 104.38898, 'Irkutsk Airport', 9);
INSERT INTO public.airports VALUES (1527, 'Killeen', 'GRK', 'US', 31.06725, -97.82892, 'Gray AAF', -6);
INSERT INTO public.airports VALUES (1528, 'Killeen', 'ILE', 'US', 0, 0, 'Killeen Municipal', -100);
INSERT INTO public.airports VALUES (1529, 'Ilford', 'ILF', 'CA', 56.0614, -95.6139, 'Ilford Rail Station', -6);
INSERT INTO public.airports VALUES (1530, 'Wilmington', 'ILG', 'US', 39.678722, -75.60653, 'Greater Wilmington New Castle', -5);
INSERT INTO public.airports VALUES (1531, 'Wilmington', 'ILM', 'US', 34.270615, -77.90257, 'New Hanover Cty Arpt', -5);
INSERT INTO public.airports VALUES (1532, 'Iloilo', 'ILO', 'PH', 10.713044, 122.545296, 'Mandurriao Arpt', 8);
INSERT INTO public.airports VALUES (1533, 'Ile Des Pins', 'ILP', 'NC', -22.5889, 167.456, 'Ile Des Pins Arpt', 11);
INSERT INTO public.airports VALUES (1534, 'Islay', 'ILY', 'GB', 55.681946, -6.256667, 'Islay Arpt', 0);
INSERT INTO public.airports VALUES (1535, 'Zilina', 'ILZ', 'SK', 49.23153, 18.6135, 'Zilina Arpt', 1);
INSERT INTO public.airports VALUES (1536, 'Imphal', 'IMF', 'IN', 24.75995, 93.8967, 'Tulihal Arpt', 5);
INSERT INTO public.airports VALUES (1537, 'Imperatriz', 'IMP', 'BR', -5.531292, -47.46005, 'Imperatriz Arpt', -3);
INSERT INTO public.airports VALUES (1538, 'Iron Mountain', 'IMT', 'US', 45.81836, -88.114555, 'Ford Arpt', -5);
INSERT INTO public.airports VALUES (1539, 'Inta Airport', 'INA', 'RU', 0, 0, 'Inta Airport', -2);
INSERT INTO public.airports VALUES (1540, 'Yinchuan', 'INC', 'CN', 38.481945, 106.00917, 'Yinchuan Arpt', 8);
INSERT INTO public.airports VALUES (1541, 'Indianapolis', 'IND', 'US', 39.71733, -86.29438, 'Indianapolis Intl Arpt', -5);
INSERT INTO public.airports VALUES (1542, 'Nis Rs', 'INI', 'RS', 43.337288, 21.853722, 'Nis Arpt', 1);
INSERT INTO public.airports VALUES (1543, 'International Falls', 'INL', 'US', 48.566185, -93.40307, 'Intl Falls Arpt', -6);
INSERT INTO public.airports VALUES (1544, 'Innsbruck', 'INN', 'AT', 47.26022, 11.343964, 'Kranebitten Airport', 1);
INSERT INTO public.airports VALUES (1545, 'Winston-Salem', 'INT', 'US', 36.13372, -80.222, 'Smith Reynolds Arpt', -5);
INSERT INTO public.airports VALUES (1546, 'Nauru Island', 'INU', 'NR', -0.547458, 166.9191, 'Nauru Intl Arpt', 12);
INSERT INTO public.airports VALUES (1547, 'Inverness', 'ZIV', 'GB', 0, 0, 'Inverness ScotRail Station', -100);
INSERT INTO public.airports VALUES (1548, 'Inverness', 'INV', 'GB', 57.5425, -4.0475, 'Inverness Arpt', 0);
INSERT INTO public.airports VALUES (1549, 'Winslow', 'INW', 'US', 35.021915, -110.72253, 'Winslow Municipal', -7);
INSERT INTO public.airports VALUES (1550, 'Ioannina', 'IOA', 'GR', 39.69639, 20.8225, 'Ioannina Arpt', 2);
INSERT INTO public.airports VALUES (1551, 'Isle Of Man', 'IOM', 'GB', 54.083332, -4.623889, 'Ronaldsway Arpt', 0);
INSERT INTO public.airports VALUES (1552, 'Ilheus', 'IOS', 'BR', -14.815964, -39.033195, 'Eduardo Gomes Airport', -3);
INSERT INTO public.airports VALUES (1553, 'Iowa City', 'IOW', 'US', 0, 0, 'Iowa City Municipal Airport', -100);
INSERT INTO public.airports VALUES (1554, 'Easter Island', 'IPC', 'CL', -27.164791, -109.42183, 'Mataveri Intl Arpt', -6);
INSERT INTO public.airports VALUES (1555, 'Ipoh', 'IPH', 'MY', 4.567972, 101.09219, 'Ipoh Arpt', 8);
INSERT INTO public.airports VALUES (1556, 'Ipiales', 'IPI', 'CO', 0.861925, -77.67176, 'San Luis Arpt', -5);
INSERT INTO public.airports VALUES (1557, 'El Centro', 'IPL', 'US', 32.83422, -115.57874, 'Imperial County', -8);
INSERT INTO public.airports VALUES (1558, 'Ipatinga', 'IPN', 'BR', -19.470722, -42.487583, 'Usiminas Arpt', -3);
INSERT INTO public.airports VALUES (1559, 'Williamsport', 'IPT', 'US', 41.241837, -76.9211, 'Williamsport Lycoming Municipal', -5);
INSERT INTO public.airports VALUES (1560, 'Ipswich', 'IPW', 'GB', 0, 0, 'Ipswitch Rail Station', -100);
INSERT INTO public.airports VALUES (1561, 'Iquique', 'IQQ', 'CL', -20.535221, -70.181274, 'Cavancha Chucumata Arpt', -4);
INSERT INTO public.airports VALUES (1562, 'Iquitos', 'IQT', 'PE', -3.784739, -73.30881, 'C F Secada Arpt', -5);
INSERT INTO public.airports VALUES (1563, 'Lockhart', 'IRG', 'AU', -12.7869, 143.305, 'Lockhart River Arpt', 10);
INSERT INTO public.airports VALUES (1564, 'La Rioja', 'IRJ', 'AR', -29.381636, -66.79584, 'La Rioja Arpt', -3);
INSERT INTO public.airports VALUES (1565, 'Kirksville', 'IRK', 'US', 40.0935, -92.5449, 'Kirksville Municipal', -6);
INSERT INTO public.airports VALUES (1566, 'Sturgis', 'IRS', 'US', 0, 0, 'Kirsch Municipal', -100);
INSERT INTO public.airports VALUES (1567, 'Mount Isa', 'ISA', 'AU', -20.663889, 139.48862, 'Mount Isa Arpt', 10);
INSERT INTO public.airports VALUES (1568, 'Islamabad', 'ISB', 'PK', 33.616653, 73.099236, 'Islamabad Intl', 5);
INSERT INTO public.airports VALUES (1569, 'Isles Of Scilly', 'ISC', 'GB', 49.919, -6.3075, 'St Marys Arpt', 0);
INSERT INTO public.airports VALUES (1570, 'Isles Of Scilly', 'TSO', 'GB', 49.945557, -6.331389, 'Tresco Arpt', 0);
INSERT INTO public.airports VALUES (1571, 'Isparta', 'ISE', 'TR', 37.8554, 30.3684, 'Isparta Suleyman Demirel Airport', 2);
INSERT INTO public.airports VALUES (1572, 'Ishigaki', 'ISG', 'JP', 24.344524, 124.18698, 'Ishigaki Airport', 9);
INSERT INTO public.airports VALUES (1573, 'Ischia', 'ISH', 'IT', 0, 0, 'Ischia Arpt', -100);
INSERT INTO public.airports VALUES (1574, 'Isla Mujeres', 'ISJ', 'MX', 21.245033, -86.73997, 'Isla Mujeres Arpt', -6);
INSERT INTO public.airports VALUES (1575, 'Kissimmee', 'ISM', 'US', 28.289806, -81.43708, 'Kissimmee Municipal Arpt', -5);
INSERT INTO public.airports VALUES (1576, 'Williston', 'ISN', 'US', 48.17794, -103.64235, 'Sloulin Field Intl Arpt', -7);
INSERT INTO public.airports VALUES (1577, 'Kinston', 'ISO', 'US', 35.33139, -77.60889, 'East Reg Jetport Stallings', 7);
INSERT INTO public.airports VALUES (1578, 'Islip', 'ISP', 'US', 40.79525, -73.10022, 'Long Island Macarthur Arpt', -5);
INSERT INTO public.airports VALUES (1579, 'Manistique', 'ISQ', 'US', 0, 0, 'Schoolcraft County Arpt', -100);
INSERT INTO public.airports VALUES (1580, 'Wiscasset', 'ISS', 'US', 0, 0, 'Wiscasset Arpt', -100);
INSERT INTO public.airports VALUES (1581, 'Istanbul', 'IST', 'TR', 40.97692, 28.814606, 'Ataturk Arpt', 2);
INSERT INTO public.airports VALUES (1582, 'Istanbul', 'SAW', 'TR', 40.898552, 29.30922, 'Sabiha Gokcen Arpt', 2);
INSERT INTO public.airports VALUES (1583, 'Sulaimaniyah', 'ISU', 'IQ', 35.5608, 45.3147, 'Sulaimaniyah International Airport', 3);
INSERT INTO public.airports VALUES (1584, 'Wisconsin Rapids', 'ISW', 'US', 0, 0, 'Alexander Field', -100);
INSERT INTO public.airports VALUES (1585, 'Ithaca', 'ITH', 'US', 42.491028, -76.45844, 'Tomkins County', -5);
INSERT INTO public.airports VALUES (1586, 'Hilo', 'ITO', 'US', 19.721375, -155.04846, 'Hilo Hawaii Intl', -10);
INSERT INTO public.airports VALUES (1587, 'Itaperuna', 'ITP', 'BR', 0, 0, 'Itaperuna Arpt', -100);
INSERT INTO public.airports VALUES (1588, 'Niue Island', 'IUE', 'NU', -19.080029, -169.92564, 'Hanan Arpt', -11);
INSERT INTO public.airports VALUES (1589, 'Invercargill', 'IVC', 'NZ', -46.412407, 168.31299, 'Invercargill Arpt', 12);
INSERT INTO public.airports VALUES (1590, 'Ivalo', 'IVL', 'FI', 68.60727, 27.405329, 'Ivalo Arpt', 2);
INSERT INTO public.airports VALUES (1591, 'Inverell', 'IVR', 'AU', -29.8894, 151.1469, 'Inverell Arpt', -100);
INSERT INTO public.airports VALUES (1592, 'Ivanovo', 'IWA', 'RU', 56.939445, 40.940834, 'Ivanovo Arpt', 4);
INSERT INTO public.airports VALUES (1593, 'Ironwood', 'IWD', 'US', 46.527473, -90.13139, 'Ironwood Arpt', -6);
INSERT INTO public.airports VALUES (1594, 'Iwami', 'IWJ', 'JP', 34.6764, 131.79, 'Iwami Arpt', 9);
INSERT INTO public.airports VALUES (1595, 'Agartala', 'IXA', 'IN', 23.886978, 91.24045, 'Singerbhil Arpt', 5);
INSERT INTO public.airports VALUES (1596, 'Bagdogra', 'IXB', 'IN', 26.681206, 88.32857, 'Bagdogra Arpt', 5);
INSERT INTO public.airports VALUES (1597, 'Chandigarh', 'IXC', 'IN', 30.67347, 76.78854, 'Chandigarh Arpt', 5);
INSERT INTO public.airports VALUES (1598, 'Allahabad', 'IXD', 'IN', 25.440063, 81.73387, 'Bamrauli Arpt', 5);
INSERT INTO public.airports VALUES (1599, 'Mangalore', 'IXE', 'IN', 12.961267, 74.89007, 'Bajpe Arpt', 5);
INSERT INTO public.airports VALUES (1600, 'Belgaum', 'IXG', 'IN', 15.859286, 74.61829, 'Sambre Arpt', 5);
INSERT INTO public.airports VALUES (1601, 'Lilabari', 'IXI', 'IN', 27.295494, 94.09765, 'Lilabari Arpt', 5);
INSERT INTO public.airports VALUES (1602, 'Jammu', 'IXJ', 'IN', 32.68914, 74.83739, 'Satwari Arpt', 5);
INSERT INTO public.airports VALUES (1603, 'Leh IN', 'IXL', 'IN', 34.13587, 77.54652, 'Leh Kushok Bakula Rimpochee Arpt', 5);
INSERT INTO public.airports VALUES (1604, 'Madurai', 'IXM', 'IN', 9.834508, 78.093376, 'Madurai Airport', 5);
INSERT INTO public.airports VALUES (1605, 'Pathankot', 'IXP', 'IN', 32.23378, 75.63463, 'Pathankot Arpt', 5);
INSERT INTO public.airports VALUES (1606, 'Ranchi', 'IXR', 'IN', 23.31425, 85.32168, 'Birsa Munda Arpt', 5);
INSERT INTO public.airports VALUES (1607, 'Silchar', 'IXS', 'IN', 24.912928, 92.978745, 'Kumbhigram Arpt', 5);
INSERT INTO public.airports VALUES (1608, 'Aurangabad', 'IXU', 'IN', 19.862728, 75.39812, 'Chikkalthana Arpt', 5);
INSERT INTO public.airports VALUES (1609, 'Kandla', 'IXY', 'IN', 23.112719, 70.10029, 'Kandla Arpt', 5);
INSERT INTO public.airports VALUES (1610, 'Port Blair', 'IXZ', 'IN', 11.641161, 92.729744, 'Veer Savarkar Arpt', 5);
INSERT INTO public.airports VALUES (1611, 'Inyokern', 'IYK', 'US', 35.65889, -117.829445, 'Kern Cty Airport', -8);
INSERT INTO public.airports VALUES (1612, 'Izmir', 'ADB', 'TR', 38.292393, 27.156954, 'Adnan Menderes Airport', 2);
INSERT INTO public.airports VALUES (1613, 'Izumo', 'IZO', 'JP', 35.413612, 132.89, 'Izumo Arpt', 9);
INSERT INTO public.airports VALUES (1614, 'Ixtepec', 'IZT', 'MX', 0, 0, 'Ixtepec Arpt', -100);
INSERT INTO public.airports VALUES (1615, 'Jabiru', 'JAB', 'AU', -12.6571, 132.893, 'Jabiru Arpt', 9);
INSERT INTO public.airports VALUES (1616, 'Jackson', 'JAC', 'US', 43.607334, -110.73775, 'Jackson Hole Arpt', -7);
INSERT INTO public.airports VALUES (1617, 'Jaipur', 'JAI', 'IN', 26.824192, 75.812164, 'Sanganeer Arpt', 5);
INSERT INTO public.airports VALUES (1618, 'Jalapa', 'JAL', 'MX', 19.475082, -96.79751, 'Jalapa Arpt', -6);
INSERT INTO public.airports VALUES (1619, 'Jackson', 'HKS', 'US', 0, 0, 'Hawkins Field', -100);
INSERT INTO public.airports VALUES (1620, 'Jackson', 'JAN', 'US', 32.31117, -90.07589, 'Jackson Evers Intl Arpt', -6);
INSERT INTO public.airports VALUES (1621, 'Punta Renes', 'JAP', 'CR', 0, 0, 'Punta Renes Arpt', -100);
INSERT INTO public.airports VALUES (1622, 'Ilulissat', 'JAV', 'GL', 69.23444, -51.05111, 'Ilulissat Arpt', -3);
INSERT INTO public.airports VALUES (1623, 'Jacksonville', 'JAX', 'US', 30.494057, -81.68786, 'Jacksonville Intl Arpt', -5);
INSERT INTO public.airports VALUES (1624, 'Jacksonville', 'NIP', 'US', 30.235834, -81.68056, 'Jacksonville Nas', -5);
INSERT INTO public.airports VALUES (1625, 'Jacksonville', 'NZC', 'US', 30.2187, -81.8767, 'Cecil Field Nas', -5);
INSERT INTO public.airports VALUES (1626, 'Jacksonville', 'CRG', 'US', 0, 0, 'Craig Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1627, 'Higuero', 'JBQ', 'DO', 18.5725, -69.9856, 'Dr Joaquin Balaguer', -4);
INSERT INTO public.airports VALUES (1628, 'Jonesboro', 'JBR', 'US', 35.831707, -90.646416, 'Jonesboro Municipal', -6);
INSERT INTO public.airports VALUES (1629, 'Joacaba', 'JCB', 'BR', -27.172777, -51.50083, 'Joacaba Arpt', -3);
INSERT INTO public.airports VALUES (1630, 'Julia Creek', 'JCK', 'AU', -20.6683, 141.723, 'Julia Creek Arpt', 10);
INSERT INTO public.airports VALUES (1631, 'Juiz De Fora', 'JDF', 'BR', -21.7915, -43.38678, 'Francisco De Assis Arpt', -3);
INSERT INTO public.airports VALUES (1632, 'Jodhpur', 'JDH', 'IN', 26.251093, 73.04887, 'Jodhpur Arpt', 5);
INSERT INTO public.airports VALUES (1633, 'Juazeiro Do Norte', 'JDO', 'BR', -7.218958, -39.2701, 'Regional Do Cariri Arpt', -3);
INSERT INTO public.airports VALUES (1634, 'Jingdezhen', 'JDZ', 'CN', 29.3386, 117.176, 'Jingdezhen Arpt', 8);
INSERT INTO public.airports VALUES (1635, 'Jeddah', 'JED', 'SA', 21.679564, 39.156536, 'Jeddah Intl', 3);
INSERT INTO public.airports VALUES (1636, 'Jefferson City', 'JEF', 'US', 38.5912, -92.1561, 'Jefferson City Memorial', -6);
INSERT INTO public.airports VALUES (1637, 'Aasiaat', 'JEG', 'GL', 68.7, -52.75, 'Aasiaat Arpt', -3);
INSERT INTO public.airports VALUES (1638, 'Jersey', 'JER', 'GB', 49.207947, -2.195508, 'States Airport', 0);
INSERT INTO public.airports VALUES (1639, 'Jamnagar', 'JGA', 'IN', 22.465523, 70.01256, 'Govardhanpur Arpt', 5);
INSERT INTO public.airports VALUES (1640, 'Jiayuguan', 'JGN', 'CN', 39.8569, 98.3414, 'Jiayuguan Arpt', 8);
INSERT INTO public.airports VALUES (1641, 'Jian', 'JGS', 'CN', 26.8997, 114.7375, 'Jing Gang Shan Arpt', 8);
INSERT INTO public.airports VALUES (1642, 'Johor Bahru', 'JHB', 'MY', 1.641308, 103.66962, 'Sultan Ismail Intl Arpt', 8);
INSERT INTO public.airports VALUES (1643, 'Helsingborg', 'XWP', 'SE', 0, 0, 'Hassleholm Rail Station', -100);
INSERT INTO public.airports VALUES (1644, 'Helsingborg', 'XYH', 'SE', 0, 0, 'Helsingborg Railway service', -100);
INSERT INTO public.airports VALUES (1645, 'Jinghong', 'JHG', 'CN', 21.973913, 100.75961, 'Jinghong Arpt', 8);
INSERT INTO public.airports VALUES (1646, 'Kapalua', 'JHM', 'US', 20.962936, -156.67303, 'Kapalua Arpt', -10);
INSERT INTO public.airports VALUES (1647, 'Sisimiut', 'JHS', 'GL', 66.9513, -53.7293, 'Sisimiut Arpt', -3);
INSERT INTO public.airports VALUES (1648, 'Jamestown', 'JHW', 'US', 42.15333, -79.25806, 'Chautauqua Cty Arpt', -5);
INSERT INTO public.airports VALUES (1649, 'Djibouti', 'JIB', 'DJ', 11.5472, 43.1594, 'Ambouli Airport', 3);
INSERT INTO public.airports VALUES (1650, 'Ikaria Island', 'JIK', 'GR', 37.682716, 26.347061, 'Ikaria Arpt', 2);
INSERT INTO public.airports VALUES (1651, 'Jilin', 'JIL', 'CN', 0, 0, 'Jilin Arpt', -100);
INSERT INTO public.airports VALUES (1652, 'Jimma', 'JIM', 'ET', 7.666094, 36.81664, 'Jimma Arpt', 3);
INSERT INTO public.airports VALUES (1653, 'Jiujiang', 'JIU', 'CN', 29.733, 115.983, 'Jiujiang Airport', 8);
INSERT INTO public.airports VALUES (1654, 'Jinjiang', 'JJN', 'CN', 24.7964, 118.59, 'Jinjiang Arpt', 8);
INSERT INTO public.airports VALUES (1655, 'Qaqortoq', 'JJU', 'GL', 60.7158, -46.0294, 'Qaqortoq Arpt', -3);
INSERT INTO public.airports VALUES (1656, 'Jonkoping', 'XYC', 'SE', 0, 0, 'Herrljunga Rail Station', -100);
INSERT INTO public.airports VALUES (1657, 'Jonkoping', 'XYF', 'SE', 0, 0, 'Falkoping Rail Station', -100);
INSERT INTO public.airports VALUES (1658, 'Jonkoping', 'JKG', 'SE', 57.757595, 14.068731, 'Axamo Airport', 1);
INSERT INTO public.airports VALUES (1659, 'Chios', 'JKH', 'GR', 38.343174, 26.140572, 'Chios Arpt', 2);
INSERT INTO public.airports VALUES (1660, 'Kalymnos Island', 'JKL', 'GR', 36.963333, 26.940556, 'Kalymnos Arpt', 2);
INSERT INTO public.airports VALUES (1661, 'Jakarta', 'HLP', 'ID', -6.26661, 106.891, 'Halim Perdana Kusuma Arpt', 7);
INSERT INTO public.airports VALUES (1662, 'Jakarta', 'CGK', 'ID', -6.125567, 106.6559, 'Soekarno Hatta Intl', 7);
INSERT INTO public.airports VALUES (1663, 'Jacksonville', 'JKV', 'US', 0, 0, 'Cherokee County Arpt', -100);
INSERT INTO public.airports VALUES (1664, 'Joplin', 'JLN', 'US', 37.151814, -94.49827, 'Joplin Municipal Arpt', -6);
INSERT INTO public.airports VALUES (1665, 'Sausalito', 'JMC', 'US', 0, 0, 'Marin County Arpt', -100);
INSERT INTO public.airports VALUES (1666, 'Mykonos', 'JMK', 'GR', 37.435127, 25.348103, 'Mykonos Greece Arpt', 2);
INSERT INTO public.airports VALUES (1667, 'Jamestown', 'JMS', 'US', 46.9297, -98.6782, 'Jamestown Arpt', -6);
INSERT INTO public.airports VALUES (1668, 'Johannesburg', 'HLA', 'ZA', -25.938515, 27.926132, 'Lanseria International Arpt', 2);
INSERT INTO public.airports VALUES (1669, 'Johannesburg', 'QRA', 'ZA', -26.242506, 28.151169, 'Randgermiston Arpt', 2);
INSERT INTO public.airports VALUES (1670, 'Johannesburg', 'GCJ', 'ZA', -25.986267, 28.14006, 'Grand Central Arpt', 2);
INSERT INTO public.airports VALUES (1671, 'Johannesburg', 'JNB', 'ZA', -26.139166, 28.246, 'O R Tambo International Arpt', 2);
INSERT INTO public.airports VALUES (1672, 'Nanortalik', 'JNN', 'GL', 60.14, -45.2317, 'Nanortalik Arpt', -3);
INSERT INTO public.airports VALUES (1673, 'Narsaq', 'JNS', 'GL', 60.9167, -46.0586, 'Narsaq Heleport', -3);
INSERT INTO public.airports VALUES (1674, 'Juneau', 'JNU', 'US', 58.354973, -134.57628, 'Juneau Arpt', -9);
INSERT INTO public.airports VALUES (1675, 'Joensuu', 'JOE', 'FI', 62.662907, 29.60755, 'Joensuu Arpt', 2);
INSERT INTO public.airports VALUES (1676, 'Yogyakarta', 'JOG', 'ID', -7.788181, 110.431755, 'Adisutjipto Arpt', 7);
INSERT INTO public.airports VALUES (1677, 'Joinville', 'JOI', 'BR', -26.224453, -48.797363, 'Cubatao Arpt', -3);
INSERT INTO public.airports VALUES (1678, 'Yoshkar-Ola Airport', 'JOK', 'RU', 56.7006, 47.9047, 'Yoshkar-Ola Airport', 4);
INSERT INTO public.airports VALUES (1679, 'Joliet', 'JOT', 'US', 41.5178, -88.1756, 'Joliet Park District Arpt', -100);
INSERT INTO public.airports VALUES (1680, 'Joao Pessoa', 'JPA', 'BR', -7.148381, -34.95068, 'Castro Pinto Arpt', -3);
INSERT INTO public.airports VALUES (1681, 'Ji Parana', 'JPR', 'BR', -10.8708, -61.8465, 'Ji Parana Arpt', -4);
INSERT INTO public.airports VALUES (1682, 'Qaarsut', 'JQA', 'GL', 70.7342, -52.6962, 'Qaarsut Arpt', -3);
INSERT INTO public.airports VALUES (1683, 'Jorhat', 'JRH', 'IN', 26.731527, 94.17554, 'Rowriah Arpt', 5);
INSERT INTO public.airports VALUES (1684, 'Kilimanjaro', 'JRO', 'TZ', -3.429406, 37.074463, 'Kilimanjaro Arpt', 3);
INSERT INTO public.airports VALUES (1685, 'Jerusalem', 'JRS', 'IL', 31.8647, 35.2192, 'Atarot Airport', -100);
INSERT INTO public.airports VALUES (1686, 'Jaisalmer', 'JSA', 'IN', 26.888653, 70.86497, 'Jaisalmer Arpt', 5);
INSERT INTO public.airports VALUES (1687, 'Skiathos', 'JSI', 'GR', 39.1771, 23.503675, 'Skiathos Arpt', 2);
INSERT INTO public.airports VALUES (1688, 'Sodertalje', 'XEZ', 'SE', 0, 0, 'Sodertalje S Rail Station', -100);
INSERT INTO public.airports VALUES (1689, 'Johnstown', 'JST', 'US', 40.316113, -78.833885, 'Johnstown Cambria Arpt', -5);
INSERT INTO public.airports VALUES (1690, 'Maniitsoq', 'JSU', 'GL', 65.4125, -52.9394, 'Maniitsoq Heleport', -3);
INSERT INTO public.airports VALUES (1691, 'Syros Island', 'JSY', 'GR', 37.42279, 24.950935, 'Syros Island Arpt', 2);
INSERT INTO public.airports VALUES (1692, 'Thira Island', 'JTR', 'GR', 36.39917, 25.479334, 'Santorini Arpt', 2);
INSERT INTO public.airports VALUES (1693, 'Astypalaia Island', 'JTY', 'GR', 36.579887, 26.375822, 'Astypalaia Arpt', 2);
INSERT INTO public.airports VALUES (1694, 'Juba', 'JUB', 'SD', 4.872006, 31.601116, 'Juba Arpt', 2);
INSERT INTO public.airports VALUES (1695, 'Juist', 'JUI', 'DE', 53.681572, 7.055731, 'Juist Arpt', 1);
INSERT INTO public.airports VALUES (1696, 'Jujuy', 'JUJ', 'AR', -24.392778, -65.09778, 'El Cadillal Airport', -3);
INSERT INTO public.airports VALUES (1697, 'Juliaca', 'JUL', 'PE', -15.467103, -70.15817, 'Juliaca Arpt', -5);
INSERT INTO public.airports VALUES (1698, 'Jurado', 'JUO', 'CO', 0, 0, 'Jurado Arpt', -100);
INSERT INTO public.airports VALUES (1699, 'Juzhou', 'JUZ', 'CN', 28.9658, 118.899, 'Juzhou Arpt', 8);
INSERT INTO public.airports VALUES (1700, 'Beloit', 'JVL', 'US', 42.62025, -89.04156, 'Rock County Arpt', -6);
INSERT INTO public.airports VALUES (1701, 'Zanjan', 'JWN', 'IR', 36.7747, 48.3592, 'Zanjan Arpt', -100);
INSERT INTO public.airports VALUES (1702, 'Jackson', 'JXN', 'US', 42.2598, -84.4594, 'Jackson Reynolds Municipal', -100);
INSERT INTO public.airports VALUES (1703, 'Jyvaskyla', 'JYV', 'FI', 62.399452, 25.678253, 'Jyvaskyla Arpt', 2);
INSERT INTO public.airports VALUES (1704, 'Songpan', 'JZH', 'CN', 32.857, 103.683, 'Jiu Zhai Huang Long Arpt', 8);
INSERT INTO public.airports VALUES (1705, 'Kariba Dam', 'KAB', 'ZW', -16.51976, 28.884981, 'Kariba Arpt', 2);
INSERT INTO public.airports VALUES (1706, 'Kake', 'KAE', 'US', 56.973057, -133.94556, 'Kake Arpt', -9);
INSERT INTO public.airports VALUES (1707, 'Kajaani', 'KAJ', 'FI', 64.28547, 27.692413, 'Kajaani Airport', 2);
INSERT INTO public.airports VALUES (1708, 'Kano', 'KAN', 'NG', 12.047589, 8.524622, 'Aminu Kano Intl Arpt', 1);
INSERT INTO public.airports VALUES (1709, 'Kuusamo', 'KAO', 'FI', 65.98757, 29.239382, 'Kuusamo', 2);
INSERT INTO public.airports VALUES (1710, 'Kaitaia', 'KAT', 'NZ', -35.07, 173.28528, 'Kaitaia Arpt', 12);
INSERT INTO public.airports VALUES (1711, 'Kings Canyon', 'KBJ', 'AU', 0, 0, 'Kings Canyon Arpt', -100);
INSERT INTO public.airports VALUES (1712, 'Kabul', 'KBL', 'AF', 34.565853, 69.212326, 'Khwaja Rawash Arpt', 5);
INSERT INTO public.airports VALUES (1713, 'Kota Bharu', 'KBR', 'MY', 6.16685, 102.293015, 'Pengkalan Chepa', 8);
INSERT INTO public.airports VALUES (1714, 'Krabi', 'KBV', 'TH', 8.095969, 98.98876, 'Krabi Arpt', 7);
INSERT INTO public.airports VALUES (1715, 'Kaikoura', 'KBZ', 'NZ', -42.416668, 173.68333, 'Kaikoura Arpt', 12);
INSERT INTO public.airports VALUES (1716, 'Collinsville', 'KCE', 'AU', 0, 0, 'Collinsville Arpt', -100);
INSERT INTO public.airports VALUES (1717, 'Kuching', 'KCH', 'MY', 1.484697, 110.34693, 'Kuching Airport', 8);
INSERT INTO public.airports VALUES (1718, 'Kansas City', 'OJC', 'US', 0, 0, 'Johnson Executive Arpt', -100);
INSERT INTO public.airports VALUES (1719, 'Kansas City', 'KCK', 'US', 0, 0, 'Fairfax Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1720, 'Kahramanmaras', 'KCM', 'TR', 37.539, 36.9534, 'Kahramanmaras aRPT', 2);
INSERT INTO public.airports VALUES (1721, 'Kocaeli', 'KCO', 'TR', 0, 0, 'Kocaeli', 2);
INSERT INTO public.airports VALUES (1722, 'Kamenets Podolski', 'KCP', 'UA', 0, 0, 'Kamenets Podolski Arpt', -100);
INSERT INTO public.airports VALUES (1723, 'Kochi', 'KCZ', 'JP', 33.546112, 133.66945, 'Kochi Airport', 9);
INSERT INTO public.airports VALUES (1724, 'Kandahar Airport', 'KDH', 'AF', 31.505756, 65.847824, 'Kandahar Airport', 5);
INSERT INTO public.airports VALUES (1725, 'Kemerovo', 'KEJ', 'RU', 55.270096, 86.10721, 'Kemerovo Arpt', 8);
INSERT INTO public.airports VALUES (1726, 'Kiel', 'KEL', 'DE', 54.3795, 10.145167, 'Holtenau Arpt', 1);
INSERT INTO public.airports VALUES (1727, 'Kemi', 'KEM', 'FI', 65.78189, 24.5991, 'Kemi Tornio Arpt', 2);
INSERT INTO public.airports VALUES (1728, 'Kerman', 'KER', 'IR', 30.274445, 56.95111, 'Kerman Arpt', 4);
INSERT INTO public.airports VALUES (1729, 'Kastamonu', 'KFS', 'TR', 41.305557, 33.79111, 'Kastamonu Arpt', 3);
INSERT INTO public.airports VALUES (1730, 'Kingscote', 'KGC', 'AU', -35.71389, 137.5214, 'Kingscote Arpt', 9);
INSERT INTO public.airports VALUES (1731, 'Kaliningrad', 'KGD', 'RU', 54.89005, 20.592632, 'Kaliningrad Arpt', 3);
INSERT INTO public.airports VALUES (1732, 'Karaganda', 'KGF', 'KZ', 49.670834, 73.33444, 'Karaganda Arpt', 5);
INSERT INTO public.airports VALUES (1733, 'Kalgoorlie', 'KGI', 'AU', -30.789444, 121.46167, 'Kalgoorlie Arpt', 8);
INSERT INTO public.airports VALUES (1734, 'Kigali', 'KGL', 'RW', -1.968628, 30.13945, 'Kigali Intl Arpt', 2);
INSERT INTO public.airports VALUES (1735, 'Kogalym Airport', 'KGP', 'RU', 62.18, 74.53, 'Kogalym Airport', 6);
INSERT INTO public.airports VALUES (1736, 'Kos Gr', 'KGS', 'GR', 36.793335, 27.091667, 'Kos Arpt', 2);
INSERT INTO public.airports VALUES (1737, 'Khorramabad', 'KHD', 'IR', 33.43538, 48.28289, 'Khorramabad Arpt', 3);
INSERT INTO public.airports VALUES (1738, 'Kashi', 'KHG', 'CN', 39.542923, 76.01996, 'Kashi Arpt', 8);
INSERT INTO public.airports VALUES (1739, 'Kaohsiung', 'KHH', 'TW', 22.577093, 120.350006, 'Kaohsiung Intl', 8);
INSERT INTO public.airports VALUES (1740, 'Karachi', 'KHI', 'PK', 24.906548, 67.1608, 'Quaid E Azam International', 5);
INSERT INTO public.airports VALUES (1741, 'Nanchang', 'KHN', 'CN', 28.865, 115.9, 'Nanchang Arpt', 8);
INSERT INTO public.airports VALUES (1742, 'Khabarovsk', 'KHV', 'RU', 48.528046, 135.18835, 'Novyy Arpt', 11);
INSERT INTO public.airports VALUES (1743, 'King City', 'KIC', 'US', 0, 0, 'Mesa Del Rey Arpt', -100);
INSERT INTO public.airports VALUES (1744, 'Kristianstad', 'XYU', 'SE', 0, 0, 'Solvesborg Rail Station', -100);
INSERT INTO public.airports VALUES (1745, 'Kristianstad', 'KID', 'SE', 55.921684, 14.085536, 'Kristianstad Arpt', 1);
INSERT INTO public.airports VALUES (1746, 'Kish Island', 'KIH', 'IR', 26.526155, 53.98021, 'Kish Island Arpt', 4);
INSERT INTO public.airports VALUES (1747, 'Niigata', 'KIJ', 'JP', 37.5711, 139.0646, 'Niigata Arpt', 9);
INSERT INTO public.airports VALUES (1748, 'Kimberley', 'KIM', 'ZA', -28.802834, 24.765167, 'Kimberley Arpt', 2);
INSERT INTO public.airports VALUES (1749, 'Kingston', 'KIN', 'JM', 17.935667, -76.7875, 'Norman Manly Arpt', -5);
INSERT INTO public.airports VALUES (1750, 'Kingston', 'KTP', 'JM', 17.988558, -76.82376, 'Tinson Arpt', -5);
INSERT INTO public.airports VALUES (1751, 'Kerry County', 'KIR', 'IE', 52.180878, -9.523783, 'Kerry County Arpt', 0);
INSERT INTO public.airports VALUES (1752, 'Kisumu', 'KIS', 'KE', -0.086139, 34.728893, 'Kisumu Arpt', 3);
INSERT INTO public.airports VALUES (1753, 'Kithira', 'KIT', 'GR', 36.274258, 23.016977, 'Kithira Arpt', 2);
INSERT INTO public.airports VALUES (1754, 'Chisinau', 'KIV', 'MD', 46.927746, 28.930979, 'Chisinau Arpt', 2);
INSERT INTO public.airports VALUES (1755, 'Krasnoyarsk', 'KJA', 'RU', 56.18, 92.475, 'Krasnojarsk Arpt', 8);
INSERT INTO public.airports VALUES (1756, 'Kortrijk', 'KJK', 'BE', 50.8172, 3.2047, 'Kortrijk Arpt', -100);
INSERT INTO public.airports VALUES (1757, 'Khon Kaen', 'KKC', 'TH', 16.466627, 102.78366, 'Khon Kaen Arpt', 7);
INSERT INTO public.airports VALUES (1758, 'Kerikeri', 'KKE', 'NZ', -35.26278, 173.91194, 'Kerikeri Arpt', 12);
INSERT INTO public.airports VALUES (1759, 'Kita Kyushu', 'KKJ', 'JP', 33.845943, 131.03468, 'Kokura Arpt', 9);
INSERT INTO public.airports VALUES (1760, 'Kirkenes', 'KKN', 'NO', 69.725784, 29.891294, 'Hoeybuktmoen Arpt', 1);
INSERT INTO public.airports VALUES (1761, 'Kentland', 'KKT', 'US', 0, 0, 'Kentland Arpt', -100);
INSERT INTO public.airports VALUES (1762, 'Tver', 'KLD', 'RU', 56.824738, 35.75768, 'Migalovo Arpt', 4);
INSERT INTO public.airports VALUES (1763, 'Kaluga Grabtsevo AirportINA', 'KLF', 'RU', 0, 0, 'Kaluga Grabtsevo AirportINA', -2);
INSERT INTO public.airports VALUES (1764, 'Kalskag', 'KLG', 'US', 61.5363, -160.341, 'Kalskag Municipal Arpt', -9);
INSERT INTO public.airports VALUES (1765, 'Kolhapur', 'KLH', 'IN', 16.664658, 74.28935, 'Kolhapur Arpt', 5);
INSERT INTO public.airports VALUES (1766, 'Klaipeda', 'KLJ', 'LT', 0, 0, 'Klaipeda Arpt', -100);
INSERT INTO public.airports VALUES (1767, 'Kalibo', 'KLO', 'PH', 11.679431, 122.3763, 'Kalibo Arpt', 8);
INSERT INTO public.airports VALUES (1768, 'Kalmar', 'KLR', 'SE', 56.68553, 16.287579, 'Kalmar Arpt', 1);
INSERT INTO public.airports VALUES (1769, 'Kelso', 'KLS', 'US', 46.118, -122.89839, 'Kelso Longview Regional Arpt', -8);
INSERT INTO public.airports VALUES (1770, 'Kaiserslautern', 'KLT', 'DE', 0, 0, 'Kaiserslautern Rail Station', -100);
INSERT INTO public.airports VALUES (1771, 'Klagenfurt', 'KLU', 'AT', 46.642513, 14.337739, 'Klagenfurt Arpt', 1);
INSERT INTO public.airports VALUES (1772, 'Karlovy Vary', 'KLV', 'CZ', 50.202976, 12.914983, 'Karlovy Vary Arpt', 1);
INSERT INTO public.airports VALUES (1773, 'Klawock', 'KLW', 'US', 55.579166, -133.07611, 'Klawock Arpt', -9);
INSERT INTO public.airports VALUES (1774, 'Kalamata', 'KLX', 'GR', 37.068317, 22.025524, 'Kalamata Airport', 2);
INSERT INTO public.airports VALUES (1775, 'Kunming', 'KMG', 'CN', 24.992365, 102.74354, 'Kunming Airport', 8);
INSERT INTO public.airports VALUES (1776, 'Kuruman', 'KMH', 'ZA', 0, 0, 'Kuruman Arpt', -100);
INSERT INTO public.airports VALUES (1777, 'Miyazaki', 'KMI', 'JP', 31.877222, 131.44861, 'Miyazaki Arpt', 9);
INSERT INTO public.airports VALUES (1778, 'Kumamoto', 'KMJ', 'JP', 32.83732, 130.85506, 'Kumamoto Airport', 9);
INSERT INTO public.airports VALUES (1779, 'Komatsu', 'KMQ', 'JP', 36.39461, 136.40654, 'Komatsu Airport', 9);
INSERT INTO public.airports VALUES (1780, 'Kumasi', 'KMS', 'GH', 6.714564, -1.590818, 'Sunyani', 0);
INSERT INTO public.airports VALUES (1781, 'Kostroma', 'KMW', 'RU', 57.7961, 41.0204, 'Kostroma Arpt', 4);
INSERT INTO public.airports VALUES (1782, 'Khamis Mushait', 'KMX', 'SA', 18.3011, 42.8009, 'Khamis Mushait Arpt', -100);
INSERT INTO public.airports VALUES (1783, 'Vina Del Mar', 'KNA', 'CL', -32.9497, -71.4786, 'Vina Del Mar Arpt', -100);
INSERT INTO public.airports VALUES (1784, 'Kings Lynn', 'KNF', 'GB', 52.648354, 0.550692, 'Marham Raf', 0);
INSERT INTO public.airports VALUES (1785, 'Kinmen', 'KNH', 'TW', 24.427893, 118.3592, 'Shang Yi Arpt', 8);
INSERT INTO public.airports VALUES (1786, 'King Island', 'KNS', 'AU', -39.8775, 143.878, 'King Island Arpt', 10);
INSERT INTO public.airports VALUES (1787, 'Kennett', 'KNT', 'US', 0, 0, 'Kennett Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1788, 'Kanpur', 'KNU', 'IN', 26.441444, 80.36486, 'Chakeri Arpt', 5);
INSERT INTO public.airports VALUES (1789, 'Kununurra', 'KNX', 'AU', -15.778056, 128.7075, 'Kununurra Airport', 8);
INSERT INTO public.airports VALUES (1790, 'Kona', 'KOA', 'US', 19.738768, -156.04562, 'Keahole Arpt', -10);
INSERT INTO public.airports VALUES (1791, 'Koutaba', 'KOB', 'CM', 0, 0, 'Koutaba Arpt', -100);
INSERT INTO public.airports VALUES (1792, 'Koumac', 'KOC', 'NC', -20.546314, 164.25563, 'Koumac Arpt', 11);
INSERT INTO public.airports VALUES (1793, 'Kirkwall', 'KOI', 'GB', 58.95778, -2.905, 'Kirkwall Arpt', 0);
INSERT INTO public.airports VALUES (1794, 'Kagoshima', 'KOJ', 'JP', 31.803396, 130.7194, 'Kagoshima Arpt', 9);
INSERT INTO public.airports VALUES (1795, 'Kokkola', 'KOK', 'FI', 63.721172, 23.143131, 'Kokkola Arpt', 2);
INSERT INTO public.airports VALUES (1796, 'Nakhon Phanom', 'KOP', 'TH', 17.383795, 104.64302, 'Nakhon Phanom Arpt', 7);
INSERT INTO public.airports VALUES (1797, 'Kokoro', 'KOR', 'PG', 0, 0, 'Kokoro Arpt', -100);
INSERT INTO public.airports VALUES (1798, 'Sihanoukville', 'KOS', 'KH', 10.579686, 103.636826, 'Sihanoukville Arpt', 7);
INSERT INTO public.airports VALUES (1799, 'KOKSHETAU', 'KOV', 'KZ', 53.3291, 69.5946, 'KOKSHETAU', 6);
INSERT INTO public.airports VALUES (1800, 'Ganzhou', 'KOW', 'CN', 25.8258, 114.912, 'Ganzhou Arpt', 8);
INSERT INTO public.airports VALUES (1801, 'King Of Prussia', 'KPD', 'US', 0, 0, 'King Of Prussia Arpt', -100);
INSERT INTO public.airports VALUES (1802, 'Pohang', 'KPO', 'KR', 35.987858, 129.42049, 'Pohang Arpt', 9);
INSERT INTO public.airports VALUES (1803, 'Kempsey', 'KPS', 'AU', -31.06, 152.7897, 'Kempsey Arpt', -100);
INSERT INTO public.airports VALUES (1804, 'Karumba', 'KRB', 'AU', -17.4567, 140.83, 'Karumba Arpt', 10);
INSERT INTO public.airports VALUES (1805, 'Kramfors', 'KRF', 'SE', 63.048595, 17.768856, 'Kramfors Arpt', 1);
INSERT INTO public.airports VALUES (1806, 'Krakow', 'KRK', 'PL', 50.077732, 19.784836, 'John Paul Ii International', 1);
INSERT INTO public.airports VALUES (1807, 'Korla', 'KRL', 'CN', 41.6978, 86.1289, 'Korla Arpt', 8);
INSERT INTO public.airports VALUES (1808, 'Kiruna', 'KRN', 'SE', 67.82198, 20.336763, 'Kiruna Airport', 1);
INSERT INTO public.airports VALUES (1809, 'Kurgan Airport', 'KRO', 'RU', 55.4753, 65.4156, 'Kurgan Airport', 6);
INSERT INTO public.airports VALUES (1810, 'Karup', 'KRP', 'DK', 56.29746, 9.124628, 'Karup Arpt', 1);
INSERT INTO public.airports VALUES (1811, 'Krasnodar', 'KRR', 'RU', 45.03469, 39.17054, 'Krasnodar Arpt', 4);
INSERT INTO public.airports VALUES (1812, 'Kristiansand', 'XGD', 'NO', 0, 0, 'Arendal Rail Station', -100);
INSERT INTO public.airports VALUES (1813, 'Kristiansand', 'XKR', 'NO', 0, 0, 'Kristiansand Rail Station', -100);
INSERT INTO public.airports VALUES (1814, 'Kristiansand', 'KRS', 'NO', 58.204212, 8.085369, 'Kjevik Airport', 1);
INSERT INTO public.airports VALUES (1815, 'Khartoum', 'KRT', 'SD', 15.589497, 32.55316, 'Civil Arpt', 2);
INSERT INTO public.airports VALUES (1816, 'Turkmanbashi', 'KRW', 'TM', 40.06333, 53.00722, 'Turkmanbashi Arpt', 5);
INSERT INTO public.airports VALUES (1817, 'Karamay', 'KRY', 'CN', 45.617, 84.883, 'Karamay Arpt', 8);
INSERT INTO public.airports VALUES (1818, 'Kosice', 'KSC', 'SK', 48.663055, 21.241112, 'Barca Arpt', 1);
INSERT INTO public.airports VALUES (1819, 'Karlstad', 'KSD', 'SE', 59.4447, 13.3374, 'Karlstad Arpt', 1);
INSERT INTO public.airports VALUES (1820, 'Kassel', 'KSF', 'DE', 51.408394, 9.377631, 'Kassel Calden Arpt', 1);
INSERT INTO public.airports VALUES (1821, 'Kermanshah', 'KSH', 'IR', 34.34585, 47.158127, 'Kermanshah Arpt', 4);
INSERT INTO public.airports VALUES (1822, 'Kostanay', 'KSN', 'KZ', 53.206944, 63.550278, 'Kostanay Arpt', 6);
INSERT INTO public.airports VALUES (1823, 'Kastoria', 'KSO', 'GR', 40.446293, 21.282187, 'Aristoteles Arpt', 2);
INSERT INTO public.airports VALUES (1824, 'Karshi Arpt', 'KSQ', 'UZ', 38.8336, 65.9215, 'Karshi Arpt', 5);
INSERT INTO public.airports VALUES (1825, 'SANDY RIVER', 'KSR', 'US', 0, 0, 'SANDY RIVER', 1);
INSERT INTO public.airports VALUES (1826, 'Kristiansund', 'XGI', 'NO', 0, 0, 'Andalsnes Rail Station', -100);
INSERT INTO public.airports VALUES (1827, 'Kristiansund', 'KSU', 'NO', 63.111782, 7.824522, 'Kvernberget Arpt', 1);
INSERT INTO public.airports VALUES (1828, 'Kiryat Shmona', 'KSW', 'IL', 0, 0, 'Kiryat Shmona Arpt', -100);
INSERT INTO public.airports VALUES (1829, 'Kars', 'KSY', 'TR', 40.56222, 43.115, 'Kars Arpt', 2);
INSERT INTO public.airports VALUES (1830, 'Kotlas Airport', 'KSZ', 'RU', 61.2358, 46.6975, 'Kotlas Airport', 4);
INSERT INTO public.airports VALUES (1831, 'Karratha', 'KTA', 'AU', -20.712221, 116.77333, 'Karratha Airport', 8);
INSERT INTO public.airports VALUES (1832, 'Kerteh', 'KTE', 'MY', 4.537222, 103.42676, 'Kertech Arpt', 8);
INSERT INTO public.airports VALUES (1833, 'Kathmandu', 'KTM', 'NP', 27.696583, 85.3591, 'Tribuvan Arpt', 5);
INSERT INTO public.airports VALUES (1834, 'Ketchikan', 'KTN', 'US', 55.355556, -131.71375, 'Ketchikan Intl Arpt', -9);
INSERT INTO public.airports VALUES (1835, 'Katherine', 'KTR', 'AU', -14.5211, 132.378, 'Tindal Airport', 9);
INSERT INTO public.airports VALUES (1836, 'Brevig Mission', 'KTS', 'US', 65.33139, -166.46584, 'Brevig Mission Arpt', -9);
INSERT INTO public.airports VALUES (1837, 'Kittila', 'KTT', 'FI', 67.70102, 24.84685, 'Kittila Arpt', 2);
INSERT INTO public.airports VALUES (1838, 'Katowice', 'KTW', 'PL', 50.474255, 19.080019, 'Pyrzowice', 1);
INSERT INTO public.airports VALUES (1839, 'Kuantan', 'KUA', 'MY', 3.775389, 103.20905, 'Kuantan Arpt', 8);
INSERT INTO public.airports VALUES (1840, 'Kuala Belait', 'KUB', 'BN', 0, 0, 'Kuala Belait Arpt', -100);
INSERT INTO public.airports VALUES (1841, 'Kudat', 'KUD', 'MY', 6.9225, 116.836, 'Kudat Arpt', 8);
INSERT INTO public.airports VALUES (1842, 'Samara', 'KUF', 'RU', 53.5, 50.15, 'Samara Arpt', 4);
INSERT INTO public.airports VALUES (1843, 'Kushiro', 'KUH', 'JP', 43.041, 144.193, 'Kushiro Arpt', 9);
INSERT INTO public.airports VALUES (1844, 'Kuala Lumpur', 'KUL', 'MY', 2.745578, 101.709915, 'Kuala Lumpur International Arpt', 8);
INSERT INTO public.airports VALUES (1845, 'Kuala Lumpur', 'SZB', 'MY', 3.130583, 101.54933, 'Sultan Abdul Aziz Shah Arpt', 8);
INSERT INTO public.airports VALUES (1846, 'Kaunas', 'KUN', 'LT', 54.96392, 24.084778, 'Kaunas Arpt', 2);
INSERT INTO public.airports VALUES (1847, 'Kuopio', 'KUO', 'FI', 63.00715, 27.797756, 'Kuopio Arpt', 2);
INSERT INTO public.airports VALUES (1848, 'Kulusuk', 'KUS', 'GL', 65.566666, -37.11667, 'Kulusuk Arpt', -2);
INSERT INTO public.airports VALUES (1849, 'Kutaisi Arpt', 'KUT', 'GE', 42.25, 42.7, 'Kutaisi Arpt', 4);
INSERT INTO public.airports VALUES (1850, 'Kulu', 'KUU', 'IN', 31.876705, 77.154366, 'Bhuntar Arpt', 5);
INSERT INTO public.airports VALUES (1851, 'Kunsan', 'KUV', 'KR', 35.903755, 126.615906, 'Kunsan Arpt', 9);
INSERT INTO public.airports VALUES (1852, 'Kavalla', 'KVA', 'GR', 40.913307, 24.619223, 'Megas Alexandros', 2);
INSERT INTO public.airports VALUES (1853, 'Skovde', 'KVB', 'SE', 58.4564, 13.972672, 'Skovde Arpt', 1);
INSERT INTO public.airports VALUES (1854, 'Ganja', 'KVD', 'AZ', 40.7377, 46.3176, 'Ganja', 4);
INSERT INTO public.airports VALUES (1855, 'Kavieng', 'KVG', 'PG', -2.5794, 150.808, 'Kavieng Arpt', 10);
INSERT INTO public.airports VALUES (1856, 'Kirovsk-Apatity Airport', 'KVK', 'RU', 67.4633, 33.5883, 'Kirovsk-Apatity Airport', 4);
INSERT INTO public.airports VALUES (1857, 'Kirov', 'KVX', 'RU', 58.5033, 49.3483, 'Pobedilovo Airport', 4);
INSERT INTO public.airports VALUES (1858, 'Kwajalein', 'KWA', 'MH', 8.720122, 167.73166, 'Kwajalein Arpt', 12);
INSERT INTO public.airports VALUES (1859, 'Guiyang', 'KWE', 'CN', 26.538523, 106.800705, 'Guiyang Arpt', 8);
INSERT INTO public.airports VALUES (1860, 'Krivoy Rog', 'KWG', 'UA', 48.0433, 33.21, 'Krivoy Rog Arpt', 2);
INSERT INTO public.airports VALUES (1861, 'Kuwait', 'KWI', 'KW', 29.226566, 47.96893, 'Kuwait Intl', 3);
INSERT INTO public.airports VALUES (1862, 'Kwangju', 'KWJ', 'KR', 35.12639, 126.80889, 'Kwangju Arpt', 9);
INSERT INTO public.airports VALUES (1863, 'Guilin', 'KWL', 'CN', 25.218105, 110.0392, 'Guilin Airport', 8);
INSERT INTO public.airports VALUES (1864, 'Komsomolsk Na Amure', 'KXK', 'RU', 50.4094, 136.934, 'Komsomolsk Na Amure Arpt', 11);
INSERT INTO public.airports VALUES (1865, 'Konya', 'KYA', 'TR', 37.979, 32.56186, 'Konya Arpt', 2);
INSERT INTO public.airports VALUES (1866, 'Key Largo', 'KYL', 'US', 0, 0, 'Port Largo Arpt', -100);
INSERT INTO public.airports VALUES (1867, 'Milton Keynes', 'KYN', 'GB', 0, 0, 'Milton Keynes Rail Station', -100);
INSERT INTO public.airports VALUES (1868, 'KAYES', 'KYS', 'ML', 14.481233, -11.404397, 'KAYES', 0);
INSERT INTO public.airports VALUES (1869, 'Kyzyl Airport', 'KYZ', 'RU', 51.6694, 94.4006, 'Kyzyl Airport', 8);
INSERT INTO public.airports VALUES (1870, 'Zachar Bay', 'KZB', 'US', 57.55, -153.75, 'Zachar Bay Sea Plane Base', -9);
INSERT INTO public.airports VALUES (1871, 'Kozani', 'KZI', 'GR', 40.28611, 21.840834, 'Philippos Arpt', 2);
INSERT INTO public.airports VALUES (1872, 'Kazan', 'KZN', 'RU', 55.606186, 49.27873, 'Kazan Arpt', 4);
INSERT INTO public.airports VALUES (1873, 'Kzyl Orda', 'KZO', 'KZ', 44.709, 65.591, 'Kzyl Orda Arpt', 6);
INSERT INTO public.airports VALUES (1874, 'Kütahya Zafer Arpt', 'KZR', 'TR', 39.4, 30, 'Zafer Arpt', 2);
INSERT INTO public.airports VALUES (1875, 'Kastelorizo', 'KZS', 'GR', 36.127777, 29.566656, 'Kastelorizo Arpt', 2);
INSERT INTO public.airports VALUES (1876, 'Lamar', 'LAA', 'US', 38.069695, -102.6885, 'Lamar Arpt', -7);
INSERT INTO public.airports VALUES (1877, 'Luanda', 'LAD', 'AO', -8.858375, 13.231178, 'Four De Fevereiro Arpt', 1);
INSERT INTO public.airports VALUES (1878, 'Lae Pg', 'LAE', 'PG', -6.569828, 146.72624, 'Nadzab Arpt', 10);
INSERT INTO public.airports VALUES (1879, 'Lafayette', 'LAF', 'US', 40.412308, -86.93689, 'Lafayette Arpt', -5);
INSERT INTO public.airports VALUES (1880, 'La Guaira Arpt', 'LAG', 'VE', 10.6, -66.933334, 'La Guaira Arpt', -4);
INSERT INTO public.airports VALUES (1881, 'Lannion', 'LAI', 'FR', 48.75438, -3.471656, 'Servel Airport', 1);
INSERT INTO public.airports VALUES (1882, 'Lajes', 'LAJ', 'BR', -27.7828, -50.2806, 'Lages Arpt', -100);
INSERT INTO public.airports VALUES (1883, 'Lakeland', 'LAL', 'US', 27.988916, -82.018555, 'Lakeland Arpt', -4);
INSERT INTO public.airports VALUES (1884, 'Los Alamos', 'LAM', 'US', 35.879803, -106.26942, 'Los Alamos Municipal', -6);
INSERT INTO public.airports VALUES (1885, 'Lansing', 'LAN', 'US', 42.7787, -84.58736, 'Lansing Arpt', -5);
INSERT INTO public.airports VALUES (1886, 'Laoag', 'LAO', 'PH', 18.178091, 120.531525, 'Laoag Arpt', 8);
INSERT INTO public.airports VALUES (1887, 'La Paz', 'LAP', 'MX', 24.072695, -110.36247, 'Aeropuerto Gen Marquez De Leon', -7);
INSERT INTO public.airports VALUES (1888, 'Laramie', 'SAA', 'US', 41.44486, -106.823524, 'Lar Shively Arpt', -6);
INSERT INTO public.airports VALUES (1889, 'Laramie', 'LAR', 'US', 41.3121, -105.675, 'General Brees Fld', -7);
INSERT INTO public.airports VALUES (1890, 'Las Vegas', 'HSH', 'US', 35.97278, -115.134445, 'Henderson Sky Harbor Arpt', -8);
INSERT INTO public.airports VALUES (1891, 'Las Vegas', 'VGT', 'US', 36.210693, -115.19444, 'Las Vegas North Air Terminal', -7);
INSERT INTO public.airports VALUES (1892, 'Las Vegas', 'LAS', 'US', 36.080055, -115.15225, 'McCarran Intl', -8);
INSERT INTO public.airports VALUES (1893, 'Las Vegas', 'BLD', 'US', 35.5651, -114.514, 'Boulder City Municipal Arpt', -8);
INSERT INTO public.airports VALUES (1894, 'Lamu', 'LAU', 'KE', -2.252417, 40.913097, 'Lamu Arpt', 3);
INSERT INTO public.airports VALUES (1895, 'Lawton', 'LAW', 'US', 34.567715, -98.41663, 'Lawton Municipal', -6);
INSERT INTO public.airports VALUES (1896, 'Los Angeles', 'VNY', 'US', 34.209812, -118.489975, 'Van Nuys Arpt', -8);
INSERT INTO public.airports VALUES (1897, 'Mary', 'MYP', 'TM', 37.6194, 61.8967, 'Mary Arpt', 5);
INSERT INTO public.airports VALUES (1898, 'Los Angeles', 'SMO', 'US', 34.015835, -118.45131, 'Santa Monica Municipal Arpt', -7);
INSERT INTO public.airports VALUES (1899, 'Los Angeles', 'LAX', 'US', 33.942535, -118.40807, 'Los Angeles Intl Arpt', -8);
INSERT INTO public.airports VALUES (1900, 'Ladysmith', 'LAY', 'ZA', -28.581667, 29.749722, 'Ladysmith Arpt', 2);
INSERT INTO public.airports VALUES (1901, 'Leeds', 'LBA', 'GB', 53.8659, -1.660569, 'Leeds Bradford Arpt', 0);
INSERT INTO public.airports VALUES (1902, 'Lubbock', 'LBB', 'US', 33.66364, -101.82278, 'Lubbock Preston Smith Intl Arpt', -6);
INSERT INTO public.airports VALUES (1903, 'LBD', 'LBD', 'TJ', 40.2154, 69.6947, 'Khudzhand Arpt', 5);
INSERT INTO public.airports VALUES (1904, 'Latrobe', 'LBE', 'US', 40.2759, -79.4048, 'Westmorland County', -5);
INSERT INTO public.airports VALUES (1905, 'North Platte', 'LBF', 'US', 41.1262, -100.684, 'Lee Bird Field', -6);
INSERT INTO public.airports VALUES (1906, 'Albi', 'LBI', 'FR', 43.913887, 2.113056, 'Le Sequestre Arpt', 1);
INSERT INTO public.airports VALUES (1907, 'Liberal', 'LBL', 'US', 37.044224, -100.95986, 'Liberal Municipal', -6);
INSERT INTO public.airports VALUES (1908, 'Long Banga', 'LBP', 'MY', 3.18495, 115.454, 'Long Banga Airfield Arpt', 8);
INSERT INTO public.airports VALUES (1909, 'Labasa', 'LBS', 'FJ', -16.46675, 179.33986, 'Labasa Arpt', 12);
INSERT INTO public.airports VALUES (1910, 'Lumberton', 'LBT', 'US', 0, 0, 'Lumberton Arpt', -100);
INSERT INTO public.airports VALUES (1911, 'Labuan', 'LBU', 'MY', 5.300683, 115.25018, 'Labuan Arpt', 8);
INSERT INTO public.airports VALUES (1912, 'Libreville', 'LBV', 'GA', 0.4586, 9.412283, 'Libreville Arpt', 1);
INSERT INTO public.airports VALUES (1913, 'La Baule', 'LBY', 'FR', 0, 0, 'Montoir Arpt', -100);
INSERT INTO public.airports VALUES (1914, 'Larnaca', 'LCA', 'CY', 34.87512, 33.62485, 'Larnaca Intl', 2);
INSERT INTO public.airports VALUES (1915, 'Lecce', 'LCC', 'IT', 40.239227, 18.133326, 'Galatina Arpt', 1);
INSERT INTO public.airports VALUES (1916, 'La Ceiba', 'LCE', 'HN', 15.742481, -86.853035, 'Goloson Intl Arpt', -6);
INSERT INTO public.airports VALUES (1917, 'Rio Dulce', 'LCF', 'GT', 0, 0, 'Las Vegas Airport', -100);
INSERT INTO public.airports VALUES (1918, 'La Coruna', 'LCG', 'ES', 43.30206, -8.377256, 'La Coruna Arpt', 1);
INSERT INTO public.airports VALUES (1919, 'Lake Charles', 'LCH', 'US', 30.126112, -93.223335, 'Lake Charles Municipal', -6);
INSERT INTO public.airports VALUES (1920, 'Laconia', 'LCI', 'US', 43.5736, -71.4189, 'Laconia Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1921, 'Lodz', 'LCJ', 'PL', 51.72188, 19.398132, 'Lodz Lublinek Arpt', 1);
INSERT INTO public.airports VALUES (1922, 'Lucca', 'LCV', 'IT', 0, 0, 'Lucca Arpt', -100);
INSERT INTO public.airports VALUES (1923, 'Londrina', 'LDB', 'BR', -23.333626, -51.130074, 'Londrina Arpt', -3);
INSERT INTO public.airports VALUES (1924, 'Lourdes', 'LDE', 'FR', 43.178677, -0.006439, 'Tarbes Intl Arpt', 1);
INSERT INTO public.airports VALUES (1925, 'Leshukonskoye Airport', 'LDG', 'RU', 64.895836, 45.72278, 'Leshukonskoye Airport', 4);
INSERT INTO public.airports VALUES (1926, 'Lord Howe Island', 'LDH', 'AU', -31.5383, 159.077, 'Lord Howe Island Arpt', 10);
INSERT INTO public.airports VALUES (1927, 'Linden', 'LDJ', 'US', 0, 0, 'Linden Municipal', -100);
INSERT INTO public.airports VALUES (1928, 'Lidkoping', 'LDK', 'SE', 58.465523, 13.174414, 'Hovby Airport', 1);
INSERT INTO public.airports VALUES (1929, 'Lahad Datu', 'LDU', 'MY', 5.032247, 118.324036, 'Lahad Datu Arpt', 8);
INSERT INTO public.airports VALUES (1930, 'Saint Laurent du Maroni', 'LDX', 'GF', 5.483056, -54.034443, 'Saint Laurent du Maroni Arpt', -4);
INSERT INTO public.airports VALUES (1931, 'Londonderry', 'LDY', 'GB', 55.042778, -7.161111, 'Eglinton Arpt', 0);
INSERT INTO public.airports VALUES (1932, 'Learmonth', 'LEA', 'AU', -22.235556, 114.08861, 'Learmonth Arpt', 8);
INSERT INTO public.airports VALUES (1933, 'Lebanon', 'CNH', 'US', 0, 0, 'Claremont Municipal', -100);
INSERT INTO public.airports VALUES (1934, 'Lebanon', 'LEB', 'US', 43.6261, -72.3042, 'Lebanon Regional', -5);
INSERT INTO public.airports VALUES (1935, 'Lencois', 'LEC', 'BR', -12.4823, -41.277, 'Chapada Diamantina Arpt', -3);
INSERT INTO public.airports VALUES (1936, 'St Petersburg', 'LED', 'RU', 59.800293, 30.262503, 'Pulkovo Airport', 4);
INSERT INTO public.airports VALUES (1937, 'St Petersburg', 'RVH', 'RU', 0, 0, 'Rzhevka Arpt', -100);
INSERT INTO public.airports VALUES (1938, 'Leesburg', 'LEE', 'US', 0, 0, 'Leesburg Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1939, 'Le Havre', 'LEH', 'FR', 49.53389, 0.088056, 'Octeville Arpt', 1);
INSERT INTO public.airports VALUES (1940, 'Almeria', 'LEI', 'ES', 36.843937, -2.370097, 'Almeria Arpt', 1);
INSERT INTO public.airports VALUES (1941, 'Leipzig', 'LEJ', 'DE', 51.432446, 12.241633, 'Leipzig Arpt', 1);
INSERT INTO public.airports VALUES (1942, 'Leon', 'LEN', 'ES', 42.589, -5.655556, 'Leon Arpt', 1);
INSERT INTO public.airports VALUES (1943, 'Lands End', 'LEQ', 'GB', 50.1028, -5.67056, 'St Just Arpt', 0);
INSERT INTO public.airports VALUES (1944, 'Leinster', 'LER', 'AU', -27.8433, 120.703, 'Leinster Arpt', 8);
INSERT INTO public.airports VALUES (1945, 'Lesobeng', 'LES', 'LS', 47.75, 10.601, 'Lesobeng Arpt', 2);
INSERT INTO public.airports VALUES (1946, 'Leticia', 'LET', 'CO', -4.193549, -69.94316, 'General A V Cobo Arpt', -5);
INSERT INTO public.airports VALUES (1947, 'Lewiston', 'LEW', 'US', 0, 0, 'Auburn Lewiston Arpt', -100);
INSERT INTO public.airports VALUES (1948, 'Lexington', 'LEX', 'US', 38.0365, -84.60589, 'Blue Grass Field', -5);
INSERT INTO public.airports VALUES (1949, 'Lelystad', 'LEY', 'NL', 52.4603, 5.52722, 'Lelystad Arpt', 1);
INSERT INTO public.airports VALUES (1950, 'Lufkin', 'LFK', 'US', 31.234015, -94.75, 'Angelina Cty Arpt', -6);
INSERT INTO public.airports VALUES (1951, 'Lafayette', 'LFT', 'US', 30.205278, -91.98761, 'Lafayette Municipal', -6);
INSERT INTO public.airports VALUES (1952, 'Lome', 'LFW', 'TG', 6.165611, 1.254511, 'Lome Airport', 1);
INSERT INTO public.airports VALUES (1953, 'Long Beach', 'LGB', 'US', 33.817722, -118.15161, 'Long Beach Municipal', -8);
INSERT INTO public.airports VALUES (1954, 'La Grange', 'LGC', 'US', 33.00886, -85.07261, 'Calloway Arpt', -4);
INSERT INTO public.airports VALUES (1955, 'Liege', 'LGG', 'BE', 50.637417, 5.443222, 'Bierset Airport', 1);
INSERT INTO public.airports VALUES (1956, 'Deadmans Cay', 'LGI', 'BS', 23.179014, -75.0936, 'Deadmans Cay Arpt', -5);
INSERT INTO public.airports VALUES (1957, 'Langkawi', 'LGK', 'MY', 6.329728, 99.72867, 'Langkawi Arpt', 8);
INSERT INTO public.airports VALUES (1958, 'Long Lellang', 'LGL', 'MY', 3.421, 115.154, 'Long Lellang Arpt', 8);
INSERT INTO public.airports VALUES (1959, 'Legaspi', 'LGP', 'PH', 13.157064, 123.74625, 'Legaspi Arpt', 8);
INSERT INTO public.airports VALUES (1960, 'Malargue', 'LGS', 'AR', -35.493595, -69.574265, 'Malargue Arpt', -3);
INSERT INTO public.airports VALUES (1961, 'Logan', 'LGU', 'US', 41.791, -111.852, 'Logan Arpt', -7);
INSERT INTO public.airports VALUES (1962, 'Lahr', 'LHA', 'DE', 48.3693, 7.82772, 'Lahr Arpt', 1);
INSERT INTO public.airports VALUES (1963, 'Lahore', 'LHE', 'PK', 31.521564, 74.403595, 'Lahore Arpt', 5);
INSERT INTO public.airports VALUES (1964, 'Lightning Ridge', 'LHG', 'AU', -29.4567, 147.984, 'Lightning Ridge Arpt', 10);
INSERT INTO public.airports VALUES (1965, 'Lanzhou', 'LHW', 'CN', 36.117, 103.617, 'Lanzhou Arpt', 8);
INSERT INTO public.airports VALUES (1966, 'Lianping', 'LIA', 'CN', 0, 0, 'Lianping Arpt', -100);
INSERT INTO public.airports VALUES (1967, 'Lifou', 'LIF', 'NC', -20.7748, 167.23987, 'Lifou Arpt', 11);
INSERT INTO public.airports VALUES (1968, 'Limoges', 'LIG', 'FR', 45.862778, 1.179444, 'Bellegarde Arpt', 1);
INSERT INTO public.airports VALUES (1969, 'Lihue', 'LIH', 'US', 21.975983, -159.33896, 'Lihue Municipal', -10);
INSERT INTO public.airports VALUES (1970, 'Lille', 'XDB', 'FR', 50.56333, 3.08805, 'Europe Railway Service', 1);
INSERT INTO public.airports VALUES (1971, 'Lille', 'LIL', 'FR', 50.561943, 3.089444, 'Lesquin Arpt', 1);
INSERT INTO public.airports VALUES (1972, 'Lille', 'XFA', 'FR', 50.6325, 3.0583, 'Lille Flanders Rail Service', -100);
INSERT INTO public.airports VALUES (1973, 'Lima', 'LIM', 'PE', -12.021889, -77.11432, 'Jorge Chavez International Arpt', -5);
INSERT INTO public.airports VALUES (1974, 'Limon', 'LIO', 'CR', 9.957961, -83.022, 'Limon Arpt', -6);
INSERT INTO public.airports VALUES (1975, 'Liberia', 'LIR', 'CR', 10.593289, -85.54441, 'Liberia Arpt', -6);
INSERT INTO public.airports VALUES (1976, 'Lisbon', 'LIS', 'PT', 38.78131, -9.135919, 'Lisboa', 0);
INSERT INTO public.airports VALUES (1977, 'Little Rock', 'LIT', 'US', 34.729443, -92.224304, 'Little Rock Regional', -6);
INSERT INTO public.airports VALUES (1978, 'Lijiang City', 'LJG', 'CN', 26.883333, 100.23333, 'Lijiang Arpt', 8);
INSERT INTO public.airports VALUES (1979, 'Lake Jackson', 'LJN', 'US', 0, 0, 'Lake Jackson Arpt', -100);
INSERT INTO public.airports VALUES (1980, 'Ljubljana', 'LJU', 'SI', 46.223686, 14.457611, 'Brnik Airport', 1);
INSERT INTO public.airports VALUES (1981, 'Lokichoggio', 'LKG', 'KE', 4.204117, 34.348186, 'Lokichoggio Arpt', 3);
INSERT INTO public.airports VALUES (1982, 'Long Akah', 'LKH', 'MY', 3.3, 114.783, 'Long Akah Arpt', 8);
INSERT INTO public.airports VALUES (1983, 'Lakselv', 'LKL', 'NO', 70.06882, 24.97349, 'Banak Airport', 1);
INSERT INTO public.airports VALUES (1984, 'Leknes', 'LKN', 'NO', 68.1525, 13.6094, 'Leknes Arpt', 1);
INSERT INTO public.airports VALUES (1985, 'Lucknow', 'LKO', 'IN', 26.760593, 80.889336, 'Amausi Arpt', 5);
INSERT INTO public.airports VALUES (1986, 'Lulea', 'LLA', 'SE', 65.543755, 22.121988, 'Kallax Airport', 1);
INSERT INTO public.airports VALUES (1987, 'Malelane', 'LLE', 'ZA', 0, 0, 'Municipal Arpt', -100);
INSERT INTO public.airports VALUES (1988, 'Ling Ling', 'LLF', 'CN', 26.7008, 111.9575, 'Ling Ling Arpt', -100);
INSERT INTO public.airports VALUES (1989, 'Lankaran International Arpt', 'LLK', 'AZ', 38.74203, 48.824093, 'Lankaran International Arpt', 5);
INSERT INTO public.airports VALUES (1990, 'Alluitsup Paa', 'LLU', 'GL', 60.4644, -45.5778, 'Alluitsup Paa Arpt', -3);
INSERT INTO public.airports VALUES (1991, 'Lilongwe', 'LLW', 'MW', -13.789378, 33.781, 'Lilongwe Intl Arpt', 2);
INSERT INTO public.airports VALUES (1992, 'Mount Holly', 'LLY', 'US', 0, 0, 'Burlington Country Arpt', -100);
INSERT INTO public.airports VALUES (1993, 'Le Mans', 'LME', 'FR', 47.948612, 0.201667, 'Arnage Arpt', 1);
INSERT INTO public.airports VALUES (1994, 'Los Mochis', 'LMM', 'MX', 25.685194, -109.0808, 'Federal Los Mochis Arpt', -7);
INSERT INTO public.airports VALUES (1995, 'Limbang', 'LMN', 'MY', 4.808303, 115.01044, 'Limbang Arpt', 8);
INSERT INTO public.airports VALUES (1996, 'Lampedusa', 'LMP', 'IT', 35.497913, 12.618083, 'Lampedusa Arpt', 1);
INSERT INTO public.airports VALUES (1997, 'Louisville', 'LMS', 'US', 33.1462, -89.0625, 'Louisville Winston County Arpt', -100);
INSERT INTO public.airports VALUES (1998, 'Klamath Falls', 'LMT', 'US', 42.1561, -121.733, 'Kingsley Field', -8);
INSERT INTO public.airports VALUES (1999, 'Lincoln', 'LNK', 'US', 40.85097, -96.75925, 'Lincoln Municipal', -6);
INSERT INTO public.airports VALUES (2000, 'Leonora', 'LNO', 'AU', -28.8781, 121.315, 'Leonora Arpt', 8);
INSERT INTO public.airports VALUES (2001, 'Lancaster', 'LNS', 'US', 40.1217, -76.2961, 'Lancaster Arpt', -5);
INSERT INTO public.airports VALUES (2002, 'Lihir Island', 'LNV', 'PG', -3.04361, 152.629, 'Lihir Island Arpt', 10);
INSERT INTO public.airports VALUES (2003, 'Lanai', 'LNY', 'US', 20.78561, -156.95142, 'Lanai Airport', -10);
INSERT INTO public.airports VALUES (2004, 'Linz', 'LNZ', 'AT', 48.23322, 14.187511, 'Hoersching Arpt', 1);
INSERT INTO public.airports VALUES (2005, 'Loei', 'LOE', 'TH', 17.439133, 101.72206, 'Loei Arpt', 7);
INSERT INTO public.airports VALUES (2006, 'Loja', 'LOH', 'EC', -3.99589, -79.3719, 'Aeropuerto Camilo Enriquez', -5);
INSERT INTO public.airports VALUES (2007, 'Lagos De Moreno', 'LOM', 'MX', 0, 0, 'Francisco P V Y R', -100);
INSERT INTO public.airports VALUES (2008, 'London', 'QQP', 'GB', 51.515835, -0.176111, 'London - Paddington Rail Service', 0);
INSERT INTO public.airports VALUES (2009, 'London', 'QQS', 'GB', 51.53252, -0.1263, 'QQS St Pancras Intl Rail St', 0);
INSERT INTO public.airports VALUES (2010, 'London', 'QQU', 'GB', 0, 0, 'London - Euston Rail Service', -100);
INSERT INTO public.airports VALUES (2011, 'London', 'QQW', 'GB', 0, 0, 'London - Waterloo Rail Service', -100);
INSERT INTO public.airports VALUES (2012, 'London', 'XQE', 'GB', 0, 0, 'XQE Ebbsfleet Kent Rail St', -100);
INSERT INTO public.airports VALUES (2013, 'London', 'ZEP', 'GB', 0, 0, 'London - Victoria Railway Station', -100);
INSERT INTO public.airports VALUES (2014, 'London', 'LGW', 'GB', 51.148056, -0.190278, 'Gatwick Arpt', 0);
INSERT INTO public.airports VALUES (2015, 'London', 'LHR', 'GB', 51.4775, -0.461389, 'Heathrow', 0);
INSERT INTO public.airports VALUES (2016, 'London', 'QQK', 'GB', 20.2461, 0.9808, 'London - Kings Cross Rail Service', -100);
INSERT INTO public.airports VALUES (2017, 'London', 'LCY', 'GB', 51.50528, 0.055278, 'London City Arpt', 0);
INSERT INTO public.airports VALUES (2018, 'London', 'STN', 'GB', 51.885, 0.235, 'Stansted Arpt', 0);
INSERT INTO public.airports VALUES (2019, 'London', 'QQH', 'GB', 0, 0, 'Harwich Rail Station', -100);
INSERT INTO public.airports VALUES (2020, 'Lagos', 'LOS', 'NG', 6.577369, 3.321156, 'Murtala Muhammed Arpt', 1);
INSERT INTO public.airports VALUES (2021, 'Monclova', 'LOV', 'MX', 26.955732, -101.47014, 'Monclova Arpt', -6);
INSERT INTO public.airports VALUES (2022, 'London', 'LOZ', 'US', 37.087, -84.0773, 'Corbin London Arpt', -100);
INSERT INTO public.airports VALUES (2023, 'Gran Canaria', 'LPA', 'ES', 27.931887, -15.386586, 'Aeropuerto De Gran Canaria', 0);
INSERT INTO public.airports VALUES (2024, 'La Paz', 'LPB', 'BO', -16.513338, -68.19225, 'El Alto Arpt', -4);
INSERT INTO public.airports VALUES (2025, 'La Plata', 'LPG', 'AR', -34.97222, -57.894695, 'La Plata Arpt', -3);
INSERT INTO public.airports VALUES (2026, 'Lochgilphead', 'LPH', 'GB', 0, 0, 'Lochgilphead Heliport', -100);
INSERT INTO public.airports VALUES (2027, 'Linkoping', 'LPI', 'SE', 58.40615, 15.680508, 'Saab Airport', 1);
INSERT INTO public.airports VALUES (2028, 'Lipetsk Airport', 'LPK', 'RU', 52.7028, 39.5378, 'Lipetsk Airport', 4);
INSERT INTO public.airports VALUES (2029, 'Liverpool', 'LPL', 'GB', 53.33361, -2.849722, 'Liverpool Arpt', 0);
INSERT INTO public.airports VALUES (2030, 'Liverpool', 'ZLS', 'GB', 0, 0, 'Liverpool Street Station', -100);
INSERT INTO public.airports VALUES (2031, 'Liverpool', 'XWN', 'GB', 0, 0, 'Warrington B Q Rail Station', -100);
INSERT INTO public.airports VALUES (2032, 'La Porte', 'LPO', 'US', 0, 0, 'La Porte Arpt', -100);
INSERT INTO public.airports VALUES (2033, 'Lappeenranta', 'LPP', 'FI', 61.04455, 28.144398, 'Lappeenranta Arpt', 2);
INSERT INTO public.airports VALUES (2034, 'Louangphrabang', 'LPQ', 'LA', 19.897915, 102.16077, 'Louangphrabang Arpt', 7);
INSERT INTO public.airports VALUES (2035, 'Lopez Island', 'LPS', 'US', 48.4839, -122.938, 'Lopez Island Arpt', -8);
INSERT INTO public.airports VALUES (2036, 'Lampang', 'LPT', 'TH', 18.270933, 99.504166, 'Lampang Arpt', 7);
INSERT INTO public.airports VALUES (2037, 'Liepaja', 'LPX', 'LV', 56.5175, 21.096945, 'Liepaya Arpt', 2);
INSERT INTO public.airports VALUES (2038, 'Le Puy', 'LPY', 'FR', 45.08069, 3.762889, 'Loudes Airport', 1);
INSERT INTO public.airports VALUES (2039, 'Larisa', 'LRA', 'GR', 39.650253, 22.4655, 'Larisa Arpt', 2);
INSERT INTO public.airports VALUES (2040, 'Laredo', 'LRD', 'US', 27.54375, -99.461555, 'Laredo Intl', -6);
INSERT INTO public.airports VALUES (2041, 'Longreach', 'LRE', 'AU', -23.4342, 144.28, 'Longreach Arpt', 10);
INSERT INTO public.airports VALUES (2042, 'La Rochelle', 'LRH', 'FR', 46.1792, -1.19528, 'Laleu Airport', 1);
INSERT INTO public.airports VALUES (2043, 'La Romana', 'LRM', 'DO', 18.45071, -68.911835, 'La Romana Arpt', -4);
INSERT INTO public.airports VALUES (2044, 'Leros', 'LRS', 'GR', 37.184902, 26.80029, 'Leros Arpt', 2);
INSERT INTO public.airports VALUES (2045, 'Lorient', 'LRT', 'FR', 47.760555, -3.44, 'Lann Bihoue Arpt', 1);
INSERT INTO public.airports VALUES (2046, 'Las Cruces', 'LRU', 'US', 32.289417, -106.921974, 'Las Cruces Crawford Arpt', -7);
INSERT INTO public.airports VALUES (2047, 'La Serena', 'LSC', 'CL', -29.916233, -71.199524, 'La Florida', -4);
INSERT INTO public.airports VALUES (2048, 'La Crosse', 'LSE', 'US', 43.878986, -91.256714, 'La Crosse Municipal', -6);
INSERT INTO public.airports VALUES (2049, 'Lerwick', 'LSI', 'GB', 59.878887, -1.295556, 'Sumburgh Airport', 0);
INSERT INTO public.airports VALUES (2050, 'Lerwick', 'LWK', 'GB', 60.1922, -1.24361, 'Tingwall Arpt', 0);
INSERT INTO public.airports VALUES (2051, 'Los Banos', 'LSN', 'US', 0, 0, 'Los Banos Arpt', -100);
INSERT INTO public.airports VALUES (2052, 'Les Sables', 'LSO', 'FR', 0, 0, 'Talmont Arpt', -100);
INSERT INTO public.airports VALUES (2053, 'Las Piedras', 'LSP', 'VE', 11.780775, -70.1515, 'Josefa Camejo Arpt', -4);
INSERT INTO public.airports VALUES (2054, 'Los Angeles', 'LSQ', 'CL', -37.40173, -72.425446, 'Maria Dolores Arpt', -4);
INSERT INTO public.airports VALUES (2055, 'Launceston', 'LST', 'AU', -41.545277, 147.21417, 'Launceston Arpt', 10);
INSERT INTO public.airports VALUES (2056, 'Lismore', 'LSY', 'AU', -28.8303, 153.26, 'Lismore Airport', 10);
INSERT INTO public.airports VALUES (2057, 'Tzaneen', 'LTA', 'ZA', -23.824417, 30.329306, 'Letaba Aprt', 2);
INSERT INTO public.airports VALUES (2058, 'Latakia', 'LTK', 'SY', 35.401093, 35.94868, 'Hmelmin Airport', 2);
INSERT INTO public.airports VALUES (2059, 'Luton', 'LTN', 'GB', 51.87472, -0.368333, 'Luton Arpt', 0);
INSERT INTO public.airports VALUES (2060, 'Loreto', 'LTO', 'MX', 25.989195, -111.34836, 'Loreto Intl Arpt', -7);
INSERT INTO public.airports VALUES (2061, 'Le Touquet', 'LTQ', 'FR', 50.517384, 1.620587, 'Le Touquet Arpt', 1);
INSERT INTO public.airports VALUES (2062, 'Altus', 'AXS', 'US', 0, 0, 'Altus Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2063, 'St Tropez', 'LTT', 'FR', 43.2054, 6.482, 'La Mole Arpt', 1);
INSERT INTO public.airports VALUES (2064, 'Latur', 'LTU', 'IN', 18.411943, 76.465, 'Latur Arpt', 5);
INSERT INTO public.airports VALUES (2065, 'Latacunga', 'LTX', 'EC', -0.5425, -78.3657, 'Cotapaxi Intl Arpt', -5);
INSERT INTO public.airports VALUES (2066, 'Luderitz', 'LUD', 'NA', -26.6874, 15.2429, 'Luderitz Arpt', 1);
INSERT INTO public.airports VALUES (2067, 'Lugano', 'LUG', 'CH', 46.004276, 8.910578, 'Agno Airport', 1);
INSERT INTO public.airports VALUES (2068, 'Ludhiana', 'LUH', 'IN', 30.854681, 75.95259, 'Ludhiana Arpt', 5);
INSERT INTO public.airports VALUES (2069, 'Laurel', 'PIB', 'US', 31.4671, -89.3371, 'Hattiesburg Laurel Regional Arpt', -6);
INSERT INTO public.airports VALUES (2070, 'Laurel', 'LUL', 'US', 0, 0, 'Hesler Noble Field', -100);
INSERT INTO public.airports VALUES (2071, 'Lusaka', 'LUN', 'ZM', -15.330817, 28.452627, 'Lusaka Airport', 2);
INSERT INTO public.airports VALUES (2072, 'Kalaupapa', 'LUP', 'US', 21.211, -156.974, 'Kalaupapa Municipal', -10);
INSERT INTO public.airports VALUES (2073, 'San Luis', 'LUQ', 'AR', -33.273193, -66.35642, 'San Luis Cty Arpt', -3);
INSERT INTO public.airports VALUES (2074, 'Luxembourg', 'LUX', 'LU', 49.626575, 6.211517, 'Luxembourg Arpt', 1);
INSERT INTO public.airports VALUES (2075, 'Livingstone', 'LVI', 'ZM', -17.821756, 25.822693, 'Livingstone Arpt', 2);
INSERT INTO public.airports VALUES (2076, 'Livermore', 'LVK', 'US', 37.41362, -121.49133, 'Bron Airport', -8);
INSERT INTO public.airports VALUES (2077, 'Livingston', 'LVM', 'US', 45.69939, -110.4483, 'Mission Field', -7);
INSERT INTO public.airports VALUES (2078, 'Laverton', 'LVO', 'AU', -28.6136, 122.424, 'Laverton Airport', 8);
INSERT INTO public.airports VALUES (2079, 'Las Vegas', 'LVS', 'US', 35.65422, -105.14239, 'Las Vegas Arpt', -7);
INSERT INTO public.airports VALUES (2080, 'Las Vegas', 'TCC', 'US', 35.182777, -103.60319, 'Tucumcari Arpt', -7);
INSERT INTO public.airports VALUES (2081, 'Lewisburg', 'LWB', 'US', 37.858334, -80.399445, 'Greenbrier Valley Arpt', -5);
INSERT INTO public.airports VALUES (2082, 'Lawrence', 'LWC', 'US', 39.009167, -95.2175, 'Lawrence Municipal', -4);
INSERT INTO public.airports VALUES (2083, 'Lawrence', 'LWM', 'US', 42.717194, -71.12342, 'Lawrence Arpt', -4);
INSERT INTO public.airports VALUES (2084, 'Lvov', 'LWO', 'UA', 49.8125, 23.956112, 'Snilow Arpt', 2);
INSERT INTO public.airports VALUES (2085, 'Lewiston', 'LWS', 'US', 46.3745, -117.01539, 'Lewiston Nez Pierce Arpt', -8);
INSERT INTO public.airports VALUES (2086, 'Lewistown', 'LWT', 'US', 47.0493, -109.467, 'Lewistown Municipal', -7);
INSERT INTO public.airports VALUES (2087, 'Lawas', 'LWY', 'MY', 4.84917, 115.408, 'Lawas Arpt', 8);
INSERT INTO public.airports VALUES (2088, 'Lhasa', 'LXA', 'CN', 29.297777, 90.91194, 'Lhasa Arpt', 8);
INSERT INTO public.airports VALUES (2089, 'Lexington', 'LXN', 'US', 0, 0, 'Jim Kelley Field', -100);
INSERT INTO public.airports VALUES (2090, 'Luxor', 'LXR', 'EG', 25.671028, 32.70658, 'Luxor Airport', 2);
INSERT INTO public.airports VALUES (2091, 'Limnos', 'LXS', 'GR', 39.917072, 25.236307, 'Limnos Airport', 2);
INSERT INTO public.airports VALUES (2092, 'Sebha Airport', 'SEB', 'LY', 27.016666, 14.4625, 'Sebha Airport', 2);
INSERT INTO public.airports VALUES (2093, 'Luoyang', 'LYA', 'CN', 34.41, 112.28, 'Luoyang Arpt', 8);
INSERT INTO public.airports VALUES (2094, 'Little Cayman', 'LYB', 'KY', 19.659166, -80.090836, 'Little Cayman Arpt', -5);
INSERT INTO public.airports VALUES (2095, 'Lycksele', 'LYC', 'SE', 64.548325, 18.716219, 'Hedlunda Arpt', 1);
INSERT INTO public.airports VALUES (2096, 'Lianyungang', 'LYG', 'CN', 34.55, 119.25, 'Lianyungang Arpt', 8);
INSERT INTO public.airports VALUES (2097, 'Lynchburg', 'LYH', 'US', 37.3267, -79.2004, 'Lynchburg Municipal', -5);
INSERT INTO public.airports VALUES (2098, 'Linyi', 'LYI', 'CN', 35.0461, 118.412, 'Linyi Arpt', 8);
INSERT INTO public.airports VALUES (2099, 'Faisalabad', 'LYP', 'PK', 31.365013, 72.99484, 'Faisalabad International Arpt', 5);
INSERT INTO public.airports VALUES (2100, 'Longyearbyen', 'LYR', 'NO', 78.24611, 15.465556, 'Svalbard Arpt', 1);
INSERT INTO public.airports VALUES (2101, 'Lyon', 'LYS', 'FR', 45.726387, 5.090833, 'Lyon Saint Exupery Arpt', 1);
INSERT INTO public.airports VALUES (2102, 'Lyon', 'XYD', 'FR', 46, 5, 'Lyon Rail Station', 1);
INSERT INTO public.airports VALUES (2103, 'Lyon', 'LYN', 'FR', 45.727173, 4.944275, 'Bron Arpt', 1);
INSERT INTO public.airports VALUES (2104, 'Ely Mn', 'LYU', 'US', 47.824444, -91.83083, 'Ely Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2105, 'Lydd', 'LYX', 'GB', 50.956112, 0.939167, 'Lydd Intl Arpt', 0);
INSERT INTO public.airports VALUES (2106, 'Lazaro Cardenas Michoacan', 'LZC', 'MX', 18.001732, -102.22053, 'Lazaro Cardenas Arpt', -6);
INSERT INTO public.airports VALUES (2107, 'Liuzhou', 'LZH', 'CN', 24.2075, 109.391, 'Liuzhou Airport', 8);
INSERT INTO public.airports VALUES (2108, 'Luzhou', 'LZO', 'CN', 28.8522, 105.393, 'Luzhou Arpt', 8);
INSERT INTO public.airports VALUES (2109, 'Lizard Island', 'LZR', 'AU', -14.673056, 145.45444, 'Lizard Island Arpt', 10);
INSERT INTO public.airports VALUES (2110, 'Chennai', 'MAA', 'IN', 12.994414, 80.18052, 'Chennai Arpt', 5);
INSERT INTO public.airports VALUES (2111, 'Maraba', 'MAB', 'BR', -5.368589, -49.138023, 'Maraba Arpt', -3);
INSERT INTO public.airports VALUES (2112, 'Madrid', 'MAD', 'ES', 40.493557, -3.566764, 'Barajas Arpt', 1);
INSERT INTO public.airports VALUES (2113, 'Madera', 'MAE', 'US', 36.98861, -120.11244, 'Madera Municipal Arpt', -8);
INSERT INTO public.airports VALUES (2114, 'Midland', 'MAF', 'US', 31.942528, -102.20191, 'Midland Intl Arpt', -6);
INSERT INTO public.airports VALUES (2115, 'Madang', 'MAG', 'PG', -5.207083, 145.7887, 'Madang Arpt', 10);
INSERT INTO public.airports VALUES (2116, 'Menorca', 'MAH', 'ES', 39.8626, 4.218647, 'Aerop De Menorca', 1);
INSERT INTO public.airports VALUES (2117, 'Majuro', 'MAJ', 'MH', 7.064758, 171.27202, 'Amata Kabua Intl Arpt', 12);
INSERT INTO public.airports VALUES (2118, 'Malakal', 'MAK', 'SD', 9.558969, 31.652243, 'Malakal Arpt', 2);
INSERT INTO public.airports VALUES (2119, 'Matamoros', 'MAM', 'MX', 25.769894, -97.525314, 'Servando Canales Arpt', -6);
INSERT INTO public.airports VALUES (2120, 'Manchester', 'QQM', 'GB', 0, 0, 'Manchester - Piccadilly Rail Station', -100);
INSERT INTO public.airports VALUES (2121, 'Manchester', 'XVC', 'GB', 0, 0, 'Crewe Rail Station', -100);
INSERT INTO public.airports VALUES (2122, 'Manchester', 'MAN', 'GB', 53.353745, -2.27495, 'Manchester Intl', 0);
INSERT INTO public.airports VALUES (2123, 'Manaus', 'MAO', 'BR', -3.038611, -60.04972, 'Intl Arpt Eduardo Gomes', -4);
INSERT INTO public.airports VALUES (2124, 'Mae Sot', 'MAQ', 'TH', 16.699856, 98.54506, 'Mae Sot Arpt', 7);
INSERT INTO public.airports VALUES (2125, 'Maracaibo', 'MAR', 'VE', 10.558208, -71.72786, 'La Chinita Arpt', -4);
INSERT INTO public.airports VALUES (2126, 'Manus Island', 'MAS', 'PG', -2.06189, 147.424, 'Momote Arpt', 10);
INSERT INTO public.airports VALUES (2127, 'Mayaguez', 'MAZ', 'US', 18.255693, -67.148476, 'Eugenio M De Hostos Arpt', -4);
INSERT INTO public.airports VALUES (2128, 'Mombasa', 'MBA', 'KE', -4.034833, 39.59425, 'Moi Intl', 3);
INSERT INTO public.airports VALUES (2129, 'Mmabatho', 'MBD', 'ZA', -25.798445, 25.548029, 'Mmabatho International Arpt', 2);
INSERT INTO public.airports VALUES (2130, 'Maryborough', 'MBH', 'AU', -25.5133, 152.715, 'Maryborough Arpt', 10);
INSERT INTO public.airports VALUES (2131, 'Montego Bay', 'MBJ', 'JM', 18.503717, -77.91336, 'Sangster Arpt', -5);
INSERT INTO public.airports VALUES (2132, 'Manistee', 'MBL', 'US', 44.2725, -86.24694, 'Manistee Arpt', -5);
INSERT INTO public.airports VALUES (2133, 'Saginaw', 'MBS', 'US', 43.532913, -84.07964, 'Saginaw Arpt', -5);
INSERT INTO public.airports VALUES (2134, 'Masbate', 'MBT', 'PH', 12.3694, 123.629, 'Murfreesboro Municipal Arpt', 8);
INSERT INTO public.airports VALUES (2135, 'Moorabbin', 'MBW', 'AU', -37.975834, 145.10222, 'Moorabbin Arpt', 10);
INSERT INTO public.airports VALUES (2136, 'Maribor', 'MBX', 'SI', 46.479862, 15.686131, 'Maribor Arpt', 1);
INSERT INTO public.airports VALUES (2137, 'Merced', 'MCE', 'US', 37.28472, -120.513885, 'Merced Municipal Arpt', -8);
INSERT INTO public.airports VALUES (2138, 'McCook', 'MCK', 'US', 40.20639, -100.592224, 'McCook Municipal', -6);
INSERT INTO public.airports VALUES (2139, 'Monte Carlo', 'MCM', 'MC', 43.733334, 7.416667, 'Hel De Monte Carlo Airport', 1);
INSERT INTO public.airports VALUES (2140, 'Macon', 'MCN', 'US', 32.69285, -83.64921, 'Lewis B Wilson', -5);
INSERT INTO public.airports VALUES (2141, 'Macapa', 'MCP', 'BR', 0.050664, -51.072178, 'Macapa Intl Arpt', -3);
INSERT INTO public.airports VALUES (2142, 'Miskolc', 'MCQ', 'HU', 0, 0, 'Miskolc Arpt', -100);
INSERT INTO public.airports VALUES (2143, 'Muscat', 'MCT', 'OM', 23.593279, 58.284443, 'Seeb Intl', 4);
INSERT INTO public.airports VALUES (2144, 'Montlucon', 'MCU', 'FR', 46.352524, 2.570486, 'Gueret Arpt', 1);
INSERT INTO public.airports VALUES (2145, 'McArthur River', 'MCV', 'AU', -16.4425, 136.084, 'McArthur River Arpt', 9);
INSERT INTO public.airports VALUES (2146, 'Mason City', 'MCW', 'US', 43.2247, -93.4067, 'Mason City Municipal', -5);
INSERT INTO public.airports VALUES (2147, 'Makhachkala Airport', 'MCX', 'RU', 42.816822, 47.652294, 'Makhachkala Airport', 4);
INSERT INTO public.airports VALUES (2148, 'Maroochydore', 'MCY', 'AU', -26.603333, 153.09111, 'Maroochydore Arpt', 10);
INSERT INTO public.airports VALUES (2149, 'Maceio', 'MCZ', 'BR', -9.510808, -35.79168, 'Palmeres Airport', -3);
INSERT INTO public.airports VALUES (2150, 'Manado', 'MDC', 'ID', 1.549447, 124.92588, 'Samratulang Arpt', 8);
INSERT INTO public.airports VALUES (2151, 'Medellin', 'EOH', 'CO', 6.219958, -75.59052, 'Enrique Olaya Herrara', -5);
INSERT INTO public.airports VALUES (2152, 'Medellin', 'MDE', 'CO', 6.164536, -75.42312, 'Jose Marie Cordova', -5);
INSERT INTO public.airports VALUES (2153, 'Mudanjiang', 'MDG', 'CN', 44.523888, 129.5689, 'Mudanjiang Arpt', 8);
INSERT INTO public.airports VALUES (2154, 'Carbondale', 'MDH', 'US', 0, 0, 'Southern Illinois Arpt', -100);
INSERT INTO public.airports VALUES (2155, 'Makurdi', 'MDI', 'NG', 7.703883, 8.613939, 'Makurdi Arpt', 1);
INSERT INTO public.airports VALUES (2156, 'Mandalay', 'MDL', 'MM', 21.702156, 95.97793, 'Annisaton Arpt', 6);
INSERT INTO public.airports VALUES (2157, 'Mar Del Plata', 'MDQ', 'AR', -37.934166, -57.573334, 'Mar Del Plata Arpt', -3);
INSERT INTO public.airports VALUES (2158, 'Mendi', 'MDU', 'PG', -6.14774, 143.657, 'Mendi Arpt', 10);
INSERT INTO public.airports VALUES (2159, 'Midway Island', 'MDY', 'UM', 28.201725, -177.38063, 'Sand Island Field', -11);
INSERT INTO public.airports VALUES (2160, 'Mendoza', 'MDZ', 'AR', -32.83172, -68.792854, 'El Plumerillo Airport', -3);
INSERT INTO public.airports VALUES (2161, 'Macae', 'MEA', 'BR', -22.343, -41.766, 'Macae Arpt', -3);
INSERT INTO public.airports VALUES (2162, 'Manta', 'MEC', 'EC', -0.946078, -80.67881, 'Manta Arpt', -5);
INSERT INTO public.airports VALUES (2163, 'Madinah', 'MED', 'SA', 24.553423, 39.705063, 'Prince Mohammad Bin Abdulaziz Arpt', 3);
INSERT INTO public.airports VALUES (2164, 'Mehamn', 'MEH', 'NO', 71.029724, 27.826668, 'Mehamn Arpt', 1);
INSERT INTO public.airports VALUES (2165, 'Meridian', 'MEI', 'US', 32.332623, -88.75187, 'Key Field', -6);
INSERT INTO public.airports VALUES (2166, 'Melbourne', 'MEB', 'AU', -37.728058, 144.90195, 'Essendon Arpt', 10);
INSERT INTO public.airports VALUES (2167, 'Melbourne', 'AVV', 'AU', -38.039444, 144.46944, 'Avalon Arpt', 10);
INSERT INTO public.airports VALUES (2168, 'Melbourne', 'MEL', 'AU', -37.673332, 144.84334, 'Tullamarine Arpt', 10);
INSERT INTO public.airports VALUES (2169, 'Memphis', 'AWM', 'US', 0, 0, 'West Memphis Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2170, 'Memphis', 'NQA', 'US', 35.356667, -89.87028, 'Memphis Naval Air Station', -6);
INSERT INTO public.airports VALUES (2171, 'Memphis', 'MEM', 'US', 35.042416, -89.97667, 'Memphis Intl', -6);
INSERT INTO public.airports VALUES (2172, 'Manteo', 'MEO', 'US', 0, 0, 'Dare County Regional Arpt', -100);
INSERT INTO public.airports VALUES (2173, 'Medan', 'MES', 'ID', 3.558056, 98.67172, 'Polonia Arpt', 7);
INSERT INTO public.airports VALUES (2174, 'Monte Dourado', 'MEU', 'BR', -0.8894, -52.6017, 'Monte Dourado Arpt', -100);
INSERT INTO public.airports VALUES (2175, 'Minden', 'MEV', 'US', 0, 0, 'Douglas County Arpt', -100);
INSERT INTO public.airports VALUES (2176, 'Mexico City', 'MEX', 'MX', 19.436302, -99.0721, 'Benito Juarez Intl Airport', -6);
INSERT INTO public.airports VALUES (2177, 'Messina', 'MEZ', 'ZA', -25.704458, 26.908978, 'Messina Arpt', 2);
INSERT INTO public.airports VALUES (2178, 'Mansfield', 'MFD', 'US', 40.82142, -82.51664, 'Mansfield Municipal', -5);
INSERT INTO public.airports VALUES (2179, 'McAllen', 'MFE', 'US', 26.175833, -98.23861, 'Miller Intl', -6);
INSERT INTO public.airports VALUES (2180, 'Mesquite', 'MFH', 'US', 0, 0, 'Mesquite Arpt', -100);
INSERT INTO public.airports VALUES (2181, 'Marshfield', 'MFI', 'US', 0, 0, 'Marshfield Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2182, 'Matsu', 'MFK', 'TW', 26.224154, 120.00275, 'Matsu Arpt', 8);
INSERT INTO public.airports VALUES (2183, 'Macau', 'MFM', 'MO', 22.149555, 113.59156, 'Macau Arpt', 8);
INSERT INTO public.airports VALUES (2184, 'Milford Sound', 'MFN', 'NZ', -44.67333, 167.92332, 'Milford Sound Arpt', 12);
INSERT INTO public.airports VALUES (2185, 'Medford', 'MFR', 'US', 42.37423, -122.8735, 'Medford Jackson Cty', -8);
INSERT INTO public.airports VALUES (2186, 'Machu Picchu', 'MFT', 'PE', -13.1167, -72.5667, 'Machu Picchu Arpt', -5);
INSERT INTO public.airports VALUES (2187, 'Managua', 'MGA', 'NI', 12.141494, -86.168175, 'Augusto C Sandino', -6);
INSERT INTO public.airports VALUES (2188, 'Mt Gambier', 'MGB', 'AU', -37.7456, 140.785, 'Mount Gambier Arpt', 9);
INSERT INTO public.airports VALUES (2189, 'Michigan City', 'MGC', 'US', 41.7033, -86.8211, 'Michigan City Arpt', -5);
INSERT INTO public.airports VALUES (2190, 'Marietta', 'MGE', 'US', 33.915382, -84.51632, 'Dobbins Air Force Base', -5);
INSERT INTO public.airports VALUES (2191, 'Maringa', 'MGF', 'BR', -23.476393, -52.016407, 'Regional De Maringa Arpt', -3);
INSERT INTO public.airports VALUES (2192, 'Margate', 'MGH', 'ZA', -30.857409, 30.34302, 'Margate Arpt', 2);
INSERT INTO public.airports VALUES (2193, 'Montgomery', 'MGJ', 'US', 41.509987, -74.26464, 'Orange County Arpt', -4);
INSERT INTO public.airports VALUES (2194, 'Montgomery', 'MGM', 'US', 32.30064, -86.393974, 'Dannelly Field', -6);
INSERT INTO public.airports VALUES (2195, 'Mogadishu', 'MGQ', 'SO', 2.01444, 45.3047, 'Mogadishu International Airport', 3);
INSERT INTO public.airports VALUES (2196, 'Moultrie', 'MGR', 'US', 31.084917, -83.80325, 'Moultrie Arpt', -4);
INSERT INTO public.airports VALUES (2197, 'Margaret River Station', 'MGV', 'AU', 0, 0, 'Margaret River Station Arpt', -100);
INSERT INTO public.airports VALUES (2198, 'Morgantown', 'MGW', 'US', 39.642906, -79.91631, 'Morgantown Municipal', -5);
INSERT INTO public.airports VALUES (2199, 'Mashad', 'MHD', 'IR', 36, 59, 'Mashad Arpt', 3);
INSERT INTO public.airports VALUES (2200, 'Mitchell', 'MHE', 'US', 0, 0, 'Mitchell Municipal', -100);
INSERT INTO public.airports VALUES (2201, 'Mannheim Germany', 'MHG', 'DE', 49.472706, 8.514264, 'Mannheim Neuostheim', 1);
INSERT INTO public.airports VALUES (2202, 'Marsh Harbour', 'MHH', 'BS', 26.511406, -77.08347, 'Marsh Harbour Intl Arpt', -5);
INSERT INTO public.airports VALUES (2203, 'Manhattan', 'MHK', 'US', 39.140972, -96.67083, 'Manhattan Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2204, 'Mariehamn', 'MHQ', 'FI', 60.122204, 19.898155, 'Mariehamn Arpt', 1);
INSERT INTO public.airports VALUES (2205, 'Manchester', 'MHT', 'US', 42.932556, -71.43567, 'Manchester Arpt', -5);
INSERT INTO public.airports VALUES (2206, 'Mount Hotham', 'MHU', 'AU', -37.0475, 147.334, 'Mount Hotham Arpt', 10);
INSERT INTO public.airports VALUES (2207, 'Mojave', 'MHV', 'US', 35.059364, -118.151855, 'Kern County Arpt', -8);
INSERT INTO public.airports VALUES (2208, 'Mildenhall', 'MHZ', 'GB', 52.361935, 0.486406, 'Mildenhall Arpt', 0);
INSERT INTO public.airports VALUES (2209, 'Miami', 'OPF', 'US', 25.907, -80.27839, 'Opa Locka Arpt', -5);
INSERT INTO public.airports VALUES (2210, 'Miami', 'MIA', 'US', 25.79325, -80.29056, 'Miami Intl', -5);
INSERT INTO public.airports VALUES (2211, 'Miami', 'MPB', 'US', 25.7783, -80.1703, 'Mpb Seaplane Base', -5);
INSERT INTO public.airports VALUES (2212, 'Miami', 'TMB', 'US', 25.647888, -80.43278, 'Tamiami Airport', -5);
INSERT INTO public.airports VALUES (2213, 'Merida', 'MID', 'MX', 20.936981, -89.65767, 'Merida Intl', -6);
INSERT INTO public.airports VALUES (2214, 'Muncie', 'MIE', 'US', 40.242474, -85.39575, 'Johnson Field', -5);
INSERT INTO public.airports VALUES (2215, 'Mian Yang', 'MIG', 'CN', 31.4281, 104.741, 'Mian Yang Arpt', 8);
INSERT INTO public.airports VALUES (2216, 'Marilia', 'MII', 'BR', -22.196892, -49.9264, 'Dr Gastao Vidigal', -3);
INSERT INTO public.airports VALUES (2217, 'Mikkeli', 'MIK', 'FI', 61.6866, 27.201794, 'Mikkeli Aprt', 2);
INSERT INTO public.airports VALUES (2218, 'Milan', 'MXP', 'IT', 45.630608, 8.728111, 'Malpensa Arpt', 1);
INSERT INTO public.airports VALUES (2219, 'Milan', 'XIK', 'IT', 0, 0, 'Milan Central Station Railway', -100);
INSERT INTO public.airports VALUES (2220, 'Milan', 'SWK', 'IT', 0, 0, 'Segrate Arpt', -100);
INSERT INTO public.airports VALUES (2221, 'Milan', 'LIN', 'IT', 45.445103, 9.276739, 'Linate Arpt', 1);
INSERT INTO public.airports VALUES (2222, 'Merimbula', 'MIM', 'AU', -36.9086, 149.901, 'Merimbula Arpt', 10);
INSERT INTO public.airports VALUES (2223, 'Monastir', 'MIR', 'TN', 35.758057, 10.754722, 'Habib Bourguiba Intl', 1);
INSERT INTO public.airports VALUES (2224, 'Millville', 'MIV', 'US', 39.367805, -75.07222, 'Millville Arpt', -5);
INSERT INTO public.airports VALUES (2225, 'Marshalltown', 'MIW', 'US', 0, 0, 'Marshalltown Municipal', -100);
INSERT INTO public.airports VALUES (2226, 'Mohenjodaro', 'MJD', 'PK', 27.335155, 68.14305, 'Mohenjodaro Arpt', 5);
INSERT INTO public.airports VALUES (2227, 'Mosjoen', 'MJF', 'NO', 65.784, 13.214914, 'Kjaerstad Arpt', 1);
INSERT INTO public.airports VALUES (2228, 'Maji', 'MJI', 'LY', 32.8941, 13.276, 'MITIGA', 1);
INSERT INTO public.airports VALUES (2229, 'Monkey Mia', 'MJK', 'AU', -25.8939, 113.5772, 'Shark Bay Arpt', -100);
INSERT INTO public.airports VALUES (2230, 'Majunga', 'MJN', 'MG', -15.667144, 46.35183, 'Amborovy Arpt', 3);
INSERT INTO public.airports VALUES (2231, 'Miramar', 'MJR', 'AR', 0, 0, 'Miramar Arpt', -100);
INSERT INTO public.airports VALUES (2232, 'Mytilene', 'MJT', 'GR', 39.056667, 26.598333, 'Mytilene Arpt', 2);
INSERT INTO public.airports VALUES (2233, 'Mamuju', 'MJU', 'ID', -2.5, 118.833336, 'Mamuju Arpt', 9);
INSERT INTO public.airports VALUES (2234, 'Murcia', 'MJV', 'ES', 37.77497, -0.812389, 'San Javier Airport', 1);
INSERT INTO public.airports VALUES (2235, 'Mahenye', 'MJW', 'ZW', 0, 0, 'Mahenye Airfield', -100);
INSERT INTO public.airports VALUES (2236, 'Mirnyj', 'MJZ', 'RU', 62.53469, 114.038925, 'Mirnyj Arpt', 10);
INSERT INTO public.airports VALUES (2237, 'Marianske Lazne', 'MKA', 'CZ', 0, 0, 'Marianske Lazne Arpt', -100);
INSERT INTO public.airports VALUES (2238, 'Kansas City', 'MCI', 'US', 39.297607, -94.713905, 'Kansas City Intl', -6);
INSERT INTO public.airports VALUES (2239, 'Kansas City', 'JCI', 'US', 38.830917, -94.890305, 'Johnson Industrial Arpt', -6);
INSERT INTO public.airports VALUES (2240, 'Kansas City', 'MKC', 'US', 39.1275, -94.59889, 'Kansas City Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2241, 'Milwaukee', 'MKE', 'US', 42.947224, -87.89658, 'General Mitchell Intl Arpt', -6);
INSERT INTO public.airports VALUES (2242, 'Muskegon', 'MKG', 'US', 43.1695, -86.2382, 'Muskegon Cty Intl', -5);
INSERT INTO public.airports VALUES (2243, 'Hoolehua', 'MKK', 'US', 21.152885, -157.09625, 'Molokai Arpt', -10);
INSERT INTO public.airports VALUES (2244, 'Jackson', 'MKL', 'US', 35.599888, -88.91561, 'McKellar Fld', -6);
INSERT INTO public.airports VALUES (2245, 'Mukah', 'MKM', 'MY', 2.90639, 112.08, 'Mukah Arpt', 8);
INSERT INTO public.airports VALUES (2246, 'Muskogee', 'MKO', 'US', 35.65649, -95.36665, 'Davis Field', -6);
INSERT INTO public.airports VALUES (2247, 'Meekathara', 'MKR', 'AU', -26.6117, 118.548, 'Meekatharra Arpt', 8);
INSERT INTO public.airports VALUES (2248, 'Mankato', 'MKT', 'US', 0, 0, 'Mankato Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2249, 'Manokwari', 'MKW', 'ID', -0.891833, 134.04918, 'Rendani Arpt', 9);
INSERT INTO public.airports VALUES (2250, 'Mukalla', 'MKX', 'YE', 0, 0, 'Mukalla Arpt', -100);
INSERT INTO public.airports VALUES (2251, 'Mackay', 'MKY', 'AU', -21.171667, 149.17972, 'Mackay Arpt', 10);
INSERT INTO public.airports VALUES (2252, 'Malacca', 'MKZ', 'MY', 2.263361, 102.25156, 'Batu Berendum Arpt', 8);
INSERT INTO public.airports VALUES (2253, 'Malta', 'MLA', 'MT', 35.8575, 14.4775, 'Luqa Airport', 1);
INSERT INTO public.airports VALUES (2254, 'Melbourne', 'MLB', 'US', 28.102753, -80.645256, 'Melbourne Regional', -5);
INSERT INTO public.airports VALUES (2255, 'McAlester', 'MLC', 'US', 34.882404, -95.78346, 'McAlester Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2256, 'Male', 'MLE', 'MV', 4.191833, 73.52913, 'Male Intl Arpt', 5);
INSERT INTO public.airports VALUES (2257, 'Malang', 'MLG', 'ID', -7.926556, 112.714516, 'Malang Arpt', 7);
INSERT INTO public.airports VALUES (2258, 'Moline', 'MLI', 'US', 41.44853, -90.50754, 'Quad City Arpt', -6);
INSERT INTO public.airports VALUES (2259, 'Morelia', 'MLM', 'MX', 19.849943, -101.0255, 'Michoacan Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2260, 'Melilla', 'MLN', 'ES', 35.279816, -2.956256, 'Melilla Arpt', 0);
INSERT INTO public.airports VALUES (2261, 'Milos', 'MLO', 'GR', 36.69611, 24.4775, 'Milos Arpt', 2);
INSERT INTO public.airports VALUES (2262, 'Miles City', 'MLS', 'US', 46.428, -105.886, 'Miles City Municipal Arpt', -7);
INSERT INTO public.airports VALUES (2263, 'Millinocket', 'MLT', 'US', 45.647835, -68.68556, 'Millinocket Arpt', -5);
INSERT INTO public.airports VALUES (2264, 'Monroe', 'MLU', 'US', 32.510864, -92.03769, 'Monroe Regional', -6);
INSERT INTO public.airports VALUES (2265, 'Monrovia', 'ROB', 'LR', 6.233789, -10.362311, 'Roberts Intl', 0);
INSERT INTO public.airports VALUES (2266, 'Monrovia', 'MLW', 'LR', 6.289061, -10.758722, 'Sprigg Payne Arpt', 0);
INSERT INTO public.airports VALUES (2267, 'Malatya', 'MLX', 'TR', 38.43535, 38.091007, 'Malatya Arpt', 2);
INSERT INTO public.airports VALUES (2268, 'Melo', 'MLZ', 'UY', -32.3425, -54.2219, 'Melo Arpt', -100);
INSERT INTO public.airports VALUES (2269, 'Malmo', 'XFP', 'SE', 0, 0, 'Malmo Railway Service', -100);
INSERT INTO public.airports VALUES (2270, 'Malmo', 'XFR', 'SE', 0, 0, 'Malmo South Railway Service', -100);
INSERT INTO public.airports VALUES (2271, 'Malmo', 'MMA', 'SE', 0, 0, 'Malmo Metropolitan Area Arpt', -100);
INSERT INTO public.airports VALUES (2272, 'Malmo', 'MMX', 'SE', 55.530193, 13.371639, 'Sturup Arpt', 1);
INSERT INTO public.airports VALUES (2273, 'Memambetsu', 'MMB', 'JP', 43.880608, 144.16405, 'Memanbetsu Arpt', 9);
INSERT INTO public.airports VALUES (2274, 'Ciudad Mante', 'MMC', 'MX', 0, 0, 'Ciudad Mante Arpt', -100);
INSERT INTO public.airports VALUES (2275, 'Teesside', 'MME', 'GB', 54.50919, -1.429406, 'Durham Tees Valley Arpt', 0);
INSERT INTO public.airports VALUES (2276, 'Teesside', 'XVG', 'GB', 0, 0, 'Darlington Rail Station', -100);
INSERT INTO public.airports VALUES (2277, 'Teesside', 'XNO', 'GB', 0, 0, 'Northallerton Rail Station', -100);
INSERT INTO public.airports VALUES (2278, 'Mount Magnet', 'MMG', 'AU', -28.1161, 117.842, 'Mount Magnet Arpt', 8);
INSERT INTO public.airports VALUES (2279, 'Mammoth Lakes', 'MMH', 'US', 37.62405, -118.83777, 'Mammoth Lakes Municipal', -8);
INSERT INTO public.airports VALUES (2280, 'Athens', 'MMI', 'US', 35.39919, -84.56177, 'McMinn County Arpt', -5);
INSERT INTO public.airports VALUES (2281, 'Matsumoto', 'MMJ', 'JP', 36.16676, 137.92267, 'Matsumoto Arpt', 9);
INSERT INTO public.airports VALUES (2282, 'Murmansk', 'MMK', 'RU', 68.78167, 32.75082, 'Murmansk Arpt', 4);
INSERT INTO public.airports VALUES (2283, 'Marshall', 'MML', 'US', 0, 0, 'Marshall Municipal', -100);
INSERT INTO public.airports VALUES (2284, 'Middlemount', 'MMM', 'AU', -22.8025, 148.7047, 'Middlemount Arpt', -100);
INSERT INTO public.airports VALUES (2285, 'Maio', 'MMO', 'CV', 15.155928, -23.213703, 'Vila Do Maio Arpt', -1);
INSERT INTO public.airports VALUES (2286, 'Morristown', 'MMU', 'US', 40.79935, -74.41487, 'Morristown Arpt', -5);
INSERT INTO public.airports VALUES (2287, 'Miyako Jima', 'MMY', 'JP', 24.782833, 125.29511, 'Hirara Arpt', 9);
INSERT INTO public.airports VALUES (2288, 'Montserrat', 'MNI', 'DM', 16.79139, -62.193333, 'Bramble Arpt', 1);
INSERT INTO public.airports VALUES (2289, 'Maiana', 'MNK', 'KI', 0.933333, 173, 'Maiana Airport', 10);
INSERT INTO public.airports VALUES (2290, 'Manila', 'MNL', 'PH', 14.508647, 121.019585, 'Ninoy Aquino Intl', 8);
INSERT INTO public.airports VALUES (2291, 'Menominee', 'MNM', 'US', 45.12665, -87.63844, 'Menominee County', -5);
INSERT INTO public.airports VALUES (2292, 'Manono', 'MNO', 'CD', 0, 0, 'Manono Arpt', -100);
INSERT INTO public.airports VALUES (2293, 'Monto', 'MNQ', 'AU', -24.8917, 151.1083, 'Monto Arpt', -100);
INSERT INTO public.airports VALUES (2294, 'Manassas', 'MNZ', 'US', 0, 0, 'Manassas Arpt', -100);
INSERT INTO public.airports VALUES (2295, 'Manassas', 'EZF', 'US', 0, 0, 'Shannon Airport', -100);
INSERT INTO public.airports VALUES (2296, 'Mobile', 'MOB', 'US', 30.69123, -88.24281, 'Mobile Municipal', -6);
INSERT INTO public.airports VALUES (2297, 'Montes Claros', 'MOC', 'BR', -16.706924, -43.8189, 'Montes Claros Arpt', -3);
INSERT INTO public.airports VALUES (2298, 'Modesto', 'MOD', 'US', 37.625816, -120.95442, 'Harry Sham Fld', -8);
INSERT INTO public.airports VALUES (2299, 'Mitiaro Island', 'MOI', 'CK', -19.8425, -157.703, 'Mitiaro Island Arpt', -10);
INSERT INTO public.airports VALUES (2300, 'Molde', 'MOL', 'NO', 62.74472, 7.2625, 'Aro Arpt', 1);
INSERT INTO public.airports VALUES (2301, 'Mount Cook', 'MON', 'NZ', -43.906666, 170.12833, 'Mount Cook Arpt', 12);
INSERT INTO public.airports VALUES (2302, 'Mount Pleasant', 'MOP', 'US', 0, 0, 'Mt Pleasant Municipal', -100);
INSERT INTO public.airports VALUES (2303, 'Morondava', 'MOQ', 'MG', -20.28475, 44.317616, 'Morondava Arpt', 3);
INSERT INTO public.airports VALUES (2304, 'Minot', 'MOT', 'US', 48.259377, -101.280334, 'Minot Intl', -6);
INSERT INTO public.airports VALUES (2305, 'Mountain Village', 'MOU', 'US', 62.0954, -163.682, 'Mountain Village Arpt', -9);
INSERT INTO public.airports VALUES (2306, 'Moranbah', 'MOV', 'AU', -22.0578, 148.077, 'Moranbah Arpt', 10);
INSERT INTO public.airports VALUES (2307, 'Moscow', 'DME', 'RU', 55.40861, 37.906113, 'Domodedovo Arpt', 4);
INSERT INTO public.airports VALUES (2308, 'Moscow', 'VKO', 'RU', 55.59153, 37.261486, 'Vnukovo Arpt', 4);
INSERT INTO public.airports VALUES (2309, 'Moscow', 'SVO', 'RU', 55.97264, 37.41459, 'Sheremetyevo Arpt', 4);
INSERT INTO public.airports VALUES (2310, 'Moorea', 'MOZ', 'PF', -17.489971, -149.76187, 'Temae Airport', -10);
INSERT INTO public.airports VALUES (2311, 'Mpache', 'MPA', 'NA', -17.6344, 24.1767, 'Mpacha Aerodrome', 1);
INSERT INTO public.airports VALUES (2312, 'Caticlan', 'MPH', 'PH', 11.9215, 121.953, 'Malay Arpt', 8);
INSERT INTO public.airports VALUES (2313, 'Mokpo', 'MPK', 'KR', 34.758907, 126.379875, 'Mokpo Arpt', 9);
INSERT INTO public.airports VALUES (2314, 'Montpellier', 'MPL', 'FR', 43.576195, 3.963014, 'Frejorgues Arpt', 1);
INSERT INTO public.airports VALUES (2315, 'Maputo', 'MPM', 'MZ', -25.920835, 32.572605, 'Maputo Intl', 2);
INSERT INTO public.airports VALUES (2316, 'Mount Pleasant', 'MPN', 'FK', -51.822777, -58.447224, 'Mount Pleasant Arpt', -4);
INSERT INTO public.airports VALUES (2317, 'Maan', 'MPQ', 'JO', 0, 0, 'Maan Arpt', -100);
INSERT INTO public.airports VALUES (2318, 'McPherson', 'MPR', 'US', 0, 0, 'McPherson Arpt', -100);
INSERT INTO public.airports VALUES (2319, 'Montpelier', 'MPV', 'US', 44.203503, -72.562325, 'E F Knapp Arpt', -5);
INSERT INTO public.airports VALUES (2320, 'Mariupol', 'MPW', 'UA', 47.0761, 37.4496, 'Mariupol Arpt', 2);
INSERT INTO public.airports VALUES (2321, 'Magnitogorsk', 'MQF', 'RU', 53.39313, 58.75566, 'Magnitogorsk Arpt', 6);
INSERT INTO public.airports VALUES (2322, 'San Matias', 'MQK', 'BO', 0, 0, 'San Matias Arpt', -100);
INSERT INTO public.airports VALUES (2323, 'Mildura', 'MQL', 'AU', -34.2292, 142.086, 'Mildura Arpt', 10);
INSERT INTO public.airports VALUES (2324, 'Mardin', 'MQM', 'TR', 37.2233, 40.6317, 'Mardin Arpt', 2);
INSERT INTO public.airports VALUES (2325, 'Mo I Rana', 'MQN', 'NO', 66.3639, 14.3014, 'Rossvoll', 1);
INSERT INTO public.airports VALUES (2326, 'Mustique', 'MQS', 'DM', 12.887947, -61.18016, 'Mustique Arpt', -4);
INSERT INTO public.airports VALUES (2327, 'Marquette', 'MQT', 'US', 46.35361, -87.39528, 'Sawyer Intl Airport', -5);
INSERT INTO public.airports VALUES (2328, 'Smyrna', 'MQY', 'US', 36.009, -86.52, 'Smyrna Arpt', -100);
INSERT INTO public.airports VALUES (2329, 'Margaret River', 'MQZ', 'AU', -33.93, 115.1, 'Margaret River Arpt', -100);
INSERT INTO public.airports VALUES (2330, 'Misurata', 'MRA', 'LB', 32.325, 15.061, 'Misurata', 1);
INSERT INTO public.airports VALUES (2331, 'Martinsburg', 'MRB', 'US', 39.2407, -77.591, 'Martinsburgh Regional Arpt', -5);
INSERT INTO public.airports VALUES (2332, 'Columbia', 'MRC', 'US', 0, 0, 'Maury Country Arpt', -100);
INSERT INTO public.airports VALUES (2333, 'Merida', 'MRD', 'VE', 8.582294, -71.16119, 'Alberto Carnevalli Arpt', -4);
INSERT INTO public.airports VALUES (2334, 'Mara Lodges', 'MRE', 'KE', -1.406111, 35.008057, 'Mara Lodges Arpt', 3);
INSERT INTO public.airports VALUES (2335, 'Masterton', 'MRO', 'NZ', -40.97333, 175.6336, 'Masterton Arpt', 12);
INSERT INTO public.airports VALUES (2336, 'Marseille', 'XRF', 'FR', 47.0667, 3, 'Marseille Rail Station', -100);
INSERT INTO public.airports VALUES (2337, 'Marseille', 'MRS', 'FR', 43.435555, 5.213611, 'Marseille Provence Arpt', 1);
INSERT INTO public.airports VALUES (2338, 'Mauritius', 'MRU', 'MU', -20.430235, 57.6836, 'Plaisance Arptt', 5);
INSERT INTO public.airports VALUES (2339, 'Mineralnye Vody', 'MRV', 'RU', 44.22507, 43.08189, 'Mineralnye Vody Arpt', 4);
INSERT INTO public.airports VALUES (2340, 'Mahshahr Airport', 'MRX', 'IR', 30.556192, 49.15188, 'Mahshahr Airport', 4);
INSERT INTO public.airports VALUES (2341, 'Monterey', 'MRY', 'US', 36.587, -121.84294, 'Monterey Peninsula', -8);
INSERT INTO public.airports VALUES (2342, 'Moree', 'MRZ', 'AU', -29.4989, 149.845, 'Moree Arpt', 10);
INSERT INTO public.airports VALUES (2343, 'Marigot St Martin', 'MSB', 'GP', 0, 0, 'Marigot Seaplane Base', -100);
INSERT INTO public.airports VALUES (2344, 'Mesa', 'MSC', 'US', 0, 0, 'Falcon Field', -100);
INSERT INTO public.airports VALUES (2345, 'Manston', 'MSE', 'GB', 51.34222, 1.346111, 'Kent International Arpt', 0);
INSERT INTO public.airports VALUES (2346, 'Misawa', 'MSJ', 'JP', 40.70322, 141.36836, 'Misawa Arpt', 9);
INSERT INTO public.airports VALUES (2347, 'Muscle Shoals', 'MSL', 'US', 34.7453, -87.6102, 'Muscle Shoals Arpt', -6);
INSERT INTO public.airports VALUES (2348, 'Madison', 'MSN', 'US', 43.13986, -89.33752, 'Dane County Regional', -6);
INSERT INTO public.airports VALUES (2349, 'Missoula', 'MSO', 'US', 46.916306, -114.09055, 'Missoula Intl', -7);
INSERT INTO public.airports VALUES (2350, 'Minneapolis', 'MIC', 'US', 0, 0, 'Crystal Arpt', -100);
INSERT INTO public.airports VALUES (2351, 'Minneapolis', 'FCM', 'US', 0, 0, 'Flying Cloud Arpt', -100);
INSERT INTO public.airports VALUES (2352, 'Minneapolis', 'MSP', 'US', 44.881954, -93.22176, 'Minneapolis St Paul Intl', -6);
INSERT INTO public.airports VALUES (2353, 'Minsk', 'MHP', 'BY', 53.86447, 27.539682, 'Minsk Intl 1', 2);
INSERT INTO public.airports VALUES (2354, 'Minsk', 'MSQ', 'BY', 53.88247, 28.030731, 'Minsk Intl 2', 2);
INSERT INTO public.airports VALUES (2355, 'Mus Tr', 'MSR', 'TR', 38.74777, 41.661236, 'Mus Arpt', 2);
INSERT INTO public.airports VALUES (2356, 'Massena', 'MSS', 'US', 44.935833, -74.84555, 'Richards Field', -5);
INSERT INTO public.airports VALUES (2357, 'Maastricht', 'MST', 'NL', 50.91166, 5.770144, 'Maastricht Aachen Arpt', 1);
INSERT INTO public.airports VALUES (2358, 'Maastricht', 'ZYT', 'NL', 0, 0, 'Maastricht Rail Station', -100);
INSERT INTO public.airports VALUES (2359, 'Maseru', 'MSU', 'LS', -29.462255, 27.552504, 'Moshoeshoe Intl Arpt', 2);
INSERT INTO public.airports VALUES (2360, 'Monticello', 'MSV', 'US', 0, 0, 'Catskills Sulivan', -100);
INSERT INTO public.airports VALUES (2361, 'New Orleans', 'MSY', 'US', 29.99339, -90.258026, 'Louis Armstrong Intl Arpt', -6);
INSERT INTO public.airports VALUES (2362, 'New Orleans', 'NEW', 'US', 30.0424, -90.0283, 'New Lakefront Arpt', -100);
INSERT INTO public.airports VALUES (2363, 'Marathon', 'MTH', 'US', 24.72611, -81.05139, 'Marathon Arpt', -5);
INSERT INTO public.airports VALUES (2364, 'Montrose', 'MTJ', 'US', 38.509792, -107.89424, 'Montrose County', -7);
INSERT INTO public.airports VALUES (2365, 'Maitland', 'MTL', 'AU', -32.7033, 151.488, 'Maitland Airport', 10);
INSERT INTO public.airports VALUES (2366, 'Mattoon', 'MTO', 'US', 0, 0, 'Coles County', -100);
INSERT INTO public.airports VALUES (2367, 'Montauk', 'MTP', 'US', 41.0765, -71.9208, 'Sky Portal Arpt', -100);
INSERT INTO public.airports VALUES (2368, 'Monteria', 'MTR', 'CO', 8.823744, -75.82583, 'S Jeronimo Arpt', -5);
INSERT INTO public.airports VALUES (2369, 'Manzini', 'MTS', 'SZ', -26.529022, 31.30752, 'Matsapha Intl Arpt', 2);
INSERT INTO public.airports VALUES (2370, 'Minatitlan', 'MTT', 'MX', 18.103418, -94.58068, 'Minatitlan Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2371, 'Manitowoc', 'MTW', 'US', 0, 0, 'Manitowoc Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2372, 'Monterrey', 'MTY', 'MX', 25.778488, -100.10688, 'Escobedo Arpt', -6);
INSERT INTO public.airports VALUES (2373, 'Monterrey', 'NTR', 'MX', 25.865572, -100.237236, 'Aeropuerto Del Norte', -6);
INSERT INTO public.airports VALUES (2374, 'Munda', 'MUA', 'SB', -8.32797, 157.263, 'Munda Arpt', 11);
INSERT INTO public.airports VALUES (2375, 'Maun', 'MUB', 'BW', -19.972565, 23.431086, 'Maun Arpt', 2);
INSERT INTO public.airports VALUES (2376, 'Munich', 'ZMU', 'DE', 48.1408, 11.555, 'Munich HBF Railway Service', 1);
INSERT INTO public.airports VALUES (2377, 'Munich', 'MUC', 'DE', 48.353783, 11.786086, 'Munich Intl Arpt', 1);
INSERT INTO public.airports VALUES (2378, 'Kamuela', 'MUE', 'US', 20.001328, -155.6681, 'Waimea Arpt', -10);
INSERT INTO public.airports VALUES (2379, 'Maturin', 'MUN', 'VE', 9.749067, -63.1534, 'Quiriquire Arpt', -4);
INSERT INTO public.airports VALUES (2380, 'Mountain Home', 'MUO', 'US', 43.043602, -115.87243, 'Mountain Home AFB', -7);
INSERT INTO public.airports VALUES (2381, 'Marudi', 'MUR', 'MY', 4.1775, 114.321945, 'Marudi Arpt', 8);
INSERT INTO public.airports VALUES (2382, 'Multan', 'MUX', 'PK', 30.203222, 71.41911, 'Multan Arpt', 5);
INSERT INTO public.airports VALUES (2383, 'Musoma', 'MUZ', 'TZ', -1.483, 33.8, 'Musoma Arpt', 3);
INSERT INTO public.airports VALUES (2384, 'Franceville Mvengue', 'MVB', 'GA', -1.656156, 13.438036, 'Franceville Mvengue Arpt', 1);
INSERT INTO public.airports VALUES (2385, 'Monroeville', 'MVC', 'US', 0, 0, 'Monroe County Arpt', -100);
INSERT INTO public.airports VALUES (2386, 'Montevideo', 'MVD', 'UY', -34.838417, -56.030807, 'Carrasco Arpt', -3);
INSERT INTO public.airports VALUES (2387, 'Mossoro', 'MVF', 'BR', -5.20192, -37.3643, 'Dixsept Rosado Arpt', -3);
INSERT INTO public.airports VALUES (2388, 'Mt Vernon', 'MVN', 'US', 0, 0, 'Mt Vernon Outland Arpt', -100);
INSERT INTO public.airports VALUES (2389, 'Mogilev', 'MVQ', 'BY', 53.9549, 30.0951, 'Mogilev Arpt', 2);
INSERT INTO public.airports VALUES (2390, 'Maroua', 'MVR', 'CM', 10.451392, 14.257361, 'Salam Arpt', 1);
INSERT INTO public.airports VALUES (2391, 'Megeve', 'MVV', 'FR', 45.8208, 6.65222, 'Megeve Arpt', 1);
INSERT INTO public.airports VALUES (2392, 'Martha S Vineyard', 'MVY', 'US', 41.391666, -70.61528, 'Dukes County', -5);
INSERT INTO public.airports VALUES (2393, 'Masvingo', 'MVZ', 'ZW', -20.055332, 30.859112, 'Ft Victoria Arpt', 2);
INSERT INTO public.airports VALUES (2394, 'Marion', 'MWA', 'US', 37.754955, -89.01109, 'Williamson County', -5);
INSERT INTO public.airports VALUES (2395, 'Moses Lake', 'MWH', 'US', 47.207706, -119.32019, 'Grant County', -8);
INSERT INTO public.airports VALUES (2396, 'Middletown', 'MWO', 'US', 0, 0, 'Hook Field', -100);
INSERT INTO public.airports VALUES (2397, 'Mwanza', 'MWZ', 'TZ', -2.444486, 32.932667, 'Mwanza Arpt', 3);
INSERT INTO public.airports VALUES (2398, 'Monticello', 'MXC', 'US', 0, 0, 'San Juan County Arpt', -100);
INSERT INTO public.airports VALUES (2399, 'Mexicali', 'MXL', 'MX', 32.630634, -115.24164, 'Rodolfg Sachez Taboada', -8);
INSERT INTO public.airports VALUES (2400, 'Morlaix', 'MXN', 'FR', 48.60322, -3.815783, 'Morlaix Arpt', 1);
INSERT INTO public.airports VALUES (2401, 'Maota', 'MXS', 'WS', -13.733, -172.3, 'Maota Arpt', -11);
INSERT INTO public.airports VALUES (2402, 'Mora', 'MXX', 'SE', 60.95791, 14.511383, 'Mora Arpt', 1);
INSERT INTO public.airports VALUES (2403, 'Mccarthy', 'MXY', 'US', 61.43706, -142.90308, 'McCarthy Arpt', -8);
INSERT INTO public.airports VALUES (2404, 'Meixian', 'MXZ', 'CN', 24.35, 116.133, 'Meixian Arpt', 8);
INSERT INTO public.airports VALUES (2405, 'Moruya', 'MYA', 'AU', -35.8978, 150.144, 'Moruya Arpt', 10);
INSERT INTO public.airports VALUES (2406, 'Maracay', 'MYC', 'VE', 10.249978, -67.64942, 'Maracay Arpt', -4);
INSERT INTO public.airports VALUES (2407, 'Malindi', 'MYD', 'KE', -3.22931, 40.1017, 'Malindi Arpt', 3);
INSERT INTO public.airports VALUES (2408, 'Matsuyama', 'MYJ', 'JP', 33.82722, 132.69972, 'Matsuyama Airport', 9);
INSERT INTO public.airports VALUES (2409, 'Mccall', 'MYL', 'US', 44.88972, -116.10139, 'Mccall Arpt', -7);
INSERT INTO public.airports VALUES (2410, 'Mysore', 'MYQ', 'IN', 12.3072, 76.6497, 'Mysore Arpt', 5);
INSERT INTO public.airports VALUES (2411, 'Myrtle Beach', 'MYR', 'US', 33.67975, -78.92833, 'Myrtle Beach Jetway', -5);
INSERT INTO public.airports VALUES (2412, 'Myrtle Beach', 'CRE', 'US', 33.8118, -78.7239, 'Grand Strand Arpt', -100);
INSERT INTO public.airports VALUES (2413, 'Myrtle Beach', 'GGE', 'US', 0, 0, 'George Town Arpt', -100);
INSERT INTO public.airports VALUES (2414, 'Marysville', 'MYV', 'US', 39.0553, -121.3411, 'Yuba County Arpt', -8);
INSERT INTO public.airports VALUES (2415, 'Mtwara', 'MYW', 'TZ', -10.339058, 40.18178, 'Mtwara Arpt', 2);
INSERT INTO public.airports VALUES (2416, 'Miri', 'MYY', 'MY', 4.322014, 113.98681, 'Miri Arpt', 8);
INSERT INTO public.airports VALUES (2417, 'Makung', 'MZG', 'TW', 23.568668, 119.62831, 'Makung Arpt', 8);
INSERT INTO public.airports VALUES (2418, 'Merzifon', 'MZH', 'TR', 40.829376, 35.52199, 'Merzifon Airport', 2);
INSERT INTO public.airports VALUES (2419, 'Mopti', 'MZI', 'ML', 14.512803, -4.079561, 'Mopti Arpt', 0);
INSERT INTO public.airports VALUES (2420, 'Manizales', 'MZL', 'CO', 5.029597, -75.46471, 'Santaguida Arpt', -5);
INSERT INTO public.airports VALUES (2421, 'Metz', 'MZM', 'FR', 49.071667, 6.131667, 'Frescaty Airport', 1);
INSERT INTO public.airports VALUES (2422, 'Manzanillo', 'MZO', 'CU', 20.288172, -77.0893, 'Sierra Maestra Arpt', -5);
INSERT INTO public.airports VALUES (2423, 'Mazar I Sharif', 'MZR', 'AF', 36.706913, 67.20968, 'Mazar I Sharif Arpt', 5);
INSERT INTO public.airports VALUES (2424, 'Mazatlan', 'MZT', 'MX', 23.161356, -106.266075, 'Buelina Arpt', -7);
INSERT INTO public.airports VALUES (2425, 'Mulu', 'MZV', 'MY', 4.048333, 114.805, 'Mulu Arpt', 8);
INSERT INTO public.airports VALUES (2426, 'Narrabri', 'NAA', 'AU', -30.3192, 149.827, 'Narrabri Arpt', 10);
INSERT INTO public.airports VALUES (2427, 'Naracoorte', 'NAC', 'AU', 0, 0, 'Naracoorte Arpt', -100);
INSERT INTO public.airports VALUES (2428, 'Nagpur', 'NAG', 'IN', 21.092192, 79.04718, 'Dr Ambedkar Intl Arpt', 5);
INSERT INTO public.airports VALUES (2429, 'Nakhichevan', 'NAJ', 'AZ', 39.1888, 45.4584, 'Nakhichevan', 3);
INSERT INTO public.airports VALUES (2430, 'Nakhon Ratchasima', 'NAK', 'TH', 14.949497, 102.31274, 'Nakhon Ratchasima Arpt', 7);
INSERT INTO public.airports VALUES (2431, 'Nalchik', 'NAL', 'RU', 43.5129, 43.6366, 'Nalchik Arpt', 4);
INSERT INTO public.airports VALUES (2432, 'Namlea', 'NAM', 'ID', 0, 0, 'Namlea Arpt', -100);
INSERT INTO public.airports VALUES (2433, 'Nadi', 'NAN', 'FJ', -17.755392, 177.44337, 'Nadi Intl', 12);
INSERT INTO public.airports VALUES (2434, 'Nanchong', 'NAO', 'CN', 30.754, 106.062, 'Nanchong Arpt', 8);
INSERT INTO public.airports VALUES (2435, 'Naples', 'NAP', 'IT', 40.886032, 14.290781, 'Capodichino Arpt', 1);
INSERT INTO public.airports VALUES (2436, 'Nare', 'NAR', 'CO', 0, 0, 'Nare Arpt', -100);
INSERT INTO public.airports VALUES (2437, 'Nassau', 'WZY', 'BS', 25.0872, -77.3239, 'Seaplane Base Arpt', -5);
INSERT INTO public.airports VALUES (2438, 'Nassau', 'PID', 'BS', 25.083, -77.3, 'Paradise Island Arpt', -5);
INSERT INTO public.airports VALUES (2439, 'Nassau', 'NAS', 'BS', 25.038958, -77.46623, 'Nassau Intl', -5);
INSERT INTO public.airports VALUES (2440, 'Natal', 'NAT', 'BR', -5.911417, -35.24772, 'Augusto Severo Intl Arpt', -3);
INSERT INTO public.airports VALUES (2441, 'Nevsehir', 'NAV', 'TR', 38.771866, 34.53455, 'Nevsehir Arpt', 2);
INSERT INTO public.airports VALUES (2442, 'Narathiwat', 'NAW', 'TH', 6.519922, 101.7434, 'Narathiwat Arpt', 7);
INSERT INTO public.airports VALUES (2443, 'Naberevnye Chelny', 'NBC', 'RU', 32.47741, -80.72316, 'Nijnekamsk Arpt', -5);
INSERT INTO public.airports VALUES (2444, 'Hammamet', 'NBE', 'TN', 36.075832, 10.438611, 'Hammamet International Arpt', 1);
INSERT INTO public.airports VALUES (2445, 'Nairobi', 'WIL', 'KE', -1.321719, 36.814835, 'Wilson Airport', 3);
INSERT INTO public.airports VALUES (2446, 'Nairobi', 'NBO', 'KE', -1.319167, 36.9275, 'Jomo Kenyatta Intl', 3);
INSERT INTO public.airports VALUES (2447, 'North Caicos', 'NCA', 'TC', 21.917475, -71.93956, 'North Caicos Municipal Arpt', -5);
INSERT INTO public.airports VALUES (2448, 'Nice', 'NCE', 'FR', 43.65841, 7.215872, 'Cote D Azur Arpt', 1);
INSERT INTO public.airports VALUES (2449, 'Newcastle', 'NCL', 'GB', 55.0375, -1.691667, 'Newcastle Arpt', 0);
INSERT INTO public.airports VALUES (2450, 'Newcastle', 'XVU', 'GB', 0, 0, 'Durham Rail Station', -100);
INSERT INTO public.airports VALUES (2451, 'Newcastle', 'NCS', 'ZA', -27.770586, 29.976894, 'Newcastle Intl Arpt', 2);
INSERT INTO public.airports VALUES (2452, 'Nukus', 'NCU', 'UZ', 42.4884, 59.6233, 'Nukus', 5);
INSERT INTO public.airports VALUES (2453, 'Annecy', 'NCY', 'FR', 45.929234, 6.098764, 'Annecy Meythet Arpt', 1);
INSERT INTO public.airports VALUES (2454, 'Nouadhibou', 'NDB', 'MR', 20.933067, -17.029957, 'Nouadhibou Arpt', 0);
INSERT INTO public.airports VALUES (2455, 'Qiqihar', 'NDG', 'CN', 47.239628, 123.91813, 'Qiqihar Arpt', 8);
INSERT INTO public.airports VALUES (2456, 'N Djamena', 'NDJ', 'TD', 12.133689, 15.034019, 'N Djamena Arpt', 1);
INSERT INTO public.airports VALUES (2457, 'Namdrik', 'NDK', 'MH', 5.63167, 168.125, 'Namdrik Arpt', 12);
INSERT INTO public.airports VALUES (2458, 'Nador', 'NDR', 'MA', 34.9888, -3.02821, 'Nador Arpt', 0);
INSERT INTO public.airports VALUES (2459, 'Sanday', 'NDY', 'GB', 59.2503, -2.57667, 'Sanday Arpt', 0);
INSERT INTO public.airports VALUES (2460, 'Neftekamsk Airport', 'NEF', 'RU', 0, 0, 'Neftekamsk Airport', -2);
INSERT INTO public.airports VALUES (2461, 'Negril', 'NEG', 'JM', 18.34, -78.335556, 'Negril Arpt', -5);
INSERT INTO public.airports VALUES (2462, 'Neryungri Chulman', 'NER', 'RU', 0, 0, 'Neryungri Chulman', -2);
INSERT INTO public.airports VALUES (2463, 'Nevis', 'NEV', 'KN', 17.205679, -62.58987, 'Nevis Airport', -4);
INSERT INTO public.airports VALUES (2464, 'Nefteyugansk', 'NFG', 'RU', 61.1083, 72.65, 'Nefteyugansk Arpt', 6);
INSERT INTO public.airports VALUES (2465, 'Fallon', 'FLX', 'US', 0, 0, 'Fallon Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2466, 'Young', 'NGA', 'AU', -34.25, 148.2483, 'Young Arpt', -100);
INSERT INTO public.airports VALUES (2467, 'Ningbo', 'NGB', 'CN', 29.826683, 121.46191, 'Ningbo Arpt', 8);
INSERT INTO public.airports VALUES (2468, 'N Gaoundere', 'NGE', 'CM', 7.357011, 13.559242, 'N Gaoundere Arpt', 1);
INSERT INTO public.airports VALUES (2469, 'Nagoya', 'NKM', 'JP', 35.255, 136.924, 'Nagoya Komaki Arpt', 9);
INSERT INTO public.airports VALUES (2470, 'Nagoya', 'NGO', 'JP', 34.858414, 136.8054, 'Chubu Centrair Intl Arpt', 9);
INSERT INTO public.airports VALUES (2471, 'Nagasaki', 'NGS', 'JP', 32.916943, 129.9136, 'Nagasaki Airport', 9);
INSERT INTO public.airports VALUES (2472, 'Nha Trang', 'NHA', 'VN', 12.227467, 109.19232, 'Nha Trang Arpt', 7);
INSERT INTO public.airports VALUES (2473, 'Brunswick', 'NHZ', 'US', 43.8917, -69.9425, 'Naval Air Station', -100);
INSERT INTO public.airports VALUES (2474, 'Niamey', 'NIM', 'NE', 13.481547, 2.183614, 'Niamey Airport', 1);
INSERT INTO public.airports VALUES (2475, 'Nizhnevartovsk', 'NJC', 'RU', 60.949272, 76.48362, 'Nizhnevartovsk Arpt', 6);
INSERT INTO public.airports VALUES (2476, 'Al Najaf International Arpt', 'NJF', 'IQ', 31.991667, 44.404167, 'Al Najaf International Arpt', 3);
INSERT INTO public.airports VALUES (2477, 'Nouakchott', 'NKC', 'MR', 18.097857, -15.947956, 'Nouakchott Arpt', 0);
INSERT INTO public.airports VALUES (2478, 'Nanjing', 'NKG', 'CN', 31.742043, 118.86202, 'Nanjing Arpt', 8);
INSERT INTO public.airports VALUES (2479, 'N Dola', 'NLA', 'ZM', -12.998139, 28.664944, 'Ndola Arpt', 2);
INSERT INTO public.airports VALUES (2480, 'Lemoore', 'NLC', 'US', 36.33301, -119.95208, 'Nas Reeves Field', -8);
INSERT INTO public.airports VALUES (2481, 'Nuevo Laredo', 'NLD', 'MX', 27.443918, -99.57046, 'Quetzalcoatl Intl', -6);
INSERT INTO public.airports VALUES (2482, 'Norfolk Island', 'NLK', 'NF', -29.041624, 167.93874, 'Norfolk Island Intl Arpt', 11);
INSERT INTO public.airports VALUES (2483, 'Nelspruit', 'NLP', 'ZA', -25.5, 30.9138, 'Nelspruit Airport', 2);
INSERT INTO public.airports VALUES (2484, 'Nelspruit', 'MQP', 'ZA', -25.3832, 31.1056, 'Kruger Mpumalanga Intl Arpt', 2);
INSERT INTO public.airports VALUES (2485, 'Nikolaev', 'NLV', 'UA', 47.0579, 31.9198, 'Nikolaev Arpt', 2);
INSERT INTO public.airports VALUES (2486, 'Namangrad', 'NMA', 'UZ', 40.9846, 71.5567, 'Namangrad Airport', 5);
INSERT INTO public.airports VALUES (2487, 'Nanning', 'NNG', 'CN', 22.608267, 108.17244, 'Nanning Arpt', 8);
INSERT INTO public.airports VALUES (2488, 'Naryan Mar', 'NNM', 'RU', 67.38054, 53.051018, 'Naryan-Mar Airport', 4);
INSERT INTO public.airports VALUES (2489, 'Spiddal', 'NNR', 'IE', 53.2303, -9.46778, 'Connemara Arpt', 0);
INSERT INTO public.airports VALUES (2490, 'Nan Th', 'NNT', 'TH', 18.807915, 100.78342, 'Nan Arpt', 7);
INSERT INTO public.airports VALUES (2491, 'Nowra', 'NOA', 'AU', -34.9489, 150.537, 'Nowra Arpt', 10);
INSERT INTO public.airports VALUES (2492, 'Nosara Beach', 'NOB', 'CR', 9.97649, -85.653, 'Nosara Beach Arpt', -6);
INSERT INTO public.airports VALUES (2493, 'Knock', 'NOC', 'IE', 53.910297, -8.818492, 'Knock International', 0);
INSERT INTO public.airports VALUES (2494, 'Nogales', 'NOG', 'MX', 31.226084, -110.97583, 'Nogales Arpt', -7);
INSERT INTO public.airports VALUES (2495, 'Nojabrxsk', 'NOJ', 'RU', 63.11008, 75.16225, 'Nojabrxsk Arpt', 6);
INSERT INTO public.airports VALUES (2496, 'Nossi Be', 'NOS', 'MG', -13.312067, 48.314823, 'Fascene Arpt', 3);
INSERT INTO public.airports VALUES (2497, 'Novato', 'NOT', 'US', 0, 0, 'Novato Arpt', -100);
INSERT INTO public.airports VALUES (2498, 'Noumea', 'NOU', 'NC', -22.014553, 166.21297, 'Tontouta Arpt', 11);
INSERT INTO public.airports VALUES (2499, 'Noumea', 'GEA', 'NC', -22.258278, 166.47281, 'Magenta Arpt', 11);
INSERT INTO public.airports VALUES (2500, 'Novokuznetsk', 'NOZ', 'RU', 53.8114, 86.8772, 'Novokuznetsk Arpt', 8);
INSERT INTO public.airports VALUES (2501, 'Napier Hastings', 'NPE', 'NZ', -39.46583, 176.87, 'Hawkes Bay Arpt', 12);
INSERT INTO public.airports VALUES (2502, 'New Plymouth', 'NPL', 'NZ', -39.00861, 174.17917, 'New Plymouth Arpt', 12);
INSERT INTO public.airports VALUES (2503, 'Newport', 'NPT', 'US', 0, 0, 'Newport State Arpt', -100);
INSERT INTO public.airports VALUES (2504, 'Kingsville', 'NQI', 'US', 27.507223, -97.80972, 'Naval Air Station Arpt', -6);
INSERT INTO public.airports VALUES (2505, 'Neuquen', 'NQN', 'AR', -38.949, -68.15571, 'Neuquen Airport', -3);
INSERT INTO public.airports VALUES (2506, 'Nottingham Uk', 'EMA', 'GB', 52.831112, -1.328056, 'East Midlands Arpt', 0);
INSERT INTO public.airports VALUES (2507, 'Nottingham Uk', 'NQT', 'GB', 52.92, -1.079167, 'Nottingham Arpt', 0);
INSERT INTO public.airports VALUES (2508, 'Newquay', 'NQY', 'GB', 50.44056, -4.995408, 'Newquay Civil Arpt', 0);
INSERT INTO public.airports VALUES (2509, 'Narrandera', 'NRA', 'AU', -34.7022, 146.512, 'Narrandera Arpt', 10);
INSERT INTO public.airports VALUES (2510, 'Norrkoping', 'XYK', 'SE', 0, 0, 'Norrkoping Railway Service', -100);
INSERT INTO public.airports VALUES (2511, 'Norrkoping', 'NRK', 'SE', 58.586254, 16.250622, 'Kungsangen Arpt', 1);
INSERT INTO public.airports VALUES (2512, 'North Ronaldsay', 'NRL', 'GB', 59.3675, -2.43444, 'North Ronaldsay Arpt', 0);
INSERT INTO public.airports VALUES (2513, 'Noosa', 'NSA', 'AU', 0, 0, 'Noosa Airport', -100);
INSERT INTO public.airports VALUES (2514, 'Milton', 'NSE', 'US', 30.724167, -87.02194, 'Whiting Field Nas', -6);
INSERT INTO public.airports VALUES (2515, 'Norilsk', 'NSK', 'RU', 69.31105, 87.332184, 'Norilsk Arpt', 8);
INSERT INTO public.airports VALUES (2516, 'Norseman', 'NSM', 'AU', 0, 0, 'Norseman Arpt', -100);
INSERT INTO public.airports VALUES (2517, 'Nelson', 'NSN', 'NZ', -41.298332, 173.22112, 'Nelson Arpt', 12);
INSERT INTO public.airports VALUES (2518, 'Scone', 'NSO', 'AU', -32.0372, 150.832, 'Scone Airport', 10);
INSERT INTO public.airports VALUES (2519, 'Nakhon Si Thammarat', 'NST', 'TH', 8.539617, 99.944725, 'Nakhon Si Thammarat Arpt', 7);
INSERT INTO public.airports VALUES (2520, 'Notodden', 'NTB', 'NO', 59.5655, 9.2123, 'Notodden Arpt', -100);
INSERT INTO public.airports VALUES (2521, 'Nantes', 'QJZ', 'FR', 47.1667, -1.6167, 'Nantes Rail Station', -100);
INSERT INTO public.airports VALUES (2522, 'Nantes', 'NTE', 'FR', 47.15319, -1.610725, 'Nantes Atlantique', 1);
INSERT INTO public.airports VALUES (2523, 'Nantong', 'NTG', 'CN', 32.0708, 120.976, 'Nantong Arpt', 8);
INSERT INTO public.airports VALUES (2524, 'Newcastle', 'NTL', 'AU', -32.78, 151.83, 'Williamtown Arpt', 10);
INSERT INTO public.airports VALUES (2525, 'Newcastle', 'BEO', 'AU', 0, 0, 'Belmont Arpt', -100);
INSERT INTO public.airports VALUES (2526, 'Normanton', 'NTN', 'AU', -17.6836, 141.07, 'Normanton Arpt', 10);
INSERT INTO public.airports VALUES (2527, 'Santo Antao', 'NTO', 'CV', 0, 0, 'Santo Antao Arpt', -100);
INSERT INTO public.airports VALUES (2528, 'Sun City', 'NTY', 'ZA', -25.333822, 27.173359, 'Pilansberg Arpt', 2);
INSERT INTO public.airports VALUES (2529, 'Nuremberg', 'NUE', 'DE', 49.4987, 11.066897, 'Nuremberg Arpt', 1);
INSERT INTO public.airports VALUES (2530, 'Nuremberg', 'ZAQ', 'DE', 49.44639, 11.081944, 'Nuremberg Rail Station', 1);
INSERT INTO public.airports VALUES (2531, 'Nulato', 'NUL', 'US', 64.72945, -158.07417, 'Nulato Arpt', -9);
INSERT INTO public.airports VALUES (2532, 'Mountain View', 'NUQ', 'US', 37.41614, -122.04914, 'Moffett Field', -8);
INSERT INTO public.airports VALUES (2533, 'Nullarbor', 'NUR', 'AU', 49.446, 11.081944, 'Nullarbor Arpt', 2);
INSERT INTO public.airports VALUES (2534, 'Novy Urengoy', 'NUX', 'RU', 66.04181, 76.313934, 'Novy Urengoy Arpt', 6);
INSERT INTO public.airports VALUES (2535, 'Narvik', 'NVK', 'NO', 68.43584, 17.388056, 'Framnes Arpt', 1);
INSERT INTO public.airports VALUES (2536, 'Novgorod', 'NVR', 'RU', 0, 0, 'Yurievo Airport', 4);
INSERT INTO public.airports VALUES (2537, 'Nevers', 'NVS', 'FR', 47.002625, 3.113333, 'Nevers Arpt', 1);
INSERT INTO public.airports VALUES (2538, 'Navegantes', 'NVT', 'BR', -26.88, -48.65139, 'Navegantes Arpt', -3);
INSERT INTO public.airports VALUES (2539, 'Norwich', 'NWI', 'GB', 52.675835, 1.282778, 'Norwich Airport', 0);
INSERT INTO public.airports VALUES (2540, 'Nyagan Airport', 'NYA', 'RU', 62.11, 65.615, 'Nyagan Airport', 6);
INSERT INTO public.airports VALUES (2541, 'New York', 'JFK', 'US', 40.63975, -73.77892, 'John F Kennedy Intl', -5);
INSERT INTO public.airports VALUES (2542, 'New York', 'LGA', 'US', 40.777245, -73.872604, 'La Guardia', -5);
INSERT INTO public.airports VALUES (2543, 'Nyeri', 'NYE', 'KE', 0, 0, 'Nyeri Arpt', -100);
INSERT INTO public.airports VALUES (2544, 'Nanyuki', 'NYK', 'KE', -0.067, 37.033, 'Nanyuki Arpt', 3);
INSERT INTO public.airports VALUES (2545, 'Nadym Airport', 'NYM', 'RU', 65.4809, 72.6989, 'Nadym Airport', 6);
INSERT INTO public.airports VALUES (2546, 'Nyngan', 'NYN', 'AU', -31.5531, 147.2031, 'Nyngan Arpt', -100);
INSERT INTO public.airports VALUES (2547, 'Nyaung', 'NYU', 'MM', 21.173834, 94.92467, 'Nyaung U Arpt', 6);
INSERT INTO public.airports VALUES (2548, 'Orange', 'OAG', 'AU', -33.3817, 149.133, 'Springhill Arpt', 10);
INSERT INTO public.airports VALUES (2549, 'Jacksonville', 'OAJ', 'US', 34.829163, -77.61214, 'Albert J Ellis', -5);
INSERT INTO public.airports VALUES (2550, 'Oakland', 'OAK', 'US', 37.72128, -122.22072, 'Metro Oakland Intl Arpt', -8);
INSERT INTO public.airports VALUES (2551, 'Cacoal', 'OAL', 'BR', 47.78, 10.627, 'Cacoal Arpt', 2);
INSERT INTO public.airports VALUES (2552, 'Oamaru', 'OAM', 'NZ', -44.97, 171.08167, 'Oamaru Airport', 12);
INSERT INTO public.airports VALUES (2553, 'Oaxaca', 'OAX', 'MX', 16.999907, -96.72664, 'Xoxocotlan Arpt', -6);
INSERT INTO public.airports VALUES (2554, 'Okeechobee', 'OBE', 'US', 0, 0, 'Okeechobee County Arpt', -100);
INSERT INTO public.airports VALUES (2555, 'Oban', 'OBN', 'GB', 56.464, -5.4, 'Connel Arpt', 0);
INSERT INTO public.airports VALUES (2556, 'Obihiro', 'OBO', 'JP', 42.733334, 143.21722, 'Obihiro Arpt', 9);
INSERT INTO public.airports VALUES (2557, 'Aubenas', 'OBS', 'FR', 44.544235, 4.372192, 'Vals Lanas Arpt', 1);
INSERT INTO public.airports VALUES (2558, 'Ocean Reef', 'OCA', 'US', 25.325394, -80.27477, 'Ocean Reef Arpt', -5);
INSERT INTO public.airports VALUES (2559, 'Ocean City', 'OCE', 'US', 0, 0, 'Ocean City Airport', -100);
INSERT INTO public.airports VALUES (2560, 'Ocala', 'OCF', 'US', 0, 0, 'Taylor Field Arpt', -100);
INSERT INTO public.airports VALUES (2561, 'Ocho Rios', 'OCJ', 'JM', 18.404247, -76.96902, 'Boscobel Arpt', -5);
INSERT INTO public.airports VALUES (2562, 'Oceanside', 'OCN', 'US', 0, 0, 'Oceanside Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2563, 'Cordoba', 'ODB', 'ES', 37.842007, -4.848878, 'Cordoba Airport', 1);
INSERT INTO public.airports VALUES (2564, 'Odense', 'ZBQ', 'DK', 0, 0, 'Odense Railroad Station', -100);
INSERT INTO public.airports VALUES (2565, 'Odense', 'ZIM', 'DK', 0, 0, 'Odense Bus Service', -100);
INSERT INTO public.airports VALUES (2566, 'Odense', 'ODE', 'DK', 55.476665, 10.330933, 'Odense Airport', 1);
INSERT INTO public.airports VALUES (2567, 'Long Seridan', 'ODN', 'MY', 3.967, 115.05, 'Long Seridan Arpt', 8);
INSERT INTO public.airports VALUES (2568, 'Odessa', 'ODS', 'UA', 46.426765, 30.676464, 'Central Arpt', 2);
INSERT INTO public.airports VALUES (2569, 'Oak Harbor', 'ODW', 'US', 48.2515, -122.6737, 'Oak Harbour Municipal', -100);
INSERT INTO public.airports VALUES (2570, 'Vincennes', 'OEA', 'US', 0, 0, 'Oneal Arpt', -100);
INSERT INTO public.airports VALUES (2571, 'Oryol Yuzhny Airport', 'OEL', 'RU', 0, 0, 'Oryol Yuzhny Airport', -2);
INSERT INTO public.airports VALUES (2572, 'Ornskoldsvik', 'OER', 'SE', 63.40834, 18.99004, 'Ornskoldsvik Arpt', 1);
INSERT INTO public.airports VALUES (2573, 'Norfolk', 'OFK', 'US', 41.9856, -97.4353, 'Karl Stefan Fld', -100);
INSERT INTO public.airports VALUES (2574, 'Ogallala', 'OGA', 'US', 0, 0, 'Searle Field', -100);
INSERT INTO public.airports VALUES (2575, 'Ogden', 'OGD', 'US', 41.1961, -112.0122, 'Ogden Municipal', -100);
INSERT INTO public.airports VALUES (2576, 'Maui', 'OGG', 'US', 20.89865, -156.43045, 'Kahului Airport', -10);
INSERT INTO public.airports VALUES (2577, 'Ogdensburg', 'OGS', 'US', 44.681854, -75.4655, 'Ogdensburg Municipal', -5);
INSERT INTO public.airports VALUES (2578, 'VLADIKAVKAZ', 'OGZ', 'RU', 43.2051, 44.6066, 'VLADIKAVKAZ', 4);
INSERT INTO public.airports VALUES (2579, 'Ohrid', 'OHD', 'MK', 41.179955, 20.742325, 'Ohrid Arpt', 1);
INSERT INTO public.airports VALUES (2580, 'Okha Airport', 'OHH', 'RU', 53.583332, 142.93333, 'Okha Airport', 11);
INSERT INTO public.airports VALUES (2581, 'Okhotsk Airport', 'OHO', 'RU', 59.4101, 143.057, 'Okhotsk Airport', 11);
INSERT INTO public.airports VALUES (2582, 'Ourilandia', 'OIA', 'BR', -6.763056, -51.05, 'Ourilandia Arpt', -4);
INSERT INTO public.airports VALUES (2583, 'Oshima', 'OIM', 'JP', 34.782032, 139.3603, 'Oshima Arpt', 9);
INSERT INTO public.airports VALUES (2584, 'Oita', 'OIT', 'JP', 33.479443, 131.73723, 'Oita Arpt', 9);
INSERT INTO public.airports VALUES (2585, 'Okinawa', 'OKA', 'JP', 26.195814, 127.64587, 'Naha Field', 9);
INSERT INTO public.airports VALUES (2586, 'Oklahoma City', 'PWA', 'US', 35.5342, -97.6471, 'Wiley Post Arpt', -100);
INSERT INTO public.airports VALUES (2587, 'Oklahoma City', 'DWN', 'US', 0, 0, 'Downtown Airpark', -100);
INSERT INTO public.airports VALUES (2588, 'Oklahoma City', 'OKC', 'US', 35.39309, -97.60073, 'Will Rogers World Arpt', -6);
INSERT INTO public.airports VALUES (2589, 'Okino Erabu', 'OKE', 'JP', 27.4317, 128.7056, 'Okino Erabu Arpt', -100);
INSERT INTO public.airports VALUES (2590, 'Okayama', 'OKJ', 'JP', 34.756943, 133.85527, 'Okayama Arpt', 9);
INSERT INTO public.airports VALUES (2591, 'Kokomo', 'OKK', 'US', 0, 0, 'Kokomo Municipal', -100);
INSERT INTO public.airports VALUES (2592, 'Oktyabrsky Airport', 'OKT', 'RU', 0, 0, 'Oktyabrsky Airport', -2);
INSERT INTO public.airports VALUES (2593, 'Oakey', 'OKY', 'AU', -27.411388, 151.73528, 'Oakey Arpt', 10);
INSERT INTO public.airports VALUES (2594, 'Olbia', 'OLB', 'IT', 40.898663, 9.517628, 'Costa Smeralda Arpt', 1);
INSERT INTO public.airports VALUES (2595, 'Fuerte Olimpo', 'OLK', 'PY', 60.3883, 120.4717, 'Fuerte Olimpo Arpt', -100);
INSERT INTO public.airports VALUES (2596, 'Olympia', 'OLM', 'US', 46.969402, -122.90254, 'Olympia Arpt', -7);
INSERT INTO public.airports VALUES (2597, 'Olympic Dam', 'OLP', 'AU', -30.485, 136.877, 'Olympic Dam Arpt', 9);
INSERT INTO public.airports VALUES (2598, 'Nogales', 'OLS', 'US', 31.417723, -110.84789, 'International Arpt', -7);
INSERT INTO public.airports VALUES (2599, 'Columbus', 'OLU', 'US', 0, 0, 'Columbus Arpt', -100);
INSERT INTO public.airports VALUES (2600, 'Omaha', 'MIQ', 'US', 0, 0, 'Millard Airport', -100);
INSERT INTO public.airports VALUES (2601, 'Omaha', 'OMA', 'US', 41.303165, -95.894066, 'Eppley Airfield', -6);
INSERT INTO public.airports VALUES (2602, 'Oranjemund', 'OMD', 'NA', -28.5847, 16.4467, 'Oranjemund Arpt', 1);
INSERT INTO public.airports VALUES (2603, 'Nome', 'OME', 'US', 64.5122, -165.44525, 'Nome Arpt', -9);
INSERT INTO public.airports VALUES (2604, 'Mostar', 'OMO', 'BA', 43.2829, 17.845879, 'Mostar Arpt', 1);
INSERT INTO public.airports VALUES (2605, 'Oradea', 'OMR', 'RO', 47.025276, 21.9025, 'Oradea Arpt', 2);
INSERT INTO public.airports VALUES (2606, 'Omsk', 'OMS', 'RU', 54.96704, 73.31052, 'Omsk Arpt', 7);
INSERT INTO public.airports VALUES (2607, 'Ondangwa', 'OND', 'NA', -17.8782, 15.9526, 'Ondangwa Arpt', 1);
INSERT INTO public.airports VALUES (2608, 'Mornington', 'ONG', 'AU', -16.6625, 139.178, 'Mornington Arpt', 9);
INSERT INTO public.airports VALUES (2609, 'Oneonta', 'ONH', 'US', 42.524723, -75.064445, 'Oneonta Municpal', -5);
INSERT INTO public.airports VALUES (2610, 'Odate Noshiro', 'ONJ', 'JP', 40.1919, 140.371, 'Odate Noshiro Arpt', 9);
INSERT INTO public.airports VALUES (2611, 'Socorro', 'ONM', 'US', 0, 0, 'Socorro Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2612, 'Newport', 'ONP', 'US', 44.58036, -124.057915, 'Newport Municipal Arpt', 8);
INSERT INTO public.airports VALUES (2613, 'Zonguldak', 'ONQ', 'TR', 41.50611, 32.08861, 'Zonguldak Airport', 2);
INSERT INTO public.airports VALUES (2614, 'Ontario', 'ONT', 'US', 34.056, -117.6012, 'Ontario Intl', -8);
INSERT INTO public.airports VALUES (2615, 'Gold Coast', 'OOL', 'AU', -28.164444, 153.50471, 'Gold Coast Arpt', 10);
INSERT INTO public.airports VALUES (2616, 'Cooma', 'OOM', 'AU', -36.3006, 148.974, 'Cooma Airport', 10);
INSERT INTO public.airports VALUES (2617, 'Kopasker', 'OPA', 'IS', 0, 0, 'Kopasker Arpt', -100);
INSERT INTO public.airports VALUES (2618, 'Porto', 'OPO', 'PT', 41.248055, -8.681389, 'Porto Airport', 0);
INSERT INTO public.airports VALUES (2619, 'Orebro Bofors', 'XWR', 'SE', 0, 0, 'Orebro Bofors Railway Service', -100);
INSERT INTO public.airports VALUES (2620, 'Orebro Bofors', 'ORB', 'SE', 59.223732, 15.037956, 'Orebro Bofors Arpt', 1);
INSERT INTO public.airports VALUES (2621, 'Orebro Bofors', 'XWM', 'SE', 0, 0, 'Hallsberg Rail Station', -100);
INSERT INTO public.airports VALUES (2622, 'Orleans', 'ORE', 'FR', 47.987778, 1.760556, 'Orleans Arpt', 1);
INSERT INTO public.airports VALUES (2623, 'Norfolk', 'ORF', 'US', 36.89461, -76.201225, 'Norfolk Intl Arpt', -5);
INSERT INTO public.airports VALUES (2624, 'Worcester', 'ORH', 'US', 42.2673, -71.8757, 'Worcester Arpt', -5);
INSERT INTO public.airports VALUES (2625, 'Cork', 'ORK', 'IE', 51.84127, -8.491111, 'Cork International Arpt', 0);
INSERT INTO public.airports VALUES (2626, 'Orlando', 'ORL', 'US', 28.545464, -81.33294, 'Herndon Arpt', -5);
INSERT INTO public.airports VALUES (2627, 'Orlando', 'MCO', 'US', 28.429394, -81.30899, 'Orlando Intl Arpt', -5);
INSERT INTO public.airports VALUES (2628, 'Northampton', 'ORM', 'GB', 0, 0, 'Northampton Rail Station', -100);
INSERT INTO public.airports VALUES (2629, 'Oran', 'ORN', 'DZ', 35.62386, -0.621183, 'Es Senia', 1);
INSERT INTO public.airports VALUES (2630, 'Orpheus Island', 'ORS', 'AU', -18.634, 146.5, 'Waterport Arpt', 10);
INSERT INTO public.airports VALUES (2631, 'Osaka', 'ITM', 'JP', 34.785526, 135.43822, 'Itami Arpt', 9);
INSERT INTO public.airports VALUES (2632, 'Osaka', 'KIX', 'JP', 34.434723, 135.24417, 'Kansai International Arpt', 9);
INSERT INTO public.airports VALUES (2633, 'Ostersund', 'OSD', 'SE', 63.1944, 14.5003, 'Froesoe Airport', 1);
INSERT INTO public.airports VALUES (2634, 'Oshkosh', 'OSH', 'US', 44.024982, -88.55134, 'Wittman Field', -5);
INSERT INTO public.airports VALUES (2635, 'Osijek', 'OSI', 'HR', 45.462666, 18.810156, 'Osijek Arpt', 1);
INSERT INTO public.airports VALUES (2636, 'Oskarshamn', 'OSK', 'SE', 57.350452, 16.497972, 'Oskarshamn', 1);
INSERT INTO public.airports VALUES (2637, 'Oslo', 'OSL', 'NO', 60.193916, 11.100361, 'Oslo Arpt', 1);
INSERT INTO public.airports VALUES (2638, 'Oslo', 'TRF', 'NO', 59.186703, 10.258628, 'Sandefjord Arpt', 1);
INSERT INTO public.airports VALUES (2639, 'Oslo', 'RYG', 'NO', 59.378933, 10.785389, 'Moss Rygge Arpt', 1);
INSERT INTO public.airports VALUES (2640, 'Oslo', 'XZO', 'NO', 0, 0, 'Oslo Central Station', -100);
INSERT INTO public.airports VALUES (2641, 'Oslo', 'XND', 'NO', 0, 0, 'Drammen Rail Station', -100);
INSERT INTO public.airports VALUES (2642, 'Oslo', 'XKQ', 'NO', 0, 0, 'Sarpsborg Rail Station', -100);
INSERT INTO public.airports VALUES (2643, 'Oslo', 'XKM', 'NO', 0, 0, 'Moss Rail Station', -100);
INSERT INTO public.airports VALUES (2644, 'Oslo', 'XKI', 'NO', 0, 0, 'Lillestrom Rail Station', -100);
INSERT INTO public.airports VALUES (2645, 'Oslo', 'XKF', 'NO', 0, 0, 'Fredrikstad Rail Station', -100);
INSERT INTO public.airports VALUES (2646, 'Oslo', 'XKE', 'NO', 0, 0, 'Rena Rail Station', -100);
INSERT INTO public.airports VALUES (2647, 'Oslo', 'XKD', 'NO', 0, 0, 'Halden Rail Station', -100);
INSERT INTO public.airports VALUES (2648, 'Oslo', 'XKB', 'NO', 0, 0, 'Kongsberg Rail Station', -100);
INSERT INTO public.airports VALUES (2649, 'Oslo', 'XGU', 'NO', 0, 0, 'Asker Rail Station', -100);
INSERT INTO public.airports VALUES (2650, 'Mosul', 'OSM', 'IQ', 36.305832, 43.1475, 'Mosul Airport', 3);
INSERT INTO public.airports VALUES (2651, 'Ostrava', 'OSR', 'CZ', 49.696293, 18.111053, 'Mosnov Arpt', 1);
INSERT INTO public.airports VALUES (2652, 'Osh', 'OSS', 'KG', 40.60899, 72.79327, 'Osh Airport', 5);
INSERT INTO public.airports VALUES (2653, 'Ostende', 'OST', 'BE', 51.19889, 2.862222, 'Ostend Airport', 1);
INSERT INTO public.airports VALUES (2654, 'Namsos', 'OSY', 'NO', 64.4722, 11.5786, 'Namsos Arpt', 1);
INSERT INTO public.airports VALUES (2655, 'Worthington', 'OTG', 'US', 0, 0, 'Worthington Arpt', -100);
INSERT INTO public.airports VALUES (2656, 'North Bend', 'OTH', 'US', 43.4171, -124.246, 'North Bend Municipal', -8);
INSERT INTO public.airports VALUES (2657, 'Ottumwa', 'OTM', 'US', 41.1066, -92.4479, 'Industrial Arpt', -100);
INSERT INTO public.airports VALUES (2658, 'Ancortes', 'OTS', 'US', 48.49889, -122.6625, 'Ancortes Arpt', -8);
INSERT INTO public.airports VALUES (2659, 'Kotzebue', 'OTZ', 'US', 66.88468, -162.59856, 'Ralph Wien Memorial', -9);
INSERT INTO public.airports VALUES (2660, 'Ouagadougou', 'OUA', 'BF', 12.353194, -1.512417, 'Ouagadougou Arpt', 0);
INSERT INTO public.airports VALUES (2661, 'Oujda', 'OUD', 'MA', 34.78715, -1.923986, 'Les Angades Arpt', 1);
INSERT INTO public.airports VALUES (2662, 'Oudtshoorn', 'OUH', 'ZA', -33.6, 22.1833, 'Oudtshoorn Arpt', -100);
INSERT INTO public.airports VALUES (2663, 'Oulu', 'OUL', 'FI', 64.93006, 25.354565, 'Oulu Airport', 2);
INSERT INTO public.airports VALUES (2664, 'Zouerate', 'OUZ', 'MR', 0, 0, 'Zouerate Arpt', -100);
INSERT INTO public.airports VALUES (2665, 'Novosibirsk', 'OVB', 'RU', 55.012623, 82.65066, 'Tolmachevo Arpt', 7);
INSERT INTO public.airports VALUES (2666, 'Asturias', 'OVD', 'ES', 43.56357, -6.034622, 'Asturias Airport', 1);
INSERT INTO public.airports VALUES (2667, 'Boscobel', 'OVS', 'RU', 61.32, 63.6044, 'Sovetsky Airport', 6);
INSERT INTO public.airports VALUES (2668, 'Owatonna', 'OWA', 'US', 0, 0, 'Owatonna Arpt', -100);
INSERT INTO public.airports VALUES (2669, 'Owensboro', 'OWB', 'US', 37.7401, -87.1668, 'Daviess County Arpt', -6);
INSERT INTO public.airports VALUES (2670, 'Norwood', 'OWD', 'US', 42.19053, -71.17294, 'Norwood Ma Arpt', -4);
INSERT INTO public.airports VALUES (2671, 'Bissau', 'OXB', 'GW', 11.89485, -15.653681, 'Airport Osvaldo Viera', 0);
INSERT INTO public.airports VALUES (2672, 'Oxford', 'OXC', 'US', 41.478558, -73.13525, 'Waterbury Oxford Arpt', -4);
INSERT INTO public.airports VALUES (2673, 'Oxford', 'OXF', 'GB', 51.836945, -1.32, 'Kidlington Arpt', 0);
INSERT INTO public.airports VALUES (2674, 'Oxford', 'BZZ', 'GB', 51.749966, -1.583617, 'Brize Norton Raf Station', 0);
INSERT INTO public.airports VALUES (2675, 'Oxnard', 'OXR', 'US', 34.200832, -119.20722, 'Oxnard Ventura Arpt', -8);
INSERT INTO public.airports VALUES (2676, 'Tres Arroyos', 'OYO', 'AR', 0, 0, 'Tres Arroyos Arpt', -100);
INSERT INTO public.airports VALUES (2677, 'Labo Arpt', 'OZC', 'PH', 8.178508, 123.84173, 'Labo Arpt', 8);
INSERT INTO public.airports VALUES (2678, 'Zaporozhe', 'OZH', 'UA', 47.867, 35.3157, 'Zaporozhye Arpt', 2);
INSERT INTO public.airports VALUES (2679, 'Ourzazate', 'OZZ', 'MA', 30.939053, -6.909431, 'Ourzazate', 0);
INSERT INTO public.airports VALUES (2680, 'Paderborn', 'PAD', 'DE', 51.61409, 8.616317, 'Paderborn Airport', 1);
INSERT INTO public.airports VALUES (2681, 'Everett', 'PAE', 'US', 47.90634, -122.28156, 'Snohomish Cty Arpt', -8);
INSERT INTO public.airports VALUES (2682, 'Paducah', 'PAH', 'US', 37.060287, -88.77296, 'Barkley Regional', -6);
INSERT INTO public.airports VALUES (2683, 'Palo Alto', 'PAO', 'US', 0, 0, 'Palo Alto Arpt', -100);
INSERT INTO public.airports VALUES (2684, 'Port Au Prince', 'PAP', 'HT', 18.58005, -72.29254, 'Mais Gate Arpt', -5);
INSERT INTO public.airports VALUES (2685, 'Paris', 'ORY', 'FR', 48.725277, 2.359444, 'Orly Arpt', 1);
INSERT INTO public.airports VALUES (2686, 'Paris', 'JDP', 'FR', 0, 0, 'Issy Les Moulineaux Arpt', -100);
INSERT INTO public.airports VALUES (2687, 'Paris', 'LBG', 'FR', 48.969444, 2.441389, 'Le Bourget Arpt', 1);
INSERT INTO public.airports VALUES (2688, 'Paris', 'CDG', 'FR', 49.01278, 2.55, 'Charles De Gaulle Intl Arpt', 1);
INSERT INTO public.airports VALUES (2689, 'Paris', 'BVA', 'FR', 49.454445, 2.112778, 'Beauvais Tille Arpt', 1);
INSERT INTO public.airports VALUES (2690, 'Paris', 'XPG', 'FR', 48.88093, 2.355323, 'Gare du Nord Railway Station', 1);
INSERT INTO public.airports VALUES (2691, 'Paris', 'XCR', 'FR', 48.7733, 4.2061, 'Vatry Arpt', -100);
INSERT INTO public.airports VALUES (2692, 'Paros', 'PAS', 'GR', 37.010277, 25.127777, 'Paros Community Arpt', 2);
INSERT INTO public.airports VALUES (2693, 'Patna', 'PAT', 'IN', 25.591316, 85.08799, 'Jai Prakash Narayan Arpt', 5);
INSERT INTO public.airports VALUES (2694, 'Poza Rica', 'PAZ', 'MX', 20.60267, -97.46084, 'Tajin Arpt', -6);
INSERT INTO public.airports VALUES (2695, 'Puebla', 'PBC', 'MX', 19.158144, -98.371445, 'Huejostingo Arpt', -6);
INSERT INTO public.airports VALUES (2696, 'Porbandar', 'PBD', 'IN', 21.648676, 69.65722, 'Porbandar Arpt', 5);
INSERT INTO public.airports VALUES (2697, 'Pine Bluff', 'PBF', 'US', 34.17314, -91.9356, 'Pine Bluff Arpt', -6);
INSERT INTO public.airports VALUES (2698, 'Plattsburgh', 'PBG', 'US', 44.650944, -73.46814, 'Plattsburgh Intl Arpt', -5);
INSERT INTO public.airports VALUES (2699, 'Paro', 'PBH', 'BT', 27.403193, 89.42461, 'Paro Arpt', 6);
INSERT INTO public.airports VALUES (2700, 'West Palm Beach', 'LNA', 'US', 26.593, -80.08505, 'Palm Beach County Arpt', -5);
INSERT INTO public.airports VALUES (2701, 'West Palm Beach', 'PBI', 'US', 26.68316, -80.09559, 'Palm Beach Intl Arpt', -5);
INSERT INTO public.airports VALUES (2702, 'Paramaribo', 'PBM', 'SR', 5.452831, -55.187782, 'Zanderij Intl Arpt', -3);
INSERT INTO public.airports VALUES (2703, 'Paramaribo', 'ORG', 'SR', 5.81108, -55.1907, 'Zorg En Hoop Arpt', -3);
INSERT INTO public.airports VALUES (2704, 'Paraburdoo', 'PBO', 'AU', -23.1711, 117.745, 'Paraburdoo Arpt', 8);
INSERT INTO public.airports VALUES (2705, 'Puerto Barrios', 'PBR', 'GT', 15.730878, -88.58377, 'Puerto Barrios Arpt', -6);
INSERT INTO public.airports VALUES (2706, 'Plettenberg Bay', 'PBZ', 'ZA', 0, 0, 'Plettenberg Bay Arpt', -100);
INSERT INTO public.airports VALUES (2707, 'Prairie Du Chien', 'PCD', 'US', 0, 0, 'Prairie Du Chien Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2708, 'Puerto La Victoria', 'PCJ', 'PY', 0, 0, 'Puerto La Victoria Arpt', -100);
INSERT INTO public.airports VALUES (2709, 'Pucallpa', 'PCL', 'PE', -8.377939, -74.574295, 'Capitan Rolden Arpt', -5);
INSERT INTO public.airports VALUES (2710, 'Playa Del Carmen', 'PCM', 'MX', 0, 0, 'Playa Del Carmen Arpt', -100);
INSERT INTO public.airports VALUES (2711, 'Picton', 'PCN', 'NZ', -41.34833, 173.95528, 'Koromiko', 12);
INSERT INTO public.airports VALUES (2712, 'Princeton', 'PCT', 'US', 0, 0, 'Princeton Arpt', -100);
INSERT INTO public.airports VALUES (2713, 'Padang', 'PDG', 'ID', -0.874989, 100.35188, 'Tabing Arpt', 7);
INSERT INTO public.airports VALUES (2714, 'Ponta Delgada', 'PDL', 'PT', 37.741184, -25.69787, 'Nordela Arpt', -1);
INSERT INTO public.airports VALUES (2715, 'Punta Del Este', 'PDP', 'UY', -34.85514, -55.094276, 'Cap Curbelo Arpt', -3);
INSERT INTO public.airports VALUES (2716, 'Piedras Negras', 'PDS', 'MX', 28.627394, -100.53521, 'Piedras Negras Intl Arpt', -6);
INSERT INTO public.airports VALUES (2717, 'Pendleton', 'PDT', 'US', 45.695, -118.84139, 'Pendleton Municipal', -7);
INSERT INTO public.airports VALUES (2718, 'Paysandu', 'PDU', 'UY', 0, 0, 'Paysandu Arpt', -100);
INSERT INTO public.airports VALUES (2719, 'Plovdiv', 'PDV', 'BG', 42.067806, 24.850834, 'Plovdiv Arpt', 2);
INSERT INTO public.airports VALUES (2720, 'Portland', 'PDX', 'US', 45.588722, -122.5975, 'Portland Intl Arpt', -8);
INSERT INTO public.airports VALUES (2721, 'Pardubice', 'PED', 'CZ', 50.01342, 15.738647, 'Pardubice Arpt', 1);
INSERT INTO public.airports VALUES (2722, 'Perm', 'PEE', 'RU', 57.914516, 56.021214, 'Perm Arpt', 6);
INSERT INTO public.airports VALUES (2723, 'Peenemuende', 'PEF', 'DE', 0, 0, 'Peenemuende Arpt', -100);
INSERT INTO public.airports VALUES (2724, 'Perugia', 'PEG', 'IT', 43.095905, 12.513222, 'Sant Egidio Arpt', 1);
INSERT INTO public.airports VALUES (2725, 'Pereira', 'PEI', 'CO', 4.812675, -75.73952, 'Matecana Arpt', -5);
INSERT INTO public.airports VALUES (2726, 'Peschiei', 'PEJ', 'IT', 0, 0, 'Peschiei Arpt', -100);
INSERT INTO public.airports VALUES (2727, 'Puerto Maldonado', 'PEM', 'PE', -12.613611, -69.228615, 'Puerto Maldonado Arpt', -5);
INSERT INTO public.airports VALUES (2728, 'Penang', 'PEN', 'MY', 5.297139, 100.27686, 'Penang Intl Arpt', 8);
INSERT INTO public.airports VALUES (2729, 'Perth', 'PER', 'AU', -31.940277, 115.96694, 'Perth Arpt', 8);
INSERT INTO public.airports VALUES (2730, 'Petrozavodsk', 'PES', 'RU', 61.8852, 34.1547, 'Petrozavodsk Arpt', 4);
INSERT INTO public.airports VALUES (2731, 'Pelotas', 'PET', 'BR', -31.718353, -52.32769, 'Pelotas Federal Arpt', -3);
INSERT INTO public.airports VALUES (2732, 'Pecs', 'PEV', 'HU', 45.99093, 18.240982, 'Pecs Arpt', 1);
INSERT INTO public.airports VALUES (2733, 'Peshawar', 'PEW', 'PK', 33.99391, 71.51458, 'Peshawar Arpt', 5);
INSERT INTO public.airports VALUES (2734, 'Pechora Airport', 'PEX', 'RU', 65.07039, 57.082047, 'Pechora Airport', 4);
INSERT INTO public.airports VALUES (2735, 'Penza', 'PEZ', 'RU', 53.1106, 45.0211, 'Penza Arpt', 4);
INSERT INTO public.airports VALUES (2736, 'Passo Fundo', 'PFB', 'BR', -28.24399, -52.326557, 'Passo Fundo Arpt', -3);
INSERT INTO public.airports VALUES (2737, 'Panama City', 'ECP', 'US', 30.3417, -85.7973, 'Northwest Florida Beaches Intl Arpt', -6);
INSERT INTO public.airports VALUES (2738, 'Panama City', 'PFN', 'US', 30.212084, -85.68281, 'Bay County Arpt', -6);
INSERT INTO public.airports VALUES (2739, 'Paphos', 'PFO', 'CY', 34.71804, 32.48573, 'Paphos Intl Airport', 2);
INSERT INTO public.airports VALUES (2740, 'Parsabad Arpt', 'PFQ', 'IR', 39.603607, 47.8815, 'Parsabad Arpt', 3);
INSERT INTO public.airports VALUES (2741, 'Page', 'PGA', 'US', 36.9261, -111.4483, 'Page Airport', -7);
INSERT INTO public.airports VALUES (2742, 'Punta Gorda', 'PGD', 'US', 26.919722, -81.990555, 'Charlotte County', -5);
INSERT INTO public.airports VALUES (2743, 'Perpignan', 'PGF', 'FR', 42.74044, 2.870667, 'Llabanere Arpt', 1);
INSERT INTO public.airports VALUES (2744, 'Pantnagar', 'PGH', 'IN', 29.033407, 79.47375, 'Pantnagar Arpt', 5);
INSERT INTO public.airports VALUES (2745, 'Pascagoula', 'PGL', 'US', 0, 0, 'Jackson Cnty', -100);
INSERT INTO public.airports VALUES (2746, 'Pagosa Springs', 'PGO', 'US', 0, 0, 'Stevens Field Arpt', -100);
INSERT INTO public.airports VALUES (2747, 'Ala''Marvdasht Arpt', 'PGU', 'IR', 27.379444, 52.7375, 'Ala''Marvdasht Arpt', 3);
INSERT INTO public.airports VALUES (2748, 'Greenville', 'PGV', 'US', 35.635277, -77.38528, 'Pitt Greenville Arpt', -5);
INSERT INTO public.airports VALUES (2749, 'Perigueux', 'PGX', 'FR', 45.198055, 0.815556, 'Perigueux Arpt', 1);
INSERT INTO public.airports VALUES (2750, 'Parnaiba', 'PHB', 'BR', 0, 0, 'Santos Dumont Airport', -100);
INSERT INTO public.airports VALUES (2751, 'Port Harcourt', 'PHC', 'NG', 5.015494, 6.949594, 'Port Harcourt Arpt', 1);
INSERT INTO public.airports VALUES (2752, 'Port Harcourt', 'PHG', 'NG', 4.85, 7.0167, 'Port Harcourt City Arpt', -100);
INSERT INTO public.airports VALUES (2753, 'Port Hedland', 'PHE', 'AU', -20.377777, 118.62639, 'Port Hedland Arpt', 8);
INSERT INTO public.airports VALUES (2754, 'Newport News', 'PHF', 'US', 37.131893, -76.49299, 'Williamsburg Intl Arpt', -5);
INSERT INTO public.airports VALUES (2755, 'Phan Thiet', 'PHH', 'VN', 0, 0, 'Phan Thiet Arpt', -100);
INSERT INTO public.airports VALUES (2756, 'Philadelphia', 'PNE', 'US', 40.081944, -75.01059, 'N Philadelphia', -5);
INSERT INTO public.airports VALUES (2757, 'Philadelphia', 'PHL', 'US', 39.871944, -75.24114, 'Philadelphia Intl Arpt', -5);
INSERT INTO public.airports VALUES (2758, 'Port Huron', 'PHN', 'US', 42.910957, -82.52886, 'St Clair County Intl Arpt', -5);
INSERT INTO public.airports VALUES (2759, 'Phitsanulok', 'PHS', 'TH', 16.78294, 100.27912, 'Phitsanulok Arpt', 7);
INSERT INTO public.airports VALUES (2760, 'Paris', 'PHT', 'US', 39.7002, -87.6696, 'Henry County Arpt', -100);
INSERT INTO public.airports VALUES (2761, 'Phalaborwa', 'PHW', 'ZA', -23.937166, 31.15539, 'Phalaborwa Arpt', 2);
INSERT INTO public.airports VALUES (2762, 'Phoenix', 'PHX', 'US', 33.434277, -112.01158, 'Sky Harbor Intl Arpt', -7);
INSERT INTO public.airports VALUES (2763, 'Phoenix', 'AZA', 'US', 33.307835, -111.655, 'Williams Gateway Arpt', -7);
INSERT INTO public.airports VALUES (2764, 'Phoenix', 'DVT', 'US', 33.4117, 112.457, 'Phoenix Deer Valley Airport', -7);
INSERT INTO public.airports VALUES (2765, 'Peoria', 'PIA', 'US', 40.664204, -89.69326, 'Greater Peoria Arpt', -6);
INSERT INTO public.airports VALUES (2766, 'Pocatello', 'PIH', 'US', 42.9098, -112.596, 'Pocatello Municipal Arpt', -7);
INSERT INTO public.airports VALUES (2767, 'Pierre', 'PIR', 'US', 44.3827, -100.286, 'Pierre Municipal', -6);
INSERT INTO public.airports VALUES (2768, 'Poitiers', 'XOP', 'FR', 46.58, 0.3, 'Poitiers Rail Station', -100);
INSERT INTO public.airports VALUES (2769, 'Poitiers', 'PIS', 'FR', 46.587746, 0.306666, 'Biard Airport', 1);
INSERT INTO public.airports VALUES (2770, 'Pittsburgh', 'AGC', 'US', 40.3544, -79.9302, 'Allegheny Cty Arpt', -5);
INSERT INTO public.airports VALUES (2771, 'Pittsburgh', 'PIT', 'US', 40.491467, -80.23287, 'Pittsburgh Intl Arpt', -5);
INSERT INTO public.airports VALUES (2772, 'Piura', 'PIU', 'PE', -5.20575, -80.61645, 'Piura Arpt', -5);
INSERT INTO public.airports VALUES (2773, 'Pikwitonei', 'PIW', 'CA', 55.5889, -97.1642, 'Pikwitonei Rail Station', -100);
INSERT INTO public.airports VALUES (2774, 'Pico Island', 'PIX', 'PT', 38.554333, -28.441334, 'Pico Arpt', -1);
INSERT INTO public.airports VALUES (2775, 'Point Lay', 'PIZ', 'US', 69.73287, -163.00534, 'Dew Station Arpt', -9);
INSERT INTO public.airports VALUES (2776, 'Pajala', 'PJA', 'SE', 67.2456, 23.0689, 'Pajala Arpt', 1);
INSERT INTO public.airports VALUES (2777, 'Payson', 'PJB', 'US', 0, 0, 'Payson Arpt', -100);
INSERT INTO public.airports VALUES (2778, 'Parkersburg', 'PKB', 'US', 39.345104, -81.4392, 'Wood County', -5);
INSERT INTO public.airports VALUES (2779, 'Petropavlovsk Kamchatskiy', 'PKC', 'RU', 53.16789, 158.45367, 'Petropavlovsk Kamchatskiy Arpt', 12);
INSERT INTO public.airports VALUES (2780, 'Park Rapids', 'PKD', 'US', 46.9006, -95.0731, 'Park Rapids Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2781, 'Parkes', 'PKE', 'AU', -33.1314, 148.239, 'Parkes Arpt', 10);
INSERT INTO public.airports VALUES (2782, 'Pangkor', 'PKG', 'MY', 4.24472, 100.553, 'Pangkor Arpt', 8);
INSERT INTO public.airports VALUES (2783, 'Portoheli', 'PKH', 'GR', 37.298794, 23.148987, 'Alexion Arpt', 2);
INSERT INTO public.airports VALUES (2784, 'Playa Grande', 'PKJ', 'GT', 0, 0, 'Playa Grand Arpt', -100);
INSERT INTO public.airports VALUES (2785, 'Pangkalanbun', 'PKN', 'ID', -2.705197, 111.67321, 'Pangkalanbuun Arpt', 7);
INSERT INTO public.airports VALUES (2786, 'Pokhara', 'PKR', 'NP', 28.20088, 83.982056, 'Pokhara Arpt', 5);
INSERT INTO public.airports VALUES (2787, 'Pekanbaru', 'PKU', 'ID', 0.460786, 101.44454, 'Simpang Tiga Arpt', 7);
INSERT INTO public.airports VALUES (2788, 'Pskov', 'PKV', 'RU', 57.783916, 28.395615, 'Pskov Arpt', 4);
INSERT INTO public.airports VALUES (2789, 'Selebi Phikwe', 'PKW', 'BW', -22.05835, 27.828768, 'Selebi Phikwe Arpt', 2);
INSERT INTO public.airports VALUES (2790, 'Pakse', 'PKZ', 'LA', 15.132053, 105.78142, 'Pakse Arpt', 7);
INSERT INTO public.airports VALUES (2791, 'Playa Samara', 'PLD', 'CR', 10.25, -85.417, 'Playa Samara Arpt', -6);
INSERT INTO public.airports VALUES (2792, 'Plymouth', 'PLH', 'GB', 50.42278, -4.105833, 'Roborough Arpt', 0);
INSERT INTO public.airports VALUES (2793, 'Placencia', 'PLJ', 'BZ', 16.536943, -88.361664, 'Placencia Arpt', -6);
INSERT INTO public.airports VALUES (2794, 'Point Lookout', 'PLK', 'US', 0, 0, 'M Graham Clark Arpt', -100);
INSERT INTO public.airports VALUES (2795, 'Palembang', 'PLM', 'ID', -2.89825, 104.699905, 'Mahmud Badaruddin Li Arpt', 7);
INSERT INTO public.airports VALUES (2796, 'Pellston', 'PLN', 'US', 45.5709, -84.7967, 'Emmet Cty Arpt', -5);
INSERT INTO public.airports VALUES (2797, 'Port Lincoln', 'PLO', 'AU', -34.6053, 135.88, 'Port Lincoln Arpt', 9);
INSERT INTO public.airports VALUES (2798, 'LA PALMA', 'PLP', 'PA', 8.40667, -78.1417, 'LA PALMA', -5);
INSERT INTO public.airports VALUES (2799, 'Palanga', 'PLQ', 'LT', 55.97323, 21.093857, 'Palanga Intl Arpt', 2);
INSERT INTO public.airports VALUES (2800, 'Providenciales', 'PLS', 'TC', 21.773624, -72.265884, 'Providenciales Intl', -5);
INSERT INTO public.airports VALUES (2801, 'Poltava', 'PLV', 'UA', 49.34261, 34.23551, 'Poltava Arpt', 3);
INSERT INTO public.airports VALUES (2802, 'Palu', 'PLW', 'ID', -0.918542, 119.909645, 'Mutiara Arpt', 8);
INSERT INTO public.airports VALUES (2803, 'SEMIPALATINSK', 'PLX', 'KZ', 50.3513, 80.2344, 'SEMIPALATINSK', 6);
INSERT INTO public.airports VALUES (2804, 'Plymouth', 'PLY', 'US', 0, 0, 'Plymouth Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2805, 'Port Elizabeth', 'PLZ', 'ZA', -33.98492, 25.617275, 'Port Elizabeth Airport', 2);
INSERT INTO public.airports VALUES (2806, 'Puerto Montt', 'PMC', 'CL', -41.438885, -73.093956, 'Tepual Arpt', -4);
INSERT INTO public.airports VALUES (2807, 'Palmdale', 'PMD', 'US', 34.62939, -118.08456, 'La Palmdale Regional Arpt', -8);
INSERT INTO public.airports VALUES (2808, 'Portsmouth', 'PME', 'GB', 50.8, -1.083333, 'Portsmouth Arpt', 0);
INSERT INTO public.airports VALUES (2809, 'Parma', 'PMF', 'IT', 44.824482, 10.296367, 'Parma Arpt', 1);
INSERT INTO public.airports VALUES (2810, 'Ponta Pora', 'PMG', 'BR', -22.549639, -55.702614, 'International', -4);
INSERT INTO public.airports VALUES (2811, 'Palma Mallorca', 'PMI', 'ES', 39.55361, 2.727778, 'Palma Mallorca Arpt', 1);
INSERT INTO public.airports VALUES (2812, 'Palm Island', 'PMK', 'AU', -18.7553, 146.581, 'Palm Island Arpt', 10);
INSERT INTO public.airports VALUES (2813, 'Palermo', 'PMO', 'IT', 38.175957, 13.091019, 'Punta Raisi Arpt', 1);
INSERT INTO public.airports VALUES (2814, 'Palmerston', 'PMR', 'NZ', -40.320557, 175.61694, 'Palmerston North Arpt', 12);
INSERT INTO public.airports VALUES (2815, 'Palmyra', 'PMS', 'SY', 34.55736, 38.31689, 'Palmyra Arpt', 2);
INSERT INTO public.airports VALUES (2816, 'Porlamar', 'PMV', 'VE', 10.912926, -63.967583, 'Delcaribe Gen S Marino Arpt', -4);
INSERT INTO public.airports VALUES (2817, 'Palmas', 'PMW', 'BR', -10.241667, -48.35278, 'Palmas Arpt', -3);
INSERT INTO public.airports VALUES (2818, 'Puerto Madryn', 'PMY', 'AR', -42.759163, -65.10272, 'El Tehuelche Arpt', -3);
INSERT INTO public.airports VALUES (2819, 'Palmar', 'PMZ', 'CR', 8.951025, -83.46858, 'Palmar Sur', -6);
INSERT INTO public.airports VALUES (2820, 'Pamplona', 'PNA', 'ES', 42.77004, -1.646331, 'Pamplona Noain Arpt', 1);
INSERT INTO public.airports VALUES (2821, 'Ponca City', 'PNC', 'US', 36.731956, -97.09978, 'Ponca City Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2822, 'Paranagua', 'PNG', 'BR', -25.54, -48.5306, 'Paranagua Municipal', -100);
INSERT INTO public.airports VALUES (2823, 'Phnom Penh', 'PNH', 'KH', 11.546556, 104.84414, 'Pochentong Arpt', 7);
INSERT INTO public.airports VALUES (2824, 'Pohnpei', 'PNI', 'FM', 6.9851, 158.20898, 'Pohnpei Arpt', 11);
INSERT INTO public.airports VALUES (2825, 'Penglai', 'PNJ', 'CN', 0, 0, 'Sha He Kou Arpt', -100);
INSERT INTO public.airports VALUES (2826, 'Pontianak', 'PNK', 'ID', -0.150711, 109.40389, 'Supadio International Arpt', 7);
INSERT INTO public.airports VALUES (2827, 'Pantelleria', 'PNL', 'IT', 36.81652, 11.968864, 'Pantelleria Arpt', 1);
INSERT INTO public.airports VALUES (2828, 'Pinotepa Nacional', 'PNO', 'MX', 0, 0, 'Pinotepa Nacional Arpt', -100);
INSERT INTO public.airports VALUES (2829, 'Popondetta', 'PNP', 'PG', -8.80454, 148.309, 'Girua Arpt', 10);
INSERT INTO public.airports VALUES (2830, 'Pune', 'PNQ', 'IN', 18.582111, 73.9197, 'Lohegaon Arpt', 5);
INSERT INTO public.airports VALUES (2831, 'Pointe Noire', 'PNR', 'CG', -4.816028, 11.886597, 'Pointe Noire Arpt', 1);
INSERT INTO public.airports VALUES (2832, 'Pensacola', 'PNS', 'US', 30.473425, -87.18661, 'Pensacola Regional Municipal', -6);
INSERT INTO public.airports VALUES (2833, 'Puerto Natales', 'PNT', 'CL', -51.733334, -72.51667, 'Teniente Julio Gallardo Arpt', -3);
INSERT INTO public.airports VALUES (2834, 'Sherman', 'PNX', 'US', 0, 0, 'Grayson County Arpt', -100);
INSERT INTO public.airports VALUES (2835, 'Petrolina', 'PNZ', 'BR', -9.362411, -40.569096, 'Petrolina Internacional Arpt', -3);
INSERT INTO public.airports VALUES (2836, 'Porto Alegre', 'POA', 'BR', -29.994429, -51.17143, 'Porto Alegre Airport', -3);
INSERT INTO public.airports VALUES (2837, 'La Verne', 'POC', 'US', 0, 0, 'Brackett Field', -100);
INSERT INTO public.airports VALUES (2838, 'Fort Polk', 'POE', 'US', 31.044832, -93.191666, 'Fort Polk Arpt', -6);
INSERT INTO public.airports VALUES (2839, 'Poplar Bluff', 'POF', 'US', 36.7739, -90.3248, 'Earl Fields Memorial', -100);
INSERT INTO public.airports VALUES (2840, 'Port Gentil', 'POG', 'GA', -0.711739, 8.754383, 'Port Gentil Arpt', 1);
INSERT INTO public.airports VALUES (2841, 'Pemba', 'POL', 'MZ', -12.986753, 40.52249, 'Pemba Arpt', 2);
INSERT INTO public.airports VALUES (2842, 'Port Moresby', 'POM', 'PG', -9.443383, 147.22005, 'Jackson Field', 10);
INSERT INTO public.airports VALUES (2843, 'Puerto Plata', 'POP', 'DO', 19.7579, -70.57003, 'La Union Arpt', -4);
INSERT INTO public.airports VALUES (2844, 'Pori', 'POR', 'FI', 61.461685, 21.799982, 'Pori Airport', 2);
INSERT INTO public.airports VALUES (2845, 'Port Of Spain', 'POS', 'TT', 10.595369, -61.337242, 'Piarco Arpt', -4);
INSERT INTO public.airports VALUES (2846, 'Poughkeepsie', 'POU', 'US', 41.6266, -73.8842, 'Dutchess County', -100);
INSERT INTO public.airports VALUES (2847, 'Portoroz', 'POW', 'SI', 45.473354, 13.614978, 'Portoroz Airport', 1);
INSERT INTO public.airports VALUES (2848, 'Pontoise', 'POX', 'FR', 49.096645, 2.040833, 'Cormeille En Vexin', 1);
INSERT INTO public.airports VALUES (2849, 'Poznan', 'POZ', 'PL', 52.421032, 16.826324, 'Lawica Arpt', 1);
INSERT INTO public.airports VALUES (2850, 'Presidente Prudente', 'PPB', 'BR', -22.175056, -51.42464, 'A De Barros', -3);
INSERT INTO public.airports VALUES (2851, 'Puerto Penasco', 'PPE', 'MX', 31.351877, -113.52573, 'Puerto Penasco Municipal', -7);
INSERT INTO public.airports VALUES (2852, 'Pago Pago', 'PPG', 'AS', -14.331, -170.7105, 'Pago Pago Arpt', -11);
INSERT INTO public.airports VALUES (2853, 'Port Pirie', 'PPI', 'AU', -33.2389, 137.995, 'Port Porie Arpt', -100);
INSERT INTO public.airports VALUES (2854, 'Petropavlovsk', 'PPK', 'KZ', 54.7747, 69.1839, 'Petropavlovsk Arpt', 6);
INSERT INTO public.airports VALUES (2855, 'Phaplu', 'PPL', 'NP', 27.517, 86.6, 'Phaplu Airport', 5);
INSERT INTO public.airports VALUES (2856, 'Pompano Beach', 'PPM', 'US', 0, 0, 'Pompano Beach Arpt', -100);
INSERT INTO public.airports VALUES (2857, 'Popayan', 'PPN', 'CO', 2.4544, -76.60932, 'Machangara Arpt', -5);
INSERT INTO public.airports VALUES (2858, 'Proserpine', 'PPP', 'AU', -20.495, 148.55222, 'Whitsunday Coast Arpt', 10);
INSERT INTO public.airports VALUES (2859, 'Paraparaumu', 'PPQ', 'NZ', -40.90472, 174.98917, 'Paraparaumu Arpt', 12);
INSERT INTO public.airports VALUES (2860, 'Puerto Princesa', 'PPS', 'PH', 9.742119, 118.75873, 'Puerto Princesa Arpt', 8);
INSERT INTO public.airports VALUES (2861, 'Papeete', 'PPT', 'PF', -17.556667, -149.61139, 'Intl Tahiti Faaa', -10);
INSERT INTO public.airports VALUES (2862, 'Papa Westray', 'PPW', 'GB', 59.3517, -2.90028, 'Papa Westray Arpt', 0);
INSERT INTO public.airports VALUES (2863, 'Phu Quoc', 'PQC', 'VN', 10.227025, 103.96717, 'Duong Dang Arpt', 7);
INSERT INTO public.airports VALUES (2864, 'Presque Isle', 'PQI', 'US', 46.688957, -68.0448, 'Northern Maine Regional', -4);
INSERT INTO public.airports VALUES (2865, 'Palenque', 'PQM', 'MX', 0, 0, 'Palenque Arpt', -100);
INSERT INTO public.airports VALUES (2866, 'Pt Macquarie', 'PQQ', 'AU', -31.4358, 152.863, 'Port Macquarie Arpt', 10);
INSERT INTO public.airports VALUES (2867, 'Parana', 'PRA', 'AR', -31.794779, -60.480362, 'Parana Arpt', -3);
INSERT INTO public.airports VALUES (2868, 'Paso Robles', 'PRB', 'US', 35.6729, -120.6271, 'Paso Robles Cty', -100);
INSERT INTO public.airports VALUES (2869, 'Prescott', 'PRC', 'US', 34.654472, -112.419586, 'Prescott Municipal', -7);
INSERT INTO public.airports VALUES (2870, 'Prague', 'PRG', 'CZ', 50.100834, 14.26, 'Ruzyne Arpt', 1);
INSERT INTO public.airports VALUES (2871, 'Phrae', 'PRH', 'TH', 18.13217, 100.164665, 'Phrae Arpt', 7);
INSERT INTO public.airports VALUES (2872, 'Praslin Island', 'PRI', 'SC', -4.319292, 55.691418, 'Praslin Island Arpt', 4);
INSERT INTO public.airports VALUES (2873, 'Portimao', 'PRM', 'PT', 37.1499, -8.584, 'Portimao Airport', -100);
INSERT INTO public.airports VALUES (2874, 'Pristina', 'PRN', 'KV', 42.572777, 21.035833, 'Pristina Arpt', 1);
INSERT INTO public.airports VALUES (2875, 'Propriano', 'PRP', 'FR', 0, 0, 'Propriano Arpt', -100);
INSERT INTO public.airports VALUES (2876, 'Paris', 'PRX', 'US', 0, 0, 'Paris Cox Field Arpt', -100);
INSERT INTO public.airports VALUES (2877, 'Pretoria', 'PRY', 'ZA', -25.653858, 28.224232, 'Wonderboom Arpt', 2);
INSERT INTO public.airports VALUES (2878, 'Pretoria', 'HPR', 'ZA', 0, 0, 'Central Hpr Arpt', -100);
INSERT INTO public.airports VALUES (2879, 'Pisa', 'PSA', 'IT', 43.683918, 10.39275, 'Gal Galilei Arpt', 1);
INSERT INTO public.airports VALUES (2880, 'Philipsburg', 'PSB', 'US', 0, 0, 'Midstate Arpt', -100);
INSERT INTO public.airports VALUES (2881, 'Pasco', 'PSC', 'US', 46.2647, -119.119, 'Tri Cities Arpt', -8);
INSERT INTO public.airports VALUES (2882, 'Ponce', 'PSE', 'US', 18.008307, -66.56303, 'Mercedita Arpt', -4);
INSERT INTO public.airports VALUES (2883, 'Pittsfield', 'PSF', 'US', 39.6389, -90.7784, 'Pittsfield Municipal', -100);
INSERT INTO public.airports VALUES (2884, 'Petersburg', 'PSG', 'US', 56.801666, -132.94528, 'Petersburg Municipal', -9);
INSERT INTO public.airports VALUES (2885, 'Dublin', 'PSK', 'US', 0, 0, 'New River Valley Arpt', -100);
INSERT INTO public.airports VALUES (2886, 'Perth', 'PSL', 'GB', 56.4392, -3.3722, 'Perth Airport', -100);
INSERT INTO public.airports VALUES (2887, 'Portsmouth', 'PSM', 'US', 43.0779, -70.8233, 'Portsmouth Pease Intl Arpt', -5);
INSERT INTO public.airports VALUES (2888, 'Pasto', 'PSO', 'CO', 1.396247, -77.29148, 'Cano Arpt', -5);
INSERT INTO public.airports VALUES (2889, 'Palm Springs', 'PSP', 'US', 33.829666, -116.50669, 'Palm Springs Municipal', -8);
INSERT INTO public.airports VALUES (2890, 'Pescara', 'PSR', 'IT', 42.431656, 14.181067, 'Liberi Airport', 1);
INSERT INTO public.airports VALUES (2891, 'Posadas', 'PSS', 'AR', -27.38584, -55.97073, 'Posadas Arpt', -3);
INSERT INTO public.airports VALUES (2892, 'Petersburg', 'PTB', 'US', 0, 0, 'Petersburg Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2893, 'Malololailai', 'PTF', 'FJ', -17.7779, 177.197, 'Malololailai Arpt', 12);
INSERT INTO public.airports VALUES (2894, 'Pietersburg', 'PTG', 'ZA', -23.926088, 29.484423, 'Pietersburg Arpt', 2);
INSERT INTO public.airports VALUES (2895, 'Port Douglas', 'PTI', 'AU', 0, 0, 'Port Douglas Arpt', -100);
INSERT INTO public.airports VALUES (2896, 'Portland', 'PTJ', 'AU', -38.3181, 141.471, 'Portland Arpt', 10);
INSERT INTO public.airports VALUES (2897, 'Pontiac', 'PTK', 'US', 42.6655, -83.4201, 'Oakland Pontiac Arpt', -100);
INSERT INTO public.airports VALUES (2898, 'Pato Branco', 'PTO', 'BR', -26.2172, -52.6936, 'Pato Branco Municipal', -100);
INSERT INTO public.airports VALUES (2899, 'Pointe A Pitre', 'PTP', 'GP', 16.265306, -61.531807, 'Le Raizet Arpt', -4);
INSERT INTO public.airports VALUES (2900, 'Pittsburg', 'PTS', 'US', 0, 0, 'Atkinson Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2901, 'Pottstown', 'PTW', 'US', 0, 0, 'Pottstown Limerick', -100);
INSERT INTO public.airports VALUES (2902, 'Panama City', 'PTY', 'PA', 9.071364, -79.38345, 'Tocumen Intl Arpt', -5);
INSERT INTO public.airports VALUES (2903, 'Panama City', 'PAC', 'PA', 8.973339, -79.55558, 'Paitilla Arpt', -5);
INSERT INTO public.airports VALUES (2904, 'Pueblo', 'PUB', 'US', 38.289085, -104.496574, 'Pueblo Arpt', -7);
INSERT INTO public.airports VALUES (2905, 'Pueblo', 'TAD', 'US', 0, 0, 'Las Animas Arpt', -100);
INSERT INTO public.airports VALUES (2906, 'Price', 'PUC', 'US', 39.609722, -110.75278, 'Carbon Cty Municipal Arpt', -6);
INSERT INTO public.airports VALUES (2907, 'Pau Fr', 'PUF', 'FR', 43.38, -0.418611, 'Uzein Airport', 1);
INSERT INTO public.airports VALUES (2908, 'Port Augusta', 'PUG', 'AU', -32.506943, 137.71666, 'Port Augusta Arpt', 9);
INSERT INTO public.airports VALUES (2909, 'Punta Cana', 'PUJ', 'DO', 18.567368, -68.363434, 'Punta Cana Arpt', -4);
INSERT INTO public.airports VALUES (2910, 'Punta Arenas', 'PUQ', 'CL', -53.002644, -70.85458, 'Presidente Ibanez Arpt', -4);
INSERT INTO public.airports VALUES (2911, 'Busan', 'PUS', 'KR', 35.179527, 128.93822, 'Kimhae Arpt', 9);
INSERT INTO public.airports VALUES (2912, 'Pullman', 'PUW', 'US', 46.743862, -117.10958, 'Pullman Moscow Arpt', -8);
INSERT INTO public.airports VALUES (2913, 'Puerto Varas', 'PUX', 'CL', 0, 0, 'Puerto Varas Arpt', -100);
INSERT INTO public.airports VALUES (2914, 'Pula', 'PUY', 'HR', 44.89353, 13.922192, 'Pula Arpt', 1);
INSERT INTO public.airports VALUES (2915, 'Provincetown', 'PVC', 'US', 42.071945, -70.22139, 'Provincetown Municipal', -5);
INSERT INTO public.airports VALUES (2916, 'Providence', 'PVD', 'US', 41.732582, -71.42038, 'T F Green St Arpt', -5);
INSERT INTO public.airports VALUES (2917, 'Placerville', 'PVF', 'US', 0, 0, 'Placerville Arpt', -100);
INSERT INTO public.airports VALUES (2918, 'Porto Velho', 'PVH', 'BR', -8.709294, -63.902283, 'Belmonte Arpt', -4);
INSERT INTO public.airports VALUES (2919, 'Preveza', 'PVK', 'GR', 38.92547, 20.76531, 'Aktion Arpt', 2);
INSERT INTO public.airports VALUES (2920, 'Puerto Vallarta', 'PVR', 'MX', 20.680082, -105.254166, 'Ordaz Arpt', -6);
INSERT INTO public.airports VALUES (2921, 'Provideniya Bay Airport', 'PVS', 'RU', 64.378136, -173.2433, 'Provideniya Bay Airport', 12);
INSERT INTO public.airports VALUES (2922, 'Provo', 'PVU', 'US', 40.218056, -111.72222, 'Provo Arpt', -6);
INSERT INTO public.airports VALUES (2923, 'Plainview', 'PVW', 'US', 0, 0, 'Hale County Arpt', -100);
INSERT INTO public.airports VALUES (2924, 'Painesville', 'PVZ', 'US', 0, 0, 'Casement Arpt', -100);
INSERT INTO public.airports VALUES (2925, 'Pevek Airport', 'PWE', 'RU', 69.78328, 170.597, 'Pevek Airport', 12);
INSERT INTO public.airports VALUES (2926, 'Portland', 'PWM', 'US', 43.64616, -70.30928, 'Portland Intl Jetport', -5);
INSERT INTO public.airports VALUES (2927, 'Pavlodar', 'PWQ', 'KZ', 52.195, 77.07389, 'Pavlodar Arpt', 6);
INSERT INTO public.airports VALUES (2928, 'Bremerton', 'PWT', 'US', 47.490246, -122.76482, 'Bremerton Municipal', -8);
INSERT INTO public.airports VALUES (2929, 'Puerto Escondido', 'PXM', 'MX', 15.876861, -97.08912, 'Puerto Escondido Municipal', -6);
INSERT INTO public.airports VALUES (2930, 'Porto Santo', 'PXO', 'PT', 33.073387, -16.349976, 'Porto Santo Arpt', 0);
INSERT INTO public.airports VALUES (2931, 'Pleiku', 'PXU', 'VN', 14.004522, 108.01716, 'Pleiku Arpt', 7);
INSERT INTO public.airports VALUES (2932, 'Polyarny Airport', 'PYJ', 'RU', 66.40043, 112.03033, 'Polyarny Airport', 10);
INSERT INTO public.airports VALUES (2933, 'Plymouth', 'PYM', 'US', 41.909027, -70.728775, 'Plymouth Arpt', -4);
INSERT INTO public.airports VALUES (2934, 'Pattaya', 'PYX', 'TH', 0, 0, 'Pattaya Arpt', -100);
INSERT INTO public.airports VALUES (2935, 'Pai City', 'PYY', 'TH', 19.372, 98.437, 'Pai Arpt', 7);
INSERT INTO public.airports VALUES (2936, 'Pietermaritzburg', 'PZB', 'ZA', -29.648975, 30.398666, 'Pietermaritzburg Arpt', 2);
INSERT INTO public.airports VALUES (2937, 'Penzance', 'PZE', 'GB', 50.1281, -5.51845, 'Penzance Arpt', 0);
INSERT INTO public.airports VALUES (2938, 'Panzhihua', 'PZI', 'CN', 26.54, 101.799, 'Pan Zhi Hua Bao An Ying Arpt', 8);
INSERT INTO public.airports VALUES (2939, 'Puerto Ordaz', 'PZO', 'VE', 8.288528, -62.76036, 'Puerto Ordaz Arpt', -4);
INSERT INTO public.airports VALUES (2940, 'Port Sudan', 'PZU', 'SD', 19.4336, 37.2341, 'Port Sudan New intl Arpt', 2);
INSERT INTO public.airports VALUES (2941, 'Piestany', 'PZY', 'SK', 48.625248, 17.828444, 'Piestany Arpt', 1);
INSERT INTO public.airports VALUES (2942, 'Arnhem', 'ZYM', 'NL', 0, 0, 'Arnhem Rail Station', -100);
INSERT INTO public.airports VALUES (2943, 'Bella Coola', 'QBC', 'CA', 52.3875, -126.596, 'Bella Colla Municipal', -8);
INSERT INTO public.airports VALUES (2944, 'Copper Mountain', 'QCE', 'US', 0, 0, 'Copper Mountain Van Service', -100);
INSERT INTO public.airports VALUES (2945, 'Ashford', 'QDH', 'GB', 0, 0, 'Ashford Intl Rail Station', -100);
INSERT INTO public.airports VALUES (2946, 'Leicester', 'XGM', 'GB', 0, 0, 'Grantham Rail Station', -100);
INSERT INTO public.airports VALUES (2947, 'Maloy', 'QFQ', 'NO', 0, 0, 'Harbour Arpt', -100);
INSERT INTO public.airports VALUES (2948, 'Novo Hamburgo', 'QHV', 'BR', 0, 0, 'Novo Hamburgo Arpt', -100);
INSERT INTO public.airports VALUES (2949, 'Iguatu', 'QIG', 'BR', -6.3475, -39.2983, 'Iguatu Arpt', -100);
INSERT INTO public.airports VALUES (2950, 'Breckenridge', 'QKB', 'US', 0, 0, 'Breckenridge Van Service', -100);
INSERT INTO public.airports VALUES (2951, 'Keystone', 'QKS', 'US', 0, 0, 'Keystone Van Service', -100);
INSERT INTO public.airports VALUES (2952, 'Leeton', 'QLE', 'AU', 0, 0, 'Leeton Arpt', -100);
INSERT INTO public.airports VALUES (2953, 'Niteroi', 'QNT', 'BR', 0, 0, 'Niteroi Arpt', -100);
INSERT INTO public.airports VALUES (2954, 'Bath', 'QQX', 'GB', 0, 0, 'Bath Rail Service', -100);
INSERT INTO public.airports VALUES (2955, 'York', 'QQY', 'GB', 0, 0, 'York Rail Station', -100);
INSERT INTO public.airports VALUES (2956, 'Queretaro', 'QRO', 'MX', 20.617289, -100.18566, 'Queretaro Arpt', -6);
INSERT INTO public.airports VALUES (2957, 'Arras', 'QRV', 'FR', 0, 0, 'Arras Arpt', -100);
INSERT INTO public.airports VALUES (2958, 'Setif', 'QSF', 'DZ', 36.1781, 5.32449, 'Setif Arpt', 0);
INSERT INTO public.airports VALUES (2959, 'Aix En Provence', 'QXB', 'FR', 43.505554, 5.367778, 'Aix en Provence Rail Station', 1);
INSERT INTO public.airports VALUES (2960, 'Hengelo', 'QYH', 'NL', 0, 0, 'Hengelo Railway Service', -100);
INSERT INTO public.airports VALUES (2961, 'Amersfoort', 'QYM', 'NL', 0, 0, 'Amersfoort Railway Service', -100);
INSERT INTO public.airports VALUES (2962, 'Olsztyn', 'QYO', 'PL', 0, 0, 'Olsztyn Arpt', -100);
INSERT INTO public.airports VALUES (2963, 'Uppsala', 'QYX', 'SE', 59.9008, 17.5958, 'Uppsala Railway Service', -100);
INSERT INTO public.airports VALUES (2964, 'Rabaul', 'RAB', 'PG', -4.34046, 152.38, 'Lakunai Arpt', 10);
INSERT INTO public.airports VALUES (2965, 'Racine', 'RAC', 'US', 0, 0, 'Horlick Arpt', -100);
INSERT INTO public.airports VALUES (2966, 'Praia', 'RAI', 'CV', 14.9245, -23.4935, 'Francisco Mendes', -1);
INSERT INTO public.airports VALUES (2967, 'Rajkot', 'RAJ', 'IN', 22.309183, 70.779526, 'Rajkot Civil Arpt', 5);
INSERT INTO public.airports VALUES (2968, 'Marrakech', 'RAK', 'MA', 31.606886, -8.0363, 'Menara Airport', 0);
INSERT INTO public.airports VALUES (2969, 'Riverside', 'RAL', 'US', 33.951874, -117.44511, 'Riverside Municipal', -8);
INSERT INTO public.airports VALUES (2970, 'Ribeirao Preto', 'RAO', 'BR', -21.134167, -47.77419, 'Leite Lopes', -3);
INSERT INTO public.airports VALUES (2971, 'Rapid City', 'RAP', 'US', 44.045277, -103.05722, 'Rapid City Regional Arpt', -7);
INSERT INTO public.airports VALUES (2972, 'Rarotonga', 'RAR', 'CK', -21.20274, -159.80556, 'Rarotonga Arpt', -10);
INSERT INTO public.airports VALUES (2973, 'Raduzhny Airport', 'RAT', 'RU', 62.1586, 77.3289, 'Raduzhny Airport', 6);
INSERT INTO public.airports VALUES (2974, 'Rothesay', 'RAY', 'GB', 0, 0, 'Rothesay Heliport', -100);
INSERT INTO public.airports VALUES (2975, 'Rabat', 'RBA', 'MA', 34.051468, -6.751519, 'Sale Airport', 0);
INSERT INTO public.airports VALUES (2976, 'Big Bear City', 'RBF', 'US', 0, 0, 'Big Bear City Arpt', -100);
INSERT INTO public.airports VALUES (2977, 'Roseburg', 'RBG', 'US', 0, 0, 'Roseburg Municipal', -100);
INSERT INTO public.airports VALUES (2978, 'Straubing', 'RBM', 'DE', 34.85009, -92.300156, 'Wallmuhle', -6);
INSERT INTO public.airports VALUES (2979, 'Rio Branco', 'RBR', 'BR', -9.583, -67.4836, 'Pres Medici Arpt', -5);
INSERT INTO public.airports VALUES (2980, 'Walterboro', 'RBW', 'US', 0, 0, 'Walterboro Municipal Arpt', -100);
INSERT INTO public.airports VALUES (2981, 'Richards Bay', 'RCB', 'ZA', -28.74104, 32.09211, 'Richards Bay Arpt', 2);
INSERT INTO public.airports VALUES (2982, 'Roche Harbor', 'RCE', 'US', 48.608055, -123.15972, 'Roche Harbor Arpt', -8);
INSERT INTO public.airports VALUES (2983, 'Rochefort', 'RCO', 'FR', 45.88778, -0.983056, 'St Agnant Arpt', 1);
INSERT INTO public.airports VALUES (2984, 'Rio Cuarto', 'RCU', 'AR', -33.08513, -64.261314, 'Rio Cuarto Arpt', -3);
INSERT INTO public.airports VALUES (2985, 'Redding', 'RDD', 'US', 40.509, -122.29339, 'Redding Municipal Arpt', -8);
INSERT INTO public.airports VALUES (2986, 'Redding', 'RBL', 'US', 40.1506, -122.2523, 'Flight Service Station', -100);
INSERT INTO public.airports VALUES (2987, 'Reading', 'RDG', 'US', 40.3785, -75.9652, 'Reading Municipal', -5);
INSERT INTO public.airports VALUES (2988, 'Redmond', 'RDM', 'US', 44.254066, -121.14996, 'Roberts Field', -8);
INSERT INTO public.airports VALUES (2989, 'Redang', 'RDN', 'MY', 5.76528, 103.007, 'Lts Pulau Redang Arpt', 8);
INSERT INTO public.airports VALUES (2990, 'Raleigh', 'RDU', 'US', 35.87764, -78.787476, 'Raleigh Durham Intl Arpt', -5);
INSERT INTO public.airports VALUES (2991, 'Rodez', 'RDZ', 'FR', 44.407867, 2.482672, 'Marcillac', 1);
INSERT INTO public.airports VALUES (2992, 'Recife', 'REC', 'BR', -8.126794, -34.92304, 'Recife Airport', -3);
INSERT INTO public.airports VALUES (2993, 'Reggio Calabria', 'REG', 'IT', 38.071205, 15.651556, 'Tito Menniti Arpt', 1);
INSERT INTO public.airports VALUES (2994, 'Reykjavik', 'KEF', 'IS', 63.985, -22.605556, 'Reykjavik Keflavik Intl Arpt', 0);
INSERT INTO public.airports VALUES (2995, 'Reykjavik', 'RKV', 'IS', 64.13, -21.940556, 'Reykjavik Domestic Arpt', 0);
INSERT INTO public.airports VALUES (2996, 'Trelew', 'REL', 'AR', -43.2105, -65.27032, 'Trelew Arpt', -3);
INSERT INTO public.airports VALUES (2997, 'Orenburg', 'REN', 'RU', 51.795788, 55.456745, 'Orenburg Arpt', 6);
INSERT INTO public.airports VALUES (2998, 'Siem Reap', 'REP', 'KH', 13.410666, 103.81284, 'Siem Reap Arpt', 7);
INSERT INTO public.airports VALUES (2999, 'Retalhuleu', 'RER', 'GT', 0, 0, 'Base Aerea Del Sur Arpt', -100);
INSERT INTO public.airports VALUES (3000, 'Resistencia', 'RES', 'AR', -27.449986, -59.056126, 'Resistencia Arpt', -3);
INSERT INTO public.airports VALUES (3001, 'Reus', 'REU', 'ES', 41.147392, 1.167172, 'Reus Arpt', 1);
INSERT INTO public.airports VALUES (3002, 'Reynosa', 'REX', 'MX', 26.008907, -98.228516, 'General Lucio Blanco Arpt', -6);
INSERT INTO public.airports VALUES (3003, 'Rockford', 'ZRF', 'US', 0, 0, 'Peoria Rockford Bus Terminal', -100);
INSERT INTO public.airports VALUES (3004, 'Rockford', 'ZRK', 'US', 0, 0, 'Van Galder Bus Terminal', -100);
INSERT INTO public.airports VALUES (3005, 'Raiatea', 'RFP', 'PF', -16.72286, -151.46585, 'Raiatea Arpt', -10);
INSERT INTO public.airports VALUES (3006, 'Rio Frio', 'RFR', 'CR', 0, 0, 'Rio Frio Arpt', -100);
INSERT INTO public.airports VALUES (3007, 'Rio Grande', 'RGA', 'AR', -53.777668, -67.74939, 'Rio Grande Arpt', -3);
INSERT INTO public.airports VALUES (3008, 'Rangiroa Island', 'RGI', 'PF', -14.954283, -147.6608, 'Rangiroa Arpt', -10);
INSERT INTO public.airports VALUES (3009, 'Rio Gallegos', 'RGL', 'AR', -51.608875, -69.31264, 'Rio Gallegos Internacional Arpt', -3);
INSERT INTO public.airports VALUES (3010, 'Yangon', 'RGN', 'MM', 16.907305, 96.133224, 'Mingaladon', 6);
INSERT INTO public.airports VALUES (3011, 'Ranger', 'RGR', 'US', 0, 0, 'Ranger Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3012, 'Reims', 'RHE', 'FR', 49.31, 4.05, 'Champagne Arpt', 1);
INSERT INTO public.airports VALUES (3013, 'Rhinelander', 'RHI', 'US', 45.6312, -89.4675, 'Oneida County', -6);
INSERT INTO public.airports VALUES (3014, 'Rosh Pina', 'RHN', 'NA', 0, 0, 'Rosh Pina Airport', -100);
INSERT INTO public.airports VALUES (3015, 'Rhodes', 'RHO', 'GR', 36.40542, 28.086191, 'Diagoras Arpt', 2);
INSERT INTO public.airports VALUES (3016, 'Santa Maria', 'RIA', 'BR', -29.711357, -53.688152, 'Base Aerea Arpt', -3);
INSERT INTO public.airports VALUES (3017, 'Richmond', 'RIC', 'US', 37.505165, -77.319664, 'Richmond Intl Arpt', -5);
INSERT INTO public.airports VALUES (3018, 'Richfield', 'RIF', 'US', 38.736435, -112.098946, 'Reynolds Municipal Arpt', -6);
INSERT INTO public.airports VALUES (3019, 'Rio Grande', 'RIG', 'BR', -32.08262, -52.166542, 'Rio Grande Airport', -3);
INSERT INTO public.airports VALUES (3020, 'Rifle', 'RIL', 'US', 39.526306, -107.726944, 'Garfield Cty Arpt', -6);
INSERT INTO public.airports VALUES (3021, 'Rio De Janeiro', 'GIG', 'BR', -22.808903, -43.24365, 'Rio Internacional', -3);
INSERT INTO public.airports VALUES (3022, 'Rio De Janeiro', 'SDU', 'BR', -22.910461, -43.16313, 'Santos Dumont Arpt', -3);
INSERT INTO public.airports VALUES (3023, 'Riverton', 'RIW', 'US', 43.064167, -108.459724, 'Riverton Municipal', -7);
INSERT INTO public.airports VALUES (3024, 'Riga', 'RIX', 'LV', 56.92361, 23.971111, 'Riga Arpt', 2);
INSERT INTO public.airports VALUES (3025, 'Riyan', 'RIY', 'YE', 14.662639, 49.375027, 'Riyan Mukalla Arpt', 3);
INSERT INTO public.airports VALUES (3026, 'Rajahmundry', 'RJA', 'IN', 17.110361, 81.81821, 'Rajahmundry Arpt', 5);
INSERT INTO public.airports VALUES (3027, 'Rijeka', 'RJK', 'HR', 45.21689, 14.570267, 'Rijeka Arpt', 1);
INSERT INTO public.airports VALUES (3028, 'Logrono', 'RJL', 'ES', 42.4542, -2.32083, 'Agoncillo Arpt', 1);
INSERT INTO public.airports VALUES (3029, 'Yreka', 'RKC', 'US', 0, 0, 'Yreka Arpt', -100);
INSERT INTO public.airports VALUES (3030, 'Rockland', 'RKD', 'US', 44.060112, -69.09923, 'Rockland Arpt', -5);
INSERT INTO public.airports VALUES (3031, 'Roskilde', 'RKE', 'DK', 55.585567, 12.131428, 'Roskilde Arpt', 1);
INSERT INTO public.airports VALUES (3032, 'Rock Hill', 'RKH', 'US', 34.9878, -81.0572, 'Rock Hill York County Arpt', -5);
INSERT INTO public.airports VALUES (3033, 'Rockport', 'RKP', 'US', 28.086222, -97.04369, 'Aransas County Arpt', -6);
INSERT INTO public.airports VALUES (3034, 'Rock Springs', 'RKS', 'US', 41.5942, -109.065, 'Rock Springs Municipal', -7);
INSERT INTO public.airports VALUES (3035, 'Ras Al Khaimah', 'RKT', 'AE', 25.613483, 55.938816, 'Ras Al Khaimah Arpt', 4);
INSERT INTO public.airports VALUES (3036, 'Rolla', 'RLA', 'US', 38.1274, -91.7695, 'National Arpt', -100);
INSERT INTO public.airports VALUES (3037, 'Richland', 'RLD', 'US', 0, 0, 'Richland Arpt', -100);
INSERT INTO public.airports VALUES (3038, 'Rostock Laage', 'RLG', 'DE', 53.918167, 12.278333, 'Laage Arpt', 1);
INSERT INTO public.airports VALUES (3039, 'Roma', 'RMA', 'AU', -26.545, 148.775, 'Roma Arpt', 10);
INSERT INTO public.airports VALUES (3040, 'Rome', 'RME', 'US', 43.2338, -75.407036, 'Griffiss Air Force Base', -5);
INSERT INTO public.airports VALUES (3041, 'Marsa Alam', 'RMF', 'EG', 25.557112, 34.58371, 'Marsa Alam Arpt', 2);
INSERT INTO public.airports VALUES (3042, 'Rome', 'RMG', 'US', 34.350777, -85.15867, 'Richard B Russell Arpt', -4);
INSERT INTO public.airports VALUES (3043, 'Rimini', 'RMI', 'IT', 44.02029, 12.611747, 'Miramare Airport', 1);
INSERT INTO public.airports VALUES (3044, 'Renmark', 'RMK', 'AU', -34.118, 140.404, 'Renmark Airport', 9);
INSERT INTO public.airports VALUES (3045, 'Ramstein', 'RMS', 'DE', 49.436913, 7.600283, 'Ramsteim Arpt', 1);
INSERT INTO public.airports VALUES (3046, 'Ronneby', 'XXY', 'SE', 0, 0, 'Ronneby Railway Service', -100);
INSERT INTO public.airports VALUES (3047, 'Ronneby', 'XYO', 'SE', 0, 0, 'Karlshamn Rail Station', -100);
INSERT INTO public.airports VALUES (3048, 'Ronneby', 'RNB', 'SE', 56.266666, 15.265, 'Kallinge Arpt', 1);
INSERT INTO public.airports VALUES (3049, 'Roanne', 'RNE', 'FR', 46.058334, 4.001389, 'Renaison Arpt', 1);
INSERT INTO public.airports VALUES (3050, 'New Richmond', 'RNH', 'US', 0, 0, 'New Richmond Municipal', -100);
INSERT INTO public.airports VALUES (3051, 'Bornholm', 'RNN', 'DK', 55.063267, 14.759558, 'Bornholm Arpt', 1);
INSERT INTO public.airports VALUES (3052, 'Reno', 'RNO', 'US', 39.499107, -119.768105, 'Reno Tahoe Intl Arpt', -8);
INSERT INTO public.airports VALUES (3053, 'Rennes', 'RNS', 'FR', 48.069508, -1.734794, 'Saint Jacques Arpt', 1);
INSERT INTO public.airports VALUES (3054, 'Rennes', 'ZFJ', 'FR', 48.15, 4.85, 'Gare de Rennes', -100);
INSERT INTO public.airports VALUES (3055, 'Renton', 'RNT', 'US', 47.4933, -122.215, 'Renton Arpt', -100);
INSERT INTO public.airports VALUES (3056, 'Roanoke', 'ROA', 'US', 37.325474, -79.97542, 'Roanoke Regional Arpt', -5);
INSERT INTO public.airports VALUES (3057, 'Rochester', 'ROC', 'US', 43.118866, -77.672386, 'Monroe Cty Arpt New York', -5);
INSERT INTO public.airports VALUES (3058, 'Rogers', 'ROG', 'US', 0, 0, 'Rogers Arpt', -100);
INSERT INTO public.airports VALUES (3059, 'Roi Et', 'ROI', 'TH', 16.11676, 103.773796, 'Roi Et Arpt', 7);
INSERT INTO public.airports VALUES (3060, 'Rockhampton', 'ROK', 'AU', -23.381945, 150.47528, 'Rockhampton Arpt', 10);
INSERT INTO public.airports VALUES (3061, 'Rome', 'CIA', 'IT', 41.799362, 12.594936, 'Ciampino Arpt', 1);
INSERT INTO public.airports VALUES (3062, 'Rome', 'FCO', 'IT', 41.804474, 12.250797, 'Fiumicino Arpt', 1);
INSERT INTO public.airports VALUES (3063, 'Rondon', 'RON', 'CO', -24.5122, -54.0533, 'Rondon Arpt', -100);
INSERT INTO public.airports VALUES (3064, 'Rondonopolis', 'ROO', 'BR', -16.466667, -54.63333, 'Rondonopolis Arpt', -4);
INSERT INTO public.airports VALUES (3065, 'Rota', 'ROP', 'MP', 14.174308, 145.24254, 'Rota Arpt', 10);
INSERT INTO public.airports VALUES (3066, 'Koror', 'ROR', 'PW', 7.367303, 134.54428, 'Airai Airport', 9);
INSERT INTO public.airports VALUES (3067, 'Rosario', 'ROS', 'AR', -32.90361, -60.785, 'Fisherton Airport', -3);
INSERT INTO public.airports VALUES (3068, 'Rotorua', 'ROT', 'NZ', -38.109165, 176.31721, 'Rotorua Arpt', 12);
INSERT INTO public.airports VALUES (3069, 'Rostov', 'ROV', 'RU', 47.25821, 39.81809, 'Rostov Arpt', 4);
INSERT INTO public.airports VALUES (3070, 'Roswell', 'ROW', 'US', 33.301556, -104.530556, 'Industrial Aircenter', -7);
INSERT INTO public.airports VALUES (3071, 'Rosh Pina', 'RPN', 'IL', 32.98105, 35.571907, 'Rosh Pina Arpt', 2);
INSERT INTO public.airports VALUES (3072, 'Raipur', 'RPR', 'IN', 21.180407, 81.738754, 'Raipur Arpt', 5);
INSERT INTO public.airports VALUES (3073, 'Rodrigues Island', 'RRG', 'MU', -19.757658, 63.360985, 'Rodrigues Island Arpt', 4);
INSERT INTO public.airports VALUES (3074, 'Sorrento', 'RRO', 'IT', 0, 0, 'Sorrento Arpt', -100);
INSERT INTO public.airports VALUES (3075, 'Roros', 'RRS', 'NO', 62.57841, 11.342347, 'Roros Arpt', 1);
INSERT INTO public.airports VALUES (3076, 'Santa Rosa', 'RSA', 'AR', -36.58832, -64.275696, 'Santa Rosa Arpt', -3);
INSERT INTO public.airports VALUES (3077, 'Rock Sound', 'RSD', 'BS', 24.8917, -76.17774, 'S Eleuthera Arpt', -5);
INSERT INTO public.airports VALUES (3078, 'Russian Mission', 'RSH', 'US', 61.775, -161.31944, 'Russian Seaplane Base', -9);
INSERT INTO public.airports VALUES (3079, 'Ruston', 'RSN', 'US', 0, 0, 'Ruston Regional Arpt', -100);
INSERT INTO public.airports VALUES (3080, 'Rochester', 'RST', 'US', 43.908283, -92.500015, 'Rochester Municipal', -6);
INSERT INTO public.airports VALUES (3081, 'Yeosu', 'RSU', 'KR', 34.842327, 127.61685, 'Yeosu Arpt', 9);
INSERT INTO public.airports VALUES (3082, 'Roatan', 'RTB', 'HN', 16.316814, -86.522964, 'Roatan Arpt', -6);
INSERT INTO public.airports VALUES (3083, 'Rotterdam', 'QRH', 'NL', 0, 0, 'Rotterdam Central Rail Station', -100);
INSERT INTO public.airports VALUES (3084, 'Rotterdam', 'RTM', 'NL', 51.956944, 4.437222, 'Rotterdam Arpt', 1);
INSERT INTO public.airports VALUES (3085, 'Raton', 'RTN', 'US', 0, 0, 'Crews Fld', -100);
INSERT INTO public.airports VALUES (3086, 'Rottnest', 'RTS', 'AU', 0, 0, 'Rottnest Island Arpt', -100);
INSERT INTO public.airports VALUES (3087, 'Saratov', 'RTW', 'RU', 51.334366, 46.022953, 'Saratov Arpt', 6);
INSERT INTO public.airports VALUES (3088, 'Orsk', 'OSW', 'RU', 52.1, 58.566666, 'Orsk Airport', 6);
INSERT INTO public.airports VALUES (3089, 'Riyadh', 'RUH', 'SA', 24.95764, 46.698776, 'King Khaled Intl', 3);
INSERT INTO public.airports VALUES (3090, 'Ruidoso', 'RUI', 'US', 33.4629, -105.5348, 'Ruidoso Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3091, 'Reunion Island', 'RUN', 'RE', -20.8871, 55.510307, 'Gillot Airport', 5);
INSERT INTO public.airports VALUES (3092, 'Rutland', 'RUT', 'US', 43.5294, -72.9496, 'Rutland Arpt', -5);
INSERT INTO public.airports VALUES (3093, 'Copan', 'RUY', 'HN', 0, 0, 'Copan Arpt', -100);
INSERT INTO public.airports VALUES (3094, 'Roervik', 'RVK', 'NO', 64.8383, 11.1461, 'Ryumsjoen Arpt', 1);
INSERT INTO public.airports VALUES (3095, 'Rovaniemi', 'RVN', 'FI', 66.56482, 25.830412, 'Rovaniemi Arpt', 2);
INSERT INTO public.airports VALUES (3096, 'Green River', 'RVR', 'US', 18.245277, -65.64333, 'Green River Arpt', -4);
INSERT INTO public.airports VALUES (3097, 'Ravensthorpe', 'RVT', 'AU', -33.797222, 120.20805, 'Ravensthorpe Arpt', 8);
INSERT INTO public.airports VALUES (3098, 'Rocky Mount', 'RWI', 'US', 35.8563, -77.8919, 'Wilson Arpt', -5);
INSERT INTO public.airports VALUES (3099, 'Rawlins', 'RWL', 'US', 41.8056, -107.19994, 'Rawlins Municipal', -7);
INSERT INTO public.airports VALUES (3100, 'Rovno', 'RWN', 'UA', 50.6071, 26.1416, 'Rovno Arpt', 2);
INSERT INTO public.airports VALUES (3101, 'Sumare', 'RWS', 'BR', 0, 0, 'Sumare Arpt', -100);
INSERT INTO public.airports VALUES (3102, 'Roxas City', 'RXS', 'PH', 11.597669, 122.75167, 'Roxas City Arpt', 8);
INSERT INTO public.airports VALUES (3103, 'Rybinsk Staroselye', 'RYB', 'RU', 58.1042, 38.9294, 'Rybinsk Staroselye', 4);
INSERT INTO public.airports VALUES (3104, 'Rzeszow', 'RZE', 'PL', 50.10996, 22.019, 'Jasionka Arpt', 1);
INSERT INTO public.airports VALUES (3105, 'Ryazan', 'RZN', 'RU', 0, 0, 'Ryazan Arpt', -100);
INSERT INTO public.airports VALUES (3106, 'Roanoke Rapids', 'RZZ', 'US', 0, 0, 'Halifax Cty Arpt', -100);
INSERT INTO public.airports VALUES (3107, 'Saba Island', 'SAB', 'AN', 17.645279, -63.220554, 'Juancho Yraus Quinl', -4);
INSERT INTO public.airports VALUES (3108, 'Sacramento', 'SMF', 'US', 38.695415, -121.590775, 'Sacramento International', -8);
INSERT INTO public.airports VALUES (3109, 'Sacramento', 'MHR', 'US', 38.553898, -121.29759, 'Mather Air Force Base', -8);
INSERT INTO public.airports VALUES (3110, 'Sacramento', 'SAC', 'US', 38.512524, -121.49347, 'Sacramento Executive Arpt', -8);
INSERT INTO public.airports VALUES (3111, 'Santa Fe', 'SAF', 'US', 35.617107, -106.089424, 'Santa Fe Municipal', -7);
INSERT INTO public.airports VALUES (3112, 'Sanaa', 'SAH', 'YE', 15.476258, 44.219738, 'Sanaa Intl Airport', 3);
INSERT INTO public.airports VALUES (3113, 'Saudarkrokur', 'SAK', 'IS', 65.73167, -19.572779, 'Saudarkrokur Arpt', 0);
INSERT INTO public.airports VALUES (3114, 'San Salvador', 'SAL', 'SV', 13.440947, -89.055725, 'Comalapa Intl Arpt', -6);
INSERT INTO public.airports VALUES (3115, 'Salamo', 'SAM', 'PG', 0, 0, 'Salamo Arpt', -100);
INSERT INTO public.airports VALUES (3116, 'San Diego', 'SDM', 'US', 32.572273, -116.98016, 'Brown Field Municipal', -7);
INSERT INTO public.airports VALUES (3117, 'San Diego', 'MYF', 'US', 32.4759, 117.759, 'Montgomery Field', -8);
INSERT INTO public.airports VALUES (3118, 'San Diego', 'SEE', 'US', 32.82622, -116.97244, 'Gillespie Field', -8);
INSERT INTO public.airports VALUES (3119, 'San Diego', 'SAN', 'US', 32.733555, -117.18967, 'Lindbergh Intl Arpt', -8);
INSERT INTO public.airports VALUES (3120, 'Sao Paulo', 'GRU', 'BR', -23.432076, -46.46951, 'Guarulhos Arpt', -3);
INSERT INTO public.airports VALUES (3121, 'Sao Paulo', 'CGH', 'BR', -23.626692, -46.655376, 'Congonhas Arpt', -3);
INSERT INTO public.airports VALUES (3122, 'Sao Paulo', 'VCP', 'BR', -23.0075, -47.134445, 'Viracopos Arpt', -3);
INSERT INTO public.airports VALUES (3123, 'San Pedro Sula', 'SAP', 'HN', 15.452639, -87.92355, 'Ramon Villeda Morales Arpt', -6);
INSERT INTO public.airports VALUES (3124, 'Sparta', 'SAR', 'US', 38.1489, -89.6987, 'Sparta Community Airport', -100);
INSERT INTO public.airports VALUES (3125, 'San Antonio', 'SSF', 'US', 0, 0, 'Stinson Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3126, 'San Antonio', 'SAT', 'US', 29.533693, -98.46978, 'San Antonio Intl', -6);
INSERT INTO public.airports VALUES (3127, 'Savannah', 'SAV', 'US', 32.127583, -81.20214, 'Savannah Intl Arpt', -5);
INSERT INTO public.airports VALUES (3128, 'Siena', 'SAY', 'IT', 43.256287, 11.255036, 'Siena Arpt', 1);
INSERT INTO public.airports VALUES (3129, 'Sasstown', 'SAZ', 'LR', 0, 0, 'Sasstown Arpt', -100);
INSERT INTO public.airports VALUES (3130, 'Santa Barbara', 'SBA', 'US', 34.426212, -119.84037, 'Santa Barbara Arpt', -8);
INSERT INTO public.airports VALUES (3131, 'St Barthelemy', 'SBH', 'GP', 17.9023, -62.8324, 'St Jean Arpt', -4);
INSERT INTO public.airports VALUES (3132, 'St Brieuc', 'SBK', 'FR', 48.537777, -2.854445, 'Tremuson Armor Arpt', 1);
INSERT INTO public.airports VALUES (3133, 'Sheboygan', 'SBM', 'US', 0, 0, 'Sheboygan Arpt', -100);
INSERT INTO public.airports VALUES (3134, 'South Bend', 'SBN', 'US', 41.70866, -86.31725, 'Michiana Regional Arpt', -5);
INSERT INTO public.airports VALUES (3135, 'Steamboat Springs', 'SBS', 'US', 40.51625, -106.8663, 'Steamboat Arpt', -6);
INSERT INTO public.airports VALUES (3136, 'San Bernardino', 'SBD', 'US', 34.095352, -117.23487, 'San Bernardino Intl Arpt', -8);
INSERT INTO public.airports VALUES (3137, 'Springbok', 'SBU', 'ZA', -29.689333, 17.939611, 'Springbok Arpt', 2);
INSERT INTO public.airports VALUES (3138, 'Sibu', 'SBW', 'MY', 2.261603, 111.98532, 'Sibu Arpt', 8);
INSERT INTO public.airports VALUES (3139, 'Salisbury Ocean City', 'SBY', 'US', 38.340527, -75.51029, 'Wicomico Regional Arpt', -5);
INSERT INTO public.airports VALUES (3140, 'Sibiu', 'SBZ', 'RO', 45.7856, 24.091343, 'Sibiu Arpt', 2);
INSERT INTO public.airports VALUES (3141, 'Prudhoe Bay Deadhorse', 'SCC', 'US', 70.19475, -148.46516, 'Prudhoe Bay Deadhorse Arpt', -9);
INSERT INTO public.airports VALUES (3142, 'State College', 'SCE', 'US', 40.849277, -77.848694, 'University Park Arpt', -5);
INSERT INTO public.airports VALUES (3143, 'Scottsdale', 'SCF', 'US', 0, 0, 'Scottsdale Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3144, 'Schenectady', 'SCH', 'US', 42.852455, -73.92886, 'Schenectady County Arpt', -5);
INSERT INTO public.airports VALUES (3145, 'San Crystobal', 'SCI', 'VE', 0, 0, 'Aeropuerto Santo Domingo', -100);
INSERT INTO public.airports VALUES (3146, 'Stockton', 'SCK', 'US', 37.89417, -121.238304, 'Stockton Metro Arpt', -8);
INSERT INTO public.airports VALUES (3147, 'Santiago', 'ULC', 'CL', 0, 0, 'Los Cerrillos', -100);
INSERT INTO public.airports VALUES (3148, 'Santiago', 'SCL', 'CL', -33.392975, -70.785805, 'Arturo Merino Benitez', -4);
INSERT INTO public.airports VALUES (3149, 'Saarbruecken', 'QFZ', 'DE', 0, 0, 'Saarbruecken Rail Station', 1);
INSERT INTO public.airports VALUES (3150, 'Saarbruecken', 'SCN', 'DE', 49.214554, 7.109508, 'Ensheim Arpt', 1);
INSERT INTO public.airports VALUES (3151, 'Aktau', 'SCO', 'KZ', 43.513557, 51.05282, 'Aktau Arpt', 5);
INSERT INTO public.airports VALUES (3152, 'Santiago De Compostela', 'SCQ', 'ES', 42.89633, -8.415144, 'Santiago Airport', 1);
INSERT INTO public.airports VALUES (3153, 'Santiago', 'SCU', 'CU', 19.969769, -75.83541, 'Antonio Maceo Arpt', -5);
INSERT INTO public.airports VALUES (3154, 'Suceava', 'SCV', 'RO', 47.6875, 26.354055, 'Salcea Arpt', 2);
INSERT INTO public.airports VALUES (3155, 'Syktyvkar', 'SCW', 'RU', 61.64705, 50.84505, 'Syktyvkar Arpt', 4);
INSERT INTO public.airports VALUES (3156, 'Salina Cruz', 'SCX', 'MX', 16.2126, -95.2016, 'Salina Cruz Arpt', -6);
INSERT INTO public.airports VALUES (3157, 'San Cristobal', 'SCY', 'EC', -0.910206, -89.61745, 'San Cristobal Airport', -6);
INSERT INTO public.airports VALUES (3158, 'Saldanha Bay', 'SDB', 'ZA', -32.9688, 18.1653, 'Langebaanweg Arpt', -100);
INSERT INTO public.airports VALUES (3159, 'Santiago Del Estero', 'SDE', 'AR', -27.765617, -64.31012, 'Santiago Des Estero Arpt', -3);
INSERT INTO public.airports VALUES (3160, 'Louisville', 'LOU', 'US', 38.228, -85.66372, 'Bowman Field Arpt', -5);
INSERT INTO public.airports VALUES (3161, 'Louisville', 'SDF', 'US', 38.174088, -85.736496, 'Louisville International Arpt', -5);
INSERT INTO public.airports VALUES (3162, 'Sendai', 'SDJ', 'JP', 38.13972, 140.91695, 'Sendai Arpt', 9);
INSERT INTO public.airports VALUES (3163, 'Sandakan', 'SDK', 'MY', 5.900897, 118.05949, 'Sandakan Arpt', 8);
INSERT INTO public.airports VALUES (3164, 'Sundsvall', 'XXZ', 'SE', 0, 0, 'Sundsvall Rail Service', -100);
INSERT INTO public.airports VALUES (3165, 'Sundsvall', 'SDL', 'SE', 62.528126, 17.443928, 'Sundsvall Arpt', 1);
INSERT INTO public.airports VALUES (3166, 'Sandane', 'SDN', 'NO', 61.83, 6.10583, 'Anda Airport', 1);
INSERT INTO public.airports VALUES (3167, 'Sand Point', 'SDP', 'US', 55.315, -160.523, 'Sand Point Arpt', -9);
INSERT INTO public.airports VALUES (3168, 'Santo Domingo', 'SDQ', 'DO', 18.429665, -69.66892, 'Las Americas Arpt', -4);
INSERT INTO public.airports VALUES (3169, 'Santo Domingo', 'HEX', 'DO', 18.475, -69.975, 'Herrera Arpt', -6);
INSERT INTO public.airports VALUES (3170, 'Santander', 'SDR', 'ES', 43.427063, -3.820006, 'Santander Airport', 1);
INSERT INTO public.airports VALUES (3171, 'Sedona', 'SDX', 'US', 34.84863, -111.788475, 'Sedona Arpt', -7);
INSERT INTO public.airports VALUES (3172, 'Sidney', 'SDY', 'US', 47.706944, -104.1925, 'Sindey Richland Municipal Arpt', -7);
INSERT INTO public.airports VALUES (3173, 'Shetland Islands Area', 'SCS', 'GB', 60.4328, -1.2961, 'Scatsta Arpt', -100);
INSERT INTO public.airports VALUES (3174, 'Seattle', 'SEA', 'US', 47.449, -122.3093, 'Seattle Tacoma Intl Arpt', -8);
INSERT INTO public.airports VALUES (3175, 'Seattle', 'BFI', 'US', 47.53, -122.30195, 'Seattle Boeing Field', -8);
INSERT INTO public.airports VALUES (3176, 'Seattle', 'KEH', 'US', 47.7548, -122.259, 'Kenmore Air Harbor', -8);
INSERT INTO public.airports VALUES (3177, 'Seattle', 'LKE', 'US', 47.629, -122.339, 'Lake Union Seaplane Base', -7);
INSERT INTO public.airports VALUES (3178, 'Sebring', 'SEF', 'US', 0, 0, 'Air Terminal Arpt', -100);
INSERT INTO public.airports VALUES (3179, 'Seoul', 'ICN', 'KR', 37.469074, 126.450516, 'Incheon Intl Arpt', 9);
INSERT INTO public.airports VALUES (3180, 'Seoul', 'GMP', 'KR', 37.55831, 126.79059, 'Gimpo Intl Arpt', 9);
INSERT INTO public.airports VALUES (3181, 'Southend', 'SEN', 'GB', 51.57139, 0.695556, 'Southend Municipal Arpt', 0);
INSERT INTO public.airports VALUES (3182, 'Stephenville', 'SEP', 'US', 0, 0, 'Clark Field', -100);
INSERT INTO public.airports VALUES (3183, 'Siwa', 'SEW', 'EG', 0, 0, 'Siwa Arpt', -100);
INSERT INTO public.airports VALUES (3184, 'Selibaby', 'SEY', 'MR', 15.179692, -12.207272, 'Selibaby Arpt', 0);
INSERT INTO public.airports VALUES (3185, 'Mahe Island', 'SEZ', 'SC', -4.674342, 55.52184, 'Seychelles Intl Arpt', 4);
INSERT INTO public.airports VALUES (3186, 'Sfax', 'SFA', 'TN', 34.717953, 10.690972, 'El Maou Airport', 1);
INSERT INTO public.airports VALUES (3187, 'Sanford', 'SFB', 'US', 28.77764, -81.23749, 'Orlando Sanford Arpt', -5);
INSERT INTO public.airports VALUES (3188, 'San Fernando De Apure', 'SFD', 'VE', 7.883317, -67.44402, 'Las Flecheras', -4);
INSERT INTO public.airports VALUES (3189, 'San Fernando', 'SFE', 'PH', 16.595589, 120.30322, 'San Fernando Arpt', 8);
INSERT INTO public.airports VALUES (3190, 'St Martin', 'SFG', 'AN', 18.099915, -63.047195, 'Esperance Airport', -4);
INSERT INTO public.airports VALUES (3191, 'San Felipe', 'SFH', 'MX', 10.278728, -68.75521, 'San Felipe Arpt', -4);
INSERT INTO public.airports VALUES (3192, 'Kangerlussuaq', 'SFJ', 'GL', 67.01697, -50.689323, 'Sondre Stromfjord Arpt', -3);
INSERT INTO public.airports VALUES (3193, 'Sao Filipe', 'SFL', 'CV', 14.885, -24.48, 'Sao Filipe Arpt', -1);
INSERT INTO public.airports VALUES (3194, 'Sanford', 'SFM', 'US', 43.39383, -70.708, 'Sanford Regional Arpt', -5);
INSERT INTO public.airports VALUES (3195, 'Santa Fe', 'SFN', 'AR', -31.711666, -60.81167, 'Santa Fe Arpt', -3);
INSERT INTO public.airports VALUES (3196, 'San Francisco', 'SFO', 'US', 37.618973, -122.374886, 'San Francisco Intl Arpt', -8);
INSERT INTO public.airports VALUES (3197, 'Sanli Urfa', 'SFQ', 'TR', 37.09426, 38.847103, 'Sanli Urfa Arpt', 2);
INSERT INTO public.airports VALUES (3198, 'Sanli Urfa', 'GNY', 'TR', 37.0919, 38.8462, 'Guney Anadolu Airport', 2);
INSERT INTO public.airports VALUES (3199, 'Subic Bay', 'SFS', 'PH', 14.7944, 120.271, 'Subic Bay Intl Arpt', 8);
INSERT INTO public.airports VALUES (3200, 'Skelleftea', 'SFT', 'SE', 64.62477, 21.076893, 'Skelleftea Arpt', 1);
INSERT INTO public.airports VALUES (3201, 'San Felix', 'SFX', 'VE', 0, 0, 'San Felix Arpt', -100);
INSERT INTO public.airports VALUES (3202, 'Springfield', 'CEF', 'US', 42.194016, -72.53478, 'Westover Metro', -5);
INSERT INTO public.airports VALUES (3203, 'Smithfield', 'SFZ', 'US', 41.920765, -71.49138, 'Smithfield Arpt', -5);
INSERT INTO public.airports VALUES (3204, 'Surgut', 'SGC', 'RU', 61.343693, 73.40184, 'Surgut Arpt', 6);
INSERT INTO public.airports VALUES (3205, 'Sonderborg', 'SGD', 'DK', 54.964367, 9.791731, 'Sonderborg Arpt', 1);
INSERT INTO public.airports VALUES (3206, 'Siegen', 'SGE', 'DE', 50.7077, 8.083, 'Siegerland Arpt', -100);
INSERT INTO public.airports VALUES (3207, 'Springfield', 'SGF', 'US', 37.245667, -93.38864, 'Springfield Branson Regional Arpt', -6);
INSERT INTO public.airports VALUES (3208, 'Ho Chi Minh City', 'SGN', 'VN', 10.818797, 106.651855, 'Tan Son Nhut Arpt', 7);
INSERT INTO public.airports VALUES (3209, 'St George', 'SGO', 'AU', -28.0497, 148.595, 'St George Arpt', 10);
INSERT INTO public.airports VALUES (3210, 'Sugar Land', 'SGR', 'US', 29.62225, -95.656525, 'Hull Field Arpt', -6);
INSERT INTO public.airports VALUES (3211, 'Stuttgart', 'SGT', 'US', 0, 0, 'Stuttgart Municipal', -100);
INSERT INTO public.airports VALUES (3212, 'St George', 'SGU', 'US', 37.090584, -113.593056, 'Saint George Municipal Arpt', -7);
INSERT INTO public.airports VALUES (3213, 'Skagway', 'SGY', 'US', 59.4601, -135.316, 'Skagway Municipal Arpt', -9);
INSERT INTO public.airports VALUES (3214, 'Shanghai', 'SHA', 'CN', 31.197874, 121.33632, 'Hongqiao International Arpt', 8);
INSERT INTO public.airports VALUES (3215, 'Shanghai', 'PVG', 'CN', 31.143377, 121.805214, 'Pudong International Arpt', 8);
INSERT INTO public.airports VALUES (3216, 'Nakashibetsu', 'SHB', 'JP', 43.5775, 144.96, 'Nakashibetsu Arpt', 9);
INSERT INTO public.airports VALUES (3217, 'Staunton', 'SHD', 'US', 38.26389, -78.896385, 'Shenandoah Valley Arpt', -5);
INSERT INTO public.airports VALUES (3218, 'Shenyang', 'SHE', 'CN', 41.3824, 123.2901, 'Shenyang Arpt', 8);
INSERT INTO public.airports VALUES (3219, 'Sokcho', 'SHO', 'KR', 38.142612, 128.59856, 'Seolak Arpt', 9);
INSERT INTO public.airports VALUES (3220, 'Qinhuangdao', 'SHP', 'CN', 39.9681, 119.731, 'Qinhuangdao Arpt', 8);
INSERT INTO public.airports VALUES (3221, 'Sheridan', 'SHR', 'US', 44.7692, -106.98, 'Sheridan Cty Arpt', -7);
INSERT INTO public.airports VALUES (3222, 'Shashi', 'SHS', 'CN', 0, 0, 'Shashi Arpt', -100);
INSERT INTO public.airports VALUES (3223, 'Shepparton', 'SHT', 'AU', -36.4283, 145.3933, 'Shepparton', -100);
INSERT INTO public.airports VALUES (3224, 'Shreveport', 'SHV', 'US', 32.44663, -93.8256, 'Shreveport Regional Arpt', -6);
INSERT INTO public.airports VALUES (3225, 'Shreveport', 'BAD', 'US', 32.50182, -93.662674, 'Barksdale Air Force Base', -6);
INSERT INTO public.airports VALUES (3226, 'Sharurah', 'SHW', 'SA', 17.466875, 47.12143, 'Sharurah Arpt', 3);
INSERT INTO public.airports VALUES (3227, 'Shinyanga', 'SHY', 'TZ', -3.667, 33.417, 'Shinyanga Arpt', 3);
INSERT INTO public.airports VALUES (3228, 'Xi An', 'XIY', 'CN', 34.44712, 108.751595, 'Xianyang Arpt', 8);
INSERT INTO public.airports VALUES (3229, 'Xi An', 'SIA', 'CN', 34.3767, 109.12, 'Xiguan Airport', 8);
INSERT INTO public.airports VALUES (3230, 'Sinop', 'NOP', 'TR', 42.0158, 35.0664, 'Sinop Arpt', 2);
INSERT INTO public.airports VALUES (3231, 'Sal Island', 'SID', 'CV', 16.741388, -22.949444, 'Amilcar Cabral Intl Arpt', -1);
INSERT INTO public.airports VALUES (3232, 'Isla Grande', 'SIG', 'US', 18.456827, -66.09814, 'SIG Isla Grande Arpt', -4);
INSERT INTO public.airports VALUES (3233, 'Singapore', 'SIN', 'SG', 1.350189, 103.99443, 'Changi Intl Arpt', 8);
INSERT INTO public.airports VALUES (3234, 'Simferopol', 'SIP', 'UA', 45.052223, 33.97514, 'Simferopol Arpt', 2);
INSERT INTO public.airports VALUES (3235, 'Sion', 'SIR', 'CH', 46.219593, 7.326764, 'Sion Arpt', 1);
INSERT INTO public.airports VALUES (3236, 'Sitka', 'SIT', 'US', 57.04714, -135.36162, 'Sitka Airport', -9);
INSERT INTO public.airports VALUES (3237, 'Singleton', 'SIX', 'AU', 0, 0, 'Singleton Arpt', -100);
INSERT INTO public.airports VALUES (3238, 'San Jose', 'SJC', 'US', 37.3626, -121.92902, 'San Jose Intl Arpt', -8);
INSERT INTO public.airports VALUES (3239, 'San Jose', 'ZSM', 'US', 0, 0, 'Santa Clara Bus Service', -100);
INSERT INTO public.airports VALUES (3240, 'San Jose', 'ZJO', 'US', 0, 0, 'San Jose Bus Service', -100);
INSERT INTO public.airports VALUES (3241, 'San Jose', 'RHV', 'US', 0, 0, 'Reid Hillview Of Santa Clara County', -100);
INSERT INTO public.airports VALUES (3242, 'San Jose Cabo', 'SJD', 'MX', 23.15185, -109.72105, 'Los Cabos Arpt', -7);
INSERT INTO public.airports VALUES (3243, 'St John', 'SJF', 'US', 0, 0, 'St John Island Arpt', -100);
INSERT INTO public.airports VALUES (3244, 'Sarajevo', 'SJJ', 'BA', 43.82458, 18.331467, 'Butmir Arpt', 1);
INSERT INTO public.airports VALUES (3245, 'Sao Jose Dos Campos', 'SJK', 'BR', -23.228172, -45.86274, 'Sao Jose Dos Campos Arpt', -3);
INSERT INTO public.airports VALUES (3246, 'San Jose', 'SJO', 'CR', 9.993861, -84.20881, 'Juan Santa Maria Intl', -6);
INSERT INTO public.airports VALUES (3247, 'San Jose', 'SYQ', 'CR', 9.957053, -84.13979, 'Tobias Bolanos Intl', -6);
INSERT INTO public.airports VALUES (3248, 'Sao Jose Do Rio Preto', 'SJP', 'BR', -20.816566, -49.40651, 'Sao Jose Do Rio Preto', -3);
INSERT INTO public.airports VALUES (3249, 'San Angelo', 'SJT', 'US', 31.35775, -100.49631, 'Mathis Field', -6);
INSERT INTO public.airports VALUES (3250, 'San Juan', 'SJU', 'US', 18.439417, -66.00183, 'Luiz Munoz Marin Intl', -4);
INSERT INTO public.airports VALUES (3251, 'Shijiazhuang', 'SJW', 'CN', 38.280685, 114.6973, 'Daguocun Arpt', 8);
INSERT INTO public.airports VALUES (3252, 'Seinajoki', 'SJY', 'FI', 62.6921, 22.8323, 'Ilmajoki Arpt', 2);
INSERT INTO public.airports VALUES (3253, 'Sao Jorge Island', 'SJZ', 'PT', 38.6655, -28.175817, 'Sao Jorge Arpt', -1);
INSERT INTO public.airports VALUES (3254, 'St Kitts', 'SKB', 'KN', 17.311193, -62.718666, 'Robert L Bradshaw Arpt', -4);
INSERT INTO public.airports VALUES (3255, 'Samarkand', 'SKD', 'UZ', 39.700546, 66.983826, 'Samarkand Arpt', 5);
INSERT INTO public.airports VALUES (3256, 'Skien', 'XKK', 'NO', 0, 0, 'Larvik Rail Station', -100);
INSERT INTO public.airports VALUES (3257, 'Skien', 'XKP', 'NO', 0, 0, 'Porsgrunn Rail Station', -100);
INSERT INTO public.airports VALUES (3258, 'Skien', 'SKE', 'NO', 59.185, 9.566944, 'Skien Arpt', 1);
INSERT INTO public.airports VALUES (3259, 'Thessaloniki', 'SKG', 'GR', 40.519726, 22.97095, 'Makedonia Arpt', 2);
INSERT INTO public.airports VALUES (3260, 'Isle Of Skye Hebrides Islands', 'SKL', 'GB', 0, 0, 'Broadford Arpt', -100);
INSERT INTO public.airports VALUES (3261, 'Stokmarknes', 'SKN', 'NO', 68.58083, 15.026111, 'Skagen Arpt', 1);
INSERT INTO public.airports VALUES (3262, 'Skopje', 'SKP', 'MK', 41.96162, 21.621382, 'Skopje Arpt', 1);
INSERT INTO public.airports VALUES (3263, 'Skrydstrup', 'SKS', 'DK', 55.22555, 9.263931, 'Skrydstrup Airport', 1);
INSERT INTO public.airports VALUES (3264, 'Sialkot', 'SKT', 'PK', 32.5356, 74.3639, 'Sialkot Arpt', 5);
INSERT INTO public.airports VALUES (3265, 'Skiros', 'SKU', 'GR', 38.967552, 24.487228, 'Skiros Arpt', 2);
INSERT INTO public.airports VALUES (3266, 'Saransk', 'SKX', 'RU', 54.1251, 45.2123, 'Saransk Arpt', 4);
INSERT INTO public.airports VALUES (3267, 'Sandusky', 'SKY', 'US', 41.43336, -82.652336, 'Griffing Sandusky Arpt', -5);
INSERT INTO public.airports VALUES (3268, 'Salta', 'SLA', 'AR', -24.855978, -65.48617, 'General Belgrano Intl Arpt', -3);
INSERT INTO public.airports VALUES (3269, 'Salt Lake City', 'SLC', 'US', 40.788387, -111.977776, 'Salt Lake City Intl Arpt', -7);
INSERT INTO public.airports VALUES (3270, 'Sliac', 'SLD', 'SK', 48.63784, 19.134108, 'Sliac Arpt', 1);
INSERT INTO public.airports VALUES (3271, 'Salem', 'SLE', 'US', 44.9095, -123.003, 'McNary Field', -7);
INSERT INTO public.airports VALUES (3272, 'Saranac Lake', 'SLK', 'US', 44.3853, -74.2062, 'Adirondack Arpt', -5);
INSERT INTO public.airports VALUES (3273, 'Salalah', 'SLL', 'OM', 17.03872, 54.091297, 'Salalah Arpt', 4);
INSERT INTO public.airports VALUES (3274, 'Salamanca', 'SLM', 'ES', 40.952118, -5.501986, 'Matacan Arpt', 1);
INSERT INTO public.airports VALUES (3275, 'Salina', 'SLN', 'US', 38.791, -97.6522, 'Salina Municipal', -6);
INSERT INTO public.airports VALUES (3276, 'San Luis Potosi', 'SLP', 'MX', 22.254303, -100.93081, 'San Luis Potosi Municipal Arpt', -6);
INSERT INTO public.airports VALUES (3277, 'Salida', 'SLT', 'US', 0, 0, 'Salida Arpt', -100);
INSERT INTO public.airports VALUES (3278, 'St Lucia', 'SLU', 'LC', 14.020228, -60.992935, 'Vigie Field Arpt', -4);
INSERT INTO public.airports VALUES (3279, 'Simla', 'SLV', 'IN', 31.081802, 77.06797, 'Simla Arpt', 5);
INSERT INTO public.airports VALUES (3280, 'Saltillo', 'SLW', 'MX', 25.549498, -100.92867, 'Saltillo Arpt', -6);
INSERT INTO public.airports VALUES (3281, 'Salekhard', 'SLY', 'RU', 66.59075, 66.61104, 'Salehard Airport', 6);
INSERT INTO public.airports VALUES (3282, 'Sao Luiz', 'SLZ', 'BR', -2.585361, -44.23414, 'Mal Cunha Machado', -3);
INSERT INTO public.airports VALUES (3283, 'Santa Maria', 'SMA', 'PT', 36.97139, -25.170639, 'Vilo Do Porto Arpt', -1);
INSERT INTO public.airports VALUES (3284, 'Somerset', 'SME', 'US', 37.05361, -84.615555, 'Pulaski County Arpt', -5);
INSERT INTO public.airports VALUES (3285, 'Samos', 'SMI', 'GR', 37.69, 26.911667, 'Samos Arpt', 2);
INSERT INTO public.airports VALUES (3286, 'Stella Maris', 'SML', 'BS', 23.581444, -75.27048, 'Stella Maris Arpt', -5);
INSERT INTO public.airports VALUES (3287, 'Stockholm', 'SMP', 'PG', -4.566667, 151.96666, 'Stockholm Arpt', 10);
INSERT INTO public.airports VALUES (3288, 'Santa Marta', 'SMR', 'CO', 11.11965, -74.230644, 'Simon Bolivar', -5);
INSERT INTO public.airports VALUES (3289, 'Saint Marie', 'SMS', 'MG', -17.09389, 49.815834, 'St Marie Arpt', 3);
INSERT INTO public.airports VALUES (3290, 'St Moritz', 'SMV', 'CH', 46.534077, 9.884106, 'Samedan Arpt', 1);
INSERT INTO public.airports VALUES (3291, 'Santa Maria', 'SMX', 'US', 34.8989, -120.457, 'Santa Maria Public Arpt', -8);
INSERT INTO public.airports VALUES (3292, 'Santa Maria', 'LPC', 'US', 0, 0, 'Lompoc Arpt', -100);
INSERT INTO public.airports VALUES (3293, 'Sunyani', 'NYI', 'GH', 5.605186, 0, 'Sunyani', 0);
INSERT INTO public.airports VALUES (3294, 'Santa Ana', 'SNA', 'US', 33.675667, -117.868225, 'John Wayne Arpt', -8);
INSERT INTO public.airports VALUES (3295, 'Sao Nicolau', 'SNE', 'CV', 16.588356, -24.284657, 'Preguica Arpt', -1);
INSERT INTO public.airports VALUES (3296, 'San Felipe', 'SNF', 'VE', 10.2833, -68.7333, 'San Felipe Airport', -100);
INSERT INTO public.airports VALUES (3297, 'Stanthorpe', 'SNH', 'AU', -28.62, 151.99, 'Stanthorpe', -100);
INSERT INTO public.airports VALUES (3298, 'Sinoe', 'SNI', 'LR', 0, 0, 'R E Murray Arpt', -100);
INSERT INTO public.airports VALUES (3299, 'Shawnee', 'SNL', 'US', 0, 0, 'Shawnee Airport', -100);
INSERT INTO public.airports VALUES (3300, 'Shannon', 'SNN', 'IE', 52.701977, -8.924817, 'Shannon Arpt', 0);
INSERT INTO public.airports VALUES (3301, 'Sakon Nakhon', 'SNO', 'TH', 17.195143, 104.11862, 'Sakon Nakhon Arpt', 7);
INSERT INTO public.airports VALUES (3302, 'San Quintin', 'SNQ', 'MX', 0, 0, 'San Quintin Arpt', -100);
INSERT INTO public.airports VALUES (3303, 'St Nazaire', 'SNR', 'FR', 47.312187, -2.149181, 'Montoir Airport', 1);
INSERT INTO public.airports VALUES (3304, 'Salinas', 'SNS', 'US', 36.6628, -121.6064, 'Salinas Arpt', -100);
INSERT INTO public.airports VALUES (3305, 'Santa Clara', 'SNU', 'CU', 22.492191, -79.94361, 'Santa Clara Arpt', -5);
INSERT INTO public.airports VALUES (3306, 'Sidney', 'SNY', 'US', 41.1013, -102.9853, 'Sidney Municipal', -100);
INSERT INTO public.airports VALUES (3307, 'Saarmelleek', 'SOB', 'HU', 46.68639, 17.159056, 'Saarmelleek Balaton Arpt', 1);
INSERT INTO public.airports VALUES (3308, 'Solo', 'SOC', 'ID', -7.516089, 110.75689, 'Adi Sumarno Arpt', 7);
INSERT INTO public.airports VALUES (3309, 'Sorocaba', 'SOD', 'BR', -23.478, -47.49, 'Sorocaba Arpt', -3);
INSERT INTO public.airports VALUES (3310, 'Sofia', 'SOF', 'BG', 42.695194, 23.406166, 'Sofia Vrazhdebna Arpt', 2);
INSERT INTO public.airports VALUES (3311, 'Sogndal', 'SOG', 'NO', 61.1561, 7.13778, 'Haukasen Arpt', 1);
INSERT INTO public.airports VALUES (3312, 'South Molle', 'SOI', 'AU', 0, 0, 'South Molle Island Arpt', -100);
INSERT INTO public.airports VALUES (3313, 'San Tome', 'SOM', 'VE', 8.945147, -64.151085, 'El Tigre Arpt', -4);
INSERT INTO public.airports VALUES (3314, 'Espiritu Santo', 'SON', 'VU', -15.505033, 167.21974, 'Pekoa Arpt', 11);
INSERT INTO public.airports VALUES (3315, 'Soderhamn', 'SOO', 'SE', 61.2614, 17.0983, 'Soderhamn Arpt', -100);
INSERT INTO public.airports VALUES (3316, 'Pinehurst', 'SOP', 'US', 35.2374, -79.3912, 'Pinehurst Arpt', -100);
INSERT INTO public.airports VALUES (3317, 'Sorong', 'SOQ', 'ID', -0.926358, 131.1212, 'Jefman Arpt', 9);
INSERT INTO public.airports VALUES (3318, 'Southampton', 'SOU', 'GB', 50.95026, -1.356803, 'Southampton Intl Arpt', 0);
INSERT INTO public.airports VALUES (3319, 'Seldovia', 'SOV', 'US', 59.4424, -151.7041, 'Seldovia Arpt', -100);
INSERT INTO public.airports VALUES (3320, 'Show Low', 'SOW', 'US', 34.265556, -110.005554, 'Show Low Arpt', -7);
INSERT INTO public.airports VALUES (3321, 'Stronsay', 'SOY', 'GB', 59.1553, -2.64139, 'Stronsay Arpt', 0);
INSERT INTO public.airports VALUES (3322, 'Santa Cruz', 'SPC', 'ES', 28.626478, -17.755611, 'La Palma Arpt', 0);
INSERT INTO public.airports VALUES (3323, 'Spearfish', 'SPF', 'US', 44.48114, -103.786, 'Black Hills Clyde Ice Field', -7);
INSERT INTO public.airports VALUES (3324, 'St Petersburg', 'SPG', 'US', 27.765112, -82.62697, 'Whitted Arpt', -5);
INSERT INTO public.airports VALUES (3325, 'Springfield', 'SPI', 'US', 39.8441, -89.67789, 'Capital Airport', -6);
INSERT INTO public.airports VALUES (3326, 'Sparta', 'SPJ', 'GR', 0, 0, 'Sparta Arpt', -100);
INSERT INTO public.airports VALUES (3327, 'Sapporo', 'OKD', 'JP', 43.1161, 141.38, 'Okadama Arpt', 9);
INSERT INTO public.airports VALUES (3328, 'Sapporo', 'CTS', 'JP', 42.7752, 141.69228, 'Chitose Arpt', 9);
INSERT INTO public.airports VALUES (3329, 'Spangdahlem', 'SPM', 'DE', 49.972668, 6.6925, 'Spangdahlem Air Base', 1);
INSERT INTO public.airports VALUES (3330, 'Saipan', 'SPN', 'MP', 15.119003, 145.72935, 'Saipan Intl', 10);
INSERT INTO public.airports VALUES (3331, 'San Pedro', 'SPR', 'BZ', 17.913937, -87.97108, 'San Pedro Arpt', -6);
INSERT INTO public.airports VALUES (3332, 'Wichita Falls', 'SPS', 'US', 33.988796, -98.4919, 'Wichita Falls Municipal Arpt', -6);
INSERT INTO public.airports VALUES (3333, 'Split', 'SPU', 'HR', 43.538944, 16.297964, 'Split Arpt', 1);
INSERT INTO public.airports VALUES (3334, 'Spencer', 'SPW', 'US', 43.165527, -95.202805, 'Spencer Municipal', -6);
INSERT INTO public.airports VALUES (3335, 'Springdale', 'SPZ', 'US', 39.403027, -119.25119, 'Springdale Municipal Arpt', -8);
INSERT INTO public.airports VALUES (3336, 'Santa Ynez', 'SQA', 'US', 0, 0, 'Santa Ynez Arpt', -100);
INSERT INTO public.airports VALUES (3337, 'Son La', 'SQH', 'VN', 21.217, 104.033, 'Na San Arpt', 7);
INSERT INTO public.airports VALUES (3338, 'Sterling', 'SQI', 'US', 0, 0, 'Whiteside Cty Municipal', -100);
INSERT INTO public.airports VALUES (3339, 'San Carlos', 'SQL', 'US', 37.511944, -122.24944, 'San Carlos Arpt', -8);
INSERT INTO public.airports VALUES (3340, 'Storuman', 'SQO', 'SE', 64.96089, 17.696583, 'Gunnarn Arpt', 1);
INSERT INTO public.airports VALUES (3341, 'Sucre', 'SRE', 'BO', -19.007084, -65.28875, 'Sucre Arpt', -4);
INSERT INTO public.airports VALUES (3342, 'Semarang', 'SRG', 'ID', -6.971447, 110.37412, 'Achmad Uani Arpt', 7);
INSERT INTO public.airports VALUES (3343, 'Santa Rosalia', 'SRL', 'MX', 0, 0, 'Santa Rosalia Arpt', -100);
INSERT INTO public.airports VALUES (3344, 'Strahan', 'SRN', 'AU', -42.155, 145.292, 'Strahan Arpt', 10);
INSERT INTO public.airports VALUES (3345, 'Stord', 'SRP', 'NO', 59.791924, 5.34085, 'Stord Arpt', 1);
INSERT INTO public.airports VALUES (3346, 'Sarasota', 'SRQ', 'US', 27.395445, -82.55439, 'Sarasota Bradenton Arpt', -5);
INSERT INTO public.airports VALUES (3347, 'Santa Cruz', 'SRU', 'US', 0, 0, 'Skypark Arpt', -100);
INSERT INTO public.airports VALUES (3348, 'Santa Cruz', 'SRZ', 'BO', -17.8, -63.166668, 'El Trompillo Arpt', -4);
INSERT INTO public.airports VALUES (3349, 'Santa Cruz', 'VVI', 'BO', -17.644756, -63.135365, 'Viru Viru Intl Arpt', -4);
INSERT INTO public.airports VALUES (3350, 'Salvador', 'SSA', 'BR', -12.910994, -38.331043, 'Luis E Magalhaes Arpt', -3);
INSERT INTO public.airports VALUES (3351, 'Malabo', 'SSG', 'GQ', 3.755267, 8.708717, 'Santa Isabel Arpt', 1);
INSERT INTO public.airports VALUES (3352, 'Sharm El Sheik', 'SSH', 'EG', 27.977285, 34.39495, 'Ophira Arpt', 2);
INSERT INTO public.airports VALUES (3353, 'St Simons Is', 'SSI', 'US', 31.1518, -81.3913, 'McKinnon Arpt', -100);
INSERT INTO public.airports VALUES (3354, 'Sandnessjoen', 'SSJ', 'NO', 65.956825, 12.468944, 'Stokka Arpt', 1);
INSERT INTO public.airports VALUES (3355, 'Sault Ste Marie', 'CIU', 'US', 46.2508, -84.4724, 'Chippewa Cnty Intl', -5);
INSERT INTO public.airports VALUES (3356, 'La Sarre', 'SSQ', 'CA', 0, 0, 'La Sarre Rail Station', -100);
INSERT INTO public.airports VALUES (3357, 'Samsun', 'SZF', 'TR', 41.2545, 36.5671, 'Carsamba Arpt', 2);
INSERT INTO public.airports VALUES (3358, 'Santos', 'SSZ', 'BR', -23.925205, -46.2875, 'Santos Arpt', -3);
INSERT INTO public.airports VALUES (3359, 'Santa Barbara', 'STB', 'VE', 8.974425, -71.943016, 'Las Delicias Arpt', -4);
INSERT INTO public.airports VALUES (3360, 'Saint Cloud', 'STC', 'US', 45.546555, -94.05989, 'Saint Cloud Municipal', -6);
INSERT INTO public.airports VALUES (3361, 'Santo Domingo', 'STD', 'VE', 7.565111, -72.035126, 'Mayor Humberto Vivas Guerrero Arpt', -4);
INSERT INTO public.airports VALUES (3362, 'Stevens Point', 'STE', 'US', 0, 0, 'Stevens Point Municipal', -100);
INSERT INTO public.airports VALUES (3363, 'Santiago', 'STI', 'DO', 19.406092, -70.60469, 'Santiago Municipal', -4);
INSERT INTO public.airports VALUES (3364, 'St Joseph', 'STJ', 'US', 39.771942, -94.909706, 'Rosecrans Memorial Arpt', -6);
INSERT INTO public.airports VALUES (3365, 'St Louis', 'SUS', 'US', 38.66212, -90.65205, 'Spirit Of St Louis Arpt', -7);
INSERT INTO public.airports VALUES (3366, 'St Louis', 'CPS', 'US', 38.570724, -90.15622, 'East St Louis', -6);
INSERT INTO public.airports VALUES (3367, 'St Louis', 'STL', 'US', 38.748695, -90.370026, 'Lambert St Louis Intl', -6);
INSERT INTO public.airports VALUES (3368, 'Santarem', 'STM', 'BR', -2.422431, -54.79279, 'Eduardo Gomes Arpt', -4);
INSERT INTO public.airports VALUES (3369, 'Stockholm', 'XEW', 'SE', 0, 0, 'Flemingsberg Rail Station', -100);
INSERT INTO public.airports VALUES (3370, 'Stockholm', 'ARN', 'SE', 59.651943, 17.918612, 'Arlanda Arpt', 1);
INSERT INTO public.airports VALUES (3371, 'Stockholm', 'XEV', 'SE', 0, 0, 'Stockholm Rail Station', -100);
INSERT INTO public.airports VALUES (3372, 'Stockholm', 'NYO', 'SE', 58.788635, 16.91219, 'Skavsta Airport', 1);
INSERT INTO public.airports VALUES (3373, 'Stockholm', 'VST', 'SE', 59.589443, 16.633612, 'Hasslo Airport', 1);
INSERT INTO public.airports VALUES (3374, 'Stockholm', 'BMA', 'SE', 59.35437, 17.94165, 'Bromma Airport', 1);
INSERT INTO public.airports VALUES (3375, 'St Paul', 'STP', 'US', 51.53, -0.125, 'Downtown St Paul Arpt', 0);
INSERT INTO public.airports VALUES (3376, 'Stuttgart', 'STR', 'DE', 48.689877, 9.221964, 'Stuttgart Arpt', 1);
INSERT INTO public.airports VALUES (3377, 'Stuttgart', 'ZWS', 'DE', 48.78361, 9.181667, 'Stuttgart Railway Service', 1);
INSERT INTO public.airports VALUES (3378, 'Santa Rosa', 'STS', 'US', 38.50898, -122.81288, 'Sonoma Cty Arpt', -8);
INSERT INTO public.airports VALUES (3379, 'St Thomas', 'STT', 'US', 18.337305, -64.97336, 'Cyril E King Arpt', -4);
INSERT INTO public.airports VALUES (3380, 'Stavropol', 'STW', 'RU', 45.109165, 42.112778, 'Stavropol Arpt', 4);
INSERT INTO public.airports VALUES (3381, 'St Croix', 'STX', 'US', 17.701889, -64.79855, 'Alexander Hamilton Arpt', -4);
INSERT INTO public.airports VALUES (3382, 'Salto', 'STY', 'UY', -31.43848, -57.985294, 'Salto Arpt', -3);
INSERT INTO public.airports VALUES (3383, 'Stuart', 'SUA', 'US', 27.1817, -80.22129, 'Witham Field', -4);
INSERT INTO public.airports VALUES (3384, 'Surabaya', 'SUB', 'ID', -7.379831, 112.78686, 'Juanda Arpt', 7);
INSERT INTO public.airports VALUES (3385, 'Sturgeon Bay', 'SUE', 'US', 44.843666, -87.421555, 'Door Country Arpt', -6);
INSERT INTO public.airports VALUES (3386, 'Lamezia Terme', 'SUF', 'IT', 38.905396, 16.24227, 'S Eufemia Arpt', 1);
INSERT INTO public.airports VALUES (3387, 'Sur Om', 'SUH', 'OM', 0, 0, 'Sur Arpt', -100);
INSERT INTO public.airports VALUES (3388, 'Sumter', 'SUM', 'US', 0, 0, 'Sumter Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3389, 'Sun Valley', 'SUN', 'US', 43.504444, -114.296196, 'Friedman Memorial', -7);
INSERT INTO public.airports VALUES (3390, 'Fairfield', 'SUU', 'US', 38.26269, -121.92747, 'Travis AFB', -8);
INSERT INTO public.airports VALUES (3391, 'Suva', 'SUV', 'FJ', -18.043266, 178.55923, 'Nausori Airport', 12);
INSERT INTO public.airports VALUES (3392, 'Superior', 'SUW', 'US', 0, 0, 'Richard I Bong Arpt', -100);
INSERT INTO public.airports VALUES (3393, 'Sioux City', 'SUX', 'US', 42.402603, -96.38437, 'Sioux Gateway Arpt', -6);
INSERT INTO public.airports VALUES (3394, 'Sambava', 'SVB', 'MG', -14.278611, 50.17472, 'Sambava Arpt', 3);
INSERT INTO public.airports VALUES (3395, 'Silver City', 'SVC', 'US', 32.6365, -108.156, 'Grant County Airport', -7);
INSERT INTO public.airports VALUES (3396, 'St Vincent', 'SVD', 'VC', 13.144306, -61.21086, 'Arnos Vale Arpt', -4);
INSERT INTO public.airports VALUES (3397, 'Stavanger', 'ZWC', 'NO', 0, 0, 'Stavanger Rail Station', -100);
INSERT INTO public.airports VALUES (3398, 'Stavanger', 'XOQ', 'NO', 0, 0, 'Sira Rail Station', -100);
INSERT INTO public.airports VALUES (3399, 'Stavanger', 'XKC', 'NO', 0, 0, 'Sandnes Rail Station', -100);
INSERT INTO public.airports VALUES (3400, 'Stavanger', 'SVG', 'NO', 58.876778, 5.637856, 'Sola Airport', 1);
INSERT INTO public.airports VALUES (3401, 'Statesville', 'SVH', 'US', 0, 0, 'Statesville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3402, 'Svolvaer', 'SVJ', 'NO', 68.2433, 14.6692, 'Helle', 1);
INSERT INTO public.airports VALUES (3403, 'Savonlinna', 'SVL', 'FI', 61.943066, 28.945135, 'Savonlinna Arpt', 2);
INSERT INTO public.airports VALUES (3404, 'Sevilla', 'SVQ', 'ES', 37.418, -5.893106, 'San Pablo Arpt', 1);
INSERT INTO public.airports VALUES (3405, 'Savusavu', 'SVU', 'FJ', -16.8028, 179.341, 'Savusavu Airport', 12);
INSERT INTO public.airports VALUES (3406, 'Ekaterinburg', 'SVX', 'RU', 56.743107, 60.802727, 'Koltsovo Arpt', 6);
INSERT INTO public.airports VALUES (3407, 'San Antonio', 'SVZ', 'VE', 7.840831, -72.43974, 'San Antonio Arpt', -4);
INSERT INTO public.airports VALUES (3408, 'Shantou', 'SWA', 'CN', 23.4, 116.683, 'Shantou Airport', 8);
INSERT INTO public.airports VALUES (3409, 'Seward', 'SWD', 'US', 60.126938, -149.41881, 'Seward Airport', -8);
INSERT INTO public.airports VALUES (3410, 'Newburgh', 'SWF', 'US', 41.504093, -74.104836, 'Stewart Airport', -5);
INSERT INTO public.airports VALUES (3411, 'Swan Hill', 'SWH', 'AU', -35.3772, 143.5322, 'Swan Hill Arpt', -100);
INSERT INTO public.airports VALUES (3412, 'Swindon', 'SWI', 'GB', 0, 0, 'Swindon Rail Station', -100);
INSERT INTO public.airports VALUES (3413, 'Swindon', 'XWS', 'GB', 0, 0, 'Swindon Rail Station', -100);
INSERT INTO public.airports VALUES (3414, 'Stillwater', 'SWO', 'US', 0, 0, 'Searcy Fld', -100);
INSERT INTO public.airports VALUES (3415, 'Swansea', 'SWS', 'GB', 51.60533, -4.067833, 'Fairwood Comm', 0);
INSERT INTO public.airports VALUES (3416, 'Strezhevoy Airport', 'SWT', 'RU', 60.716667, 77.65, 'Strezhevoy Airport', 7);
INSERT INTO public.airports VALUES (3417, 'Su Won', 'SWU', 'KR', 0, 0, 'Su Won Arpt', -100);
INSERT INTO public.airports VALUES (3418, 'Strasbourg', 'SXB', 'FR', 48.53832, 7.628233, 'Enzheim Arpt', 1);
INSERT INTO public.airports VALUES (3419, 'Strasbourg', 'XER', 'FR', 0, 0, 'Strasbourg Bus Service', -100);
INSERT INTO public.airports VALUES (3420, 'Sale', 'SXE', 'AU', -38.0983, 147.15, 'Sale Arpt', -100);
INSERT INTO public.airports VALUES (3421, 'Sligo', 'SXL', 'IE', 54.280212, -8.599206, 'Collooney', 0);
INSERT INTO public.airports VALUES (3422, 'St Maarten', 'SXM', 'AN', 18.040953, -63.1089, 'Princ Juliana Arpt', -4);
INSERT INTO public.airports VALUES (3423, 'Srinagar', 'SXR', 'IN', 33.98714, 74.77425, 'Srinagar Arpt', 5);
INSERT INTO public.airports VALUES (3424, 'Siirt Airport', 'SXZ', 'TR', 0, 0, 'Siirt Airport', 2);
INSERT INTO public.airports VALUES (3425, 'Sydney', 'RSE', 'AU', 0, 0, 'Au Rose Bay Arpt', -100);
INSERT INTO public.airports VALUES (3426, 'Sydney', 'SYD', 'AU', -33.94611, 151.17722, 'Sydney Kingsford Smith Arpt', 10);
INSERT INTO public.airports VALUES (3427, 'Sydney', 'LBH', 'AU', 0, 0, 'Palm Beach Arpt', -100);
INSERT INTO public.airports VALUES (3428, 'Shonai', 'SYO', 'JP', 38.81222, 139.78722, 'Shonai Arpt', 9);
INSERT INTO public.airports VALUES (3429, 'Syracuse', 'SYR', 'US', 43.111187, -76.10631, 'Hancock Intl', -5);
INSERT INTO public.airports VALUES (3430, 'Sanya', 'SYX', 'CN', 18.302896, 109.41227, 'Sanya Arpt', 8);
INSERT INTO public.airports VALUES (3431, 'Stornoway', 'SYY', 'GB', 58.215557, -6.331111, 'Stornoway Arpt', 0);
INSERT INTO public.airports VALUES (3432, 'Shiraz', 'SYZ', 'IR', 29.539242, 52.589787, 'Shiraz Arpt', 4);
INSERT INTO public.airports VALUES (3433, 'Santa Cruz', 'SZC', 'CR', 0, 0, 'Guanacaste Arpt', -100);
INSERT INTO public.airports VALUES (3434, 'Sheffield', 'SZD', 'GB', 53.3943, -1.3885, 'Sheffield City Arpt', -100);
INSERT INTO public.airports VALUES (3435, 'Salzburg', 'SZG', 'AT', 47.793304, 13.004333, 'W A Mozart Arpt', 1);
INSERT INTO public.airports VALUES (3436, 'Siguanea', 'SZJ', 'CU', 21.6333, -82.95, 'Siguanea Arpt', -100);
INSERT INTO public.airports VALUES (3437, 'Skukuza', 'SZK', 'ZA', -24.960943, 31.588732, 'Skukuza Arpt', 2);
INSERT INTO public.airports VALUES (3438, 'Shanzhou', 'SZO', 'CN', 0, 0, 'Shanzhou Arpt', -100);
INSERT INTO public.airports VALUES (3439, 'Santa Paula', 'SZP', 'US', 0, 0, 'Santa Paula Arpt', -100);
INSERT INTO public.airports VALUES (3440, 'Stara Zagora', 'SZR', 'BG', 0, 0, 'Stara Zagora Arpt', -100);
INSERT INTO public.airports VALUES (3441, 'San Cristobal De Las Casas', 'SZT', 'MX', 16.6904, -92.5303, 'San Cristobal Arpt', -100);
INSERT INTO public.airports VALUES (3442, 'Suzhou', 'SZV', 'CN', 0, 0, 'Suzhou Arpt', -100);
INSERT INTO public.airports VALUES (3443, 'Shenzhen', 'SZX', 'CN', 22.639257, 113.81066, 'Shenzhen Arpt', 8);
INSERT INTO public.airports VALUES (3444, 'Szymany', 'SZY', 'PL', 53.4819, 20.9377, 'Mazury Arpt', -100);
INSERT INTO public.airports VALUES (3445, 'Szczecin', 'SZZ', 'PL', 53.584732, 14.902206, 'Goleniow Arpt', 1);
INSERT INTO public.airports VALUES (3446, 'Tobago', 'TAB', 'TT', 11.149658, -60.832195, 'Crown Point Arpt', -4);
INSERT INTO public.airports VALUES (3447, 'Tacloban', 'TAC', 'PH', 11.227628, 125.027756, 'D Z Romualdez Arpt', 8);
INSERT INTO public.airports VALUES (3448, 'Daegu', 'TAE', 'KR', 35.894108, 128.65886, 'Daegu Arpt', 9);
INSERT INTO public.airports VALUES (3449, 'Tagbilaran', 'TAG', 'PH', 9.664081, 123.85325, 'Tagbilaran Arpt', 8);
INSERT INTO public.airports VALUES (3450, 'Tanna', 'TAH', 'VU', -19.455198, 169.22394, 'Tanna Arpt', 11);
INSERT INTO public.airports VALUES (3451, 'Takamatsu', 'TAK', 'JP', 34.21417, 134.01555, 'Takamatsu Arpt', 9);
INSERT INTO public.airports VALUES (3452, 'Tanana', 'TAL', 'US', 65.17956, -152.07584, 'Ralph Calhoun Arpt', -9);
INSERT INTO public.airports VALUES (3453, 'Tampico', 'TAM', 'MX', 22.29645, -97.86593, 'General F Javier Mina', -6);
INSERT INTO public.airports VALUES (3454, 'Qingdao', 'TAO', 'CN', 36.26611, 120.374435, 'Liuting Arpt', 8);
INSERT INTO public.airports VALUES (3455, 'Tapachula', 'TAP', 'MX', 14.794339, -92.370026, 'Tapachula Arpt', -6);
INSERT INTO public.airports VALUES (3456, 'Taranto', 'TAR', 'IT', 40.517513, 17.403212, 'M A Grottag Arpt', 1);
INSERT INTO public.airports VALUES (3457, 'Tashkent', 'TAS', 'UZ', 41.257862, 69.28119, 'Vostochny Arpt', 5);
INSERT INTO public.airports VALUES (3458, 'Poprad Tatry', 'TAT', 'SK', 49.073593, 20.241142, 'Poprad Tatry Arpt', 1);
INSERT INTO public.airports VALUES (3459, 'Tartu', 'TAY', 'EE', 58.30746, 26.690428, 'Tartu Arpt', 2);
INSERT INTO public.airports VALUES (3460, 'Dashoguz', 'TAZ', 'TM', 41.76472, 59.833057, 'Dashoguz Arpt', 5);
INSERT INTO public.airports VALUES (3461, 'Tuy Hoa', 'TBB', 'VN', 13.04955, 109.33371, 'Tuy Hoa Arpt', 7);
INSERT INTO public.airports VALUES (3462, 'Tububil', 'TBG', 'PG', -5.27861, 141.226, 'Tabubil Arpt', 10);
INSERT INTO public.airports VALUES (3463, 'Tabarka', 'TBJ', 'TN', 36.978333, 8.876389, 'Tabarka Arpt', 1);
INSERT INTO public.airports VALUES (3464, 'Ft Leonard Wood', 'TBN', 'US', 37.74163, -92.14074, 'Forney Field', -6);
INSERT INTO public.airports VALUES (3465, 'Tabora', 'TBO', 'TZ', -5.07639, 32.8333, 'Tabora Arpt', 3);
INSERT INTO public.airports VALUES (3466, 'Tumbes', 'TBP', 'PE', -3.552528, -80.381355, 'Tumbes Arpt', -5);
INSERT INTO public.airports VALUES (3467, 'Tbilisi', 'TBS', 'GE', 41.669167, 44.954723, 'Novo Alexeyevka Arpt', 4);
INSERT INTO public.airports VALUES (3468, 'Tabatinga', 'TBT', 'BR', -4.255669, -69.93583, 'Tabatinga Intl Arpt', -4);
INSERT INTO public.airports VALUES (3469, 'Nuku Alofa', 'TBU', 'TO', -21.241215, -175.14964, 'Tongatapu Intl', 13);
INSERT INTO public.airports VALUES (3470, 'Tambov', 'TBW', 'RU', 52.81, 41.48, 'Tambov Arpt', 4);
INSERT INTO public.airports VALUES (3471, 'Tabriz', 'TBZ', 'IR', 38.13389, 46.235, 'Tabriz International Arpt', 4);
INSERT INTO public.airports VALUES (3472, 'Tennant Creek', 'TCA', 'AU', -19.6344, 134.183, 'Tennant Creek Arpt', 9);
INSERT INTO public.airports VALUES (3473, 'Treasure Cay', 'TCB', 'BS', 26.745337, -77.391266, 'Treasure Cay Arpt', -5);
INSERT INTO public.airports VALUES (3474, 'Tulcea', 'TCE', 'RO', 45.062485, 28.714312, 'Tulcea Arpt', 2);
INSERT INTO public.airports VALUES (3475, 'Tenerife', 'TFS', 'ES', 28.044476, -16.572489, 'Reina Sofia Arpt', 0);
INSERT INTO public.airports VALUES (3476, 'Tenerife', 'TFN', 'ES', 28.482653, -16.341536, 'Tenerife Norte Los Rodeos Arpt', 0);
INSERT INTO public.airports VALUES (3477, 'Tuscaloosa', 'TCL', 'US', 33.220627, -87.611404, 'Van De Graff Arpt', -6);
INSERT INTO public.airports VALUES (3478, 'Tehuacan', 'TCN', 'MX', 18.497189, -97.419945, 'Tehuacan Arpt', -6);
INSERT INTO public.airports VALUES (3479, 'Taba', 'TCP', 'EG', 29.587778, 34.778057, 'Ras An Naqb Arpt', 2);
INSERT INTO public.airports VALUES (3480, 'Tuticorin', 'TCR', 'IN', 8.7833, 78.1333, 'Tuticorin Arpt', -100);
INSERT INTO public.airports VALUES (3481, 'Thaba Nchu', 'TCU', 'ZA', 0, 0, 'Thaba Nchu Arpt', -100);
INSERT INTO public.airports VALUES (3482, 'Tocumwal', 'TCW', 'AU', -35.8117, 145.6083, 'Tocumwal Arpt', -100);
INSERT INTO public.airports VALUES (3483, 'Trinidad', 'TDD', 'BO', -14.818739, -64.91802, 'Trinidad Arpt', -4);
INSERT INTO public.airports VALUES (3484, 'Taldy Kurgan', 'TDK', 'KZ', 45.016666, 78.36667, 'Taldy Kurgan Arpt', 6);
INSERT INTO public.airports VALUES (3485, 'Tandil', 'TDL', 'AR', -37.237392, -59.22792, 'Tandil Arpt', -3);
INSERT INTO public.airports VALUES (3486, 'Trat', 'TDX', 'TH', 12.274572, 102.318954, 'Trat Arpt', 7);
INSERT INTO public.airports VALUES (3487, 'Tela', 'TEA', 'HN', 15.775864, -87.475845, 'Tela Arpt', -6);
INSERT INTO public.airports VALUES (3488, 'Teterboro', 'TEB', 'US', 40.8501, -74.06084, 'Teterboro Arpt', -5);
INSERT INTO public.airports VALUES (3489, 'Telemaco Borba', 'TEC', 'BR', -24.3158, -50.6517, 'Telemaco Borba Arpt', -100);
INSERT INTO public.airports VALUES (3490, 'Thisted', 'TED', 'DK', 57.0688, 8.705225, 'Thisted Arpt', 1);
INSERT INTO public.airports VALUES (3491, 'Tongren', 'TEN', 'CN', 27.884, 109.31, 'Tongren Arpt', 8);
INSERT INTO public.airports VALUES (3492, 'Corlu', 'TEQ', 'TR', 41.13825, 27.919094, 'Corlu Airport Information', 2);
INSERT INTO public.airports VALUES (3493, 'Terceira', 'TER', 'PT', 38.76184, -27.090797, 'Lajes Arpt', -1);
INSERT INTO public.airports VALUES (3494, 'Tete', 'TET', 'MZ', -16.104816, 33.640182, 'Matunda Arpt', 2);
INSERT INTO public.airports VALUES (3495, 'Te Anau', 'TEU', 'NZ', -45.533054, 167.65, 'Manapouri Airport', 12);
INSERT INTO public.airports VALUES (3496, 'Telluride', 'TEX', 'US', 37.95376, -107.90848, 'Telluride Municipal Arpt', -7);
INSERT INTO public.airports VALUES (3497, 'Tefe', 'TFF', 'BR', -3.382944, -64.72405, 'Tefe Arpt', -4);
INSERT INTO public.airports VALUES (3498, 'Podgorica', 'TGD', 'ME', 42.35939, 19.251894, 'Golubovci Arpt', 1);
INSERT INTO public.airports VALUES (3499, 'Kuala Terengganu', 'TGG', 'MY', 5.382639, 103.10336, 'Sultan Mahmood Arpt', 8);
INSERT INTO public.airports VALUES (3500, 'Tirgu Mures', 'TGM', 'RO', 46.467712, 24.412525, 'Tirgu Mures Arpt', 2);
INSERT INTO public.airports VALUES (3501, 'Traralgon', 'TGN', 'AU', 0, 0, 'La Trobe Traralgon Arpt', -100);
INSERT INTO public.airports VALUES (3502, 'Tongliao', 'TGO', 'CN', 43.5567, 122.2, 'Tongliao Arpt', 8);
INSERT INTO public.airports VALUES (3503, 'Tanga', 'TGT', 'TZ', -5.092358, 39.07116, 'Tanga Arpt', 3);
INSERT INTO public.airports VALUES (3504, 'Tegucigalpa', 'TGU', 'HN', 14.060883, -87.21719, 'Toncontin Arpt', -6);
INSERT INTO public.airports VALUES (3505, 'Tuxtla Gutierrez', 'TGZ', 'MX', 16.561823, -93.02608, 'Llano San Juan Arpt', -6);
INSERT INTO public.airports VALUES (3506, 'Tullahoma', 'THA', 'US', 0, 0, 'Northern Arpt', -100);
INSERT INTO public.airports VALUES (3507, 'Tchien', 'THC', 'LR', 0, 0, 'Tchien Arpt', -100);
INSERT INTO public.airports VALUES (3508, 'Teresina', 'THE', 'BR', -5.059942, -42.82348, 'Teresina Arpt', -3);
INSERT INTO public.airports VALUES (3509, 'Thangool', 'THG', 'AU', -24.493889, 150.57611, 'Thangool Arpt', 10);
INSERT INTO public.airports VALUES (3510, 'Trollhattan', 'THN', 'SE', 58.318054, 12.345, 'Trollhattan Arpt', 1);
INSERT INTO public.airports VALUES (3511, 'Thermopolis', 'THP', 'US', 0, 0, 'Hot Springs', -100);
INSERT INTO public.airports VALUES (3512, 'Teheran', 'THR', 'IR', 35.689167, 51.313416, 'Mehrabad Arpt', 4);
INSERT INTO public.airports VALUES (3513, 'Teheran', 'IKA', 'IR', 35, 51, 'Imam Khomeini Arpt', 3);
INSERT INTO public.airports VALUES (3514, 'Sukhothai', 'THS', 'TH', 17.237991, 99.818184, 'Sukhothai Arpt', 7);
INSERT INTO public.airports VALUES (3515, 'York', 'THV', 'US', 0, 0, 'York Arpt', -100);
INSERT INTO public.airports VALUES (3516, 'Tirana', 'TIA', 'AL', 41.41474, 19.72056, 'Rinas Arpt', 1);
INSERT INTO public.airports VALUES (3517, 'Taif', 'TIF', 'SA', 21.483418, 40.544334, 'Taif Airport', 3);
INSERT INTO public.airports VALUES (3518, 'Tingwon', 'TIG', 'PG', 0, 0, 'Tingwon Arpt', -100);
INSERT INTO public.airports VALUES (3519, 'Tikehau', 'TIH', 'PF', -15.119617, -148.2307, 'Tikehau Arpt', -10);
INSERT INTO public.airports VALUES (3520, 'Tijuana', 'TIJ', 'MX', 32.541065, -116.97016, 'Gen Abelardo Rodriguez', -8);
INSERT INTO public.airports VALUES (3521, 'Timika', 'TIM', 'ID', -4.528275, 136.88737, 'Timika Arpt', 9);
INSERT INTO public.airports VALUES (3522, 'Tripoli', 'TIP', 'LY', 32.663544, 13.159011, 'Tripoli Intl Arpt', 1);
INSERT INTO public.airports VALUES (3523, 'Tinian', 'TIQ', 'MP', 14.999203, 145.61935, 'Tinian Arpt', 10);
INSERT INTO public.airports VALUES (3524, 'Tirupati', 'TIR', 'IN', 13.632492, 79.54326, 'Tirupati Arpt', 5);
INSERT INTO public.airports VALUES (3525, 'Thursday Island', 'TIS', 'AU', -10.5864, 142.29, 'Thursday Island Arpt', -100);
INSERT INTO public.airports VALUES (3526, 'Timaru', 'TIU', 'NZ', -44.302776, 171.22528, 'Timaru Arpt', 12);
INSERT INTO public.airports VALUES (3527, 'Tivat', 'TIV', 'ME', 42.404663, 18.723286, 'Tivat Arpt', 1);
INSERT INTO public.airports VALUES (3528, 'Tacoma', 'TIW', 'US', 47.2679, -122.5781, 'Tacoma Industrial Arpt', -100);
INSERT INTO public.airports VALUES (3529, 'Titusville', 'TIX', 'US', 28.5148, -80.7992, 'Space Center Executive Arpt', -100);
INSERT INTO public.airports VALUES (3530, 'Tari', 'TIZ', 'PG', -5.845, 142.948, 'Tari Arpt', 10);
INSERT INTO public.airports VALUES (3531, 'Tarija', 'TJA', 'BO', -21.555737, -64.701324, 'Tarija Arpt', -4);
INSERT INTO public.airports VALUES (3532, 'TOKAT HAVALIMANI', 'TJK', 'TR', 0, 0, 'TOKAT HAVALIMANI', 2);
INSERT INTO public.airports VALUES (3533, 'Tyumen', 'TJM', 'RU', 57.189568, 65.3243, 'Tyumen Arpt', 6);
INSERT INTO public.airports VALUES (3534, 'Tanjung Pandan', 'TJQ', 'ID', -2.745722, 107.75491, 'Bulutumbang Arpt', 7);
INSERT INTO public.airports VALUES (3535, 'Truckee', 'TKF', 'US', 39.32, -120.1396, 'Truckee Arpt', -100);
INSERT INTO public.airports VALUES (3536, 'Bandar Lampung', 'TKG', 'ID', -5.242339, 105.17894, 'Branti Arpt', 7);
INSERT INTO public.airports VALUES (3537, 'Tok Ak', 'TKJ', 'US', 63.2955, -143.0061, 'Tok Arpt', -100);
INSERT INTO public.airports VALUES (3538, 'Truk', 'TKK', 'FM', 7.461869, 151.843, 'Truk Arpt', 10);
INSERT INTO public.airports VALUES (3539, 'Tikal', 'TKM', 'GT', 0, 0, 'El Peten Arpt', -100);
INSERT INTO public.airports VALUES (3540, 'Tokunoshima', 'TKN', 'JP', 27.836382, 128.88126, 'Tokunoshima Arpt', 9);
INSERT INTO public.airports VALUES (3541, 'Kigoma', 'TKQ', 'TZ', -4.883, 29.633, 'Kigoma Arpt', 3);
INSERT INTO public.airports VALUES (3542, 'Tokushima', 'TKS', 'JP', 34.13281, 134.60664, 'Tokushima Arpt', 9);
INSERT INTO public.airports VALUES (3543, 'Turku', 'TKU', 'FI', 60.51414, 22.262808, 'Turku Arpt', 2);
INSERT INTO public.airports VALUES (3544, 'Toluca', 'TLC', 'MX', 19.337072, -99.56601, 'Morelos Arpt', -6);
INSERT INTO public.airports VALUES (3545, 'Tuli Block', 'TLD', 'BW', -22.1892, 29.1269, 'Limpopo Valley Arpt', 2);
INSERT INTO public.airports VALUES (3546, 'Tulear', 'TLE', 'MG', -23.38337, 43.728455, 'Tulear Arpt', 3);
INSERT INTO public.airports VALUES (3547, 'Tallahassee', 'TLH', 'US', 30.396528, -84.350334, 'Tallahassee Municipal', -5);
INSERT INTO public.airports VALUES (3548, 'Tallinn', 'TLL', 'EE', 59.41332, 24.832844, 'Ulemiste Arpt', 2);
INSERT INTO public.airports VALUES (3549, 'Tlemcen', 'TLM', 'DZ', 35.016666, -1.45, 'Zenata Arpt', 1);
INSERT INTO public.airports VALUES (3550, 'Toulon', 'TLN', 'FR', 43.0973, 6.14603, 'Le Palyvestre Arpt', 1);
INSERT INTO public.airports VALUES (3551, 'Tulare', 'TLR', 'US', 0, 0, 'Mefford Field', -100);
INSERT INTO public.airports VALUES (3552, 'Toulouse', 'TLS', 'FR', 43.629074, 1.363819, 'Blagnac Arpt', 1);
INSERT INTO public.airports VALUES (3553, 'Tel Aviv', 'TLV', 'IL', 32.01139, 34.886665, 'Ben Gurion Intl Arpt', 2);
INSERT INTO public.airports VALUES (3554, 'Tel Aviv', 'SDV', 'IL', 32.114662, 34.782238, 'Dov Airport', 2);
INSERT INTO public.airports VALUES (3555, 'Tifton', 'TMA', 'US', 31.428982, -83.48855, 'Henry Tift Myers Arpt', -5);
INSERT INTO public.airports VALUES (3556, 'Tomanggong', 'TMG', 'MY', 5.4, 118.65, 'Tomanggong Arpt', 8);
INSERT INTO public.airports VALUES (3557, 'Tamale', 'TML', 'GH', 9.557192, -0.863214, 'Tamale Arpt', 0);
INSERT INTO public.airports VALUES (3558, 'Tamatave', 'TMM', 'MG', -18.109516, 49.392536, 'Tamatave Arpt', 3);
INSERT INTO public.airports VALUES (3559, 'Tampere', 'TMP', 'FI', 61.414146, 23.604391, 'Tampere Pirkkala Arpt', 2);
INSERT INTO public.airports VALUES (3560, 'Sao Tome Is', 'TMS', 'ST', 0.378175, 6.712153, 'Sao Tome Intl Arpt', 0);
INSERT INTO public.airports VALUES (3561, 'Trombetas', 'TMT', 'BR', -1.4896, -56.3968, 'Trombetas Arpt', -100);
INSERT INTO public.airports VALUES (3562, 'Tambor', 'TMU', 'CR', 9.73852, -85.0138, 'Tambor Arpt', -6);
INSERT INTO public.airports VALUES (3563, 'Tamworth', 'TMW', 'AU', -31.083889, 150.84666, 'Tamworth Arpt', 10);
INSERT INTO public.airports VALUES (3564, 'Thames', 'TMZ', 'NZ', 0, 0, 'Thames Arpt', -100);
INSERT INTO public.airports VALUES (3565, 'Jinan', 'TNA', 'CN', 36.857216, 117.215996, 'Jinan Arpt', 8);
INSERT INTO public.airports VALUES (3566, 'Trinidad', 'TND', 'CU', 21.788462, -79.9972, 'Trinidad CU Arpt', -5);
INSERT INTO public.airports VALUES (3567, 'Tanega Shima', 'TNE', 'JP', 30.605066, 130.99123, 'Tanega Shima Arpt', 9);
INSERT INTO public.airports VALUES (3568, 'Toussus Le Noble', 'TNF', 'FR', 48.751923, 2.106189, 'Toussus Le Noble Arpt', 1);
INSERT INTO public.airports VALUES (3569, 'Tangier', 'TNG', 'MA', 35.726917, -5.916889, 'Boukhalef Arpt', 0);
INSERT INTO public.airports VALUES (3570, 'Tainan', 'TNN', 'TW', 22.950361, 120.20578, 'Tainan Arpt', 8);
INSERT INTO public.airports VALUES (3571, 'Tamarindo', 'TNO', 'CR', 10.3557, -85.85289, 'Tamarindo Arpt', -6);
INSERT INTO public.airports VALUES (3572, 'Tananarive', 'TNR', 'MG', -18.79695, 47.478806, 'Ivato Arpt', 3);
INSERT INTO public.airports VALUES (3573, 'Newton', 'TNU', 'US', 0, 0, 'Municipal Newton Arpt', -100);
INSERT INTO public.airports VALUES (3574, 'Tobruk', 'TOB', 'LY', 31.861, 23.907, 'Tobruk Arpt', 1);
INSERT INTO public.airports VALUES (3575, 'Tioman', 'TOD', 'MY', 2.818183, 104.16002, 'Tioman Arpt', 8);
INSERT INTO public.airports VALUES (3576, 'Tozeur', 'TOE', 'TN', 33.93972, 8.110556, 'Tozeur Arpt', 1);
INSERT INTO public.airports VALUES (3577, 'Tomsk', 'TOF', 'RU', 56.38028, 85.208336, 'Tomsk Arpt', 8);
INSERT INTO public.airports VALUES (3578, 'Togiak', 'TOG', 'US', 59.0528, -160.397, 'Togiak Village Arpt', -9);
INSERT INTO public.airports VALUES (3579, 'Torres', 'TOH', 'VU', -13.328, 166.638, 'Torres Airstrip', 11);
INSERT INTO public.airports VALUES (3580, 'Toledo', 'TOL', 'US', 41.586807, -83.80783, 'Toledo Express Arpt', -5);
INSERT INTO public.airports VALUES (3581, 'Topeka', 'TOP', 'US', 39.068657, -95.62248, 'Phillip Billard Arpt', -6);
INSERT INTO public.airports VALUES (3582, 'Topeka', 'FOE', 'US', 38.950943, -95.66361, 'Forbes Field', -6);
INSERT INTO public.airports VALUES (3583, 'Torrington', 'TOR', 'US', 0, 0, 'Torrington Minicipal Arpt', -100);
INSERT INTO public.airports VALUES (3584, 'Tromso', 'TOS', 'NO', 69.683334, 18.918919, 'Tromso Langnes Arpt', 1);
INSERT INTO public.airports VALUES (3585, 'Tortola Westend', 'RAD', 'VG', 0, 0, 'Road Town Arpt', -100);
INSERT INTO public.airports VALUES (3586, 'Toledo', 'TOW', 'BR', -24.6863, -53.6975, 'Toledo Arpt', -3);
INSERT INTO public.airports VALUES (3587, 'Tobolsk', 'TOX', 'RU', 0, 0, 'Tobolsk Arpt', -100);
INSERT INTO public.airports VALUES (3588, 'Toyama', 'TOY', 'JP', 36.648335, 137.1875, 'Toyama Arpt', 9);
INSERT INTO public.airports VALUES (3589, 'Tampa', 'TPA', 'US', 27.975471, -82.53325, 'Tampa Intl', -5);
INSERT INTO public.airports VALUES (3590, 'Tampa', 'TPF', 'US', 0, 0, 'Peter O Knight Arpt', -100);
INSERT INTO public.airports VALUES (3591, 'Tampa', 'PIE', 'US', 27.910168, -82.687386, 'St Petersburg Clearwater Arpt', -5);
INSERT INTO public.airports VALUES (3592, 'Taipei', 'TPE', 'TW', 25.07773, 121.23282, 'Taiwan Taoyuan Intl Arpt', 8);
INSERT INTO public.airports VALUES (3593, 'Taipei', 'TSA', 'TW', 25.069721, 121.5525, 'Sung Shan Arpt', 8);
INSERT INTO public.airports VALUES (3594, 'Tonopah', 'TPH', 'US', 38.0601, -117.0872, 'Tonopah Arpt', -100);
INSERT INTO public.airports VALUES (3595, 'Temple', 'TPL', 'US', 31.1525, -97.407776, 'Temple Arpt', -6);
INSERT INTO public.airports VALUES (3596, 'Tepic', 'TPQ', 'MX', 21.419453, -104.84258, 'Tepic Arpt', -6);
INSERT INTO public.airports VALUES (3597, 'Tom Price', 'TPR', 'AU', 0, 0, 'Tom Price', -100);
INSERT INTO public.airports VALUES (3598, 'Trapani', 'TPS', 'IT', 37.911404, 12.487961, 'Birgi Arpt', 1);
INSERT INTO public.airports VALUES (3599, 'San Domino Island', 'TQR', 'IT', 42.1025, 15.488, 'San Domino Island Arpt', 1);
INSERT INTO public.airports VALUES (3600, 'Torreon', 'TRC', 'MX', 25.568277, -103.41058, 'Francisco Sarabia Arpt', -6);
INSERT INTO public.airports VALUES (3601, 'Trondheim', 'XOD', 'NO', 0, 0, 'Oppdal Rail Station', -100);
INSERT INTO public.airports VALUES (3602, 'Trondheim', 'XZT', 'NO', 0, 0, 'Trondheim Rail Station', -100);
INSERT INTO public.airports VALUES (3603, 'Trondheim', 'TRD', 'NO', 63.457558, 10.92425, 'Trondheim Vaernes Arpt', 1);
INSERT INTO public.airports VALUES (3604, 'Tiree', 'TRE', 'GB', 56.49917, -6.869167, 'Tiree Arpt', 0);
INSERT INTO public.airports VALUES (3605, 'Tauranga', 'TRG', 'NZ', -37.671944, 176.1961, 'Tauranga Arpt', 12);
INSERT INTO public.airports VALUES (3606, 'Bristol', 'TRI', 'US', 36.475224, -82.40742, 'Tri City Regional Arpt', -5);
INSERT INTO public.airports VALUES (3607, 'Tarakan', 'TRK', 'ID', 3.326694, 117.56557, 'Tarakan Arpt', 8);
INSERT INTO public.airports VALUES (3608, 'Terrell', 'TRL', 'US', 0, 0, 'Terrell Field Arpt', -100);
INSERT INTO public.airports VALUES (3609, 'Turin', 'TRN', 'IT', 45.20076, 7.649631, 'Torino Caselle Arpt', 1);
INSERT INTO public.airports VALUES (3610, 'Taree', 'TRO', 'AU', -31.8886, 152.514, 'Taree Arpt', 10);
INSERT INTO public.airports VALUES (3611, 'Trieste', 'TRS', 'IT', 45.8275, 13.472222, 'Ronchi Dei Legionari Arpt', 1);
INSERT INTO public.airports VALUES (3612, 'Trujillo', 'TRU', 'PE', -8.081411, -79.108765, 'Trujillo Arpt', -5);
INSERT INTO public.airports VALUES (3613, 'Thiruvananthapuram', 'TRV', 'IN', 8.482122, 76.92011, 'Thiruvananthapuram Arpt', 5);
INSERT INTO public.airports VALUES (3614, 'Tarawa', 'TRW', 'KI', 1.381636, 173.14703, 'Bonriki Arpt', 12);
INSERT INTO public.airports VALUES (3615, 'Tiruchirappali', 'TRZ', 'IN', 10.765364, 78.709724, 'Tiruchirapally Civil Arpt', 5);
INSERT INTO public.airports VALUES (3616, 'Astana', 'TSE', 'KZ', 51.02222, 71.46694, 'Astana Arpt', 6);
INSERT INTO public.airports VALUES (3617, 'Treviso', 'TSF', 'IT', 45.6484, 12.194422, 'Treviso Arpt', 1);
INSERT INTO public.airports VALUES (3618, 'Tsushima', 'TSJ', 'JP', 34.28489, 129.33055, 'Tsushima Arpt', 9);
INSERT INTO public.airports VALUES (3619, 'Taos', 'TSM', 'US', 0, 0, 'Taos Airport', -100);
INSERT INTO public.airports VALUES (3620, 'Tianjin', 'TSN', 'CN', 39.12435, 117.34618, 'Tianjin Airport', 8);
INSERT INTO public.airports VALUES (3621, 'Timisoara', 'TSR', 'RO', 45.80986, 21.33786, 'Timisoara Arpt', 2);
INSERT INTO public.airports VALUES (3622, 'Trang', 'TST', 'TH', 7.508744, 99.61658, 'Trang Arpt', 7);
INSERT INTO public.airports VALUES (3623, 'Townsville', 'TSV', 'AU', -19.2525, 146.76527, 'Townsville Arpt', 10);
INSERT INTO public.airports VALUES (3624, 'Tortoli', 'TTB', 'IT', 39.918762, 9.682981, 'Arbatax Arpt', 1);
INSERT INTO public.airports VALUES (3625, 'Troutdale', 'TTD', 'US', 45.54937, -122.40125, 'Troutdale Arpt', -8);
INSERT INTO public.airports VALUES (3626, 'Tottori', 'TTJ', 'JP', 35.530067, 134.16655, 'Tottori Arpt', 9);
INSERT INTO public.airports VALUES (3627, 'Trenton', 'TTN', 'US', 40.27669, -74.81347, 'Trenton Mercer Arpt', -5);
INSERT INTO public.airports VALUES (3628, 'Trenton', 'TRX', 'US', 0, 0, 'Trenton Airport', -100);
INSERT INTO public.airports VALUES (3629, 'Tortuquero', 'TTQ', 'CR', 10.569, -83.5148, 'Tortuquero Arpt', -6);
INSERT INTO public.airports VALUES (3630, 'Taitung', 'TTT', 'TW', 22.754986, 121.101685, 'Taitung Arpt', 8);
INSERT INTO public.airports VALUES (3631, 'Tucuman', 'TUC', 'AR', -26.84086, -65.10494, 'Benjamin Matienzo Airport', -3);
INSERT INTO public.airports VALUES (3632, 'Tours', 'TUF', 'FR', 47.43222, 0.727606, 'Saint Symphorien Arpt', 1);
INSERT INTO public.airports VALUES (3633, 'Tours', 'XSH', 'FR', 47.385628, 0.723347, 'Tours Rail Station', 1);
INSERT INTO public.airports VALUES (3634, 'Tuguegarao', 'TUG', 'PH', 17.638311, 121.73061, 'Tuguegarao Arpt', 8);
INSERT INTO public.airports VALUES (3635, 'Turaif', 'TUI', 'SA', 31.692682, 38.7312, 'Turaif Arpt', 3);
INSERT INTO public.airports VALUES (3636, 'Turbat', 'TUK', 'PK', 25.986368, 63.030167, 'Turbat Arpt', 5);
INSERT INTO public.airports VALUES (3637, 'Tulsa', 'TUL', 'US', 36.198387, -95.88811, 'Tulsa Intl', -6);
INSERT INTO public.airports VALUES (3638, 'Tunis', 'TUN', 'TN', 36.851032, 10.227217, 'Carthage Arpt', 1);
INSERT INTO public.airports VALUES (3639, 'Taupo', 'TUO', 'NZ', -38.739723, 176.08444, 'Taupo Arpt', 12);
INSERT INTO public.airports VALUES (3640, 'Tupelo', 'TUP', 'US', 34.2681, -88.7699, 'C D Lemons Municipal Arpt', -6);
INSERT INTO public.airports VALUES (3641, 'Tucurui', 'TUR', 'BR', -3.786008, -49.72027, 'Tucurui Arpt', -3);
INSERT INTO public.airports VALUES (3642, 'Tucson', 'TUS', 'US', 32.11608, -110.941025, 'Tucson Intl Arpt', -7);
INSERT INTO public.airports VALUES (3643, 'Tabuk', 'TUU', 'SA', 28.365417, 36.61889, 'Tabuk Arpt', 3);
INSERT INTO public.airports VALUES (3644, 'Tulum', 'TUY', 'MX', 0, 0, 'Tulum Arpt', -100);
INSERT INTO public.airports VALUES (3645, 'Traverse City', 'TVC', 'US', 44.741444, -85.58224, 'Cherry Capital Arpt', -5);
INSERT INTO public.airports VALUES (3646, 'Thief River Falls', 'TVF', 'US', 48.065556, -96.185, 'Thief River Falls Numicipal', -6);
INSERT INTO public.airports VALUES (3647, 'Lake Tahoe', 'TVL', 'US', 38.89389, -119.99528, 'Lake Tahoe Arpt', -8);
INSERT INTO public.airports VALUES (3648, 'Taveuni', 'TVU', 'FJ', -16.6906, -179.877, 'Matei Arpt', 12);
INSERT INTO public.airports VALUES (3649, 'Twin Hills', 'TWA', 'US', 59.074444, -160.275, 'Twin Hills Arpt', -9);
INSERT INTO public.airports VALUES (3650, 'Toowoomba', 'TWB', 'AU', -27.542778, 151.91638, 'Toowoomba Arpt', 10);
INSERT INTO public.airports VALUES (3651, 'Twin Falls', 'TWF', 'US', 42.481804, -114.48773, 'Twin Falls City County Arpt', -7);
INSERT INTO public.airports VALUES (3652, 'Tawau', 'TWU', 'MY', 4.313369, 118.121956, 'Tawau Arpt', 8);
INSERT INTO public.airports VALUES (3653, 'Taichung', 'TXG', 'TW', 24.1863, 120.654, 'Taichung Arpt', 8);
INSERT INTO public.airports VALUES (3654, 'Taichung', 'RMQ', 'TW', 24.264668, 120.62058, 'Ching Chuan Kang', 8);
INSERT INTO public.airports VALUES (3655, 'Texarkana', 'TXK', 'US', 33.45372, -93.99103, 'Texarkana Municipal', -6);
INSERT INTO public.airports VALUES (3656, 'Tunxi', 'TXN', 'CN', 29.7333, 118.256, 'Tunxi Arpt', 8);
INSERT INTO public.airports VALUES (3657, 'Tynda Airport', 'TYD', 'RU', 0, 0, 'Tynda Airport', 0);
INSERT INTO public.airports VALUES (3658, 'Taiyuan', 'TYN', 'CN', 37.7469, 112.628426, 'Taiyuan Arpt', 8);
INSERT INTO public.airports VALUES (3659, 'Tokyo', 'HND', 'JP', 35.552258, 139.7797, 'Haneda Arpt', 9);
INSERT INTO public.airports VALUES (3660, 'Tokyo', 'NRT', 'JP', 35.76472, 140.38638, 'Narita', 9);
INSERT INTO public.airports VALUES (3661, 'Tyler', 'TYR', 'US', 32.354137, -95.40239, 'Pounds Field', -6);
INSERT INTO public.airports VALUES (3662, 'Knoxville', 'TYS', 'US', 35.81097, -83.994026, 'McGhee Tyson Arpt', -5);
INSERT INTO public.airports VALUES (3663, 'Tuzla', 'TZL', 'BA', 44.4587, 18.7248, 'Tuzla Intl Arpt', -100);
INSERT INTO public.airports VALUES (3664, 'South Andros', 'TZN', 'BS', 24.1586, -77.5892, 'South Andros Arpt', -100);
INSERT INTO public.airports VALUES (3665, 'Trabzon', 'TZX', 'TR', 40.99511, 39.789726, 'Trabzon Arpt', 2);
INSERT INTO public.airports VALUES (3666, 'San Luis Rio Colorado', 'UAC', 'MX', 0, 0, 'San Luis Rio Colorado Municipal', -100);
INSERT INTO public.airports VALUES (3667, 'Narsarsuaq', 'UAK', 'GL', 61.16052, -45.42598, 'Narsarsuaq Arpt', -3);
INSERT INTO public.airports VALUES (3668, 'San Juan', 'UAQ', 'AR', -31.571472, -68.4182, 'San Juan Arpt', -3);
INSERT INTO public.airports VALUES (3669, 'Samburu', 'UAS', 'KE', 0.530583, 37.5342, 'Samburu Airstrip', 3);
INSERT INTO public.airports VALUES (3670, 'Uberaba', 'UBA', 'BR', -19.765, -47.96478, 'Uberaba Airport', -3);
INSERT INTO public.airports VALUES (3671, 'Ube Jp', 'UBJ', 'JP', 33.93, 131.27861, 'Ube Airport', 9);
INSERT INTO public.airports VALUES (3672, 'Ubon Ratchathani', 'UBP', 'TH', 15.251278, 104.87023, 'Muang Ubon Arpt', 7);
INSERT INTO public.airports VALUES (3673, 'Columbus', 'UBS', 'US', 0, 0, 'Lowndes Cty Arpt', -100);
INSERT INTO public.airports VALUES (3674, 'Columbus', 'GTR', 'US', 33.450333, -88.59136, 'Golden Arpt', -6);
INSERT INTO public.airports VALUES (3675, 'Utica', 'UCA', 'US', 43.1451, -75.3839, 'Oneida County Arpt', -100);
INSERT INTO public.airports VALUES (3676, 'Lutsk', 'UCK', 'UA', 0, 0, 'Lutsk Arpt', -100);
INSERT INTO public.airports VALUES (3677, 'Ukhta Airport', 'UCT', 'RU', 63.340298, 53.482594, 'Ukhta Airport', 4);
INSERT INTO public.airports VALUES (3678, 'Palm Desert', 'UDD', 'US', 33.74844, -116.27481, 'Bermuda Dunes Arpt', -7);
INSERT INTO public.airports VALUES (3679, 'Uden', 'UDE', 'NL', 51.656387, 5.708611, 'Volkel Arpt', 1);
INSERT INTO public.airports VALUES (3680, 'Uberlandia', 'UDI', 'BR', -18.882845, -48.225594, 'Eduardo Gomes Airprt', -3);
INSERT INTO public.airports VALUES (3681, 'Uzhhorod International Airport', 'UDJ', 'UA', 48.634277, 22.263355, 'Uzhhorod International Airport', 2);
INSERT INTO public.airports VALUES (3682, 'Udine', 'UDN', 'IT', 45.9347, 12.9422, 'Campoformido Arpt', -100);
INSERT INTO public.airports VALUES (3683, 'Udaipur', 'UDR', 'IN', 24.617697, 73.8961, 'Maharana Pratap Arpt', 5);
INSERT INTO public.airports VALUES (3684, 'Queenstown', 'UEE', 'AU', 0, 0, 'Queenstown Arpt', -100);
INSERT INTO public.airports VALUES (3685, 'Kume Jima', 'UEO', 'JP', 26.363506, 126.713806, 'Kumejima Arpt', 9);
INSERT INTO public.airports VALUES (3686, 'Ufa RU', 'UFA', 'RU', 54.55751, 55.874416, 'Ufa Arpt', 6);
INSERT INTO public.airports VALUES (3687, 'Urgench', 'UGC', 'UZ', 41.5843, 60.6417, 'Urgench Arpt', 5);
INSERT INTO public.airports VALUES (3688, 'Waukegan', 'UGN', 'US', 42.42216, -87.867905, 'Memorial Arpt', -6);
INSERT INTO public.airports VALUES (3689, 'Uherske Hradiste', 'UHE', 'CZ', 49.0294, 17.4397, 'Uherske Hradiste Kunovice Arpt', -100);
INSERT INTO public.airports VALUES (3690, 'Qui Nhon', 'UIH', 'VN', 13.954986, 109.04227, 'Qui Nhon Arpt', 7);
INSERT INTO public.airports VALUES (3691, 'Utila', 'UII', 'HN', 16.091667, -86.8875, 'Utila Arpt', -6);
INSERT INTO public.airports VALUES (3692, 'Ust-Ilimsk Airport', 'UIK', 'RU', 58.08, 108.08, 'Ust-Ilimsk Airport', 9);
INSERT INTO public.airports VALUES (3693, 'Quincy', 'UIN', 'US', 39.9427, -91.1946, 'Baldwin Field', -6);
INSERT INTO public.airports VALUES (3694, 'Quito', 'UIO', 'EC', -0.141144, -78.48821, 'Mariscal Arpt', -5);
INSERT INTO public.airports VALUES (3695, 'Quimper', 'UIP', 'FR', 47.97498, -4.167786, 'Pluguffan Arpt', 1);
INSERT INTO public.airports VALUES (3696, 'Quirindi', 'UIR', 'AU', -31.4983, 150.5183, 'Quirindi Arpt', -100);
INSERT INTO public.airports VALUES (3697, 'Kobe', 'UKB', 'JP', 34.63278, 135.22389, 'Kobe Arpt', 9);
INSERT INTO public.airports VALUES (3698, 'Ukiah', 'UKI', 'US', 39.126, -123.2009, 'Ukiah Arpt', -100);
INSERT INTO public.airports VALUES (3699, 'Ust Kamenogorsk', 'UKK', 'KZ', 50.0366, 82.4942, 'Ust Kamenogorsk Arpt', 6);
INSERT INTO public.airports VALUES (3700, 'Sevastopol', 'UKS', 'UA', 44.69143, 33.57567, 'Belbek Arpt', 2);
INSERT INTO public.airports VALUES (3701, 'Quakertown', 'UKT', 'US', 0, 0, 'Upper Bucks Arpt', -100);
INSERT INTO public.airports VALUES (3702, 'Ust-Kut Airport', 'UKX', 'RU', 56.85, 105.7167, 'Ust-Kut Airport', 9);
INSERT INTO public.airports VALUES (3703, 'Kyoto', 'UKY', 'JP', 35.016666, 135.76666, 'Kyoto Arpt', 9);
INSERT INTO public.airports VALUES (3704, 'New Ulm', 'ULM', 'US', 0, 0, 'New Ulm Arpt', -100);
INSERT INTO public.airports VALUES (3705, 'Ulaanbaatar', 'ULN', 'MN', 47.843056, 106.76664, 'Buyant Uhaa Airport', 8);
INSERT INTO public.airports VALUES (3706, 'Quilpie', 'ULP', 'AU', -26.6122, 144.253, 'Quilpie Arpt', 10);
INSERT INTO public.airports VALUES (3707, 'Baratayeveka', 'ULV', 'RU', 0, 0, 'Ulyanovsk Baratayeveka Airport', 4);
INSERT INTO public.airports VALUES (3708, 'Ulyanovsk', 'ULY', 'RU', 54.401, 48.8027, 'Ulyanovsk Arpt', 4);
INSERT INTO public.airports VALUES (3709, 'Umea', 'UME', 'SE', 63.79183, 20.282759, 'Umea Airport', 1);
INSERT INTO public.airports VALUES (3710, 'Umuarama', 'UMU', 'BR', -23.79861, -53.31361, 'Ernesto Geisel Arpt', -4);
INSERT INTO public.airports VALUES (3711, 'Sumy', 'UMY', 'UA', 50.8583, 34.7625, 'Sumy Arpt', -100);
INSERT INTO public.airports VALUES (3712, 'Una BR', 'UNA', 'BR', -15.355278, -38.99889, 'Una Airport', -4);
INSERT INTO public.airports VALUES (3713, 'Union Island', 'UNI', 'VC', 12.583, -61.417, 'Union Island Arpt', -4);
INSERT INTO public.airports VALUES (3714, 'Unalakleet', 'UNK', 'US', 63.888332, -160.79889, 'Unalakleet Arpt', -9);
INSERT INTO public.airports VALUES (3715, 'Ranong', 'UNN', 'TH', 9.777622, 98.58548, 'Ranong Arpt', 7);
INSERT INTO public.airports VALUES (3716, 'Unst', 'UNT', 'GB', 60.7472, -0.85385, 'Baltasound Arpt', 0);
INSERT INTO public.airports VALUES (3717, 'University Oxford', 'UOX', 'US', 0, 0, 'University Oxford', -100);
INSERT INTO public.airports VALUES (3718, 'Ujung Pandang', 'UPG', 'ID', -5.061631, 119.55404, 'Hasanudin Arpt', 8);
INSERT INTO public.airports VALUES (3719, 'Uruapan', 'UPN', 'MX', 19.396692, -102.039055, 'Uruapan Arpt', -6);
INSERT INTO public.airports VALUES (3720, 'Uralsk', 'URA', 'KZ', 51.150833, 51.543056, 'Uralsk Arpt', 5);
INSERT INTO public.airports VALUES (3721, 'Urumqi', 'URC', 'CN', 43.907104, 87.47424, 'Urumqi Arpt', 8);
INSERT INTO public.airports VALUES (3722, 'Kuressaare', 'URE', 'EE', 58.22988, 22.509495, 'Kuressaare Arpt', 2);
INSERT INTO public.airports VALUES (3723, 'Uruguaina', 'URG', 'BR', -29.782179, -57.03819, 'Ruben Berta Arpt', -3);
INSERT INTO public.airports VALUES (3724, 'Urai Airport', 'URJ', 'RU', 60.1, 64.83, 'Urai Airport', 6);
INSERT INTO public.airports VALUES (3725, 'Rouen', 'URO', 'FR', 49.38417, 1.1748, 'Boos Airport', 1);
INSERT INTO public.airports VALUES (3726, 'Kursk', 'URS', 'RU', 51.7506, 36.2956, 'Kursk Arpt', 4);
INSERT INTO public.airports VALUES (3727, 'Surat Thani', 'URT', 'TH', 9.1325, 99.13556, 'Surat Thani Arpt', 7);
INSERT INTO public.airports VALUES (3728, 'Gurayat', 'URY', 'SA', 31.411942, 37.27947, 'Gurayat Arpt', 3);
INSERT INTO public.airports VALUES (3729, 'Ushuaia', 'USH', 'AR', -54.843277, -68.29575, 'Islas Malvinas Arpt', -3);
INSERT INTO public.airports VALUES (3730, 'Usinsk', 'USK', 'RU', 66.00077, 57.22111, 'Usinsk Arpt', 4);
INSERT INTO public.airports VALUES (3731, 'Useless Loop', 'USL', 'AU', 0, 0, 'Useless Loop Arpt', -100);
INSERT INTO public.airports VALUES (3732, 'Koh Samui', 'USM', 'TH', 9.547794, 100.06227, 'Koh Samui Arpt', 7);
INSERT INTO public.airports VALUES (3733, 'Ulsan', 'USN', 'KR', 35.593494, 129.35172, 'Ulsan Arpt', 9);
INSERT INTO public.airports VALUES (3734, 'Usak', 'USQ', 'TR', 38.681477, 29.471676, 'Usak Airport', 2);
INSERT INTO public.airports VALUES (3735, 'Sancti Spiritus', 'USS', 'CU', 0, 0, 'Sancti Spiritus Arpt', -100);
INSERT INTO public.airports VALUES (3736, 'St Augustine', 'UST', 'US', 29.959167, -81.33972, 'St Augustine Arpt', -5);
INSERT INTO public.airports VALUES (3737, 'Mutare', 'UTA', 'ZW', 0, 0, 'Mutare Arpt', -100);
INSERT INTO public.airports VALUES (3738, 'Utrecht', 'ZYU', 'NL', 0, 0, 'Utrecht Rail Station', -100);
INSERT INTO public.airports VALUES (3739, 'Udon Thani', 'UTH', 'TH', 17.386436, 102.788246, 'Udon Thani Arpt', 7);
INSERT INTO public.airports VALUES (3740, 'Upington', 'UTN', 'ZA', -28.399097, 21.260239, 'Upington Airport', 2);
INSERT INTO public.airports VALUES (3741, 'U Tapao', 'UTP', 'TH', 12.679944, 101.00503, 'U Tapao Arpt', 7);
INSERT INTO public.airports VALUES (3742, 'Umtata', 'UTT', 'ZA', -31.547903, 28.67429, 'Umtata Arpt', 2);
INSERT INTO public.airports VALUES (3743, 'Queenstown', 'UTW', 'ZA', -31.920197, 26.882206, 'Queenstown Airport', 2);
INSERT INTO public.airports VALUES (3744, 'Bugulma Airport', 'UUA', 'RU', 54.64, 52.8017, 'Bugulma Airport', 6);
INSERT INTO public.airports VALUES (3745, 'Ulan Ude', 'UUD', 'RU', 51.807762, 107.437645, 'Ulan Ude Arpt', 9);
INSERT INTO public.airports VALUES (3746, 'Yuzhno Sakhalinsk', 'UUS', 'RU', 46.88867, 142.71753, 'Yuzhno Sakhalinsk Arpt', 11);
INSERT INTO public.airports VALUES (3747, 'Uvalde', 'UVA', 'US', 29.21543, -99.74896, 'Garner Field', -6);
INSERT INTO public.airports VALUES (3748, 'Vieux Fort St Lucia', 'UVF', 'LC', 13.733194, -60.9526, 'Hewanorra Arpt', -4);
INSERT INTO public.airports VALUES (3749, 'Kharga', 'UVL', 'EG', 25.4736, 30.5908, 'Kharga Arpt', -100);
INSERT INTO public.airports VALUES (3750, 'Wiesbaden', 'WIE', 'DE', 50.05, 8.325, 'Air Base', -100);
INSERT INTO public.airports VALUES (3751, 'Nyala', 'UYL', 'SD', 12.0535, 24.9562, 'Nyala Arpt', 2);
INSERT INTO public.airports VALUES (3752, 'Vaasa', 'VAA', 'FI', 63.05065, 21.762175, 'Vaasa Arpt', 2);
INSERT INTO public.airports VALUES (3753, 'Valence', 'XHK', 'FR', -100, 0, 'Gare de Valence TGV', 0);
INSERT INTO public.airports VALUES (3754, 'Valence', 'VAF', 'FR', 44.921593, 4.9699, 'Chabeuil Airport', 1);
INSERT INTO public.airports VALUES (3755, 'Varginha', 'VAG', 'BR', -21.590067, -45.473343, 'Maj Brig Trompowsky Arpt', -3);
INSERT INTO public.airports VALUES (3756, 'Vanimo', 'VAI', 'PG', -2.69717, 141.302, 'Vanimo Arpt', 10);
INSERT INTO public.airports VALUES (3757, 'Van TR', 'VAN', 'TR', 38.46822, 43.3323, 'Van Arpt', 2);
INSERT INTO public.airports VALUES (3758, 'Varna', 'VAR', 'BG', 43.23207, 27.825106, 'Varna', 2);
INSERT INTO public.airports VALUES (3759, 'Sivas', 'VAS', 'TR', 39.813828, 36.903496, 'Sivas Arpt', 2);
INSERT INTO public.airports VALUES (3760, 'Vava U', 'VAV', 'TO', -18.585337, -173.96172, 'Lupepau U Arpt', 13);
INSERT INTO public.airports VALUES (3761, 'Vardoe', 'VAW', 'NO', 70.35539, 31.04489, 'Vardoe Luftan', 1);
INSERT INTO public.airports VALUES (3762, 'Visby', 'VBY', 'SE', 57.662796, 18.34621, 'Visby Airport', 1);
INSERT INTO public.airports VALUES (3763, 'Can Tho', 'VCA', 'VN', 10.085119, 105.71192, 'Can Tho Arpt', 7);
INSERT INTO public.airports VALUES (3764, 'Venice', 'VCE', 'IT', 45.50528, 12.351944, 'Marco Polo Arpt', 1);
INSERT INTO public.airports VALUES (3765, 'Tamky', 'VCL', 'VN', 15.405944, 108.70589, 'Chulai Arpt', 7);
INSERT INTO public.airports VALUES (3766, 'Victoria', 'VCT', 'US', 28.8526, -96.9185, 'Victoria Regional Arpt', -6);
INSERT INTO public.airports VALUES (3767, 'Victorville', 'VCV', 'US', 34.597454, -117.382996, 'George AFB', -8);
INSERT INTO public.airports VALUES (3768, 'Ovda', 'VDA', 'IL', 29.94025, 34.93585, 'Ovda Arpt', 2);
INSERT INTO public.airports VALUES (3769, 'Fagernes', 'VDB', 'NO', 61.015556, 9.288056, 'Valdres Arpt', 1);
INSERT INTO public.airports VALUES (3770, 'Vitoria Da Conquista', 'VDC', 'BR', -14.862761, -40.863106, 'Vitoria Da Conquista Arpt', -3);
INSERT INTO public.airports VALUES (3771, 'Valverde', 'VDE', 'ES', 27.814848, -17.887056, 'Hierro Arpt', 0);
INSERT INTO public.airports VALUES (3772, 'Vidalia', 'VDI', 'US', 0, 0, 'Vidalia Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3773, 'Viedma', 'VDM', 'AR', -40.86922, -63.00039, 'Viedma Arpt', -3);
INSERT INTO public.airports VALUES (3774, 'Vadso', 'VDS', 'NO', 70.065, 29.844, 'Vadso', 1);
INSERT INTO public.airports VALUES (3775, 'Valdez', 'VDZ', 'US', 61.13395, -146.24834, 'Valdez Municipal Arpt', -9);
INSERT INTO public.airports VALUES (3776, 'Vejle', 'VEJ', 'DK', 0, 0, 'Vejle Arpt', -100);
INSERT INTO public.airports VALUES (3777, 'Vernal', 'VEL', 'US', 40.440834, -109.51, 'Vernal Municipal', -7);
INSERT INTO public.airports VALUES (3778, 'Veracruz', 'VER', 'MX', 19.145931, -96.18726, 'Las Bajadas General Heriberto Jara', -6);
INSERT INTO public.airports VALUES (3779, 'Vestmannaeyjar', 'VEY', 'IS', 63.4243, -20.278875, 'Vestmannaeyjar Arpt', 0);
INSERT INTO public.airports VALUES (3780, 'Victoria Falls', 'VFA', 'ZW', -18.09588, 25.839006, 'Victoria Falls Arpt', 2);
INSERT INTO public.airports VALUES (3781, 'Vijayawada', 'VGA', 'IN', 16.530434, 80.796844, 'Vijayawada Arpt', 5);
INSERT INTO public.airports VALUES (3782, 'Vologda', 'VGD', 'RU', 59.281666, 39.946667, 'Vologda Arpt', 4);
INSERT INTO public.airports VALUES (3783, 'Vigo', 'VGO', 'ES', 42.2318, -8.626775, 'Vigo Airport', 1);
INSERT INTO public.airports VALUES (3784, 'Vilhelmina', 'VHM', 'SE', 64.57909, 16.833574, 'Vilhelmina Arpt', 1);
INSERT INTO public.airports VALUES (3785, 'Van Horn', 'VHN', 'US', 0, 0, 'Culberson Cty Arpt', -100);
INSERT INTO public.airports VALUES (3786, 'Vichy', 'VHY', 'FR', 46.16969, 3.403736, 'Charmeil Arpt', 1);
INSERT INTO public.airports VALUES (3787, 'Villa Constitucion', 'VIB', 'MX', 0, 0, 'Villa Constitucion Arpt', -100);
INSERT INTO public.airports VALUES (3788, 'Vicenza', 'VIC', 'IT', 45.57341, 11.52955, 'Vicenza Arpt', 1);
INSERT INTO public.airports VALUES (3789, 'Vienna', 'VDD', 'AT', 48.2, 16.366667, 'Vienna Danubepier Arpt', 2);
INSERT INTO public.airports VALUES (3790, 'Vienna', 'VIE', 'AT', 48.11028, 16.569721, 'Vienna Intl Arpt', 1);
INSERT INTO public.airports VALUES (3791, 'Vieste', 'VIF', 'IT', 0, 0, 'Vieste Arpt', -100);
INSERT INTO public.airports VALUES (3792, 'El Vigia', 'VIG', 'VE', 8.6241, -71.67282, 'El Vigia Arpt', -4);
INSERT INTO public.airports VALUES (3793, 'Vinh City', 'VII', 'VN', 18.73757, 105.67076, 'Vinh City Arpt', 7);
INSERT INTO public.airports VALUES (3794, 'Virgin Gorda', 'VIJ', 'VG', 18.4464, -64.4275, 'Virgin Gorda Arpt', -4);
INSERT INTO public.airports VALUES (3795, 'Dakhla', 'VIL', 'MA', 23.7183, -15.932, 'Dakhla Airport', 0);
INSERT INTO public.airports VALUES (3796, 'Vinnitsa', 'VIN', 'UA', 49.2433, 28.6063, 'Vinnitsa Arpt', 2);
INSERT INTO public.airports VALUES (3797, 'Visalia', 'VIS', 'US', 36.31861, -119.39278, 'Visalia Municipal', -8);
INSERT INTO public.airports VALUES (3798, 'Vitoria', 'VIT', 'ES', 42.882835, -2.724469, 'Vitoria Arpt', 1);
INSERT INTO public.airports VALUES (3799, 'Vitoria', 'VIX', 'BR', -20.258057, -40.28639, 'Eurico Sales Arpt', -3);
INSERT INTO public.airports VALUES (3800, 'Abingdon', 'VJI', 'US', 0, 0, 'Virginia Highlands Arpt', -100);
INSERT INTO public.airports VALUES (3801, 'Rach Gia', 'VKG', 'VN', 9.949676, 105.13366, 'Rach Gia Arpt', 7);
INSERT INTO public.airports VALUES (3802, 'Vicksburg', 'VKS', 'US', 0, 0, 'Vicksburg Arpt', -100);
INSERT INTO public.airports VALUES (3803, 'Vorkuta', 'VKT', 'RU', 67.4886, 63.9931, 'Vorkuta Airport', 6);
INSERT INTO public.airports VALUES (3804, 'Valencia', 'VLC', 'ES', 39.489315, -0.481625, 'Valencia Arpt', 1);
INSERT INTO public.airports VALUES (3805, 'Valdosta', 'VLD', 'US', 30.7825, -83.2767, 'Valdosta Regional', -5);
INSERT INTO public.airports VALUES (3806, 'Villa Gesell', 'VLG', 'AR', -37.23541, -57.02924, 'Villa Gesell Arpt', -3);
INSERT INTO public.airports VALUES (3807, 'Port Vila', 'VLI', 'VU', -17.699326, 168.3198, 'Bauerfield Arpt', 11);
INSERT INTO public.airports VALUES (3808, 'Valladolid', 'VLL', 'ES', 41.706112, -4.851944, 'Valladolid Arpt', 1);
INSERT INTO public.airports VALUES (3809, 'Valencia', 'VLN', 'VE', 10.149733, -67.9284, 'Valenica Arpt', -4);
INSERT INTO public.airports VALUES (3810, 'Vallejo', 'VLO', 'US', 0, 0, 'Stolport Arpt', -100);
INSERT INTO public.airports VALUES (3811, 'Velikiye Luki Airport', 'VLU', 'RU', 0, 0, 'Velikiye Luki Airport', -2);
INSERT INTO public.airports VALUES (3812, 'Valera', 'VLV', 'VE', 9.340797, -70.58409, 'Carvajal Arpt', -4);
INSERT INTO public.airports VALUES (3813, 'Anglesey', 'VLY', 'GB', 53.2481, -4.5353, 'Anglesey Arpt', -100);
INSERT INTO public.airports VALUES (3814, 'Villa Mercedes', 'VME', 'AR', 0, 0, 'Villa Mercedes Arpt', -100);
INSERT INTO public.airports VALUES (3815, 'Vallemi', 'VMI', 'PY', 0, 0, 'Inc Arpt', -100);
INSERT INTO public.airports VALUES (3816, 'Venice', 'VNC', 'US', 0, 0, 'Venice Municipal Airport', -100);
INSERT INTO public.airports VALUES (3817, 'Vannes', 'VNE', 'FR', 47.723305, -2.718561, 'Muecon Arpt', 1);
INSERT INTO public.airports VALUES (3818, 'Vilnius', 'VNO', 'LT', 54.634132, 25.285767, 'Vilnius Arpt', 2);
INSERT INTO public.airports VALUES (3819, 'Varanasi', 'VNS', 'IN', 25.452358, 82.859344, 'Lal Bahadur Shastri Arpt', 5);
INSERT INTO public.airports VALUES (3820, 'Ventspils', 'VNT', 'LV', 57.3578, 21.5442, 'Ventspils Intl Arpt', -100);
INSERT INTO public.airports VALUES (3821, 'Vilanculos', 'VNX', 'MZ', -22.01843, 35.313297, 'Vilanculos Arpt', 2);
INSERT INTO public.airports VALUES (3822, 'Volgograd', 'VOG', 'RU', 48.782528, 44.345543, 'Volgograd Arpt', 4);
INSERT INTO public.airports VALUES (3823, 'Volos', 'VOL', 'GR', 39.21962, 22.794338, 'Nea Anchialos Arpt', 2);
INSERT INTO public.airports VALUES (3824, 'Voronezh', 'VOZ', 'RU', 51.814213, 39.229588, 'Voronezh Arpt', 4);
INSERT INTO public.airports VALUES (3825, 'Valparaiso', 'VPS', 'US', 30.48325, -86.5254, 'Ft Walton Beach Arpt', -6);
INSERT INTO public.airports VALUES (3826, 'Valparaiso', 'EGI', 'US', 0, 0, 'Duke Field', -100);
INSERT INTO public.airports VALUES (3827, 'Valparaiso', 'VPZ', 'US', 0, 0, 'Porter County', -100);
INSERT INTO public.airports VALUES (3828, 'Vieques', 'VQS', 'US', 18.1158, -65.4227, 'Vieques Arpt', -4);
INSERT INTO public.airports VALUES (3829, 'Varadero', 'VRA', 'CU', 23.034445, -81.43528, 'Juan Gualberto Gomez Arpt', -5);
INSERT INTO public.airports VALUES (3830, 'Vero Beach', 'VRB', 'US', 27.655556, -80.417946, 'Vero Beach Municipal Arpt', -5);
INSERT INTO public.airports VALUES (3831, 'Varkaus', 'VRK', 'FI', 62.171112, 27.86861, 'Varkaus', 2);
INSERT INTO public.airports VALUES (3832, 'Vila Real', 'VRL', 'PT', 41.274334, -7.720472, 'Vila Real Arpt', 0);
INSERT INTO public.airports VALUES (3833, 'Verona', 'VRN', 'IT', 45.395706, 10.888533, 'Verona Airport', 1);
INSERT INTO public.airports VALUES (3834, 'Verona', 'VBS', 'IT', 45.42889, 10.330556, 'Montichiari Arpt', 1);
INSERT INTO public.airports VALUES (3835, 'Matanzas', 'VRO', 'CU', 0, 0, 'Kawama Arpt', -100);
INSERT INTO public.airports VALUES (3836, 'Villahermosa', 'VSA', 'MX', 17.997, -92.81736, 'Capt Carlos Rovirosa Perez', -6);
INSERT INTO public.airports VALUES (3837, 'Viseu', 'VSE', 'PT', 40.7255, -7.889, 'Viseu Arpt', -100);
INSERT INTO public.airports VALUES (3838, 'Lugansk', 'VSG', 'UA', 48.4174, 39.3741, 'Lugansk Arpt', 2);
INSERT INTO public.airports VALUES (3839, 'Vasteras', 'XYX', 'SE', 0, 0, 'Sala Rail Station', -100);
INSERT INTO public.airports VALUES (3840, 'Vitebsk', 'VTB', 'BY', 55.1265, 30.34964, 'Vitebsk Arpt', 2);
INSERT INTO public.airports VALUES (3841, 'Vientiane', 'VTE', 'LA', 17.988321, 102.563255, 'Wattay Arpt', 7);
INSERT INTO public.airports VALUES (3842, 'Vishakhapatanam', 'VTZ', 'IN', 17.721167, 83.22448, 'Vishakhapatnam', 6);
INSERT INTO public.airports VALUES (3843, 'Valleduper', 'VUP', 'CO', 10.435042, -73.249504, 'Valledupar Arpt', -5);
INSERT INTO public.airports VALUES (3844, 'Velikiy Ustyug Airport', 'VUS', 'RU', 0, 0, 'Velikiy Ustyug Airport', -2);
INSERT INTO public.airports VALUES (3845, 'Vladivostok', 'VVO', 'RU', 43.398952, 132.14801, 'Vladivostok Arpt', 11);
INSERT INTO public.airports VALUES (3846, 'Sao Vicente', 'VXE', 'CV', 16.833689, -25.05466, 'San Pedro Airport', -1);
INSERT INTO public.airports VALUES (3847, 'Vaxjo', 'VXO', 'SE', 56.929146, 14.727994, 'Vaxjo Airport', 1);
INSERT INTO public.airports VALUES (3848, 'Vryheid', 'VYD', 'ZA', 0, 0, 'Vryheid Arpt', -100);
INSERT INTO public.airports VALUES (3849, 'Peru', 'VYS', 'US', 41.3519, -89.1531, 'Illinois Valley Regional Arpt', -100);
INSERT INTO public.airports VALUES (3850, 'Wanganui', 'WAG', 'NZ', -39.962223, 175.02528, 'Wanganui Arpt', 12);
INSERT INTO public.airports VALUES (3851, 'Chincoteague', 'WAL', 'US', 37.940193, -75.46639, 'Wallops Arpt', -5);
INSERT INTO public.airports VALUES (3852, 'Washington', 'DCA', 'US', 38.85208, -77.03772, 'Ronald Reagan National Arpt', -5);
INSERT INTO public.airports VALUES (3853, 'Washington', 'IAD', 'US', 38.944534, -77.45581, 'Washington Dulles Intl', -5);
INSERT INTO public.airports VALUES (3854, 'Waterford', 'WAT', 'IE', 52.1872, -7.086964, 'Waterford Arpt', 0);
INSERT INTO public.airports VALUES (3855, 'Warsaw', 'WAW', 'PL', 52.16575, 20.967121, 'Warsaw Intl Arpt', 1);
INSERT INTO public.airports VALUES (3856, 'Waynesburg', 'WAY', 'US', 0, 0, 'Green County Airport', -100);
INSERT INTO public.airports VALUES (3857, 'Warwick', 'WAZ', 'AU', 0, 0, 'Warwick Arpt', -100);
INSERT INTO public.airports VALUES (3858, 'Boulder', 'WBU', 'US', 0, 0, 'Boulder Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3859, 'Enid', 'WDG', 'US', 0, 0, 'Woodring Municipal', -100);
INSERT INTO public.airports VALUES (3860, 'Windhoek', 'WDH', 'NA', -22.486668, 17.4625, 'Hosea Kutako International Arpt', 1);
INSERT INTO public.airports VALUES (3861, 'Windhoek', 'ERS', 'NA', -22.6122, 17.0804, 'Eros Arpt', 1);
INSERT INTO public.airports VALUES (3862, 'Weatherford', 'WEA', 'US', 0, 0, 'Parker County Airport', -100);
INSERT INTO public.airports VALUES (3863, 'Weifang', 'WEF', 'CN', 36.6467, 119.119, 'Weifang Arpt', 8);
INSERT INTO public.airports VALUES (3864, 'Weihai', 'WEH', 'CN', 37.1871, 122.229, 'Weihai Arpu', 8);
INSERT INTO public.airports VALUES (3865, 'Weipa', 'WEI', 'AU', -12.678611, 141.92528, 'Weipa Arpt', 10);
INSERT INTO public.airports VALUES (3866, 'Welkom', 'WEL', 'ZA', -27.998, 26.669586, 'Welkom Arpt', 2);
INSERT INTO public.airports VALUES (3867, 'Wee Waa', 'WEW', 'AU', 0, 0, 'Wee Waa Airport', -100);
INSERT INTO public.airports VALUES (3868, 'Wexford', 'WEX', 'IE', 0, 0, 'Castlebridge Arpt', -100);
INSERT INTO public.airports VALUES (3869, 'Wagga Wagga', 'WGA', 'AU', -35.16528, 147.46638, 'Forrest Hill Arpt', 10);
INSERT INTO public.airports VALUES (3870, 'Walgett', 'WGE', 'AU', -30.0318, 148.1222, 'Walgett Arpt', 10);
INSERT INTO public.airports VALUES (3871, 'Winchester', 'WGO', 'US', 0, 0, 'Winchester Arpt', -100);
INSERT INTO public.airports VALUES (3872, 'Wangaratta', 'WGT', 'AU', -36.4175, 146.3056, 'Wangaratta', -100);
INSERT INTO public.airports VALUES (3873, 'Whakatane', 'WHK', 'NZ', -37.920555, 176.91417, 'Whakatane Arpt', 12);
INSERT INTO public.airports VALUES (3874, 'Welshpool', 'WHL', 'AU', 0, 0, 'Welshpool Arpt', -100);
INSERT INTO public.airports VALUES (3875, 'Wick', 'WIC', 'GB', 58.45889, -3.093056, 'Wick Arpt', 0);
INSERT INTO public.airports VALUES (3876, 'Lancaster', 'WJF', 'US', 34.7411, -118.2186, 'Williams J Fox Arpt', -100);
INSERT INTO public.airports VALUES (3877, 'Lancaster', 'RZH', 'US', 0, 0, 'Quartz Hill Arpt', -100);
INSERT INTO public.airports VALUES (3878, 'Wanaka', 'WKA', 'NZ', -44.72222, 169.24556, 'Wanaka Arpt', 12);
INSERT INTO public.airports VALUES (3879, 'Wakkanai', 'WKJ', 'JP', 45.404167, 141.80083, 'Hokkaido Arpt', 9);
INSERT INTO public.airports VALUES (3880, 'Winfield', 'WLD', 'US', 0, 0, 'Arkansas City Arpt', -100);
INSERT INTO public.airports VALUES (3881, 'Wellington', 'WLG', 'NZ', -41.32722, 174.80528, 'Wellington Arpt', 12);
INSERT INTO public.airports VALUES (3882, 'Selawik', 'WLK', 'US', 66.6, -159.98584, 'Selawik Arpt', -9);
INSERT INTO public.airports VALUES (3883, 'Warrnambool', 'WMB', 'AU', -38.2961, 142.4447, 'Warrnambool Arpt', -100);
INSERT INTO public.airports VALUES (3884, 'Winnemucca', 'WMC', 'US', 40.8966, -117.8059, 'Winnemucca Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3885, 'Mountain Home', 'WMH', 'US', 0, 0, 'Mountain Home Arpt', -100);
INSERT INTO public.airports VALUES (3886, 'Warsaw-Modlin Mazovia Airport', 'WMI', 'PL', 52.45111, 20.651667, 'Warsaw-Modlin Mazovia Airport', 2);
INSERT INTO public.airports VALUES (3887, 'Naga', 'WNP', 'PH', 13.584886, 123.27024, 'Naga Arpt', 8);
INSERT INTO public.airports VALUES (3888, 'Windorah', 'WNR', 'AU', -25.4131, 142.667, 'Windorah Arpt', 10);
INSERT INTO public.airports VALUES (3889, 'Nawabshah', 'WNS', 'PK', 26.219442, 68.39005, 'Nawabshah Arpt', 5);
INSERT INTO public.airports VALUES (3890, 'Wenzhou', 'WNZ', 'CN', 27.9122, 120.852, 'Wenzhou Arpt', 8);
INSERT INTO public.airports VALUES (3891, 'Wollongong', 'WOL', 'AU', -34.5611, 150.789, 'Wollongong Arpt', 10);
INSERT INTO public.airports VALUES (3892, 'Puerto Aisen', 'WPA', 'CL', -45.4, -72.6667, 'Puerto Aisen Arpt', -100);
INSERT INTO public.airports VALUES (3893, 'Whangarei', 'WRE', 'NZ', -35.768333, 174.365, 'Whangarei Arpt', 12);
INSERT INTO public.airports VALUES (3894, 'Wrangell', 'WRG', 'US', 56.4843, -132.37, 'Wrangell Seaplane Base', -9);
INSERT INTO public.airports VALUES (3895, 'Worland', 'WRL', 'US', 43.9657, -107.951, 'Worland Municipal', -7);
INSERT INTO public.airports VALUES (3896, 'Wroclaw', 'WRO', 'PL', 51.102684, 16.885836, 'Strachowice', 1);
INSERT INTO public.airports VALUES (3897, 'Westray', 'WRY', 'GB', 59.3503, -2.95, 'Westray Arpt', 0);
INSERT INTO public.airports VALUES (3898, 'Westerly', 'WST', 'US', 53.351334, -6.4875, 'Westerly Municipal', 0);
INSERT INTO public.airports VALUES (3899, 'Airlie Beach', 'WSY', 'AU', -20.276, 148.755, 'Whitsunday Airstrip', 10);
INSERT INTO public.airports VALUES (3900, 'Westport', 'WSZ', 'NZ', -41.738056, 171.58083, 'Westport Airport', 12);
INSERT INTO public.airports VALUES (3901, 'Wuhan', 'WUH', 'CN', 30.783758, 114.2081, 'Wuhan Arpt', 8);
INSERT INTO public.airports VALUES (3902, 'Wiluna', 'WUN', 'AU', -26.6292, 120.221, 'Wiluna Arpt', 8);
INSERT INTO public.airports VALUES (3903, 'Wuyishan', 'WUS', 'CN', 27.7019, 118.001, 'Wuyishan Arpt', 8);
INSERT INTO public.airports VALUES (3904, 'Wau City', 'WUU', 'SD', 7.725, 27.98, 'Wau Arpt', 3);
INSERT INTO public.airports VALUES (3905, 'Wuxi', 'WUX', 'CN', 31.4944, 120.429, 'Wuxi Arpt', 8);
INSERT INTO public.airports VALUES (3906, 'Walvis Bay', 'WVB', 'NA', -22.9799, 14.6453, 'Rooikop Arpt', 1);
INSERT INTO public.airports VALUES (3907, 'Watsonville', 'WVI', 'US', 0, 0, 'Watsonville Municipal Arpt', -100);
INSERT INTO public.airports VALUES (3908, 'Waterville', 'WVL', 'US', 0, 0, 'Robert La Fleur Arpt', -100);
INSERT INTO public.airports VALUES (3909, 'Wilhelmshaven', 'WVN', 'DE', 53.504833, 8.053333, 'Wilhelmshaven Arpt', 1);
INSERT INTO public.airports VALUES (3910, 'Cape May', 'WWD', 'US', 39.008507, -74.90827, 'Cape May Arpt', -5);
INSERT INTO public.airports VALUES (3911, 'Wewak', 'WWK', 'PG', -3.583828, 143.66919, 'Boram Arpt', 10);
INSERT INTO public.airports VALUES (3912, 'Woodward', 'WWR', 'US', 0, 0, 'West Woodward Arpt', -100);
INSERT INTO public.airports VALUES (3913, 'Newtok', 'WWT', 'US', 60.939167, -164.64111, 'Newtok Arpt', -10);
INSERT INTO public.airports VALUES (3914, 'Braintree', 'WXF', 'GB', 0, 0, 'Wether Field Raf', -100);
INSERT INTO public.airports VALUES (3915, 'Wanxian', 'WXN', 'CN', 30.8361, 108.406, 'Wanxian Arpt', 8);
INSERT INTO public.airports VALUES (3916, 'Whyalla', 'WYA', 'AU', -33.0589, 137.514, 'Whyalla Arpt', 9);
INSERT INTO public.airports VALUES (3917, 'Wyndham', 'WYN', 'AU', -15.5117, 128.1533, 'Wyndham Arpt', -100);
INSERT INTO public.airports VALUES (3918, 'West Yellowstone', 'WYS', 'US', 44.68833, -111.1175, 'West Yellowstone Arpt', -7);
INSERT INTO public.airports VALUES (3919, 'Alamos', 'XAL', 'MX', 0, 0, 'Alamos Arpt', -100);
INSERT INTO public.airports VALUES (3920, 'Chapeco', 'XAP', 'BR', -27.134218, -52.65655, 'Chapeco Arpt', -3);
INSERT INTO public.airports VALUES (3921, 'Capreol', 'XAW', 'CA', 0, 0, 'Capreol Rail Station', -100);
INSERT INTO public.airports VALUES (3922, 'Campbellton', 'XAZ', 'CA', 0, 0, 'Campbellton Rail Station', -100);
INSERT INTO public.airports VALUES (3923, 'Brockville', 'XBR', 'CA', 0, 0, 'Brockville Arpt', -100);
INSERT INTO public.airports VALUES (3924, 'Killineq', 'XBW', 'CA', 0, 0, 'Killineq Arpt', -100);
INSERT INTO public.airports VALUES (3925, 'Christmas Island', 'XCH', 'CX', -10.450556, 105.69028, 'Christmas Island Arpt', 7);
INSERT INTO public.airports VALUES (3926, 'Chambord', 'XCI', 'CA', 0, 0, 'Chambord Rail Station', -100);
INSERT INTO public.airports VALUES (3927, 'Chatham', 'XCM', 'CA', 0, 0, 'Chatham Airport', -100);
INSERT INTO public.airports VALUES (3928, 'Colac', 'XCO', 'AU', 0, 0, 'Colac Arpt', -100);
INSERT INTO public.airports VALUES (3929, 'Dunkerque', 'XDK', 'FR', 0, 0, 'Dunkerque Arpt', -100);
INSERT INTO public.airports VALUES (3930, 'Chandler', 'XDL', 'CA', 0, 0, 'Chandler Rail Station', -100);
INSERT INTO public.airports VALUES (3931, 'Drummondville', 'XDM', 'CA', 0, 0, 'Drummondville Rail Station', -100);
INSERT INTO public.airports VALUES (3932, 'Grande Riviere', 'XDO', 'CA', 0, 0, 'Grande-Riviere Rail Station', -100);
INSERT INTO public.airports VALUES (3933, 'Hervey', 'XDU', 'CA', 0, 0, 'Hervey Rail Station', -100);
INSERT INTO public.airports VALUES (3934, 'Disneyland Paris Rail', 'XED', 'FR', 0, 0, 'Railway Service', -100);
INSERT INTO public.airports VALUES (3935, 'Lac Edouard', 'XEE', 'CA', 0, 0, 'Lac Edouard Rail Station', -100);
INSERT INTO public.airports VALUES (3936, 'Ladysmith', 'XEH', 'CA', 0, 0, 'Ladysmith Rail Station', -100);
INSERT INTO public.airports VALUES (3937, 'Langford', 'XEJ', 'CA', 0, 0, 'Langford Rail Station', -100);
INSERT INTO public.airports VALUES (3938, 'Melville', 'XEK', 'CA', 0, 0, 'Melville Rail Station', -100);
INSERT INTO public.airports VALUES (3939, 'New Carlisle', 'XEL', 'CA', 0, 0, 'New Carlisle Rail Station', -100);
INSERT INTO public.airports VALUES (3940, 'New Richmond', 'XEM', 'CA', 0, 0, 'New Richmond Rail Station', -100);
INSERT INTO public.airports VALUES (3941, 'Stratford', 'XFD', 'CA', 0, 0, 'Stratford Rail Station', -100);
INSERT INTO public.airports VALUES (3942, 'Parent', 'XFE', 'CA', 0, 0, 'Parent Rail Station', -100);
INSERT INTO public.airports VALUES (3943, 'Perce', 'XFG', 'CA', 0, 0, 'Perce Rail Station', -100);
INSERT INTO public.airports VALUES (3944, 'Port Daniel', 'XFI', 'CA', 0, 0, 'Port-Daniel Rail Station', -100);
INSERT INTO public.airports VALUES (3945, 'Senneterre', 'XFK', 'CA', 0, 0, 'Senneterre Rail Station', -100);
INSERT INTO public.airports VALUES (3946, 'Shawinigan', 'XFL', 'CA', 29.2821, -81.1212, 'Shawinigan Rail Station', -5);
INSERT INTO public.airports VALUES (3947, 'Shawnigan', 'XFM', 'CA', 0, 0, 'Shawnigan Rail Station', -100);
INSERT INTO public.airports VALUES (3948, 'Xiangfan', 'XFN', 'CN', 32.1506, 112.291, 'Xiangfan Arpt', 8);
INSERT INTO public.airports VALUES (3949, 'Taschereau', 'XFO', 'CA', 0, 0, 'Taschereau Rail Station', -100);
INSERT INTO public.airports VALUES (3950, 'Weymont', 'XFQ', 'CA', 0, 0, 'Weymont Rail Station', -100);
INSERT INTO public.airports VALUES (3951, 'Alexandria', 'XFS', 'CA', 0, 0, 'Alexandria Rail Station', -100);
INSERT INTO public.airports VALUES (3952, 'Brantford', 'XFV', 'CA', 43.1314, -80.3425, 'Brantford Rail Station', -100);
INSERT INTO public.airports VALUES (3953, 'Lund C', 'XGC', 'SE', 0, 0, 'Lund C Rail Station', -100);
INSERT INTO public.airports VALUES (3954, 'Cobourg', 'XGJ', 'CA', 0, 0, 'Cobourg Rail Station', -100);
INSERT INTO public.airports VALUES (3955, 'Coteau', 'XGK', 'CA', 0, 0, 'Coteau Rail Station', -100);
INSERT INTO public.airports VALUES (3956, 'Kangiqsualujjuaq', 'XGR', 'CA', 58.7114, -65.9928, 'Kangiqsualujjuaq Arpt', -5);
INSERT INTO public.airports VALUES (3957, 'Gananoque', 'XGW', 'CA', 0, 0, 'Gananoque Rail Station', -100);
INSERT INTO public.airports VALUES (3958, 'Grimsby', 'XGY', 'CA', 0, 0, 'Grimsby Rail Station', -100);
INSERT INTO public.airports VALUES (3959, 'Honefoss', 'XHF', 'NO', 0, 0, 'Honefoss Rail Station', -100);
INSERT INTO public.airports VALUES (3960, 'Georgetown', 'XHM', 'CA', 0, 0, 'Georgetown Rail Station', -100);
INSERT INTO public.airports VALUES (3961, 'Hopa', 'XHQ', 'TR', 0, 0, 'Hopa Artvin', 2);
INSERT INTO public.airports VALUES (3962, 'Chemainus', 'XHS', 'CA', 0, 0, 'Chemainus Rail Station', -100);
INSERT INTO public.airports VALUES (3963, 'Guelph', 'XIA', 'CA', 0, 0, 'Guelph Rail Station', -100);
INSERT INTO public.airports VALUES (3964, 'Ingersoll', 'XIB', 'CA', 0, 0, 'Ingersoll Rail Station', -100);
INSERT INTO public.airports VALUES (3965, 'Xichang', 'XIC', 'CN', 27.989082, 102.184364, 'Xichang Arpt', 8);
INSERT INTO public.airports VALUES (3966, 'Maxville', 'XID', 'CA', 0, 0, 'Maxville Rail Station', -100);
INSERT INTO public.airports VALUES (3967, 'Napanee', 'XIF', 'CA', 0, 0, 'Napanee Rail Station', -100);
INSERT INTO public.airports VALUES (3968, 'Prescott', 'XII', 'CA', 0, 0, 'Prescott Rail Station', -100);
INSERT INTO public.airports VALUES (3969, 'Saint Hyacinthe', 'XIM', 'CA', 0, 0, 'Saint Hyacinthe Rail Station', -100);
INSERT INTO public.airports VALUES (3970, 'St Marys', 'XIO', 'CA', 0, 0, 'St Marys Rail Station', -100);
INSERT INTO public.airports VALUES (3971, 'Woodstock', 'XIP', 'CA', 0, 0, 'Woodstock Rail Station', -100);
INSERT INTO public.airports VALUES (3972, 'Joliette', 'XJL', 'CA', 0, 0, 'Joliette Rail Station', -100);
INSERT INTO public.airports VALUES (3973, 'Jonquiere', 'XJQ', 'CA', 0, 0, 'Jonquiere Rail Station', -100);
INSERT INTO public.airports VALUES (3974, 'Xieng Khouang', 'XKH', 'LA', 19.449997, 103.15833, 'Xieng Khouang Arpt', 7);
INSERT INTO public.airports VALUES (3975, 'Steinkjer', 'XKJ', 'NO', 0, 0, 'Steinkjer Rail Station', -100);
INSERT INTO public.airports VALUES (3976, 'Steinkjer', 'XKG', 'NO', 0, 0, 'Grong Rail Station', -100);
INSERT INTO public.airports VALUES (3977, 'Sackville', 'XKV', 'CA', 0, 0, 'Sackville Rail Station', -100);
INSERT INTO public.airports VALUES (3978, 'Matapedia', 'XLP', 'CA', 0, 0, 'Matapedia Rail Station', -100);
INSERT INTO public.airports VALUES (3979, 'Niagara Falls', 'XLV', 'CA', 0, 0, 'Niagara Falls Rail Station', -100);
INSERT INTO public.airports VALUES (3980, 'Aldershot', 'XLY', 'CA', 0, 0, 'Aldershot Rail Station', -100);
INSERT INTO public.airports VALUES (3981, 'Truro', 'XLZ', 'CA', 0, 0, 'Truro Rail Station', -100);
INSERT INTO public.airports VALUES (3982, 'M''Bahiakro', 'XMB', 'CI', 7.45, -4.333333, 'M''Bahiakro Arpt', 0);
INSERT INTO public.airports VALUES (3983, 'Xiamen', 'XMN', 'CN', 24.544037, 118.12774, 'Xiamen Intl Airport', 8);
INSERT INTO public.airports VALUES (3984, 'Yam Island', 'XMY', 'AU', -9.90111, 142.776, 'Yam Island Arpt', 10);
INSERT INTO public.airports VALUES (3985, 'Nottingham', 'XNM', 'GB', 0, 0, 'Nottingham Rail Station', -100);
INSERT INTO public.airports VALUES (3986, 'Xining', 'XNN', 'CN', 36.5275, 102.043, 'Xining Arpt', 8);
INSERT INTO public.airports VALUES (3987, 'Xingtai', 'XNT', 'CN', 0, 0, 'Xingtai Airport', -100);
INSERT INTO public.airports VALUES (3988, 'Oakville', 'XOK', 'CA', 0, 0, 'Oakville Rail Station', -100);
INSERT INTO public.airports VALUES (3989, 'Carleton', 'XON', 'CA', 0, 0, 'Carleton Rail Station', -100);
INSERT INTO public.airports VALUES (3990, 'Otta', 'XOR', 'NO', 0, 0, 'Otta Rail Station', -100);
INSERT INTO public.airports VALUES (3991, 'Parksville', 'XPB', 'CA', 0, 0, 'Parksville Rail Station', -100);
INSERT INTO public.airports VALUES (3992, 'Port Hope', 'XPH', 'CA', 0, 0, 'Port Hope Rail Station', -100);
INSERT INTO public.airports VALUES (3993, 'Pukatawagan', 'XPK', 'CA', 55.7489, -101.2664, 'Pukatawagan Rail Station', -100);
INSERT INTO public.airports VALUES (3994, 'Comayagua', 'XPL', 'HN', 0, 0, 'Palmerola Air Base', -100);
INSERT INTO public.airports VALUES (3995, 'Brampton', 'XPN', 'CA', 0, 0, 'Brampton Rail Station', -100);
INSERT INTO public.airports VALUES (3996, 'Preston', 'XPT', 'GB', 0, 0, 'Preston Rail Station', -100);
INSERT INTO public.airports VALUES (3997, 'Pointe Aux Trembles', 'XPX', 'CA', 0, 0, 'Pointe-aux-Trembles Rail Station', -100);
INSERT INTO public.airports VALUES (3998, 'Berwick Upon Tweed', 'XQG', 'GB', 0, 0, 'Berwick Rail Station', -100);
INSERT INTO public.airports VALUES (3999, 'Quepos', 'XQP', 'CR', 9.443164, -84.12977, 'Quepos Arpt', -6);
INSERT INTO public.airports VALUES (4000, 'Qualicum', 'XQU', 'CA', 49.337223, -124.39389, 'Qualicum Arpt', -8);
INSERT INTO public.airports VALUES (4001, 'Egersund', 'XRD', 'NO', 0, 0, 'Rail Station Egersund', -100);
INSERT INTO public.airports VALUES (4002, 'Rugeley', 'XRG', 'GB', 0, 0, 'Rugeley Rail Station', -100);
INSERT INTO public.airports VALUES (4003, 'Riviere A Pierre', 'XRP', 'CA', 0, 0, 'Pine Ridge Rail Station', -100);
INSERT INTO public.airports VALUES (4004, 'Rugby', 'XRU', 'GB', 0, 0, 'Rugby Rail Station', -100);
INSERT INTO public.airports VALUES (4005, 'Jerez De La Frontera', 'XRY', 'ES', 36.74462, -6.060111, 'La Parra Arpt', 1);
INSERT INTO public.airports VALUES (4006, 'South Caicos', 'XSC', 'TC', 21.51574, -71.52853, 'South Caicos Intl Arpt', -5);
INSERT INTO public.airports VALUES (4007, 'Salisbury', 'XSR', 'GB', 0, 0, 'Salisbury Rail Station', -100);
INSERT INTO public.airports VALUES (4008, 'Soissons', 'XSS', 'FR', 0, 0, 'Soissons Railway Station', -100);
INSERT INTO public.airports VALUES (4009, 'Thargomindah', 'XTG', 'AU', -27.9864, 143.811, 'Thargomindah Arpt', 10);
INSERT INTO public.airports VALUES (4010, 'Strathroy', 'XTY', 'CA', 0, 0, 'Strathroy Rail Station', -100);
INSERT INTO public.airports VALUES (4011, 'Holmestrand', 'XUG', 'NO', 0, 0, 'Holmestrand Railway', -100);
INSERT INTO public.airports VALUES (4012, 'Xuzhou', 'XUZ', 'CN', 34.16, 117.11, 'Xuzhou Arpt', 8);
INSERT INTO public.airports VALUES (4013, 'Stockport', 'XVA', 'GB', 0, 0, 'Stockport Rail Station', -100);
INSERT INTO public.airports VALUES (4014, 'Peterborough', 'XVH', 'GB', 0, 0, 'Peterborough Rail Station', -100);
INSERT INTO public.airports VALUES (4015, 'Stevenage', 'XVJ', 'GB', 0, 0, 'Stevenage Rail Station', -100);
INSERT INTO public.airports VALUES (4016, 'Belleville', 'XVV', 'CA', 44.1793, -77.3747, 'Belleville Rail Station', -5);
INSERT INTO public.airports VALUES (4017, 'Wolverhampton', 'XVW', 'GB', 52.5175, -2.2594, 'Belleville Rail Station', -100);
INSERT INTO public.airports VALUES (4018, 'Watford', 'XWA', 'CA', 0, 0, 'Watford Rail Station', -100);
INSERT INTO public.airports VALUES (4019, 'Wakefield Westgate', 'XWD', 'GB', 0, 0, 'Wakefield Westgate Rail Station', -100);
INSERT INTO public.airports VALUES (4020, 'Falun', 'XWF', 'SE', 0, 0, 'Falun Railway Service', -100);
INSERT INTO public.airports VALUES (4021, 'Falun', 'XJF', 'SE', 0, 0, 'Falun Bus Service', -100);
INSERT INTO public.airports VALUES (4022, 'Stoke On Trent', 'XWH', 'GB', 0, 0, 'Stroke on Trent Rail Station', -100);
INSERT INTO public.airports VALUES (4023, 'Varberg', 'XWV', 'SE', 0, 0, 'Varberg Rail Station', -100);
INSERT INTO public.airports VALUES (4024, 'Wyoming', 'XWY', 'CA', 0, 0, 'Wyoming Rail Station', -100);
INSERT INTO public.airports VALUES (4025, 'Alvesta', 'XXA', 'SE', 0, 0, 'Alvesta Railway Service', -100);
INSERT INTO public.airports VALUES (4026, 'Degerfors', 'XXD', 'SE', 0, 0, 'Degerfors Rail Station', -100);
INSERT INTO public.airports VALUES (4027, 'Lille Hammer', 'XXL', 'NO', 0, 0, 'Lillehammer Rail Station', -100);
INSERT INTO public.airports VALUES (4028, 'Mjolby', 'XXM', 'SE', 0, 0, 'Mjolby Rail Station', -100);
INSERT INTO public.airports VALUES (4029, 'Kristinehamn', 'XYN', 'SE', 0, 0, 'Kristinehamn Rail Station', -100);
INSERT INTO public.airports VALUES (4030, 'Avesta Krylbo', 'XYP', 'SE', 0, 0, 'Railway Service', -100);
INSERT INTO public.airports VALUES (4031, 'Arvika', 'XYY', 'SE', 0, 0, 'Arvika Rail Station', -100);
INSERT INTO public.airports VALUES (4032, 'Harnosand', 'XYZ', 'SE', 0, 0, 'Harnosand Rail Station', -100);
INSERT INTO public.airports VALUES (4033, 'Casselman', 'XZB', 'CA', 0, 0, 'Casselman Rail Station', -100);
INSERT INTO public.airports VALUES (4034, 'Glencoe', 'XZC', 'CA', 0, 0, 'Glencoe Rail Station', -100);
INSERT INTO public.airports VALUES (4035, 'Kongsvinger', 'XZD', 'NO', 0, 0, 'Kongsvinger Rail Station', -100);
INSERT INTO public.airports VALUES (4036, 'Rail', 'XZJ', 'JP', 0, 0, 'Off Line Point', -100);
INSERT INTO public.airports VALUES (4037, 'Amherst', 'XZK', 'CA', 0, 0, 'Amherst Rail Station', -100);
INSERT INTO public.airports VALUES (4038, 'Pass', 'XZP', 'CA', 0, 0, 'Off Line Point', -100);
INSERT INTO public.airports VALUES (4039, 'Fort Frances', 'YAG', 'CA', 48.6542, -93.4397, 'Fort Frances Municipal', -6);
INSERT INTO public.airports VALUES (4040, 'Yakutat', 'YAK', 'US', 59.3012, -139.3937, 'Yakutat Arpt', -9);
INSERT INTO public.airports VALUES (4041, 'Sault Ste Marie', 'YAM', 'CA', 46.485, -84.509445, 'Sault Ste Marie Arpt', -5);
INSERT INTO public.airports VALUES (4042, 'Yaounde', 'NSI', 'CM', 3.722556, 11.553269, 'Nsimalen Arpt', 1);
INSERT INTO public.airports VALUES (4043, 'Yaounde', 'YAO', 'CM', 3.836039, 11.523461, 'Yaounde Airport', 1);
INSERT INTO public.airports VALUES (4044, 'Yap Fm', 'YAP', 'FM', 9.498911, 138.0825, 'Yap Arpt', 10);
INSERT INTO public.airports VALUES (4045, 'Attawapiskat', 'YAT', 'CA', 52.9275, -82.4319, 'Attawapiskat Arpt', -5);
INSERT INTO public.airports VALUES (4046, 'St Anthony', 'YAY', 'CA', 51.391945, -56.083057, 'St Anthony Arpt', -4);
INSERT INTO public.airports VALUES (4047, 'Tofino', 'YAZ', 'CA', 49.082222, -125.7725, 'Tofino Arpt', -8);
INSERT INTO public.airports VALUES (4048, 'Banff', 'YBA', 'CA', 0, 0, 'Banff Arpt', -100);
INSERT INTO public.airports VALUES (4049, 'Pelly Bay', 'YBB', 'CA', 68.53445, -89.80806, 'Kugaaruk Arpt', -6);
INSERT INTO public.airports VALUES (4050, 'Baie Comeau', 'YBC', 'CA', 49.1325, -68.204445, 'Baie Comeau Arpt', -5);
INSERT INTO public.airports VALUES (4051, 'New Westminster', 'YBD', 'CA', 0, 0, 'New Westminster Rail Station', -100);
INSERT INTO public.airports VALUES (4052, 'Bagotville', 'YBG', 'CA', 48.330555, -70.99639, 'Bagotville Arpt', -5);
INSERT INTO public.airports VALUES (4053, 'Baker Lake', 'YBK', 'CA', 64.29889, -96.07778, 'Baker Lake Arpt', -6);
INSERT INTO public.airports VALUES (4054, 'Campbell River', 'YBL', 'CA', 49.950832, -125.270836, 'Campbell River Municipal', -8);
INSERT INTO public.airports VALUES (4055, 'Campbell River', 'YHH', 'CA', 0, 0, 'Harbor Airport', -100);
INSERT INTO public.airports VALUES (4056, 'Yibin', 'YBP', 'CN', 28.800278, 104.54444, 'Yibin Airport', 8);
INSERT INTO public.airports VALUES (4057, 'Brandon', 'YBR', 'CA', 49.91, -99.95194, 'Brandon Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4058, 'Bedwell Harbor', 'YBW', 'CA', 51.1031, -114.374, 'Bedwell Harbor Arpt', -7);
INSERT INTO public.airports VALUES (4059, 'Blanc Sablon', 'YBX', 'CA', 51.4436, -57.1853, 'Blanc Sablon Arpt', -4);
INSERT INTO public.airports VALUES (4060, 'Courtenay', 'YCA', 'CA', 0, 0, 'Courtenay Rail Station', -100);
INSERT INTO public.airports VALUES (4061, 'Cambridge Bay', 'YCB', 'CA', 69.108055, -105.138336, 'Cambridge Bay Arpt', -7);
INSERT INTO public.airports VALUES (4062, 'Cornwall', 'YCC', 'CA', 45.092777, -74.56778, 'Cornwall Regional Arpt', -5);
INSERT INTO public.airports VALUES (4063, 'Nanaimo', 'ZNA', 'CA', 49.183334, -123.95, 'Harbour Seaplane Base', -8);
INSERT INTO public.airports VALUES (4064, 'Nanaimo', 'YCD', 'CA', 49.052334, -123.87017, 'Nanaimo Arpt', -8);
INSERT INTO public.airports VALUES (4065, 'Castlegar', 'YCG', 'CA', 49.29639, -117.6325, 'Ralph West Arpt', -8);
INSERT INTO public.airports VALUES (4066, 'Miramichi', 'XEY', 'CA', 0, 0, 'Newcastle Rail Station', -100);
INSERT INTO public.airports VALUES (4067, 'Miramichi', 'YCH', 'CA', 47.00778, -65.449165, 'Miramichi Arpt', -4);
INSERT INTO public.airports VALUES (4068, 'Colville', 'YCK', 'CA', 67.0333, -126.083, 'Colville Municipal', -7);
INSERT INTO public.airports VALUES (4069, 'Charlo', 'YCL', 'CA', 47.990833, -66.33028, 'Charlo Municipal Arpt', -4);
INSERT INTO public.airports VALUES (4070, 'St Catherines', 'YCM', 'CA', 0, 0, 'St Catharines Rail Station', -100);
INSERT INTO public.airports VALUES (4071, 'Cochrane', 'YCN', 'CA', 49.1056, -81.0136, 'Cochrane Rail Station', -100);
INSERT INTO public.airports VALUES (4072, 'Kugluktuk Coppermine', 'YCO', 'CA', 67.816666, -115.14389, 'Kugluktuk Arpt', -7);
INSERT INTO public.airports VALUES (4073, 'Chesterfield Inlet', 'YCS', 'CA', 63.3469, -90.7311, 'Chesterfield Inlet Arpt', -6);
INSERT INTO public.airports VALUES (4074, 'Yun Cheng', 'YCU', 'CN', 35.018, 110.993, 'Yun Cheng Arpt', 8);
INSERT INTO public.airports VALUES (4075, 'Chilliwack', 'YCW', 'CA', 49.15278, -121.93889, 'Chilliwack Arpt', -8);
INSERT INTO public.airports VALUES (4076, 'Clyde River', 'YCY', 'CA', 70.486115, -68.51667, 'Clyde River', -5);
INSERT INTO public.airports VALUES (4077, 'Fairmont Springs', 'YCZ', 'CA', 0, 0, 'Fairmont Springs Arpt', -100);
INSERT INTO public.airports VALUES (4078, 'Dawson City', 'YDA', 'CA', 64.04305, -139.12778, 'Dawson City Arpt', -8);
INSERT INTO public.airports VALUES (4079, 'Deer Lake', 'YDF', 'CA', 49.210835, -57.391388, 'Deer Lake Municipal', -4);
INSERT INTO public.airports VALUES (4080, 'Dease Lake', 'YDL', 'CA', 58.422222, -130.03223, 'Dease Lake Arpt', -8);
INSERT INTO public.airports VALUES (4081, 'Dauphin', 'YDN', 'CA', 51.100834, -100.0525, 'Dauphin Rail Station', -6);
INSERT INTO public.airports VALUES (4082, 'Nain', 'YDP', 'CA', 56.5492, -61.6803, 'Nain Arpt', -4);
INSERT INTO public.airports VALUES (4083, 'Dawson Creek', 'YDQ', 'CA', 55.742332, -120.183, 'Dawson Creek Arpt', -7);
INSERT INTO public.airports VALUES (4084, 'Edmonton', 'YXD', 'CA', 53.5725, -113.52055, 'Edmonton Municipal Arpt', -7);
INSERT INTO public.airports VALUES (4085, 'Edmonton', 'YED', 'CA', 0, 0, 'Namao Field', -100);
INSERT INTO public.airports VALUES (4086, 'Edmonton', 'YEG', 'CA', 53.309723, -113.57972, 'Edmonton Intl Arpt', -7);
INSERT INTO public.airports VALUES (4087, 'Edmonton', 'XZL', 'CA', 53.5789, -113.5307, 'Edmonton Rail Station', -7);
INSERT INTO public.airports VALUES (4088, 'Bar River', 'YEB', 'CA', 0, 0, 'Bar River Arpt', -100);
INSERT INTO public.airports VALUES (4089, 'Asaloyeh', 'YEH', 'IR', 0, 0, 'Asaloyeh Arpt', -100);
INSERT INTO public.airports VALUES (4090, 'Arviat', 'YEK', 'CA', 61.094166, -94.07083, 'Arviat Arpt', -6);
INSERT INTO public.airports VALUES (4091, 'Elliot Lake', 'YEL', 'CA', 46.3514, -82.5614, 'Elliot Lake Arpt', -100);
INSERT INTO public.airports VALUES (4092, 'Estevan', 'YEN', 'CA', 49.210278, -102.965836, 'Estevan Arpt', -6);
INSERT INTO public.airports VALUES (4093, 'Fort Severn', 'YER', 'CA', 56.0189, -87.6761, 'Fort Severn Arpt', -5);
INSERT INTO public.airports VALUES (4094, 'Edson', 'YET', 'CA', 53.578888, -116.465, 'Edson Arpt', -7);
INSERT INTO public.airports VALUES (4095, 'Inuvik', 'YEV', 'CA', 68.30417, -133.48277, 'Inuvik Mike Zubko Arpt', -7);
INSERT INTO public.airports VALUES (4096, 'Amos', 'YEY', 'CA', 0, 0, 'Amos Rail Station', -100);
INSERT INTO public.airports VALUES (4097, 'Iqaluit', 'YFB', 'CA', 63.75639, -68.55583, 'Iqaluit Arpt', -5);
INSERT INTO public.airports VALUES (4098, 'Fredericton', 'YFC', 'CA', 45.86889, -66.537224, 'Fredericton Municipal', -4);
INSERT INTO public.airports VALUES (4099, 'Flin Flon', 'YFO', 'CA', 54.678055, -101.68166, 'Flin Flon Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4100, 'Fox Harbour', 'YFX', 'CA', 52.3728, -55.6739, 'Fox Harbour Arpt', -4);
INSERT INTO public.airports VALUES (4101, 'Yonago', 'YGJ', 'JP', 35.49222, 133.23639, 'Miho Arpt', 9);
INSERT INTO public.airports VALUES (4102, 'Kingston', 'YGK', 'CA', 44.225277, -76.59695, 'Norman Rodgers Arpt', -5);
INSERT INTO public.airports VALUES (4103, 'Kingston', 'XEG', 'CA', 44.256943, -76.53694, 'Kingston Rail Station', -5);
INSERT INTO public.airports VALUES (4104, 'La Grande', 'YGL', 'CA', 53.62528, -77.70417, 'La Grande Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4105, 'Gaspe', 'YGP', 'CA', 48.775276, -64.478615, 'Gaspe Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4106, 'Gaspe', 'XDD', 'CA', 0, 0, 'Gaspe Rail Station', -100);
INSERT INTO public.airports VALUES (4107, 'Iles De Madeleine', 'YGR', 'CA', 47.42472, -61.778057, 'House Harbour Arpt', -4);
INSERT INTO public.airports VALUES (4108, 'Igloolik', 'YGT', 'CA', 69.3647, -81.8161, 'Igloolik Arpt', -5);
INSERT INTO public.airports VALUES (4109, 'Havre St Pierre', 'YGV', 'CA', 50.281944, -63.61139, 'Havre St Pierre Municipal Arpt', -4);
INSERT INTO public.airports VALUES (4110, 'Poste De La Baleine', 'YGW', 'CA', 55.2819, -77.7653, 'Kuujjuaraapik Arpt', -5);
INSERT INTO public.airports VALUES (4111, 'Gillam', 'YGX', 'CA', 56.3575, -94.7106, 'Gillam Rail Station', -6);
INSERT INTO public.airports VALUES (4112, 'Port Hope Simpson', 'YHA', 'CA', 52.5281, -56.2861, 'Port Hope Simpson Arpt', -4);
INSERT INTO public.airports VALUES (4113, 'Hudson Bay', 'YHB', 'CA', 52.816666, -102.31139, 'Hudson Bay Rail Station', -6);
INSERT INTO public.airports VALUES (4114, 'Dryden', 'YHD', 'CA', 49.83167, -92.74416, 'Dryden Municipal', -6);
INSERT INTO public.airports VALUES (4115, 'Hope', 'YHE', 'CA', 49.3667, -121.4833, 'Hope Arpt', -100);
INSERT INTO public.airports VALUES (4116, 'Hearst', 'YHF', 'CA', 49.71389, -83.68694, 'Hearst Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4117, 'Charlottetown', 'YHG', 'CA', 52.7647, -56.1094, 'Charlottetown Municipal Arpt', -100);
INSERT INTO public.airports VALUES (4118, 'Gjoa Haven', 'YHK', 'CA', 68.63556, -95.849724, 'Gjoa Haven Arpt', -6);
INSERT INTO public.airports VALUES (4119, 'Hamilton', 'YHM', 'CA', 43.17361, -79.935, 'Civic Airport', -5);
INSERT INTO public.airports VALUES (4120, 'Hornepayne', 'YHN', 'CA', 49.193054, -84.75889, 'Hornepayne Rail Station', -5);
INSERT INTO public.airports VALUES (4121, 'Hopedale', 'YHO', 'CA', 55.4483, -60.2286, 'Hopedale Arpt', -4);
INSERT INTO public.airports VALUES (4122, 'Chevery', 'YHR', 'CA', 50.4689, -59.6367, 'Chevery Arpt', -4);
INSERT INTO public.airports VALUES (4123, 'Sechelt', 'YHS', 'CA', 49.460556, -123.71861, 'Sechelt Arpt', -8);
INSERT INTO public.airports VALUES (4124, 'Hay River', 'YHY', 'CA', 60.83972, -115.782776, 'Hay River Municipal Arpt', -7);
INSERT INTO public.airports VALUES (4125, 'Halifax', 'YHZ', 'CA', 44.880833, -63.50861, 'Halifax Intl', -4);
INSERT INTO public.airports VALUES (4126, 'Halifax', 'XDG', 'CA', 0, 0, 'Halifax Rail Station', -100);
INSERT INTO public.airports VALUES (4127, 'Atikokan', 'YIB', 'CA', 48.773888, -91.63861, 'Atikokan Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4128, 'Pakuashipi', 'YIF', 'CA', 51.2117, -58.6583, 'Pakuashipi Arpt', -4);
INSERT INTO public.airports VALUES (4129, 'Yichang', 'YIH', 'CN', 30.671, 111.441, 'Yichang Arpt', 8);
INSERT INTO public.airports VALUES (4130, 'Ivujivik', 'YIK', 'CA', 62.4173, -77.9253, 'Ivujivik Arpt', -5);
INSERT INTO public.airports VALUES (4131, 'Pond Inlet', 'YIO', 'CA', 72.683334, -77.96667, 'Pond Inlet Arpt', -5);
INSERT INTO public.airports VALUES (4132, 'Yiwu', 'YIW', 'CN', 29.3447, 120.032, 'Yiwu Arpt', 8);
INSERT INTO public.airports VALUES (4133, 'Jasper', 'YJA', 'CA', 0, 0, 'Jasper Airport', -100);
INSERT INTO public.airports VALUES (4134, 'Jasper', 'XDH', 'CA', 0, 0, 'Jasper Rail Station', -100);
INSERT INTO public.airports VALUES (4135, 'Stephenville', 'YJT', 'CA', 48.544167, -58.55, 'Stephenville Municipal', -4);
INSERT INTO public.airports VALUES (4136, 'Kamloops', 'YKA', 'CA', 50.70222, -120.44444, 'Davie Fulton Arpt', -8);
INSERT INTO public.airports VALUES (4137, 'Kitchener', 'YKF', 'CA', 43.460835, -80.37861, 'Kitchener Waterloo Regional', -5);
INSERT INTO public.airports VALUES (4138, 'Kangirsuk', 'YKG', 'CA', 60.0272, -69.9992, 'Kangirsuk Arpt', -5);
INSERT INTO public.airports VALUES (4139, 'Schefferville', 'YKL', 'CA', 54.80528, -66.805275, 'Schefferville Arpt', -4);
INSERT INTO public.airports VALUES (4140, 'Yakima', 'YKM', 'US', 46.5682, -120.544, 'Yakima Terminal Arpt', -8);
INSERT INTO public.airports VALUES (4141, 'Yankton', 'YKN', 'US', 0, 0, 'Chan Gurney Municipal', -100);
INSERT INTO public.airports VALUES (4142, 'Waskaganish', 'YKQ', 'CA', 51.4733, -78.7583, 'Waskaganish Arpt', -5);
INSERT INTO public.airports VALUES (4143, 'Yakutsk', 'YKS', 'RU', 62.09325, 129.77068, 'Yakutsk Arpt', 10);
INSERT INTO public.airports VALUES (4144, 'Chisasibi', 'YKU', 'CA', 53.8056, -78.9169, 'Chisasibi Arpt', -5);
INSERT INTO public.airports VALUES (4145, 'Kirkland', 'YKX', 'CA', 48.210278, -79.98139, 'Kirkland Lake Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4146, 'Kimmirut Lake Harbour', 'YLC', 'CA', 62.85, -69.8833, 'Kimmirut Lake Harbour Arpt', -5);
INSERT INTO public.airports VALUES (4147, 'Chapleau', 'YLD', 'CA', 47.82, -83.346664, 'Chapleau Rail Station', -5);
INSERT INTO public.airports VALUES (4148, 'Ylivieska', 'YLI', 'FI', 64.0547, 24.7253, 'Ylivieska Arpt', -100);
INSERT INTO public.airports VALUES (4149, 'Meadow Lake', 'YLJ', 'CA', 54.12528, -108.52278, 'Meadow Lake Arpt', -6);
INSERT INTO public.airports VALUES (4150, 'Lloydminster', 'YLL', 'CA', 53.309166, -110.0725, 'Lloydminster Arpt', -6);
INSERT INTO public.airports VALUES (4151, 'La Tuque', 'YLQ', 'CA', 47.4097, -72.7889, 'La Tuque Rail Station', -100);
INSERT INTO public.airports VALUES (4152, 'Kelowna', 'YLW', 'CA', 49.956112, -119.37778, 'Ellison Field', -8);
INSERT INTO public.airports VALUES (4153, 'Langley', 'YLY', 'CA', 49.1008, -122.6308, 'Langley Regional Arpt', -100);
INSERT INTO public.airports VALUES (4154, 'Merritt', 'YMB', 'CA', 0, 0, 'Merritt Arpt', -100);
INSERT INTO public.airports VALUES (4155, 'Matane', 'YME', 'CA', 0, 0, 'Matane Airport', -100);
INSERT INTO public.airports VALUES (4156, 'Manitouwadge', 'YMG', 'CA', 49.08389, -85.86056, 'Manitouwadge Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4157, 'Marys Harbour', 'YMH', 'CA', 52.3028, -55.8472, 'Marys Harbour Arpt', -4);
INSERT INTO public.airports VALUES (4158, 'Minaki', 'YMI', 'CA', 0, 0, 'Minaki Rail Station', -100);
INSERT INTO public.airports VALUES (4159, 'Ft McMurray', 'YMM', 'CA', 56.65333, -111.22195, 'Ft McMurray Municipal Arpt', -7);
INSERT INTO public.airports VALUES (4160, 'Makkovik', 'YMN', 'CA', 55.0769, -59.1864, 'Makkovik Arpt', -4);
INSERT INTO public.airports VALUES (4161, 'Moosonee', 'YMO', 'CA', 51.29111, -80.60778, 'Moosonee Arpt', -5);
INSERT INTO public.airports VALUES (4162, 'Montreal', 'XLM', 'CA', 0, 0, 'Saint Lambert Rail Station', -100);
INSERT INTO public.airports VALUES (4163, 'Montreal', 'YMX', 'CA', 45.681946, -74.00528, 'Mirabel Intl Arpt', -5);
INSERT INTO public.airports VALUES (4164, 'Montreal', 'YMY', 'CA', 45.49972, -73.56611, 'Montreal Downtown Rail Station', -5);
INSERT INTO public.airports VALUES (4165, 'Montreal', 'YHU', 'CA', 45.5175, -73.41695, 'St Hubert Arpt', -5);
INSERT INTO public.airports VALUES (4166, 'Montreal', 'XAX', 'CA', 45.448612, -73.74111, 'Dorval Rail Station', -5);
INSERT INTO public.airports VALUES (4167, 'Montreal', 'YUL', 'CA', 45.470554, -73.74083, 'Pierre Elliott Trudeau Intl Arpt', -5);
INSERT INTO public.airports VALUES (4168, 'Chibougamau', 'YMT', 'CA', 49.7719, -74.5281, 'Chibougamau Arpt', -5);
INSERT INTO public.airports VALUES (4169, 'Natashquan', 'YNA', 'CA', 50.19, -61.789165, 'Natashquan Arpt', -4);
INSERT INTO public.airports VALUES (4170, 'Yanbo', 'YNB', 'SA', 24.144243, 38.06335, 'Yanbo Arpt', 3);
INSERT INTO public.airports VALUES (4171, 'Gatineau Hull', 'YND', 'CA', 45.521694, -75.56359, 'Gatineau Hull Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4172, 'Youngstown', 'YNG', 'US', 41.260735, -80.6791, 'Youngstown Municipal', -5);
INSERT INTO public.airports VALUES (4173, 'Yanji', 'YNJ', 'CN', 42.8828, 129.45126, 'Yanji Arpt', 8);
INSERT INTO public.airports VALUES (4174, 'Yandicoogina', 'YNN', 'AU', 0, 0, 'Yandi Arpt', -100);
INSERT INTO public.airports VALUES (4175, 'Natuashish', 'YNP', 'CA', 55.9128, -61.1853, 'Natuashish Arpt', -100);
INSERT INTO public.airports VALUES (4176, 'Yantai', 'YNT', 'CN', 37.40167, 121.371666, 'Laishan Arpt', 8);
INSERT INTO public.airports VALUES (4177, 'Yancheng', 'YNZ', 'CN', 33.3856, 120.125, 'Yancheng Arpt', 8);
INSERT INTO public.airports VALUES (4178, 'Cold Lake', 'YOD', 'CA', 54.405, -110.27944, 'Cold Lake Arpt', -7);
INSERT INTO public.airports VALUES (4179, 'High Level', 'YOJ', 'CA', 58.621387, -117.16472, 'Footner Lake Arpt', -7);
INSERT INTO public.airports VALUES (4180, 'Oshawa', 'YOO', 'CA', 43.9228, -78.895, 'Oshawa Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4181, 'Rainbow Lake', 'YOP', 'CA', 58.49139, -119.407776, 'Rainbow Lake Arpt', -7);
INSERT INTO public.airports VALUES (4182, 'Owen Sound', 'YOS', 'CA', 0, 0, 'Billy Bishop Regional Arpt', -100);
INSERT INTO public.airports VALUES (4183, 'Yotvata', 'YOT', 'IL', 0, 0, 'Yotvata Arpt', -100);
INSERT INTO public.airports VALUES (4184, 'Ottawa', 'YOW', 'CA', 45.3225, -75.66917, 'Ottawa Intl Arpt', -5);
INSERT INTO public.airports VALUES (4185, 'Ottawa', 'XDS', 'CA', 45.4164, -75.6517, 'Ottawa Rail Station', -5);
INSERT INTO public.airports VALUES (4186, 'Prince Albert', 'YPA', 'CA', 53.21417, -105.672775, 'Prince Albert Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4187, 'Port Alberni', 'YPB', 'CA', 49.267, -124.833, 'Port Alberni Arpt', -100);
INSERT INTO public.airports VALUES (4188, 'Parry Sound', 'YPD', 'CA', 70.1678, -124.6914, 'Parry Sound Municipal Arpt', -100);
INSERT INTO public.airports VALUES (4189, 'Peace River', 'YPE', 'CA', 56.226944, -117.44722, 'Municipal Peace River', -7);
INSERT INTO public.airports VALUES (4190, 'Esquimalt', 'YPF', 'CA', 0, 0, 'Esquimalt Rail Station', -100);
INSERT INTO public.airports VALUES (4191, 'Portage La Prairie', 'YPG', 'CA', 49.903057, -98.27389, 'Portage La Prairie Rail Station', -6);
INSERT INTO public.airports VALUES (4192, 'Inukjuak', 'YPH', 'CA', 58.4719, -78.0769, 'Inukjuak Arpt', -5);
INSERT INTO public.airports VALUES (4193, 'Aupaluk', 'YPJ', 'CA', 59.2967, -69.5997, 'Aupaluk Arpt', -5);
INSERT INTO public.airports VALUES (4194, 'Pickle Lake', 'YPL', 'CA', 51.44639, -90.214165, 'Pickle Lake Arpt', -6);
INSERT INTO public.airports VALUES (4195, 'St Pierre', 'YPM', 'CA', 51.8197, -93.9733, 'Pikangikum Arpt', -6);
INSERT INTO public.airports VALUES (4196, 'Port Menier', 'YPN', 'CA', 49.836388, -64.28861, 'Port Menier Arpt', -5);
INSERT INTO public.airports VALUES (4197, 'Peterborough', 'YPQ', 'CA', 44.23, -78.363335, 'Peterborough Arpt', -5);
INSERT INTO public.airports VALUES (4198, 'Prince Rupert', 'YPR', 'CA', 54.28611, -130.44472, 'Digby Island Arpt', -8);
INSERT INTO public.airports VALUES (4199, 'Prince Rupert', 'XDW', 'CA', 0, 0, 'Prince Rupert Rail Station', -100);
INSERT INTO public.airports VALUES (4200, 'Prince Rupert', 'ZSW', 'CA', 54.3333, -130.283, 'Seal Cove Arpt', -8);
INSERT INTO public.airports VALUES (4201, 'Port Hawkesbury', 'YPS', 'CA', 45.6567, -61.3681, 'Port Hawkesbury Arpt', -100);
INSERT INTO public.airports VALUES (4202, 'Powell River', 'YPW', 'CA', 49.8342, -124.5, 'Westview Arpt', -8);
INSERT INTO public.airports VALUES (4203, 'Puvirnituq', 'YPX', 'CA', 60.0506, -77.2869, 'Povungnituk Arpt', -5);
INSERT INTO public.airports VALUES (4204, 'Burns Lake', 'YPZ', 'CA', 54.3717, -125.9514, 'Burns Lake Rail Station', -100);
INSERT INTO public.airports VALUES (4205, 'Muskoka', 'YQA', 'CA', 44.974724, -79.30333, 'Muskoka Arpt', -5);
INSERT INTO public.airports VALUES (4206, 'Quebec', 'XLJ', 'CA', 0, 0, 'Quebec City Rail Station', -100);
INSERT INTO public.airports VALUES (4207, 'Quebec', 'XFZ', 'CA', 0, 0, 'Charny Rail Station', -100);
INSERT INTO public.airports VALUES (4208, 'Quebec', 'YQB', 'CA', 46.79111, -71.39333, 'Quebec Intl', -5);
INSERT INTO public.airports VALUES (4209, 'Quebec', 'XFY', 'CA', 0, 0, 'Sainte-Foy Rail Station', -100);
INSERT INTO public.airports VALUES (4210, 'Quebec', 'XLK', 'CA', 0, 0, 'Levis Rail Station', -100);
INSERT INTO public.airports VALUES (4211, 'Quaqtaq', 'YQC', 'CA', 61.0464, -69.6178, 'Quaqtaq Arpt', -5);
INSERT INTO public.airports VALUES (4212, 'The Pas', 'XDZ', 'CA', 0, 0, 'The Pas Rail Station', -100);
INSERT INTO public.airports VALUES (4213, 'The Pas', 'YQD', 'CA', 53.9714, -101.091, 'The Pas Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4214, 'Windsor', 'XEC', 'CA', 0, 0, 'Windsor Rail Station', -100);
INSERT INTO public.airports VALUES (4215, 'Windsor', 'YQG', 'CA', 42.275555, -82.95556, 'Windsor Intl Arpt', -5);
INSERT INTO public.airports VALUES (4216, 'Watson Lake', 'YQH', 'CA', 60.11639, -128.8225, 'Watson Lake Arpt', -8);
INSERT INTO public.airports VALUES (4217, 'Yarmouth', 'YQI', 'CA', 43.8269, -66.0881, 'Municipal Yarmouth', -5);
INSERT INTO public.airports VALUES (4218, 'Kenora', 'YQK', 'CA', 49.788334, -94.36305, 'Kenora Arpt', -6);
INSERT INTO public.airports VALUES (4219, 'Lethbridge', 'YQL', 'CA', 49.63028, -112.79972, 'Lethbridge Arpt', -7);
INSERT INTO public.airports VALUES (4220, 'Moncton', 'YQM', 'CA', 46.11222, -64.67861, 'Moncton Municipal', -4);
INSERT INTO public.airports VALUES (4221, 'Moncton', 'XDP', 'CA', 0, 0, 'Moncton Rail Station', -100);
INSERT INTO public.airports VALUES (4222, 'Nakina', 'YQN', 'CA', 50.182777, -86.69639, 'Nakina Rail Station', -5);
INSERT INTO public.airports VALUES (4223, 'Comox', 'YQQ', 'CA', 49.710835, -124.886665, 'Royal Canadian Air Force Station', -8);
INSERT INTO public.airports VALUES (4224, 'Regina', 'YQR', 'CA', 50.431946, -104.66583, 'Regina Municipal', -6);
INSERT INTO public.airports VALUES (4225, 'Regina', 'YMJ', 'CA', 50.330276, -105.559166, 'Moose Jaw Arpt', -6);
INSERT INTO public.airports VALUES (4226, 'St Thomas', 'YQS', 'CA', 42.77, -81.1108, 'Pembroke Area Municipal Arpt', -100);
INSERT INTO public.airports VALUES (4227, 'Thunder Bay', 'YQT', 'CA', 48.371944, -89.32389, 'Thunder Bay Arpt', -5);
INSERT INTO public.airports VALUES (4228, 'Grande Prairie', 'YQU', 'CA', 55.17972, -118.885, 'Grande Prairie Arpt', -7);
INSERT INTO public.airports VALUES (4229, 'Yorkton', 'YQV', 'CA', 51.26472, -102.46167, 'Yorkton Airport', -6);
INSERT INTO public.airports VALUES (4230, 'North Battleford', 'YQW', 'CA', 52.76917, -108.24361, 'North Battleford Arpt', -6);
INSERT INTO public.airports VALUES (4231, 'Gander', 'YQX', 'CA', 48.936943, -54.568054, 'Gander International', -4);
INSERT INTO public.airports VALUES (4232, 'Sydney', 'YQY', 'CA', 46.16139, -60.04778, 'Sydney Airport', -4);
INSERT INTO public.airports VALUES (4233, 'Quesnel', 'YQZ', 'CA', 53.02611, -122.51028, 'Quesnel Arpt', -8);
INSERT INTO public.airports VALUES (4234, 'Resolute', 'YRB', 'CA', 74.71694, -94.969444, 'Resolute Arpt', -6);
INSERT INTO public.airports VALUES (4235, 'Cartwright', 'YRF', 'CA', 53.6828, -57.0419, 'Cartwright Arpt', -4);
INSERT INTO public.airports VALUES (4236, 'Rigolet', 'YRG', 'CA', 54.1797, -58.4575, 'Rigolet Arpt', -4);
INSERT INTO public.airports VALUES (4237, 'Riviere Du Loup', 'YRI', 'CA', 47.764442, -69.584724, 'Riviere Du Loup Arpt', -5);
INSERT INTO public.airports VALUES (4238, 'Roberval', 'YRJ', 'CA', 48.52, -72.26556, 'Roberval Airport', -5);
INSERT INTO public.airports VALUES (4239, 'Red Lake', 'YRL', 'CA', 51.0669, -93.7931, 'Federal Red Lake', -6);
INSERT INTO public.airports VALUES (4240, 'Trois Rivieres', 'YRQ', 'CA', 46.3528, -72.6794, 'Three Rivers Arpt', -100);
INSERT INTO public.airports VALUES (4241, 'Rankin Inlet', 'YRT', 'CA', 62.81139, -92.11583, 'Rankin Inlet Arpt', -6);
INSERT INTO public.airports VALUES (4242, 'Sudbury', 'YSB', 'CA', 46.625, -80.79889, 'Sudbury Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4243, 'Sudbury', 'XDY', 'CA', 0, 0, 'Sudbury Junction Rail Station', -100);
INSERT INTO public.airports VALUES (4244, 'Sherbrooke', 'YSC', 'CA', 45.43861, -71.69139, 'Sherbrooke Airport', -5);
INSERT INTO public.airports VALUES (4245, 'Smith Falls', 'YSH', 'CA', 0, 0, 'Smith Falls Rail Station', -100);
INSERT INTO public.airports VALUES (4246, 'St John', 'YSJ', 'CA', 45.316113, -65.89028, 'St John Municipal', -4);
INSERT INTO public.airports VALUES (4247, 'Sanikiluaq', 'YSK', 'CA', 56.5378, -79.2467, 'Sanikiluaq Arpt', -5);
INSERT INTO public.airports VALUES (4248, 'St Leonard', 'YSL', 'CA', 47.1575, -67.8347, 'Edmunston Arpt', -100);
INSERT INTO public.airports VALUES (4249, 'Ft Smith', 'YSM', 'CA', 60.02028, -111.961945, 'Ft Smith Municipal Arpt', -7);
INSERT INTO public.airports VALUES (4250, 'Salmon Arm', 'YSN', 'CA', 43.1917, -79.1717, 'Salmon Arm Municipal', -100);
INSERT INTO public.airports VALUES (4251, 'Postville', 'YSO', 'CA', 54.91028, -59.78528, 'Postville Arpt', -4);
INSERT INTO public.airports VALUES (4252, 'Marathon', 'YSP', 'CA', 48.75528, -86.344444, 'Marathon Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4253, 'St Theris Point', 'YST', 'CA', 53.8456, -94.8519, 'St Therese Pt Municipal', -6);
INSERT INTO public.airports VALUES (4254, 'Pembroke', 'YTA', 'CA', 45.8644, -77.2517, 'Pembroke And Area', -5);
INSERT INTO public.airports VALUES (4255, 'Thicket Portage', 'YTD', 'CA', 55.3189, -97.7078, 'Thicket Portage Rail Station', -100);
INSERT INTO public.airports VALUES (4256, 'Cape Dorset', 'YTE', 'CA', 64.23, -76.526665, 'Cape Dorset Arpt', -5);
INSERT INTO public.airports VALUES (4257, 'Alma', 'YTF', 'CA', 48.50861, -71.64139, 'Alma Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4258, 'Thompson', 'YTH', 'CA', 55.80111, -97.86417, 'Thompson Arpt', -6);
INSERT INTO public.airports VALUES (4259, 'Terrace Bay', 'YTJ', 'CA', 48.8133, -87.0994, 'Terrace Bay Municipal Arpt', -100);
INSERT INTO public.airports VALUES (4260, 'Big Trout', 'YTL', 'CA', 53.8178, -89.8969, 'Big Trout Arpt', -5);
INSERT INTO public.airports VALUES (4261, 'Mont Tremblant', 'YTM', 'CA', 46.409443, -74.78, 'International Airport', -5);
INSERT INTO public.airports VALUES (4262, 'Toronto', 'YBZ', 'CA', 43.64528, -79.380554, 'Toronto Downtown Rail Station', -5);
INSERT INTO public.airports VALUES (4263, 'Toronto', 'YYZ', 'CA', 43.677223, -79.630554, 'Lester B Pearson Intl', -5);
INSERT INTO public.airports VALUES (4264, 'Toronto', 'YTZ', 'CA', 43.6275, -79.396164, 'Toronto City Centre Airport', -5);
INSERT INTO public.airports VALUES (4265, 'Toronto', 'YKZ', 'CA', 43.86222, -79.37, 'Buttonville Arpt', -5);
INSERT INTO public.airports VALUES (4266, 'Toronto', 'XLQ', 'CA', 0, 0, 'Guildwood Rail Station', -100);
INSERT INTO public.airports VALUES (4267, 'Tasiujaq', 'YTQ', 'CA', 58.6678, -69.9558, 'Tasiujaq Arpt', -5);
INSERT INTO public.airports VALUES (4268, 'Trenton', 'YTR', 'CA', 44.11889, -77.52805, 'Trenton Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4269, 'Timmins', 'YTS', 'CA', 48.56972, -81.37666, 'Timmins Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4270, 'Umiujaq', 'YUD', 'CA', 56.5361, -76.5183, 'Umiujaq Arpt', -5);
INSERT INTO public.airports VALUES (4271, 'Yuma', 'YUM', 'US', 32.656578, -114.60598, 'Yuma Intl', -7);
INSERT INTO public.airports VALUES (4272, 'Hall Beach', 'YUX', 'CA', 68.77611, -81.243614, 'Hall Beach Arpt', -5);
INSERT INTO public.airports VALUES (4273, 'Rouyn Noranda', 'YUY', 'CA', 48.206112, -78.835556, 'Rouyn Noranda Arpt', -5);
INSERT INTO public.airports VALUES (4274, 'Moroni', 'YVA', 'KM', -11.7108, 43.2439, 'Iconi Arpt', 3);
INSERT INTO public.airports VALUES (4275, 'Moroni', 'HAH', 'KM', -11.533661, 43.27185, 'Prince Said Ibrahim In', 3);
INSERT INTO public.airports VALUES (4276, 'Bonaventure', 'YVB', 'CA', 48.0711, -65.4603, 'Municipal Bonaventure', -4);
INSERT INTO public.airports VALUES (4277, 'Vernon', 'YVE', 'CA', 50.25, -119.3333, 'Vernon Municipal Arpt', -100);
INSERT INTO public.airports VALUES (4278, 'Vermilion', 'YVG', 'CA', 53.35583, -110.82389, 'Vermilion Arpt', -7);
INSERT INTO public.airports VALUES (4279, 'Qikiqtarjuaq', 'YVM', 'CA', 67.54583, -64.03139, 'Qikiqtarjuaq Arpt', -5);
INSERT INTO public.airports VALUES (4280, 'Val D Or', 'YVO', 'CA', 48.053333, -77.782776, 'Val d Or Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4281, 'Kuujjuaq', 'YVP', 'CA', 58.09611, -68.42694, 'Kuujjuaq Arpt', -5);
INSERT INTO public.airports VALUES (4282, 'Norman Wells', 'YVQ', 'CA', 65.28162, -126.79822, 'Norman Wells Municipal Arpt', -7);
INSERT INTO public.airports VALUES (4283, 'Vancouver', 'YVR', 'CA', 49.19389, -123.18444, 'Vancouver Intl Arpt', -8);
INSERT INTO public.airports VALUES (4284, 'Vancouver', 'YDT', 'CA', 49.07389, -123.0075, 'Boundary Bay Arpt', -8);
INSERT INTO public.airports VALUES (4285, 'Vancouver', 'CXH', 'CA', 49.289722, -123.11583, 'Coal Harbor Sea Plane Arpt', -8);
INSERT INTO public.airports VALUES (4286, 'Vancouver', 'XEA', 'CA', 0, 0, 'Vancouver Rail Station', -100);
INSERT INTO public.airports VALUES (4287, 'Deer Lake', 'YVZ', 'CA', 52.6558, -94.0614, 'Deer Lake Arpt', -6);
INSERT INTO public.airports VALUES (4288, 'Kangiqsujuaq', 'YWB', 'CA', 61.58861, -71.92944, 'Kangiqsujuaq Arpt', -6);
INSERT INTO public.airports VALUES (4289, 'Winnipeg', 'XEF', 'CA', 49.8889, -97.1342, 'Winnipeg Rail Station', -6);
INSERT INTO public.airports VALUES (4290, 'Winnipeg', 'YWG', 'CA', 49.910034, -97.23988, 'Winnipeg Intl Arpt', -6);
INSERT INTO public.airports VALUES (4291, 'Wabush', 'YWK', 'CA', 52.921944, -66.86444, 'Wabush Arpt', -4);
INSERT INTO public.airports VALUES (4292, 'Williams Lake', 'YWL', 'CA', 52.183056, -122.05417, 'Williams Lake Municipal', -8);
INSERT INTO public.airports VALUES (4293, 'White River', 'YWR', 'CA', 0, 0, 'White River Rail Station', -100);
INSERT INTO public.airports VALUES (4294, 'Whistler', 'YWS', 'CA', 50.1436, -122.949, 'Whistler Arpt', -8);
INSERT INTO public.airports VALUES (4295, 'Cranbrook', 'YXC', 'CA', 49.61222, -115.781944, 'Cranbrook Municipal', -7);
INSERT INTO public.airports VALUES (4296, 'Saskatoon', 'YKY', 'CA', 51.5175, -109.18083, 'Kindersley Arpt', -6);
INSERT INTO public.airports VALUES (4297, 'Saskatoon', 'YXE', 'CA', 52.170834, -106.69972, 'Saskatoon Municipal', -6);
INSERT INTO public.airports VALUES (4298, 'Medicine Hat', 'YXH', 'CA', 50.01889, -110.72083, 'Medicine Hat Airport', -7);
INSERT INTO public.airports VALUES (4299, 'Ft St John', 'YXJ', 'CA', 56.238056, -120.74028, 'Ft St John Municipal Arpt', -8);
INSERT INTO public.airports VALUES (4300, 'Rimouski', 'YXK', 'CA', 48.478058, -68.49694, 'Rimouski Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4301, 'Sioux Lookout', 'YXL', 'CA', 50.113888, -91.90528, 'Sioux Lookout Arpt', -6);
INSERT INTO public.airports VALUES (4302, 'Whale Cove', 'YXN', 'CA', 62.24, -92.5981, 'Whale Cove Arpt', -6);
INSERT INTO public.airports VALUES (4303, 'Pangnirtung', 'YXP', 'CA', 66.145, -65.71361, 'Pangnirtung Arpt', -5);
INSERT INTO public.airports VALUES (4304, 'Prince George', 'XDV', 'CA', 0, 0, 'Prince George Rail Station', -100);
INSERT INTO public.airports VALUES (4305, 'Prince George', 'YXS', 'CA', 53.889442, -122.67889, 'Prince George Municipal', -8);
INSERT INTO public.airports VALUES (4306, 'Terrace', 'YXT', 'CA', 54.46851, -128.57622, 'Terrace Municipal Arpt', -8);
INSERT INTO public.airports VALUES (4307, 'London', 'XDQ', 'CA', 0, 0, 'London Rail Station', -100);
INSERT INTO public.airports VALUES (4308, 'London', 'YXU', 'CA', 43.033054, -81.15111, 'London Municipal', -5);
INSERT INTO public.airports VALUES (4309, 'Abbotsford', 'YXX', 'CA', 49.025276, -122.36056, 'Abbotsford Arpt', -8);
INSERT INTO public.airports VALUES (4310, 'Whitehorse', 'YXY', 'CA', 60.709553, -135.06728, 'Whitehorse Arpt', -8);
INSERT INTO public.airports VALUES (4311, 'Wawa', 'YXZ', 'CA', 47.966946, -84.78639, 'Municipal Wawa', -5);
INSERT INTO public.airports VALUES (4312, 'North Bay', 'YYB', 'CA', 46.36361, -79.422775, 'North Bay Municipal', -5);
INSERT INTO public.airports VALUES (4313, 'Calgary', 'YYC', 'CA', 51.113888, -114.02028, 'Calgary Intl Arpt', -7);
INSERT INTO public.airports VALUES (4314, 'Calgary', 'YQF', 'CA', 52.18222, -113.89445, 'Red Deer Arpt', -7);
INSERT INTO public.airports VALUES (4315, 'Smithers', 'YYD', 'CA', 54.824722, -127.18278, 'Smithers Municipal', -8);
INSERT INTO public.airports VALUES (4316, 'Fort Nelson', 'YYE', 'CA', 58.836388, -122.59695, 'Ft Nelson Municipal Arpt', -8);
INSERT INTO public.airports VALUES (4317, 'Penticton', 'YYF', 'CA', 49.463055, -119.60222, 'Penticton Municipal Arpt', -8);
INSERT INTO public.airports VALUES (4318, 'Charlottetown', 'YYG', 'CA', 46.29, -63.121113, 'Charlottetown Municipal', -4);
INSERT INTO public.airports VALUES (4319, 'Taloyoak', 'YYH', 'CA', 69.54667, -93.57667, 'Taloyoak Arpt', -6);
INSERT INTO public.airports VALUES (4320, 'Rivers', 'YYI', 'CA', 0, 0, 'Rivers Rail Station', -100);
INSERT INTO public.airports VALUES (4321, 'Victoria', 'YYJ', 'CA', 48.646942, -123.425835, 'Victoria Intl Arpt', -8);
INSERT INTO public.airports VALUES (4322, 'Victoria', 'YWH', 'CA', 48.42278, -123.3875, 'Inner Harbor Sea Plane Arpt', -8);
INSERT INTO public.airports VALUES (4323, 'Lynn Lake', 'YYL', 'CA', 56.863888, -101.07611, 'Lynn Lake Rail Station', -6);
INSERT INTO public.airports VALUES (4324, 'Swift Current', 'YYN', 'CA', 50.291943, -107.69056, 'Swift Current Arpt', -6);
INSERT INTO public.airports VALUES (4325, 'Churchill', 'XAD', 'CA', 58.76775, -94.17425, 'Churchill Rail Station', -6);
INSERT INTO public.airports VALUES (4326, 'Churchill', 'YYQ', 'CA', 58.739166, -94.065, 'Churchill Arpt', -6);
INSERT INTO public.airports VALUES (4327, 'Goose Bay', 'YYR', 'CA', 53.319168, -60.425835, 'Municipal Goose Bay', -4);
INSERT INTO public.airports VALUES (4328, 'St Johns', 'YYT', 'CA', 47.61861, -52.751945, 'St Johns Arpt', -3);
INSERT INTO public.airports VALUES (4329, 'Kapuskasing', 'YYU', 'CA', 49.41389, -82.4675, 'Japuskasing Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4330, 'Armstromg', 'YYW', 'CA', 50.29028, -88.90972, 'Armstrong Rail Station', -5);
INSERT INTO public.airports VALUES (4331, 'Mont Joli', 'YYY', 'CA', 48.608612, -68.20805, 'Mont Joli Arpt', -5);
INSERT INTO public.airports VALUES (4332, 'Ashcroft', 'YZA', 'CA', 0, 0, 'Ashcroft Rail Station', -100);
INSERT INTO public.airports VALUES (4333, 'Yellowknife', 'YZF', 'CA', 62.462776, -114.44028, 'Yellowknife Arpt', -7);
INSERT INTO public.airports VALUES (4334, 'Salluit', 'YZG', 'CA', 62.1794, -75.6672, 'Salluit Arpt', -5);
INSERT INTO public.airports VALUES (4335, 'Sandspit', 'YZP', 'CA', 53.254333, -131.81383, 'Federal Airport', -8);
INSERT INTO public.airports VALUES (4336, 'Sarnia', 'YZR', 'CA', 42.999443, -82.30889, 'Sarnia Airport', -5);
INSERT INTO public.airports VALUES (4337, 'Sarnia', 'XDX', 'CA', 0, 0, 'Sarina Rail Station', -100);
INSERT INTO public.airports VALUES (4338, 'Coral Harbour', 'YZS', 'CA', 50.330276, -115.87334, 'Coral Harbour Arpt', -7);
INSERT INTO public.airports VALUES (4339, 'Port Hardy', 'YZT', 'CA', 50.680557, -127.36667, 'Port Hardy Municipal', -8);
INSERT INTO public.airports VALUES (4340, 'Sept Iles', 'YZV', 'CA', 50.22333, -66.26556, 'Sept Iles Municipal Arpt', -5);
INSERT INTO public.airports VALUES (4341, 'Greenwood', 'YZX', 'CA', 44.984444, -64.91695, 'Greenwood Arpt', -4);
INSERT INTO public.airports VALUES (4342, 'Trail', 'YZZ', 'CA', 49.055557, -117.60917, 'Trail Arpt', -8);
INSERT INTO public.airports VALUES (4343, 'Zadar', 'ZAD', 'HR', 44.10827, 15.346697, 'Zadar Arpt', 1);
INSERT INTO public.airports VALUES (4344, 'Zagreb', 'ZAG', 'HR', 45.74293, 16.068777, 'Zagreb Arpt', 1);
INSERT INTO public.airports VALUES (4345, 'Valdivia', 'ZAL', 'CL', -39.649956, -73.08611, 'Pichoy', -4);
INSERT INTO public.airports VALUES (4346, 'Cahors', 'ZAO', 'FR', 44.3506, 1.4786, 'Laberandie Arpt', -100);
INSERT INTO public.airports VALUES (4347, 'Zaragoza', 'ZAZ', 'ES', 41.66624, -1.041553, 'Zaragoza Airport', 1);
INSERT INTO public.airports VALUES (4348, 'Jiang Men', 'ZBD', 'CN', 0, 0, 'Jiang Men Ferry', -100);
INSERT INTO public.airports VALUES (4349, 'Bathurst', 'ZBF', 'CA', 47.6297, -65.7389, 'Bathurst Arpt', -4);
INSERT INTO public.airports VALUES (4350, 'Biloela', 'ZBL', 'AU', -24.4, 150.5, 'Biloela Arpt', -100);
INSERT INTO public.airports VALUES (4351, 'Bromont', 'ZBM', 'CA', 45.2908, -72.7414, 'Bromont Regional Arpt', -100);
INSERT INTO public.airports VALUES (4352, 'Atibaia', 'ZBW', 'BR', 0, 0, 'Atibaia Arpt', -100);
INSERT INTO public.airports VALUES (4353, 'Xin Hui', 'ZBZ', 'CN', 0, 0, 'Xin Hui Ferry Arpt', -100);
INSERT INTO public.airports VALUES (4354, 'Zacatecas', 'ZCL', 'MX', 22.897112, -102.68689, 'Zacatecas Airport', -6);
INSERT INTO public.airports VALUES (4355, 'Temuco', 'ZCO', 'CL', -38.76682, -72.6371, 'Manquehue Arpt', -4);
INSERT INTO public.airports VALUES (4356, 'She Kou', 'ZCU', 'CN', 0, 0, 'She Kou Ferry', -100);
INSERT INTO public.airports VALUES (4357, 'Secunda', 'ZEC', 'ZA', 0, 0, 'Secunda Arpt', -100);
INSERT INTO public.airports VALUES (4358, 'Chesterfield', 'ZFI', 'GB', 0, 0, 'Chesterfield Bus Station', -100);
INSERT INTO public.airports VALUES (4359, 'Philadelphia Rail Station', 'ZFV', 'US', 39.9557, -75.182, 'Philadelphia Rail Station', -5);
INSERT INTO public.airports VALUES (4360, 'Gethsemanie', 'ZGS', 'CA', 50.333, -60.667, 'Gethsemanie Arpt', -100);
INSERT INTO public.airports VALUES (4361, 'Zhangjiang', 'ZHA', 'CN', 21.2144, 110.358, 'Zhanjiang Airport', 8);
INSERT INTO public.airports VALUES (4362, 'Houston', 'ZHO', 'CA', 0, 0, 'Houston Bus Station', -100);
INSERT INTO public.airports VALUES (4363, 'Ziguinchor', 'ZIG', 'SN', 12.555617, -16.281782, 'Ziguinchor Arpt', 0);
INSERT INTO public.airports VALUES (4364, 'Zihuatanejo', 'ZIH', 'MX', 17.601568, -101.46053, 'Zihuatanejo Intl', -6);
INSERT INTO public.airports VALUES (4365, 'Swan River', 'ZJN', 'CA', 52.1206, -101.236, 'Swan River Municipal Arpt', -6);
INSERT INTO public.airports VALUES (4366, 'Kegaska', 'ZKG', 'CA', 50.19583, -61.265835, 'Kegaska Arpt', -4);
INSERT INTO public.airports VALUES (4367, 'Manzanillo', 'ZLO', 'MX', 19.144777, -104.55863, 'Manzanillo Arpt', -6);
INSERT INTO public.airports VALUES (4368, 'La Tabatiere', 'ZLT', 'CA', 50.8308, -58.9756, 'La Tabatiere Arpt', -4);
INSERT INTO public.airports VALUES (4369, 'Newman', 'ZNE', 'AU', -23.4178, 119.803, 'Newman Airport', 8);
INSERT INTO public.airports VALUES (4370, 'Ingolstadt', 'IGS', 'DE', 48.7777, 11.422, 'Ingolstadt Arpt', 1);
INSERT INTO public.airports VALUES (4371, 'Zanzibar', 'ZNZ', 'TZ', -6.222025, 39.224888, 'Kisauni Arpt', 3);
INSERT INTO public.airports VALUES (4372, 'Osorno', 'ZOS', 'CL', -40.61121, -73.06104, 'Canal Balo Arpt', -4);
INSERT INTO public.airports VALUES (4373, 'Pucon', 'ZPC', 'CL', -39.2928, -71.9159, 'Pucon Arpt', -4);
INSERT INTO public.airports VALUES (4374, 'Osnabruck', 'ZPE', 'DE', 0, 0, 'Osnabrueck Rail Service', -100);
INSERT INTO public.airports VALUES (4375, 'Reutlingen', 'ZPP', 'DE', 0, 0, 'Rail Station Reutlingen', -100);
INSERT INTO public.airports VALUES (4376, 'Trier', 'ZQF', 'DE', 49.8635, 6.788167, 'Trier Arpt', 1);
INSERT INTO public.airports VALUES (4377, 'Queenstown', 'ZQN', 'NZ', -45.02111, 168.73917, 'Frankton Airport', 12);
INSERT INTO public.airports VALUES (4378, 'Queen Charlotte Island', 'ZQS', 'CA', 0, 0, 'Queen Charlotte Island Arpt', -100);
INSERT INTO public.airports VALUES (4379, 'Zweibruecken', 'ZQW', 'DE', 49.209446, 7.401323, 'Zweibruecken Arpt', 1);
INSERT INTO public.airports VALUES (4380, 'Zurich', 'ZRH', 'CH', 47.46472, 8.549167, 'Zurich Airport', 1);
INSERT INTO public.airports VALUES (4381, 'San Salvador', 'ZSA', 'BS', 24.063274, -74.523964, 'San Salvador Arpt', -5);
INSERT INTO public.airports VALUES (4382, 'St Pierre Dela Reunion', 'ZSE', 'RE', -21.32004, 55.42358, 'St Pierre Dela Reunion Arpt', 5);
INSERT INTO public.airports VALUES (4383, 'Sonneberg', 'ZSG', 'DE', 0, 0, 'Sonneberg Railway Station', -100);
INSERT INTO public.airports VALUES (4384, 'Sandy Lake', 'ZSJ', 'CA', 53.0642, -93.3444, 'Sandy Lake Arpt', -6);
INSERT INTO public.airports VALUES (4385, 'Schwerin', 'SZW', 'DE', 53.427, 11.783436, 'Parchim Arpt', 1);
INSERT INTO public.airports VALUES (4386, 'Tete A La Baleine', 'ZTB', 'CA', 50.6744, -59.3836, 'Tete A La Baleine Arpt', -4);
INSERT INTO public.airports VALUES (4387, 'Zakinthos', 'ZTH', 'GR', 37.750854, 20.88425, 'Zakinthos Arpt', 2);
INSERT INTO public.airports VALUES (4388, 'Zhuhai', 'ZUH', 'CN', 22.0064, 113.376, 'Zhuhai Arpt', 8);
INSERT INTO public.airports VALUES (4389, 'Churchhill Falls', 'ZUM', 'CA', 53.5619, -64.1064, 'Churchhill Falls Arpt', -4);
INSERT INTO public.airports VALUES (4390, 'Drangedal', 'ZVD', 'NO', 0, 0, 'Drangedal Rail Station', -100);
INSERT INTO public.airports VALUES (4391, 'Fauske', 'ZXO', 'NO', 0, 0, 'Fauske Rail Station', -100);
INSERT INTO public.airports VALUES (4392, 'Rygge', 'ZXU', 'NO', 0, 0, 'Rygge Rail Station', -100);
INSERT INTO public.airports VALUES (4393, 'Rade', 'ZXX', 'NO', 0, 0, 'Rade Rail Station', -100);
INSERT INTO public.airports VALUES (4394, 'Zunyi', 'ZYI', 'CN', 0, 0, 'Zunyi Arpt', -100);
INSERT INTO public.airports VALUES (4395, 'Sylhet', 'ZYL', 'BD', 24.963242, 91.86678, 'Sylhet Osmany Arpt', 6);
INSERT INTO public.airports VALUES (4396, 'New York Penn STN', 'ZYP', 'US', 40.7505, -73.9935, 'New York Penn STN', -5);
INSERT INTO public.airports VALUES (4397, 'Vegarshei', 'ZYV', 'NO', 0, 0, 'Vegarshei Rail Station', -100);
INSERT INTO public.airports VALUES (4398, 'Sandvika', 'ZYW', 'NO', 0, 0, 'Sandvika Rail Station', -100);
INSERT INTO public.airports VALUES (4399, 'Marnardal', 'ZYY', 'NO', 0, 0, 'Marnardal Rail Station', -100);
INSERT INTO public.airports VALUES (4400, 'Zanesville', 'ZZV', 'US', 39.9445, -81.8921, 'Zanesville Arpt', -100);
ALTER SEQUENCE public.airports_id_seq RESTART WITH 4401;

INSERT INTO public.domain_entities VALUES (1, 'airline1', 'ROLE_AIRLINE', 'salt-TODO', 'airline1');
INSERT INTO public.domain_entities VALUES (2, 'airline2', 'ROLE_AIRLINE', 'salt-TODO', 'airline2');
INSERT INTO public.domain_entities VALUES (3, 'bank', 'ROLE_BANK', 'salt-TODO', 'bank');
INSERT INTO public.domain_entities VALUES (5, 'giacomo', 'ROLE_USER', 'salt-TODO', 'giacomo@acme.com');
INSERT INTO public.domain_entities VALUES (6, 'andrea', 'ROLE_USER', 'salt-TODO', 'andrea@acme.com');
INSERT INTO public.domain_entities VALUES (7, 'riccardo', 'ROLE_USER', 'salt-TODO', 'riccardo@acme.com');
INSERT INTO public.domain_entities VALUES (8, 'RentGood', 'ROLE_RENT', 'salt-TODO', 'RentGood');
INSERT INTO public.domain_entities VALUES (9, 'JustRent', 'ROLE_RENT', 'salt-TODO', 'JustRent');
ALTER SEQUENCE public.domain_entities_id_seq RESTART WITH 10;

INSERT INTO public.users VALUES (1, 'giacomo@acme.com', 'Giacomo', 'giacomo', 'Vallorani', 5);
INSERT INTO public.users VALUES (2, 'andrea@acme.com', 'Andrea', 'andrea', 'Di Ubaldo', 6);
INSERT INTO public.users VALUES (3, 'riccardo@acme.com', 'Riccardo', 'riccardo', 'Baratin', 7);
ALTER SEQUENCE public.users_id_seq RESTART WITH 4;

INSERT INTO public.airlines VALUES (1, 'http://national-airline:8082', 1);
INSERT INTO public.airlines VALUES (2, 'http://international-airline:8082', 2);
ALTER SEQUENCE public.airlines_id_seq RESTART WITH 3;

INSERT INTO public.banks VALUES (1, 'http://bank:8080', 3, '925461', '1234');
ALTER SEQUENCE public.banks_id_seq RESTART WITH 2;

INSERT INTO public.rent_services VALUES (1, 'Via Mura Anteo Zamboni 7, 40126 Bologna', 'http://rent-service-1:8080', 8);
INSERT INTO public.rent_services VALUES (2, 'Via Giovanni Bovio 31, Pisa (PI)', 'http://rent-service-2:8080', 9);
ALTER SEQUENCE public.rent_services_id_seq RESTART WITH 3;

--
-- Flights data
--

INSERT INTO public.flights_interest VALUES (1, '2021-10-28 12:00:00+02', FALSE, 2221, 3386, 1);
INSERT INTO public.flights_interest VALUES (2, '2021-11-8 12:00:00+02', FALSE, 3386, 2221, 1);
INSERT INTO public.flights_interest VALUES (3, '2021-10-30 12:00:00+02', FALSE, 16, 424, 1);
INSERT INTO public.flights_interest VALUES (4, '2021-10-25 12:00:00+02', FALSE, 424, 16, 1);
-- BLQ-AMS
INSERT INTO public.flights_interest VALUES (5, '2021-10-28 12:00:00+02', FALSE, 16, 391, 1);
INSERT INTO public.flights_interest VALUES (6, '2021-10-30 12:00:00+02', FALSE, 391, 16, 1);
-- BLQ-BOS
INSERT INTO public.flights_interest VALUES (7, '2021-11-28 12:00:00+02', FALSE, 424, 391, 1);
INSERT INTO public.flights_interest VALUES (8, '2021-11-30 12:00:00+02', FALSE, 391, 424, 1);

ALTER SEQUENCE public.flights_interest_id_seq RESTART WITH 9;


INSERT INTO public.users_interests VALUES (1, '2021-10-1 12:00:00+02', 1300, FALSE, 2, 1, 1);
INSERT INTO public.users_interests VALUES (2, '2021-10-25 12:00:00+02', 1500, FALSE, 3, 4, 1);
-- BLQ-AMS
INSERT INTO public.users_interests VALUES (3, '2021-10-25 12:00:00+02', 1500, FALSE, 6, 5, 1);
-- BLQ-BOS
INSERT INTO public.users_interests VALUES (4, '2021-10-25 12:00:00+02', 1300, FALSE, 8, 7, 1);

ALTER SEQUENCE public.users_interests_id_seq RESTART WITH 5;


INSERT INTO public.flights VALUES (2, '2021-10-28 20:00:00+00', FALSE, TRUE, '2021-10-28 13:00:00+00', '2021-10-26 13:00:00+00', 'XEG8F3G1', 200, 1, 2221, 391);
INSERT INTO public.flights VALUES (1, '2021-11-08 20:00:00+00', FALSE, TRUE, '2021-11-08 13:00:00+00', '2021-10-06 13:00:00+00', 'BEGDRG22', 200, 1, 391, 2221);
ALTER SEQUENCE public.flights_id_seq RESTART WITH 3;

INSERT INTO public.generated_offers VALUES (1, FALSE, TRUE, '2021-12-12 14:39:57.388312+00', 'b62c1', 410, 2, 1, 1, FALSE);
ALTER SEQUENCE public.generated_offers_id_seq RESTART WITH 5;
