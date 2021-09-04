

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.students DISABLE TRIGGER ALL;

INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('6e8d5f3b-6c5f-43eb-bfad-eef7def28b3d', 'Torvalds', 'Linus', '1858-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('5eb08676-57ec-43af-b7ef-f806aeaac5b4', 'Tannenbaum', 'Andrew', '1858-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('80682c0a-9d8c-408f-92eb-0a5d2fc1ebf8', 'Hejlsberg', 'Anders', '1980-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('ce4cd592-dbbd-4561-b11d-81d79a9e1752', 'Ingalls', 'Dan', '1981-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('a455db86-1218-4411-a6a7-9ebe79fd7c0c', 'Steele', 'Guy', '1980-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('ac749fc6-a091-48bb-87ae-9e25d82b7943', 'Kay', 'Alan', '1982-11-17');
INSERT INTO public.students (id, last_name, first_mid_name, enrollment_date) VALUES ('cdd88c29-ff43-41f0-ae22-4e0d208d7add', 'Stallman', 'Richard', '1985-01-01');


ALTER TABLE public.students ENABLE TRIGGER ALL;


