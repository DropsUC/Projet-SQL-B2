--
-- PostgreSQL database dump
--

\restrict ciRDypEQpPTUISZ6rhqnIUM5l4sMAETspSGrErvdjFNQUs7dGdBgdoHc7tDuZQO

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

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

--
-- TOC entry 230 (class 1255 OID 16583)
-- Name: verif_disponibilite(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verif_disponibilite() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    etat_vehicule VARCHAR;
BEGIN
    -- On va chercher l'état de la voiture concernée par la réservation
    SELECT etat INTO etat_vehicule FROM vehicules WHERE id_vehicule = NEW.id_vehicule;
    
    -- Si la voiture n'est pas 'Disponible', on bloque tout !
    IF etat_vehicule != 'Disponible' THEN
        RAISE EXCEPTION '⛔ INTERDIT : Ce véhicule est % et ne peut pas être réservé !', etat_vehicule;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.verif_disponibilite() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16518)
-- Name: energies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.energies (
    id_energie integer NOT NULL,
    nom_energie character varying(100) NOT NULL
);


ALTER TABLE public.energies OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16517)
-- Name: energies_id_energie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.energies_id_energie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.energies_id_energie_seq OWNER TO postgres;

--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 222
-- Name: energies_id_energie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.energies_id_energie_seq OWNED BY public.energies.id_energie;


--
-- TOC entry 219 (class 1259 OID 16501)
-- Name: import_temp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.import_temp (
    id_temp integer,
    marque_temp character varying(255),
    modele_temp character varying(255),
    annee_temp integer,
    energie_temp character varying(255),
    auto_temp character varying(50),
    immat_temp character varying(50),
    etat_temp character varying(50),
    local_temp character varying(100)
);


ALTER TABLE public.import_temp OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16507)
-- Name: marques; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marques (
    id_marque integer NOT NULL,
    nom_marque character varying(100) NOT NULL
);


ALTER TABLE public.marques OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16506)
-- Name: marques_id_marque_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marques_id_marque_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marques_id_marque_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 220
-- Name: marques_id_marque_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marques_id_marque_seq OWNED BY public.marques.id_marque;


--
-- TOC entry 228 (class 1259 OID 16557)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id_reservation integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone,
    statut character varying(50) DEFAULT 'Terminée'::character varying,
    cout_total numeric(10,2),
    id_utilisateur integer,
    id_vehicule integer
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16556)
-- Name: reservations_id_reservation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_reservation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservations_id_reservation_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 227
-- Name: reservations_id_reservation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_reservation_seq OWNED BY public.reservations.id_reservation;


--
-- TOC entry 226 (class 1259 OID 16547)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id_utilisateur integer NOT NULL,
    nom character varying(100),
    prenom character varying(100),
    email character varying(150),
    ville character varying(100),
    date_inscription date
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16546)
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateurs_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 225
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateurs_id_utilisateur_seq OWNED BY public.utilisateurs.id_utilisateur;


--
-- TOC entry 224 (class 1259 OID 16528)
-- Name: vehicules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicules (
    id_vehicule integer NOT NULL,
    modele character varying(100),
    annee integer,
    autonomie_km integer,
    immatriculation character varying(20),
    etat character varying(50),
    localisation character varying(100),
    id_marque integer,
    id_energie integer
);


ALTER TABLE public.vehicules OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16575)
-- Name: vue_details_reservations; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vue_details_reservations AS
 SELECT r.id_reservation,
    (((u.nom)::text || ' '::text) || (u.prenom)::text) AS client,
    (((m.nom_marque)::text || ' '::text) || (v.modele)::text) AS voiture,
    r.date_debut,
    r.cout_total,
    r.statut
   FROM (((public.reservations r
     JOIN public.utilisateurs u ON ((r.id_utilisateur = u.id_utilisateur)))
     JOIN public.vehicules v ON ((r.id_vehicule = v.id_vehicule)))
     JOIN public.marques m ON ((v.id_marque = m.id_marque)));


ALTER VIEW public.vue_details_reservations OWNER TO postgres;

