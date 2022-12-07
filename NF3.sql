-- Database: KioskSystemNF3

-- DROP DATABASE IF EXISTS "KioskSystemNF3";

CREATE DATABASE "KioskSystemNF3"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- SCHEMA: public

-- DROP SCHEMA IF EXISTS public ;

CREATE SCHEMA IF NOT EXISTS public
    AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO pg_database_owner;

-- Table: public.Frequency

-- DROP TABLE IF EXISTS public."Frequency";

CREATE TABLE IF NOT EXISTS public."Frequency"
(
    id integer NOT NULL,
    frequency "char"[] NOT NULL,
    CONSTRAINT "Frequency_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Frequency"
    OWNER to postgres;

-- Table: public.Type

-- DROP TABLE IF EXISTS public."Type";

CREATE TABLE IF NOT EXISTS public."Type"
(
    id integer NOT NULL,
    type "char"[] NOT NULL,
    CONSTRAINT "Type_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Type"
    OWNER to postgres;

-- Table: public.Supplier

-- DROP TABLE IF EXISTS public."Supplier";

CREATE TABLE IF NOT EXISTS public."Supplier"
(
    id integer NOT NULL,
    company "char"[] NOT NULL,
    city "char"[] NOT NULL,
    street "char"[] NOT NULL,
    building "char"[] NOT NULL,
    index "char"[] NOT NULL,
    CONSTRAINT "Supplier_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Supplier"
    OWNER to postgres;

-- Table: public.Item

-- DROP TABLE IF EXISTS public."Item";

CREATE TABLE IF NOT EXISTS public."Item"
(
    id integer NOT NULL,
    name "char"[] NOT NULL,
    supplier_id integer NOT NULL,
    frequency_id integer NOT NULL,
    type_id integer DEFAULT '-1'::integer,
    CONSTRAINT "Item_pkey" PRIMARY KEY (id),
    CONSTRAINT "Item_frequency_id_fkey" FOREIGN KEY (frequency_id)
        REFERENCES public."Frequency" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Item_supplier_id_fkey" FOREIGN KEY (supplier_id)
        REFERENCES public."Supplier" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "Item_type_id_fkey" FOREIGN KEY (type_id)
        REFERENCES public."Type" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Item"
    OWNER to postgres;
-- Index: -1

-- DROP INDEX IF EXISTS public."-1";

CREATE INDEX IF NOT EXISTS "-1"
    ON public."Item" USING btree
    (type_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- Table: public.Kiosk

-- DROP TABLE IF EXISTS public."Kiosk";

CREATE TABLE IF NOT EXISTS public."Kiosk"
(
    id integer NOT NULL,
    index "char"[] NOT NULL,
    city "char"[] NOT NULL,
    street "char"[] NOT NULL,
    building "char"[] NOT NULL,
    name "char"[] NOT NULL,
    CONSTRAINT "Kiosk_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Kiosk"
    OWNER to postgres;


-- Table: public.KioskAndItem

-- DROP TABLE IF EXISTS public."KioskAndItem";

CREATE TABLE IF NOT EXISTS public."KioskAndItem"
(
    kiosk_id integer NOT NULL,
    item_id integer NOT NULL,
    quantity integer NOT NULL,
    price integer NOT NULL,
    suppluer_quantity integer NOT NULL,
    CONSTRAINT "KioskAndItem_item_id_fkey" FOREIGN KEY (item_id)
        REFERENCES public."Item" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT "KioskAndItem_kiosk_id_fkey" FOREIGN KEY (kiosk_id)
        REFERENCES public."Kiosk" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."KioskAndItem"
    OWNER to postgres;