--
-- TOC entry 4885 (class 2604 OID 16521)
-- Name: energies id_energie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.energies ALTER COLUMN id_energie SET DEFAULT nextval('public.energies_id_energie_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16510)
-- Name: marques id_marque; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marques ALTER COLUMN id_marque SET DEFAULT nextval('public.marques_id_marque_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 16560)
-- Name: reservations id_reservation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id_reservation SET DEFAULT nextval('public.reservations_id_reservation_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16550)
-- Name: utilisateurs id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateurs_id_utilisateur_seq'::regclass);


--
-- TOC entry 5064 (class 0 OID 16518)
-- Dependencies: 223
-- Data for Name: energies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.energies (id_energie, nom_energie) FROM stdin;
1	Electrique
\.


--
-- TOC entry 5060 (class 0 OID 16501)
-- Dependencies: 219
-- Data for Name: import_temp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.import_temp (id_temp, marque_temp, modele_temp, annee_temp, energie_temp, auto_temp, immat_temp, etat_temp, local_temp) FROM stdin;
1	Kia	EV6	2022	Electrique	320	XR-964-LJ	En maintenance	Strasbourg
2	Kia	EV6	2024	Electrique	270	OY-932-RY	En maintenance	Nantes
3	Hyundai	Ioniq 5	2022	Electrique	380	BJ-663-FL	Hors service	Marseille
4	Kia	EV6	2024	Electrique	480	MW-909-XP	Hors service	Montpellier
5	Mercedes	EQA	2021	Electrique	390	UN-317-LM	En maintenance	Lyon
6	Hyundai	Ioniq 5	2024	Electrique	330	PU-953-NB	En maintenance	Montpellier
7	BMW	iX1	2024	Electrique	270	YO-412-AH	Hors service	Toulouse
8	Nissan	Leaf	2024	Electrique	270	SO-650-ZD	Disponible	Lyon
9	Toyota	Proace Electric	2023	Electrique	530	YE-805-LI	En maintenance	Nice
10	Renault	Megane E-Tech	2024	Electrique	550	YE-951-QU	Disponible	Montpellier
11	Citroen	Ami	2024	Electrique	550	WT-751-VN	Disponible	Lyon
12	Mercedes	EQB	2024	Electrique	420	OD-742-GO	En maintenance	Toulouse
13	Volkswagen	ID.5	2022	Electrique	550	KO-197-KW	Hors service	Nantes
14	Mercedes	EQA	2022	Electrique	500	KM-850-ZY	En maintenance	Lille
15	Kia	Soul EV	2024	Electrique	360	TR-567-ZM	Hors service	Nantes
16	Renault	Megane E-Tech	2021	Electrique	590	JR-526-BM	Disponible	Marseille
17	Citroen	Ami	2023	Electrique	340	XF-922-TM	Hors service	Strasbourg
18	Tesla	Model 3	2022	Electrique	270	HU-769-AI	En maintenance	Nice
19	Kia	Soul EV	2022	Electrique	510	IW-415-IT	En service	Toulouse
20	Mercedes	EQA	2022	Electrique	500	IL-910-WY	Disponible	Paris
21	Mercedes	EQB	2023	Electrique	330	FF-812-UQ	En maintenance	Nantes
22	Toyota	Proace Electric	2024	Electrique	320	UD-673-OE	En maintenance	Lyon
23	Mercedes	EQA	2021	Electrique	420	AQ-685-JB	En service	Montpellier
24	Toyota	Proace Electric	2022	Electrique	290	PS-158-WM	En maintenance	Marseille
25	Nissan	Ariya	2021	Electrique	470	WN-898-EP	En maintenance	Bordeaux
26	Volkswagen	ID.4	2023	Electrique	580	XU-837-FD	Disponible	Lille
27	Peugeot	e-308	2023	Electrique	320	ON-875-UO	Hors service	Marseille
28	Toyota	Proace Electric	2023	Electrique	430	GO-836-IU	En maintenance	Nantes
29	Citroen	Ami	2022	Electrique	480	VE-965-UY	Disponible	Lyon
30	Hyundai	Ioniq 5	2024	Electrique	410	UE-921-ED	En maintenance	Nantes
31	Mercedes	EQA	2021	Electrique	450	YA-188-TY	En maintenance	Nice
32	Citroen	Ami	2023	Electrique	340	HV-248-IT	En service	Toulouse
33	Hyundai	Ioniq 5	2022	Electrique	500	TZ-433-HF	En maintenance	Strasbourg
34	Fiat	500e	2021	Electrique	320	NQ-819-BP	Hors service	Lille
35	Fiat	Panda EV	2022	Electrique	540	DW-525-FC	En service	Paris
36	Renault	Zoe	2023	Electrique	300	QC-782-KP	En maintenance	Lyon
37	BMW	iX1	2022	Electrique	400	UG-214-SA	En service	Bordeaux
38	Mercedes	EQB	2021	Electrique	290	IT-929-YS	Hors service	Lyon
39	Nissan	Leaf	2022	Electrique	490	TH-749-AC	En service	Montpellier
40	Tesla	Model 3	2022	Electrique	390	NC-394-CX	Disponible	Paris
41	Volkswagen	ID.4	2023	Electrique	340	HX-598-OS	En maintenance	Strasbourg
42	Citroen	Berlingo EV	2023	Electrique	450	AN-441-ZU	Disponible	Bordeaux
43	Mercedes	EQE	2022	Electrique	520	QN-135-FB	En maintenance	Nice
44	Fiat	500e	2024	Electrique	590	ZO-456-RC	Hors service	Marseille
45	Tesla	Model Y	2022	Electrique	450	HY-708-CY	Hors service	Lille
46	Hyundai	Kona Electric	2023	Electrique	560	AR-624-YF	Hors service	Montpellier
47	Citroen	e-C4	2022	Electrique	420	TW-514-GR	Disponible	Nice
48	Toyota	bZ4X	2021	Electrique	250	SI-389-FD	Disponible	Lyon
49	Toyota	bZ4X	2023	Electrique	320	QI-180-WY	En service	Nantes
50	Renault	Zoe	2024	Electrique	550	SW-740-DO	Hors service	Nice
51	Tesla	Model S	2023	Electrique	340	FF-225-KQ	Hors service	Lille
52	Volkswagen	ID.3	2024	Electrique	480	QS-174-ZR	Disponible	Bordeaux
53	Tesla	Model S	2024	Electrique	260	LP-456-BF	Disponible	Nice
54	Tesla	Model Y	2024	Electrique	410	WE-429-FR	Hors service	Montpellier
55	Peugeot	e-208	2021	Electrique	390	EL-581-UI	Hors service	Montpellier
56	Mercedes	EQE	2021	Electrique	250	RJ-910-JH	En service	Lille
57	Mercedes	EQB	2024	Electrique	540	MM-708-MP	Disponible	Lyon
58	Toyota	bZ4X	2023	Electrique	410	AX-830-FQ	En maintenance	Lille
59	Renault	Megane E-Tech	2022	Electrique	570	TE-356-RM	Hors service	Nantes
60	Nissan	Leaf	2021	Electrique	250	EB-604-AD	En service	Paris
61	Fiat	500e	2021	Electrique	430	SU-704-FB	En service	Montpellier
62	Mercedes	EQE	2022	Electrique	450	VA-230-KN	Hors service	Bordeaux
63	Citroen	Berlingo EV	2023	Electrique	250	AN-425-ZW	Hors service	Marseille
64	Renault	Twingo E-Tech	2024	Electrique	350	KZ-306-XV	Disponible	Bordeaux
65	Tesla	Model 3	2021	Electrique	570	SD-357-YU	Disponible	Montpellier
66	Nissan	Ariya	2023	Electrique	490	FO-267-ZD	En maintenance	Lille
67	Kia	EV6	2022	Electrique	260	LS-696-PV	Disponible	Bordeaux
68	Citroen	Ami	2023	Electrique	310	ZV-338-JX	Hors service	Toulouse
69	Mercedes	EQA	2024	Electrique	480	TC-188-QF	Hors service	Nice
70	Mercedes	EQA	2023	Electrique	360	QD-535-RQ	En service	Paris
71	Fiat	500e	2021	Electrique	260	YW-289-PL	En maintenance	Paris
72	Hyundai	Ioniq 6	2024	Electrique	310	CX-634-XG	Hors service	Bordeaux
73	Peugeot	e-2008	2023	Electrique	550	SE-164-IS	En maintenance	Strasbourg
74	Nissan	Ariya	2023	Electrique	300	SW-661-EL	Hors service	Strasbourg
75	Mercedes	EQA	2021	Electrique	490	FV-360-TH	En maintenance	Marseille
76	Renault	Zoe	2021	Electrique	540	RW-414-YG	Hors service	Lille
77	Toyota	bZ4X	2023	Electrique	350	KE-749-OR	En maintenance	Strasbourg
78	Mercedes	EQE	2021	Electrique	570	EM-599-QD	En service	Toulouse
79	Kia	Soul EV	2023	Electrique	360	YL-392-JL	Hors service	Toulouse
80	Renault	Megane E-Tech	2023	Electrique	340	SW-667-JM	Disponible	Lille
81	Hyundai	Kona Electric	2022	Electrique	400	HO-110-PM	En service	Lille
82	Hyundai	Ioniq 5	2023	Electrique	280	CN-775-SP	Hors service	Bordeaux
83	Tesla	Model 3	2024	Electrique	490	NW-528-XK	Hors service	Nantes
84	Fiat	Panda EV	2021	Electrique	520	PV-742-CK	Hors service	Montpellier
85	Fiat	500e	2021	Electrique	360	WZ-347-FT	En service	Paris
86	Tesla	Model Y	2022	Electrique	330	JX-290-MI	Disponible	Marseille
87	Hyundai	Ioniq 5	2023	Electrique	540	DP-239-MK	Hors service	Lille
88	Kia	EV6	2021	Electrique	300	BP-212-VV	En service	Nantes
89	Citroen	Ami	2021	Electrique	310	WS-948-XM	Disponible	Nice
90	Toyota	Proace Electric	2024	Electrique	400	UO-609-AK	Hors service	Bordeaux
91	Toyota	bZ4X	2022	Electrique	330	DE-120-IL	En maintenance	Nice
92	Nissan	Ariya	2023	Electrique	360	NL-530-PG	En maintenance	Paris
93	Toyota	Proace Electric	2023	Electrique	300	GJ-521-QR	Disponible	Toulouse
94	Citroen	Berlingo EV	2024	Electrique	550	OE-844-KP	En maintenance	Lille
95	Hyundai	Ioniq 6	2021	Electrique	470	HW-712-EI	Hors service	Montpellier
96	Fiat	Panda EV	2021	Electrique	330	TF-251-SI	Disponible	Strasbourg
97	Tesla	Model 3	2023	Electrique	410	ZK-632-LE	En maintenance	Bordeaux
98	Renault	Zoe	2023	Electrique	270	OM-169-MV	En service	Nantes
99	BMW	i4	2022	Electrique	590	ET-620-CS	Hors service	Marseille
100	Kia	Niro EV	2024	Electrique	570	LG-389-OK	Hors service	Bordeaux
101	Peugeot	e-2008	2023	Electrique	490	WI-254-SD	Disponible	Lille
102	Volkswagen	ID.5	2022	Electrique	540	WL-753-WR	Hors service	Lille
103	Kia	Soul EV	2023	Electrique	350	IR-711-JA	En service	Lyon
104	Mercedes	EQE	2021	Electrique	470	RP-199-AS	En maintenance	Montpellier
105	Renault	Megane E-Tech	2021	Electrique	400	XT-498-QA	En maintenance	Montpellier
106	Volkswagen	ID.5	2021	Electrique	290	WG-359-PO	Disponible	Toulouse
107	Mercedes	EQA	2022	Electrique	340	FX-993-XP	Disponible	Lyon
108	Toyota	bZ4X	2024	Electrique	480	MB-368-UO	En maintenance	Lille
109	BMW	iX1	2024	Electrique	290	QL-947-DJ	Hors service	Nantes
110	Citroen	Ami	2023	Electrique	570	BZ-366-UO	Hors service	Nantes
111	Citroen	e-C4	2022	Electrique	260	WJ-620-FG	En maintenance	Montpellier
112	Mercedes	EQA	2023	Electrique	370	RZ-370-NL	Disponible	Toulouse
113	Nissan	Leaf	2024	Electrique	390	BP-234-SK	Disponible	Bordeaux
114	Fiat	Panda EV	2023	Electrique	350	XJ-945-HM	En maintenance	Marseille
115	Mercedes	EQB	2022	Electrique	530	DH-852-NY	Disponible	Marseille
116	Mercedes	EQA	2021	Electrique	280	NK-133-FM	En service	Montpellier
117	BMW	iX1	2024	Electrique	490	WD-869-LS	En maintenance	Toulouse
118	BMW	i4	2024	Electrique	250	ZR-949-AH	Disponible	Paris
119	Nissan	Ariya	2022	Electrique	510	NL-355-NC	En maintenance	Paris
120	Volkswagen	ID.4	2023	Electrique	260	PR-323-VJ	Disponible	Strasbourg
121	Tesla	Model Y	2023	Electrique	360	AE-397-CK	Disponible	Strasbourg
122	Fiat	Panda EV	2024	Electrique	340	FT-670-QN	Hors service	Toulouse
123	Peugeot	e-2008	2021	Electrique	480	PS-782-EL	En maintenance	Montpellier
124	Nissan	Ariya	2023	Electrique	440	DK-304-FY	Hors service	Bordeaux
125	Fiat	Panda EV	2023	Electrique	350	FC-495-SL	En service	Strasbourg
126	Fiat	Panda EV	2024	Electrique	520	VK-465-JT	En maintenance	Nice
127	Mercedes	EQB	2021	Electrique	370	QY-837-UB	En maintenance	Nantes
128	Fiat	Panda EV	2023	Electrique	310	NH-411-OO	Disponible	Montpellier
129	Mercedes	EQB	2022	Electrique	440	LJ-641-IZ	Hors service	Lille
130	Tesla	Model S	2021	Electrique	530	UM-650-SA	Disponible	Lyon
131	Kia	EV6	2022	Electrique	590	RB-458-VO	Hors service	Nantes
132	Mercedes	EQB	2022	Electrique	510	VE-861-VS	Hors service	Lille
133	Mercedes	EQE	2022	Electrique	300	CJ-528-YK	En service	Bordeaux
134	Tesla	Model 3	2024	Electrique	560	SO-450-TY	En maintenance	Marseille
135	Hyundai	Kona Electric	2024	Electrique	250	JL-958-MC	Disponible	Paris
136	Nissan	Ariya	2022	Electrique	450	BL-747-IP	Disponible	Lyon
137	Peugeot	e-308	2024	Electrique	560	IJ-140-LZ	Disponible	Lille
138	Nissan	Leaf	2023	Electrique	530	ME-146-YS	Disponible	Bordeaux
139	Nissan	Ariya	2023	Electrique	360	WU-151-UG	Disponible	Nantes
140	Volkswagen	ID.5	2024	Electrique	370	MN-866-BT	En maintenance	Marseille
141	Tesla	Model 3	2024	Electrique	270	KH-489-MM	En service	Nantes
142	Mercedes	EQE	2024	Electrique	590	ZF-466-DO	En maintenance	Bordeaux
143	Fiat	Panda EV	2024	Electrique	270	RG-111-UB	En maintenance	Paris
144	Peugeot	e-2008	2022	Electrique	420	UT-617-SM	En service	Lille
145	Fiat	Panda EV	2021	Electrique	510	VK-657-DT	Hors service	Bordeaux
146	Tesla	Model 3	2024	Electrique	430	VN-439-QX	En service	Montpellier
147	Kia	Soul EV	2022	Electrique	500	TW-416-PG	En maintenance	Marseille
148	Citroen	Berlingo EV	2022	Electrique	480	XI-615-WE	Hors service	Nantes
149	Citroen	Ami	2024	Electrique	460	AM-438-XO	Hors service	Toulouse
150	Toyota	Proace Electric	2023	Electrique	330	IS-472-XI	En maintenance	Nantes
151	Mercedes	EQE	2022	Electrique	370	VH-124-QD	Disponible	Bordeaux
152	Nissan	Ariya	2022	Electrique	320	UH-682-IO	En maintenance	Marseille
153	Hyundai	Kona Electric	2024	Electrique	500	DE-955-XC	Hors service	Lyon
154	Fiat	500e	2022	Electrique	580	EB-649-OH	En service	Nice
155	Nissan	Ariya	2022	Electrique	560	XN-131-XQ	En maintenance	Nantes
156	Mercedes	EQA	2023	Electrique	290	YT-400-RA	En service	Nantes
157	Peugeot	e-208	2024	Electrique	560	BN-764-CE	En service	Paris
158	Hyundai	Ioniq 6	2023	Electrique	260	MC-203-SW	Disponible	Lyon
159	BMW	iX1	2023	Electrique	480	TH-109-OL	En service	Lyon
160	Mercedes	EQB	2023	Electrique	490	HA-896-FD	En service	Toulouse
161	Toyota	Proace Electric	2023	Electrique	320	IV-986-QN	Disponible	Nantes
162	Mercedes	EQE	2023	Electrique	440	TS-753-YT	Hors service	Nice
163	Mercedes	EQE	2021	Electrique	480	HQ-340-ME	Hors service	Lille
164	Peugeot	e-2008	2023	Electrique	490	TM-569-HA	Disponible	Marseille
165	Toyota	bZ4X	2023	Electrique	440	WK-987-YD	Disponible	Nice
166	Peugeot	e-308	2023	Electrique	490	UD-306-PX	Hors service	Nantes
167	Kia	EV6	2021	Electrique	280	BU-389-QH	En service	Nice
168	Renault	Twingo E-Tech	2024	Electrique	260	SV-706-SJ	En service	Lille
169	Volkswagen	ID.3	2022	Electrique	300	OI-419-ZT	En service	Lyon
170	Peugeot	e-2008	2024	Electrique	480	LN-599-UP	En maintenance	Lille
171	Tesla	Model Y	2024	Electrique	560	GD-271-MQ	Disponible	Toulouse
172	Fiat	Panda EV	2022	Electrique	500	PF-512-MT	En service	Lille
173	Volkswagen	ID.4	2022	Electrique	350	SB-817-VP	En service	Toulouse
174	Peugeot	e-208	2021	Electrique	330	VY-619-MP	En service	Marseille
175	BMW	i4	2023	Electrique	330	DR-314-DR	Hors service	Bordeaux
176	Fiat	Panda EV	2021	Electrique	270	JY-869-HY	Disponible	Nantes
177	Kia	Niro EV	2024	Electrique	340	QJ-391-VO	En service	Lille
178	Renault	Twingo E-Tech	2023	Electrique	340	SB-797-MR	En maintenance	Toulouse
179	Kia	Niro EV	2023	Electrique	420	AX-470-KN	En maintenance	Strasbourg
180	BMW	iX1	2023	Electrique	420	KM-572-NJ	En service	Marseille
181	Renault	Megane E-Tech	2021	Electrique	520	PU-577-ZZ	En maintenance	Lyon
182	Hyundai	Ioniq 6	2024	Electrique	250	TZ-622-EA	En maintenance	Toulouse
183	Toyota	Proace Electric	2022	Electrique	570	EH-429-CM	Disponible	Lille
184	Volkswagen	ID.3	2023	Electrique	410	OS-980-AT	En maintenance	Toulouse
185	Tesla	Model 3	2022	Electrique	480	TI-895-UI	En maintenance	Lyon
186	Tesla	Model Y	2022	Electrique	290	NN-119-YJ	Disponible	Nantes
187	Volkswagen	ID.3	2023	Electrique	450	RV-850-FT	Hors service	Montpellier
188	Peugeot	e-2008	2022	Electrique	310	UX-407-TO	Disponible	Nantes
189	Volkswagen	ID.3	2024	Electrique	540	FZ-415-DG	En service	Toulouse
190	Renault	Twingo E-Tech	2024	Electrique	550	BH-615-AM	Hors service	Marseille
191	Volkswagen	ID.4	2024	Electrique	540	VP-134-EA	Hors service	Nice
192	Volkswagen	ID.3	2024	Electrique	550	UJ-309-EH	En maintenance	Nantes
193	Fiat	500e	2024	Electrique	370	KT-363-MD	En service	Nice
194	Hyundai	Ioniq 6	2021	Electrique	410	BK-529-UC	Disponible	Strasbourg
195	Mercedes	EQB	2023	Electrique	590	EJ-848-ZK	Hors service	Strasbourg
196	BMW	iX1	2021	Electrique	550	OS-817-PA	En maintenance	Lyon
197	Renault	Zoe	2021	Electrique	480	LO-729-ZR	En service	Lyon
198	Peugeot	e-2008	2021	Electrique	470	XD-909-AR	En service	Lille
199	Citroen	e-C4	2024	Electrique	460	HO-747-OR	Hors service	Nice
200	Citroen	e-C4	2022	Electrique	580	XE-564-VB	Disponible	Nice
\.


--
-- TOC entry 5062 (class 0 OID 16507)
-- Dependencies: 221
-- Data for Name: marques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marques (id_marque, nom_marque) FROM stdin;
1	Peugeot
2	Mercedes
3	Tesla
4	Renault
5	Kia
6	Fiat
7	Nissan
8	Hyundai
9	Citroen
10	BMW
11	Volkswagen
12	Toyota
\.


--
-- TOC entry 5069 (class 0 OID 16557)
-- Dependencies: 228
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id_reservation, date_debut, date_fin, statut, cout_total, id_utilisateur, id_vehicule) FROM stdin;
1	2025-01-01 08:00:00	2025-01-01 18:00:00	Terminée	45.50	1	12
2	2025-01-02 09:30:00	2025-01-02 11:30:00	Terminée	15.00	2	45
3	2025-01-03 14:00:00	2025-01-05 10:00:00	Terminée	120.00	3	8
4	2025-01-04 07:00:00	2025-01-04 08:00:00	Terminée	12.50	4	150
5	2025-01-05 10:00:00	2025-01-05 12:00:00	Annulée	0.00	5	22
6	2025-01-06 08:00:00	2025-01-06 20:00:00	En cours	60.00	6	78
7	2025-01-07 13:00:00	2025-01-07 14:30:00	Terminée	18.00	7	33
8	2025-01-08 09:00:00	2025-01-10 18:00:00	Terminée	210.00	8	99
9	2025-01-09 15:00:00	2025-01-09 16:00:00	Terminée	10.00	9	5
10	2025-01-10 08:00:00	2025-01-12 20:00:00	En cours	150.00	10	180
\.


--
-- TOC entry 5067 (class 0 OID 16547)
-- Dependencies: 226
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id_utilisateur, nom, prenom, email, ville, date_inscription) FROM stdin;
1	Dupont	Marie	marie.dupont@email.com	Paris	2024-01-15
2	Martin	Lucas	lucas.martin@email.com	Lyon	2024-02-20
3	Bernard	Sophie	sophie.bernard@email.com	Marseille	2024-03-10
4	Petit	Thomas	thomas.petit@email.com	Lille	2024-04-05
5	Robert	Julie	julie.robert@email.com	Nantes	2024-05-12
6	Richard	Alex	alex.richard@email.com	Bordeaux	2024-06-18
7	Durand	Emma	emma.durand@email.com	Toulouse	2024-07-22
8	Leroy	Hugo	hugo.leroy@email.com	Strasbourg	2024-08-30
9	Moreau	Chloe	chloe.moreau@email.com	Nice	2024-09-14
10	Simon	Leo	leo.simon@email.com	Montpellier	2024-10-01
\.


--
-- TOC entry 5065 (class 0 OID 16528)
-- Dependencies: 224
-- Data for Name: vehicules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicules (id_vehicule, modele, annee, autonomie_km, immatriculation, etat, localisation, id_marque, id_energie) FROM stdin;
9	Proace Electric	2023	530	YE-805-LI	En maintenance	Nice	12	1
22	Proace Electric	2024	320	UD-673-OE	En maintenance	Lyon	12	1
24	Proace Electric	2022	290	PS-158-WM	En maintenance	Marseille	12	1
28	Proace Electric	2023	430	GO-836-IU	En maintenance	Nantes	12	1
48	bZ4X	2021	250	SI-389-FD	Disponible	Lyon	12	1
49	bZ4X	2023	320	QI-180-WY	En service	Nantes	12	1
58	bZ4X	2023	410	AX-830-FQ	En maintenance	Lille	12	1
77	bZ4X	2023	350	KE-749-OR	En maintenance	Strasbourg	12	1
90	Proace Electric	2024	400	UO-609-AK	Hors service	Bordeaux	12	1
91	bZ4X	2022	330	DE-120-IL	En maintenance	Nice	12	1
93	Proace Electric	2023	300	GJ-521-QR	Disponible	Toulouse	12	1
108	bZ4X	2024	480	MB-368-UO	En maintenance	Lille	12	1
150	Proace Electric	2023	330	IS-472-XI	En maintenance	Nantes	12	1
161	Proace Electric	2023	320	IV-986-QN	Disponible	Nantes	12	1
165	bZ4X	2023	440	WK-987-YD	Disponible	Nice	12	1
183	Proace Electric	2022	570	EH-429-CM	Disponible	Lille	12	1
13	ID.5	2022	550	KO-197-KW	Hors service	Nantes	11	1
26	ID.4	2023	580	XU-837-FD	Disponible	Lille	11	1
41	ID.4	2023	340	HX-598-OS	En maintenance	Strasbourg	11	1
52	ID.3	2024	480	QS-174-ZR	Disponible	Bordeaux	11	1
102	ID.5	2022	540	WL-753-WR	Hors service	Lille	11	1
106	ID.5	2021	290	WG-359-PO	Disponible	Toulouse	11	1
120	ID.4	2023	260	PR-323-VJ	Disponible	Strasbourg	11	1
140	ID.5	2024	370	MN-866-BT	En maintenance	Marseille	11	1
169	ID.3	2022	300	OI-419-ZT	En service	Lyon	11	1
173	ID.4	2022	350	SB-817-VP	En service	Toulouse	11	1
184	ID.3	2023	410	OS-980-AT	En maintenance	Toulouse	11	1
187	ID.3	2023	450	RV-850-FT	Hors service	Montpellier	11	1
189	ID.3	2024	540	FZ-415-DG	En service	Toulouse	11	1
191	ID.4	2024	540	VP-134-EA	Hors service	Nice	11	1
192	ID.3	2024	550	UJ-309-EH	En maintenance	Nantes	11	1
7	iX1	2024	270	YO-412-AH	Hors service	Toulouse	10	1
37	iX1	2022	400	UG-214-SA	En service	Bordeaux	10	1
99	i4	2022	590	ET-620-CS	Hors service	Marseille	10	1
109	iX1	2024	290	QL-947-DJ	Hors service	Nantes	10	1
117	iX1	2024	490	WD-869-LS	En maintenance	Toulouse	10	1
118	i4	2024	250	ZR-949-AH	Disponible	Paris	10	1
159	iX1	2023	480	TH-109-OL	En service	Lyon	10	1
175	i4	2023	330	DR-314-DR	Hors service	Bordeaux	10	1
180	iX1	2023	420	KM-572-NJ	En service	Marseille	10	1
196	iX1	2021	550	OS-817-PA	En maintenance	Lyon	10	1
11	Ami	2024	550	WT-751-VN	Disponible	Lyon	9	1
17	Ami	2023	340	XF-922-TM	Hors service	Strasbourg	9	1
29	Ami	2022	480	VE-965-UY	Disponible	Lyon	9	1
32	Ami	2023	340	HV-248-IT	En service	Toulouse	9	1
42	Berlingo EV	2023	450	AN-441-ZU	Disponible	Bordeaux	9	1
47	e-C4	2022	420	TW-514-GR	Disponible	Nice	9	1
63	Berlingo EV	2023	250	AN-425-ZW	Hors service	Marseille	9	1
68	Ami	2023	310	ZV-338-JX	Hors service	Toulouse	9	1
89	Ami	2021	310	WS-948-XM	Disponible	Nice	9	1
94	Berlingo EV	2024	550	OE-844-KP	En maintenance	Lille	9	1
110	Ami	2023	570	BZ-366-UO	Hors service	Nantes	9	1
111	e-C4	2022	260	WJ-620-FG	En maintenance	Montpellier	9	1
148	Berlingo EV	2022	480	XI-615-WE	Hors service	Nantes	9	1
149	Ami	2024	460	AM-438-XO	Hors service	Toulouse	9	1
199	e-C4	2024	460	HO-747-OR	Hors service	Nice	9	1
200	e-C4	2022	580	XE-564-VB	Disponible	Nice	9	1
3	Ioniq 5	2022	380	BJ-663-FL	Hors service	Marseille	8	1
6	Ioniq 5	2024	330	PU-953-NB	En maintenance	Montpellier	8	1
30	Ioniq 5	2024	410	UE-921-ED	En maintenance	Nantes	8	1
33	Ioniq 5	2022	500	TZ-433-HF	En maintenance	Strasbourg	8	1
46	Kona Electric	2023	560	AR-624-YF	Hors service	Montpellier	8	1
72	Ioniq 6	2024	310	CX-634-XG	Hors service	Bordeaux	8	1
81	Kona Electric	2022	400	HO-110-PM	En service	Lille	8	1
82	Ioniq 5	2023	280	CN-775-SP	Hors service	Bordeaux	8	1
87	Ioniq 5	2023	540	DP-239-MK	Hors service	Lille	8	1
95	Ioniq 6	2021	470	HW-712-EI	Hors service	Montpellier	8	1
135	Kona Electric	2024	250	JL-958-MC	Disponible	Paris	8	1
153	Kona Electric	2024	500	DE-955-XC	Hors service	Lyon	8	1
158	Ioniq 6	2023	260	MC-203-SW	Disponible	Lyon	8	1
182	Ioniq 6	2024	250	TZ-622-EA	En maintenance	Toulouse	8	1
194	Ioniq 6	2021	410	BK-529-UC	Disponible	Strasbourg	8	1
8	Leaf	2024	270	SO-650-ZD	Disponible	Lyon	7	1
25	Ariya	2021	470	WN-898-EP	En maintenance	Bordeaux	7	1
39	Leaf	2022	490	TH-749-AC	En service	Montpellier	7	1
60	Leaf	2021	250	EB-604-AD	En service	Paris	7	1
66	Ariya	2023	490	FO-267-ZD	En maintenance	Lille	7	1
74	Ariya	2023	300	SW-661-EL	Hors service	Strasbourg	7	1
92	Ariya	2023	360	NL-530-PG	En maintenance	Paris	7	1
113	Leaf	2024	390	BP-234-SK	Disponible	Bordeaux	7	1
119	Ariya	2022	510	NL-355-NC	En maintenance	Paris	7	1
124	Ariya	2023	440	DK-304-FY	Hors service	Bordeaux	7	1
136	Ariya	2022	450	BL-747-IP	Disponible	Lyon	7	1
138	Leaf	2023	530	ME-146-YS	Disponible	Bordeaux	7	1
139	Ariya	2023	360	WU-151-UG	Disponible	Nantes	7	1
152	Ariya	2022	320	UH-682-IO	En maintenance	Marseille	7	1
155	Ariya	2022	560	XN-131-XQ	En maintenance	Nantes	7	1
34	500e	2021	320	NQ-819-BP	Hors service	Lille	6	1
35	Panda EV	2022	540	DW-525-FC	En service	Paris	6	1
44	500e	2024	590	ZO-456-RC	Hors service	Marseille	6	1
61	500e	2021	430	SU-704-FB	En service	Montpellier	6	1
71	500e	2021	260	YW-289-PL	En maintenance	Paris	6	1
84	Panda EV	2021	520	PV-742-CK	Hors service	Montpellier	6	1
85	500e	2021	360	WZ-347-FT	En service	Paris	6	1
96	Panda EV	2021	330	TF-251-SI	Disponible	Strasbourg	6	1
114	Panda EV	2023	350	XJ-945-HM	En maintenance	Marseille	6	1
122	Panda EV	2024	340	FT-670-QN	Hors service	Toulouse	6	1
125	Panda EV	2023	350	FC-495-SL	En service	Strasbourg	6	1
126	Panda EV	2024	520	VK-465-JT	En maintenance	Nice	6	1
128	Panda EV	2023	310	NH-411-OO	Disponible	Montpellier	6	1
143	Panda EV	2024	270	RG-111-UB	En maintenance	Paris	6	1
145	Panda EV	2021	510	VK-657-DT	Hors service	Bordeaux	6	1
154	500e	2022	580	EB-649-OH	En service	Nice	6	1
172	Panda EV	2022	500	PF-512-MT	En service	Lille	6	1
176	Panda EV	2021	270	JY-869-HY	Disponible	Nantes	6	1
193	500e	2024	370	KT-363-MD	En service	Nice	6	1
1	EV6	2022	320	XR-964-LJ	En maintenance	Strasbourg	5	1
2	EV6	2024	270	OY-932-RY	En maintenance	Nantes	5	1
4	EV6	2024	480	MW-909-XP	Hors service	Montpellier	5	1
15	Soul EV	2024	360	TR-567-ZM	Hors service	Nantes	5	1
19	Soul EV	2022	510	IW-415-IT	En service	Toulouse	5	1
67	EV6	2022	260	LS-696-PV	Disponible	Bordeaux	5	1
79	Soul EV	2023	360	YL-392-JL	Hors service	Toulouse	5	1
88	EV6	2021	300	BP-212-VV	En service	Nantes	5	1
100	Niro EV	2024	570	LG-389-OK	Hors service	Bordeaux	5	1
103	Soul EV	2023	350	IR-711-JA	En service	Lyon	5	1
131	EV6	2022	590	RB-458-VO	Hors service	Nantes	5	1
147	Soul EV	2022	500	TW-416-PG	En maintenance	Marseille	5	1
167	EV6	2021	280	BU-389-QH	En service	Nice	5	1
177	Niro EV	2024	340	QJ-391-VO	En service	Lille	5	1
179	Niro EV	2023	420	AX-470-KN	En maintenance	Strasbourg	5	1
10	Megane E-Tech	2024	550	YE-951-QU	Disponible	Montpellier	4	1
16	Megane E-Tech	2021	590	JR-526-BM	Disponible	Marseille	4	1
36	Zoe	2023	300	QC-782-KP	En maintenance	Lyon	4	1
50	Zoe	2024	550	SW-740-DO	Hors service	Nice	4	1
59	Megane E-Tech	2022	570	TE-356-RM	Hors service	Nantes	4	1
64	Twingo E-Tech	2024	350	KZ-306-XV	Disponible	Bordeaux	4	1
76	Zoe	2021	540	RW-414-YG	Hors service	Lille	4	1
80	Megane E-Tech	2023	340	SW-667-JM	Disponible	Lille	4	1
98	Zoe	2023	270	OM-169-MV	En service	Nantes	4	1
105	Megane E-Tech	2021	400	XT-498-QA	En maintenance	Montpellier	4	1
168	Twingo E-Tech	2024	260	SV-706-SJ	En service	Lille	4	1
178	Twingo E-Tech	2023	340	SB-797-MR	En maintenance	Toulouse	4	1
181	Megane E-Tech	2021	520	PU-577-ZZ	En maintenance	Lyon	4	1
190	Twingo E-Tech	2024	550	BH-615-AM	Hors service	Marseille	4	1
197	Zoe	2021	480	LO-729-ZR	En service	Lyon	4	1
18	Model 3	2022	270	HU-769-AI	En maintenance	Nice	3	1
40	Model 3	2022	390	NC-394-CX	Disponible	Paris	3	1
45	Model Y	2022	450	HY-708-CY	Hors service	Lille	3	1
51	Model S	2023	340	FF-225-KQ	Hors service	Lille	3	1
53	Model S	2024	260	LP-456-BF	Disponible	Nice	3	1
54	Model Y	2024	410	WE-429-FR	Hors service	Montpellier	3	1
65	Model 3	2021	570	SD-357-YU	Disponible	Montpellier	3	1
83	Model 3	2024	490	NW-528-XK	Hors service	Nantes	3	1
86	Model Y	2022	330	JX-290-MI	Disponible	Marseille	3	1
97	Model 3	2023	410	ZK-632-LE	En maintenance	Bordeaux	3	1
121	Model Y	2023	360	AE-397-CK	Disponible	Strasbourg	3	1
130	Model S	2021	530	UM-650-SA	Disponible	Lyon	3	1
134	Model 3	2024	560	SO-450-TY	En maintenance	Marseille	3	1
141	Model 3	2024	270	KH-489-MM	En service	Nantes	3	1
146	Model 3	2024	430	VN-439-QX	En service	Montpellier	3	1
171	Model Y	2024	560	GD-271-MQ	Disponible	Toulouse	3	1
185	Model 3	2022	480	TI-895-UI	En maintenance	Lyon	3	1
186	Model Y	2022	290	NN-119-YJ	Disponible	Nantes	3	1
5	EQA	2021	390	UN-317-LM	En maintenance	Lyon	2	1
12	EQB	2024	420	OD-742-GO	En maintenance	Toulouse	2	1
14	EQA	2022	500	KM-850-ZY	En maintenance	Lille	2	1
20	EQA	2022	500	IL-910-WY	Disponible	Paris	2	1
21	EQB	2023	330	FF-812-UQ	En maintenance	Nantes	2	1
23	EQA	2021	420	AQ-685-JB	En service	Montpellier	2	1
31	EQA	2021	450	YA-188-TY	En maintenance	Nice	2	1
38	EQB	2021	290	IT-929-YS	Hors service	Lyon	2	1
43	EQE	2022	520	QN-135-FB	En maintenance	Nice	2	1
56	EQE	2021	250	RJ-910-JH	En service	Lille	2	1
57	EQB	2024	540	MM-708-MP	Disponible	Lyon	2	1
62	EQE	2022	450	VA-230-KN	Hors service	Bordeaux	2	1
69	EQA	2024	480	TC-188-QF	Hors service	Nice	2	1
70	EQA	2023	360	QD-535-RQ	En service	Paris	2	1
75	EQA	2021	490	FV-360-TH	En maintenance	Marseille	2	1
78	EQE	2021	570	EM-599-QD	En service	Toulouse	2	1
104	EQE	2021	470	RP-199-AS	En maintenance	Montpellier	2	1
107	EQA	2022	340	FX-993-XP	Disponible	Lyon	2	1
112	EQA	2023	370	RZ-370-NL	Disponible	Toulouse	2	1
115	EQB	2022	530	DH-852-NY	Disponible	Marseille	2	1
116	EQA	2021	280	NK-133-FM	En service	Montpellier	2	1
127	EQB	2021	370	QY-837-UB	En maintenance	Nantes	2	1
129	EQB	2022	440	LJ-641-IZ	Hors service	Lille	2	1
132	EQB	2022	510	VE-861-VS	Hors service	Lille	2	1
133	EQE	2022	300	CJ-528-YK	En service	Bordeaux	2	1
142	EQE	2024	590	ZF-466-DO	En maintenance	Bordeaux	2	1
151	EQE	2022	370	VH-124-QD	Disponible	Bordeaux	2	1
156	EQA	2023	290	YT-400-RA	En service	Nantes	2	1
160	EQB	2023	490	HA-896-FD	En service	Toulouse	2	1
162	EQE	2023	440	TS-753-YT	Hors service	Nice	2	1
163	EQE	2021	480	HQ-340-ME	Hors service	Lille	2	1
195	EQB	2023	590	EJ-848-ZK	Hors service	Strasbourg	2	1
27	e-308	2023	320	ON-875-UO	Hors service	Marseille	1	1
55	e-208	2021	390	EL-581-UI	Hors service	Montpellier	1	1
73	e-2008	2023	550	SE-164-IS	En maintenance	Strasbourg	1	1
101	e-2008	2023	490	WI-254-SD	Disponible	Lille	1	1
123	e-2008	2021	480	PS-782-EL	En maintenance	Montpellier	1	1
137	e-308	2024	560	IJ-140-LZ	Disponible	Lille	1	1
144	e-2008	2022	420	UT-617-SM	En service	Lille	1	1
157	e-208	2024	560	BN-764-CE	En service	Paris	1	1
164	e-2008	2023	490	TM-569-HA	Disponible	Marseille	1	1
166	e-308	2023	490	UD-306-PX	Hors service	Nantes	1	1
170	e-2008	2024	480	LN-599-UP	En maintenance	Lille	1	1
174	e-208	2021	330	VY-619-MP	En service	Marseille	1	1
188	e-2008	2022	310	UX-407-TO	Disponible	Nantes	1	1
198	e-2008	2021	470	XD-909-AR	En service	Lille	1	1
\.


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 222
-- Name: energies_id_energie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.energies_id_energie_seq', 1, true);


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 220
-- Name: marques_id_marque_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marques_id_marque_seq', 12, true);


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 227
-- Name: reservations_id_reservation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_reservation_seq', 11, true);


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 225
-- Name: utilisateurs_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateurs_id_utilisateur_seq', 10, true);


--
-- TOC entry 4894 (class 2606 OID 16527)
-- Name: energies energies_nom_energie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.energies
    ADD CONSTRAINT energies_nom_energie_key UNIQUE (nom_energie);


--
-- TOC entry 4896 (class 2606 OID 16525)
-- Name: energies energies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.energies
    ADD CONSTRAINT energies_pkey PRIMARY KEY (id_energie);


--
-- TOC entry 4890 (class 2606 OID 16516)
-- Name: marques marques_nom_marque_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marques
    ADD CONSTRAINT marques_nom_marque_key UNIQUE (nom_marque);


--
-- TOC entry 4892 (class 2606 OID 16514)
-- Name: marques marques_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marques
    ADD CONSTRAINT marques_pkey PRIMARY KEY (id_marque);


--
-- TOC entry 4906 (class 2606 OID 16564)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id_reservation);


--
-- TOC entry 4902 (class 2606 OID 16555)
-- Name: utilisateurs utilisateurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);


--
-- TOC entry 4904 (class 2606 OID 16553)
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id_utilisateur);


--
-- TOC entry 4898 (class 2606 OID 16535)
-- Name: vehicules vehicules_immatriculation_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicules
    ADD CONSTRAINT vehicules_immatriculation_key UNIQUE (immatriculation);


--
-- TOC entry 4900 (class 2606 OID 16533)
-- Name: vehicules vehicules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicules
    ADD CONSTRAINT vehicules_pkey PRIMARY KEY (id_vehicule);


--
-- TOC entry 4911 (class 2620 OID 16584)
-- Name: reservations trigger_check_dispo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_dispo BEFORE INSERT ON public.reservations FOR EACH ROW EXECUTE FUNCTION public.verif_disponibilite();


--
-- TOC entry 4909 (class 2606 OID 16570)
-- Name: reservations fk_auto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT fk_auto FOREIGN KEY (id_vehicule) REFERENCES public.vehicules(id_vehicule);


--
-- TOC entry 4907 (class 2606 OID 16541)
-- Name: vehicules fk_energie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicules
    ADD CONSTRAINT fk_energie FOREIGN KEY (id_energie) REFERENCES public.energies(id_energie);


--
-- TOC entry 4908 (class 2606 OID 16536)
-- Name: vehicules fk_marque; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicules
    ADD CONSTRAINT fk_marque FOREIGN KEY (id_marque) REFERENCES public.marques(id_marque);


--
-- TOC entry 4910 (class 2606 OID 16565)
-- Name: reservations fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT fk_user FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateurs(id_utilisateur);


-- Completed on 2026-01-07 19:22:02

--
-- PostgreSQL database dump complete
--

\unrestrict ciRDypEQpPTUISZ6rhqnIUM5l4sMAETspSGrErvdjFNQUs7dGdBgdoHc7tDuZQO

