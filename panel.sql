--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6
-- Dumped by pg_dump version 12.1

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

--
-- Name: action_items; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.action_items (
    id integer NOT NULL,
    security_threat_id integer,
    law_firm_id integer,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.action_items OWNER TO manishchhipa1;

--
-- Name: action_items_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.action_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.action_items_id_seq OWNER TO manishchhipa1;

--
-- Name: action_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.action_items_id_seq OWNED BY public.action_items.id;


--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_type character varying,
    author_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.active_admin_comments OWNER TO manishchhipa1;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO manishchhipa1;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.activity_logs (
    id integer NOT NULL,
    law_firm_id integer,
    event_type character varying,
    custom_message character varying,
    loggable_type character varying,
    loggable_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    read boolean,
    notify boolean,
    email character varying,
    source character varying,
    status character varying
);


ALTER TABLE public.activity_logs OWNER TO manishchhipa1;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.activity_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_logs_id_seq OWNER TO manishchhipa1;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: activity_time_logs; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.activity_time_logs (
    id integer NOT NULL,
    network_discovery date,
    penetration_testing date,
    vulnerability_assessment date,
    hardware_refresh date,
    hardware_inventory date,
    software_inventory date,
    form_value_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    network_discovery_never boolean DEFAULT false,
    penetration_testing_never boolean DEFAULT false,
    vulnerability_assessment_never boolean DEFAULT false,
    hardware_refresh_never boolean DEFAULT false,
    hardware_inventory_never boolean DEFAULT false,
    software_inventory_never boolean DEFAULT false
);


ALTER TABLE public.activity_time_logs OWNER TO manishchhipa1;

--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.activity_time_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_time_logs_id_seq OWNER TO manishchhipa1;

--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.activity_time_logs_id_seq OWNED BY public.activity_time_logs.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role character varying
);


ALTER TABLE public.admin_users OWNER TO manishchhipa1;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO manishchhipa1;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO manishchhipa1;

--
-- Name: cloud_providers; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.cloud_providers (
    id integer NOT NULL,
    form_value_id integer,
    name character varying,
    service character varying,
    data_store_location_ca character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cloud_type character varying,
    data character varying,
    encrypted_in_flight character varying,
    encrypted_at_rest character varying
);


ALTER TABLE public.cloud_providers OWNER TO manishchhipa1;

--
-- Name: cloud_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.cloud_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cloud_providers_id_seq OWNER TO manishchhipa1;

--
-- Name: cloud_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.cloud_providers_id_seq OWNED BY public.cloud_providers.id;


--
-- Name: conflict_waivers; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.conflict_waivers (
    id integer NOT NULL,
    name_of_law_firm character varying,
    contact_details character varying,
    bmo_business_contact character varying,
    reason text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    confirm_waiver boolean,
    lxp_status character varying,
    internal_lawyers_status character varying,
    law_firm_id integer,
    assigned_to_id integer
);


ALTER TABLE public.conflict_waivers OWNER TO manishchhipa1;

--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.conflict_waivers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conflict_waivers_id_seq OWNER TO manishchhipa1;

--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.conflict_waivers_id_seq OWNED BY public.conflict_waivers.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    country_id integer,
    name character varying,
    iso character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.countries OWNER TO manishchhipa1;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO manishchhipa1;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: cyber_security_insurances; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.cyber_security_insurances (
    id integer NOT NULL,
    company character varying,
    coverage character varying,
    coverage_amount character varying,
    policy character varying,
    form_value_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    date_of_expiry date,
    standing character varying
);


ALTER TABLE public.cyber_security_insurances OWNER TO manishchhipa1;

--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.cyber_security_insurances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cyber_security_insurances_id_seq OWNER TO manishchhipa1;

--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.cyber_security_insurances_id_seq OWNED BY public.cyber_security_insurances.id;


--
-- Name: cyber_security_standards; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.cyber_security_standards (
    id integer NOT NULL,
    rank character varying,
    standard character varying,
    date_of_certification date,
    renewal date,
    form_value_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying
);


ALTER TABLE public.cyber_security_standards OWNER TO manishchhipa1;

--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.cyber_security_standards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cyber_security_standards_id_seq OWNER TO manishchhipa1;

--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.cyber_security_standards_id_seq OWNED BY public.cyber_security_standards.id;


--
-- Name: dropdown_options; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.dropdown_options (
    id integer NOT NULL,
    key character varying,
    value character varying,
    form_field_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    score double precision DEFAULT 0.0
);


ALTER TABLE public.dropdown_options OWNER TO manishchhipa1;

--
-- Name: dropdown_options_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.dropdown_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dropdown_options_id_seq OWNER TO manishchhipa1;

--
-- Name: dropdown_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.dropdown_options_id_seq OWNED BY public.dropdown_options.id;


--
-- Name: exception_requests; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.exception_requests (
    id integer NOT NULL,
    requested_by character varying,
    user_id integer,
    submitted_by_email character varying,
    line_of_business character varying,
    lob_contact_name character varying,
    law_firm_id integer,
    request_type character varying,
    law_firm_category character varying,
    minority_owned character varying,
    minority_owned_details text,
    women_owned character varying,
    women_owned_details text,
    matter_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    matter_types text,
    law_firm_name character varying,
    business_manager_name character varying,
    business_manager_phone character varying,
    business_manager_email character varying,
    lxp_status character varying,
    lxp_id integer,
    internal_lawyers_status character varying,
    internal_lawyers_id integer,
    docusign_envelope_id character varying,
    pay_type character varying,
    notes text,
    is_work boolean DEFAULT false,
    reason text,
    payer character varying,
    matter_types_search text,
    sub_matter_types_search text,
    jurisdiction_types_search text,
    countries_search text,
    states_search text,
    niche_preferred_external_counsel_panel_law_firms boolean DEFAULT false,
    niche_expertise text,
    required_unique_geography boolean DEFAULT false,
    geographic_location text,
    involved_engagement character varying,
    reson_other text
);


ALTER TABLE public.exception_requests OWNER TO manishchhipa1;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.exception_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exception_requests_id_seq OWNER TO manishchhipa1;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.exception_requests_id_seq OWNED BY public.exception_requests.id;


--
-- Name: faq_categories; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.faq_categories (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.faq_categories OWNER TO manishchhipa1;

--
-- Name: faq_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.faq_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faq_categories_id_seq OWNER TO manishchhipa1;

--
-- Name: faq_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.faq_categories_id_seq OWNED BY public.faq_categories.id;


--
-- Name: file_attachments; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.file_attachments (
    id integer NOT NULL,
    file character varying,
    form_value_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    iv text,
    key text,
    attachable_type character varying,
    attachable_id integer
);


ALTER TABLE public.file_attachments OWNER TO manishchhipa1;

--
-- Name: file_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.file_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_attachments_id_seq OWNER TO manishchhipa1;

--
-- Name: file_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.file_attachments_id_seq OWNED BY public.file_attachments.id;


--
-- Name: follow_ups; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.follow_ups (
    id integer NOT NULL,
    form_submission_id integer,
    loggable_type character varying,
    loggable_id integer,
    status character varying,
    note_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.follow_ups OWNER TO manishchhipa1;

--
-- Name: follow_ups_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.follow_ups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follow_ups_id_seq OWNER TO manishchhipa1;

--
-- Name: follow_ups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.follow_ups_id_seq OWNED BY public.follow_ups.id;


--
-- Name: form_fields; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.form_fields (
    id integer NOT NULL,
    min character varying,
    max character varying,
    required boolean,
    label character varying,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    form_id integer,
    formable_id integer,
    formable_type character varying,
    parent_id integer,
    "position" integer,
    group_form_id integer,
    repeater boolean,
    custom_logic boolean,
    show_when_form_field_id integer,
    show_when_form_field_value character varying,
    scored boolean,
    score double precision,
    help_description text
);


ALTER TABLE public.form_fields OWNER TO manishchhipa1;

--
-- Name: form_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.form_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_fields_id_seq OWNER TO manishchhipa1;

--
-- Name: form_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.form_fields_id_seq OWNED BY public.form_fields.id;


--
-- Name: form_submissions; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.form_submissions (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    form_id integer,
    form_process_id integer,
    submitted boolean DEFAULT false,
    submitted_on timestamp without time zone,
    law_firm_id integer,
    total_score double precision,
    status character varying,
    reason character varying,
    assessor_score double precision,
    system_score double precision,
    expiry_date date,
    locked_by_id integer,
    locked_at timestamp without time zone,
    last_submitted_by_id integer,
    approved_at timestamp without time zone,
    evidence_status character varying,
    form_relationship_id integer,
    form_diversity_id integer,
    form_innovation_id integer,
    form_resourcing_id integer
);


ALTER TABLE public.form_submissions OWNER TO manishchhipa1;

--
-- Name: form_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.form_submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_submissions_id_seq OWNER TO manishchhipa1;

--
-- Name: form_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.form_submissions_id_seq OWNED BY public.form_submissions.id;


--
-- Name: form_values; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.form_values (
    id integer NOT NULL,
    form_field_id integer,
    submittable_id integer,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submittable_type character varying,
    form_field_label character varying,
    file_value character varying,
    checked boolean DEFAULT false,
    form_value_iv character varying,
    form_value_key character varying,
    multi_select_value text
);


ALTER TABLE public.form_values OWNER TO manishchhipa1;

--
-- Name: form_values_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.form_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_values_id_seq OWNER TO manishchhipa1;

--
-- Name: form_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.form_values_id_seq OWNED BY public.form_values.id;


--
-- Name: forms; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.forms (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    group_form boolean,
    step character varying
);


ALTER TABLE public.forms OWNER TO manishchhipa1;

--
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.forms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forms_id_seq OWNER TO manishchhipa1;

--
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.forms_id_seq OWNED BY public.forms.id;


--
-- Name: frequently_asked_questions; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.frequently_asked_questions (
    id integer NOT NULL,
    question character varying,
    answer text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    faq_category_id integer
);


ALTER TABLE public.frequently_asked_questions OWNER TO manishchhipa1;

--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.frequently_asked_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.frequently_asked_questions_id_seq OWNER TO manishchhipa1;

--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.frequently_asked_questions_id_seq OWNED BY public.frequently_asked_questions.id;


--
-- Name: history_submissions; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.history_submissions (
    id integer NOT NULL,
    incident_type character varying,
    impact character varying,
    discovery_time character varying,
    source character varying,
    data_loss character varying,
    incident_details text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    form_submission_id integer,
    checked boolean DEFAULT false
);


ALTER TABLE public.history_submissions OWNER TO manishchhipa1;

--
-- Name: history_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.history_submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_submissions_id_seq OWNER TO manishchhipa1;

--
-- Name: history_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.history_submissions_id_seq OWNED BY public.history_submissions.id;


--
-- Name: information_security_policies; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.information_security_policies (
    id integer NOT NULL,
    policy character varying,
    last_reviewed date,
    last_updated date,
    freq_of_review character varying,
    form_value_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    upload_policy character varying,
    independent_review character varying,
    communication_status character varying
);


ALTER TABLE public.information_security_policies OWNER TO manishchhipa1;

--
-- Name: information_security_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.information_security_policies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.information_security_policies_id_seq OWNER TO manishchhipa1;

--
-- Name: information_security_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.information_security_policies_id_seq OWNED BY public.information_security_policies.id;


--
-- Name: internal_notes; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.internal_notes (
    id integer NOT NULL,
    message text,
    sender_id integer,
    law_firm_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.internal_notes OWNER TO manishchhipa1;

--
-- Name: internal_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.internal_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.internal_notes_id_seq OWNER TO manishchhipa1;

--
-- Name: internal_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.internal_notes_id_seq OWNED BY public.internal_notes.id;


--
-- Name: jurisdiction_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.jurisdiction_types (
    id integer NOT NULL,
    jurisdiction_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.jurisdiction_types OWNER TO manishchhipa1;

--
-- Name: jurisdiction_types_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.jurisdiction_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jurisdiction_types_id_seq OWNER TO manishchhipa1;

--
-- Name: jurisdiction_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.jurisdiction_types_id_seq OWNED BY public.jurisdiction_types.id;


--
-- Name: jurisdictions; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.jurisdictions (
    id integer NOT NULL,
    country character varying,
    city character varying,
    law_firm_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.jurisdictions OWNER TO manishchhipa1;

--
-- Name: jurisdictions_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.jurisdictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jurisdictions_id_seq OWNER TO manishchhipa1;

--
-- Name: jurisdictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.jurisdictions_id_seq OWNED BY public.jurisdictions.id;


--
-- Name: law_firms; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms (
    id integer NOT NULL,
    name character varying,
    description character varying,
    email character varying,
    phone character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    relationship_manager_email character varying,
    law_firm_type character varying,
    parent_company text,
    practice_area character varying,
    sister_firm text,
    principle_name character varying,
    principle_title character varying,
    principle_contact_info text,
    profile_completed boolean DEFAULT false,
    max_users integer,
    public_uid character varying,
    updated_by_lawfirm boolean DEFAULT false,
    initial_date_of_engagement_with_the_bank timestamp without time zone,
    type_of_matters_your_law_firm_handles_for_us text,
    type_of_services_your_law_firm_provides_generally text,
    confidentiality_level_of_matters_that_are_handled text,
    number_of_lawyers character varying,
    relationship_manager_name character varying,
    relationship_manager_phone character varying,
    law_firm_category character varying,
    firm_use_on_regular_basis boolean DEFAULT false
);


ALTER TABLE public.law_firms OWNER TO manishchhipa1;

--
-- Name: law_firms_countries; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms_countries (
    id integer NOT NULL,
    law_firm_id integer,
    country_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.law_firms_countries OWNER TO manishchhipa1;

--
-- Name: law_firms_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.law_firms_countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.law_firms_countries_id_seq OWNER TO manishchhipa1;

--
-- Name: law_firms_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.law_firms_countries_id_seq OWNED BY public.law_firms_countries.id;


--
-- Name: law_firms_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.law_firms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.law_firms_id_seq OWNER TO manishchhipa1;

--
-- Name: law_firms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.law_firms_id_seq OWNED BY public.law_firms.id;


--
-- Name: law_firms_jurisdiction_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms_jurisdiction_types (
    law_firm_id integer,
    jurisdiction_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.law_firms_jurisdiction_types OWNER TO manishchhipa1;

--
-- Name: law_firms_matter_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms_matter_types (
    law_firm_id integer,
    matter_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.law_firms_matter_types OWNER TO manishchhipa1;

--
-- Name: law_firms_states; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms_states (
    id integer NOT NULL,
    law_firm_id integer,
    state_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.law_firms_states OWNER TO manishchhipa1;

--
-- Name: law_firms_states_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.law_firms_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.law_firms_states_id_seq OWNER TO manishchhipa1;

--
-- Name: law_firms_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.law_firms_states_id_seq OWNED BY public.law_firms_states.id;


--
-- Name: law_firms_sub_matter_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.law_firms_sub_matter_types (
    law_firm_id integer,
    sub_matter_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.law_firms_sub_matter_types OWNER TO manishchhipa1;

--
-- Name: locations; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    address1 character varying,
    address2 character varying,
    city character varying,
    province character varying,
    country character varying,
    postal_code character varying,
    law_firm_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO manishchhipa1;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO manishchhipa1;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: logics; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.logics (
    id integer NOT NULL,
    listen_field_id integer,
    change_field_id integer,
    form_id integer,
    logic_to_be_applied character varying,
    "values" character varying,
    perform_action character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.logics OWNER TO manishchhipa1;

--
-- Name: logics_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.logics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logics_id_seq OWNER TO manishchhipa1;

--
-- Name: logics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.logics_id_seq OWNED BY public.logics.id;


--
-- Name: mailboxer_conversation_opt_outs; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.mailboxer_conversation_opt_outs (
    id integer NOT NULL,
    unsubscriber_type character varying,
    unsubscriber_id integer,
    conversation_id integer
);


ALTER TABLE public.mailboxer_conversation_opt_outs OWNER TO manishchhipa1;

--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.mailboxer_conversation_opt_outs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_conversation_opt_outs_id_seq OWNER TO manishchhipa1;

--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.mailboxer_conversation_opt_outs_id_seq OWNED BY public.mailboxer_conversation_opt_outs.id;


--
-- Name: mailboxer_conversations; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.mailboxer_conversations (
    id integer NOT NULL,
    subject character varying DEFAULT ''::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.mailboxer_conversations OWNER TO manishchhipa1;

--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.mailboxer_conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_conversations_id_seq OWNER TO manishchhipa1;

--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.mailboxer_conversations_id_seq OWNED BY public.mailboxer_conversations.id;


--
-- Name: mailboxer_notifications; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.mailboxer_notifications (
    id integer NOT NULL,
    type character varying,
    body text,
    subject character varying DEFAULT ''::character varying,
    sender_type character varying,
    sender_id integer,
    conversation_id integer,
    draft boolean DEFAULT false,
    notification_code character varying,
    notified_object_type character varying,
    notified_object_id integer,
    attachment character varying,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    global boolean DEFAULT false,
    expires timestamp without time zone
);


ALTER TABLE public.mailboxer_notifications OWNER TO manishchhipa1;

--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.mailboxer_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_notifications_id_seq OWNER TO manishchhipa1;

--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.mailboxer_notifications_id_seq OWNED BY public.mailboxer_notifications.id;


--
-- Name: mailboxer_receipts; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.mailboxer_receipts (
    id integer NOT NULL,
    receiver_type character varying,
    receiver_id integer,
    notification_id integer NOT NULL,
    is_read boolean DEFAULT false,
    trashed boolean DEFAULT false,
    deleted boolean DEFAULT false,
    mailbox_type character varying(25),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_delivered boolean DEFAULT false,
    delivery_method character varying,
    message_id character varying
);


ALTER TABLE public.mailboxer_receipts OWNER TO manishchhipa1;

--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.mailboxer_receipts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_receipts_id_seq OWNER TO manishchhipa1;

--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.mailboxer_receipts_id_seq OWNED BY public.mailboxer_receipts.id;


--
-- Name: matter_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.matter_types (
    id integer NOT NULL,
    matter_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.matter_types OWNER TO manishchhipa1;

--
-- Name: matter_types_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.matter_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.matter_types_id_seq OWNER TO manishchhipa1;

--
-- Name: matter_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.matter_types_id_seq OWNED BY public.matter_types.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    law_firm_id integer,
    message_type character varying,
    message text,
    step character varying,
    admin_user_id integer,
    sender character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    form_submission_id integer,
    follow_up_id integer,
    deleted_at timestamp without time zone
);


ALTER TABLE public.notes OWNER TO manishchhipa1;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO manishchhipa1;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: panel_requests; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.panel_requests (
    id integer NOT NULL,
    requested_by character varying,
    user_id integer,
    submitted_by_email character varying,
    line_of_business character varying,
    lob_contact_name character varying,
    law_firm_id integer,
    request_type character varying,
    law_firm_category character varying,
    minority_owned character varying,
    minority_owned_details text,
    women_owned character varying,
    women_owned_details text,
    matter_name character varying,
    matter_types text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    law_firm_name character varying,
    business_manager_name character varying,
    business_manager_phone character varying,
    business_manager_email character varying
);


ALTER TABLE public.panel_requests OWNER TO manishchhipa1;

--
-- Name: panel_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.panel_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.panel_requests_id_seq OWNER TO manishchhipa1;

--
-- Name: panel_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.panel_requests_id_seq OWNED BY public.panel_requests.id;


--
-- Name: queued_notifications; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.queued_notifications (
    id integer NOT NULL,
    trigger_at timestamp without time zone,
    trigger_id integer,
    action_item_id integer,
    triggered boolean DEFAULT false,
    deleted_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    severity_negative_factor double precision
);


ALTER TABLE public.queued_notifications OWNER TO manishchhipa1;

--
-- Name: queued_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.queued_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queued_notifications_id_seq OWNER TO manishchhipa1;

--
-- Name: queued_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.queued_notifications_id_seq OWNED BY public.queued_notifications.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    reviewable_id integer,
    reviewable_type character varying,
    status character varying,
    status_from character varying,
    description text,
    actor_id integer,
    assigned_to_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    pay_type character varying
);


ALTER TABLE public.reviews OWNER TO manishchhipa1;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO manishchhipa1;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO manishchhipa1;

--
-- Name: security_alerts; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.security_alerts (
    id integer NOT NULL,
    title character varying,
    description text,
    severity character varying,
    link character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    alert_date timestamp without time zone
);


ALTER TABLE public.security_alerts OWNER TO manishchhipa1;

--
-- Name: security_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.security_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.security_alerts_id_seq OWNER TO manishchhipa1;

--
-- Name: security_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.security_alerts_id_seq OWNED BY public.security_alerts.id;


--
-- Name: security_threats; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.security_threats (
    id integer NOT NULL,
    title character varying,
    description text,
    severity_level_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    severity_negative_factor double precision,
    vendor text,
    platform text,
    version text,
    service_pack text
);


ALTER TABLE public.security_threats OWNER TO manishchhipa1;

--
-- Name: security_threats_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.security_threats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.security_threats_id_seq OWNER TO manishchhipa1;

--
-- Name: security_threats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.security_threats_id_seq OWNED BY public.security_threats.id;


--
-- Name: severity_levels; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.severity_levels (
    id integer NOT NULL,
    name character varying,
    color character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.severity_levels OWNER TO manishchhipa1;

--
-- Name: severity_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.severity_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.severity_levels_id_seq OWNER TO manishchhipa1;

--
-- Name: severity_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.severity_levels_id_seq OWNED BY public.severity_levels.id;


--
-- Name: shared_bank_informations; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.shared_bank_informations (
    id integer NOT NULL,
    form_value_id integer,
    name character varying,
    purpose character varying,
    level_of_access character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.shared_bank_informations OWNER TO manishchhipa1;

--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.shared_bank_informations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_bank_informations_id_seq OWNER TO manishchhipa1;

--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.shared_bank_informations_id_seq OWNED BY public.shared_bank_informations.id;


--
-- Name: states; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.states (
    id integer NOT NULL,
    name character varying,
    iso character varying,
    country_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.states OWNER TO manishchhipa1;

--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.states_id_seq OWNER TO manishchhipa1;

--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.states_id_seq OWNED BY public.states.id;


--
-- Name: sub_matter_types; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.sub_matter_types (
    id integer NOT NULL,
    sub_matter_type character varying,
    matter_type_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.sub_matter_types OWNER TO manishchhipa1;

--
-- Name: sub_matter_types_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.sub_matter_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sub_matter_types_id_seq OWNER TO manishchhipa1;

--
-- Name: sub_matter_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.sub_matter_types_id_seq OWNED BY public.sub_matter_types.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.system_settings (
    id integer NOT NULL,
    score_threshold double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    docusign_access_token text
);


ALTER TABLE public.system_settings OWNER TO manishchhipa1;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.system_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_settings_id_seq OWNER TO manishchhipa1;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.technologies (
    id integer NOT NULL,
    vendor character varying,
    platform character varying,
    version character varying,
    service_pack character varying,
    supported character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    platform_category character varying,
    platform_type character varying
);


ALTER TABLE public.technologies OWNER TO manishchhipa1;

--
-- Name: technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.technologies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technologies_id_seq OWNER TO manishchhipa1;

--
-- Name: technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.technologies_id_seq OWNED BY public.technologies.id;


--
-- Name: technology_values; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.technology_values (
    id integer NOT NULL,
    platform_category character varying,
    platform_type character varying,
    vendor character varying,
    platform character varying,
    version character varying,
    service_pack character varying,
    supported character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    law_firm_id integer,
    form_submission_id integer,
    technology_id integer,
    checked boolean DEFAULT false
);


ALTER TABLE public.technology_values OWNER TO manishchhipa1;

--
-- Name: technology_values_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.technology_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technology_values_id_seq OWNER TO manishchhipa1;

--
-- Name: technology_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.technology_values_id_seq OWNED BY public.technology_values.id;


--
-- Name: third_party_vendors; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.third_party_vendors (
    id integer NOT NULL,
    form_value_id integer,
    vendor_name character varying,
    area character varying,
    confidentiality_agreement character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.third_party_vendors OWNER TO manishchhipa1;

--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.third_party_vendors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.third_party_vendors_id_seq OWNER TO manishchhipa1;

--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.third_party_vendors_id_seq OWNED BY public.third_party_vendors.id;


--
-- Name: todo_tasks; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.todo_tasks (
    id integer NOT NULL,
    law_firm_id integer,
    title character varying,
    message character varying,
    severity character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.todo_tasks OWNER TO manishchhipa1;

--
-- Name: todo_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.todo_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todo_tasks_id_seq OWNER TO manishchhipa1;

--
-- Name: todo_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.todo_tasks_id_seq OWNED BY public.todo_tasks.id;


--
-- Name: triggers; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.triggers (
    id integer NOT NULL,
    hours integer,
    action_type character varying,
    message character varying,
    severity_level_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.triggers OWNER TO manishchhipa1;

--
-- Name: triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.triggers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.triggers_id_seq OWNER TO manishchhipa1;

--
-- Name: triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.triggers_id_seq OWNED BY public.triggers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    username character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deactivated_at timestamp without time zone,
    otp_secret_key character varying,
    google_secret character varying,
    role character varying,
    law_firm_id integer,
    new_password_set boolean DEFAULT false,
    qr_code_confirmed_at timestamp without time zone,
    first_name character varying,
    last_name character varying,
    line_of_business character varying,
    lob_contact_name character varying,
    two_fa_key character varying,
    two_fa_key_expires_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO manishchhipa1;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO manishchhipa1;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    name character varying,
    vendor_type character varying,
    application character varying,
    form_value_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.vendors OWNER TO manishchhipa1;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.vendors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO manishchhipa1;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: manishchhipa1
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_type character varying NOT NULL,
    item_id integer NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp without time zone
);


ALTER TABLE public.versions OWNER TO manishchhipa1;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa1
--

CREATE SEQUENCE public.versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO manishchhipa1;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa1
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: action_items id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.action_items ALTER COLUMN id SET DEFAULT nextval('public.action_items_id_seq'::regclass);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: activity_time_logs id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.activity_time_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_time_logs_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: cloud_providers id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cloud_providers ALTER COLUMN id SET DEFAULT nextval('public.cloud_providers_id_seq'::regclass);


--
-- Name: conflict_waivers id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.conflict_waivers ALTER COLUMN id SET DEFAULT nextval('public.conflict_waivers_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: cyber_security_insurances id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cyber_security_insurances ALTER COLUMN id SET DEFAULT nextval('public.cyber_security_insurances_id_seq'::regclass);


--
-- Name: cyber_security_standards id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cyber_security_standards ALTER COLUMN id SET DEFAULT nextval('public.cyber_security_standards_id_seq'::regclass);


--
-- Name: dropdown_options id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.dropdown_options ALTER COLUMN id SET DEFAULT nextval('public.dropdown_options_id_seq'::regclass);


--
-- Name: exception_requests id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.exception_requests ALTER COLUMN id SET DEFAULT nextval('public.exception_requests_id_seq'::regclass);


--
-- Name: faq_categories id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.faq_categories ALTER COLUMN id SET DEFAULT nextval('public.faq_categories_id_seq'::regclass);


--
-- Name: file_attachments id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.file_attachments ALTER COLUMN id SET DEFAULT nextval('public.file_attachments_id_seq'::regclass);


--
-- Name: follow_ups id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.follow_ups ALTER COLUMN id SET DEFAULT nextval('public.follow_ups_id_seq'::regclass);


--
-- Name: form_fields id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_fields ALTER COLUMN id SET DEFAULT nextval('public.form_fields_id_seq'::regclass);


--
-- Name: form_submissions id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_submissions ALTER COLUMN id SET DEFAULT nextval('public.form_submissions_id_seq'::regclass);


--
-- Name: form_values id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_values ALTER COLUMN id SET DEFAULT nextval('public.form_values_id_seq'::regclass);


--
-- Name: forms id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.forms ALTER COLUMN id SET DEFAULT nextval('public.forms_id_seq'::regclass);


--
-- Name: frequently_asked_questions id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.frequently_asked_questions ALTER COLUMN id SET DEFAULT nextval('public.frequently_asked_questions_id_seq'::regclass);


--
-- Name: history_submissions id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.history_submissions ALTER COLUMN id SET DEFAULT nextval('public.history_submissions_id_seq'::regclass);


--
-- Name: information_security_policies id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.information_security_policies ALTER COLUMN id SET DEFAULT nextval('public.information_security_policies_id_seq'::regclass);


--
-- Name: internal_notes id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.internal_notes ALTER COLUMN id SET DEFAULT nextval('public.internal_notes_id_seq'::regclass);


--
-- Name: jurisdiction_types id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.jurisdiction_types ALTER COLUMN id SET DEFAULT nextval('public.jurisdiction_types_id_seq'::regclass);


--
-- Name: jurisdictions id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.jurisdictions ALTER COLUMN id SET DEFAULT nextval('public.jurisdictions_id_seq'::regclass);


--
-- Name: law_firms id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms ALTER COLUMN id SET DEFAULT nextval('public.law_firms_id_seq'::regclass);


--
-- Name: law_firms_countries id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms_countries ALTER COLUMN id SET DEFAULT nextval('public.law_firms_countries_id_seq'::regclass);


--
-- Name: law_firms_states id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms_states ALTER COLUMN id SET DEFAULT nextval('public.law_firms_states_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: logics id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.logics ALTER COLUMN id SET DEFAULT nextval('public.logics_id_seq'::regclass);


--
-- Name: mailboxer_conversation_opt_outs id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_conversation_opt_outs_id_seq'::regclass);


--
-- Name: mailboxer_conversations id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_conversations ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_conversations_id_seq'::regclass);


--
-- Name: mailboxer_notifications id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_notifications ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_notifications_id_seq'::regclass);


--
-- Name: mailboxer_receipts id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_receipts ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_receipts_id_seq'::regclass);


--
-- Name: matter_types id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.matter_types ALTER COLUMN id SET DEFAULT nextval('public.matter_types_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: panel_requests id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.panel_requests ALTER COLUMN id SET DEFAULT nextval('public.panel_requests_id_seq'::regclass);


--
-- Name: queued_notifications id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.queued_notifications ALTER COLUMN id SET DEFAULT nextval('public.queued_notifications_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: security_alerts id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.security_alerts ALTER COLUMN id SET DEFAULT nextval('public.security_alerts_id_seq'::regclass);


--
-- Name: security_threats id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.security_threats ALTER COLUMN id SET DEFAULT nextval('public.security_threats_id_seq'::regclass);


--
-- Name: severity_levels id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.severity_levels ALTER COLUMN id SET DEFAULT nextval('public.severity_levels_id_seq'::regclass);


--
-- Name: shared_bank_informations id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.shared_bank_informations ALTER COLUMN id SET DEFAULT nextval('public.shared_bank_informations_id_seq'::regclass);


--
-- Name: states id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.states ALTER COLUMN id SET DEFAULT nextval('public.states_id_seq'::regclass);


--
-- Name: sub_matter_types id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.sub_matter_types ALTER COLUMN id SET DEFAULT nextval('public.sub_matter_types_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: technologies id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.technologies ALTER COLUMN id SET DEFAULT nextval('public.technologies_id_seq'::regclass);


--
-- Name: technology_values id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.technology_values ALTER COLUMN id SET DEFAULT nextval('public.technology_values_id_seq'::regclass);


--
-- Name: third_party_vendors id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.third_party_vendors ALTER COLUMN id SET DEFAULT nextval('public.third_party_vendors_id_seq'::regclass);


--
-- Name: todo_tasks id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.todo_tasks ALTER COLUMN id SET DEFAULT nextval('public.todo_tasks_id_seq'::regclass);


--
-- Name: triggers id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.triggers ALTER COLUMN id SET DEFAULT nextval('public.triggers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Data for Name: action_items; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.action_items (id, security_threat_id, law_firm_id, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.active_admin_comments (id, namespace, body, resource_id, resource_type, author_type, author_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.activity_logs (id, law_firm_id, event_type, custom_message, loggable_type, loggable_id, created_at, updated_at, read, notify, email, source, status) FROM stdin;
1	2	information_security_policy_request_initiated	SEAL process started	FormSubmission	1	2020-02-03 18:03:28.941772	2020-02-03 18:03:28.941772	\N	t	ram@gmail.com	User	\N
2	2	information_security_policy_submitted	SEAL form submitted	FormSubmission	1	2020-02-03 18:09:43.100122	2020-02-03 18:09:43.100122	\N	t	ram@gmail.com	User	\N
3	6	account_created	Onboarded	LawFirm	6	2020-03-24 16:44:42.431808	2020-03-24 16:44:42.431808	\N	t	demolxp@mailinator.com	User	\N
4	7	account_created	Onboarded	LawFirm	7	2020-03-24 16:54:37.671012	2020-03-24 16:54:37.671012	\N	t	demolxp@mailinator.com	User	\N
5	18	account_created	Onboarded	LawFirm	18	2020-03-25 08:33:13.500392	2020-03-25 08:33:13.500392	\N	t	demolxp@mailinator.com	User	\N
\.


--
-- Data for Name: activity_time_logs; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.activity_time_logs (id, network_discovery, penetration_testing, vulnerability_assessment, hardware_refresh, hardware_inventory, software_inventory, form_value_id, created_at, updated_at, network_discovery_never, penetration_testing_never, vulnerability_assessment_never, hardware_refresh_never, hardware_inventory_never, software_inventory_never) FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, role) FROM stdin;
1	admin@gmail.com	$2a$11$SG9ySYnHyIW2r5iYQuRn4ev31s2y070M.WMyA0JOul6eUrkkkksJa	\N	\N	\N	0	\N	\N	\N	\N	2020-02-03 17:49:19.23625	2020-02-03 17:49:19.23625	superadmin
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2020-02-03 15:21:31.969052	2020-02-03 15:21:31.969052
\.


--
-- Data for Name: cloud_providers; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.cloud_providers (id, form_value_id, name, service, data_store_location_ca, created_at, updated_at, cloud_type, data, encrypted_in_flight, encrypted_at_rest) FROM stdin;
\.


--
-- Data for Name: conflict_waivers; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.conflict_waivers (id, name_of_law_firm, contact_details, bmo_business_contact, reason, user_id, created_at, updated_at, confirm_waiver, lxp_status, internal_lawyers_status, law_firm_id, assigned_to_id) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.countries (id, country_id, name, iso, created_at, updated_at) FROM stdin;
34	1	Andorra	AD	2020-03-23 17:08:28.507097	2020-03-23 17:08:28.507097
35	2	United Arab Emirates	AE	2020-03-23 17:08:28.534542	2020-03-23 17:08:28.534542
36	3	Afghanistan	AF	2020-03-23 17:08:28.537337	2020-03-23 17:08:28.537337
37	4	Antigua and Barbuda	AG	2020-03-23 17:08:28.539996	2020-03-23 17:08:28.539996
38	5	Anguilla	AI	2020-03-23 17:08:28.542256	2020-03-23 17:08:28.542256
39	6	Albania	AL	2020-03-23 17:08:28.54461	2020-03-23 17:08:28.54461
40	7	Armenia	AM	2020-03-23 17:08:28.547628	2020-03-23 17:08:28.547628
41	8	Angola	AO	2020-03-23 17:08:28.549568	2020-03-23 17:08:28.549568
42	9	Antarctica	AQ	2020-03-23 17:08:28.551664	2020-03-23 17:08:28.551664
43	10	Argentina	AR	2020-03-23 17:08:28.554384	2020-03-23 17:08:28.554384
44	11	American Samoa	AS	2020-03-23 17:08:28.556382	2020-03-23 17:08:28.556382
45	12	Austria	AT	2020-03-23 17:08:28.558279	2020-03-23 17:08:28.558279
46	13	Australia	AU	2020-03-23 17:08:28.560255	2020-03-23 17:08:28.560255
47	14	Aruba	AW	2020-03-23 17:08:28.562852	2020-03-23 17:08:28.562852
48	15	Aland Islands	AX	2020-03-23 17:08:28.564976	2020-03-23 17:08:28.564976
49	16	Azerbaijan	AZ	2020-03-23 17:08:28.56741	2020-03-23 17:08:28.56741
50	17	Bosnia and Herzegovina	BA	2020-03-23 17:08:28.56997	2020-03-23 17:08:28.56997
51	18	Barbados	BB	2020-03-23 17:08:28.572579	2020-03-23 17:08:28.572579
52	19	Bangladesh	BD	2020-03-23 17:08:28.574937	2020-03-23 17:08:28.574937
53	20	Belgium	BE	2020-03-23 17:08:28.577389	2020-03-23 17:08:28.577389
54	21	Burkina Faso	BF	2020-03-23 17:08:28.579236	2020-03-23 17:08:28.579236
55	22	Bulgaria	BG	2020-03-23 17:08:28.581398	2020-03-23 17:08:28.581398
56	23	Bahrain	BH	2020-03-23 17:08:28.58343	2020-03-23 17:08:28.58343
57	24	Burundi	BI	2020-03-23 17:08:28.586173	2020-03-23 17:08:28.586173
58	25	Benin	BJ	2020-03-23 17:08:28.588262	2020-03-23 17:08:28.588262
59	26	Saint Barthelemy	BL	2020-03-23 17:08:28.590116	2020-03-23 17:08:28.590116
60	27	Bermuda	BM	2020-03-23 17:08:28.593	2020-03-23 17:08:28.593
61	28	Brunei	BN	2020-03-23 17:08:28.595101	2020-03-23 17:08:28.595101
62	29	Bolivia	BO	2020-03-23 17:08:28.597134	2020-03-23 17:08:28.597134
63	30	Bonaire, Saint Eustatius and Saba 	BQ	2020-03-23 17:08:28.599303	2020-03-23 17:08:28.599303
64	31	Brazil	BR	2020-03-23 17:08:28.601365	2020-03-23 17:08:28.601365
65	32	Bahamas	BS	2020-03-23 17:08:28.603594	2020-03-23 17:08:28.603594
66	33	Bhutan	BT	2020-03-23 17:08:28.605699	2020-03-23 17:08:28.605699
67	34	Bouvet Island	BV	2020-03-23 17:08:28.607722	2020-03-23 17:08:28.607722
68	35	Botswana	BW	2020-03-23 17:08:28.610369	2020-03-23 17:08:28.610369
69	36	Belarus	BY	2020-03-23 17:08:28.613041	2020-03-23 17:08:28.613041
70	37	Belize	BZ	2020-03-23 17:08:28.615368	2020-03-23 17:08:28.615368
71	38	Canada	CA	2020-03-23 17:08:28.617807	2020-03-23 17:08:28.617807
72	39	Cocos Islands	CC	2020-03-23 17:08:28.619714	2020-03-23 17:08:28.619714
73	40	Democratic Republic of the Congo	CD	2020-03-23 17:08:28.621448	2020-03-23 17:08:28.621448
74	41	Central African Republic	CF	2020-03-23 17:08:28.623713	2020-03-23 17:08:28.623713
75	42	Republic of the Congo	CG	2020-03-23 17:08:28.626154	2020-03-23 17:08:28.626154
76	43	Switzerland	CH	2020-03-23 17:08:28.62835	2020-03-23 17:08:28.62835
77	44	Ivory Coast	CI	2020-03-23 17:08:28.630394	2020-03-23 17:08:28.630394
78	45	Cook Islands	CK	2020-03-23 17:08:28.632648	2020-03-23 17:08:28.632648
79	46	Chile	CL	2020-03-23 17:08:28.634943	2020-03-23 17:08:28.634943
80	47	Cameroon	CM	2020-03-23 17:08:28.636897	2020-03-23 17:08:28.636897
81	48	China	CN	2020-03-23 17:08:28.638809	2020-03-23 17:08:28.638809
82	49	Colombia	CO	2020-03-23 17:08:28.641135	2020-03-23 17:08:28.641135
83	50	Costa Rica	CR	2020-03-23 17:08:28.64357	2020-03-23 17:08:28.64357
84	51	Cuba	CU	2020-03-23 17:08:28.645554	2020-03-23 17:08:28.645554
85	52	Cape Verde	CV	2020-03-23 17:08:28.647526	2020-03-23 17:08:28.647526
86	53	Curacao	CW	2020-03-23 17:08:28.64957	2020-03-23 17:08:28.64957
87	54	Christmas Island	CX	2020-03-23 17:08:28.651816	2020-03-23 17:08:28.651816
88	55	Cyprus	CY	2020-03-23 17:08:28.654041	2020-03-23 17:08:28.654041
89	56	Czech Republic	CZ	2020-03-23 17:08:28.656013	2020-03-23 17:08:28.656013
90	57	Germany	DE	2020-03-23 17:08:28.658121	2020-03-23 17:08:28.658121
91	58	Djibouti	DJ	2020-03-23 17:08:28.660002	2020-03-23 17:08:28.660002
92	59	Denmark	DK	2020-03-23 17:08:28.661888	2020-03-23 17:08:28.661888
93	60	Dominica	DM	2020-03-23 17:08:28.663631	2020-03-23 17:08:28.663631
94	61	Dominican Republic	DO	2020-03-23 17:08:28.665618	2020-03-23 17:08:28.665618
95	62	Algeria	DZ	2020-03-23 17:08:28.667835	2020-03-23 17:08:28.667835
96	63	Ecuador	EC	2020-03-23 17:08:28.670077	2020-03-23 17:08:28.670077
97	64	Estonia	EE	2020-03-23 17:08:28.673298	2020-03-23 17:08:28.673298
98	65	Egypt	EG	2020-03-23 17:08:28.675901	2020-03-23 17:08:28.675901
99	66	Western Sahara	EH	2020-03-23 17:08:28.678234	2020-03-23 17:08:28.678234
100	67	Eritrea	ER	2020-03-23 17:08:28.680461	2020-03-23 17:08:28.680461
101	68	Spain	ES	2020-03-23 17:08:28.682836	2020-03-23 17:08:28.682836
102	69	Ethiopia	ET	2020-03-23 17:08:28.68475	2020-03-23 17:08:28.68475
103	70	Finland	FI	2020-03-23 17:08:28.68681	2020-03-23 17:08:28.68681
104	71	Fiji	FJ	2020-03-23 17:08:28.68885	2020-03-23 17:08:28.68885
105	72	Falkland Islands	FK	2020-03-23 17:08:28.690894	2020-03-23 17:08:28.690894
106	73	Micronesia	FM	2020-03-23 17:08:28.693452	2020-03-23 17:08:28.693452
107	74	Faroe Islands	FO	2020-03-23 17:08:28.695293	2020-03-23 17:08:28.695293
108	75	France	FR	2020-03-23 17:08:28.697202	2020-03-23 17:08:28.697202
109	76	Gabon	GA	2020-03-23 17:08:28.699419	2020-03-23 17:08:28.699419
110	77	United Kingdom	GB	2020-03-23 17:08:28.701738	2020-03-23 17:08:28.701738
111	78	Grenada	GD	2020-03-23 17:08:28.703854	2020-03-23 17:08:28.703854
112	79	Georgia	GE	2020-03-23 17:08:28.70613	2020-03-23 17:08:28.70613
113	80	French Guiana	GF	2020-03-23 17:08:28.70819	2020-03-23 17:08:28.70819
114	81	Guernsey	GG	2020-03-23 17:08:28.710356	2020-03-23 17:08:28.710356
115	82	Ghana	GH	2020-03-23 17:08:28.71289	2020-03-23 17:08:28.71289
116	83	Gibraltar	GI	2020-03-23 17:08:28.71506	2020-03-23 17:08:28.71506
117	84	Greenland	GL	2020-03-23 17:08:28.718367	2020-03-23 17:08:28.718367
118	85	Gambia	GM	2020-03-23 17:08:28.720691	2020-03-23 17:08:28.720691
119	86	Guinea	GN	2020-03-23 17:08:28.723391	2020-03-23 17:08:28.723391
120	87	Guadeloupe	GP	2020-03-23 17:08:28.725579	2020-03-23 17:08:28.725579
121	88	Equatorial Guinea	GQ	2020-03-23 17:08:28.727621	2020-03-23 17:08:28.727621
122	89	Greece	GR	2020-03-23 17:08:28.729716	2020-03-23 17:08:28.729716
123	90	South Georgia and the South Sandwich Islands	GS	2020-03-23 17:08:28.732377	2020-03-23 17:08:28.732377
124	91	Guatemala	GT	2020-03-23 17:08:28.734639	2020-03-23 17:08:28.734639
125	92	Guam	GU	2020-03-23 17:08:28.736996	2020-03-23 17:08:28.736996
126	93	Guinea-Bissau	GW	2020-03-23 17:08:28.739832	2020-03-23 17:08:28.739832
127	94	Guyana	GY	2020-03-23 17:08:28.741878	2020-03-23 17:08:28.741878
128	95	Hong Kong	HK	2020-03-23 17:08:28.744325	2020-03-23 17:08:28.744325
129	96	Heard Island and McDonald Islands	HM	2020-03-23 17:08:28.747217	2020-03-23 17:08:28.747217
130	97	Honduras	HN	2020-03-23 17:08:28.750025	2020-03-23 17:08:28.750025
131	98	Croatia	HR	2020-03-23 17:08:28.753795	2020-03-23 17:08:28.753795
132	99	Haiti	HT	2020-03-23 17:08:28.756158	2020-03-23 17:08:28.756158
133	100	Hungary	HU	2020-03-23 17:08:28.758459	2020-03-23 17:08:28.758459
134	101	Indonesia	country_id	2020-03-23 17:08:28.760683	2020-03-23 17:08:28.760683
135	102	Ireland	IE	2020-03-23 17:08:28.764384	2020-03-23 17:08:28.764384
136	103	Israel	IL	2020-03-23 17:08:28.769508	2020-03-23 17:08:28.769508
137	104	Isle of Man	IM	2020-03-23 17:08:28.772838	2020-03-23 17:08:28.772838
138	105	India	IN	2020-03-23 17:08:28.775095	2020-03-23 17:08:28.775095
139	106	British Indian Ocean Territory	IO	2020-03-23 17:08:28.777161	2020-03-23 17:08:28.777161
140	107	Iraq	IQ	2020-03-23 17:08:28.780084	2020-03-23 17:08:28.780084
141	108	Iran	IR	2020-03-23 17:08:28.782833	2020-03-23 17:08:28.782833
142	109	Iceland	IS	2020-03-23 17:08:28.785075	2020-03-23 17:08:28.785075
143	110	Italy	IT	2020-03-23 17:08:28.787274	2020-03-23 17:08:28.787274
144	111	Jersey	JE	2020-03-23 17:08:28.789279	2020-03-23 17:08:28.789279
145	112	Jamaica	JM	2020-03-23 17:08:28.791228	2020-03-23 17:08:28.791228
146	113	Jordan	JO	2020-03-23 17:08:28.794156	2020-03-23 17:08:28.794156
147	114	Japan	JP	2020-03-23 17:08:28.796271	2020-03-23 17:08:28.796271
148	115	Kenya	KE	2020-03-23 17:08:28.79873	2020-03-23 17:08:28.79873
149	116	Kyrgyzstan	KG	2020-03-23 17:08:28.804198	2020-03-23 17:08:28.804198
150	117	Cambodia	KH	2020-03-23 17:08:28.806669	2020-03-23 17:08:28.806669
151	118	Kiribati	KI	2020-03-23 17:08:28.809008	2020-03-23 17:08:28.809008
152	119	Comoros	KM	2020-03-23 17:08:28.813694	2020-03-23 17:08:28.813694
153	120	Saint Kitts and Nevis	KN	2020-03-23 17:08:28.815746	2020-03-23 17:08:28.815746
154	121	North Korea	KP	2020-03-23 17:08:28.818444	2020-03-23 17:08:28.818444
155	122	South Korea	KR	2020-03-23 17:08:28.820508	2020-03-23 17:08:28.820508
156	123	Kosovo	XK	2020-03-23 17:08:28.822577	2020-03-23 17:08:28.822577
157	124	Kuwait	KW	2020-03-23 17:08:28.825158	2020-03-23 17:08:28.825158
158	125	Cayman Islands	KY	2020-03-23 17:08:28.827717	2020-03-23 17:08:28.827717
159	126	Kazakhstan	KZ	2020-03-23 17:08:28.831539	2020-03-23 17:08:28.831539
160	127	Laos	LA	2020-03-23 17:08:28.835099	2020-03-23 17:08:28.835099
161	128	Lebanon	LB	2020-03-23 17:08:28.83732	2020-03-23 17:08:28.83732
162	129	Saint Lucia	LC	2020-03-23 17:08:28.839465	2020-03-23 17:08:28.839465
163	130	Liechtenstein	LI	2020-03-23 17:08:28.84175	2020-03-23 17:08:28.84175
164	131	Sri Lanka	LK	2020-03-23 17:08:28.843917	2020-03-23 17:08:28.843917
165	132	Liberia	LR	2020-03-23 17:08:28.846278	2020-03-23 17:08:28.846278
166	133	Lesotho	LS	2020-03-23 17:08:28.848838	2020-03-23 17:08:28.848838
167	134	Lithuania	LT	2020-03-23 17:08:28.852331	2020-03-23 17:08:28.852331
168	135	Luxembourg	LU	2020-03-23 17:08:28.854441	2020-03-23 17:08:28.854441
169	136	Latvia	LV	2020-03-23 17:08:28.856447	2020-03-23 17:08:28.856447
170	137	Libya	LY	2020-03-23 17:08:28.859383	2020-03-23 17:08:28.859383
171	138	Morocco	MA	2020-03-23 17:08:28.862199	2020-03-23 17:08:28.862199
172	139	Monaco	MC	2020-03-23 17:08:28.867958	2020-03-23 17:08:28.867958
173	140	Moldova	MD	2020-03-23 17:08:28.871445	2020-03-23 17:08:28.871445
174	141	Montenegro	ME	2020-03-23 17:08:28.874576	2020-03-23 17:08:28.874576
175	142	Saint Martin	MF	2020-03-23 17:08:28.876877	2020-03-23 17:08:28.876877
176	143	Madagascar	MG	2020-03-23 17:08:28.87914	2020-03-23 17:08:28.87914
177	144	Marshall Islands	MH	2020-03-23 17:08:28.882601	2020-03-23 17:08:28.882601
178	145	Macedonia	MK	2020-03-23 17:08:28.885952	2020-03-23 17:08:28.885952
179	146	Mali	ML	2020-03-23 17:08:28.890366	2020-03-23 17:08:28.890366
180	147	Myanmar	MM	2020-03-23 17:08:28.892887	2020-03-23 17:08:28.892887
181	148	Mongolia	MN	2020-03-23 17:08:28.896158	2020-03-23 17:08:28.896158
182	149	Macau	MO	2020-03-23 17:08:28.898937	2020-03-23 17:08:28.898937
183	150	Northern Mariana Islands	MP	2020-03-23 17:08:28.901732	2020-03-23 17:08:28.901732
184	151	Martinique	MQ	2020-03-23 17:08:28.903463	2020-03-23 17:08:28.903463
185	152	Mauritania	MR	2020-03-23 17:08:28.905286	2020-03-23 17:08:28.905286
186	153	Montserrat	MS	2020-03-23 17:08:28.907684	2020-03-23 17:08:28.907684
187	154	Malta	MT	2020-03-23 17:08:28.90976	2020-03-23 17:08:28.90976
188	155	Mauritius	MU	2020-03-23 17:08:28.912037	2020-03-23 17:08:28.912037
189	156	Maldives	MV	2020-03-23 17:08:28.91523	2020-03-23 17:08:28.91523
190	157	Malawi	MW	2020-03-23 17:08:28.918632	2020-03-23 17:08:28.918632
191	158	Mexico	MX	2020-03-23 17:08:28.921487	2020-03-23 17:08:28.921487
192	159	Malaysia	MY	2020-03-23 17:08:28.924359	2020-03-23 17:08:28.924359
193	160	Mozambique	MZ	2020-03-23 17:08:28.926417	2020-03-23 17:08:28.926417
194	161	Namibia	NA	2020-03-23 17:08:28.928635	2020-03-23 17:08:28.928635
195	162	New Caledonia	NC	2020-03-23 17:08:28.935113	2020-03-23 17:08:28.935113
196	163	Niger	NE	2020-03-23 17:08:28.937908	2020-03-23 17:08:28.937908
197	164	Norfolk Island	NF	2020-03-23 17:08:28.941066	2020-03-23 17:08:28.941066
198	165	Nigeria	NG	2020-03-23 17:08:28.944256	2020-03-23 17:08:28.944256
199	166	Nicaragua	NI	2020-03-23 17:08:28.948091	2020-03-23 17:08:28.948091
200	167	Netherlands	NL	2020-03-23 17:08:28.949609	2020-03-23 17:08:28.949609
201	168	Norway	NO	2020-03-23 17:08:28.952784	2020-03-23 17:08:28.952784
202	169	Nepal	NP	2020-03-23 17:08:28.954884	2020-03-23 17:08:28.954884
203	170	Nauru	NR	2020-03-23 17:08:28.956876	2020-03-23 17:08:28.956876
204	171	Niue	NU	2020-03-23 17:08:28.958945	2020-03-23 17:08:28.958945
205	172	New Zealand	NZ	2020-03-23 17:08:28.961009	2020-03-23 17:08:28.961009
206	173	Oman	OM	2020-03-23 17:08:28.963853	2020-03-23 17:08:28.963853
207	174	Panama	PA	2020-03-23 17:08:28.966361	2020-03-23 17:08:28.966361
208	175	Peru	PE	2020-03-23 17:08:28.969118	2020-03-23 17:08:28.969118
209	176	French Polynesia	PF	2020-03-23 17:08:28.971678	2020-03-23 17:08:28.971678
210	177	Papua New Guinea	PG	2020-03-23 17:08:28.974145	2020-03-23 17:08:28.974145
211	178	Philippines	PH	2020-03-23 17:08:28.976038	2020-03-23 17:08:28.976038
212	179	Pakistan	PK	2020-03-23 17:08:28.977827	2020-03-23 17:08:28.977827
213	180	Poland	PL	2020-03-23 17:08:28.979733	2020-03-23 17:08:28.979733
214	181	Saint Pierre and Miquelon	PM	2020-03-23 17:08:28.981973	2020-03-23 17:08:28.981973
215	182	Pitcairn	PN	2020-03-23 17:08:28.983839	2020-03-23 17:08:28.983839
216	183	Puerto Rico	PR	2020-03-23 17:08:28.986428	2020-03-23 17:08:28.986428
217	184	Palestinian Territory	PS	2020-03-23 17:08:28.988465	2020-03-23 17:08:28.988465
218	185	Portugal	PT	2020-03-23 17:08:28.990434	2020-03-23 17:08:28.990434
219	186	Palau	PW	2020-03-23 17:08:28.992771	2020-03-23 17:08:28.992771
220	187	Paraguay	PY	2020-03-23 17:08:28.995526	2020-03-23 17:08:28.995526
221	188	Qatar	QA	2020-03-23 17:08:28.997443	2020-03-23 17:08:28.997443
222	189	Reunion	RE	2020-03-23 17:08:28.999819	2020-03-23 17:08:28.999819
223	190	Romania	RO	2020-03-23 17:08:29.00287	2020-03-23 17:08:29.00287
224	191	Serbia	RS	2020-03-23 17:08:29.004912	2020-03-23 17:08:29.004912
225	192	Russia	RU	2020-03-23 17:08:29.006812	2020-03-23 17:08:29.006812
226	193	Rwanda	RW	2020-03-23 17:08:29.00911	2020-03-23 17:08:29.00911
227	194	Saudi Arabia	SA	2020-03-23 17:08:29.013481	2020-03-23 17:08:29.013481
228	195	Solomon Islands	SB	2020-03-23 17:08:29.016109	2020-03-23 17:08:29.016109
229	196	Seychelles	SC	2020-03-23 17:08:29.019563	2020-03-23 17:08:29.019563
230	197	Sudan	SD	2020-03-23 17:08:29.023464	2020-03-23 17:08:29.023464
231	198	Sweden	SE	2020-03-23 17:08:29.028664	2020-03-23 17:08:29.028664
232	199	Singapore	SG	2020-03-23 17:08:29.033028	2020-03-23 17:08:29.033028
233	200	Saint Helena	SH	2020-03-23 17:08:29.036386	2020-03-23 17:08:29.036386
234	201	Slovenia	SI	2020-03-23 17:08:29.038852	2020-03-23 17:08:29.038852
235	202	Svalbard and Jan Mayen	SJ	2020-03-23 17:08:29.04109	2020-03-23 17:08:29.04109
236	203	Slovakia	SK	2020-03-23 17:08:29.044074	2020-03-23 17:08:29.044074
237	204	Sierra Leone	SL	2020-03-23 17:08:29.048305	2020-03-23 17:08:29.048305
238	205	San Marino	SM	2020-03-23 17:08:29.055622	2020-03-23 17:08:29.055622
239	206	Senegal	SN	2020-03-23 17:08:29.064069	2020-03-23 17:08:29.064069
240	207	Somalia	SO	2020-03-23 17:08:29.067962	2020-03-23 17:08:29.067962
241	208	Suriname	SR	2020-03-23 17:08:29.074494	2020-03-23 17:08:29.074494
242	209	Sao Tome and Principe	ST	2020-03-23 17:08:29.079152	2020-03-23 17:08:29.079152
243	210	El Salvador	SV	2020-03-23 17:08:29.082498	2020-03-23 17:08:29.082498
244	211	Sint Maarten	SX	2020-03-23 17:08:29.084805	2020-03-23 17:08:29.084805
245	212	Syria	SY	2020-03-23 17:08:29.086977	2020-03-23 17:08:29.086977
246	213	Swaziland	SZ	2020-03-23 17:08:29.093501	2020-03-23 17:08:29.093501
247	214	Turks and Caicos Islands	TC	2020-03-23 17:08:29.095588	2020-03-23 17:08:29.095588
248	215	Chad	TD	2020-03-23 17:08:29.097465	2020-03-23 17:08:29.097465
249	216	French Southern Territories	TF	2020-03-23 17:08:29.10002	2020-03-23 17:08:29.10002
250	217	Togo	TG	2020-03-23 17:08:29.102484	2020-03-23 17:08:29.102484
251	218	Thailand	TH	2020-03-23 17:08:29.104934	2020-03-23 17:08:29.104934
252	219	Tajikistan	TJ	2020-03-23 17:08:29.108356	2020-03-23 17:08:29.108356
253	220	Tokelau	TK	2020-03-23 17:08:29.110241	2020-03-23 17:08:29.110241
254	221	East Timor	TL	2020-03-23 17:08:29.112696	2020-03-23 17:08:29.112696
255	222	Turkmenistan	TM	2020-03-23 17:08:29.114444	2020-03-23 17:08:29.114444
256	223	Tunisia	TN	2020-03-23 17:08:29.116682	2020-03-23 17:08:29.116682
257	224	Tonga	TO	2020-03-23 17:08:29.119285	2020-03-23 17:08:29.119285
258	225	Turkey	TR	2020-03-23 17:08:29.121739	2020-03-23 17:08:29.121739
259	226	Trincountry_idad and Tobago	TT	2020-03-23 17:08:29.124826	2020-03-23 17:08:29.124826
260	227	Tuvalu	TV	2020-03-23 17:08:29.127277	2020-03-23 17:08:29.127277
261	228	Taiwan	TW	2020-03-23 17:08:29.129237	2020-03-23 17:08:29.129237
262	229	Tanzania	TZ	2020-03-23 17:08:29.132759	2020-03-23 17:08:29.132759
263	230	Ukraine	UA	2020-03-23 17:08:29.134827	2020-03-23 17:08:29.134827
264	231	Uganda	UG	2020-03-23 17:08:29.137374	2020-03-23 17:08:29.137374
265	232	United States Minor Outlying Islands	UM	2020-03-23 17:08:29.139949	2020-03-23 17:08:29.139949
266	233	United States	US	2020-03-23 17:08:29.142572	2020-03-23 17:08:29.142572
267	234	Uruguay	UY	2020-03-23 17:08:29.144986	2020-03-23 17:08:29.144986
268	235	Uzbekistan	UZ	2020-03-23 17:08:29.146805	2020-03-23 17:08:29.146805
269	236	Vatican	VA	2020-03-23 17:08:29.157254	2020-03-23 17:08:29.157254
270	237	Saint Vincent and the Grenadines	VC	2020-03-23 17:08:29.158964	2020-03-23 17:08:29.158964
271	238	Venezuela	VE	2020-03-23 17:08:29.160848	2020-03-23 17:08:29.160848
272	239	British Virgin Islands	VG	2020-03-23 17:08:29.162706	2020-03-23 17:08:29.162706
273	240	U.S. Virgin Islands	VI	2020-03-23 17:08:29.164618	2020-03-23 17:08:29.164618
274	241	Vietnam	VN	2020-03-23 17:08:29.166792	2020-03-23 17:08:29.166792
275	242	Vanuatu	VU	2020-03-23 17:08:29.168406	2020-03-23 17:08:29.168406
276	243	Wallis and Futuna	WF	2020-03-23 17:08:29.170292	2020-03-23 17:08:29.170292
277	244	Samoa	WS	2020-03-23 17:08:29.172611	2020-03-23 17:08:29.172611
278	245	Yemen	YE	2020-03-23 17:08:29.174442	2020-03-23 17:08:29.174442
279	246	Mayotte	YT	2020-03-23 17:08:29.176223	2020-03-23 17:08:29.176223
280	247	South Africa	ZA	2020-03-23 17:08:29.177988	2020-03-23 17:08:29.177988
281	248	Zambia	ZM	2020-03-23 17:08:29.179808	2020-03-23 17:08:29.179808
282	249	Zimbabwe	ZW	2020-03-23 17:08:29.181539	2020-03-23 17:08:29.181539
283	250	Serbia and Montenegro	CS	2020-03-23 17:08:29.18326	2020-03-23 17:08:29.18326
284	251	Netherlands Antilles	AN	2020-03-23 17:08:29.18495	2020-03-23 17:08:29.18495
\.


--
-- Data for Name: cyber_security_insurances; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.cyber_security_insurances (id, company, coverage, coverage_amount, policy, form_value_id, created_at, updated_at, date_of_expiry, standing) FROM stdin;
\.


--
-- Data for Name: cyber_security_standards; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.cyber_security_standards (id, rank, standard, date_of_certification, renewal, form_value_id, created_at, updated_at, status) FROM stdin;
\.


--
-- Data for Name: dropdown_options; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.dropdown_options (id, key, value, form_field_id, created_at, updated_at, score) FROM stdin;
\.


--
-- Data for Name: exception_requests; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.exception_requests (id, requested_by, user_id, submitted_by_email, line_of_business, lob_contact_name, law_firm_id, request_type, law_firm_category, minority_owned, minority_owned_details, women_owned, women_owned_details, matter_name, created_at, updated_at, matter_types, law_firm_name, business_manager_name, business_manager_phone, business_manager_email, lxp_status, lxp_id, internal_lawyers_status, internal_lawyers_id, docusign_envelope_id, pay_type, notes, is_work, reason, payer, matter_types_search, sub_matter_types_search, jurisdiction_types_search, countries_search, states_search, niche_preferred_external_counsel_panel_law_firms, niche_expertise, required_unique_geography, geographic_location, involved_engagement, reson_other) FROM stdin;
1	demolob@mailinator.com	2	demolob@mailinator.com	Canadian P&C / Services bancaires Particuliers et entreprises - Canada	ersy	1	EXCEPTION	\N	Yes	test	Yes	test	test	2020-02-03 17:45:31.704828	2020-02-03 17:45:31.704828	["", "Corporate Governance / Gouvernance d'entreprise"]	\N				\N	\N	\N	\N	\N	\N		f	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
2	\N	\N	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 13:22:37.758907	2020-03-25 13:22:37.758907	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
3	\N	\N	\N	No	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 13:23:34.712826	2020-03-25 13:23:34.712826	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
4	\N	\N	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:22:59.689166	2020-03-25 16:22:59.689166	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
5	\N	\N	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:36:04.277931	2020-03-25 16:36:04.277931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
6	\N	\N	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:38:20.555461	2020-03-25 16:38:20.555461	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	f	\N	f	\N	\N	\N
7	\N	\N	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:40:47.01134	2020-03-25 16:40:47.01134	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	18	17	2	138	1265	f	\N	f	\N	\N	\N
8	\N	\N	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:41:54.386696	2020-03-25 16:41:54.386696	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16	2	35	8	f	\N	f	\N	\N	\N
9	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:50:29.705955	2020-03-25 16:50:29.705955	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17		2	35	9	f	\N	f	\N	\N	\N
10	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:54:21.104575	2020-03-25 16:54:21.104575	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16	15	1	138	1265	f	\N	f	\N	\N	\N
11	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:56:50.839616	2020-03-25 16:56:50.839616	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16	1	34	1	f	\N	f	\N	\N	\N
12	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 16:57:32.720272	2020-03-25 16:57:32.720272	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16	2	34	3	f	\N	f	\N	\N	\N
13	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:00:51.365414	2020-03-25 17:00:51.365414	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16	2	34	3	f	\N	f	\N	\N	\N
14	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:01:20.621886	2020-03-25 17:01:20.621886	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16	15	2	35	9	f	\N	f	\N	\N	\N
15	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:09:18.492943	2020-03-25 17:09:18.492943	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17		3	35	10	f	\N	f	\N	\N	\N
16	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:15:17.811258	2020-03-25 17:15:17.811258	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	18	31	3	35	8	f	\N	f	\N	\N	\N
17	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:16:35.07271	2020-03-25 17:16:35.07271	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	18	31	3	35	8	f	\N	f	\N	\N	\N
18	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:42:17.692649	2020-03-25 17:42:17.692649	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16	15	2	34	1	f	\N	f	\N	\N	\N
19	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:45:34.07639	2020-03-25 17:45:34.07639	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16	2	34	1	f	\N	f	\N	\N	\N
20	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:48:26.397217	2020-03-25 17:48:26.397217	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16		2	34		f	\N	f	\N	\N	\N
21	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:48:38.904804	2020-03-25 17:48:38.904804	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16		2	34		f	\N	f	\N	\N	\N
22	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:51:37.085834	2020-03-25 17:51:37.085834	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	18					f	\N	f	\N	\N	\N
23	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:52:28.176181	2020-03-25 17:52:28.176181	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17					f	\N	f	\N	\N	\N
24	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:53:54.342104	2020-03-25 17:53:54.342104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16		2	34		f	\N	f	\N	\N	\N
25	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:54:19.262214	2020-03-25 17:54:19.262214	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16		2	34		f	\N	f	\N	\N	\N
26	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:58:36.633516	2020-03-25 17:58:36.633516	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16					f	\N	f	\N	\N	\N
27	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:59:20.461099	2020-03-25 17:59:20.461099	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	16					f	\N	f	\N	\N	\N
28	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 17:59:32.874728	2020-03-25 17:59:32.874728	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17					f	\N	f	\N	\N	\N
29	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 18:00:19.317501	2020-03-25 18:00:19.317501	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17					f	\N	f	\N	\N	\N
30	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-25 18:00:48.226277	2020-03-25 18:00:48.226277	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17					f	\N	f	\N	\N	\N
31		\N				\N	ADD_TO_LAW_FIRM_PANEL	\N					\N	2020-03-25 18:01:10.906054	2020-03-25 19:13:34.191911	\N	\N				\N	\N	\N	\N	\N	\N	\N	t	[""]		18		2	35		f	\N	f	\N	\N	\N
32	M	2	\N	Canadian P&C / Services bancaires Particuliers et entreprises - Canada	MM	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-26 15:37:27.319981	2020-03-26 15:56:35.304225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	["", "Experties", "Cost", "Designated Counsel"]	Customer Pay	17					f	\N	f	\N	\N	\N
33	34	2	\N	Corporate / Services d'entreprise	34	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-26 15:57:45.252097	2020-03-26 15:58:20.691212	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	["", "Experties", "Cost", "Designated Counsel"]	Bank Pay	17	30	2	35	9	f	\N	f	\N	\N	\N
34	\N	2	\N	\N	\N	23	\N	\N	\N	\N	\N	\N	\N	2020-03-26 16:18:46.384042	2020-03-26 16:18:46.384042	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	30	3	36		f	\N	f	\N	\N	\N
35	test	2	\N	Corporate / Services d'entreprise	est	\N	\N	\N	\N	\N	\N	\N	\N	2020-03-26 16:19:55.480106	2020-03-26 16:20:53.365157	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	["", "Experties", "Cost", "Designated Counsel"]	Customer Pay	17	30	2	34	1	f	\N	f	\N	\N	\N
36		2	\N			\N	\N	\N	\N	\N	\N	\N	\N	2020-04-01 12:28:37.866805	2020-04-01 12:33:10.956888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	[""]		17		2			f	\N	f	\N	\N	\N
37	\N	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2020-04-01 12:49:26.992798	2020-04-01 12:49:26.992798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	17	16				f	\N	f	\N	\N	\N
\.


--
-- Data for Name: faq_categories; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.faq_categories (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: file_attachments; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.file_attachments (id, file, form_value_id, created_at, updated_at, iv, key, attachable_type, attachable_id) FROM stdin;
\.


--
-- Data for Name: follow_ups; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.follow_ups (id, form_submission_id, loggable_type, loggable_id, status, note_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: form_fields; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.form_fields (id, min, max, required, label, type, created_at, updated_at, form_id, formable_id, formable_type, parent_id, "position", group_form_id, repeater, custom_logic, show_when_form_field_id, show_when_form_field_value, scored, score, help_description) FROM stdin;
\.


--
-- Data for Name: form_submissions; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.form_submissions (id, name, created_at, updated_at, form_id, form_process_id, submitted, submitted_on, law_firm_id, total_score, status, reason, assessor_score, system_score, expiry_date, locked_by_id, locked_at, last_submitted_by_id, approved_at, evidence_status, form_relationship_id, form_diversity_id, form_innovation_id, form_resourcing_id) FROM stdin;
1	\N	2020-02-03 18:03:25.653732	2020-02-03 18:08:24.810732	\N	\N	f	2020-02-03 18:08:24.809773	2	\N	\N	\N	\N	0	\N	\N	\N	5	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: form_values; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.form_values (id, form_field_id, submittable_id, value, created_at, updated_at, submittable_type, form_field_label, file_value, checked, form_value_iv, form_value_key, multi_select_value) FROM stdin;
\.


--
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.forms (id, name, created_at, updated_at, group_form, step) FROM stdin;
\.


--
-- Data for Name: frequently_asked_questions; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.frequently_asked_questions (id, question, answer, created_at, updated_at, faq_category_id) FROM stdin;
\.


--
-- Data for Name: history_submissions; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.history_submissions (id, incident_type, impact, discovery_time, source, data_loss, incident_details, created_at, updated_at, form_submission_id, checked) FROM stdin;
\.


--
-- Data for Name: information_security_policies; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.information_security_policies (id, policy, last_reviewed, last_updated, freq_of_review, form_value_id, created_at, updated_at, upload_policy, independent_review, communication_status) FROM stdin;
\.


--
-- Data for Name: internal_notes; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.internal_notes (id, message, sender_id, law_firm_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: jurisdiction_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.jurisdiction_types (id, jurisdiction_type, created_at, updated_at) FROM stdin;
1	Jurisdiction Type 1	2020-03-23 14:06:27.646502	2020-03-23 14:06:27.646502
2	Jurisdiction Type 2	2020-03-23 14:06:27.669424	2020-03-23 14:06:27.669424
3	Jurisdiction Type 3	2020-03-23 14:06:27.673394	2020-03-23 14:06:27.673394
4	Jurisdiction Type 4	2020-03-23 14:06:27.6792	2020-03-23 14:06:27.6792
5	Jurisdiction Type 5	2020-03-23 14:06:27.683069	2020-03-23 14:06:27.683069
\.


--
-- Data for Name: jurisdictions; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.jurisdictions (id, country, city, law_firm_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: law_firms; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms (id, name, description, email, phone, created_at, updated_at, user_id, relationship_manager_email, law_firm_type, parent_company, practice_area, sister_firm, principle_name, principle_title, principle_contact_info, profile_completed, max_users, public_uid, updated_by_lawfirm, initial_date_of_engagement_with_the_bank, type_of_matters_your_law_firm_handles_for_us, type_of_services_your_law_firm_provides_generally, confidentiality_level_of_matters_that_are_handled, number_of_lawyers, relationship_manager_name, relationship_manager_phone, law_firm_category, firm_use_on_regular_basis) FROM stdin;
23	Law Firm 1	Test Law firm 1	LF1@gmail.com	1122334455	2020-03-25 09:57:54.646576	2020-03-25 09:57:54.646576	2	test	LP	\N	\N	\N	\N	\N	\N	f	\N	7ca03a06	f	\N	\N	\N	\N	\N	Test	test	NON_PANEL	f
24	Test Law Firm 2	34	tlf2@gmail.com	3434	2020-03-25 09:58:57.124418	2020-03-25 09:58:57.124418	2	234	LLP	\N	\N	\N	\N	\N	\N	f	\N	56d97067	f	\N	\N	\N	\N	\N	234	234	NON_PANEL	f
\.


--
-- Data for Name: law_firms_countries; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms_countries (id, law_firm_id, country_id, created_at, updated_at) FROM stdin;
4	24	71	2020-03-25 09:58:57.141803	2020-03-25 09:58:57.141803
5	24	138	2020-03-25 09:58:57.143735	2020-03-25 09:58:57.143735
\.


--
-- Data for Name: law_firms_jurisdiction_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms_jurisdiction_types (law_firm_id, jurisdiction_type_id, created_at, updated_at) FROM stdin;
23	4	2020-03-25 09:57:54.666708	2020-03-25 09:57:54.666708
23	5	2020-03-25 09:57:54.668768	2020-03-25 09:57:54.668768
24	5	2020-03-25 09:58:57.138883	2020-03-25 09:58:57.138883
\.


--
-- Data for Name: law_firms_matter_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms_matter_types (law_firm_id, matter_type_id, created_at, updated_at) FROM stdin;
23	28	2020-03-25 09:57:54.652504	2020-03-25 09:57:54.652504
23	29	2020-03-25 09:57:54.656472	2020-03-25 09:57:54.656472
24	24	2020-03-25 09:58:57.128849	2020-03-25 09:58:57.128849
24	26	2020-03-25 09:58:57.131558	2020-03-25 09:58:57.131558
\.


--
-- Data for Name: law_firms_states; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms_states (id, law_firm_id, state_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: law_firms_sub_matter_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.law_firms_sub_matter_types (law_firm_id, sub_matter_type_id, created_at, updated_at) FROM stdin;
23	55	2020-03-25 09:57:54.65932	2020-03-25 09:57:54.65932
23	56	2020-03-25 09:57:54.662383	2020-03-25 09:57:54.662383
24	25	2020-03-25 09:58:57.135351	2020-03-25 09:58:57.135351
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.locations (id, address1, address2, city, province, country, postal_code, law_firm_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: logics; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.logics (id, listen_field_id, change_field_id, form_id, logic_to_be_applied, "values", perform_action, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mailboxer_conversation_opt_outs; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.mailboxer_conversation_opt_outs (id, unsubscriber_type, unsubscriber_id, conversation_id) FROM stdin;
\.


--
-- Data for Name: mailboxer_conversations; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.mailboxer_conversations (id, subject, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mailboxer_notifications; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.mailboxer_notifications (id, type, body, subject, sender_type, sender_id, conversation_id, draft, notification_code, notified_object_type, notified_object_id, attachment, updated_at, created_at, global, expires) FROM stdin;
\.


--
-- Data for Name: mailboxer_receipts; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.mailboxer_receipts (id, receiver_type, receiver_id, notification_id, is_read, trashed, deleted, mailbox_type, created_at, updated_at, is_delivered, delivery_method, message_id) FROM stdin;
\.


--
-- Data for Name: matter_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.matter_types (id, matter_type, created_at, updated_at) FROM stdin;
16	Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt	2020-03-23 12:49:13.998852	2020-03-23 12:49:13.998852
17	Corporate Governance / Gouvernance d'entreprise	2020-03-23 12:49:14.005977	2020-03-23 12:49:14.005977
18	Employment (non-action) / Recrutement (aucune intervention)	2020-03-23 12:49:14.009456	2020-03-23 12:49:14.009456
19	General Customer Inquiries / Questions générales de clients	2020-03-23 12:49:14.012935	2020-03-23 12:49:14.012935
20	Lending and Financing (inc. secured transactions and workouts) / Financement de prê	2020-03-23 12:49:14.017052	2020-03-23 12:49:14.017052
21	transactions garanties et les redressements)	2020-03-23 12:49:14.024039	2020-03-23 12:49:14.024039
22	Litigation / Litiges	2020-03-23 12:49:14.047999	2020-03-23 12:49:14.047999
23	Mergers & Acquisitions / Fusions et acquisitions	2020-03-23 12:49:14.054356	2020-03-23 12:49:14.054356
24	New Products / Nouveaux produits	2020-03-23 12:49:14.061774	2020-03-23 12:49:14.061774
25	Real Estate (non-lending) / Immobilier (autres que des prêts)	2020-03-23 12:49:14.066408	2020-03-23 12:49:14.066408
26	Regulatory / Réglementation	2020-03-23 12:49:14.077015	2020-03-23 12:49:14.077015
27	Tax / Fiscalité	2020-03-23 12:49:14.080063	2020-03-23 12:49:14.080063
28	Trademarks / Marques	2020-03-23 12:49:14.083351	2020-03-23 12:49:14.083351
29	Wills & Estates / Testaments/successions	2020-03-23 12:49:14.089751	2020-03-23 12:49:14.089751
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.notes (id, law_firm_id, message_type, message, step, admin_user_id, sender, created_at, updated_at, form_submission_id, follow_up_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: panel_requests; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.panel_requests (id, requested_by, user_id, submitted_by_email, line_of_business, lob_contact_name, law_firm_id, request_type, law_firm_category, minority_owned, minority_owned_details, women_owned, women_owned_details, matter_name, matter_types, created_at, updated_at, law_firm_name, business_manager_name, business_manager_phone, business_manager_email) FROM stdin;
1	Manish	1	demolxp@mailinator.com	Capital Markets / Marché des capitaux	manish	1	ADD_TO_LAW_FIRM_PANEL	\N	No	 	Yes	test	\N	["", "Corporate Governance / Gouvernance d'entreprise"]	2020-02-03 17:41:32.81	2020-02-03 17:41:32.81	\N	manish	23232323	manish@mailinator.com
2	test	2	demolob@mailinator.com	Capital Markets / Marché des capitaux	test	3	ADD_TO_LAW_FIRM_PANEL	\N	No	 	No	 	\N	["", "Corporate Governance / Gouvernance d'entreprise"]	2020-02-03 17:59:07.506146	2020-02-03 18:00:07.578666	\N	test	tes	test
3	test123	2	demolob@mailinator.com	Canadian P&C / Services bancaires Particuliers et entreprises - Canada	test123	4	ADD_TO_LAW_FIRM_PANEL	\N	No	 	No	 	\N	["", "Corporate Governance / Gouvernance d'entreprise"]	2020-02-03 18:42:47.801425	2020-02-03 18:42:47.801425	\N	test123	3w334	test123@gmail.com
4	test1234	1	demolxp@mailinator.com	Capital Markets / Marché des capitaux	sdf	5	ADD_TO_LAW_FIRM_PANEL	\N	No	 	No	 	\N	["", "Corporate Governance / Gouvernance d'entreprise"]	2020-02-03 18:45:26.723996	2020-02-03 18:45:26.723996	\N	sdf	234234	test1234er@dsfdf.sdf
\.


--
-- Data for Name: queued_notifications; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.queued_notifications (id, trigger_at, trigger_id, action_item_id, triggered, deleted_at, created_at, updated_at, severity_negative_factor) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.reviews (id, reviewable_id, reviewable_type, status, status_from, description, actor_id, assigned_to_id, created_at, updated_at, pay_type) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.schema_migrations (version) FROM stdin;
20170109000656
20170109001703
20170109003309
20170109003310
20170109004902
20170119221531
20170119225031
20170119225032
20170119225033
20170119225034
20170130190810
20170130190956
20170130194014
20170205005432
20170205012043
20170205180532
20170206012234
20170206015632
20170213003928
20170213005948
20170213014949
20170213020435
20170213022054
20170220205533
20170220211355
20170220211519
20170220221942
20170221020439
20170221024436
20170222152426
20170222191252
20170222210008
20170223031601
20170224180209
20170224191206
20170224215149
20170224221344
20170227170343
20170227174329
20170227182535
20170227204330
20170228175633
20170228180835
20170228204107
20170228215213
20170228223808
20170301173942
20170301231731
20170301231951
20170301234627
20170302211512
20170302231349
20170303154225
20170303194020
20170303203525
20170309163535
20170309163542
20170309163548
20170309163553
20170309163558
20170310211743
20170313205211
20170313205547
20170314081103
20170315210052
20170315223605
20170315223705
20170316160001
20170321135241
20170324145421
20170324162236
20170324170653
20170324191631
20170327181241
20170327202132
20170327204204
20170331214006
20170403151113
20170403174840
20170403184557
20170404155915
20170407180328
20170411154839
20170411183211
20170411183738
20170412155232
20170412162204
20170412163108
20170412191927
20170413032526
20170421163657
20170421204610
20170427163945
20170502181655
20170509205351
20170515204250
20170524153711
20170524154920
20170524160235
20170608203942
20170626194926
20170714160454
20170718155256
20170718165654
20180227174711
20180305200836
20180515041959
20180515042712
20180519145523
20180527232549
20180529011015
20180531023630
20180610202848
20180610203022
20180612040302
20180615032619
20180620055226
20180918160540
20181022231526
20181022233438
20181031140358
20190916040221
20190916043042
20190917184825
20190918170358
20190918175138
20190918184647
20190918200505
20190919140911
20190919162901
20190920182850
20190920183032
20190920183642
20190920191705
20190925152700
20190925152926
20190926184454
20190926193240
20190927054756
20191001151512
20191001173038
20191001235852
20191002001001
20191002043306
20191002144917
20191003163528
20191104025318
20191104150712
20191105160453
20191113191452
20200323123446
20200323125051
20200323133114
20200323170057
20200323170207
20200323173903
20200323184509
20200323185649
20200324061459
20200324062027
20200325150737
20200401131701
20200401133454
\.


--
-- Data for Name: security_alerts; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.security_alerts (id, title, description, severity, link, created_at, updated_at, alert_date) FROM stdin;
\.


--
-- Data for Name: security_threats; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.security_threats (id, title, description, severity_level_id, created_at, updated_at, severity_negative_factor, vendor, platform, version, service_pack) FROM stdin;
\.


--
-- Data for Name: severity_levels; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.severity_levels (id, name, color, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: shared_bank_informations; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.shared_bank_informations (id, form_value_id, name, purpose, level_of_access, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.states (id, name, iso, country_id, created_at, updated_at) FROM stdin;
1	Parroquia de Sant Julià de Loria	06	1	2020-03-23 17:08:48.447046	2020-03-23 17:08:48.447046
2	Parroquia d'Ordino	05	1	2020-03-23 17:08:48.458378	2020-03-23 17:08:48.458378
3	Parroquia de la Massana	04	1	2020-03-23 17:08:48.461463	2020-03-23 17:08:48.461463
4	Parroquia d'Encamp	03	1	2020-03-23 17:08:48.463585	2020-03-23 17:08:48.463585
5	Parroquia de Canillo	02	1	2020-03-23 17:08:48.465568	2020-03-23 17:08:48.465568
6	Parroquia d'Andorra la Vella	07	1	2020-03-23 17:08:48.467835	2020-03-23 17:08:48.467835
7	Parroquia d'Escaldes-Engordany	08	1	2020-03-23 17:08:48.469761	2020-03-23 17:08:48.469761
8	Umm al Qaywayn	07	2	2020-03-23 17:08:48.471811	2020-03-23 17:08:48.471811
9	Raʼs al Khaymah	05	2	2020-03-23 17:08:48.474037	2020-03-23 17:08:48.474037
10	Dubayy	03	2	2020-03-23 17:08:48.47616	2020-03-23 17:08:48.47616
11	Ash Shāriqah	06	2	2020-03-23 17:08:48.478166	2020-03-23 17:08:48.478166
12	Al Fujayrah	04	2	2020-03-23 17:08:48.479959	2020-03-23 17:08:48.479959
13	Ajman	02	2	2020-03-23 17:08:48.493542	2020-03-23 17:08:48.493542
14	Abū Z̧aby	01	2	2020-03-23 17:08:48.536094	2020-03-23 17:08:48.536094
15	Zabul	28	3	2020-03-23 17:08:48.539204	2020-03-23 17:08:48.539204
16	Vardak	27	3	2020-03-23 17:08:48.543129	2020-03-23 17:08:48.543129
17	Takhār	26	3	2020-03-23 17:08:48.545442	2020-03-23 17:08:48.545442
18	Sar-e Pol	33	3	2020-03-23 17:08:48.5478	2020-03-23 17:08:48.5478
19	Samangān	32	3	2020-03-23 17:08:48.550175	2020-03-23 17:08:48.550175
20	Parvān	40	3	2020-03-23 17:08:48.552416	2020-03-23 17:08:48.552416
21	Paktīkā	29	3	2020-03-23 17:08:48.554466	2020-03-23 17:08:48.554466
22	Paktia	36	3	2020-03-23 17:08:48.556871	2020-03-23 17:08:48.556871
23	Orūzgān	39	3	2020-03-23 17:08:48.558683	2020-03-23 17:08:48.558683
24	Nīmrūz	19	3	2020-03-23 17:08:48.560764	2020-03-23 17:08:48.560764
25	Nangarhār	18	3	2020-03-23 17:08:48.562948	2020-03-23 17:08:48.562948
26	Lowgar	17	3	2020-03-23 17:08:48.565501	2020-03-23 17:08:48.565501
27	Laghmān	35	3	2020-03-23 17:08:48.567705	2020-03-23 17:08:48.567705
28	Kunduz	24	3	2020-03-23 17:08:48.570126	2020-03-23 17:08:48.570126
29	Konar	34	3	2020-03-23 17:08:48.573882	2020-03-23 17:08:48.573882
30	Kāpīsā	14	3	2020-03-23 17:08:48.576358	2020-03-23 17:08:48.576358
31	Kandahār	23	3	2020-03-23 17:08:48.579332	2020-03-23 17:08:48.579332
32	Kabul	13	3	2020-03-23 17:08:48.581893	2020-03-23 17:08:48.581893
33	Jowzjān	31	3	2020-03-23 17:08:48.58419	2020-03-23 17:08:48.58419
34	Herat	11	3	2020-03-23 17:08:48.586567	2020-03-23 17:08:48.586567
35	Helmand	10	3	2020-03-23 17:08:48.589111	2020-03-23 17:08:48.589111
36	Ghowr	09	3	2020-03-23 17:08:48.591631	2020-03-23 17:08:48.591631
37	Ghaznī	08	3	2020-03-23 17:08:48.593925	2020-03-23 17:08:48.593925
38	Faryab	07	3	2020-03-23 17:08:48.596379	2020-03-23 17:08:48.596379
39	Farah	06	3	2020-03-23 17:08:48.59864	2020-03-23 17:08:48.59864
40	Bāmīān	05	3	2020-03-23 17:08:48.600953	2020-03-23 17:08:48.600953
41	Balkh	30	3	2020-03-23 17:08:48.603096	2020-03-23 17:08:48.603096
42	Baghlān	03	3	2020-03-23 17:08:48.605895	2020-03-23 17:08:48.605895
43	Badghis	02	3	2020-03-23 17:08:48.608145	2020-03-23 17:08:48.608145
44	Badakhshan	01	3	2020-03-23 17:08:48.610375	2020-03-23 17:08:48.610375
45	Khowst	37	3	2020-03-23 17:08:48.613942	2020-03-23 17:08:48.613942
46	Nūrestān	38	3	2020-03-23 17:08:48.615973	2020-03-23 17:08:48.615973
47	Wilāyat-e Dāykundī	41	3	2020-03-23 17:08:48.618072	2020-03-23 17:08:48.618072
48	Panjshir	42	3	2020-03-23 17:08:48.620475	2020-03-23 17:08:48.620475
49	Saint Philip	08	4	2020-03-23 17:08:48.622459	2020-03-23 17:08:48.622459
50	Saint Peter	07	4	2020-03-23 17:08:48.624361	2020-03-23 17:08:48.624361
51	Saint Paul	06	4	2020-03-23 17:08:48.62647	2020-03-23 17:08:48.62647
52	Saint Mary	05	4	2020-03-23 17:08:48.629052	2020-03-23 17:08:48.629052
53	Saint John	04	4	2020-03-23 17:08:48.631422	2020-03-23 17:08:48.631422
54	Saint George	03	4	2020-03-23 17:08:48.634166	2020-03-23 17:08:48.634166
55	Redonda	09	4	2020-03-23 17:08:48.636773	2020-03-23 17:08:48.636773
56	Barbuda	01	4	2020-03-23 17:08:48.638645	2020-03-23 17:08:48.638645
57	Berat	40	6	2020-03-23 17:08:48.640709	2020-03-23 17:08:48.640709
58	Dibër	41	6	2020-03-23 17:08:48.643045	2020-03-23 17:08:48.643045
59	Elbasan	43	6	2020-03-23 17:08:48.645846	2020-03-23 17:08:48.645846
60	Gjirokastër	45	6	2020-03-23 17:08:48.647834	2020-03-23 17:08:48.647834
61	Korçë	46	6	2020-03-23 17:08:48.650026	2020-03-23 17:08:48.650026
62	Kukës	47	6	2020-03-23 17:08:48.653309	2020-03-23 17:08:48.653309
63	Durrës	42	6	2020-03-23 17:08:48.655276	2020-03-23 17:08:48.655276
64	Fier	44	6	2020-03-23 17:08:48.657222	2020-03-23 17:08:48.657222
65	Lezhë	48	6	2020-03-23 17:08:48.659122	2020-03-23 17:08:48.659122
66	Shkodër	49	6	2020-03-23 17:08:48.661805	2020-03-23 17:08:48.661805
67	Tiranë	50	6	2020-03-23 17:08:48.663857	2020-03-23 17:08:48.663857
68	Vlorë	51	6	2020-03-23 17:08:48.665808	2020-03-23 17:08:48.665808
69	Ararat	02	7	2020-03-23 17:08:48.667899	2020-03-23 17:08:48.667899
70	Syunikʼ	08	7	2020-03-23 17:08:48.670201	2020-03-23 17:08:48.670201
71	Vayotsʼ Dzor	10	7	2020-03-23 17:08:48.672414	2020-03-23 17:08:48.672414
72	Yerevan	11	7	2020-03-23 17:08:48.674342	2020-03-23 17:08:48.674342
73	Aragatsotn	01	7	2020-03-23 17:08:48.676502	2020-03-23 17:08:48.676502
74	Armavir	03	7	2020-03-23 17:08:48.678362	2020-03-23 17:08:48.678362
75	Gegharkʼunikʼ	04	7	2020-03-23 17:08:48.680142	2020-03-23 17:08:48.680142
76	Kotaykʼ	05	7	2020-03-23 17:08:48.681994	2020-03-23 17:08:48.681994
77	Lorri	06	7	2020-03-23 17:08:48.684171	2020-03-23 17:08:48.684171
78	Shirak	07	7	2020-03-23 17:08:48.686603	2020-03-23 17:08:48.686603
79	Tavush	09	7	2020-03-23 17:08:48.688641	2020-03-23 17:08:48.688641
80	Lunda Sul	18	8	2020-03-23 17:08:48.690499	2020-03-23 17:08:48.690499
81	Lunda Norte	17	8	2020-03-23 17:08:48.693003	2020-03-23 17:08:48.693003
82	Moxico	14	8	2020-03-23 17:08:48.69503	2020-03-23 17:08:48.69503
83	Cuando Cubango	04	8	2020-03-23 17:08:48.697147	2020-03-23 17:08:48.697147
84	Zaire	16	8	2020-03-23 17:08:48.699252	2020-03-23 17:08:48.699252
85	Uíge	15	8	2020-03-23 17:08:48.701442	2020-03-23 17:08:48.701442
86	Malanje	12	8	2020-03-23 17:08:48.703411	2020-03-23 17:08:48.703411
87	Luanda	20	8	2020-03-23 17:08:48.705584	2020-03-23 17:08:48.705584
88	Cuanza Norte	05	8	2020-03-23 17:08:48.707767	2020-03-23 17:08:48.707767
89	Cabinda	03	8	2020-03-23 17:08:48.709901	2020-03-23 17:08:48.709901
90	Bengo	19	8	2020-03-23 17:08:48.71247	2020-03-23 17:08:48.71247
91	Namibe	13	8	2020-03-23 17:08:48.714909	2020-03-23 17:08:48.714909
92	Huíla	09	8	2020-03-23 17:08:48.717264	2020-03-23 17:08:48.717264
93	Huambo	08	8	2020-03-23 17:08:48.719427	2020-03-23 17:08:48.719427
94	Cunene	07	8	2020-03-23 17:08:48.721402	2020-03-23 17:08:48.721402
95	Cuanza Sul	06	8	2020-03-23 17:08:48.723633	2020-03-23 17:08:48.723633
96	Bié	02	8	2020-03-23 17:08:48.725882	2020-03-23 17:08:48.725882
97	Benguela	01	8	2020-03-23 17:08:48.727959	2020-03-23 17:08:48.727959
98	Misiones	14	10	2020-03-23 17:08:48.73101	2020-03-23 17:08:48.73101
99	Formosa	09	10	2020-03-23 17:08:48.734872	2020-03-23 17:08:48.734872
100	Buenos Aires F.D.	07	10	2020-03-23 17:08:48.73706	2020-03-23 17:08:48.73706
101	Entre Ríos	08	10	2020-03-23 17:08:48.73947	2020-03-23 17:08:48.73947
102	Corrientes	06	10	2020-03-23 17:08:48.741836	2020-03-23 17:08:48.741836
103	Buenos Aires	01	10	2020-03-23 17:08:48.743717	2020-03-23 17:08:48.743717
104	Tucumán	24	10	2020-03-23 17:08:48.74569	2020-03-23 17:08:48.74569
105	Tierra del Fuego	23	10	2020-03-23 17:08:48.747944	2020-03-23 17:08:48.747944
106	Santiago del Estero	22	10	2020-03-23 17:08:48.750207	2020-03-23 17:08:48.750207
107	Santa Fe	21	10	2020-03-23 17:08:48.752481	2020-03-23 17:08:48.752481
108	Santa Cruz	20	10	2020-03-23 17:08:48.7547	2020-03-23 17:08:48.7547
109	San Luis	19	10	2020-03-23 17:08:48.757131	2020-03-23 17:08:48.757131
110	San Juan	18	10	2020-03-23 17:08:48.759212	2020-03-23 17:08:48.759212
111	Salta	17	10	2020-03-23 17:08:48.761217	2020-03-23 17:08:48.761217
112	Río Negro	16	10	2020-03-23 17:08:48.763479	2020-03-23 17:08:48.763479
113	Neuquén	15	10	2020-03-23 17:08:48.766127	2020-03-23 17:08:48.766127
114	Mendoza	13	10	2020-03-23 17:08:48.768276	2020-03-23 17:08:48.768276
115	La Rioja	12	10	2020-03-23 17:08:48.7706	2020-03-23 17:08:48.7706
116	La Pampa	11	10	2020-03-23 17:08:48.773977	2020-03-23 17:08:48.773977
117	Jujuy	10	10	2020-03-23 17:08:48.775916	2020-03-23 17:08:48.775916
118	Córdoba	05	10	2020-03-23 17:08:48.777906	2020-03-23 17:08:48.777906
119	Chubut	04	10	2020-03-23 17:08:48.780167	2020-03-23 17:08:48.780167
120	Chaco	03	10	2020-03-23 17:08:48.782391	2020-03-23 17:08:48.782391
121	Catamarca	02	10	2020-03-23 17:08:48.784489	2020-03-23 17:08:48.784489
122	Western District	050	11	2020-03-23 17:08:48.786533	2020-03-23 17:08:48.786533
123	Rose Island (inactive)	030	11	2020-03-23 17:08:48.788473	2020-03-23 17:08:48.788473
124	Swains Island	040	11	2020-03-23 17:08:48.790872	2020-03-23 17:08:48.790872
125	Eastern District	010	11	2020-03-23 17:08:48.793697	2020-03-23 17:08:48.793697
126	Manu'a	020	11	2020-03-23 17:08:48.796767	2020-03-23 17:08:48.796767
127	Vienna	09	12	2020-03-23 17:08:48.799446	2020-03-23 17:08:48.799446
128	Vorarlberg	08	12	2020-03-23 17:08:48.801735	2020-03-23 17:08:48.801735
129	Tyrol	07	12	2020-03-23 17:08:48.804083	2020-03-23 17:08:48.804083
130	Styria	06	12	2020-03-23 17:08:48.806883	2020-03-23 17:08:48.806883
131	Salzburg	05	12	2020-03-23 17:08:48.808972	2020-03-23 17:08:48.808972
132	Upper Austria	04	12	2020-03-23 17:08:48.811565	2020-03-23 17:08:48.811565
133	Lower Austria	03	12	2020-03-23 17:08:48.814584	2020-03-23 17:08:48.814584
134	Carinthia	02	12	2020-03-23 17:08:48.817302	2020-03-23 17:08:48.817302
135	Burgenland	01	12	2020-03-23 17:08:48.819893	2020-03-23 17:08:48.819893
136	Western Australia	08	13	2020-03-23 17:08:48.822185	2020-03-23 17:08:48.822185
137	South Australia	05	13	2020-03-23 17:08:48.824727	2020-03-23 17:08:48.824727
138	Northern Territory	03	13	2020-03-23 17:08:48.827451	2020-03-23 17:08:48.827451
139	Victoria	07	13	2020-03-23 17:08:48.830076	2020-03-23 17:08:48.830076
140	Tasmania	06	13	2020-03-23 17:08:48.832562	2020-03-23 17:08:48.832562
141	Queensland	04	13	2020-03-23 17:08:48.835196	2020-03-23 17:08:48.835196
142	New South Wales	02	13	2020-03-23 17:08:48.837783	2020-03-23 17:08:48.837783
143	Australian Capital Territory	01	13	2020-03-23 17:08:48.839943	2020-03-23 17:08:48.839943
144	Vårdö	941	15	2020-03-23 17:08:48.842203	2020-03-23 17:08:48.842203
145	Sund	771	15	2020-03-23 17:08:48.844633	2020-03-23 17:08:48.844633
146	Sottunga	766	15	2020-03-23 17:08:48.847146	2020-03-23 17:08:48.847146
147	Saltvik	736	15	2020-03-23 17:08:48.849563	2020-03-23 17:08:48.849563
148	Lumparland	438	15	2020-03-23 17:08:48.853577	2020-03-23 17:08:48.853577
149	Lemland	417	15	2020-03-23 17:08:48.85667	2020-03-23 17:08:48.85667
150	Kumlinge	295	15	2020-03-23 17:08:48.85941	2020-03-23 17:08:48.85941
151	Kökar	318	15	2020-03-23 17:08:48.862293	2020-03-23 17:08:48.862293
152	Föglö	062	15	2020-03-23 17:08:48.864727	2020-03-23 17:08:48.864727
153	Brändö	035	15	2020-03-23 17:08:48.867464	2020-03-23 17:08:48.867464
154	Mariehamn	478	15	2020-03-23 17:08:48.870039	2020-03-23 17:08:48.870039
155	Jomala	170	15	2020-03-23 17:08:48.873152	2020-03-23 17:08:48.873152
156	Hammarland	076	15	2020-03-23 17:08:48.875004	2020-03-23 17:08:48.875004
157	Geta	065	15	2020-03-23 17:08:48.877013	2020-03-23 17:08:48.877013
158	Finström	060	15	2020-03-23 17:08:48.87902	2020-03-23 17:08:48.87902
159	Eckerö	043	15	2020-03-23 17:08:48.880987	2020-03-23 17:08:48.880987
160	Zǝngilan	69	16	2020-03-23 17:08:48.883118	2020-03-23 17:08:48.883118
161	Yardımlı	66	16	2020-03-23 17:08:48.885895	2020-03-23 17:08:48.885895
162	Şuşa	55	16	2020-03-23 17:08:48.888281	2020-03-23 17:08:48.888281
163	Salyan	49	16	2020-03-23 17:08:48.890319	2020-03-23 17:08:48.890319
164	Sabirabad	46	16	2020-03-23 17:08:48.892964	2020-03-23 17:08:48.892964
165	Saatlı	45	16	2020-03-23 17:08:48.895296	2020-03-23 17:08:48.895296
166	Neftçala	36	16	2020-03-23 17:08:48.897454	2020-03-23 17:08:48.897454
167	Nakhichevan	35	16	2020-03-23 17:08:48.899477	2020-03-23 17:08:48.899477
168	Masallı	32	16	2020-03-23 17:08:48.901952	2020-03-23 17:08:48.901952
169	Lerik	31	16	2020-03-23 17:08:48.904006	2020-03-23 17:08:48.904006
170	Lənkəran	29	16	2020-03-23 17:08:48.905995	2020-03-23 17:08:48.905995
171	Laçın	28	16	2020-03-23 17:08:48.908057	2020-03-23 17:08:48.908057
172	Qubadlı	43	16	2020-03-23 17:08:48.910451	2020-03-23 17:08:48.910451
173	İmişli	24	16	2020-03-23 17:08:48.913201	2020-03-23 17:08:48.913201
174	Füzuli	18	16	2020-03-23 17:08:48.915981	2020-03-23 17:08:48.915981
175	Cǝbrayıl	14	16	2020-03-23 17:08:48.917966	2020-03-23 17:08:48.917966
176	Cəlilabad	15	16	2020-03-23 17:08:48.920379	2020-03-23 17:08:48.920379
177	Astara	08	16	2020-03-23 17:08:48.922557	2020-03-23 17:08:48.922557
178	Xocalı	64	16	2020-03-23 17:08:48.92489	2020-03-23 17:08:48.92489
179	Ağcabǝdi	02	16	2020-03-23 17:08:48.927196	2020-03-23 17:08:48.927196
180	Ağdam	03	16	2020-03-23 17:08:48.929191	2020-03-23 17:08:48.929191
181	Əli Bayramli	07	16	2020-03-23 17:08:48.931645	2020-03-23 17:08:48.931645
182	Lənkəran Şəhəri	30	16	2020-03-23 17:08:48.934575	2020-03-23 17:08:48.934575
183	Şuşa Şəhəri	56	16	2020-03-23 17:08:48.936479	2020-03-23 17:08:48.936479
184	Tǝrtǝr	57	16	2020-03-23 17:08:48.93841	2020-03-23 17:08:48.93841
185	Xankǝndi	61	16	2020-03-23 17:08:48.940414	2020-03-23 17:08:48.940414
186	Xocavǝnd	65	16	2020-03-23 17:08:48.942548	2020-03-23 17:08:48.942548
187	Zərdab	71	16	2020-03-23 17:08:48.944649	2020-03-23 17:08:48.944649
188	Zaqatala	70	16	2020-03-23 17:08:48.947165	2020-03-23 17:08:48.947165
189	Yevlax	67	16	2020-03-23 17:08:48.949525	2020-03-23 17:08:48.949525
190	Oğuz	37	16	2020-03-23 17:08:48.951216	2020-03-23 17:08:48.951216
191	Ucar	59	16	2020-03-23 17:08:48.954184	2020-03-23 17:08:48.954184
192	Tovuz	58	16	2020-03-23 17:08:48.9565	2020-03-23 17:08:48.9565
193	Şamaxı	50	16	2020-03-23 17:08:48.958706	2020-03-23 17:08:48.958706
194	Şǝki	47	16	2020-03-23 17:08:48.961342	2020-03-23 17:08:48.961342
195	Şǝmkir	51	16	2020-03-23 17:08:48.963804	2020-03-23 17:08:48.963804
196	Kürdǝmir	27	16	2020-03-23 17:08:48.966506	2020-03-23 17:08:48.966506
197	Qǝbǝlǝ	38	16	2020-03-23 17:08:48.969207	2020-03-23 17:08:48.969207
198	Qusar	44	16	2020-03-23 17:08:48.983086	2020-03-23 17:08:48.983086
199	Quba	42	16	2020-03-23 17:08:48.985484	2020-03-23 17:08:48.985484
200	Xanlar	62	16	2020-03-23 17:08:48.988157	2020-03-23 17:08:48.988157
201	Xaçmaz	60	16	2020-03-23 17:08:48.990245	2020-03-23 17:08:48.990245
202	Kǝlbǝcǝr	26	16	2020-03-23 17:08:48.992731	2020-03-23 17:08:48.992731
203	Qazax	40	16	2020-03-23 17:08:48.995333	2020-03-23 17:08:48.995333
204	Goranboy	21	16	2020-03-23 17:08:48.997534	2020-03-23 17:08:48.997534
205	Qǝx	39	16	2020-03-23 17:08:48.999595	2020-03-23 17:08:48.999595
206	İsmayıllı	25	16	2020-03-23 17:08:49.001693	2020-03-23 17:08:49.001693
207	Göyçay	22	16	2020-03-23 17:08:49.004458	2020-03-23 17:08:49.004458
208	Dǝvǝçi	17	16	2020-03-23 17:08:49.006376	2020-03-23 17:08:49.006376
209	Daşkǝsǝn	16	16	2020-03-23 17:08:49.008192	2020-03-23 17:08:49.008192
210	Balakǝn	10	16	2020-03-23 17:08:49.010479	2020-03-23 17:08:49.010479
211	Bǝrdǝ	11	16	2020-03-23 17:08:49.017396	2020-03-23 17:08:49.017396
212	Baki	09	16	2020-03-23 17:08:49.020332	2020-03-23 17:08:49.020332
213	Abşeron	01	16	2020-03-23 17:08:49.023314	2020-03-23 17:08:49.023314
214	Ağsu	06	16	2020-03-23 17:08:49.025717	2020-03-23 17:08:49.025717
215	Ağdaş	04	16	2020-03-23 17:08:49.030561	2020-03-23 17:08:49.030561
216	Gǝdǝbǝy	19	16	2020-03-23 17:08:49.036013	2020-03-23 17:08:49.036013
217	Ağstafa	05	16	2020-03-23 17:08:49.03891	2020-03-23 17:08:49.03891
218	Gǝncǝ	20	16	2020-03-23 17:08:49.041816	2020-03-23 17:08:49.041816
219	Mingǝcevir	33	16	2020-03-23 17:08:49.048539	2020-03-23 17:08:49.048539
220	Naftalan	34	16	2020-03-23 17:08:49.055123	2020-03-23 17:08:49.055123
221	Qobustan	41	16	2020-03-23 17:08:49.057377	2020-03-23 17:08:49.057377
222	Samux	52	16	2020-03-23 17:08:49.05991	2020-03-23 17:08:49.05991
223	Shaki City	48	16	2020-03-23 17:08:49.062613	2020-03-23 17:08:49.062613
224	Siyǝzǝn	53	16	2020-03-23 17:08:49.064637	2020-03-23 17:08:49.064637
225	Sumqayit	54	16	2020-03-23 17:08:49.066791	2020-03-23 17:08:49.066791
226	Xızı	63	16	2020-03-23 17:08:49.068933	2020-03-23 17:08:49.068933
227	Yevlax City	68	16	2020-03-23 17:08:49.071231	2020-03-23 17:08:49.071231
228	Hacıqabul	23	16	2020-03-23 17:08:49.073997	2020-03-23 17:08:49.073997
229	Babek	BAB	16	2020-03-23 17:08:49.075894	2020-03-23 17:08:49.075894
230	Federation of Bosnia and Herzegovina	01	17	2020-03-23 17:08:49.078505	2020-03-23 17:08:49.078505
231	Republika Srpska	02	17	2020-03-23 17:08:49.080526	2020-03-23 17:08:49.080526
232	Brčko	BRC	17	2020-03-23 17:08:49.082452	2020-03-23 17:08:49.082452
233	Saint Thomas	11	18	2020-03-23 17:08:49.084731	2020-03-23 17:08:49.084731
234	Saint Philip	10	18	2020-03-23 17:08:49.086743	2020-03-23 17:08:49.086743
235	Saint Peter	09	18	2020-03-23 17:08:49.088423	2020-03-23 17:08:49.088423
236	Saint Michael	08	18	2020-03-23 17:08:49.090301	2020-03-23 17:08:49.090301
237	Saint Lucy	07	18	2020-03-23 17:08:49.093022	2020-03-23 17:08:49.093022
238	Saint Joseph	06	18	2020-03-23 17:08:49.095423	2020-03-23 17:08:49.095423
239	Saint John	05	18	2020-03-23 17:08:49.097683	2020-03-23 17:08:49.097683
240	Saint James	04	18	2020-03-23 17:08:49.108077	2020-03-23 17:08:49.108077
241	Saint George	03	18	2020-03-23 17:08:49.110372	2020-03-23 17:08:49.110372
242	Saint Andrew	02	18	2020-03-23 17:08:49.113186	2020-03-23 17:08:49.113186
243	Christ Church	01	18	2020-03-23 17:08:49.114954	2020-03-23 17:08:49.114954
244	Rājshāhi	83	19	2020-03-23 17:08:49.116968	2020-03-23 17:08:49.116968
245	Dhaka	81	19	2020-03-23 17:08:49.11899	2020-03-23 17:08:49.11899
246	Chittagong	84	19	2020-03-23 17:08:49.120876	2020-03-23 17:08:49.120876
247	Khulna	82	19	2020-03-23 17:08:49.123008	2020-03-23 17:08:49.123008
248	Barisāl	85	19	2020-03-23 17:08:49.125024	2020-03-23 17:08:49.125024
249	Sylhet	86	19	2020-03-23 17:08:49.127144	2020-03-23 17:08:49.127144
250	Rangpur Division	87	19	2020-03-23 17:08:49.128775	2020-03-23 17:08:49.128775
251	Brussels Capital Region	BRU	20	2020-03-23 17:08:49.130283	2020-03-23 17:08:49.130283
252	Walloon Region	WAL	20	2020-03-23 17:08:49.132344	2020-03-23 17:08:49.132344
253	Flanders	VLG	20	2020-03-23 17:08:49.13452	2020-03-23 17:08:49.13452
254	Boucle du Mouhoun	01	21	2020-03-23 17:08:49.136371	2020-03-23 17:08:49.136371
255	Cascades	02	21	2020-03-23 17:08:49.138201	2020-03-23 17:08:49.138201
256	Centre	03	21	2020-03-23 17:08:49.140298	2020-03-23 17:08:49.140298
257	Centre-Est	04	21	2020-03-23 17:08:49.143137	2020-03-23 17:08:49.143137
258	Centre-Nord	05	21	2020-03-23 17:08:49.145576	2020-03-23 17:08:49.145576
259	Centre-Ouest	06	21	2020-03-23 17:08:49.147566	2020-03-23 17:08:49.147566
260	Centre-Sud	07	21	2020-03-23 17:08:49.150274	2020-03-23 17:08:49.150274
261	Est	08	21	2020-03-23 17:08:49.152314	2020-03-23 17:08:49.152314
262	Hauts-Bassins	09	21	2020-03-23 17:08:49.154346	2020-03-23 17:08:49.154346
263	Nord	10	21	2020-03-23 17:08:49.156289	2020-03-23 17:08:49.156289
264	Plateau-Central	11	21	2020-03-23 17:08:49.158642	2020-03-23 17:08:49.158642
265	Sahel	12	21	2020-03-23 17:08:49.160489	2020-03-23 17:08:49.160489
266	Sud-Ouest	13	21	2020-03-23 17:08:49.162364	2020-03-23 17:08:49.162364
267	Razgrad	52	22	2020-03-23 17:08:49.163948	2020-03-23 17:08:49.163948
268	Montana	47	22	2020-03-23 17:08:49.165955	2020-03-23 17:08:49.165955
269	Vratsa	64	22	2020-03-23 17:08:49.167589	2020-03-23 17:08:49.167589
270	Varna	61	22	2020-03-23 17:08:49.169335	2020-03-23 17:08:49.169335
271	Dobrich	40	22	2020-03-23 17:08:49.170836	2020-03-23 17:08:49.170836
272	Sofiya	58	22	2020-03-23 17:08:49.172857	2020-03-23 17:08:49.172857
273	Ruse	53	22	2020-03-23 17:08:49.174742	2020-03-23 17:08:49.174742
274	Plovdiv	51	22	2020-03-23 17:08:49.176478	2020-03-23 17:08:49.176478
275	Pleven	50	22	2020-03-23 17:08:49.178293	2020-03-23 17:08:49.178293
276	Pernik	49	22	2020-03-23 17:08:49.180048	2020-03-23 17:08:49.180048
277	Pazardzhit	48	22	2020-03-23 17:08:49.182	2020-03-23 17:08:49.182
278	Lovech	46	22	2020-03-23 17:08:49.183613	2020-03-23 17:08:49.183613
279	Khaskovo	43	22	2020-03-23 17:08:49.185204	2020-03-23 17:08:49.185204
280	Oblast Sofiya-Grad	42	22	2020-03-23 17:08:49.186843	2020-03-23 17:08:49.186843
281	Burgas	39	22	2020-03-23 17:08:49.188549	2020-03-23 17:08:49.188549
282	Blagoevgrad	38	22	2020-03-23 17:08:49.190702	2020-03-23 17:08:49.190702
283	Gabrovo	41	22	2020-03-23 17:08:49.192678	2020-03-23 17:08:49.192678
284	Kŭrdzhali	44	22	2020-03-23 17:08:49.194589	2020-03-23 17:08:49.194589
285	Kyustendil	45	22	2020-03-23 17:08:49.196509	2020-03-23 17:08:49.196509
286	Shumen	54	22	2020-03-23 17:08:49.198784	2020-03-23 17:08:49.198784
287	Silistra	55	22	2020-03-23 17:08:49.200713	2020-03-23 17:08:49.200713
288	Sliven	56	22	2020-03-23 17:08:49.202623	2020-03-23 17:08:49.202623
289	Smolyan	57	22	2020-03-23 17:08:49.204906	2020-03-23 17:08:49.204906
290	Stara Zagora	59	22	2020-03-23 17:08:49.207054	2020-03-23 17:08:49.207054
291	Tŭrgovishte	60	22	2020-03-23 17:08:49.208674	2020-03-23 17:08:49.208674
292	Veliko Tŭrnovo	62	22	2020-03-23 17:08:49.210615	2020-03-23 17:08:49.210615
293	Vidin	63	22	2020-03-23 17:08:49.213121	2020-03-23 17:08:49.213121
294	Yambol	65	22	2020-03-23 17:08:49.21519	2020-03-23 17:08:49.21519
295	Muharraq	15	23	2020-03-23 17:08:49.217201	2020-03-23 17:08:49.217201
296	Capital Governorate	16	23	2020-03-23 17:08:49.219072	2020-03-23 17:08:49.219072
297	Southern Governorate	17	23	2020-03-23 17:08:49.221061	2020-03-23 17:08:49.221061
298	Central Governorate	18	23	2020-03-23 17:08:49.223103	2020-03-23 17:08:49.223103
299	Northern Governorate	19	23	2020-03-23 17:08:49.225096	2020-03-23 17:08:49.225096
300	Makamba	17	24	2020-03-23 17:08:49.226934	2020-03-23 17:08:49.226934
301	Bururi	10	24	2020-03-23 17:08:49.228636	2020-03-23 17:08:49.228636
302	Muramvya	22	24	2020-03-23 17:08:49.230597	2020-03-23 17:08:49.230597
303	Gitega	13	24	2020-03-23 17:08:49.233371	2020-03-23 17:08:49.233371
304	Ruyigi	21	24	2020-03-23 17:08:49.235122	2020-03-23 17:08:49.235122
305	Cankuzo	11	24	2020-03-23 17:08:49.236978	2020-03-23 17:08:49.236978
306	Karuzi	14	24	2020-03-23 17:08:49.238725	2020-03-23 17:08:49.238725
307	Bubanza	09	24	2020-03-23 17:08:49.24037	2020-03-23 17:08:49.24037
308	Cibitoke	12	24	2020-03-23 17:08:49.242144	2020-03-23 17:08:49.242144
309	Ngozi	19	24	2020-03-23 17:08:49.243664	2020-03-23 17:08:49.243664
310	Kayanza	15	24	2020-03-23 17:08:49.245179	2020-03-23 17:08:49.245179
311	Muyinga	18	24	2020-03-23 17:08:49.246918	2020-03-23 17:08:49.246918
312	Kirundo	16	24	2020-03-23 17:08:49.248633	2020-03-23 17:08:49.248633
313	Rutana	20	24	2020-03-23 17:08:49.250382	2020-03-23 17:08:49.250382
314	Mwaro	23	24	2020-03-23 17:08:49.252152	2020-03-23 17:08:49.252152
315	Bujumbura Mairie	24	24	2020-03-23 17:08:49.253776	2020-03-23 17:08:49.253776
316	Bujumbura Rural	25	24	2020-03-23 17:08:49.255511	2020-03-23 17:08:49.255511
317	Zou	18	25	2020-03-23 17:08:49.257378	2020-03-23 17:08:49.257378
318	Quémé	16	25	2020-03-23 17:08:49.259498	2020-03-23 17:08:49.259498
319	Mono	15	25	2020-03-23 17:08:49.261114	2020-03-23 17:08:49.261114
320	Borgou	10	25	2020-03-23 17:08:49.26276	2020-03-23 17:08:49.26276
321	Atlantique	09	25	2020-03-23 17:08:49.264388	2020-03-23 17:08:49.264388
322	Atakora	08	25	2020-03-23 17:08:49.265829	2020-03-23 17:08:49.265829
323	Alibori	07	25	2020-03-23 17:08:49.267318	2020-03-23 17:08:49.267318
324	Collines	11	25	2020-03-23 17:08:49.268861	2020-03-23 17:08:49.268861
325	Kouffo	12	25	2020-03-23 17:08:49.270376	2020-03-23 17:08:49.270376
326	Donga	13	25	2020-03-23 17:08:49.272276	2020-03-23 17:08:49.272276
327	Littoral	14	25	2020-03-23 17:08:49.274198	2020-03-23 17:08:49.274198
328	Plateau	17	25	2020-03-23 17:08:49.276112	2020-03-23 17:08:49.276112
329	Warwick	11	27	2020-03-23 17:08:49.278002	2020-03-23 17:08:49.278002
330	Southampton	10	27	2020-03-23 17:08:49.279717	2020-03-23 17:08:49.279717
331	Smithʼs	09	27	2020-03-23 17:08:49.281395	2020-03-23 17:08:49.281395
332	Sandys	08	27	2020-03-23 17:08:49.283361	2020-03-23 17:08:49.283361
333	Saint Georgeʼs	07	27	2020-03-23 17:08:49.285047	2020-03-23 17:08:49.285047
334	Saint George	06	27	2020-03-23 17:08:49.286703	2020-03-23 17:08:49.286703
335	Pembroke	05	27	2020-03-23 17:08:49.28861	2020-03-23 17:08:49.28861
336	Paget	04	27	2020-03-23 17:08:49.290244	2020-03-23 17:08:49.290244
337	Hamilton Parish	02	27	2020-03-23 17:08:49.291935	2020-03-23 17:08:49.291935
338	Hamilton city	03	27	2020-03-23 17:08:49.294296	2020-03-23 17:08:49.294296
339	Devonshire	01	27	2020-03-23 17:08:49.296065	2020-03-23 17:08:49.296065
340	Tutong	04	28	2020-03-23 17:08:49.297797	2020-03-23 17:08:49.297797
341	Temburong	03	28	2020-03-23 17:08:49.299399	2020-03-23 17:08:49.299399
342	Brunei and Muara	02	28	2020-03-23 17:08:49.301157	2020-03-23 17:08:49.301157
343	Belait	01	28	2020-03-23 17:08:49.303115	2020-03-23 17:08:49.303115
344	Tarija	09	29	2020-03-23 17:08:49.305001	2020-03-23 17:08:49.305001
345	Santa Cruz	08	29	2020-03-23 17:08:49.306805	2020-03-23 17:08:49.306805
346	Potosí	07	29	2020-03-23 17:08:49.30844	2020-03-23 17:08:49.30844
347	Pando	06	29	2020-03-23 17:08:49.310565	2020-03-23 17:08:49.310565
348	Oruro	05	29	2020-03-23 17:08:49.31271	2020-03-23 17:08:49.31271
349	La Paz	04	29	2020-03-23 17:08:49.3147	2020-03-23 17:08:49.3147
350	Cochabamba	02	29	2020-03-23 17:08:49.316858	2020-03-23 17:08:49.316858
351	Chuquisaca	01	29	2020-03-23 17:08:49.319185	2020-03-23 17:08:49.319185
352	El Beni	03	29	2020-03-23 17:08:49.321021	2020-03-23 17:08:49.321021
353	Bonaire	BO	30	2020-03-23 17:08:49.323445	2020-03-23 17:08:49.323445
354	Saba	SB	30	2020-03-23 17:08:49.326331	2020-03-23 17:08:49.326331
355	Sint Eustatius	SE	30	2020-03-23 17:08:49.328388	2020-03-23 17:08:49.328388
356	Rio Grande do Norte	22	31	2020-03-23 17:08:49.330354	2020-03-23 17:08:49.330354
357	Piauí	20	31	2020-03-23 17:08:49.332708	2020-03-23 17:08:49.332708
358	Estado de Pernambuco	30	31	2020-03-23 17:08:49.335415	2020-03-23 17:08:49.335415
359	Paraíba	17	31	2020-03-23 17:08:49.337328	2020-03-23 17:08:49.337328
360	Pará	16	31	2020-03-23 17:08:49.339167	2020-03-23 17:08:49.339167
361	Maranhão	13	31	2020-03-23 17:08:49.341298	2020-03-23 17:08:49.341298
362	Ceará	06	31	2020-03-23 17:08:49.343684	2020-03-23 17:08:49.343684
363	Amapá	03	31	2020-03-23 17:08:49.34622	2020-03-23 17:08:49.34622
364	Alagoas	02	31	2020-03-23 17:08:49.348284	2020-03-23 17:08:49.348284
365	Sergipe	28	31	2020-03-23 17:08:49.350694	2020-03-23 17:08:49.350694
366	São Paulo	27	31	2020-03-23 17:08:49.352981	2020-03-23 17:08:49.352981
367	Santa Catarina	26	31	2020-03-23 17:08:49.355036	2020-03-23 17:08:49.355036
368	Rio Grande do Sul	23	31	2020-03-23 17:08:49.357284	2020-03-23 17:08:49.357284
369	Rio de Janeiro	21	31	2020-03-23 17:08:49.360745	2020-03-23 17:08:49.360745
370	Paraná	18	31	2020-03-23 17:08:49.362901	2020-03-23 17:08:49.362901
371	Estado de Minas Gerais	15	31	2020-03-23 17:08:49.364914	2020-03-23 17:08:49.364914
372	Mato Grosso do Sul	11	31	2020-03-23 17:08:49.368313	2020-03-23 17:08:49.368313
373	Mato Grosso	14	31	2020-03-23 17:08:49.370558	2020-03-23 17:08:49.370558
374	Goiás	29	31	2020-03-23 17:08:49.373299	2020-03-23 17:08:49.373299
375	Distrito Federal	07	31	2020-03-23 17:08:49.375996	2020-03-23 17:08:49.375996
376	Estado de Espírito Santo	08	31	2020-03-23 17:08:49.378213	2020-03-23 17:08:49.378213
377	Bahia	05	31	2020-03-23 17:08:49.380695	2020-03-23 17:08:49.380695
378	Tocantins	31	31	2020-03-23 17:08:49.383272	2020-03-23 17:08:49.383272
379	Roraima	25	31	2020-03-23 17:08:49.385563	2020-03-23 17:08:49.385563
380	Amazonas	04	31	2020-03-23 17:08:49.387838	2020-03-23 17:08:49.387838
381	Acre	01	31	2020-03-23 17:08:49.390571	2020-03-23 17:08:49.390571
382	Rondônia	24	31	2020-03-23 17:08:49.392507	2020-03-23 17:08:49.392507
383	San Salvador and Rum Cay	35	32	2020-03-23 17:08:49.39471	2020-03-23 17:08:49.39471
384	Sandy Point	34	32	2020-03-23 17:08:49.396767	2020-03-23 17:08:49.396767
385	Rock Sound	33	32	2020-03-23 17:08:49.399153	2020-03-23 17:08:49.399153
386	Ragged Island	18	32	2020-03-23 17:08:49.401114	2020-03-23 17:08:49.401114
387	Nichollstown and Berry Islands	32	32	2020-03-23 17:08:49.403067	2020-03-23 17:08:49.403067
388	New Providence	23	32	2020-03-23 17:08:49.405042	2020-03-23 17:08:49.405042
389	Mayaguana	16	32	2020-03-23 17:08:49.407604	2020-03-23 17:08:49.407604
390	Marsh Harbour	31	32	2020-03-23 17:08:49.409761	2020-03-23 17:08:49.409761
391	Long Island	15	32	2020-03-23 17:08:49.411685	2020-03-23 17:08:49.411685
392	Kemps Bay	30	32	2020-03-23 17:08:49.414193	2020-03-23 17:08:49.414193
393	Inagua	13	32	2020-03-23 17:08:49.416409	2020-03-23 17:08:49.416409
394	High Rock	29	32	2020-03-23 17:08:49.418595	2020-03-23 17:08:49.418595
395	Harbour Island	22	32	2020-03-23 17:08:49.420769	2020-03-23 17:08:49.420769
396	Green Turtle Cay	28	32	2020-03-23 17:08:49.423228	2020-03-23 17:08:49.423228
397	Governorʼs Harbour	27	32	2020-03-23 17:08:49.425531	2020-03-23 17:08:49.425531
398	Fresh Creek	26	32	2020-03-23 17:08:49.427998	2020-03-23 17:08:49.427998
399	Freeport	25	32	2020-03-23 17:08:49.430278	2020-03-23 17:08:49.430278
400	Exuma	10	32	2020-03-23 17:08:49.432508	2020-03-23 17:08:49.432508
401	Cat Island	06	32	2020-03-23 17:08:49.434815	2020-03-23 17:08:49.434815
402	Bimini	05	32	2020-03-23 17:08:49.437124	2020-03-23 17:08:49.437124
403	Acklins and Crooked Islands	24	32	2020-03-23 17:08:49.439746	2020-03-23 17:08:49.439746
404	Bumthang	05	33	2020-03-23 17:08:49.442011	2020-03-23 17:08:49.442011
405	Chhukha	06	33	2020-03-23 17:08:49.444184	2020-03-23 17:08:49.444184
406	Daga	08	33	2020-03-23 17:08:49.446526	2020-03-23 17:08:49.446526
407	Chirang	07	33	2020-03-23 17:08:49.448594	2020-03-23 17:08:49.448594
408	Geylegphug	09	33	2020-03-23 17:08:49.45063	2020-03-23 17:08:49.45063
409	Ha	10	33	2020-03-23 17:08:49.453653	2020-03-23 17:08:49.453653
410	Lhuntshi	11	33	2020-03-23 17:08:49.455978	2020-03-23 17:08:49.455978
411	Mongar	12	33	2020-03-23 17:08:49.457987	2020-03-23 17:08:49.457987
412	Paro	13	33	2020-03-23 17:08:49.459858	2020-03-23 17:08:49.459858
413	Pemagatsel	14	33	2020-03-23 17:08:49.46194	2020-03-23 17:08:49.46194
414	Punakha	15	33	2020-03-23 17:08:49.464084	2020-03-23 17:08:49.464084
415	Samchi	16	33	2020-03-23 17:08:49.466734	2020-03-23 17:08:49.466734
416	Samdrup Jongkhar	17	33	2020-03-23 17:08:49.468899	2020-03-23 17:08:49.468899
417	Shemgang	18	33	2020-03-23 17:08:49.471074	2020-03-23 17:08:49.471074
418	Tashigang	19	33	2020-03-23 17:08:49.473605	2020-03-23 17:08:49.473605
419	Thimphu	20	33	2020-03-23 17:08:49.475797	2020-03-23 17:08:49.475797
420	Tongsa	21	33	2020-03-23 17:08:49.478358	2020-03-23 17:08:49.478358
421	Wangdi Phodrang	22	33	2020-03-23 17:08:49.480058	2020-03-23 17:08:49.480058
422	Gasa	23	33	2020-03-23 17:08:49.482558	2020-03-23 17:08:49.482558
423	Trashi Yangste	24	33	2020-03-23 17:08:49.484425	2020-03-23 17:08:49.484425
424	Southern	10	35	2020-03-23 17:08:49.486899	2020-03-23 17:08:49.486899
425	South East	09	35	2020-03-23 17:08:49.488756	2020-03-23 17:08:49.488756
426	North East	08	35	2020-03-23 17:08:49.49096	2020-03-23 17:08:49.49096
427	North West	11	35	2020-03-23 17:08:49.493588	2020-03-23 17:08:49.493588
428	Kweneng	06	35	2020-03-23 17:08:49.495788	2020-03-23 17:08:49.495788
429	Kgatleng	05	35	2020-03-23 17:08:49.497644	2020-03-23 17:08:49.497644
430	Kgalagadi	04	35	2020-03-23 17:08:49.499496	2020-03-23 17:08:49.499496
431	Ghanzi	03	35	2020-03-23 17:08:49.501653	2020-03-23 17:08:49.501653
432	Central	01	35	2020-03-23 17:08:49.503352	2020-03-23 17:08:49.503352
433	Vitsyebskaya Voblastsʼ	07	36	2020-03-23 17:08:49.505197	2020-03-23 17:08:49.505197
434	Mahilyowskaya Voblastsʼ	06	36	2020-03-23 17:08:49.50716	2020-03-23 17:08:49.50716
435	Minskaya Voblastsʼ	05	36	2020-03-23 17:08:49.509016	2020-03-23 17:08:49.509016
436	Horad Minsk	04	36	2020-03-23 17:08:49.51099	2020-03-23 17:08:49.51099
437	Hrodzyenskaya Voblastsʼ	03	36	2020-03-23 17:08:49.514032	2020-03-23 17:08:49.514032
438	Homyelʼskaya Voblastsʼ	02	36	2020-03-23 17:08:49.515733	2020-03-23 17:08:49.515733
439	Brestskaya Voblastsʼ	01	36	2020-03-23 17:08:49.518356	2020-03-23 17:08:49.518356
440	Toledo	06	37	2020-03-23 17:08:49.520309	2020-03-23 17:08:49.520309
441	Stann Creek	05	37	2020-03-23 17:08:49.522099	2020-03-23 17:08:49.522099
442	Orange Walk	04	37	2020-03-23 17:08:49.523889	2020-03-23 17:08:49.523889
443	Corozal	03	37	2020-03-23 17:08:49.525899	2020-03-23 17:08:49.525899
444	Cayo	02	37	2020-03-23 17:08:49.52782	2020-03-23 17:08:49.52782
445	Belize	01	37	2020-03-23 17:08:49.52962	2020-03-23 17:08:49.52962
446	Alberta	01	38	2020-03-23 17:08:49.532162	2020-03-23 17:08:49.532162
447	British Columbia	02	38	2020-03-23 17:08:49.534092	2020-03-23 17:08:49.534092
448	Manitoba	03	38	2020-03-23 17:08:49.536197	2020-03-23 17:08:49.536197
449	New Brunswick	04	38	2020-03-23 17:08:49.538549	2020-03-23 17:08:49.538549
450	Northwest Territories	13	38	2020-03-23 17:08:49.541062	2020-03-23 17:08:49.541062
451	Nova Scotia	07	38	2020-03-23 17:08:49.542751	2020-03-23 17:08:49.542751
452	Nunavut	14	38	2020-03-23 17:08:49.544859	2020-03-23 17:08:49.544859
453	Ontario	08	38	2020-03-23 17:08:49.547297	2020-03-23 17:08:49.547297
454	Prince Edward Island	09	38	2020-03-23 17:08:49.548909	2020-03-23 17:08:49.548909
455	Quebec	10	38	2020-03-23 17:08:49.551182	2020-03-23 17:08:49.551182
456	Saskatchewan	11	38	2020-03-23 17:08:49.553605	2020-03-23 17:08:49.553605
457	Yukon	12	38	2020-03-23 17:08:49.555649	2020-03-23 17:08:49.555649
458	Newfoundland and Labrador	05	38	2020-03-23 17:08:49.55759	2020-03-23 17:08:49.55759
459	Sud-Kivu	12	40	2020-03-23 17:08:49.559801	2020-03-23 17:08:49.559801
460	Katanga	05	40	2020-03-23 17:08:49.561872	2020-03-23 17:08:49.561872
461	Nord-Kivu	11	40	2020-03-23 17:08:49.563881	2020-03-23 17:08:49.563881
462	Maniema	10	40	2020-03-23 17:08:49.565825	2020-03-23 17:08:49.565825
463	Kasaï-Oriental	04	40	2020-03-23 17:08:49.567674	2020-03-23 17:08:49.567674
464	Kasaï-Occidental	03	40	2020-03-23 17:08:49.569898	2020-03-23 17:08:49.569898
465	Orientale	09	40	2020-03-23 17:08:49.571898	2020-03-23 17:08:49.571898
466	Équateur	02	40	2020-03-23 17:08:49.574192	2020-03-23 17:08:49.574192
467	Kinshasa	06	40	2020-03-23 17:08:49.576267	2020-03-23 17:08:49.576267
468	Bas-Congo	08	40	2020-03-23 17:08:49.578671	2020-03-23 17:08:49.578671
469	Bandundu	01	40	2020-03-23 17:08:49.58835	2020-03-23 17:08:49.58835
470	Vakaga	14	41	2020-03-23 17:08:49.590176	2020-03-23 17:08:49.590176
471	Ouaka	11	41	2020-03-23 17:08:49.591942	2020-03-23 17:08:49.591942
472	Mbomou	08	41	2020-03-23 17:08:49.593864	2020-03-23 17:08:49.593864
473	Haut-Mbomou	05	41	2020-03-23 17:08:49.595497	2020-03-23 17:08:49.595497
474	Haute-Kotto	03	41	2020-03-23 17:08:49.597264	2020-03-23 17:08:49.597264
475	Basse-Kotto	02	41	2020-03-23 17:08:49.599091	2020-03-23 17:08:49.599091
476	Bamingui-Bangoran	01	41	2020-03-23 17:08:49.600802	2020-03-23 17:08:49.600802
477	Sangha-Mbaéré	16	41	2020-03-23 17:08:49.6025	2020-03-23 17:08:49.6025
478	Ouham-Pendé	13	41	2020-03-23 17:08:49.604218	2020-03-23 17:08:49.604218
479	Ouham	12	41	2020-03-23 17:08:49.605942	2020-03-23 17:08:49.605942
480	Ombella-Mpoko	17	41	2020-03-23 17:08:49.607757	2020-03-23 17:08:49.607757
481	Nana-Mambéré	09	41	2020-03-23 17:08:49.609526	2020-03-23 17:08:49.609526
482	Lobaye	07	41	2020-03-23 17:08:49.61131	2020-03-23 17:08:49.61131
483	Kémo	06	41	2020-03-23 17:08:49.6133	2020-03-23 17:08:49.6133
484	Mambéré-Kadéï	04	41	2020-03-23 17:08:49.614854	2020-03-23 17:08:49.614854
485	Nana-Grébizi	15	41	2020-03-23 17:08:49.617076	2020-03-23 17:08:49.617076
486	Bangui	18	41	2020-03-23 17:08:49.618922	2020-03-23 17:08:49.618922
487	Sangha	10	42	2020-03-23 17:08:49.620641	2020-03-23 17:08:49.620641
488	Pool	11	42	2020-03-23 17:08:49.622721	2020-03-23 17:08:49.622721
489	Plateaux	08	42	2020-03-23 17:08:49.624526	2020-03-23 17:08:49.624526
490	Niari	07	42	2020-03-23 17:08:49.626461	2020-03-23 17:08:49.626461
491	Likouala	06	42	2020-03-23 17:08:49.628613	2020-03-23 17:08:49.628613
492	Lékoumou	05	42	2020-03-23 17:08:49.630661	2020-03-23 17:08:49.630661
493	Kouilou	04	42	2020-03-23 17:08:49.632572	2020-03-23 17:08:49.632572
494	Cuvette	13	42	2020-03-23 17:08:49.634719	2020-03-23 17:08:49.634719
495	Bouenza	01	42	2020-03-23 17:08:49.636544	2020-03-23 17:08:49.636544
496	Brazzaville	12	42	2020-03-23 17:08:49.638338	2020-03-23 17:08:49.638338
497	Cuvette-Ouest	14	42	2020-03-23 17:08:49.640269	2020-03-23 17:08:49.640269
498	Pointe-Noire	7280295	42	2020-03-23 17:08:49.641953	2020-03-23 17:08:49.641953
499	Zürich	ZH	43	2020-03-23 17:08:49.643474	2020-03-23 17:08:49.643474
500	Zug	ZG	43	2020-03-23 17:08:49.645195	2020-03-23 17:08:49.645195
501	Vaud	VD	43	2020-03-23 17:08:49.647073	2020-03-23 17:08:49.647073
502	Valais	VS	43	2020-03-23 17:08:49.648725	2020-03-23 17:08:49.648725
503	Uri	UR	43	2020-03-23 17:08:49.650626	2020-03-23 17:08:49.650626
504	Ticino	TI	43	2020-03-23 17:08:49.652686	2020-03-23 17:08:49.652686
505	Thurgau	TG	43	2020-03-23 17:08:49.654472	2020-03-23 17:08:49.654472
506	Solothurn	SO	43	2020-03-23 17:08:49.656272	2020-03-23 17:08:49.656272
507	Schwyz	SZ	43	2020-03-23 17:08:49.658187	2020-03-23 17:08:49.658187
508	Schaffhausen	SH	43	2020-03-23 17:08:49.66008	2020-03-23 17:08:49.66008
509	Sankt Gallen	SG	43	2020-03-23 17:08:49.661811	2020-03-23 17:08:49.661811
510	Obwalden	OW	43	2020-03-23 17:08:49.663524	2020-03-23 17:08:49.663524
511	Nidwalden	NW	43	2020-03-23 17:08:49.665139	2020-03-23 17:08:49.665139
512	Neuchâtel	NE	43	2020-03-23 17:08:49.66682	2020-03-23 17:08:49.66682
513	Luzern	LU	43	2020-03-23 17:08:49.668237	2020-03-23 17:08:49.668237
514	Jura	JU	43	2020-03-23 17:08:49.669957	2020-03-23 17:08:49.669957
515	Graubünden	GR	43	2020-03-23 17:08:49.671875	2020-03-23 17:08:49.671875
516	Glarus	GL	43	2020-03-23 17:08:49.674008	2020-03-23 17:08:49.674008
517	Genève	GE	43	2020-03-23 17:08:49.67553	2020-03-23 17:08:49.67553
518	Fribourg	FR	43	2020-03-23 17:08:49.677341	2020-03-23 17:08:49.677341
519	Bern	BE	43	2020-03-23 17:08:49.679049	2020-03-23 17:08:49.679049
520	Basel-City	BS	43	2020-03-23 17:08:49.680727	2020-03-23 17:08:49.680727
521	Basel-Landschaft	BL	43	2020-03-23 17:08:49.682316	2020-03-23 17:08:49.682316
522	Appenzell Ausserrhoden	AR	43	2020-03-23 17:08:49.683773	2020-03-23 17:08:49.683773
523	Appenzell Innerrhoden	AI	43	2020-03-23 17:08:49.685351	2020-03-23 17:08:49.685351
524	Aargau	AG	43	2020-03-23 17:08:49.687194	2020-03-23 17:08:49.687194
525	Lagunes	82	44	2020-03-23 17:08:49.688782	2020-03-23 17:08:49.688782
526	Sud-Comoé	89	44	2020-03-23 17:08:49.690213	2020-03-23 17:08:49.690213
527	Agnéby	74	44	2020-03-23 17:08:49.691861	2020-03-23 17:08:49.691861
528	Haut-Sassandra	80	44	2020-03-23 17:08:49.693867	2020-03-23 17:08:49.693867
529	Savanes	87	44	2020-03-23 17:08:49.695723	2020-03-23 17:08:49.695723
530	Vallée du Bandama	90	44	2020-03-23 17:08:49.697403	2020-03-23 17:08:49.697403
531	Moyen-Comoé	85	44	2020-03-23 17:08:49.699092	2020-03-23 17:08:49.699092
532	Dix-Huit Montagnes	78	44	2020-03-23 17:08:49.700551	2020-03-23 17:08:49.700551
533	Lacs	81	44	2020-03-23 17:08:49.702179	2020-03-23 17:08:49.702179
534	Zanzan	92	44	2020-03-23 17:08:49.704126	2020-03-23 17:08:49.704126
535	Bas-Sassandra	76	44	2020-03-23 17:08:49.705887	2020-03-23 17:08:49.705887
536	Worodougou	91	44	2020-03-23 17:08:49.707323	2020-03-23 17:08:49.707323
537	Denguélé	77	44	2020-03-23 17:08:49.708748	2020-03-23 17:08:49.708748
538	Sud-Bandama	88	44	2020-03-23 17:08:49.710653	2020-03-23 17:08:49.710653
539	Fromager	79	44	2020-03-23 17:08:49.712953	2020-03-23 17:08:49.712953
540	Nʼzi-Comoé	86	44	2020-03-23 17:08:49.714483	2020-03-23 17:08:49.714483
541	Marahoué	83	44	2020-03-23 17:08:49.715961	2020-03-23 17:08:49.715961
542	Moyen-Cavally	84	44	2020-03-23 17:08:49.717439	2020-03-23 17:08:49.717439
543	Bafing	75	44	2020-03-23 17:08:49.718981	2020-03-23 17:08:49.718981
544	Valparaíso	01	46	2020-03-23 17:08:49.736089	2020-03-23 17:08:49.736089
545	Tarapacá	15	46	2020-03-23 17:08:49.756449	2020-03-23 17:08:49.756449
546	Región Metropolitana	12	46	2020-03-23 17:08:49.763447	2020-03-23 17:08:49.763447
547	Maule	11	46	2020-03-23 17:08:49.766927	2020-03-23 17:08:49.766927
548	Los Lagos	14	46	2020-03-23 17:08:49.770202	2020-03-23 17:08:49.770202
549	Libertador General Bernardo OʼHiggins	08	46	2020-03-23 17:08:49.775298	2020-03-23 17:08:49.775298
550	Coquimbo	07	46	2020-03-23 17:08:49.778743	2020-03-23 17:08:49.778743
551	Bío-Bío	06	46	2020-03-23 17:08:49.780621	2020-03-23 17:08:49.780621
552	Atacama	05	46	2020-03-23 17:08:49.782713	2020-03-23 17:08:49.782713
553	Araucanía	04	46	2020-03-23 17:08:49.784686	2020-03-23 17:08:49.784686
554	Antofagasta	03	46	2020-03-23 17:08:49.786366	2020-03-23 17:08:49.786366
555	Aisén del General Carlos Ibáñez del Campo	02	46	2020-03-23 17:08:49.787976	2020-03-23 17:08:49.787976
556	Magallanes y Antártica Chilena	10	46	2020-03-23 17:08:49.789774	2020-03-23 17:08:49.789774
557	Región de Arica y Parinacota	16	46	2020-03-23 17:08:49.797858	2020-03-23 17:08:49.797858
558	Región de Los Ríos	17	46	2020-03-23 17:08:49.803865	2020-03-23 17:08:49.803865
559	South-West Province	09	47	2020-03-23 17:08:49.820355	2020-03-23 17:08:49.820355
560	South Region	14	47	2020-03-23 17:08:49.822643	2020-03-23 17:08:49.822643
561	West Region	08	47	2020-03-23 17:08:49.82427	2020-03-23 17:08:49.82427
562	North-West Region	07	47	2020-03-23 17:08:49.825897	2020-03-23 17:08:49.825897
563	North Province	13	47	2020-03-23 17:08:49.828104	2020-03-23 17:08:49.828104
564	Littoral Region	05	47	2020-03-23 17:08:49.831427	2020-03-23 17:08:49.831427
565	Far North Region	12	47	2020-03-23 17:08:49.834603	2020-03-23 17:08:49.834603
566	East Province	04	47	2020-03-23 17:08:49.836227	2020-03-23 17:08:49.836227
567	Centre Region	11	47	2020-03-23 17:08:49.837968	2020-03-23 17:08:49.837968
568	Adamaoua Region	10	47	2020-03-23 17:08:49.839701	2020-03-23 17:08:49.839701
569	Tibet Autonomous Region	14	48	2020-03-23 17:08:49.841372	2020-03-23 17:08:49.841372
570	Qinghai Sheng	06	48	2020-03-23 17:08:49.843033	2020-03-23 17:08:49.843033
571	Xinjiang Uygur Zizhiqu	13	48	2020-03-23 17:08:49.844611	2020-03-23 17:08:49.844611
572	Zhejiang Sheng	02	48	2020-03-23 17:08:49.846172	2020-03-23 17:08:49.846172
573	Yunnan	29	48	2020-03-23 17:08:49.848023	2020-03-23 17:08:49.848023
574	Tianjin Shi	28	48	2020-03-23 17:08:49.849879	2020-03-23 17:08:49.849879
575	Sichuan	32	48	2020-03-23 17:08:49.852412	2020-03-23 17:08:49.852412
576	Shanxi Sheng	24	48	2020-03-23 17:08:49.854448	2020-03-23 17:08:49.854448
577	Shanghai Shi	23	48	2020-03-23 17:08:49.856082	2020-03-23 17:08:49.856082
578	Shandong Sheng	25	48	2020-03-23 17:08:49.85773	2020-03-23 17:08:49.85773
579	Shaanxi Sheng	26	48	2020-03-23 17:08:49.859362	2020-03-23 17:08:49.859362
580	Ningxia Huizu Zizhiqu	21	48	2020-03-23 17:08:49.861052	2020-03-23 17:08:49.861052
581	Jiangxi	03	48	2020-03-23 17:08:49.86264	2020-03-23 17:08:49.86264
582	Jiangsu Sheng	04	48	2020-03-23 17:08:49.864277	2020-03-23 17:08:49.864277
583	Hunan	11	48	2020-03-23 17:08:49.866137	2020-03-23 17:08:49.866137
584	Hubei	12	48	2020-03-23 17:08:49.868093	2020-03-23 17:08:49.868093
585	Henan Sheng	09	48	2020-03-23 17:08:49.87026	2020-03-23 17:08:49.87026
586	Hebei Sheng	10	48	2020-03-23 17:08:49.873894	2020-03-23 17:08:49.873894
587	Hainan	31	48	2020-03-23 17:08:49.875694	2020-03-23 17:08:49.875694
588	Guizhou Sheng	18	48	2020-03-23 17:08:49.877458	2020-03-23 17:08:49.877458
589	Guangxi Zhuangzu Zizhiqu	16	48	2020-03-23 17:08:49.879142	2020-03-23 17:08:49.879142
590	Guangdong Sheng	30	48	2020-03-23 17:08:49.880718	2020-03-23 17:08:49.880718
591	Gansu Sheng	15	48	2020-03-23 17:08:49.882493	2020-03-23 17:08:49.882493
592	Fujian	07	48	2020-03-23 17:08:49.88422	2020-03-23 17:08:49.88422
593	Chongqing Shi	33	48	2020-03-23 17:08:49.885788	2020-03-23 17:08:49.885788
594	Anhui Sheng	01	48	2020-03-23 17:08:49.887495	2020-03-23 17:08:49.887495
595	Inner Mongolia	20	48	2020-03-23 17:08:49.889406	2020-03-23 17:08:49.889406
596	Liaoning	19	48	2020-03-23 17:08:49.891598	2020-03-23 17:08:49.891598
597	Jilin Sheng	05	48	2020-03-23 17:08:49.893783	2020-03-23 17:08:49.893783
598	Heilongjiang Sheng	08	48	2020-03-23 17:08:49.895915	2020-03-23 17:08:49.895915
599	Beijing	22	48	2020-03-23 17:08:49.897873	2020-03-23 17:08:49.897873
600	Vichada	31	49	2020-03-23 17:08:49.899651	2020-03-23 17:08:49.899651
601	Vaupés	30	49	2020-03-23 17:08:49.901418	2020-03-23 17:08:49.901418
602	Valle del Cauca	29	49	2020-03-23 17:08:49.903317	2020-03-23 17:08:49.903317
603	Tolima	28	49	2020-03-23 17:08:49.905042	2020-03-23 17:08:49.905042
604	Sucre	27	49	2020-03-23 17:08:49.907004	2020-03-23 17:08:49.907004
605	Santander	26	49	2020-03-23 17:08:49.908658	2020-03-23 17:08:49.908658
606	Archipiélago de San Andrés, Providencia y Santa Catalina	25	49	2020-03-23 17:08:49.910498	2020-03-23 17:08:49.910498
607	Risaralda	24	49	2020-03-23 17:08:49.91353	2020-03-23 17:08:49.91353
608	Quindío	23	49	2020-03-23 17:08:49.915509	2020-03-23 17:08:49.915509
609	Putumayo	22	49	2020-03-23 17:08:49.917318	2020-03-23 17:08:49.917318
610	Norte de Santander	21	49	2020-03-23 17:08:49.918867	2020-03-23 17:08:49.918867
611	Nariño	20	49	2020-03-23 17:08:49.921089	2020-03-23 17:08:49.921089
612	Meta	19	49	2020-03-23 17:08:49.923235	2020-03-23 17:08:49.923235
613	Magdalena	38	49	2020-03-23 17:08:49.925173	2020-03-23 17:08:49.925173
614	La Guajira	17	49	2020-03-23 17:08:49.927162	2020-03-23 17:08:49.927162
615	Huila	16	49	2020-03-23 17:08:49.929656	2020-03-23 17:08:49.929656
616	Guaviare	14	49	2020-03-23 17:08:49.931615	2020-03-23 17:08:49.931615
617	Guainía	15	49	2020-03-23 17:08:49.933845	2020-03-23 17:08:49.933845
618	Cundinamarca	33	49	2020-03-23 17:08:49.935991	2020-03-23 17:08:49.935991
619	Córdoba	12	49	2020-03-23 17:08:49.937745	2020-03-23 17:08:49.937745
620	Chocó	11	49	2020-03-23 17:08:49.939748	2020-03-23 17:08:49.939748
621	Cesar	10	49	2020-03-23 17:08:49.941462	2020-03-23 17:08:49.941462
622	Cauca	09	49	2020-03-23 17:08:49.943238	2020-03-23 17:08:49.943238
623	Casanare	32	49	2020-03-23 17:08:49.945508	2020-03-23 17:08:49.945508
624	Caquetá	08	49	2020-03-23 17:08:49.948036	2020-03-23 17:08:49.948036
625	Caldas	37	49	2020-03-23 17:08:49.949917	2020-03-23 17:08:49.949917
626	Boyacá	36	49	2020-03-23 17:08:49.953268	2020-03-23 17:08:49.953268
627	Bolívar	35	49	2020-03-23 17:08:49.954968	2020-03-23 17:08:49.954968
628	Bogota D.C.	34	49	2020-03-23 17:08:49.956906	2020-03-23 17:08:49.956906
629	Atlántico	04	49	2020-03-23 17:08:49.958477	2020-03-23 17:08:49.958477
630	Arauca	03	49	2020-03-23 17:08:49.963702	2020-03-23 17:08:49.963702
631	Antioquia	02	49	2020-03-23 17:08:49.965522	2020-03-23 17:08:49.965522
632	Amazonas	01	49	2020-03-23 17:08:49.967708	2020-03-23 17:08:49.967708
633	San José	08	50	2020-03-23 17:08:49.969645	2020-03-23 17:08:49.969645
634	Puntarenas	07	50	2020-03-23 17:08:49.980565	2020-03-23 17:08:49.980565
635	Limón	06	50	2020-03-23 17:08:49.983548	2020-03-23 17:08:49.983548
636	Heredia	04	50	2020-03-23 17:08:49.985829	2020-03-23 17:08:49.985829
637	Guanacaste	03	50	2020-03-23 17:08:49.988106	2020-03-23 17:08:49.988106
638	Cartago	02	50	2020-03-23 17:08:49.990372	2020-03-23 17:08:49.990372
639	Alajuela	01	50	2020-03-23 17:08:49.993585	2020-03-23 17:08:49.993585
640	Villa Clara	16	51	2020-03-23 17:08:49.996136	2020-03-23 17:08:49.996136
641	Santiago de Cuba	15	51	2020-03-23 17:08:49.998862	2020-03-23 17:08:49.998862
642	Sancti Spíritus	14	51	2020-03-23 17:08:50.000992	2020-03-23 17:08:50.000992
643	Pinar del Río	01	51	2020-03-23 17:08:50.00289	2020-03-23 17:08:50.00289
644	Matanzas	03	51	2020-03-23 17:08:50.004826	2020-03-23 17:08:50.004826
645	Las Tunas	13	51	2020-03-23 17:08:50.006757	2020-03-23 17:08:50.006757
646	Isla de la Juventud	04	51	2020-03-23 17:08:50.008981	2020-03-23 17:08:50.008981
647	Holguín	12	51	2020-03-23 17:08:50.01093	2020-03-23 17:08:50.01093
648	Guantánamo	10	51	2020-03-23 17:08:50.014519	2020-03-23 17:08:50.014519
649	Granma	09	51	2020-03-23 17:08:50.016734	2020-03-23 17:08:50.016734
650	Ciudad de La Habana	02	51	2020-03-23 17:08:50.018608	2020-03-23 17:08:50.018608
651	Cienfuegos	08	51	2020-03-23 17:08:50.020494	2020-03-23 17:08:50.020494
652	Ciego de Ávila	07	51	2020-03-23 17:08:50.022254	2020-03-23 17:08:50.022254
653	Camagüey	05	51	2020-03-23 17:08:50.024764	2020-03-23 17:08:50.024764
654	Provincia Artemisa	AR	51	2020-03-23 17:08:50.026407	2020-03-23 17:08:50.026407
655	Provincia Mayabeque	MA	51	2020-03-23 17:08:50.02828	2020-03-23 17:08:50.02828
656	Tarrafal	20	52	2020-03-23 17:08:50.030204	2020-03-23 17:08:50.030204
657	São Vicente	11	52	2020-03-23 17:08:50.032566	2020-03-23 17:08:50.032566
658	Santa Catarina	15	52	2020-03-23 17:08:50.034239	2020-03-23 17:08:50.034239
659	Sal	08	52	2020-03-23 17:08:50.035827	2020-03-23 17:08:50.035827
660	Ribeira Grande	07	52	2020-03-23 17:08:50.037466	2020-03-23 17:08:50.037466
661	Praia	14	52	2020-03-23 17:08:50.039321	2020-03-23 17:08:50.039321
662	Paul	05	52	2020-03-23 17:08:50.041318	2020-03-23 17:08:50.041318
663	Maio	04	52	2020-03-23 17:08:50.043853	2020-03-23 17:08:50.043853
664	Brava	02	52	2020-03-23 17:08:50.046128	2020-03-23 17:08:50.046128
665	Boa Vista	01	52	2020-03-23 17:08:50.048058	2020-03-23 17:08:50.048058
666	Mosteiros	13	52	2020-03-23 17:08:50.049862	2020-03-23 17:08:50.049862
667	Santa Cruz	16	52	2020-03-23 17:08:50.051792	2020-03-23 17:08:50.051792
668	São Domingos	17	52	2020-03-23 17:08:50.05375	2020-03-23 17:08:50.05375
669	São Filipe	18	52	2020-03-23 17:08:50.055641	2020-03-23 17:08:50.055641
670	São Miguel	19	52	2020-03-23 17:08:50.057306	2020-03-23 17:08:50.057306
671	Concelho do Porto Novo	21	52	2020-03-23 17:08:50.058883	2020-03-23 17:08:50.058883
672	Concelho da Ribeira Brava	22	52	2020-03-23 17:08:50.060654	2020-03-23 17:08:50.060654
673	Concelho de Santa Catarina do Fogo	24	52	2020-03-23 17:08:50.062656	2020-03-23 17:08:50.062656
674	Concelho de São Salvador do Mundo	26	52	2020-03-23 17:08:50.064447	2020-03-23 17:08:50.064447
675	Concelho do Tarrafal de São Nicolau	27	52	2020-03-23 17:08:50.066529	2020-03-23 17:08:50.066529
676	Concelho de São Lourenço dos Orgãos	25	52	2020-03-23 17:08:50.068665	2020-03-23 17:08:50.068665
677	Concelho de Ribeira Grande de Santiago	23	52	2020-03-23 17:08:50.070447	2020-03-23 17:08:50.070447
678	Paphos	06	55	2020-03-23 17:08:50.072368	2020-03-23 17:08:50.072368
679	Nicosia	04	55	2020-03-23 17:08:50.074335	2020-03-23 17:08:50.074335
680	Limassol	05	55	2020-03-23 17:08:50.076275	2020-03-23 17:08:50.076275
681	Larnaca	03	55	2020-03-23 17:08:50.078298	2020-03-23 17:08:50.078298
682	Kyrenia	02	55	2020-03-23 17:08:50.080169	2020-03-23 17:08:50.080169
683	Famagusta	01	55	2020-03-23 17:08:50.081761	2020-03-23 17:08:50.081761
684	Hlavní Mesto Praha	52	56	2020-03-23 17:08:50.083511	2020-03-23 17:08:50.083511
685	South Moravian Region	78	56	2020-03-23 17:08:50.085261	2020-03-23 17:08:50.085261
686	Jihočeský Kraj	79	56	2020-03-23 17:08:50.087047	2020-03-23 17:08:50.087047
687	Vysočina	80	56	2020-03-23 17:08:50.088928	2020-03-23 17:08:50.088928
688	Karlovarský Kraj	81	56	2020-03-23 17:08:50.090787	2020-03-23 17:08:50.090787
689	Královéhradecký Kraj	82	56	2020-03-23 17:08:50.09294	2020-03-23 17:08:50.09294
690	Liberecký Kraj	83	56	2020-03-23 17:08:50.094832	2020-03-23 17:08:50.094832
691	Olomoucký Kraj	84	56	2020-03-23 17:08:50.096447	2020-03-23 17:08:50.096447
692	Moravskoslezský Kraj	85	56	2020-03-23 17:08:50.098159	2020-03-23 17:08:50.098159
693	Pardubický Kraj	86	56	2020-03-23 17:08:50.10009	2020-03-23 17:08:50.10009
694	Plzeňský Kraj	87	56	2020-03-23 17:08:50.102046	2020-03-23 17:08:50.102046
695	Středočeský Kraj	88	56	2020-03-23 17:08:50.103826	2020-03-23 17:08:50.103826
696	Ústecký Kraj	89	56	2020-03-23 17:08:50.105693	2020-03-23 17:08:50.105693
697	Zlínský Kraj	90	56	2020-03-23 17:08:50.109128	2020-03-23 17:08:50.109128
698	Thuringia	15	57	2020-03-23 17:08:50.110998	2020-03-23 17:08:50.110998
699	Schleswig-Holstein	10	57	2020-03-23 17:08:50.113571	2020-03-23 17:08:50.113571
700	Saxony-Anhalt	14	57	2020-03-23 17:08:50.115419	2020-03-23 17:08:50.115419
701	Saxony	13	57	2020-03-23 17:08:50.117062	2020-03-23 17:08:50.117062
702	Saarland	09	57	2020-03-23 17:08:50.118552	2020-03-23 17:08:50.118552
703	Rhineland-Palatinate	08	57	2020-03-23 17:08:50.120182	2020-03-23 17:08:50.120182
704	North Rhine-Westphalia	07	57	2020-03-23 17:08:50.12197	2020-03-23 17:08:50.12197
705	Lower Saxony	06	57	2020-03-23 17:08:50.123471	2020-03-23 17:08:50.123471
706	Mecklenburg-Vorpommern	12	57	2020-03-23 17:08:50.125111	2020-03-23 17:08:50.125111
707	Hesse	05	57	2020-03-23 17:08:50.126652	2020-03-23 17:08:50.126652
708	Hamburg	04	57	2020-03-23 17:08:50.12847	2020-03-23 17:08:50.12847
709	Bremen	03	57	2020-03-23 17:08:50.130082	2020-03-23 17:08:50.130082
710	Brandenburg	11	57	2020-03-23 17:08:50.132055	2020-03-23 17:08:50.132055
711	Berlin	16	57	2020-03-23 17:08:50.133978	2020-03-23 17:08:50.133978
712	Bavaria	02	57	2020-03-23 17:08:50.135387	2020-03-23 17:08:50.135387
713	Baden-Württemberg	01	57	2020-03-23 17:08:50.136926	2020-03-23 17:08:50.136926
714	Tadjourah	05	58	2020-03-23 17:08:50.138421	2020-03-23 17:08:50.138421
715	Obock	04	58	2020-03-23 17:08:50.140181	2020-03-23 17:08:50.140181
716	Djibouti	07	58	2020-03-23 17:08:50.142354	2020-03-23 17:08:50.142354
717	Dikhil	06	58	2020-03-23 17:08:50.144424	2020-03-23 17:08:50.144424
718	Ali Sabieh	01	58	2020-03-23 17:08:50.146324	2020-03-23 17:08:50.146324
719	Arta	08	58	2020-03-23 17:08:50.148165	2020-03-23 17:08:50.148165
720	Capital Region	17	59	2020-03-23 17:08:50.150254	2020-03-23 17:08:50.150254
721	Central Jutland	18	59	2020-03-23 17:08:50.152653	2020-03-23 17:08:50.152653
722	Region North Jutland	19	59	2020-03-23 17:08:50.154485	2020-03-23 17:08:50.154485
723	Zealand	20	59	2020-03-23 17:08:50.156282	2020-03-23 17:08:50.156282
724	South Denmark	21	59	2020-03-23 17:08:50.158094	2020-03-23 17:08:50.158094
725	Saint Peter	11	60	2020-03-23 17:08:50.160227	2020-03-23 17:08:50.160227
726	Saint Paul	10	60	2020-03-23 17:08:50.162083	2020-03-23 17:08:50.162083
727	Saint Patrick	09	60	2020-03-23 17:08:50.163893	2020-03-23 17:08:50.163893
728	Saint Mark	08	60	2020-03-23 17:08:50.165853	2020-03-23 17:08:50.165853
729	Saint Luke	07	60	2020-03-23 17:08:50.167613	2020-03-23 17:08:50.167613
730	Saint Joseph	06	60	2020-03-23 17:08:50.169308	2020-03-23 17:08:50.169308
731	Saint John	05	60	2020-03-23 17:08:50.170852	2020-03-23 17:08:50.170852
732	Saint George	04	60	2020-03-23 17:08:50.172929	2020-03-23 17:08:50.172929
733	Saint David	03	60	2020-03-23 17:08:50.174628	2020-03-23 17:08:50.174628
734	Saint Andrew	02	60	2020-03-23 17:08:50.17657	2020-03-23 17:08:50.17657
735	Valverde	27	61	2020-03-23 17:08:50.178353	2020-03-23 17:08:50.178353
736	Santiago Rodríguez	26	61	2020-03-23 17:08:50.180194	2020-03-23 17:08:50.180194
737	Santiago	25	61	2020-03-23 17:08:50.181893	2020-03-23 17:08:50.181893
738	San Pedro de Macorís	24	61	2020-03-23 17:08:50.183656	2020-03-23 17:08:50.183656
739	San Juan	23	61	2020-03-23 17:08:50.186596	2020-03-23 17:08:50.186596
740	San Cristóbal	33	61	2020-03-23 17:08:50.188546	2020-03-23 17:08:50.188546
741	Sánchez Ramírez	21	61	2020-03-23 17:08:50.190531	2020-03-23 17:08:50.190531
742	Samaná	20	61	2020-03-23 17:08:50.192551	2020-03-23 17:08:50.192551
743	Hermanas Mirabal	19	61	2020-03-23 17:08:50.194411	2020-03-23 17:08:50.194411
744	Puerto Plata	18	61	2020-03-23 17:08:50.19621	2020-03-23 17:08:50.19621
745	Peravia	35	61	2020-03-23 17:08:50.197804	2020-03-23 17:08:50.197804
746	Pedernales	16	61	2020-03-23 17:08:50.199667	2020-03-23 17:08:50.199667
747	Distrito Nacional	34	61	2020-03-23 17:08:50.20142	2020-03-23 17:08:50.20142
748	Monte Plata	32	61	2020-03-23 17:08:50.203076	2020-03-23 17:08:50.203076
749	Monte Cristi	15	61	2020-03-23 17:08:50.204819	2020-03-23 17:08:50.204819
750	Monseñor Nouel	31	61	2020-03-23 17:08:50.206515	2020-03-23 17:08:50.206515
751	María Trinidad Sánchez	14	61	2020-03-23 17:08:50.208296	2020-03-23 17:08:50.208296
752	La Vega	30	61	2020-03-23 17:08:50.210161	2020-03-23 17:08:50.210161
753	La Romana	12	61	2020-03-23 17:08:50.21225	2020-03-23 17:08:50.21225
754	La Altagracia	10	61	2020-03-23 17:08:50.214172	2020-03-23 17:08:50.214172
755	Independencia	09	61	2020-03-23 17:08:50.215813	2020-03-23 17:08:50.215813
756	Hato Mayor	29	61	2020-03-23 17:08:50.217533	2020-03-23 17:08:50.217533
757	Espaillat	08	61	2020-03-23 17:08:50.219323	2020-03-23 17:08:50.219323
758	El Seíbo	28	61	2020-03-23 17:08:50.22116	2020-03-23 17:08:50.22116
759	Elías Piña	11	61	2020-03-23 17:08:50.222895	2020-03-23 17:08:50.222895
760	Duarte	06	61	2020-03-23 17:08:50.224469	2020-03-23 17:08:50.224469
761	Dajabón	04	61	2020-03-23 17:08:50.226291	2020-03-23 17:08:50.226291
762	Barahona	03	61	2020-03-23 17:08:50.228333	2020-03-23 17:08:50.228333
763	Baoruco	02	61	2020-03-23 17:08:50.229841	2020-03-23 17:08:50.229841
764	Azua	01	61	2020-03-23 17:08:50.231559	2020-03-23 17:08:50.231559
765	San José de Ocoa	36	61	2020-03-23 17:08:50.233637	2020-03-23 17:08:50.233637
766	Santo Domingo	37	61	2020-03-23 17:08:50.235403	2020-03-23 17:08:50.235403
767	Tlemcen	15	62	2020-03-23 17:08:50.23711	2020-03-23 17:08:50.23711
768	Tizi Ouzou	14	62	2020-03-23 17:08:50.238811	2020-03-23 17:08:50.238811
769	Tissemsilt	56	62	2020-03-23 17:08:50.240388	2020-03-23 17:08:50.240388
770	Tipaza	55	62	2020-03-23 17:08:50.242337	2020-03-23 17:08:50.242337
771	Tindouf	54	62	2020-03-23 17:08:50.244451	2020-03-23 17:08:50.244451
772	Tiaret	13	62	2020-03-23 17:08:50.246294	2020-03-23 17:08:50.246294
773	Tébessa	33	62	2020-03-23 17:08:50.248189	2020-03-23 17:08:50.248189
774	Tamanghasset	53	62	2020-03-23 17:08:50.250238	2020-03-23 17:08:50.250238
775	Souk Ahras	52	62	2020-03-23 17:08:50.252878	2020-03-23 17:08:50.252878
776	Skikda	31	62	2020-03-23 17:08:50.254705	2020-03-23 17:08:50.254705
777	Sidi Bel Abbès	30	62	2020-03-23 17:08:50.256511	2020-03-23 17:08:50.256511
778	Sétif	12	62	2020-03-23 17:08:50.258319	2020-03-23 17:08:50.258319
779	Saïda	10	62	2020-03-23 17:08:50.260406	2020-03-23 17:08:50.260406
780	Relizane	51	62	2020-03-23 17:08:50.262598	2020-03-23 17:08:50.262598
781	Oum el Bouaghi	29	62	2020-03-23 17:08:50.26458	2020-03-23 17:08:50.26458
782	Ouargla	50	62	2020-03-23 17:08:50.266834	2020-03-23 17:08:50.266834
783	Oran	09	62	2020-03-23 17:08:50.268669	2020-03-23 17:08:50.268669
784	Naama النعامة	49	62	2020-03-23 17:08:50.270786	2020-03-23 17:08:50.270786
785	Mʼsila	27	62	2020-03-23 17:08:50.272831	2020-03-23 17:08:50.272831
786	Mostaganem	07	62	2020-03-23 17:08:50.274344	2020-03-23 17:08:50.274344
787	Mila	48	62	2020-03-23 17:08:50.275942	2020-03-23 17:08:50.275942
788	Médéa	06	62	2020-03-23 17:08:50.277398	2020-03-23 17:08:50.277398
789	Mascara	26	62	2020-03-23 17:08:50.278794	2020-03-23 17:08:50.278794
790	Laghouat	25	62	2020-03-23 17:08:50.280185	2020-03-23 17:08:50.280185
791	Khenchela	47	62	2020-03-23 17:08:50.281819	2020-03-23 17:08:50.281819
792	Jijel	24	62	2020-03-23 17:08:50.283418	2020-03-23 17:08:50.283418
793	Illizi	46	62	2020-03-23 17:08:50.285019	2020-03-23 17:08:50.285019
794	Guelma	23	62	2020-03-23 17:08:50.286471	2020-03-23 17:08:50.286471
795	Ghardaïa	45	62	2020-03-23 17:08:50.288075	2020-03-23 17:08:50.288075
796	El Tarf	44	62	2020-03-23 17:08:50.289793	2020-03-23 17:08:50.289793
797	El Oued	43	62	2020-03-23 17:08:50.291676	2020-03-23 17:08:50.291676
798	El Bayadh	42	62	2020-03-23 17:08:50.293499	2020-03-23 17:08:50.293499
799	Djelfa	22	62	2020-03-23 17:08:50.294979	2020-03-23 17:08:50.294979
800	Constantine	04	62	2020-03-23 17:08:50.29641	2020-03-23 17:08:50.29641
801	Chlef	41	62	2020-03-23 17:08:50.297934	2020-03-23 17:08:50.297934
802	Boumerdes	40	62	2020-03-23 17:08:50.29954	2020-03-23 17:08:50.29954
803	Bouira	21	62	2020-03-23 17:08:50.300957	2020-03-23 17:08:50.300957
804	Bordj Bou Arréridj	39	62	2020-03-23 17:08:50.302373	2020-03-23 17:08:50.302373
805	Blida	20	62	2020-03-23 17:08:50.304101	2020-03-23 17:08:50.304101
806	Biskra	19	62	2020-03-23 17:08:50.305779	2020-03-23 17:08:50.305779
807	Bejaïa	18	62	2020-03-23 17:08:50.307257	2020-03-23 17:08:50.307257
808	Béchar	38	62	2020-03-23 17:08:50.308743	2020-03-23 17:08:50.308743
809	Batna	03	62	2020-03-23 17:08:50.310686	2020-03-23 17:08:50.310686
810	Annaba	37	62	2020-03-23 17:08:50.313244	2020-03-23 17:08:50.313244
811	Alger	01	62	2020-03-23 17:08:50.314777	2020-03-23 17:08:50.314777
812	Aïn Temouchent	36	62	2020-03-23 17:08:50.316471	2020-03-23 17:08:50.316471
813	Aïn Defla	35	62	2020-03-23 17:08:50.318601	2020-03-23 17:08:50.318601
814	Adrar	34	62	2020-03-23 17:08:50.32042	2020-03-23 17:08:50.32042
815	Zamora-Chinchipe	20	63	2020-03-23 17:08:50.32223	2020-03-23 17:08:50.32223
816	Tungurahua	19	63	2020-03-23 17:08:50.323947	2020-03-23 17:08:50.323947
817	Pichincha	18	63	2020-03-23 17:08:50.325386	2020-03-23 17:08:50.325386
818	Pastaza	17	63	2020-03-23 17:08:50.326872	2020-03-23 17:08:50.326872
819	Napo	23	63	2020-03-23 17:08:50.328359	2020-03-23 17:08:50.328359
820	Morona-Santiago	15	63	2020-03-23 17:08:50.329989	2020-03-23 17:08:50.329989
821	Manabí	14	63	2020-03-23 17:08:50.331638	2020-03-23 17:08:50.331638
822	Los Ríos	13	63	2020-03-23 17:08:50.333635	2020-03-23 17:08:50.333635
823	Loja	12	63	2020-03-23 17:08:50.33537	2020-03-23 17:08:50.33537
824	Imbabura	11	63	2020-03-23 17:08:50.337131	2020-03-23 17:08:50.337131
825	Guayas	10	63	2020-03-23 17:08:50.338824	2020-03-23 17:08:50.338824
826	Galápagos	01	63	2020-03-23 17:08:50.340336	2020-03-23 17:08:50.340336
827	Esmeraldas	09	63	2020-03-23 17:08:50.342244	2020-03-23 17:08:50.342244
828	El Oro	08	63	2020-03-23 17:08:50.343831	2020-03-23 17:08:50.343831
829	Cotopaxi	07	63	2020-03-23 17:08:50.345613	2020-03-23 17:08:50.345613
830	Chimborazo	06	63	2020-03-23 17:08:50.347406	2020-03-23 17:08:50.347406
831	Carchi	05	63	2020-03-23 17:08:50.349314	2020-03-23 17:08:50.349314
832	Cañar	04	63	2020-03-23 17:08:50.35094	2020-03-23 17:08:50.35094
833	Bolívar	03	63	2020-03-23 17:08:50.352922	2020-03-23 17:08:50.352922
834	Azuay	02	63	2020-03-23 17:08:50.354815	2020-03-23 17:08:50.354815
835	Sucumbios	22	63	2020-03-23 17:08:50.356719	2020-03-23 17:08:50.356719
836	Orellana	24	63	2020-03-23 17:08:50.358341	2020-03-23 17:08:50.358341
837	Santo Domingo de los Tsáchilas	26	63	2020-03-23 17:08:50.359951	2020-03-23 17:08:50.359951
838	Santa Elena	25	63	2020-03-23 17:08:50.361691	2020-03-23 17:08:50.361691
839	Võrumaa	21	64	2020-03-23 17:08:50.363367	2020-03-23 17:08:50.363367
840	Viljandimaa	20	64	2020-03-23 17:08:50.365076	2020-03-23 17:08:50.365076
841	Valgamaa	19	64	2020-03-23 17:08:50.366729	2020-03-23 17:08:50.366729
842	Tartumaa	18	64	2020-03-23 17:08:50.368194	2020-03-23 17:08:50.368194
843	Saaremaa	14	64	2020-03-23 17:08:50.369649	2020-03-23 17:08:50.369649
844	Raplamaa	13	64	2020-03-23 17:08:50.37131	2020-03-23 17:08:50.37131
845	Põlvamaa	12	64	2020-03-23 17:08:50.373548	2020-03-23 17:08:50.373548
846	Pärnumaa	11	64	2020-03-23 17:08:50.375576	2020-03-23 17:08:50.375576
847	Lääne-Virumaa	08	64	2020-03-23 17:08:50.377195	2020-03-23 17:08:50.377195
848	Läänemaa	07	64	2020-03-23 17:08:50.379104	2020-03-23 17:08:50.379104
849	Jõgevamaa	05	64	2020-03-23 17:08:50.380928	2020-03-23 17:08:50.380928
850	Järvamaa	04	64	2020-03-23 17:08:50.382428	2020-03-23 17:08:50.382428
851	Ida-Virumaa	03	64	2020-03-23 17:08:50.384034	2020-03-23 17:08:50.384034
852	Hiiumaa	02	64	2020-03-23 17:08:50.385437	2020-03-23 17:08:50.385437
853	Harjumaa	01	64	2020-03-23 17:08:50.387159	2020-03-23 17:08:50.387159
854	Sūhāj	24	65	2020-03-23 17:08:50.388905	2020-03-23 17:08:50.388905
855	Shamāl Sīnāʼ	27	65	2020-03-23 17:08:50.390523	2020-03-23 17:08:50.390523
856	Qinā	23	65	2020-03-23 17:08:50.392304	2020-03-23 17:08:50.392304
857	Maţrūḩ	22	65	2020-03-23 17:08:50.39404	2020-03-23 17:08:50.39404
858	Kafr ash Shaykh	21	65	2020-03-23 17:08:50.395577	2020-03-23 17:08:50.395577
859	Janūb Sīnāʼ	26	65	2020-03-23 17:08:50.397175	2020-03-23 17:08:50.397175
860	Dumyāţ	20	65	2020-03-23 17:08:50.398689	2020-03-23 17:08:50.398689
861	Būr Sa‘īd	19	65	2020-03-23 17:08:50.400181	2020-03-23 17:08:50.400181
862	Banī Suwayf	18	65	2020-03-23 17:08:50.401899	2020-03-23 17:08:50.401899
863	Asyūţ	17	65	2020-03-23 17:08:50.403497	2020-03-23 17:08:50.403497
864	Aswān	16	65	2020-03-23 17:08:50.405438	2020-03-23 17:08:50.405438
865	As Suways	15	65	2020-03-23 17:08:50.40725	2020-03-23 17:08:50.40725
866	Eastern Province	14	65	2020-03-23 17:08:50.40875	2020-03-23 17:08:50.40875
867	Al Wādī al Jadīd	13	65	2020-03-23 17:08:50.4105	2020-03-23 17:08:50.4105
868	Al Qalyūbīyah	12	65	2020-03-23 17:08:50.412352	2020-03-23 17:08:50.412352
869	Al Qāhirah	11	65	2020-03-23 17:08:50.414166	2020-03-23 17:08:50.414166
870	Al Minyā	10	65	2020-03-23 17:08:50.415784	2020-03-23 17:08:50.415784
871	Al Minūfīyah	09	65	2020-03-23 17:08:50.417339	2020-03-23 17:08:50.417339
872	Al Jīzah	08	65	2020-03-23 17:08:50.419022	2020-03-23 17:08:50.419022
873	Al Ismā‘īlīyah	07	65	2020-03-23 17:08:50.42054	2020-03-23 17:08:50.42054
874	Alexandria	06	65	2020-03-23 17:08:50.422066	2020-03-23 17:08:50.422066
875	Al Gharbīyah	05	65	2020-03-23 17:08:50.423627	2020-03-23 17:08:50.423627
876	Al Fayyūm	04	65	2020-03-23 17:08:50.42544	2020-03-23 17:08:50.42544
877	Al Buḩayrah	03	65	2020-03-23 17:08:50.427006	2020-03-23 17:08:50.427006
878	Al Baḩr al Aḩmar	02	65	2020-03-23 17:08:50.428785	2020-03-23 17:08:50.428785
879	Ad Daqahlīyah	01	65	2020-03-23 17:08:50.430501	2020-03-23 17:08:50.430501
880	Muḩāfaz̧at al Uqşur	28	65	2020-03-23 17:08:50.433872	2020-03-23 17:08:50.433872
881	Oued Ed-Dahab-Lagouira	CE	66	2020-03-23 17:08:50.436696	2020-03-23 17:08:50.436696
882	Ānseba	01	67	2020-03-23 17:08:50.438369	2020-03-23 17:08:50.438369
883	Debub	02	67	2020-03-23 17:08:50.440204	2020-03-23 17:08:50.440204
884	Debubawī Kʼeyih Bahrī	03	67	2020-03-23 17:08:50.442545	2020-03-23 17:08:50.442545
885	Gash Barka	04	67	2020-03-23 17:08:50.444605	2020-03-23 17:08:50.444605
886	Maʼākel	05	67	2020-03-23 17:08:50.447268	2020-03-23 17:08:50.447268
887	Semēnawī Kʼeyih Bahrī	06	67	2020-03-23 17:08:50.44905	2020-03-23 17:08:50.44905
888	Murcia	31	68	2020-03-23 17:08:50.451204	2020-03-23 17:08:50.451204
889	Ceuta	CE	68	2020-03-23 17:08:50.453914	2020-03-23 17:08:50.453914
890	Balearic Islands	07	68	2020-03-23 17:08:50.455667	2020-03-23 17:08:50.455667
891	Andalusia	51	68	2020-03-23 17:08:50.457351	2020-03-23 17:08:50.457351
892	Canary Islands	53	68	2020-03-23 17:08:50.459107	2020-03-23 17:08:50.459107
893	Castille-La Mancha	54	68	2020-03-23 17:08:50.460876	2020-03-23 17:08:50.460876
894	Extremadura	57	68	2020-03-23 17:08:50.462647	2020-03-23 17:08:50.462647
895	Valencia	60	68	2020-03-23 17:08:50.464482	2020-03-23 17:08:50.464482
896	Asturias	34	68	2020-03-23 17:08:50.466198	2020-03-23 17:08:50.466198
897	Navarre	32	68	2020-03-23 17:08:50.467943	2020-03-23 17:08:50.467943
898	Madrid	29	68	2020-03-23 17:08:50.46966	2020-03-23 17:08:50.46966
899	La Rioja	27	68	2020-03-23 17:08:50.475046	2020-03-23 17:08:50.475046
900	Cantabria	39	68	2020-03-23 17:08:50.477134	2020-03-23 17:08:50.477134
901	Aragon	52	68	2020-03-23 17:08:50.478937	2020-03-23 17:08:50.478937
902	Castile and León	55	68	2020-03-23 17:08:50.480676	2020-03-23 17:08:50.480676
903	Catalonia	56	68	2020-03-23 17:08:50.482348	2020-03-23 17:08:50.482348
904	Galicia	58	68	2020-03-23 17:08:50.483916	2020-03-23 17:08:50.483916
905	Basque Country	59	68	2020-03-23 17:08:50.485667	2020-03-23 17:08:50.485667
906	Melilla	ML	68	2020-03-23 17:08:50.487218	2020-03-23 17:08:50.487218
907	Ādīs Ābeba	44	69	2020-03-23 17:08:50.488782	2020-03-23 17:08:50.488782
908	Afar Regional State	45	69	2020-03-23 17:08:50.49047	2020-03-23 17:08:50.49047
909	The State of Amhara	46	69	2020-03-23 17:08:50.495226	2020-03-23 17:08:50.495226
910	Beneshangual Gumz Regional State	47	69	2020-03-23 17:08:50.496877	2020-03-23 17:08:50.496877
911	Dire Dawa Region	48	69	2020-03-23 17:08:50.498389	2020-03-23 17:08:50.498389
912	Gambela	49	69	2020-03-23 17:08:50.499873	2020-03-23 17:08:50.499873
913	The State of Harari People	50	69	2020-03-23 17:08:50.501437	2020-03-23 17:08:50.501437
914	Oromia Regional State	51	69	2020-03-23 17:08:50.502922	2020-03-23 17:08:50.502922
915	Somalia Regional State	52	69	2020-03-23 17:08:50.504231	2020-03-23 17:08:50.504231
916	Tigray Regional State	53	69	2020-03-23 17:08:50.505611	2020-03-23 17:08:50.505611
917	SSNPR	54	69	2020-03-23 17:08:50.506996	2020-03-23 17:08:50.506996
918	Ilubabor	40	69	2020-03-23 17:08:50.508779	2020-03-23 17:08:50.508779
919	Oulu	08	70	2020-03-23 17:08:50.510294	2020-03-23 17:08:50.510294
920	Lapponia	06	70	2020-03-23 17:08:50.512017	2020-03-23 17:08:50.512017
921	Southern Finland	13	70	2020-03-23 17:08:50.513718	2020-03-23 17:08:50.513718
922	Province of Eastern Finland	14	70	2020-03-23 17:08:50.515115	2020-03-23 17:08:50.515115
923	Western Finland	15	70	2020-03-23 17:08:50.516612	2020-03-23 17:08:50.516612
924	Western	05	71	2020-03-23 17:08:50.519833	2020-03-23 17:08:50.519833
925	Northern	03	71	2020-03-23 17:08:50.521367	2020-03-23 17:08:50.521367
926	Central	01	71	2020-03-23 17:08:50.522692	2020-03-23 17:08:50.522692
927	Eastern	02	71	2020-03-23 17:08:50.529787	2020-03-23 17:08:50.529787
928	Rotuma	04	71	2020-03-23 17:08:50.531852	2020-03-23 17:08:50.531852
929	Yap	04	73	2020-03-23 17:08:50.533733	2020-03-23 17:08:50.533733
930	Pohnpei	02	73	2020-03-23 17:08:50.535212	2020-03-23 17:08:50.535212
931	Kosrae	01	73	2020-03-23 17:08:50.536684	2020-03-23 17:08:50.536684
932	Chuuk	03	73	2020-03-23 17:08:50.538032	2020-03-23 17:08:50.538032
933	Vágar	VG	74	2020-03-23 17:08:50.539412	2020-03-23 17:08:50.539412
934	Suðuroy	SU	74	2020-03-23 17:08:50.540932	2020-03-23 17:08:50.540932
935	Streymoy	ST	74	2020-03-23 17:08:50.542746	2020-03-23 17:08:50.542746
936	Sandoy	SA	74	2020-03-23 17:08:50.544525	2020-03-23 17:08:50.544525
937	Norðoyar	NO	74	2020-03-23 17:08:50.546876	2020-03-23 17:08:50.546876
938	Eysturoy	OS	74	2020-03-23 17:08:50.548373	2020-03-23 17:08:50.548373
939	Rhône-Alpes	B9	75	2020-03-23 17:08:50.549909	2020-03-23 17:08:50.549909
940	Provence-Alpes-Côte d'Azur	B8	75	2020-03-23 17:08:50.551397	2020-03-23 17:08:50.551397
941	Poitou-Charentes	B7	75	2020-03-23 17:08:50.553253	2020-03-23 17:08:50.553253
942	Picardie	B6	75	2020-03-23 17:08:50.554725	2020-03-23 17:08:50.554725
943	Pays de la Loire	B5	75	2020-03-23 17:08:50.556273	2020-03-23 17:08:50.556273
944	Nord-Pas-de-Calais	B4	75	2020-03-23 17:08:50.557748	2020-03-23 17:08:50.557748
945	Midi-Pyrénées	B3	75	2020-03-23 17:08:50.559292	2020-03-23 17:08:50.559292
946	Lorraine	B2	75	2020-03-23 17:08:50.560769	2020-03-23 17:08:50.560769
947	Limousin	B1	75	2020-03-23 17:08:50.562125	2020-03-23 17:08:50.562125
948	Languedoc-Roussillon	A9	75	2020-03-23 17:08:50.563602	2020-03-23 17:08:50.563602
949	Île-de-France	A8	75	2020-03-23 17:08:50.565007	2020-03-23 17:08:50.565007
950	Haute-Normandie	A7	75	2020-03-23 17:08:50.566428	2020-03-23 17:08:50.566428
951	Franche-Comté	A6	75	2020-03-23 17:08:50.567936	2020-03-23 17:08:50.567936
952	Corsica	A5	75	2020-03-23 17:08:50.569685	2020-03-23 17:08:50.569685
953	Champagne-Ardenne	A4	75	2020-03-23 17:08:50.571395	2020-03-23 17:08:50.571395
954	Centre	A3	75	2020-03-23 17:08:50.57331	2020-03-23 17:08:50.57331
955	Brittany	A2	75	2020-03-23 17:08:50.574773	2020-03-23 17:08:50.574773
956	Bourgogne	A1	75	2020-03-23 17:08:50.576356	2020-03-23 17:08:50.576356
957	Basse-Normandie	99	75	2020-03-23 17:08:50.577893	2020-03-23 17:08:50.577893
958	Auvergne	98	75	2020-03-23 17:08:50.579229	2020-03-23 17:08:50.579229
959	Aquitaine	97	75	2020-03-23 17:08:50.580524	2020-03-23 17:08:50.580524
960	Alsace	C1	75	2020-03-23 17:08:50.581857	2020-03-23 17:08:50.581857
961	Woleu-Ntem	09	76	2020-03-23 17:08:50.583326	2020-03-23 17:08:50.583326
962	Ogooué-Maritime	08	76	2020-03-23 17:08:50.584863	2020-03-23 17:08:50.584863
963	Ogooué-Lolo	07	76	2020-03-23 17:08:50.586241	2020-03-23 17:08:50.586241
964	Ogooué-Ivindo	06	76	2020-03-23 17:08:50.587501	2020-03-23 17:08:50.587501
965	Nyanga	05	76	2020-03-23 17:08:50.588732	2020-03-23 17:08:50.588732
966	Ngounié	04	76	2020-03-23 17:08:50.59001	2020-03-23 17:08:50.59001
967	Moyen-Ogooué	03	76	2020-03-23 17:08:50.591482	2020-03-23 17:08:50.591482
968	Haut-Ogooué	02	76	2020-03-23 17:08:50.59312	2020-03-23 17:08:50.59312
969	Estuaire	01	76	2020-03-23 17:08:50.594624	2020-03-23 17:08:50.594624
970	Wales	WLS	77	2020-03-23 17:08:50.596114	2020-03-23 17:08:50.596114
971	Scotland	SCT	77	2020-03-23 17:08:50.597366	2020-03-23 17:08:50.597366
972	N Ireland	NIR	77	2020-03-23 17:08:50.598612	2020-03-23 17:08:50.598612
973	England	ENG	77	2020-03-23 17:08:50.600062	2020-03-23 17:08:50.600062
974	Saint Patrick	06	78	2020-03-23 17:08:50.601702	2020-03-23 17:08:50.601702
975	Saint Mark	05	78	2020-03-23 17:08:50.603262	2020-03-23 17:08:50.603262
976	Saint John	04	78	2020-03-23 17:08:50.604692	2020-03-23 17:08:50.604692
977	Saint George	03	78	2020-03-23 17:08:50.606186	2020-03-23 17:08:50.606186
978	Saint David	02	78	2020-03-23 17:08:50.607551	2020-03-23 17:08:50.607551
979	Saint Andrew	01	78	2020-03-23 17:08:50.609502	2020-03-23 17:08:50.609502
980	Carriacou and Petite Martinique	10	78	2020-03-23 17:08:50.611729	2020-03-23 17:08:50.611729
981	T'bilisi	51	79	2020-03-23 17:08:50.61371	2020-03-23 17:08:50.61371
982	Ajaria	04	79	2020-03-23 17:08:50.615258	2020-03-23 17:08:50.615258
983	Kvemo Kartli	68	79	2020-03-23 17:08:50.61729	2020-03-23 17:08:50.61729
984	Kakheti	67	79	2020-03-23 17:08:50.619225	2020-03-23 17:08:50.619225
985	Guria	65	79	2020-03-23 17:08:50.621117	2020-03-23 17:08:50.621117
986	Imereti	66	79	2020-03-23 17:08:50.622748	2020-03-23 17:08:50.622748
987	Shida Kartli	73	79	2020-03-23 17:08:50.624572	2020-03-23 17:08:50.624572
988	Mtskheta-Mtianeti	69	79	2020-03-23 17:08:50.626379	2020-03-23 17:08:50.626379
989	Racha-Lechkhumi and Kvemo Svaneti	70	79	2020-03-23 17:08:50.628514	2020-03-23 17:08:50.628514
990	Samegrelo and Zemo Svaneti	71	79	2020-03-23 17:08:50.630071	2020-03-23 17:08:50.630071
991	Samtskhe-Javakheti	72	79	2020-03-23 17:08:50.632465	2020-03-23 17:08:50.632465
992	Abkhazia	02	79	2020-03-23 17:08:50.634664	2020-03-23 17:08:50.634664
993	Guyane	GF	80	2020-03-23 17:08:50.636466	2020-03-23 17:08:50.636466
994	Western	09	82	2020-03-23 17:08:50.638241	2020-03-23 17:08:50.638241
995	Volta	08	82	2020-03-23 17:08:50.640056	2020-03-23 17:08:50.640056
996	Upper West	11	82	2020-03-23 17:08:50.642324	2020-03-23 17:08:50.642324
997	Upper East	10	82	2020-03-23 17:08:50.64442	2020-03-23 17:08:50.64442
998	Northern	06	82	2020-03-23 17:08:50.646226	2020-03-23 17:08:50.646226
999	Greater Accra	01	82	2020-03-23 17:08:50.648258	2020-03-23 17:08:50.648258
1000	Eastern	05	82	2020-03-23 17:08:50.650402	2020-03-23 17:08:50.650402
1001	Central	04	82	2020-03-23 17:08:50.65249	2020-03-23 17:08:50.65249
1002	Brong-Ahafo	03	82	2020-03-23 17:08:50.654195	2020-03-23 17:08:50.654195
1003	Ashanti	02	82	2020-03-23 17:08:50.65611	2020-03-23 17:08:50.65611
1004	Qaasuitsup	05	84	2020-03-23 17:08:50.658375	2020-03-23 17:08:50.658375
1005	Kujalleq	04	84	2020-03-23 17:08:50.660228	2020-03-23 17:08:50.660228
1006	Qeqqata	06	84	2020-03-23 17:08:50.662026	2020-03-23 17:08:50.662026
1007	Sermersooq	07	84	2020-03-23 17:08:50.663924	2020-03-23 17:08:50.663924
1008	Western	05	85	2020-03-23 17:08:50.66589	2020-03-23 17:08:50.66589
1009	Upper River	04	85	2020-03-23 17:08:50.6674	2020-03-23 17:08:50.6674
1010	North Bank	07	85	2020-03-23 17:08:50.668967	2020-03-23 17:08:50.668967
1011	Central River	03	85	2020-03-23 17:08:50.670908	2020-03-23 17:08:50.670908
1012	Lower River	02	85	2020-03-23 17:08:50.673627	2020-03-23 17:08:50.673627
1013	Banjul	01	85	2020-03-23 17:08:50.675341	2020-03-23 17:08:50.675341
1014	Yomou	29	86	2020-03-23 17:08:50.677105	2020-03-23 17:08:50.677105
1015	Tougué	28	86	2020-03-23 17:08:50.678914	2020-03-23 17:08:50.678914
1016	Télimélé	27	86	2020-03-23 17:08:50.681129	2020-03-23 17:08:50.681129
1017	Siguiri	39	86	2020-03-23 17:08:50.683032	2020-03-23 17:08:50.683032
1018	Pita	25	86	2020-03-23 17:08:50.684699	2020-03-23 17:08:50.684699
1019	Nzérékoré	38	86	2020-03-23 17:08:50.686427	2020-03-23 17:08:50.686427
1020	Mamou	23	86	2020-03-23 17:08:50.688426	2020-03-23 17:08:50.688426
1021	Mali	22	86	2020-03-23 17:08:50.690549	2020-03-23 17:08:50.690549
1022	Macenta	21	86	2020-03-23 17:08:50.692574	2020-03-23 17:08:50.692574
1023	Labé	34	86	2020-03-23 17:08:50.69436	2020-03-23 17:08:50.69436
1024	Kouroussa	19	86	2020-03-23 17:08:50.695952	2020-03-23 17:08:50.695952
1025	Koundara	18	86	2020-03-23 17:08:50.697675	2020-03-23 17:08:50.697675
1026	Kissidougou	17	86	2020-03-23 17:08:50.699338	2020-03-23 17:08:50.699338
1027	Kindia	16	86	2020-03-23 17:08:50.701129	2020-03-23 17:08:50.701129
1028	Kérouané	15	86	2020-03-23 17:08:50.702766	2020-03-23 17:08:50.702766
1029	Kankan	32	86	2020-03-23 17:08:50.704836	2020-03-23 17:08:50.704836
1030	Guéckédou	13	86	2020-03-23 17:08:50.706748	2020-03-23 17:08:50.706748
1031	Gaoual	12	86	2020-03-23 17:08:50.708352	2020-03-23 17:08:50.708352
1032	Fria	11	86	2020-03-23 17:08:50.710051	2020-03-23 17:08:50.710051
1033	Forécariah	10	86	2020-03-23 17:08:50.712289	2020-03-23 17:08:50.712289
1034	Faranah	09	86	2020-03-23 17:08:50.714596	2020-03-23 17:08:50.714596
1035	Dubréka	31	86	2020-03-23 17:08:50.716246	2020-03-23 17:08:50.716246
1036	Dinguiraye	07	86	2020-03-23 17:08:50.717857	2020-03-23 17:08:50.717857
1037	Dalaba	06	86	2020-03-23 17:08:50.71951	2020-03-23 17:08:50.71951
1038	Dabola	05	86	2020-03-23 17:08:50.721559	2020-03-23 17:08:50.721559
1039	Conakry	04	86	2020-03-23 17:08:50.723456	2020-03-23 17:08:50.723456
1040	Boké	03	86	2020-03-23 17:08:50.72504	2020-03-23 17:08:50.72504
1041	Boffa	02	86	2020-03-23 17:08:50.726564	2020-03-23 17:08:50.726564
1042	Beyla	01	86	2020-03-23 17:08:50.728246	2020-03-23 17:08:50.728246
1043	Coyah	30	86	2020-03-23 17:08:50.73035	2020-03-23 17:08:50.73035
1044	Koubia	33	86	2020-03-23 17:08:50.732315	2020-03-23 17:08:50.732315
1045	Lélouma	35	86	2020-03-23 17:08:50.734128	2020-03-23 17:08:50.734128
1046	Lola	36	86	2020-03-23 17:08:50.736002	2020-03-23 17:08:50.736002
1047	Mandiana	37	86	2020-03-23 17:08:50.738107	2020-03-23 17:08:50.738107
1048	Guadeloupe	GP	87	2020-03-23 17:08:50.740088	2020-03-23 17:08:50.740088
1049	Annobón	03	88	2020-03-23 17:08:50.742297	2020-03-23 17:08:50.742297
1050	Bioko Norte	04	88	2020-03-23 17:08:50.744512	2020-03-23 17:08:50.744512
1051	Bioko Sur	05	88	2020-03-23 17:08:50.74631	2020-03-23 17:08:50.74631
1052	Centro Sur	06	88	2020-03-23 17:08:50.748121	2020-03-23 17:08:50.748121
1053	Kié-Ntem	07	88	2020-03-23 17:08:50.749841	2020-03-23 17:08:50.749841
1054	Litoral	08	88	2020-03-23 17:08:50.751687	2020-03-23 17:08:50.751687
1055	Wele-Nzas	09	88	2020-03-23 17:08:50.753788	2020-03-23 17:08:50.753788
1056	Mount Athos	736572	89	2020-03-23 17:08:50.755503	2020-03-23 17:08:50.755503
1057	Attiki	ESYE31	89	2020-03-23 17:08:50.757347	2020-03-23 17:08:50.757347
1058	Central Greece	ESYE24	89	2020-03-23 17:08:50.75933	2020-03-23 17:08:50.75933
1059	Kentriki Makedonia	ESYE12	89	2020-03-23 17:08:50.761362	2020-03-23 17:08:50.761362
1060	Kriti	ESYE43	89	2020-03-23 17:08:50.763179	2020-03-23 17:08:50.763179
1061	Anatoliki Makedonia kai Thraki	ESYE11	89	2020-03-23 17:08:50.76516	2020-03-23 17:08:50.76516
1062	Ipeiros	ESYE21	89	2020-03-23 17:08:50.767753	2020-03-23 17:08:50.767753
1063	Ionia Nisia	ESYE22	89	2020-03-23 17:08:50.76996	2020-03-23 17:08:50.76996
1064	Voreio Aigaio	ESYE41	89	2020-03-23 17:08:50.772368	2020-03-23 17:08:50.772368
1065	Peloponnisos	ESYE25	89	2020-03-23 17:08:50.774728	2020-03-23 17:08:50.774728
1066	Notio Aigaio	ESYE42	89	2020-03-23 17:08:50.776974	2020-03-23 17:08:50.776974
1067	Thessalia	ESYE14	89	2020-03-23 17:08:50.778685	2020-03-23 17:08:50.778685
1068	Ditiki Ellada	ESYE23	89	2020-03-23 17:08:50.780302	2020-03-23 17:08:50.780302
1069	Ditiki Makedonia	ESYE13	89	2020-03-23 17:08:50.781682	2020-03-23 17:08:50.781682
1070	Zacapa	22	91	2020-03-23 17:08:50.783145	2020-03-23 17:08:50.783145
1071	Totonicapán	21	91	2020-03-23 17:08:50.784645	2020-03-23 17:08:50.784645
1072	Suchitepéquez	20	91	2020-03-23 17:08:50.78621	2020-03-23 17:08:50.78621
1073	Sololá	19	91	2020-03-23 17:08:50.78782	2020-03-23 17:08:50.78782
1074	Santa Rosa	18	91	2020-03-23 17:08:50.789377	2020-03-23 17:08:50.789377
1075	San Marcos	17	91	2020-03-23 17:08:50.790845	2020-03-23 17:08:50.790845
1076	Sacatepéquez	16	91	2020-03-23 17:08:50.792792	2020-03-23 17:08:50.792792
1077	Retalhuleu	15	91	2020-03-23 17:08:50.794616	2020-03-23 17:08:50.794616
1078	Quiché	14	91	2020-03-23 17:08:50.796239	2020-03-23 17:08:50.796239
1079	Quetzaltenango	13	91	2020-03-23 17:08:50.797899	2020-03-23 17:08:50.797899
1080	Petén	12	91	2020-03-23 17:08:50.799446	2020-03-23 17:08:50.799446
1081	Jutiapa	11	91	2020-03-23 17:08:50.80108	2020-03-23 17:08:50.80108
1082	Jalapa	10	91	2020-03-23 17:08:50.802726	2020-03-23 17:08:50.802726
1083	Izabal	09	91	2020-03-23 17:08:50.804248	2020-03-23 17:08:50.804248
1084	Huehuetenango	08	91	2020-03-23 17:08:50.805873	2020-03-23 17:08:50.805873
1085	Guatemala	07	91	2020-03-23 17:08:50.807561	2020-03-23 17:08:50.807561
1086	Escuintla	06	91	2020-03-23 17:08:50.809604	2020-03-23 17:08:50.809604
1087	El Progreso	05	91	2020-03-23 17:08:50.811118	2020-03-23 17:08:50.811118
1088	Chiquimula	04	91	2020-03-23 17:08:50.813419	2020-03-23 17:08:50.813419
1089	Chimaltenango	03	91	2020-03-23 17:08:50.815229	2020-03-23 17:08:50.815229
1090	Baja Verapaz	02	91	2020-03-23 17:08:50.817091	2020-03-23 17:08:50.817091
1091	Alta Verapaz	01	91	2020-03-23 17:08:50.818843	2020-03-23 17:08:50.818843
1092	Piti Municipality	PI	92	2020-03-23 17:08:50.820429	2020-03-23 17:08:50.820429
1093	Santa Rita Municipality	SR	92	2020-03-23 17:08:50.822122	2020-03-23 17:08:50.822122
1094	Sinajana Municipality	SJ	92	2020-03-23 17:08:50.823763	2020-03-23 17:08:50.823763
1095	Talofofo Municipality	TF	92	2020-03-23 17:08:50.825362	2020-03-23 17:08:50.825362
1096	Tamuning-Tumon-Harmon Municipality	TM	92	2020-03-23 17:08:50.826833	2020-03-23 17:08:50.826833
1097	Umatac Municipality	UM	92	2020-03-23 17:08:50.828388	2020-03-23 17:08:50.828388
1098	Yigo Municipality	YG	92	2020-03-23 17:08:50.829904	2020-03-23 17:08:50.829904
1099	Yona Municipality	YN	92	2020-03-23 17:08:50.832355	2020-03-23 17:08:50.832355
1100	Merizo Municipality	ME	92	2020-03-23 17:08:50.83437	2020-03-23 17:08:50.83437
1101	Mangilao Municipality	MA	92	2020-03-23 17:08:50.835913	2020-03-23 17:08:50.835913
1102	Agana Heights Municipality	AH	92	2020-03-23 17:08:50.837343	2020-03-23 17:08:50.837343
1103	Chalan Pago-Ordot Municipality	CP	92	2020-03-23 17:08:50.83906	2020-03-23 17:08:50.83906
1104	Asan-Maina Municipality	AS	92	2020-03-23 17:08:50.84099	2020-03-23 17:08:50.84099
1105	Agat Municipality	AT	92	2020-03-23 17:08:50.842784	2020-03-23 17:08:50.842784
1106	Dededo Municipality	DD	92	2020-03-23 17:08:50.845012	2020-03-23 17:08:50.845012
1107	Barrigada Municipality	BA	92	2020-03-23 17:08:50.848286	2020-03-23 17:08:50.848286
1108	Hagatna Municipality	AN	92	2020-03-23 17:08:50.85063	2020-03-23 17:08:50.85063
1109	Inarajan Municipality	IN	92	2020-03-23 17:08:50.853014	2020-03-23 17:08:50.853014
1110	Mongmong-Toto-Maite Municipality	MT	92	2020-03-23 17:08:50.854872	2020-03-23 17:08:50.854872
1111	Tombali	07	93	2020-03-23 17:08:50.857052	2020-03-23 17:08:50.857052
1112	Quinara	02	93	2020-03-23 17:08:50.859306	2020-03-23 17:08:50.859306
1113	Oio	04	93	2020-03-23 17:08:50.862508	2020-03-23 17:08:50.862508
1114	Gabú	10	93	2020-03-23 17:08:50.86455	2020-03-23 17:08:50.86455
1115	Cacheu	06	93	2020-03-23 17:08:50.866389	2020-03-23 17:08:50.866389
1116	Bolama and Bijagos	05	93	2020-03-23 17:08:50.868532	2020-03-23 17:08:50.868532
1117	Bissau Autonomous Region	11	93	2020-03-23 17:08:50.870461	2020-03-23 17:08:50.870461
1118	Biombo	12	93	2020-03-23 17:08:50.872746	2020-03-23 17:08:50.872746
1119	Bafatá	01	93	2020-03-23 17:08:50.874758	2020-03-23 17:08:50.874758
1120	Upper Takutu-Upper Essequibo	19	94	2020-03-23 17:08:50.876923	2020-03-23 17:08:50.876923
1121	Upper Demerara-Berbice	18	94	2020-03-23 17:08:50.878585	2020-03-23 17:08:50.878585
1122	Potaro-Siparuni	17	94	2020-03-23 17:08:50.880272	2020-03-23 17:08:50.880272
1123	Pomeroon-Supenaam	16	94	2020-03-23 17:08:50.882276	2020-03-23 17:08:50.882276
1124	Mahaica-Berbice	15	94	2020-03-23 17:08:50.88392	2020-03-23 17:08:50.88392
1125	Essequibo Islands-West Demerara	14	94	2020-03-23 17:08:50.88571	2020-03-23 17:08:50.88571
1126	East Berbice-Corentyne	13	94	2020-03-23 17:08:50.887475	2020-03-23 17:08:50.887475
1127	Demerara-Mahaica	12	94	2020-03-23 17:08:50.88902	2020-03-23 17:08:50.88902
1128	Cuyuni-Mazaruni	11	94	2020-03-23 17:08:50.890735	2020-03-23 17:08:50.890735
1129	Barima-Waini	10	94	2020-03-23 17:08:50.892904	2020-03-23 17:08:50.892904
1130	Yuen Long	NYL	95	2020-03-23 17:08:50.894879	2020-03-23 17:08:50.894879
1131	Tsuen Wan	NTW	95	2020-03-23 17:08:50.896892	2020-03-23 17:08:50.896892
1132	Tai Po	NTP	95	2020-03-23 17:08:50.898958	2020-03-23 17:08:50.898958
1133	Sai Kung	NSK	95	2020-03-23 17:08:50.900496	2020-03-23 17:08:50.900496
1134	Islands	NIS	95	2020-03-23 17:08:50.902528	2020-03-23 17:08:50.902528
1135	Central and Western	HCW	95	2020-03-23 17:08:50.9047	2020-03-23 17:08:50.9047
1136	Wan Chai	HWC	95	2020-03-23 17:08:50.906405	2020-03-23 17:08:50.906405
1137	Eastern	HEA	95	2020-03-23 17:08:50.908058	2020-03-23 17:08:50.908058
1138	Southern	HSO	95	2020-03-23 17:08:50.909645	2020-03-23 17:08:50.909645
1139	Yau Tsim Mong	KYT	95	2020-03-23 17:08:50.911449	2020-03-23 17:08:50.911449
1140	Sham Shui Po	KSS	95	2020-03-23 17:08:50.913717	2020-03-23 17:08:50.913717
1141	Kowloon City	KKC	95	2020-03-23 17:08:50.915664	2020-03-23 17:08:50.915664
1142	Wong Tai Sin	KWT	95	2020-03-23 17:08:50.917381	2020-03-23 17:08:50.917381
1143	Kwon Tong	KKT	95	2020-03-23 17:08:50.919073	2020-03-23 17:08:50.919073
1144	Kwai Tsing	NKT	95	2020-03-23 17:08:50.920934	2020-03-23 17:08:50.920934
1145	Tuen Mun	NTM	95	2020-03-23 17:08:50.922718	2020-03-23 17:08:50.922718
1146	North	NNO	95	2020-03-23 17:08:50.924646	2020-03-23 17:08:50.924646
1147	Sha Tin	NST	95	2020-03-23 17:08:50.92661	2020-03-23 17:08:50.92661
1148	Yoro	18	97	2020-03-23 17:08:50.928515	2020-03-23 17:08:50.928515
1149	Valle	17	97	2020-03-23 17:08:50.930118	2020-03-23 17:08:50.930118
1150	Santa Bárbara	16	97	2020-03-23 17:08:50.931907	2020-03-23 17:08:50.931907
1151	Olancho	15	97	2020-03-23 17:08:50.934763	2020-03-23 17:08:50.934763
1152	Ocotepeque	14	97	2020-03-23 17:08:50.938805	2020-03-23 17:08:50.938805
1153	Lempira	13	97	2020-03-23 17:08:50.940787	2020-03-23 17:08:50.940787
1154	La Paz	12	97	2020-03-23 17:08:50.942773	2020-03-23 17:08:50.942773
1155	Islas de la Bahía	11	97	2020-03-23 17:08:50.944667	2020-03-23 17:08:50.944667
1156	Intibucá	10	97	2020-03-23 17:08:50.946442	2020-03-23 17:08:50.946442
1157	Gracias a Dios	09	97	2020-03-23 17:08:50.948371	2020-03-23 17:08:50.948371
1158	Francisco Morazán	08	97	2020-03-23 17:08:50.950347	2020-03-23 17:08:50.950347
1159	El Paraíso	07	97	2020-03-23 17:08:50.952528	2020-03-23 17:08:50.952528
1160	Cortés	06	97	2020-03-23 17:08:50.954657	2020-03-23 17:08:50.954657
1161	Copán	05	97	2020-03-23 17:08:50.956555	2020-03-23 17:08:50.956555
1162	Comayagua	04	97	2020-03-23 17:08:50.958148	2020-03-23 17:08:50.958148
1163	Colón	03	97	2020-03-23 17:08:50.959721	2020-03-23 17:08:50.959721
1164	Choluteca	02	97	2020-03-23 17:08:50.961484	2020-03-23 17:08:50.961484
1165	Atlántida	01	97	2020-03-23 17:08:50.963428	2020-03-23 17:08:50.963428
1166	Bjelovarsko-Bilogorska	01	98	2020-03-23 17:08:50.965065	2020-03-23 17:08:50.965065
1167	Brodsko-Posavska	02	98	2020-03-23 17:08:50.966681	2020-03-23 17:08:50.966681
1168	Dubrovačko-Neretvanska	03	98	2020-03-23 17:08:50.96842	2020-03-23 17:08:50.96842
1169	Istarska	04	98	2020-03-23 17:08:50.97014	2020-03-23 17:08:50.97014
1170	Karlovačka	05	98	2020-03-23 17:08:50.974025	2020-03-23 17:08:50.974025
1171	Koprivničko-Križevačka	06	98	2020-03-23 17:08:50.976694	2020-03-23 17:08:50.976694
1172	Krapinsko-Zagorska	07	98	2020-03-23 17:08:50.979549	2020-03-23 17:08:50.979549
1173	Ličko-Senjska	08	98	2020-03-23 17:08:50.981998	2020-03-23 17:08:50.981998
1174	Međimurska	09	98	2020-03-23 17:08:50.984317	2020-03-23 17:08:50.984317
1175	Osječko-Baranjska	10	98	2020-03-23 17:08:50.986214	2020-03-23 17:08:50.986214
1176	Požeško-Slavonska	11	98	2020-03-23 17:08:50.988041	2020-03-23 17:08:50.988041
1177	Primorsko-Goranska	12	98	2020-03-23 17:08:50.989846	2020-03-23 17:08:50.989846
1178	Šibensko-Kniniska	13	98	2020-03-23 17:08:50.991707	2020-03-23 17:08:50.991707
1179	Sisačko-Moslavačka	14	98	2020-03-23 17:08:50.99396	2020-03-23 17:08:50.99396
1180	Splitsko-Dalmatinska	15	98	2020-03-23 17:08:50.995941	2020-03-23 17:08:50.995941
1181	Varaždinska	16	98	2020-03-23 17:08:50.997833	2020-03-23 17:08:50.997833
1182	Vukovarsko-Srijemska	18	98	2020-03-23 17:08:50.999393	2020-03-23 17:08:50.999393
1183	Zadarska	19	98	2020-03-23 17:08:51.001289	2020-03-23 17:08:51.001289
1184	Zagrebačka	20	98	2020-03-23 17:08:51.003299	2020-03-23 17:08:51.003299
1185	Grad Zagreb	21	98	2020-03-23 17:08:51.005394	2020-03-23 17:08:51.005394
1186	Virovitičk-Podravska	17	98	2020-03-23 17:08:51.007291	2020-03-23 17:08:51.007291
1187	Sud-Est	13	99	2020-03-23 17:08:51.009017	2020-03-23 17:08:51.009017
1188	Sud	12	99	2020-03-23 17:08:51.011115	2020-03-23 17:08:51.011115
1189	Ouest	11	99	2020-03-23 17:08:51.013736	2020-03-23 17:08:51.013736
1190	Nord-Ouest	03	99	2020-03-23 17:08:51.015718	2020-03-23 17:08:51.015718
1191	Nord-Est	10	99	2020-03-23 17:08:51.017795	2020-03-23 17:08:51.017795
1192	Nord	09	99	2020-03-23 17:08:51.019781	2020-03-23 17:08:51.019781
1193	GrandʼAnse	14	99	2020-03-23 17:08:51.021516	2020-03-23 17:08:51.021516
1194	Centre	07	99	2020-03-23 17:08:51.024649	2020-03-23 17:08:51.024649
1195	Artibonite	06	99	2020-03-23 17:08:51.026646	2020-03-23 17:08:51.026646
1196	Nippes	15	99	2020-03-23 17:08:51.02849	2020-03-23 17:08:51.02849
1197	Szabolcs-Szatmár-Bereg	18	100	2020-03-23 17:08:51.030301	2020-03-23 17:08:51.030301
1198	Jász-Nagykun-Szolnok	20	100	2020-03-23 17:08:51.032818	2020-03-23 17:08:51.032818
1199	Heves	11	100	2020-03-23 17:08:51.034643	2020-03-23 17:08:51.034643
1200	Hajdú-Bihar	10	100	2020-03-23 17:08:51.036326	2020-03-23 17:08:51.036326
1201	Csongrád	06	100	2020-03-23 17:08:51.038458	2020-03-23 17:08:51.038458
1202	Borsod-Abaúj-Zemplén	04	100	2020-03-23 17:08:51.041299	2020-03-23 17:08:51.041299
1203	Békés	03	100	2020-03-23 17:08:51.043533	2020-03-23 17:08:51.043533
1204	Zala	24	100	2020-03-23 17:08:51.045885	2020-03-23 17:08:51.045885
1205	Veszprém	23	100	2020-03-23 17:08:51.048041	2020-03-23 17:08:51.048041
1206	Vas	22	100	2020-03-23 17:08:51.049844	2020-03-23 17:08:51.049844
1207	Tolna	21	100	2020-03-23 17:08:51.052161	2020-03-23 17:08:51.052161
1208	Somogy	17	100	2020-03-23 17:08:51.054183	2020-03-23 17:08:51.054183
1209	Pest	16	100	2020-03-23 17:08:51.056228	2020-03-23 17:08:51.056228
1210	Nógrád	14	100	2020-03-23 17:08:51.058155	2020-03-23 17:08:51.058155
1211	Komárom-Esztergom	12	100	2020-03-23 17:08:51.060122	2020-03-23 17:08:51.060122
1212	Győr-Moson-Sopron	09	100	2020-03-23 17:08:51.061794	2020-03-23 17:08:51.061794
1213	Fejér	08	100	2020-03-23 17:08:51.063733	2020-03-23 17:08:51.063733
1214	Budapest	05	100	2020-03-23 17:08:51.065547	2020-03-23 17:08:51.065547
1215	Baranya	02	100	2020-03-23 17:08:51.06728	2020-03-23 17:08:51.06728
1216	Bács-Kiskun	01	100	2020-03-23 17:08:51.06913	2020-03-23 17:08:51.06913
1217	North Sumatra	26	101	2020-03-23 17:08:51.071	2020-03-23 17:08:51.071
1218	Aceh	01	101	2020-03-23 17:08:51.073294	2020-03-23 17:08:51.073294
1219	Daerah Istimewa Yogyakarta	10	101	2020-03-23 17:08:51.075263	2020-03-23 17:08:51.075263
1220	South Sumatra	32	101	2020-03-23 17:08:51.077189	2020-03-23 17:08:51.077189
1221	West Sumatra	24	101	2020-03-23 17:08:51.078811	2020-03-23 17:08:51.078811
1222	North Sulawesi	31	101	2020-03-23 17:08:51.080324	2020-03-23 17:08:51.080324
1223	Sulawesi Tenggara	22	101	2020-03-23 17:08:51.082043	2020-03-23 17:08:51.082043
1224	Central Sulawesi	21	101	2020-03-23 17:08:51.083825	2020-03-23 17:08:51.083825
1225	South Sulawesi	38	101	2020-03-23 17:08:51.085329	2020-03-23 17:08:51.085329
1226	Riau	37	101	2020-03-23 17:08:51.087042	2020-03-23 17:08:51.087042
1227	East Nusa Tenggara	18	101	2020-03-23 17:08:51.088656	2020-03-23 17:08:51.088656
1228	Nusa Tenggara Barat	17	101	2020-03-23 17:08:51.090192	2020-03-23 17:08:51.090192
1229	Maluku	28	101	2020-03-23 17:08:51.091984	2020-03-23 17:08:51.091984
1230	Lampung	15	101	2020-03-23 17:08:51.094016	2020-03-23 17:08:51.094016
1231	East Kalimantan	14	101	2020-03-23 17:08:51.095771	2020-03-23 17:08:51.095771
1232	Kalimantan Tengah	13	101	2020-03-23 17:08:51.097596	2020-03-23 17:08:51.097596
1233	South Kalimantan	12	101	2020-03-23 17:08:51.099307	2020-03-23 17:08:51.099307
1234	West Kalimantan	11	101	2020-03-23 17:08:51.101042	2020-03-23 17:08:51.101042
1235	East Java	08	101	2020-03-23 17:08:51.102524	2020-03-23 17:08:51.102524
1236	Central Java	07	101	2020-03-23 17:08:51.104239	2020-03-23 17:08:51.104239
1237	West Java	30	101	2020-03-23 17:08:51.10596	2020-03-23 17:08:51.10596
1238	Jambi	05	101	2020-03-23 17:08:51.107423	2020-03-23 17:08:51.107423
1239	Jakarta Raya	04	101	2020-03-23 17:08:51.109102	2020-03-23 17:08:51.109102
1240	Papua	36	101	2020-03-23 17:08:51.112541	2020-03-23 17:08:51.112541
1241	Bengkulu	03	101	2020-03-23 17:08:51.114481	2020-03-23 17:08:51.114481
1242	Bali	02	101	2020-03-23 17:08:51.116573	2020-03-23 17:08:51.116573
1243	Banten	33	101	2020-03-23 17:08:51.118667	2020-03-23 17:08:51.118667
1244	Gorontalo	34	101	2020-03-23 17:08:51.120972	2020-03-23 17:08:51.120972
1245	Bangka-Belitung	35	101	2020-03-23 17:08:51.130018	2020-03-23 17:08:51.130018
1246	Maluku Utara	29	101	2020-03-23 17:08:51.135941	2020-03-23 17:08:51.135941
1247	Irian Jaya Barat	39	101	2020-03-23 17:08:51.140183	2020-03-23 17:08:51.140183
1248	Sulawesi Barat	41	101	2020-03-23 17:08:51.143618	2020-03-23 17:08:51.143618
1249	Riau Islands	40	101	2020-03-23 17:08:51.146631	2020-03-23 17:08:51.146631
1250	Connaught	C	102	2020-03-23 17:08:51.149928	2020-03-23 17:08:51.149928
1251	Leinster	L	102	2020-03-23 17:08:51.155335	2020-03-23 17:08:51.155335
1252	Munster	M	102	2020-03-23 17:08:51.158174	2020-03-23 17:08:51.158174
1253	Ulster	U	102	2020-03-23 17:08:51.160328	2020-03-23 17:08:51.160328
1254	Jerusalem District	06	103	2020-03-23 17:08:51.16423	2020-03-23 17:08:51.16423
1255	Tel Aviv	05	103	2020-03-23 17:08:51.169247	2020-03-23 17:08:51.169247
1256	Haifa	04	103	2020-03-23 17:08:51.173392	2020-03-23 17:08:51.173392
1257	Northern District	03	103	2020-03-23 17:08:51.175206	2020-03-23 17:08:51.175206
1258	Central District	02	103	2020-03-23 17:08:51.19158	2020-03-23 17:08:51.19158
1259	Southern District	01	103	2020-03-23 17:08:51.19646	2020-03-23 17:08:51.19646
1260	Bengal	28	105	2020-03-23 17:08:51.201638	2020-03-23 17:08:51.201638
1261	Uttar Pradesh	36	105	2020-03-23 17:08:51.203596	2020-03-23 17:08:51.203596
1262	Tripura	26	105	2020-03-23 17:08:51.205831	2020-03-23 17:08:51.205831
1263	Tamil Nādu	25	105	2020-03-23 17:08:51.208742	2020-03-23 17:08:51.208742
1264	Sikkim	29	105	2020-03-23 17:08:51.213396	2020-03-23 17:08:51.213396
1265	Rajasthan	24	105	2020-03-23 17:08:51.216543	2020-03-23 17:08:51.216543
1266	Punjab	23	105	2020-03-23 17:08:51.219007	2020-03-23 17:08:51.219007
1267	Pondicherry	22	105	2020-03-23 17:08:51.222154	2020-03-23 17:08:51.222154
1268	Orissa	21	105	2020-03-23 17:08:51.223907	2020-03-23 17:08:51.223907
1269	Nāgāland	20	105	2020-03-23 17:08:51.226959	2020-03-23 17:08:51.226959
1270	Mizoram	31	105	2020-03-23 17:08:51.229477	2020-03-23 17:08:51.229477
1271	Meghālaya	18	105	2020-03-23 17:08:51.233922	2020-03-23 17:08:51.233922
1272	Manipur	17	105	2020-03-23 17:08:51.236512	2020-03-23 17:08:51.236512
1273	Mahārāshtra	16	105	2020-03-23 17:08:51.238153	2020-03-23 17:08:51.238153
1274	Madhya Pradesh	35	105	2020-03-23 17:08:51.240205	2020-03-23 17:08:51.240205
1275	Laccadives	14	105	2020-03-23 17:08:51.242345	2020-03-23 17:08:51.242345
1276	Kerala	13	105	2020-03-23 17:08:51.243976	2020-03-23 17:08:51.243976
1277	Karnātaka	19	105	2020-03-23 17:08:51.245536	2020-03-23 17:08:51.245536
1278	Jammu and Kashmir	12	105	2020-03-23 17:08:51.247214	2020-03-23 17:08:51.247214
1279	Himachal Pradesh	11	105	2020-03-23 17:08:51.248877	2020-03-23 17:08:51.248877
1280	Haryana	10	105	2020-03-23 17:08:51.250576	2020-03-23 17:08:51.250576
1281	Gujarāt	09	105	2020-03-23 17:08:51.252815	2020-03-23 17:08:51.252815
1282	Daman and Diu	32	105	2020-03-23 17:08:51.254784	2020-03-23 17:08:51.254784
1283	Goa	33	105	2020-03-23 17:08:51.256652	2020-03-23 17:08:51.256652
1284	NCT	07	105	2020-03-23 17:08:51.258327	2020-03-23 17:08:51.258327
1285	Dādra and Nagar Haveli	06	105	2020-03-23 17:08:51.259886	2020-03-23 17:08:51.259886
1286	Chandīgarh	05	105	2020-03-23 17:08:51.261301	2020-03-23 17:08:51.261301
1287	Bihār	34	105	2020-03-23 17:08:51.26304	2020-03-23 17:08:51.26304
1288	Assam	03	105	2020-03-23 17:08:51.264729	2020-03-23 17:08:51.264729
1289	Arunāchal Pradesh	30	105	2020-03-23 17:08:51.266463	2020-03-23 17:08:51.266463
1290	Andhra Pradesh	02	105	2020-03-23 17:08:51.268394	2020-03-23 17:08:51.268394
1291	Andaman and Nicobar Islands	01	105	2020-03-23 17:08:51.270025	2020-03-23 17:08:51.270025
1292	Chhattisgarh	37	105	2020-03-23 17:08:51.273074	2020-03-23 17:08:51.273074
1293	Jharkhand	38	105	2020-03-23 17:08:51.275144	2020-03-23 17:08:51.275144
1294	Uttarakhand	39	105	2020-03-23 17:08:51.277045	2020-03-23 17:08:51.277045
1295	Al Başrah	02	107	2020-03-23 17:08:51.279197	2020-03-23 17:08:51.279197
1296	Wāsiţ	16	107	2020-03-23 17:08:51.281476	2020-03-23 17:08:51.281476
1297	Şalāḩ ad Dīn	18	107	2020-03-23 17:08:51.283621	2020-03-23 17:08:51.283621
1298	Nīnawá	15	107	2020-03-23 17:08:51.285328	2020-03-23 17:08:51.285328
1299	Maysan	14	107	2020-03-23 17:08:51.286874	2020-03-23 17:08:51.286874
1300	Karbalāʼ	12	107	2020-03-23 17:08:51.288484	2020-03-23 17:08:51.288484
1301	Arbīl	11	107	2020-03-23 17:08:51.290426	2020-03-23 17:08:51.290426
1302	Diyala	10	107	2020-03-23 17:08:51.292422	2020-03-23 17:08:51.292422
1303	Dhi Qar	09	107	2020-03-23 17:08:51.294304	2020-03-23 17:08:51.294304
1304	Dahūk	08	107	2020-03-23 17:08:51.296061	2020-03-23 17:08:51.296061
1305	Baghdād	07	107	2020-03-23 17:08:51.297813	2020-03-23 17:08:51.297813
1306	Bābil	06	107	2020-03-23 17:08:51.299508	2020-03-23 17:08:51.299508
1307	At Taʼmīm	13	107	2020-03-23 17:08:51.300918	2020-03-23 17:08:51.300918
1308	As Sulaymānīyah	05	107	2020-03-23 17:08:51.302266	2020-03-23 17:08:51.302266
1309	An Najaf	17	107	2020-03-23 17:08:51.303909	2020-03-23 17:08:51.303909
1310	Al Qādisīyah	04	107	2020-03-23 17:08:51.305781	2020-03-23 17:08:51.305781
1311	Al Muthanná	03	107	2020-03-23 17:08:51.307456	2020-03-23 17:08:51.307456
1312	Anbar	01	107	2020-03-23 17:08:51.309442	2020-03-23 17:08:51.309442
1313	Tehrān	26	108	2020-03-23 17:08:51.31148	2020-03-23 17:08:51.31148
1314	Zanjan	36	108	2020-03-23 17:08:51.313549	2020-03-23 17:08:51.313549
1315	Yazd	40	108	2020-03-23 17:08:51.315354	2020-03-23 17:08:51.315354
1316	Semnān	25	108	2020-03-23 17:08:51.317292	2020-03-23 17:08:51.317292
1317	Māzandarān	35	108	2020-03-23 17:08:51.319232	2020-03-23 17:08:51.319232
1318	Markazi	34	108	2020-03-23 17:08:51.321031	2020-03-23 17:08:51.321031
1319	Lorestān	23	108	2020-03-23 17:08:51.323234	2020-03-23 17:08:51.323234
1320	Kordestān	16	108	2020-03-23 17:08:51.325125	2020-03-23 17:08:51.325125
1321	Kohgīlūyeh va Būyer Aḩmad	05	108	2020-03-23 17:08:51.326679	2020-03-23 17:08:51.326679
1322	Khūzestān	15	108	2020-03-23 17:08:51.328269	2020-03-23 17:08:51.328269
1323	Kermānshāh	13	108	2020-03-23 17:08:51.329908	2020-03-23 17:08:51.329908
1324	Kermān	29	108	2020-03-23 17:08:51.331505	2020-03-23 17:08:51.331505
1325	Īlām	10	108	2020-03-23 17:08:51.333667	2020-03-23 17:08:51.333667
1326	Hormozgān	11	108	2020-03-23 17:08:51.335412	2020-03-23 17:08:51.335412
1327	Hamadān	09	108	2020-03-23 17:08:51.337061	2020-03-23 17:08:51.337061
1328	Gīlān	08	108	2020-03-23 17:08:51.338557	2020-03-23 17:08:51.338557
1329	Fārs	07	108	2020-03-23 17:08:51.34021	2020-03-23 17:08:51.34021
1330	Chahār Maḩāll va Bakhtīārī	03	108	2020-03-23 17:08:51.342064	2020-03-23 17:08:51.342064
1331	Bushehr	22	108	2020-03-23 17:08:51.344107	2020-03-23 17:08:51.344107
1332	East Azarbaijan	33	108	2020-03-23 17:08:51.346575	2020-03-23 17:08:51.346575
1333	Āz̄ārbāyjān-e Gharbī	01	108	2020-03-23 17:08:51.348534	2020-03-23 17:08:51.348534
1334	Ardabīl	32	108	2020-03-23 17:08:51.350434	2020-03-23 17:08:51.350434
1335	Eşfahān	28	108	2020-03-23 17:08:51.35239	2020-03-23 17:08:51.35239
1336	Golestān	37	108	2020-03-23 17:08:51.355153	2020-03-23 17:08:51.355153
1337	Qazvīn	38	108	2020-03-23 17:08:51.356908	2020-03-23 17:08:51.356908
1338	Qom	39	108	2020-03-23 17:08:51.358653	2020-03-23 17:08:51.358653
1339	Sīstān va Balūchestān	04	108	2020-03-23 17:08:51.360704	2020-03-23 17:08:51.360704
1340	Khorāsān-e Jonūbī	41	108	2020-03-23 17:08:51.362393	2020-03-23 17:08:51.362393
1341	Razavi Khorasan	42	108	2020-03-23 17:08:51.363823	2020-03-23 17:08:51.363823
1342	Khorāsān-e Shomālī	43	108	2020-03-23 17:08:51.365248	2020-03-23 17:08:51.365248
1343	Ostān-e Alborz	44	108	2020-03-23 17:08:51.366959	2020-03-23 17:08:51.366959
1344	Northwest	41	109	2020-03-23 17:08:51.368757	2020-03-23 17:08:51.368757
1345	Northeast	40	109	2020-03-23 17:08:51.370313	2020-03-23 17:08:51.370313
1346	East	38	109	2020-03-23 17:08:51.372578	2020-03-23 17:08:51.372578
1347	South	42	109	2020-03-23 17:08:51.374315	2020-03-23 17:08:51.374315
1348	Capital Region	39	109	2020-03-23 17:08:51.376488	2020-03-23 17:08:51.376488
1349	Southern Peninsula	43	109	2020-03-23 17:08:51.378367	2020-03-23 17:08:51.378367
1350	West	45	109	2020-03-23 17:08:51.379875	2020-03-23 17:08:51.379875
1351	Westfjords	44	109	2020-03-23 17:08:51.381642	2020-03-23 17:08:51.381642
1352	Sicily	15	110	2020-03-23 17:08:51.383186	2020-03-23 17:08:51.383186
1353	Sardinia	14	110	2020-03-23 17:08:51.384653	2020-03-23 17:08:51.384653
1354	Calabria	03	110	2020-03-23 17:08:51.386215	2020-03-23 17:08:51.386215
1355	Veneto	20	110	2020-03-23 17:08:51.387904	2020-03-23 17:08:51.387904
1356	Aosta Valley	19	110	2020-03-23 17:08:51.389563	2020-03-23 17:08:51.389563
1357	Umbria	18	110	2020-03-23 17:08:51.391051	2020-03-23 17:08:51.391051
1358	Trentino-Alto Adige	17	110	2020-03-23 17:08:51.393023	2020-03-23 17:08:51.393023
1359	Tuscany	16	110	2020-03-23 17:08:51.394702	2020-03-23 17:08:51.394702
1360	Apulia	13	110	2020-03-23 17:08:51.396269	2020-03-23 17:08:51.396269
1361	Piedmont	12	110	2020-03-23 17:08:51.397879	2020-03-23 17:08:51.397879
1362	Molise	11	110	2020-03-23 17:08:51.399319	2020-03-23 17:08:51.399319
1363	The Marches	10	110	2020-03-23 17:08:51.400776	2020-03-23 17:08:51.400776
1364	Lombardy	09	110	2020-03-23 17:08:51.402378	2020-03-23 17:08:51.402378
1365	Liguria	08	110	2020-03-23 17:08:51.40378	2020-03-23 17:08:51.40378
1366	Latium	07	110	2020-03-23 17:08:51.405522	2020-03-23 17:08:51.405522
1367	Friuli Venezia Giulia	06	110	2020-03-23 17:08:51.406995	2020-03-23 17:08:51.406995
1368	Emilia-Romagna	05	110	2020-03-23 17:08:51.408561	2020-03-23 17:08:51.408561
1369	Campania	04	110	2020-03-23 17:08:51.410086	2020-03-23 17:08:51.410086
1370	Basilicate	02	110	2020-03-23 17:08:51.411824	2020-03-23 17:08:51.411824
1371	Abruzzo	01	110	2020-03-23 17:08:51.413635	2020-03-23 17:08:51.413635
1372	Westmoreland	16	112	2020-03-23 17:08:51.415419	2020-03-23 17:08:51.415419
1373	Trelawny	15	112	2020-03-23 17:08:51.417444	2020-03-23 17:08:51.417444
1374	Saint Thomas	14	112	2020-03-23 17:08:51.419151	2020-03-23 17:08:51.419151
1375	Saint Mary	13	112	2020-03-23 17:08:51.420819	2020-03-23 17:08:51.420819
1376	Saint James	12	112	2020-03-23 17:08:51.422646	2020-03-23 17:08:51.422646
1377	St. Elizabeth	11	112	2020-03-23 17:08:51.424401	2020-03-23 17:08:51.424401
1378	Saint Catherine	10	112	2020-03-23 17:08:51.426726	2020-03-23 17:08:51.426726
1379	Saint Ann	09	112	2020-03-23 17:08:51.42893	2020-03-23 17:08:51.42893
1380	Saint Andrew	08	112	2020-03-23 17:08:51.433014	2020-03-23 17:08:51.433014
1381	Portland	07	112	2020-03-23 17:08:51.434846	2020-03-23 17:08:51.434846
1382	Manchester	04	112	2020-03-23 17:08:51.436605	2020-03-23 17:08:51.436605
1383	Kingston	17	112	2020-03-23 17:08:51.43844	2020-03-23 17:08:51.43844
1384	Hanover Parish	02	112	2020-03-23 17:08:51.440082	2020-03-23 17:08:51.440082
1385	Clarendon	01	112	2020-03-23 17:08:51.442166	2020-03-23 17:08:51.442166
1386	Ma’an	19	113	2020-03-23 17:08:51.444306	2020-03-23 17:08:51.444306
1387	Irbid	18	113	2020-03-23 17:08:51.446023	2020-03-23 17:08:51.446023
1388	Zarqa	17	113	2020-03-23 17:08:51.447814	2020-03-23 17:08:51.447814
1389	Tafielah	12	113	2020-03-23 17:08:51.449369	2020-03-23 17:08:51.449369
1390	Amman	16	113	2020-03-23 17:08:51.450827	2020-03-23 17:08:51.450827
1391	Mafraq	15	113	2020-03-23 17:08:51.452541	2020-03-23 17:08:51.452541
1392	Karak	09	113	2020-03-23 17:08:51.45397	2020-03-23 17:08:51.45397
1393	Balqa	02	113	2020-03-23 17:08:51.455279	2020-03-23 17:08:51.455279
1394	Ajlun	20	113	2020-03-23 17:08:51.456599	2020-03-23 17:08:51.456599
1395	Jerash	22	113	2020-03-23 17:08:51.457976	2020-03-23 17:08:51.457976
1396	Aqaba	21	113	2020-03-23 17:08:51.459426	2020-03-23 17:08:51.459426
1397	Madaba	23	113	2020-03-23 17:08:51.460814	2020-03-23 17:08:51.460814
1398	Yamanashi	46	114	2020-03-23 17:08:51.462281	2020-03-23 17:08:51.462281
1399	Yamaguchi	45	114	2020-03-23 17:08:51.463672	2020-03-23 17:08:51.463672
1400	Wakayama	43	114	2020-03-23 17:08:51.465111	2020-03-23 17:08:51.465111
1401	Toyama	42	114	2020-03-23 17:08:51.466473	2020-03-23 17:08:51.466473
1402	Tottori	41	114	2020-03-23 17:08:51.467847	2020-03-23 17:08:51.467847
1403	Tōkyō	40	114	2020-03-23 17:08:51.46939	2020-03-23 17:08:51.46939
1404	Tokushima	39	114	2020-03-23 17:08:51.470888	2020-03-23 17:08:51.470888
1405	Tochigi	38	114	2020-03-23 17:08:51.472885	2020-03-23 17:08:51.472885
1406	Shizuoka	37	114	2020-03-23 17:08:51.47453	2020-03-23 17:08:51.47453
1407	Shimane	36	114	2020-03-23 17:08:51.476079	2020-03-23 17:08:51.476079
1408	Shiga	35	114	2020-03-23 17:08:51.477622	2020-03-23 17:08:51.477622
1409	Saitama	34	114	2020-03-23 17:08:51.479224	2020-03-23 17:08:51.479224
1410	Saga	33	114	2020-03-23 17:08:51.480483	2020-03-23 17:08:51.480483
1411	Ōsaka	32	114	2020-03-23 17:08:51.481861	2020-03-23 17:08:51.481861
1412	Okinawa	47	114	2020-03-23 17:08:51.483192	2020-03-23 17:08:51.483192
1413	Okayama	31	114	2020-03-23 17:08:51.484482	2020-03-23 17:08:51.484482
1414	Ōita	30	114	2020-03-23 17:08:51.485751	2020-03-23 17:08:51.485751
1415	Niigata	29	114	2020-03-23 17:08:51.487085	2020-03-23 17:08:51.487085
1416	Nara	28	114	2020-03-23 17:08:51.488443	2020-03-23 17:08:51.488443
1417	Nagasaki	27	114	2020-03-23 17:08:51.489743	2020-03-23 17:08:51.489743
1418	Nagano	26	114	2020-03-23 17:08:51.491054	2020-03-23 17:08:51.491054
1419	Miyazaki	25	114	2020-03-23 17:08:51.492839	2020-03-23 17:08:51.492839
1420	Mie	23	114	2020-03-23 17:08:51.494218	2020-03-23 17:08:51.494218
1421	Kyōto	22	114	2020-03-23 17:08:51.495481	2020-03-23 17:08:51.495481
1422	Kumamoto	21	114	2020-03-23 17:08:51.496865	2020-03-23 17:08:51.496865
1423	Kōchi	20	114	2020-03-23 17:08:51.500971	2020-03-23 17:08:51.500971
1424	Kanagawa	19	114	2020-03-23 17:08:51.502891	2020-03-23 17:08:51.502891
1425	Kagoshima	18	114	2020-03-23 17:08:51.506299	2020-03-23 17:08:51.506299
1426	Kagawa	17	114	2020-03-23 17:08:51.50908	2020-03-23 17:08:51.50908
1427	Ishikawa	15	114	2020-03-23 17:08:51.5137	2020-03-23 17:08:51.5137
1428	Hyōgo	13	114	2020-03-23 17:08:51.516553	2020-03-23 17:08:51.516553
1429	Hiroshima	11	114	2020-03-23 17:08:51.518676	2020-03-23 17:08:51.518676
1430	Gunma	10	114	2020-03-23 17:08:51.520648	2020-03-23 17:08:51.520648
1431	Gifu	09	114	2020-03-23 17:08:51.522717	2020-03-23 17:08:51.522717
1432	Fukuoka	07	114	2020-03-23 17:08:51.52565	2020-03-23 17:08:51.52565
1433	Fukui	06	114	2020-03-23 17:08:51.529403	2020-03-23 17:08:51.529403
1434	Ehime	05	114	2020-03-23 17:08:51.534409	2020-03-23 17:08:51.534409
1435	Aichi	01	114	2020-03-23 17:08:51.537315	2020-03-23 17:08:51.537315
1436	Yamagata	44	114	2020-03-23 17:08:51.540924	2020-03-23 17:08:51.540924
1437	Miyagi	24	114	2020-03-23 17:08:51.543436	2020-03-23 17:08:51.543436
1438	Iwate	16	114	2020-03-23 17:08:51.546377	2020-03-23 17:08:51.546377
1439	Ibaraki	14	114	2020-03-23 17:08:51.549583	2020-03-23 17:08:51.549583
1440	Fukushima	08	114	2020-03-23 17:08:51.551737	2020-03-23 17:08:51.551737
1441	Chiba	04	114	2020-03-23 17:08:51.554782	2020-03-23 17:08:51.554782
1442	Akita	02	114	2020-03-23 17:08:51.55671	2020-03-23 17:08:51.55671
1443	Hokkaidō	12	114	2020-03-23 17:08:51.558833	2020-03-23 17:08:51.558833
1444	Aomori	03	114	2020-03-23 17:08:51.560835	2020-03-23 17:08:51.560835
1445	Nyanza	07	115	2020-03-23 17:08:51.581322	2020-03-23 17:08:51.581322
1446	Nairobi Area	05	115	2020-03-23 17:08:51.583741	2020-03-23 17:08:51.583741
1447	Coast	02	115	2020-03-23 17:08:51.586972	2020-03-23 17:08:51.586972
1448	Eastern	03	115	2020-03-23 17:08:51.591657	2020-03-23 17:08:51.591657
1449	Central	01	115	2020-03-23 17:08:51.595507	2020-03-23 17:08:51.595507
1450	Western	09	115	2020-03-23 17:08:51.597295	2020-03-23 17:08:51.597295
1451	Rift Valley	08	115	2020-03-23 17:08:51.598854	2020-03-23 17:08:51.598854
1452	North-Eastern	06	115	2020-03-23 17:08:51.600573	2020-03-23 17:08:51.600573
1453	Osh	08	116	2020-03-23 17:08:51.602109	2020-03-23 17:08:51.602109
1454	Batken	09	116	2020-03-23 17:08:51.605605	2020-03-23 17:08:51.605605
1455	Talas	06	116	2020-03-23 17:08:51.607437	2020-03-23 17:08:51.607437
1456	Naryn	04	116	2020-03-23 17:08:51.609231	2020-03-23 17:08:51.609231
1457	Ysyk-Köl	07	116	2020-03-23 17:08:51.611412	2020-03-23 17:08:51.611412
1458	Bishkek	01	116	2020-03-23 17:08:51.613658	2020-03-23 17:08:51.613658
1459	Jalal-Abad	03	116	2020-03-23 17:08:51.615431	2020-03-23 17:08:51.615431
1460	Chüy	02	116	2020-03-23 17:08:51.617622	2020-03-23 17:08:51.617622
1461	Poŭthĭsăt	12	117	2020-03-23 17:08:51.620036	2020-03-23 17:08:51.620036
1462	Khétt Bătdâmbâng	29	117	2020-03-23 17:08:51.62232	2020-03-23 17:08:51.62232
1463	Takêv	19	117	2020-03-23 17:08:51.624365	2020-03-23 17:08:51.624365
1464	Svay Riĕng	18	117	2020-03-23 17:08:51.626567	2020-03-23 17:08:51.626567
1465	Stœ̆ng Trêng	17	117	2020-03-23 17:08:51.628416	2020-03-23 17:08:51.628416
1466	Ŏtâr Méanchey	27	117	2020-03-23 17:08:51.630611	2020-03-23 17:08:51.630611
1467	Khétt Siĕm Réab	24	117	2020-03-23 17:08:51.63498	2020-03-23 17:08:51.63498
1468	Khêtt Rôtânôkiri	23	117	2020-03-23 17:08:51.637122	2020-03-23 17:08:51.637122
1469	Prey Vêng	14	117	2020-03-23 17:08:51.639076	2020-03-23 17:08:51.639076
1470	Preăh Vĭhéar	13	117	2020-03-23 17:08:51.640616	2020-03-23 17:08:51.640616
1471	Krŏng Phnum Pénh	22	117	2020-03-23 17:08:51.642276	2020-03-23 17:08:51.642276
1472	Khétt Pailĭn	30	117	2020-03-23 17:08:51.643944	2020-03-23 17:08:51.643944
1473	Môndól Kiri	10	117	2020-03-23 17:08:51.645316	2020-03-23 17:08:51.645316
1474	Krâchéh	09	117	2020-03-23 17:08:51.64675	2020-03-23 17:08:51.64675
1475	Khétt Kêb	26	117	2020-03-23 17:08:51.648162	2020-03-23 17:08:51.648162
1476	Kaôh Kŏng	08	117	2020-03-23 17:08:51.649539	2020-03-23 17:08:51.649539
1477	Kândal	07	117	2020-03-23 17:08:51.651255	2020-03-23 17:08:51.651255
1478	Khétt Kâmpôt	21	117	2020-03-23 17:08:51.654141	2020-03-23 17:08:51.654141
1479	Kâmpóng Thum	05	117	2020-03-23 17:08:51.656042	2020-03-23 17:08:51.656042
1480	Khétt Kâmpóng Spœ	04	117	2020-03-23 17:08:51.65832	2020-03-23 17:08:51.65832
1481	Kâmpóng Chhnăng	03	117	2020-03-23 17:08:51.65985	2020-03-23 17:08:51.65985
1482	Kâmpóng Cham	02	117	2020-03-23 17:08:51.661534	2020-03-23 17:08:51.661534
1483	Khétt Preăh Seihânŭ	28	117	2020-03-23 17:08:51.663684	2020-03-23 17:08:51.663684
1484	Khétt Bântéay Méan Choăy	25	117	2020-03-23 17:08:51.665488	2020-03-23 17:08:51.665488
1485	Battambang	01	117	2020-03-23 17:08:51.667126	2020-03-23 17:08:51.667126
1486	Gilbert Islands	01	118	2020-03-23 17:08:51.668962	2020-03-23 17:08:51.668962
1487	Line Islands	02	118	2020-03-23 17:08:51.670812	2020-03-23 17:08:51.670812
1488	Phoenix Islands	03	118	2020-03-23 17:08:51.673299	2020-03-23 17:08:51.673299
1489	Mohéli	03	119	2020-03-23 17:08:51.675055	2020-03-23 17:08:51.675055
1490	Grande Comore	02	119	2020-03-23 17:08:51.67712	2020-03-23 17:08:51.67712
1491	Anjouan	01	119	2020-03-23 17:08:51.679401	2020-03-23 17:08:51.679401
1492	Trinity Palmetto Point	15	120	2020-03-23 17:08:51.681494	2020-03-23 17:08:51.681494
1493	Saint Thomas Middle Island	13	120	2020-03-23 17:08:51.68321	2020-03-23 17:08:51.68321
1494	Saint Thomas Lowland	12	120	2020-03-23 17:08:51.684748	2020-03-23 17:08:51.684748
1495	Saint Peter Basseterre	11	120	2020-03-23 17:08:51.686539	2020-03-23 17:08:51.686539
1496	Saint Paul Charlestown	10	120	2020-03-23 17:08:51.688361	2020-03-23 17:08:51.688361
1497	Saint Paul Capesterre	09	120	2020-03-23 17:08:51.690332	2020-03-23 17:08:51.690332
1498	Saint Mary Cayon	08	120	2020-03-23 17:08:51.692211	2020-03-23 17:08:51.692211
1499	Saint John Figtree	07	120	2020-03-23 17:08:51.694031	2020-03-23 17:08:51.694031
1500	Saint John Capesterre	06	120	2020-03-23 17:08:51.695949	2020-03-23 17:08:51.695949
1501	Saint James Windwa	05	120	2020-03-23 17:08:51.697813	2020-03-23 17:08:51.697813
1502	Saint George Gingerland	04	120	2020-03-23 17:08:51.701166	2020-03-23 17:08:51.701166
1503	Saint George Basseterre	03	120	2020-03-23 17:08:51.702779	2020-03-23 17:08:51.702779
1504	Saint Anne Sandy Point	02	120	2020-03-23 17:08:51.704496	2020-03-23 17:08:51.704496
1505	Christ Church Nichola Town	01	120	2020-03-23 17:08:51.706204	2020-03-23 17:08:51.706204
1506	P'yŏngyang-si	12	121	2020-03-23 17:08:51.708123	2020-03-23 17:08:51.708123
1507	P'yŏngan-namdo	15	121	2020-03-23 17:08:51.709819	2020-03-23 17:08:51.709819
1508	P'yŏngan-bukto	11	121	2020-03-23 17:08:51.711442	2020-03-23 17:08:51.711442
1509	Gangwon	09	121	2020-03-23 17:08:51.713888	2020-03-23 17:08:51.713888
1510	Hwanghae-namdo	06	121	2020-03-23 17:08:51.715685	2020-03-23 17:08:51.715685
1511	Hwanghae-bukto	07	121	2020-03-23 17:08:51.717469	2020-03-23 17:08:51.717469
1512	Hamgyŏng-namdo	03	121	2020-03-23 17:08:51.719102	2020-03-23 17:08:51.719102
1513	Yanggang-do	13	121	2020-03-23 17:08:51.720804	2020-03-23 17:08:51.720804
1514	Hamgyŏng-bukto	17	121	2020-03-23 17:08:51.722631	2020-03-23 17:08:51.722631
1515	Chagang-do	01	121	2020-03-23 17:08:51.724222	2020-03-23 17:08:51.724222
1516	Najin Sŏnbong-si	18	121	2020-03-23 17:08:51.726289	2020-03-23 17:08:51.726289
1517	Ulsan	21	122	2020-03-23 17:08:51.727912	2020-03-23 17:08:51.727912
1518	Daejeon	19	122	2020-03-23 17:08:51.729472	2020-03-23 17:08:51.729472
1519	Daegu	15	122	2020-03-23 17:08:51.731137	2020-03-23 17:08:51.731137
1520	Seoul	11	122	2020-03-23 17:08:51.733153	2020-03-23 17:08:51.733153
1521	Busan	10	122	2020-03-23 17:08:51.734849	2020-03-23 17:08:51.734849
1522	North Gyeongsang	14	122	2020-03-23 17:08:51.736505	2020-03-23 17:08:51.736505
1523	Gyeonggi	13	122	2020-03-23 17:08:51.738052	2020-03-23 17:08:51.738052
1524	Gwangju	18	122	2020-03-23 17:08:51.739403	2020-03-23 17:08:51.739403
1525	Gangwon	06	122	2020-03-23 17:08:51.740776	2020-03-23 17:08:51.740776
1526	Incheon	12	122	2020-03-23 17:08:51.742566	2020-03-23 17:08:51.742566
1527	South Chungcheong	17	122	2020-03-23 17:08:51.744002	2020-03-23 17:08:51.744002
1528	North Chungcheong	05	122	2020-03-23 17:08:51.745591	2020-03-23 17:08:51.745591
1529	South Jeolla	16	122	2020-03-23 17:08:51.747314	2020-03-23 17:08:51.747314
1530	North Jeolla	03	122	2020-03-23 17:08:51.74966	2020-03-23 17:08:51.74966
1531	Jeju	01	122	2020-03-23 17:08:51.751112	2020-03-23 17:08:51.751112
1532	South Gyeongsang	20	122	2020-03-23 17:08:51.752901	2020-03-23 17:08:51.752901
1533	Ḩawallī	08	124	2020-03-23 17:08:51.754544	2020-03-23 17:08:51.754544
1534	Al ‘Āşimah	02	124	2020-03-23 17:08:51.756307	2020-03-23 17:08:51.756307
1535	Al Jahrāʼ	05	124	2020-03-23 17:08:51.758398	2020-03-23 17:08:51.758398
1536	Al Farwaniyah	07	124	2020-03-23 17:08:51.760189	2020-03-23 17:08:51.760189
1537	Al Aḩmadī	04	124	2020-03-23 17:08:51.761794	2020-03-23 17:08:51.761794
1538	Muḩāfaz̧at Mubārak al Kabīr	09	124	2020-03-23 17:08:51.763343	2020-03-23 17:08:51.763343
1539	Batys Qazaqstan	07	126	2020-03-23 17:08:51.764915	2020-03-23 17:08:51.764915
1540	Mangghystaū	09	126	2020-03-23 17:08:51.766411	2020-03-23 17:08:51.766411
1541	Atyraū	06	126	2020-03-23 17:08:51.767883	2020-03-23 17:08:51.767883
1542	Aqtöbe	04	126	2020-03-23 17:08:51.769524	2020-03-23 17:08:51.769524
1543	East Kazakhstan	15	126	2020-03-23 17:08:51.771359	2020-03-23 17:08:51.771359
1544	Aqmola	03	126	2020-03-23 17:08:51.773385	2020-03-23 17:08:51.773385
1545	Soltüstik Qazaqstan	16	126	2020-03-23 17:08:51.77514	2020-03-23 17:08:51.77514
1546	Pavlodar	11	126	2020-03-23 17:08:51.77689	2020-03-23 17:08:51.77689
1547	Qyzylorda	14	126	2020-03-23 17:08:51.778351	2020-03-23 17:08:51.778351
1548	Qostanay	13	126	2020-03-23 17:08:51.779831	2020-03-23 17:08:51.779831
1549	Qaraghandy	12	126	2020-03-23 17:08:51.781409	2020-03-23 17:08:51.781409
1550	Zhambyl	17	126	2020-03-23 17:08:51.783671	2020-03-23 17:08:51.783671
1551	Ongtüstik Qazaqstan	10	126	2020-03-23 17:08:51.785822	2020-03-23 17:08:51.785822
1552	Almaty Qalasy	02	126	2020-03-23 17:08:51.787288	2020-03-23 17:08:51.787288
1553	Almaty	01	126	2020-03-23 17:08:51.788832	2020-03-23 17:08:51.788832
1554	Bayqongyr Qalasy	08	126	2020-03-23 17:08:51.790349	2020-03-23 17:08:51.790349
1555	Astana Qalasy	05	126	2020-03-23 17:08:51.792179	2020-03-23 17:08:51.792179
1556	Xiangkhoang	14	127	2020-03-23 17:08:51.793964	2020-03-23 17:08:51.793964
1557	Xiagnabouli	13	127	2020-03-23 17:08:51.795487	2020-03-23 17:08:51.795487
1558	Khouèng Viangchan	27	127	2020-03-23 17:08:51.796873	2020-03-23 17:08:51.796873
1559	Savannahkhét	20	127	2020-03-23 17:08:51.798387	2020-03-23 17:08:51.798387
1560	Salavan	19	127	2020-03-23 17:08:51.799976	2020-03-23 17:08:51.799976
1561	Phôngsali	18	127	2020-03-23 17:08:51.801649	2020-03-23 17:08:51.801649
1562	Oudômxai	07	127	2020-03-23 17:08:51.80314	2020-03-23 17:08:51.80314
1563	Louangphabang	17	127	2020-03-23 17:08:51.804645	2020-03-23 17:08:51.804645
1564	Loungnamtha	16	127	2020-03-23 17:08:51.806158	2020-03-23 17:08:51.806158
1565	Khammouan	15	127	2020-03-23 17:08:51.807617	2020-03-23 17:08:51.807617
1566	Houaphan	03	127	2020-03-23 17:08:51.80938	2020-03-23 17:08:51.80938
1567	Champasak	02	127	2020-03-23 17:08:51.811046	2020-03-23 17:08:51.811046
1568	Attapu	01	127	2020-03-23 17:08:51.81296	2020-03-23 17:08:51.81296
1569	Xékong	26	127	2020-03-23 17:08:51.814492	2020-03-23 17:08:51.814492
1570	Bokèo	22	127	2020-03-23 17:08:51.816005	2020-03-23 17:08:51.816005
1571	Bolikhamxai	23	127	2020-03-23 17:08:51.817449	2020-03-23 17:08:51.817449
1572	Viangchan	24	127	2020-03-23 17:08:51.818978	2020-03-23 17:08:51.818978
1573	Mont-Liban	05	128	2020-03-23 17:08:51.820682	2020-03-23 17:08:51.820682
1574	Beyrouth	04	128	2020-03-23 17:08:51.822184	2020-03-23 17:08:51.822184
1575	Liban-Nord	09	128	2020-03-23 17:08:51.823643	2020-03-23 17:08:51.823643
1576	Liban-Sud	06	128	2020-03-23 17:08:51.825151	2020-03-23 17:08:51.825151
1577	Béqaa	08	128	2020-03-23 17:08:51.82679	2020-03-23 17:08:51.82679
1578	Nabatîyé	07	128	2020-03-23 17:08:51.828345	2020-03-23 17:08:51.828345
1579	Aakkâr	10	128	2020-03-23 17:08:51.829882	2020-03-23 17:08:51.829882
1580	Baalbek-Hermel	11	128	2020-03-23 17:08:51.831688	2020-03-23 17:08:51.831688
1581	Vieux-Fort	10	129	2020-03-23 17:08:51.833454	2020-03-23 17:08:51.833454
1582	Soufrière	09	129	2020-03-23 17:08:51.834904	2020-03-23 17:08:51.834904
1583	Praslin	11	129	2020-03-23 17:08:51.83645	2020-03-23 17:08:51.83645
1584	Micoud	08	129	2020-03-23 17:08:51.837964	2020-03-23 17:08:51.837964
1585	Laborie	07	129	2020-03-23 17:08:51.839488	2020-03-23 17:08:51.839488
1586	Gros-Islet	06	129	2020-03-23 17:08:51.841041	2020-03-23 17:08:51.841041
1587	Dennery	05	129	2020-03-23 17:08:51.842547	2020-03-23 17:08:51.842547
1588	Dauphin	02	129	2020-03-23 17:08:51.844162	2020-03-23 17:08:51.844162
1589	Choiseul	04	129	2020-03-23 17:08:51.845762	2020-03-23 17:08:51.845762
1590	Castries	03	129	2020-03-23 17:08:51.8474	2020-03-23 17:08:51.8474
1591	Anse-la-Raye	01	129	2020-03-23 17:08:51.849056	2020-03-23 17:08:51.849056
1592	Vaduz	11	130	2020-03-23 17:08:51.850788	2020-03-23 17:08:51.850788
1593	Triesenberg	10	130	2020-03-23 17:08:51.852917	2020-03-23 17:08:51.852917
1594	Triesen	09	130	2020-03-23 17:08:51.854548	2020-03-23 17:08:51.854548
1595	Schellenberg	08	130	2020-03-23 17:08:51.856225	2020-03-23 17:08:51.856225
1596	Schaan	07	130	2020-03-23 17:08:51.85804	2020-03-23 17:08:51.85804
1597	Ruggell	06	130	2020-03-23 17:08:51.859707	2020-03-23 17:08:51.859707
1598	Planken	05	130	2020-03-23 17:08:51.861339	2020-03-23 17:08:51.861339
1599	Mauren	04	130	2020-03-23 17:08:51.862976	2020-03-23 17:08:51.862976
1600	Gamprin	03	130	2020-03-23 17:08:51.864726	2020-03-23 17:08:51.864726
1601	Eschen	02	130	2020-03-23 17:08:51.866425	2020-03-23 17:08:51.866425
1602	Balzers	01	130	2020-03-23 17:08:51.868184	2020-03-23 17:08:51.868184
1603	Western	36	131	2020-03-23 17:08:51.869856	2020-03-23 17:08:51.869856
1604	Uva	35	131	2020-03-23 17:08:51.871572	2020-03-23 17:08:51.871572
1605	Southern	34	131	2020-03-23 17:08:51.873456	2020-03-23 17:08:51.873456
1606	Sabaragamuwa	33	131	2020-03-23 17:08:51.875154	2020-03-23 17:08:51.875154
1607	North Western	32	131	2020-03-23 17:08:51.877208	2020-03-23 17:08:51.877208
1608	North Eastern	31	131	2020-03-23 17:08:51.880732	2020-03-23 17:08:51.880732
1609	North Central	30	131	2020-03-23 17:08:51.882344	2020-03-23 17:08:51.882344
1610	Central	29	131	2020-03-23 17:08:51.883877	2020-03-23 17:08:51.883877
1611	Northern Province	38	131	2020-03-23 17:08:51.885378	2020-03-23 17:08:51.885378
1612	Sinoe	10	132	2020-03-23 17:08:51.886762	2020-03-23 17:08:51.886762
1613	Nimba	09	132	2020-03-23 17:08:51.888128	2020-03-23 17:08:51.888128
1614	Montserrado	14	132	2020-03-23 17:08:51.889536	2020-03-23 17:08:51.889536
1615	Maryland	13	132	2020-03-23 17:08:51.890968	2020-03-23 17:08:51.890968
1616	Lofa	20	132	2020-03-23 17:08:51.893241	2020-03-23 17:08:51.893241
1617	Grand Gedeh	19	132	2020-03-23 17:08:51.894754	2020-03-23 17:08:51.894754
1618	Grand Cape Mount	12	132	2020-03-23 17:08:51.89614	2020-03-23 17:08:51.89614
1619	Grand Bassa	11	132	2020-03-23 17:08:51.903884	2020-03-23 17:08:51.903884
1620	Bong	01	132	2020-03-23 17:08:51.908667	2020-03-23 17:08:51.908667
1621	Bomi	15	132	2020-03-23 17:08:51.911306	2020-03-23 17:08:51.911306
1622	Grand Kru	16	132	2020-03-23 17:08:51.913989	2020-03-23 17:08:51.913989
1623	Margibi	17	132	2020-03-23 17:08:51.915873	2020-03-23 17:08:51.915873
1624	River Cess	18	132	2020-03-23 17:08:51.917683	2020-03-23 17:08:51.917683
1625	Gbarpolu	21	132	2020-03-23 17:08:51.919358	2020-03-23 17:08:51.919358
1626	River Gee	22	132	2020-03-23 17:08:51.92115	2020-03-23 17:08:51.92115
1627	Thaba-Tseka	19	133	2020-03-23 17:08:51.922856	2020-03-23 17:08:51.922856
1628	Quthing	18	133	2020-03-23 17:08:51.924696	2020-03-23 17:08:51.924696
1629	Qachaʼs Nek	17	133	2020-03-23 17:08:51.926578	2020-03-23 17:08:51.926578
1630	Mokhotlong	16	133	2020-03-23 17:08:51.928301	2020-03-23 17:08:51.928301
1631	Mohaleʼs Hoek	15	133	2020-03-23 17:08:51.930078	2020-03-23 17:08:51.930078
1632	Maseru	14	133	2020-03-23 17:08:51.931979	2020-03-23 17:08:51.931979
1633	Mafeteng	13	133	2020-03-23 17:08:51.934112	2020-03-23 17:08:51.934112
1634	Leribe	12	133	2020-03-23 17:08:51.935903	2020-03-23 17:08:51.935903
1635	Butha-Buthe	11	133	2020-03-23 17:08:51.937572	2020-03-23 17:08:51.937572
1636	Berea	10	133	2020-03-23 17:08:51.939217	2020-03-23 17:08:51.939217
1637	Alytaus Apskritis	56	134	2020-03-23 17:08:51.941102	2020-03-23 17:08:51.941102
1638	Kauno Apskritis	57	134	2020-03-23 17:08:51.943066	2020-03-23 17:08:51.943066
1639	Klaipėdos Apskritis	58	134	2020-03-23 17:08:51.944898	2020-03-23 17:08:51.944898
1640	Marijampolės Apskritis	59	134	2020-03-23 17:08:51.947361	2020-03-23 17:08:51.947361
1641	Panevėžio Apskritis	60	134	2020-03-23 17:08:51.950223	2020-03-23 17:08:51.950223
1642	Šiaulių Apskritis	61	134	2020-03-23 17:08:51.952138	2020-03-23 17:08:51.952138
1643	Tauragės Apskritis	62	134	2020-03-23 17:08:51.953956	2020-03-23 17:08:51.953956
1644	Telšių Apskritis	63	134	2020-03-23 17:08:51.955426	2020-03-23 17:08:51.955426
1645	Utenos Apskritis	64	134	2020-03-23 17:08:51.956749	2020-03-23 17:08:51.956749
1646	Vilniaus Apskritis	65	134	2020-03-23 17:08:51.958269	2020-03-23 17:08:51.958269
1647	Luxembourg	03	135	2020-03-23 17:08:51.959724	2020-03-23 17:08:51.959724
1648	Grevenmacher	02	135	2020-03-23 17:08:51.961167	2020-03-23 17:08:51.961167
1649	Diekirch	01	135	2020-03-23 17:08:51.962573	2020-03-23 17:08:51.962573
1650	Ventspils Rajons	33	136	2020-03-23 17:08:51.963914	2020-03-23 17:08:51.963914
1651	Ventspils	32	136	2020-03-23 17:08:51.965481	2020-03-23 17:08:51.965481
1652	Valmieras Rajons	31	136	2020-03-23 17:08:51.96694	2020-03-23 17:08:51.96694
1653	Valkas Rajons	30	136	2020-03-23 17:08:51.968405	2020-03-23 17:08:51.968405
1654	Tukuma Rajons	29	136	2020-03-23 17:08:51.969973	2020-03-23 17:08:51.969973
1655	Talsu Rajons	28	136	2020-03-23 17:08:51.971566	2020-03-23 17:08:51.971566
1656	Saldus Rajons	27	136	2020-03-23 17:08:51.97357	2020-03-23 17:08:51.97357
1657	Rīgas Rajons	26	136	2020-03-23 17:08:51.974993	2020-03-23 17:08:51.974993
1658	Rīga	25	136	2020-03-23 17:08:51.976362	2020-03-23 17:08:51.976362
1659	Rēzeknes Rajons	24	136	2020-03-23 17:08:51.977785	2020-03-23 17:08:51.977785
1660	Rēzekne	23	136	2020-03-23 17:08:51.979243	2020-03-23 17:08:51.979243
1661	Preiļu Rajons	22	136	2020-03-23 17:08:51.981074	2020-03-23 17:08:51.981074
1662	Ogres Rajons	21	136	2020-03-23 17:08:51.982763	2020-03-23 17:08:51.982763
1663	Madonas Rajons	20	136	2020-03-23 17:08:51.984848	2020-03-23 17:08:51.984848
1664	Ludzas Rajons	19	136	2020-03-23 17:08:51.986395	2020-03-23 17:08:51.986395
1665	Limbažu Rajons	18	136	2020-03-23 17:08:51.987973	2020-03-23 17:08:51.987973
1666	Liepājas Rajons	17	136	2020-03-23 17:08:51.9897	2020-03-23 17:08:51.9897
1667	Liepāja	16	136	2020-03-23 17:08:51.991585	2020-03-23 17:08:51.991585
1668	Kuldīgas Rajons	15	136	2020-03-23 17:08:51.994097	2020-03-23 17:08:51.994097
1669	Krāslavas Rajons	14	136	2020-03-23 17:08:51.995626	2020-03-23 17:08:51.995626
1670	Jūrmala	13	136	2020-03-23 17:08:51.997147	2020-03-23 17:08:51.997147
1671	Jelgavas Rajons	12	136	2020-03-23 17:08:51.998805	2020-03-23 17:08:51.998805
1672	Jelgava	11	136	2020-03-23 17:08:52.000292	2020-03-23 17:08:52.000292
1673	Jēkabpils Rajons	10	136	2020-03-23 17:08:52.001743	2020-03-23 17:08:52.001743
1674	Gulbenes Rajons	09	136	2020-03-23 17:08:52.003163	2020-03-23 17:08:52.003163
1675	Dobeles Rajons	08	136	2020-03-23 17:08:52.004615	2020-03-23 17:08:52.004615
1676	Daugavpils Rajons	07	136	2020-03-23 17:08:52.006067	2020-03-23 17:08:52.006067
1677	Daugavpils	06	136	2020-03-23 17:08:52.007612	2020-03-23 17:08:52.007612
1678	Cēsu Rajons	05	136	2020-03-23 17:08:52.009084	2020-03-23 17:08:52.009084
1679	Bauskas Rajons	04	136	2020-03-23 17:08:52.010614	2020-03-23 17:08:52.010614
1680	Balvu Rajons	03	136	2020-03-23 17:08:52.012373	2020-03-23 17:08:52.012373
1681	Alūksnes Rajons	02	136	2020-03-23 17:08:52.014316	2020-03-23 17:08:52.014316
1682	Aizkraukles Rajons	01	136	2020-03-23 17:08:52.015763	2020-03-23 17:08:52.015763
1683	Dundagas Novads	60	136	2020-03-23 17:08:52.017099	2020-03-23 17:08:52.017099
1684	Alsungas Novads	40	136	2020-03-23 17:08:52.018487	2020-03-23 17:08:52.018487
1685	Pāvilostas Novads	A5	136	2020-03-23 17:08:52.019967	2020-03-23 17:08:52.019967
1686	Nīcas Novads	99	136	2020-03-23 17:08:52.021331	2020-03-23 17:08:52.021331
1687	Rucavas Novads	B6	136	2020-03-23 17:08:52.022685	2020-03-23 17:08:52.022685
1688	Grobiņas Novads	65	136	2020-03-23 17:08:52.024179	2020-03-23 17:08:52.024179
1689	Durbes Novads	61	136	2020-03-23 17:08:52.025768	2020-03-23 17:08:52.025768
1690	Aizputes Novads	37	136	2020-03-23 17:08:52.027262	2020-03-23 17:08:52.027262
1691	Priekules Novads	A8	136	2020-03-23 17:08:52.028678	2020-03-23 17:08:52.028678
1692	Vaiņodes Novads	D7	136	2020-03-23 17:08:52.030107	2020-03-23 17:08:52.030107
1693	Skrundas Novads	C9	136	2020-03-23 17:08:52.031733	2020-03-23 17:08:52.031733
1694	Brocēnu Novads	51	136	2020-03-23 17:08:52.033865	2020-03-23 17:08:52.033865
1695	Rojas Novads	B4	136	2020-03-23 17:08:52.035412	2020-03-23 17:08:52.035412
1696	Kandavas Novads	77	136	2020-03-23 17:08:52.036866	2020-03-23 17:08:52.036866
1697	Auces Novads	44	136	2020-03-23 17:08:52.038351	2020-03-23 17:08:52.038351
1698	Jaunpils Novads	73	136	2020-03-23 17:08:52.039941	2020-03-23 17:08:52.039941
1699	Engures Novads	62	136	2020-03-23 17:08:52.041409	2020-03-23 17:08:52.041409
1700	Tērvetes Novads	D5	136	2020-03-23 17:08:52.043287	2020-03-23 17:08:52.043287
1701	Ozolnieku Novads	A3	136	2020-03-23 17:08:52.044809	2020-03-23 17:08:52.044809
1702	Rundāles Novads	B9	136	2020-03-23 17:08:52.046548	2020-03-23 17:08:52.046548
1703	Babītes Novads	45	136	2020-03-23 17:08:52.048127	2020-03-23 17:08:52.048127
1704	Mārupes Novads	95	136	2020-03-23 17:08:52.04965	2020-03-23 17:08:52.04965
1705	Olaines Novads	A2	136	2020-03-23 17:08:52.05093	2020-03-23 17:08:52.05093
1706	Iecavas Novads	67	136	2020-03-23 17:08:52.052916	2020-03-23 17:08:52.052916
1707	Ķekavas Novads	80	136	2020-03-23 17:08:52.05448	2020-03-23 17:08:52.05448
1708	Salaspils Novads	C3	136	2020-03-23 17:08:52.05596	2020-03-23 17:08:52.05596
1709	Baldones Novads	46	136	2020-03-23 17:08:52.057387	2020-03-23 17:08:52.057387
1710	Stopiņu Novads	D2	136	2020-03-23 17:08:52.058741	2020-03-23 17:08:52.058741
1711	Carnikavas Novads	53	136	2020-03-23 17:08:52.060058	2020-03-23 17:08:52.060058
1712	Ādažu Novads	34	136	2020-03-23 17:08:52.061454	2020-03-23 17:08:52.061454
1713	Garkalnes Novads	64	136	2020-03-23 17:08:52.062891	2020-03-23 17:08:52.062891
1714	Vecumnieku Novads	E4	136	2020-03-23 17:08:52.064496	2020-03-23 17:08:52.064496
1715	Ķeguma Novads	79	136	2020-03-23 17:08:52.066078	2020-03-23 17:08:52.066078
1716	Lielvārdes Novads	87	136	2020-03-23 17:08:52.067606	2020-03-23 17:08:52.067606
1717	Skrīveru Novads	C8	136	2020-03-23 17:08:52.068951	2020-03-23 17:08:52.068951
1718	Jaunjelgavas Novads	71	136	2020-03-23 17:08:52.070244	2020-03-23 17:08:52.070244
1719	Neretas Novads	98	136	2020-03-23 17:08:52.071902	2020-03-23 17:08:52.071902
1720	Viesītes Novads	E6	136	2020-03-23 17:08:52.073827	2020-03-23 17:08:52.073827
1721	Salas Novads	C2	136	2020-03-23 17:08:52.076128	2020-03-23 17:08:52.076128
1722	Jēkabpils	74	136	2020-03-23 17:08:52.077807	2020-03-23 17:08:52.077807
1723	Aknīstes Novads	38	136	2020-03-23 17:08:52.079196	2020-03-23 17:08:52.079196
1724	Ilūkstes Novads	69	136	2020-03-23 17:08:52.080596	2020-03-23 17:08:52.080596
1725	Vārkavas Novads	E2	136	2020-03-23 17:08:52.082014	2020-03-23 17:08:52.082014
1726	Līvānu Novads	90	136	2020-03-23 17:08:52.083495	2020-03-23 17:08:52.083495
1727	Varakļānu Novads	E1	136	2020-03-23 17:08:52.084891	2020-03-23 17:08:52.084891
1728	Viļānu Novads	E8	136	2020-03-23 17:08:52.086505	2020-03-23 17:08:52.086505
1729	Riebiņu Novads	B3	136	2020-03-23 17:08:52.08791	2020-03-23 17:08:52.08791
1730	Aglonas Novads	35	136	2020-03-23 17:08:52.089373	2020-03-23 17:08:52.089373
1731	Ciblas Novads	56	136	2020-03-23 17:08:52.091187	2020-03-23 17:08:52.091187
1732	Zilupes Novads	E9	136	2020-03-23 17:08:52.093346	2020-03-23 17:08:52.093346
1733	Viļakas Novads	E7	136	2020-03-23 17:08:52.094945	2020-03-23 17:08:52.094945
1734	Baltinavas Novads	47	136	2020-03-23 17:08:52.096401	2020-03-23 17:08:52.096401
1735	Dagdas Novads	57	136	2020-03-23 17:08:52.097827	2020-03-23 17:08:52.097827
1736	Kārsavas Novads	78	136	2020-03-23 17:08:52.099473	2020-03-23 17:08:52.099473
1737	Rugāju Novads	B7	136	2020-03-23 17:08:52.101061	2020-03-23 17:08:52.101061
1738	Cesvaines Novads	55	136	2020-03-23 17:08:52.102718	2020-03-23 17:08:52.102718
1739	Lubānas Novads	91	136	2020-03-23 17:08:52.104395	2020-03-23 17:08:52.104395
1740	Krustpils Novads	85	136	2020-03-23 17:08:52.106281	2020-03-23 17:08:52.106281
1741	Pļaviņu Novads	A6	136	2020-03-23 17:08:52.108088	2020-03-23 17:08:52.108088
1742	Kokneses Novads	82	136	2020-03-23 17:08:52.110035	2020-03-23 17:08:52.110035
1743	Ikšķiles Novads	68	136	2020-03-23 17:08:52.111781	2020-03-23 17:08:52.111781
1744	Ropažu Novads	B5	136	2020-03-23 17:08:52.113855	2020-03-23 17:08:52.113855
1745	Inčukalna Novads	70	136	2020-03-23 17:08:52.11556	2020-03-23 17:08:52.11556
1746	Krimuldas Novads	84	136	2020-03-23 17:08:52.117207	2020-03-23 17:08:52.117207
1747	Siguldas Novads	C7	136	2020-03-23 17:08:52.11886	2020-03-23 17:08:52.11886
1748	Līgatnes Novads	88	136	2020-03-23 17:08:52.120474	2020-03-23 17:08:52.120474
1749	Mālpils Novads	94	136	2020-03-23 17:08:52.122157	2020-03-23 17:08:52.122157
1750	Sējas Novads	C6	136	2020-03-23 17:08:52.123817	2020-03-23 17:08:52.123817
1751	Saulkrastu Novads	C5	136	2020-03-23 17:08:52.125338	2020-03-23 17:08:52.125338
1752	Salacgrīvas Novads	C1	136	2020-03-23 17:08:52.126905	2020-03-23 17:08:52.126905
1753	Alojas Novads	39	136	2020-03-23 17:08:52.128488	2020-03-23 17:08:52.128488
1754	Naukšēnu Novads	97	136	2020-03-23 17:08:52.129987	2020-03-23 17:08:52.129987
1755	Rūjienas Novads	B8	136	2020-03-23 17:08:52.131964	2020-03-23 17:08:52.131964
1756	Mazsalacas Novads	96	136	2020-03-23 17:08:52.133801	2020-03-23 17:08:52.133801
1757	Burtnieku Novads	52	136	2020-03-23 17:08:52.135496	2020-03-23 17:08:52.135496
1758	Pārgaujas Novads	A4	136	2020-03-23 17:08:52.137024	2020-03-23 17:08:52.137024
1759	Kocēnu Novads	81	136	2020-03-23 17:08:52.138652	2020-03-23 17:08:52.138652
1760	Amatas Novads	42	136	2020-03-23 17:08:52.140355	2020-03-23 17:08:52.140355
1761	Priekuļu Novads	A9	136	2020-03-23 17:08:52.142515	2020-03-23 17:08:52.142515
1762	Raunas Novads	B1	136	2020-03-23 17:08:52.144272	2020-03-23 17:08:52.144272
1763	Strenču Novads	D3	136	2020-03-23 17:08:52.146334	2020-03-23 17:08:52.146334
1764	Beverīnas Novads	50	136	2020-03-23 17:08:52.149515	2020-03-23 17:08:52.149515
1765	Smiltenes Novads	D1	136	2020-03-23 17:08:52.151649	2020-03-23 17:08:52.151649
1766	Jaunpiebalgas Novads	72	136	2020-03-23 17:08:52.153982	2020-03-23 17:08:52.153982
1767	Ērgļu Novads	63	136	2020-03-23 17:08:52.155933	2020-03-23 17:08:52.155933
1768	Vecpiebalgas Novads	E3	136	2020-03-23 17:08:52.157536	2020-03-23 17:08:52.157536
1769	Apes Novads	43	136	2020-03-23 17:08:52.159229	2020-03-23 17:08:52.159229
1770	Darnah	70	137	2020-03-23 17:08:52.161	2020-03-23 17:08:52.161
1771	Banghāzī	69	137	2020-03-23 17:08:52.16274	2020-03-23 17:08:52.16274
1772	Al Marj	66	137	2020-03-23 17:08:52.164434	2020-03-23 17:08:52.164434
1773	Al Kufrah	65	137	2020-03-23 17:08:52.166091	2020-03-23 17:08:52.166091
1774	Al Jabal al Akhḑar	63	137	2020-03-23 17:08:52.167535	2020-03-23 17:08:52.167535
1775	Ţarābulus	77	137	2020-03-23 17:08:52.169081	2020-03-23 17:08:52.169081
1776	Surt	76	137	2020-03-23 17:08:52.17092	2020-03-23 17:08:52.17092
1777	Sabhā	75	137	2020-03-23 17:08:52.173366	2020-03-23 17:08:52.173366
1778	Nālūt	74	137	2020-03-23 17:08:52.175149	2020-03-23 17:08:52.175149
1779	Murzuq	73	137	2020-03-23 17:08:52.177004	2020-03-23 17:08:52.177004
1780	Mişrātah	72	137	2020-03-23 17:08:52.178947	2020-03-23 17:08:52.178947
1781	Ghāt	71	137	2020-03-23 17:08:52.180972	2020-03-23 17:08:52.180972
1782	Az Zāwiyah	68	137	2020-03-23 17:08:52.18268	2020-03-23 17:08:52.18268
1783	Ash Shāţiʼ	78	137	2020-03-23 17:08:52.184377	2020-03-23 17:08:52.184377
1784	Al Jufrah	64	137	2020-03-23 17:08:52.186121	2020-03-23 17:08:52.186121
1785	An Nuqāţ al Khams	67	137	2020-03-23 17:08:52.187751	2020-03-23 17:08:52.187751
1786	Sha‘bīyat al Buţnān	79	137	2020-03-23 17:08:52.189317	2020-03-23 17:08:52.189317
1787	Sha‘bīyat al Jabal al Gharbī	80	137	2020-03-23 17:08:52.190894	2020-03-23 17:08:52.190894
1788	Sha‘bīyat al Jafārah	81	137	2020-03-23 17:08:52.192988	2020-03-23 17:08:52.192988
1789	Sha‘bīyat al Marqab	82	137	2020-03-23 17:08:52.19471	2020-03-23 17:08:52.19471
1790	Sha‘bīyat al Wāḩāt	83	137	2020-03-23 17:08:52.196186	2020-03-23 17:08:52.196186
1791	Sha‘bīyat Wādī al Ḩayāt	84	137	2020-03-23 17:08:52.197728	2020-03-23 17:08:52.197728
1792	Rabat-Salé-Zemmour-Zaër	49	138	2020-03-23 17:08:52.199185	2020-03-23 17:08:52.199185
1793	Meknès-Tafilalet	48	138	2020-03-23 17:08:52.200601	2020-03-23 17:08:52.200601
1794	Marrakech-Tensift-Al Haouz	47	138	2020-03-23 17:08:52.201959	2020-03-23 17:08:52.201959
1795	Fès-Boulemane	46	138	2020-03-23 17:08:52.203361	2020-03-23 17:08:52.203361
1796	Grand Casablanca	45	138	2020-03-23 17:08:52.204867	2020-03-23 17:08:52.204867
1797	Chaouia-Ouardigha	50	138	2020-03-23 17:08:52.206257	2020-03-23 17:08:52.206257
1798	Doukkala-Abda	51	138	2020-03-23 17:08:52.207735	2020-03-23 17:08:52.207735
1799	Gharb-Chrarda-Beni Hssen	52	138	2020-03-23 17:08:52.209735	2020-03-23 17:08:52.209735
1800	Guelmim-Es Smara	53	138	2020-03-23 17:08:52.211446	2020-03-23 17:08:52.211446
1801	Oriental	54	138	2020-03-23 17:08:52.21394	2020-03-23 17:08:52.21394
1802	Souss-Massa-Drâa	55	138	2020-03-23 17:08:52.215619	2020-03-23 17:08:52.215619
1803	Tadla-Azilal	56	138	2020-03-23 17:08:52.217222	2020-03-23 17:08:52.217222
1804	Tanger-Tétouan	57	138	2020-03-23 17:08:52.218864	2020-03-23 17:08:52.218864
1805	Taza-Al Hoceima-Taounate	58	138	2020-03-23 17:08:52.220686	2020-03-23 17:08:52.220686
1806	Laâyoune-Boujdour-Sakia El Hamra	59	138	2020-03-23 17:08:52.229698	2020-03-23 17:08:52.229698
1807	Oued ed Dahab-Lagouira	EH	138	2020-03-23 17:08:52.233739	2020-03-23 17:08:52.233739
1808	Raionul Edineţ	73	140	2020-03-23 17:08:52.239459	2020-03-23 17:08:52.239459
1809	Raionul Ungheni	92	140	2020-03-23 17:08:52.242214	2020-03-23 17:08:52.242214
1810	Raionul Teleneşti	91	140	2020-03-23 17:08:52.245471	2020-03-23 17:08:52.245471
1811	Raionul Taraclia	90	140	2020-03-23 17:08:52.248764	2020-03-23 17:08:52.248764
1812	Ştefan-Vodă	88	140	2020-03-23 17:08:52.253149	2020-03-23 17:08:52.253149
1813	Raionul Străşeni	89	140	2020-03-23 17:08:52.256798	2020-03-23 17:08:52.256798
1814	Raionul Soroca	87	140	2020-03-23 17:08:52.260425	2020-03-23 17:08:52.260425
1815	Raionul Rîşcani	84	140	2020-03-23 17:08:52.263204	2020-03-23 17:08:52.263204
1816	Raionul Rezina	83	140	2020-03-23 17:08:52.265159	2020-03-23 17:08:52.265159
1817	Raionul Orhei	82	140	2020-03-23 17:08:52.268677	2020-03-23 17:08:52.268677
1818	Raionul Ocniţa	81	140	2020-03-23 17:08:52.289744	2020-03-23 17:08:52.289744
1819	Raionul Anenii Noi	59	140	2020-03-23 17:08:52.295329	2020-03-23 17:08:52.295329
1820	Raionul Nisporeni	80	140	2020-03-23 17:08:52.300542	2020-03-23 17:08:52.300542
1821	Raionul Leova	79	140	2020-03-23 17:08:52.304673	2020-03-23 17:08:52.304673
1822	Raionul Sîngerei	85	140	2020-03-23 17:08:52.310242	2020-03-23 17:08:52.310242
1823	Raionul Criuleni	69	140	2020-03-23 17:08:52.316999	2020-03-23 17:08:52.316999
1824	Raionul Ialoveni	78	140	2020-03-23 17:08:52.324049	2020-03-23 17:08:52.324049
1825	Chişinău	57	140	2020-03-23 17:08:52.328958	2020-03-23 17:08:52.328958
1826	Căuşeni	67	140	2020-03-23 17:08:52.333296	2020-03-23 17:08:52.333296
1827	Raionul Cantemir	65	140	2020-03-23 17:08:52.336567	2020-03-23 17:08:52.336567
1828	Călăraşi	66	140	2020-03-23 17:08:52.338528	2020-03-23 17:08:52.338528
1829	Raionul Cahul	64	140	2020-03-23 17:08:52.341027	2020-03-23 17:08:52.341027
1830	Raionul Glodeni	76	140	2020-03-23 17:08:52.342971	2020-03-23 17:08:52.342971
1831	Raionul Floreşti	75	140	2020-03-23 17:08:52.344792	2020-03-23 17:08:52.344792
1832	Raionul Făleşti	74	140	2020-03-23 17:08:52.347511	2020-03-23 17:08:52.347511
1833	Dubăsari	72	140	2020-03-23 17:08:52.354768	2020-03-23 17:08:52.354768
1834	Raionul Drochia	71	140	2020-03-23 17:08:52.357815	2020-03-23 17:08:52.357815
1835	Raionul Donduşeni	70	140	2020-03-23 17:08:52.361586	2020-03-23 17:08:52.361586
1836	Raionul Cimişlia	68	140	2020-03-23 17:08:52.365371	2020-03-23 17:08:52.365371
1837	Raionul Briceni	63	140	2020-03-23 17:08:52.36787	2020-03-23 17:08:52.36787
1838	Raionul Basarabeasca	61	140	2020-03-23 17:08:52.369683	2020-03-23 17:08:52.369683
1839	Raionul Hînceşti	77	140	2020-03-23 17:08:52.37269	2020-03-23 17:08:52.37269
1840	Raionul Şoldăneşti	86	140	2020-03-23 17:08:52.375357	2020-03-23 17:08:52.375357
1841	Stînga Nistrului	58	140	2020-03-23 17:08:52.377576	2020-03-23 17:08:52.377576
1842	Găgăuzia	51	140	2020-03-23 17:08:52.38015	2020-03-23 17:08:52.38015
1843	Bender	62	140	2020-03-23 17:08:52.382787	2020-03-23 17:08:52.382787
1844	Bălţi	60	140	2020-03-23 17:08:52.384936	2020-03-23 17:08:52.384936
1845	Opština Rožaje	17	141	2020-03-23 17:08:52.386934	2020-03-23 17:08:52.386934
1846	Opština Žabljak	21	141	2020-03-23 17:08:52.388663	2020-03-23 17:08:52.388663
1847	Opština Ulcinj	20	141	2020-03-23 17:08:52.390557	2020-03-23 17:08:52.390557
1848	Opština Tivat	19	141	2020-03-23 17:08:52.393294	2020-03-23 17:08:52.393294
1849	Opština Podgorica	16	141	2020-03-23 17:08:52.395475	2020-03-23 17:08:52.395475
1850	Opština Šavnik	18	141	2020-03-23 17:08:52.397644	2020-03-23 17:08:52.397644
1851	Opština Plužine	15	141	2020-03-23 17:08:52.399891	2020-03-23 17:08:52.399891
1852	Opština Pljevlja	14	141	2020-03-23 17:08:52.402785	2020-03-23 17:08:52.402785
1853	Opština Plav	13	141	2020-03-23 17:08:52.404816	2020-03-23 17:08:52.404816
1854	Opština Nikšić	12	141	2020-03-23 17:08:52.408195	2020-03-23 17:08:52.408195
1855	Opština Mojkovac	11	141	2020-03-23 17:08:52.410034	2020-03-23 17:08:52.410034
1856	Opština Kotor	10	141	2020-03-23 17:08:52.413791	2020-03-23 17:08:52.413791
1857	Opština Kolašin	09	141	2020-03-23 17:08:52.415951	2020-03-23 17:08:52.415951
1858	Opština Berane	03	141	2020-03-23 17:08:52.418213	2020-03-23 17:08:52.418213
1859	Opština Herceg Novi	08	141	2020-03-23 17:08:52.420089	2020-03-23 17:08:52.420089
1860	Opština Danilovgrad	07	141	2020-03-23 17:08:52.422027	2020-03-23 17:08:52.422027
1861	Opština Cetinje	06	141	2020-03-23 17:08:52.425405	2020-03-23 17:08:52.425405
1862	Opština Budva	05	141	2020-03-23 17:08:52.427207	2020-03-23 17:08:52.427207
1863	Opština Bijelo Polje	04	141	2020-03-23 17:08:52.429899	2020-03-23 17:08:52.429899
1864	Opština Bar	02	141	2020-03-23 17:08:52.433187	2020-03-23 17:08:52.433187
1865	Opština Andrijevica	01	141	2020-03-23 17:08:52.435694	2020-03-23 17:08:52.435694
1866	Diana	7670842	143	2020-03-23 17:08:52.43787	2020-03-23 17:08:52.43787
1867	Sava	7670846	143	2020-03-23 17:08:52.441711	2020-03-23 17:08:52.441711
1868	Sofia	7670847	143	2020-03-23 17:08:52.443673	2020-03-23 17:08:52.443673
1869	Analanjirofo	7670848	143	2020-03-23 17:08:52.445966	2020-03-23 17:08:52.445966
1870	Boeny	7670849	143	2020-03-23 17:08:52.447918	2020-03-23 17:08:52.447918
1871	Betsiboka	7670850	143	2020-03-23 17:08:52.449769	2020-03-23 17:08:52.449769
1872	Alaotra-Mangoro	7670851	143	2020-03-23 17:08:52.45155	2020-03-23 17:08:52.45155
1873	Melaky	7670852	143	2020-03-23 17:08:52.453909	2020-03-23 17:08:52.453909
1874	Bongolava	7670853	143	2020-03-23 17:08:52.455951	2020-03-23 17:08:52.455951
1875	Vakinankaratra	7670854	143	2020-03-23 17:08:52.457596	2020-03-23 17:08:52.457596
1876	Itasy	7670855	143	2020-03-23 17:08:52.459407	2020-03-23 17:08:52.459407
1877	Analamanga	7670856	143	2020-03-23 17:08:52.461226	2020-03-23 17:08:52.461226
1878	East	7670857	143	2020-03-23 17:08:52.463049	2020-03-23 17:08:52.463049
1879	Menabe	7670902	143	2020-03-23 17:08:52.464778	2020-03-23 17:08:52.464778
1880	Amoron'i Mania	7670904	143	2020-03-23 17:08:52.466531	2020-03-23 17:08:52.466531
1881	Upper Matsiatra	7670905	143	2020-03-23 17:08:52.468411	2020-03-23 17:08:52.468411
1882	Vatovavy-Fitovinany	7670906	143	2020-03-23 17:08:52.470116	2020-03-23 17:08:52.470116
1883	Ihorombe	7670907	143	2020-03-23 17:08:52.471886	2020-03-23 17:08:52.471886
1884	South-East	7670908	143	2020-03-23 17:08:52.473907	2020-03-23 17:08:52.473907
1885	Anosy	7670910	143	2020-03-23 17:08:52.475381	2020-03-23 17:08:52.475381
1886	Androy	7670911	143	2020-03-23 17:08:52.476831	2020-03-23 17:08:52.476831
1887	South-West	7670913	143	2020-03-23 17:08:52.478603	2020-03-23 17:08:52.478603
1888	Ailinginae Atoll	007	144	2020-03-23 17:08:52.480383	2020-03-23 17:08:52.480383
1889	Ailinglaplap Atoll	010	144	2020-03-23 17:08:52.482391	2020-03-23 17:08:52.482391
1890	Ailuk Atoll	030	144	2020-03-23 17:08:52.48413	2020-03-23 17:08:52.48413
1891	Arno Atoll	040	144	2020-03-23 17:08:52.485634	2020-03-23 17:08:52.485634
1892	Aur Atoll	050	144	2020-03-23 17:08:52.487243	2020-03-23 17:08:52.487243
1893	Bikar Atoll	060	144	2020-03-23 17:08:52.488945	2020-03-23 17:08:52.488945
1894	Bikini Atoll	070	144	2020-03-23 17:08:52.490942	2020-03-23 17:08:52.490942
1895	Ebon Atoll	080	144	2020-03-23 17:08:52.493013	2020-03-23 17:08:52.493013
1896	Enewetak Atoll	090	144	2020-03-23 17:08:52.494562	2020-03-23 17:08:52.494562
1897	Erikub Atoll	100	144	2020-03-23 17:08:52.496349	2020-03-23 17:08:52.496349
1898	Jaluit Atoll	120	144	2020-03-23 17:08:52.498021	2020-03-23 17:08:52.498021
1899	Kwajalein Atoll	150	144	2020-03-23 17:08:52.499764	2020-03-23 17:08:52.499764
1900	Lae Atoll	160	144	2020-03-23 17:08:52.501448	2020-03-23 17:08:52.501448
1901	Likiep Atoll	180	144	2020-03-23 17:08:52.503136	2020-03-23 17:08:52.503136
1902	Majuro Atoll	190	144	2020-03-23 17:08:52.505108	2020-03-23 17:08:52.505108
1903	Maloelap Atoll	300	144	2020-03-23 17:08:52.506972	2020-03-23 17:08:52.506972
1904	Mili Atoll	320	144	2020-03-23 17:08:52.509222	2020-03-23 17:08:52.509222
1905	Namdrik Atoll	330	144	2020-03-23 17:08:52.511177	2020-03-23 17:08:52.511177
1906	Namu Atoll	340	144	2020-03-23 17:08:52.513537	2020-03-23 17:08:52.513537
1907	Rongelap Atoll	350	144	2020-03-23 17:08:52.515431	2020-03-23 17:08:52.515431
1908	Rongrik Atoll	360	144	2020-03-23 17:08:52.517289	2020-03-23 17:08:52.517289
1909	Taka Atoll	385	144	2020-03-23 17:08:52.519227	2020-03-23 17:08:52.519227
1910	Bokak Atoll	073	144	2020-03-23 17:08:52.520961	2020-03-23 17:08:52.520961
1911	Ujae Atoll	390	144	2020-03-23 17:08:52.522777	2020-03-23 17:08:52.522777
1912	Ujelang	400	144	2020-03-23 17:08:52.524372	2020-03-23 17:08:52.524372
1913	Utrik Atoll	410	144	2020-03-23 17:08:52.525941	2020-03-23 17:08:52.525941
1914	Wotho Atoll	420	144	2020-03-23 17:08:52.527442	2020-03-23 17:08:52.527442
1915	Wotje Atoll	430	144	2020-03-23 17:08:52.529068	2020-03-23 17:08:52.529068
1916	Jabat Island	110	144	2020-03-23 17:08:52.530636	2020-03-23 17:08:52.530636
1917	Jemo Island	130	144	2020-03-23 17:08:52.532429	2020-03-23 17:08:52.532429
1918	Kili Island	140	144	2020-03-23 17:08:52.534243	2020-03-23 17:08:52.534243
1919	Lib Island	170	144	2020-03-23 17:08:52.535664	2020-03-23 17:08:52.535664
1920	Mejit Island	310	144	2020-03-23 17:08:52.537322	2020-03-23 17:08:52.537322
1921	Valandovo	E9	145	2020-03-23 17:08:52.538973	2020-03-23 17:08:52.538973
1922	Kratovo	51	145	2020-03-23 17:08:52.540414	2020-03-23 17:08:52.540414
1923	Pehčevo	78	145	2020-03-23 17:08:52.542107	2020-03-23 17:08:52.542107
1924	Novo Selo	72	145	2020-03-23 17:08:52.543649	2020-03-23 17:08:52.543649
1925	Bosilovo	11	145	2020-03-23 17:08:52.545297	2020-03-23 17:08:52.545297
1926	Vasilevo	A9	145	2020-03-23 17:08:52.546755	2020-03-23 17:08:52.546755
1927	Dojran	E5	145	2020-03-23 17:08:52.548405	2020-03-23 17:08:52.548405
1928	Bogdanci	08	145	2020-03-23 17:08:52.550195	2020-03-23 17:08:52.550195
1929	Konče	47	145	2020-03-23 17:08:52.551919	2020-03-23 17:08:52.551919
1930	Makedonska Kamenica	62	145	2020-03-23 17:08:52.553887	2020-03-23 17:08:52.553887
1931	Zrnovci	C6	145	2020-03-23 17:08:52.555546	2020-03-23 17:08:52.555546
1932	Karbinci	40	145	2020-03-23 17:08:52.557107	2020-03-23 17:08:52.557107
1933	Demir Kapija	25	145	2020-03-23 17:08:52.558589	2020-03-23 17:08:52.558589
1934	Rosoman	87	145	2020-03-23 17:08:52.560122	2020-03-23 17:08:52.560122
1935	Gradsko	35	145	2020-03-23 17:08:52.561782	2020-03-23 17:08:52.561782
1936	Lozovo	60	145	2020-03-23 17:08:52.56342	2020-03-23 17:08:52.56342
1937	Češinovo	19	145	2020-03-23 17:08:52.564853	2020-03-23 17:08:52.564853
1938	Novaci	E1	145	2020-03-23 17:08:52.566505	2020-03-23 17:08:52.566505
1939	Berovo	04	145	2020-03-23 17:08:52.568125	2020-03-23 17:08:52.568125
1940	Bitola	06	145	2020-03-23 17:08:52.569682	2020-03-23 17:08:52.569682
1941	Mogila	D9	145	2020-03-23 17:08:52.571413	2020-03-23 17:08:52.571413
1942	Aračinovo	01	145	2020-03-23 17:08:52.573865	2020-03-23 17:08:52.573865
1943	Bogovinje	C7	145	2020-03-23 17:08:52.575593	2020-03-23 17:08:52.575593
1944	Brvenica	12	145	2020-03-23 17:08:52.577294	2020-03-23 17:08:52.577294
1945	Čair	C8	145	2020-03-23 17:08:52.578983	2020-03-23 17:08:52.578983
1946	Čaška	C9	145	2020-03-23 17:08:52.580649	2020-03-23 17:08:52.580649
1947	Centar	D1	145	2020-03-23 17:08:52.582287	2020-03-23 17:08:52.582287
1948	Centar Župa	18	145	2020-03-23 17:08:52.583988	2020-03-23 17:08:52.583988
1949	Čučer-Sandevo	20	145	2020-03-23 17:08:52.585715	2020-03-23 17:08:52.585715
1950	Debar	D2	145	2020-03-23 17:08:52.58742	2020-03-23 17:08:52.58742
1951	Delčevo	22	145	2020-03-23 17:08:52.588874	2020-03-23 17:08:52.588874
1952	Demir Hisar	D3	145	2020-03-23 17:08:52.590467	2020-03-23 17:08:52.590467
1953	Opstina Gjorce Petrov	29	145	2020-03-23 17:08:52.592622	2020-03-23 17:08:52.592622
1954	Drugovo	30	145	2020-03-23 17:08:52.594281	2020-03-23 17:08:52.594281
1955	Gazi Baba	32	145	2020-03-23 17:08:52.595999	2020-03-23 17:08:52.595999
1956	Gevgelija	33	145	2020-03-23 17:08:52.598096	2020-03-23 17:08:52.598096
1957	Gostivar	D4	145	2020-03-23 17:08:52.599785	2020-03-23 17:08:52.599785
1958	Ilinden	36	145	2020-03-23 17:08:52.602019	2020-03-23 17:08:52.602019
1959	Jegunovce	D5	145	2020-03-23 17:08:52.604978	2020-03-23 17:08:52.604978
1960	Karpoš	41	145	2020-03-23 17:08:52.606966	2020-03-23 17:08:52.606966
1961	Kavadarci	D6	145	2020-03-23 17:08:52.608588	2020-03-23 17:08:52.608588
1962	Kičevo	43	145	2020-03-23 17:08:52.610172	2020-03-23 17:08:52.610172
1963	Kisela Voda	44	145	2020-03-23 17:08:52.611885	2020-03-23 17:08:52.611885
1964	Kočani	46	145	2020-03-23 17:08:52.614089	2020-03-23 17:08:52.614089
1965	Kriva Palanka	52	145	2020-03-23 17:08:52.615991	2020-03-23 17:08:52.615991
1966	Krivogaštani	53	145	2020-03-23 17:08:52.617904	2020-03-23 17:08:52.617904
1967	Kruševo	54	145	2020-03-23 17:08:52.619485	2020-03-23 17:08:52.619485
1968	Kumanovo	D7	145	2020-03-23 17:08:52.620974	2020-03-23 17:08:52.620974
1969	Opstina Lipkovo	59	145	2020-03-23 17:08:52.622752	2020-03-23 17:08:52.622752
1970	Makedonski Brod	D8	145	2020-03-23 17:08:52.624618	2020-03-23 17:08:52.624618
1971	Negotino	69	145	2020-03-23 17:08:52.626429	2020-03-23 17:08:52.626429
1972	Ohrid	E2	145	2020-03-23 17:08:52.628107	2020-03-23 17:08:52.628107
1973	Oslomej	77	145	2020-03-23 17:08:52.629728	2020-03-23 17:08:52.629728
1974	Petrovec	79	145	2020-03-23 17:08:52.631444	2020-03-23 17:08:52.631444
1975	Plasnica	80	145	2020-03-23 17:08:52.633384	2020-03-23 17:08:52.633384
1976	Prilep	E3	145	2020-03-23 17:08:52.635097	2020-03-23 17:08:52.635097
1977	Probištip	83	145	2020-03-23 17:08:52.637067	2020-03-23 17:08:52.637067
1978	Radoviš	84	145	2020-03-23 17:08:52.639024	2020-03-23 17:08:52.639024
1979	Opstina Rankovce	85	145	2020-03-23 17:08:52.640746	2020-03-23 17:08:52.640746
1980	Opština Rostuša	E4	145	2020-03-23 17:08:52.642326	2020-03-23 17:08:52.642326
1981	Saraj	90	145	2020-03-23 17:08:52.643798	2020-03-23 17:08:52.643798
1982	Sopište	92	145	2020-03-23 17:08:52.64565	2020-03-23 17:08:52.64565
1983	Staro Nagoričane	97	145	2020-03-23 17:08:52.647592	2020-03-23 17:08:52.647592
1984	Štip	98	145	2020-03-23 17:08:52.649327	2020-03-23 17:08:52.649327
1985	Struga	E6	145	2020-03-23 17:08:52.651051	2020-03-23 17:08:52.651051
1986	Strumica	E7	145	2020-03-23 17:08:52.653282	2020-03-23 17:08:52.653282
1987	Studeničani	A2	145	2020-03-23 17:08:52.655289	2020-03-23 17:08:52.655289
1988	Šuto Orizari	A3	145	2020-03-23 17:08:52.6574	2020-03-23 17:08:52.6574
1989	Sveti Nikole	A4	145	2020-03-23 17:08:52.659307	2020-03-23 17:08:52.659307
1990	Tearce	A5	145	2020-03-23 17:08:52.661279	2020-03-23 17:08:52.661279
1991	Tetovo	E8	145	2020-03-23 17:08:52.663352	2020-03-23 17:08:52.663352
1992	Veles	F1	145	2020-03-23 17:08:52.665249	2020-03-23 17:08:52.665249
1993	Vevčani	B3	145	2020-03-23 17:08:52.667222	2020-03-23 17:08:52.667222
1994	Vinica	B4	145	2020-03-23 17:08:52.669334	2020-03-23 17:08:52.669334
1995	Vraneštica	B6	145	2020-03-23 17:08:52.671371	2020-03-23 17:08:52.671371
1996	Vrapčište	B7	145	2020-03-23 17:08:52.673269	2020-03-23 17:08:52.673269
1997	Zajas	C1	145	2020-03-23 17:08:52.675036	2020-03-23 17:08:52.675036
1998	Zelenikovo	C2	145	2020-03-23 17:08:52.677003	2020-03-23 17:08:52.677003
1999	Želino	C3	145	2020-03-23 17:08:52.6791	2020-03-23 17:08:52.6791
2000	Opština Aerodrom	F2	145	2020-03-23 17:08:52.680859	2020-03-23 17:08:52.680859
2001	Opština Butel	F3	145	2020-03-23 17:08:52.682849	2020-03-23 17:08:52.682849
2002	Opština Debarca	F4	145	2020-03-23 17:08:52.684619	2020-03-23 17:08:52.684619
2003	Tombouctou	08	146	2020-03-23 17:08:52.686585	2020-03-23 17:08:52.686585
2004	Sikasso	06	146	2020-03-23 17:08:52.688313	2020-03-23 17:08:52.688313
2005	Ségou	05	146	2020-03-23 17:08:52.690127	2020-03-23 17:08:52.690127
2006	Mopti	04	146	2020-03-23 17:08:52.691991	2020-03-23 17:08:52.691991
2007	Koulikoro	07	146	2020-03-23 17:08:52.694298	2020-03-23 17:08:52.694298
2008	Kayes	03	146	2020-03-23 17:08:52.695964	2020-03-23 17:08:52.695964
2009	Gao	09	146	2020-03-23 17:08:52.697798	2020-03-23 17:08:52.697798
2010	Bamako	01	146	2020-03-23 17:08:52.699393	2020-03-23 17:08:52.699393
2011	Kidal	10	146	2020-03-23 17:08:52.70141	2020-03-23 17:08:52.70141
2012	Tanintharyi	12	147	2020-03-23 17:08:52.703467	2020-03-23 17:08:52.703467
2013	Shan	11	147	2020-03-23 17:08:52.705186	2020-03-23 17:08:52.705186
2014	Sagain	10	147	2020-03-23 17:08:52.7069	2020-03-23 17:08:52.7069
2015	Yangon	17	147	2020-03-23 17:08:52.708537	2020-03-23 17:08:52.708537
2016	Rakhine	01	147	2020-03-23 17:08:52.710342	2020-03-23 17:08:52.710342
2017	Bago	16	147	2020-03-23 17:08:52.71222	2020-03-23 17:08:52.71222
2018	Mon	13	147	2020-03-23 17:08:52.714022	2020-03-23 17:08:52.714022
2019	Mandalay	08	147	2020-03-23 17:08:52.715807	2020-03-23 17:08:52.715807
2020	Magway	15	147	2020-03-23 17:08:52.717631	2020-03-23 17:08:52.717631
2021	Kayah	06	147	2020-03-23 17:08:52.719399	2020-03-23 17:08:52.719399
2022	Kayin	05	147	2020-03-23 17:08:52.721077	2020-03-23 17:08:52.721077
2023	Kachin	04	147	2020-03-23 17:08:52.722891	2020-03-23 17:08:52.722891
2024	Ayeyarwady	03	147	2020-03-23 17:08:52.724792	2020-03-23 17:08:52.724792
2025	Chin	02	147	2020-03-23 17:08:52.726971	2020-03-23 17:08:52.726971
2026	Uvs	19	148	2020-03-23 17:08:52.728726	2020-03-23 17:08:52.728726
2027	Hovd	12	148	2020-03-23 17:08:52.730189	2020-03-23 17:08:52.730189
2028	Govĭ-Altay	10	148	2020-03-23 17:08:52.731891	2020-03-23 17:08:52.731891
2029	Dzavhan	09	148	2020-03-23 17:08:52.733907	2020-03-23 17:08:52.733907
2030	Bayan-Ölgiy	03	148	2020-03-23 17:08:52.735504	2020-03-23 17:08:52.735504
2031	Bayanhongor	02	148	2020-03-23 17:08:52.736949	2020-03-23 17:08:52.736949
2032	Ulaanbaatar	20	148	2020-03-23 17:08:52.738642	2020-03-23 17:08:52.738642
2033	Central Aymag	18	148	2020-03-23 17:08:52.74012	2020-03-23 17:08:52.74012
2034	Sühbaatar	17	148	2020-03-23 17:08:52.741651	2020-03-23 17:08:52.741651
2035	Selenge	16	148	2020-03-23 17:08:52.743179	2020-03-23 17:08:52.743179
2036	Övörhangay	15	148	2020-03-23 17:08:52.744935	2020-03-23 17:08:52.744935
2037	South Govĭ	14	148	2020-03-23 17:08:52.746941	2020-03-23 17:08:52.746941
2038	Hövsgöl	13	148	2020-03-23 17:08:52.748427	2020-03-23 17:08:52.748427
2039	Hentiy	11	148	2020-03-23 17:08:52.75031	2020-03-23 17:08:52.75031
2040	Middle Govĭ	08	148	2020-03-23 17:08:52.752252	2020-03-23 17:08:52.752252
2041	East Gobi Aymag	07	148	2020-03-23 17:08:52.754126	2020-03-23 17:08:52.754126
2042	Eastern	06	148	2020-03-23 17:08:52.755667	2020-03-23 17:08:52.755667
2043	Bulgan	21	148	2020-03-23 17:08:52.757245	2020-03-23 17:08:52.757245
2044	Arhangay	01	148	2020-03-23 17:08:52.758892	2020-03-23 17:08:52.758892
2045	Darhan Uul	23	148	2020-03-23 17:08:52.760443	2020-03-23 17:08:52.760443
2046	Govĭ-Sumber	24	148	2020-03-23 17:08:52.762171	2020-03-23 17:08:52.762171
2047	Orhon	25	148	2020-03-23 17:08:52.763708	2020-03-23 17:08:52.763708
2048	Macau	02	149	2020-03-23 17:08:52.765318	2020-03-23 17:08:52.765318
2049	Ilhas	01	149	2020-03-23 17:08:52.766811	2020-03-23 17:08:52.766811
2050	Rota Municipality	100	150	2020-03-23 17:08:52.768375	2020-03-23 17:08:52.768375
2051	Saipan Municipality	110	150	2020-03-23 17:08:52.770421	2020-03-23 17:08:52.770421
2052	Tinian Municipality	120	150	2020-03-23 17:08:52.772699	2020-03-23 17:08:52.772699
2053	Northern Islands Municipality	085	150	2020-03-23 17:08:52.774815	2020-03-23 17:08:52.774815
2054	Martinique	MQ	151	2020-03-23 17:08:52.776561	2020-03-23 17:08:52.776561
2055	Trarza	06	152	2020-03-23 17:08:52.778098	2020-03-23 17:08:52.778098
2056	Tiris Zemmour	11	152	2020-03-23 17:08:52.77995	2020-03-23 17:08:52.77995
2057	Tagant	09	152	2020-03-23 17:08:52.781786	2020-03-23 17:08:52.781786
2058	Nouakchott	NKC	152	2020-03-23 17:08:52.783336	2020-03-23 17:08:52.783336
2059	Inchiri	12	152	2020-03-23 17:08:52.784855	2020-03-23 17:08:52.784855
2060	Wilaya du Hodh el Gharbi	02	152	2020-03-23 17:08:52.786384	2020-03-23 17:08:52.786384
2061	Hodh ech Chargui	01	152	2020-03-23 17:08:52.788456	2020-03-23 17:08:52.788456
2062	Guidimaka	10	152	2020-03-23 17:08:52.790368	2020-03-23 17:08:52.790368
2063	Gorgol	04	152	2020-03-23 17:08:52.794545	2020-03-23 17:08:52.794545
2064	Dakhlet Nouadhibou	08	152	2020-03-23 17:08:52.796406	2020-03-23 17:08:52.796406
2065	Brakna	05	152	2020-03-23 17:08:52.798347	2020-03-23 17:08:52.798347
2066	Assaba	03	152	2020-03-23 17:08:52.800073	2020-03-23 17:08:52.800073
2067	Adrar	07	152	2020-03-23 17:08:52.801651	2020-03-23 17:08:52.801651
2068	Saint Peter	03	153	2020-03-23 17:08:52.803232	2020-03-23 17:08:52.803232
2069	Saint Georges	02	153	2020-03-23 17:08:52.804857	2020-03-23 17:08:52.804857
2070	Saint Anthony	01	153	2020-03-23 17:08:52.806581	2020-03-23 17:08:52.806581
2071	Agalega Islands	21	155	2020-03-23 17:08:52.808095	2020-03-23 17:08:52.808095
2072	Savanne	20	155	2020-03-23 17:08:52.809847	2020-03-23 17:08:52.809847
2073	Rivière du Rempart	19	155	2020-03-23 17:08:52.811829	2020-03-23 17:08:52.811829
2074	Port Louis	18	155	2020-03-23 17:08:52.814011	2020-03-23 17:08:52.814011
2075	Plaines Wilhems	17	155	2020-03-23 17:08:52.815738	2020-03-23 17:08:52.815738
2076	Pamplemousses	16	155	2020-03-23 17:08:52.817341	2020-03-23 17:08:52.817341
2077	Moka	15	155	2020-03-23 17:08:52.819226	2020-03-23 17:08:52.819226
2078	Grand Port	14	155	2020-03-23 17:08:52.821526	2020-03-23 17:08:52.821526
2079	Flacq	13	155	2020-03-23 17:08:52.823463	2020-03-23 17:08:52.823463
2080	Black River	12	155	2020-03-23 17:08:52.825402	2020-03-23 17:08:52.825402
2081	Cargados Carajos	22	155	2020-03-23 17:08:52.827693	2020-03-23 17:08:52.827693
2082	Rodrigues	23	155	2020-03-23 17:08:52.829879	2020-03-23 17:08:52.829879
2083	Vaavu Atholhu	47	156	2020-03-23 17:08:52.831953	2020-03-23 17:08:52.831953
2084	Thaa Atholhu	46	156	2020-03-23 17:08:52.834035	2020-03-23 17:08:52.834035
2085	Shaviyani Atholhu	45	156	2020-03-23 17:08:52.83593	2020-03-23 17:08:52.83593
2086	Seenu	01	156	2020-03-23 17:08:52.837565	2020-03-23 17:08:52.837565
2087	Raa Atholhu	44	156	2020-03-23 17:08:52.839257	2020-03-23 17:08:52.839257
2088	Noonu Atholhu	43	156	2020-03-23 17:08:52.840924	2020-03-23 17:08:52.840924
2089	Gnyaviyani Atoll	42	156	2020-03-23 17:08:52.84326	2020-03-23 17:08:52.84326
2090	Meemu Atholhu	41	156	2020-03-23 17:08:52.845502	2020-03-23 17:08:52.845502
2091	Lhaviyani Atholhu	39	156	2020-03-23 17:08:52.847869	2020-03-23 17:08:52.847869
2092	Laamu	05	156	2020-03-23 17:08:52.850064	2020-03-23 17:08:52.850064
2093	Kaafu Atholhu	38	156	2020-03-23 17:08:52.851977	2020-03-23 17:08:52.851977
2094	Haa Dhaalu Atholhu	37	156	2020-03-23 17:08:52.854123	2020-03-23 17:08:52.854123
2095	Haa Alifu Atholhu	36	156	2020-03-23 17:08:52.856019	2020-03-23 17:08:52.856019
2096	Gaafu Dhaalu Atholhu	35	156	2020-03-23 17:08:52.857669	2020-03-23 17:08:52.857669
2097	Gaafu Alifu Atholhu	34	156	2020-03-23 17:08:52.859405	2020-03-23 17:08:52.859405
2098	Faafu Atholhu	33	156	2020-03-23 17:08:52.861246	2020-03-23 17:08:52.861246
2099	Dhaalu Atholhu	32	156	2020-03-23 17:08:52.862919	2020-03-23 17:08:52.862919
2100	Baa Atholhu	31	156	2020-03-23 17:08:52.864648	2020-03-23 17:08:52.864648
2101	Alifu Atholhu	30	156	2020-03-23 17:08:52.866274	2020-03-23 17:08:52.866274
2102	Maale	40	156	2020-03-23 17:08:52.868102	2020-03-23 17:08:52.868102
2103	Southern Region	S	157	2020-03-23 17:08:52.869666	2020-03-23 17:08:52.869666
2104	Northern Region	N	157	2020-03-23 17:08:52.871131	2020-03-23 17:08:52.871131
2105	Central Region	C	157	2020-03-23 17:08:52.873399	2020-03-23 17:08:52.873399
2106	Yucatán	31	158	2020-03-23 17:08:52.875077	2020-03-23 17:08:52.875077
2107	Veracruz-Llave	30	158	2020-03-23 17:08:52.876859	2020-03-23 17:08:52.876859
2108	Tlaxcala	29	158	2020-03-23 17:08:52.878595	2020-03-23 17:08:52.878595
2109	Tamaulipas	28	158	2020-03-23 17:08:52.880944	2020-03-23 17:08:52.880944
2110	Tabasco	27	158	2020-03-23 17:08:52.882583	2020-03-23 17:08:52.882583
2111	Quintana Roo	23	158	2020-03-23 17:08:52.884456	2020-03-23 17:08:52.884456
2112	Querétaro	22	158	2020-03-23 17:08:52.886144	2020-03-23 17:08:52.886144
2113	Puebla	21	158	2020-03-23 17:08:52.888633	2020-03-23 17:08:52.888633
2114	Oaxaca	20	158	2020-03-23 17:08:52.890708	2020-03-23 17:08:52.890708
2115	Nuevo León	19	158	2020-03-23 17:08:52.892965	2020-03-23 17:08:52.892965
2116	Morelos	17	158	2020-03-23 17:08:52.894902	2020-03-23 17:08:52.894902
2117	México	15	158	2020-03-23 17:08:52.897076	2020-03-23 17:08:52.897076
2118	Hidalgo	13	158	2020-03-23 17:08:52.899127	2020-03-23 17:08:52.899127
2119	Guerrero	12	158	2020-03-23 17:08:52.900883	2020-03-23 17:08:52.900883
2120	The Federal District	09	158	2020-03-23 17:08:52.902749	2020-03-23 17:08:52.902749
2121	Chiapas	05	158	2020-03-23 17:08:52.904763	2020-03-23 17:08:52.904763
2122	Campeche	04	158	2020-03-23 17:08:52.906685	2020-03-23 17:08:52.906685
2123	Zacatecas	32	158	2020-03-23 17:08:52.908506	2020-03-23 17:08:52.908506
2124	Sonora	26	158	2020-03-23 17:08:52.910072	2020-03-23 17:08:52.910072
2125	Sinaloa	25	158	2020-03-23 17:08:52.912026	2020-03-23 17:08:52.912026
2126	San Luis Potosí	24	158	2020-03-23 17:08:52.914087	2020-03-23 17:08:52.914087
2127	Nayarit	18	158	2020-03-23 17:08:52.915662	2020-03-23 17:08:52.915662
2128	Michoacán	16	158	2020-03-23 17:08:52.917423	2020-03-23 17:08:52.917423
2129	Jalisco	14	158	2020-03-23 17:08:52.919138	2020-03-23 17:08:52.919138
2130	Guanajuato	11	158	2020-03-23 17:08:52.920638	2020-03-23 17:08:52.920638
2131	Durango	10	158	2020-03-23 17:08:52.922312	2020-03-23 17:08:52.922312
2132	Colima	08	158	2020-03-23 17:08:52.923801	2020-03-23 17:08:52.923801
2133	Coahuila	07	158	2020-03-23 17:08:52.925535	2020-03-23 17:08:52.925535
2134	Chihuahua	06	158	2020-03-23 17:08:52.927056	2020-03-23 17:08:52.927056
2135	Baja California Sur	03	158	2020-03-23 17:08:52.928575	2020-03-23 17:08:52.928575
2136	Baja California	02	158	2020-03-23 17:08:52.930198	2020-03-23 17:08:52.930198
2137	Aguascalientes	01	158	2020-03-23 17:08:52.931989	2020-03-23 17:08:52.931989
2138	Melaka	04	159	2020-03-23 17:08:52.933939	2020-03-23 17:08:52.933939
2139	Terengganu	13	159	2020-03-23 17:08:52.93582	2020-03-23 17:08:52.93582
2140	Selangor	12	159	2020-03-23 17:08:52.937427	2020-03-23 17:08:52.937427
2141	Sarawak	11	159	2020-03-23 17:08:52.938991	2020-03-23 17:08:52.938991
2142	Sabah	16	159	2020-03-23 17:08:52.940542	2020-03-23 17:08:52.940542
2143	Perlis	08	159	2020-03-23 17:08:52.942206	2020-03-23 17:08:52.942206
2144	Perak	07	159	2020-03-23 17:08:52.943715	2020-03-23 17:08:52.943715
2145	Pahang	06	159	2020-03-23 17:08:52.945441	2020-03-23 17:08:52.945441
2146	Negeri Sembilan	05	159	2020-03-23 17:08:52.947111	2020-03-23 17:08:52.947111
2147	Kelantan	03	159	2020-03-23 17:08:52.948869	2020-03-23 17:08:52.948869
2148	Kuala Lumpur	14	159	2020-03-23 17:08:52.95059	2020-03-23 17:08:52.95059
2149	Pulau Pinang	09	159	2020-03-23 17:08:52.952828	2020-03-23 17:08:52.952828
2150	Kedah	02	159	2020-03-23 17:08:52.954781	2020-03-23 17:08:52.954781
2151	Johor	01	159	2020-03-23 17:08:52.956671	2020-03-23 17:08:52.956671
2152	Labuan	15	159	2020-03-23 17:08:52.958162	2020-03-23 17:08:52.958162
2153	Putrajaya	17	159	2020-03-23 17:08:52.959948	2020-03-23 17:08:52.959948
2154	Zambézia	09	160	2020-03-23 17:08:52.961784	2020-03-23 17:08:52.961784
2155	Tete	08	160	2020-03-23 17:08:52.965027	2020-03-23 17:08:52.965027
2156	Sofala	05	160	2020-03-23 17:08:52.969513	2020-03-23 17:08:52.969513
2157	Niassa	07	160	2020-03-23 17:08:52.975704	2020-03-23 17:08:52.975704
2158	Nampula	06	160	2020-03-23 17:08:52.97901	2020-03-23 17:08:52.97901
2159	Maputo	04	160	2020-03-23 17:08:53.017088	2020-03-23 17:08:53.017088
2160	Manica	10	160	2020-03-23 17:08:53.023071	2020-03-23 17:08:53.023071
2161	Inhambane	03	160	2020-03-23 17:08:53.02564	2020-03-23 17:08:53.02564
2162	Gaza	02	160	2020-03-23 17:08:53.028532	2020-03-23 17:08:53.028532
2163	Cabo Delgado	01	160	2020-03-23 17:08:53.049055	2020-03-23 17:08:53.049055
2164	Maputo City	11	160	2020-03-23 17:08:53.055055	2020-03-23 17:08:53.055055
2165	Caprivi	28	161	2020-03-23 17:08:53.058824	2020-03-23 17:08:53.058824
2166	Khomas	21	161	2020-03-23 17:08:53.060847	2020-03-23 17:08:53.060847
2167	Erongo	29	161	2020-03-23 17:08:53.062847	2020-03-23 17:08:53.062847
2168	Hardap	30	161	2020-03-23 17:08:53.064507	2020-03-23 17:08:53.064507
2169	Karas	31	161	2020-03-23 17:08:53.066216	2020-03-23 17:08:53.066216
2170	Kunene	32	161	2020-03-23 17:08:53.067988	2020-03-23 17:08:53.067988
2171	Ohangwena	33	161	2020-03-23 17:08:53.069849	2020-03-23 17:08:53.069849
2172	Okavango	34	161	2020-03-23 17:08:53.072601	2020-03-23 17:08:53.072601
2173	Omaheke	35	161	2020-03-23 17:08:53.074516	2020-03-23 17:08:53.074516
2174	Omusati	36	161	2020-03-23 17:08:53.076167	2020-03-23 17:08:53.076167
2175	Oshana	37	161	2020-03-23 17:08:53.077816	2020-03-23 17:08:53.077816
2176	Oshikoto	38	161	2020-03-23 17:08:53.079514	2020-03-23 17:08:53.079514
2177	Otjozondjupa	39	161	2020-03-23 17:08:53.081233	2020-03-23 17:08:53.081233
2178	Province Sud	02	162	2020-03-23 17:08:53.082845	2020-03-23 17:08:53.082845
2179	Province Nord	01	162	2020-03-23 17:08:53.084545	2020-03-23 17:08:53.084545
2180	Province des îles Loyauté	03	162	2020-03-23 17:08:53.086243	2020-03-23 17:08:53.086243
2181	Zinder	07	163	2020-03-23 17:08:53.088042	2020-03-23 17:08:53.088042
2182	Tahoua	06	163	2020-03-23 17:08:53.089888	2020-03-23 17:08:53.089888
2183	Maradi	04	163	2020-03-23 17:08:53.091801	2020-03-23 17:08:53.091801
2184	Dosso	03	163	2020-03-23 17:08:53.094082	2020-03-23 17:08:53.094082
2185	Diffa	02	163	2020-03-23 17:08:53.095878	2020-03-23 17:08:53.095878
2186	Agadez	01	163	2020-03-23 17:08:53.097726	2020-03-23 17:08:53.097726
2187	Tillabéri	09	163	2020-03-23 17:08:53.09992	2020-03-23 17:08:53.09992
2188	Niamey	08	163	2020-03-23 17:08:53.101697	2020-03-23 17:08:53.101697
2189	Sokoto	51	165	2020-03-23 17:08:53.103486	2020-03-23 17:08:53.103486
2190	Rivers	50	165	2020-03-23 17:08:53.105387	2020-03-23 17:08:53.105387
2191	Plateau	49	165	2020-03-23 17:08:53.107309	2020-03-23 17:08:53.107309
2192	Oyo	32	165	2020-03-23 17:08:53.10896	2020-03-23 17:08:53.10896
2193	Ondo	48	165	2020-03-23 17:08:53.110656	2020-03-23 17:08:53.110656
2194	Ogun	16	165	2020-03-23 17:08:53.112576	2020-03-23 17:08:53.112576
2195	Niger	31	165	2020-03-23 17:08:53.114626	2020-03-23 17:08:53.114626
2196	Lagos	05	165	2020-03-23 17:08:53.116794	2020-03-23 17:08:53.116794
2197	Kwara	30	165	2020-03-23 17:08:53.118539	2020-03-23 17:08:53.118539
2198	Katsina	24	165	2020-03-23 17:08:53.120205	2020-03-23 17:08:53.120205
2199	Kano	29	165	2020-03-23 17:08:53.122102	2020-03-23 17:08:53.122102
2200	Kaduna	23	165	2020-03-23 17:08:53.124142	2020-03-23 17:08:53.124142
2201	Imo State	28	165	2020-03-23 17:08:53.125972	2020-03-23 17:08:53.125972
2202	Cross River	22	165	2020-03-23 17:08:53.128103	2020-03-23 17:08:53.128103
2203	Borno	27	165	2020-03-23 17:08:53.129675	2020-03-23 17:08:53.129675
2204	Benue State	26	165	2020-03-23 17:08:53.132681	2020-03-23 17:08:53.132681
2205	Bauchi State	46	165	2020-03-23 17:08:53.134634	2020-03-23 17:08:53.134634
2206	Anambra State	25	165	2020-03-23 17:08:53.136298	2020-03-23 17:08:53.136298
2207	Akwa Ibom	21	165	2020-03-23 17:08:53.138287	2020-03-23 17:08:53.138287
2208	Abuja Federal Capital Territory	11	165	2020-03-23 17:08:53.140152	2020-03-23 17:08:53.140152
2209	Abia	45	165	2020-03-23 17:08:53.141896	2020-03-23 17:08:53.141896
2210	Delta State	36	165	2020-03-23 17:08:53.1438	2020-03-23 17:08:53.1438
2211	Adamawa State	35	165	2020-03-23 17:08:53.145559	2020-03-23 17:08:53.145559
2212	Edo	37	165	2020-03-23 17:08:53.147258	2020-03-23 17:08:53.147258
2213	Enugu State	47	165	2020-03-23 17:08:53.149065	2020-03-23 17:08:53.149065
2214	Jigawa State	39	165	2020-03-23 17:08:53.150872	2020-03-23 17:08:53.150872
2215	Bayelsa	52	165	2020-03-23 17:08:53.153308	2020-03-23 17:08:53.153308
2216	Ebonyi	53	165	2020-03-23 17:08:53.154899	2020-03-23 17:08:53.154899
2217	Ekiti	54	165	2020-03-23 17:08:53.156972	2020-03-23 17:08:53.156972
2218	Gombe	55	165	2020-03-23 17:08:53.158818	2020-03-23 17:08:53.158818
2219	Nassarawa	56	165	2020-03-23 17:08:53.160286	2020-03-23 17:08:53.160286
2220	Zamfara	57	165	2020-03-23 17:08:53.161983	2020-03-23 17:08:53.161983
2221	Kebbi	40	165	2020-03-23 17:08:53.163611	2020-03-23 17:08:53.163611
2222	Kogi	41	165	2020-03-23 17:08:53.165441	2020-03-23 17:08:53.165441
2223	Osun	42	165	2020-03-23 17:08:53.167099	2020-03-23 17:08:53.167099
2224	Taraba State	43	165	2020-03-23 17:08:53.168933	2020-03-23 17:08:53.168933
2225	Yobe	44	165	2020-03-23 17:08:53.170407	2020-03-23 17:08:53.170407
2226	Rivas	15	166	2020-03-23 17:08:53.172443	2020-03-23 17:08:53.172443
2227	Río San Juan	14	166	2020-03-23 17:08:53.174306	2020-03-23 17:08:53.174306
2228	Nueva Segovia	13	166	2020-03-23 17:08:53.175761	2020-03-23 17:08:53.175761
2229	Matagalpa	12	166	2020-03-23 17:08:53.177208	2020-03-23 17:08:53.177208
2230	Masaya	11	166	2020-03-23 17:08:53.178757	2020-03-23 17:08:53.178757
2231	Managua	10	166	2020-03-23 17:08:53.180529	2020-03-23 17:08:53.180529
2232	Madriz	09	166	2020-03-23 17:08:53.182341	2020-03-23 17:08:53.182341
2233	León	08	166	2020-03-23 17:08:53.184042	2020-03-23 17:08:53.184042
2234	Jinotega	07	166	2020-03-23 17:08:53.18551	2020-03-23 17:08:53.18551
2235	Granada	06	166	2020-03-23 17:08:53.187173	2020-03-23 17:08:53.187173
2236	Estelí	05	166	2020-03-23 17:08:53.188756	2020-03-23 17:08:53.188756
2237	Chontales	04	166	2020-03-23 17:08:53.190329	2020-03-23 17:08:53.190329
2238	Chinandega	03	166	2020-03-23 17:08:53.192647	2020-03-23 17:08:53.192647
2239	Carazo	02	166	2020-03-23 17:08:53.194826	2020-03-23 17:08:53.194826
2240	Boaco	01	166	2020-03-23 17:08:53.196881	2020-03-23 17:08:53.196881
2241	Atlántico Norte	17	166	2020-03-23 17:08:53.198669	2020-03-23 17:08:53.198669
2242	Atlántico Sur	18	166	2020-03-23 17:08:53.200635	2020-03-23 17:08:53.200635
2243	South Holland	11	167	2020-03-23 17:08:53.202649	2020-03-23 17:08:53.202649
2244	Zeeland	10	167	2020-03-23 17:08:53.204511	2020-03-23 17:08:53.204511
2245	Utrecht	09	167	2020-03-23 17:08:53.206133	2020-03-23 17:08:53.206133
2246	Overijssel	15	167	2020-03-23 17:08:53.207808	2020-03-23 17:08:53.207808
2247	North Holland	07	167	2020-03-23 17:08:53.20939	2020-03-23 17:08:53.20939
2248	North Brabant	06	167	2020-03-23 17:08:53.211282	2020-03-23 17:08:53.211282
2249	Limburg	05	167	2020-03-23 17:08:53.213462	2020-03-23 17:08:53.213462
2250	Groningen	04	167	2020-03-23 17:08:53.215433	2020-03-23 17:08:53.215433
2251	Gelderland	03	167	2020-03-23 17:08:53.216995	2020-03-23 17:08:53.216995
2252	Friesland	02	167	2020-03-23 17:08:53.218769	2020-03-23 17:08:53.218769
2253	Drenthe	01	167	2020-03-23 17:08:53.220694	2020-03-23 17:08:53.220694
2254	Flevoland	16	167	2020-03-23 17:08:53.222265	2020-03-23 17:08:53.222265
2255	Finnmark	05	168	2020-03-23 17:08:53.223718	2020-03-23 17:08:53.223718
2256	Vestfold	20	168	2020-03-23 17:08:53.225198	2020-03-23 17:08:53.225198
2257	Vest-Agder	19	168	2020-03-23 17:08:53.226679	2020-03-23 17:08:53.226679
2258	Troms	18	168	2020-03-23 17:08:53.228169	2020-03-23 17:08:53.228169
2259	Telemark	17	168	2020-03-23 17:08:53.230028	2020-03-23 17:08:53.230028
2260	Sør-Trøndelag	16	168	2020-03-23 17:08:53.232147	2020-03-23 17:08:53.232147
2261	Sogn og Fjordane	15	168	2020-03-23 17:08:53.234311	2020-03-23 17:08:53.234311
2262	Rogaland	14	168	2020-03-23 17:08:53.236011	2020-03-23 17:08:53.236011
2263	Østfold	13	168	2020-03-23 17:08:53.237695	2020-03-23 17:08:53.237695
2264	Oslo	12	168	2020-03-23 17:08:53.239498	2020-03-23 17:08:53.239498
2265	Oppland	11	168	2020-03-23 17:08:53.241159	2020-03-23 17:08:53.241159
2266	Nord-Trøndelag	10	168	2020-03-23 17:08:53.242673	2020-03-23 17:08:53.242673
2267	Nordland	09	168	2020-03-23 17:08:53.244208	2020-03-23 17:08:53.244208
2268	Møre og Romsdal	08	168	2020-03-23 17:08:53.245862	2020-03-23 17:08:53.245862
2269	Hordaland	07	168	2020-03-23 17:08:53.247474	2020-03-23 17:08:53.247474
2270	Hedmark	06	168	2020-03-23 17:08:53.249029	2020-03-23 17:08:53.249029
2271	Buskerud	04	168	2020-03-23 17:08:53.250574	2020-03-23 17:08:53.250574
2272	Aust-Agder	02	168	2020-03-23 17:08:53.252384	2020-03-23 17:08:53.252384
2273	Akershus	01	168	2020-03-23 17:08:53.25409	2020-03-23 17:08:53.25409
2274	Far Western Region	FR	169	2020-03-23 17:08:53.255719	2020-03-23 17:08:53.255719
2275	Mid Western Region	MR	169	2020-03-23 17:08:53.257361	2020-03-23 17:08:53.257361
2276	Central Region	CR	169	2020-03-23 17:08:53.258761	2020-03-23 17:08:53.258761
2277	Eastern Region	ER	169	2020-03-23 17:08:53.260198	2020-03-23 17:08:53.260198
2278	Western Region	WR	169	2020-03-23 17:08:53.261671	2020-03-23 17:08:53.261671
2279	Yaren	14	170	2020-03-23 17:08:53.263414	2020-03-23 17:08:53.263414
2280	Uaboe	13	170	2020-03-23 17:08:53.265054	2020-03-23 17:08:53.265054
2281	Nibok	12	170	2020-03-23 17:08:53.266763	2020-03-23 17:08:53.266763
2282	Meneng	11	170	2020-03-23 17:08:53.268397	2020-03-23 17:08:53.268397
2283	Ijuw	10	170	2020-03-23 17:08:53.269837	2020-03-23 17:08:53.269837
2284	Ewa	09	170	2020-03-23 17:08:53.271433	2020-03-23 17:08:53.271433
2285	Denigomodu	08	170	2020-03-23 17:08:53.273545	2020-03-23 17:08:53.273545
2286	Buada	07	170	2020-03-23 17:08:53.275119	2020-03-23 17:08:53.275119
2287	Boe	06	170	2020-03-23 17:08:53.276734	2020-03-23 17:08:53.276734
2288	Baiti	05	170	2020-03-23 17:08:53.278452	2020-03-23 17:08:53.278452
2289	Anibare	04	170	2020-03-23 17:08:53.280151	2020-03-23 17:08:53.280151
2290	Anetan	03	170	2020-03-23 17:08:53.281942	2020-03-23 17:08:53.281942
2291	Anabar	02	170	2020-03-23 17:08:53.285906	2020-03-23 17:08:53.285906
2292	Aiwo	01	170	2020-03-23 17:08:53.2881	2020-03-23 17:08:53.2881
2293	Wellington	G2	172	2020-03-23 17:08:53.290487	2020-03-23 17:08:53.290487
2294	Manawatu-Wanganui	F3	172	2020-03-23 17:08:53.29333	2020-03-23 17:08:53.29333
2295	Waikato	G1	172	2020-03-23 17:08:53.295749	2020-03-23 17:08:53.295749
2296	Tasman	TAS	172	2020-03-23 17:08:53.297972	2020-03-23 17:08:53.297972
2297	Taranaki	F9	172	2020-03-23 17:08:53.30029	2020-03-23 17:08:53.30029
2298	Southland	F8	172	2020-03-23 17:08:53.30231	2020-03-23 17:08:53.30231
2299	Bay of Plenty	E8	172	2020-03-23 17:08:53.304047	2020-03-23 17:08:53.304047
2300	Northland	F6	172	2020-03-23 17:08:53.305615	2020-03-23 17:08:53.305615
2301	Marlborough	F4	172	2020-03-23 17:08:53.307391	2020-03-23 17:08:53.307391
2302	Hawke's Bay	F2	172	2020-03-23 17:08:53.309066	2020-03-23 17:08:53.309066
2303	Gisborne	F1	172	2020-03-23 17:08:53.311126	2020-03-23 17:08:53.311126
2304	Canterbury	E9	172	2020-03-23 17:08:53.313583	2020-03-23 17:08:53.313583
2305	Auckland	E7	172	2020-03-23 17:08:53.315585	2020-03-23 17:08:53.315585
2306	Chatham Islands	10	172	2020-03-23 17:08:53.317433	2020-03-23 17:08:53.317433
2307	Nelson	F5	172	2020-03-23 17:08:53.319215	2020-03-23 17:08:53.319215
2308	Otago	F7	172	2020-03-23 17:08:53.32086	2020-03-23 17:08:53.32086
2309	West Coast	G3	172	2020-03-23 17:08:53.322426	2020-03-23 17:08:53.322426
2310	Ad Dākhilīyah	01	173	2020-03-23 17:08:53.324123	2020-03-23 17:08:53.324123
2311	Al Bāţinah	02	173	2020-03-23 17:08:53.325607	2020-03-23 17:08:53.325607
2312	Al Wusţá	03	173	2020-03-23 17:08:53.327126	2020-03-23 17:08:53.327126
2313	Ash Sharqīyah	04	173	2020-03-23 17:08:53.328858	2020-03-23 17:08:53.328858
2314	Az̧ Z̧āhirah	09	173	2020-03-23 17:08:53.330539	2020-03-23 17:08:53.330539
2315	Masqaţ	06	173	2020-03-23 17:08:53.332384	2020-03-23 17:08:53.332384
2316	Muḩāfaz̧at Musandam	07	173	2020-03-23 17:08:53.334367	2020-03-23 17:08:53.334367
2317	Z̧ufār	08	173	2020-03-23 17:08:53.336118	2020-03-23 17:08:53.336118
2318	Muḩāfaz̧at al Buraymī	10	173	2020-03-23 17:08:53.337771	2020-03-23 17:08:53.337771
2319	Veraguas	10	174	2020-03-23 17:08:53.339535	2020-03-23 17:08:53.339535
2320	Kuna Yala	09	174	2020-03-23 17:08:53.341357	2020-03-23 17:08:53.341357
2321	Panamá	08	174	2020-03-23 17:08:53.343136	2020-03-23 17:08:53.343136
2322	Los Santos	07	174	2020-03-23 17:08:53.34487	2020-03-23 17:08:53.34487
2323	Herrera	06	174	2020-03-23 17:08:53.34645	2020-03-23 17:08:53.34645
2324	Darién	05	174	2020-03-23 17:08:53.348054	2020-03-23 17:08:53.348054
2325	Colón	04	174	2020-03-23 17:08:53.350105	2020-03-23 17:08:53.350105
2326	Coclé	03	174	2020-03-23 17:08:53.352017	2020-03-23 17:08:53.352017
2327	Chiriquí	02	174	2020-03-23 17:08:53.354118	2020-03-23 17:08:53.354118
2328	Bocas del Toro	01	174	2020-03-23 17:08:53.355684	2020-03-23 17:08:53.355684
2329	Emberá	11	174	2020-03-23 17:08:53.357195	2020-03-23 17:08:53.357195
2330	Ngöbe-Buglé	12	174	2020-03-23 17:08:53.358694	2020-03-23 17:08:53.358694
2331	Ucayali	25	175	2020-03-23 17:08:53.360271	2020-03-23 17:08:53.360271
2332	Tumbes	24	175	2020-03-23 17:08:53.361851	2020-03-23 17:08:53.361851
2333	San Martín	22	175	2020-03-23 17:08:53.363599	2020-03-23 17:08:53.363599
2334	Piura	20	175	2020-03-23 17:08:53.365099	2020-03-23 17:08:53.365099
2335	Loreto	16	175	2020-03-23 17:08:53.366759	2020-03-23 17:08:53.366759
2336	Lambayeque	14	175	2020-03-23 17:08:53.368407	2020-03-23 17:08:53.368407
2337	La Libertad	13	175	2020-03-23 17:08:53.369911	2020-03-23 17:08:53.369911
2338	Huanuco	10	175	2020-03-23 17:08:53.371524	2020-03-23 17:08:53.371524
2339	Cajamarca	06	175	2020-03-23 17:08:53.373931	2020-03-23 17:08:53.373931
2340	Ancash	02	175	2020-03-23 17:08:53.37549	2020-03-23 17:08:53.37549
2341	Amazonas	01	175	2020-03-23 17:08:53.376953	2020-03-23 17:08:53.376953
2342	Tacna	23	175	2020-03-23 17:08:53.378453	2020-03-23 17:08:53.378453
2343	Puno	21	175	2020-03-23 17:08:53.380138	2020-03-23 17:08:53.380138
2344	Pasco	19	175	2020-03-23 17:08:53.382227	2020-03-23 17:08:53.382227
2345	Moquegua	18	175	2020-03-23 17:08:53.384186	2020-03-23 17:08:53.384186
2346	Madre de Dios	17	175	2020-03-23 17:08:53.386386	2020-03-23 17:08:53.386386
2347	Provincia de Lima	LMA	175	2020-03-23 17:08:53.38818	2020-03-23 17:08:53.38818
2348	Lima	15	175	2020-03-23 17:08:53.389673	2020-03-23 17:08:53.389673
2349	Junín	12	175	2020-03-23 17:08:53.391477	2020-03-23 17:08:53.391477
2350	Ica	11	175	2020-03-23 17:08:53.393708	2020-03-23 17:08:53.393708
2351	Huancavelica	09	175	2020-03-23 17:08:53.395396	2020-03-23 17:08:53.395396
2352	Cusco	08	175	2020-03-23 17:08:53.39718	2020-03-23 17:08:53.39718
2353	Callao	07	175	2020-03-23 17:08:53.399245	2020-03-23 17:08:53.399245
2354	Ayacucho	05	175	2020-03-23 17:08:53.401158	2020-03-23 17:08:53.401158
2355	Arequipa	04	175	2020-03-23 17:08:53.403199	2020-03-23 17:08:53.403199
2356	Apurímac	03	175	2020-03-23 17:08:53.404981	2020-03-23 17:08:53.404981
2357	Îles Marquises	04	176	2020-03-23 17:08:53.406812	2020-03-23 17:08:53.406812
2358	Îles Tuamotu-Gambier	03	176	2020-03-23 17:08:53.408561	2020-03-23 17:08:53.408561
2359	Îles Sous-le-Vent	02	176	2020-03-23 17:08:53.410468	2020-03-23 17:08:53.410468
2360	Îles du Vent	01	176	2020-03-23 17:08:53.412871	2020-03-23 17:08:53.412871
2361	Îles Australes	05	176	2020-03-23 17:08:53.414837	2020-03-23 17:08:53.414837
2362	West New Britain	17	177	2020-03-23 17:08:53.417093	2020-03-23 17:08:53.417093
2363	Western Province	06	177	2020-03-23 17:08:53.419073	2020-03-23 17:08:53.419073
2364	Western Highlands	16	177	2020-03-23 17:08:53.420939	2020-03-23 17:08:53.420939
2365	Southern Highlands	05	177	2020-03-23 17:08:53.422821	2020-03-23 17:08:53.422821
2366	Sandaun	18	177	2020-03-23 17:08:53.424342	2020-03-23 17:08:53.424342
2367	Bougainville	07	177	2020-03-23 17:08:53.425897	2020-03-23 17:08:53.425897
2368	Northern Province	04	177	2020-03-23 17:08:53.427589	2020-03-23 17:08:53.427589
2369	New Ireland	15	177	2020-03-23 17:08:53.429265	2020-03-23 17:08:53.429265
2370	National Capital District	20	177	2020-03-23 17:08:53.430772	2020-03-23 17:08:53.430772
2371	Morobe	14	177	2020-03-23 17:08:53.432802	2020-03-23 17:08:53.432802
2372	Manus	13	177	2020-03-23 17:08:53.434497	2020-03-23 17:08:53.434497
2373	Madang	12	177	2020-03-23 17:08:53.436169	2020-03-23 17:08:53.436169
2374	Gulf	02	177	2020-03-23 17:08:53.437795	2020-03-23 17:08:53.437795
2375	Enga	19	177	2020-03-23 17:08:53.439699	2020-03-23 17:08:53.439699
2376	East Sepik	11	177	2020-03-23 17:08:53.441551	2020-03-23 17:08:53.441551
2377	East New Britain	10	177	2020-03-23 17:08:53.443115	2020-03-23 17:08:53.443115
2378	Eastern Highlands	09	177	2020-03-23 17:08:53.444747	2020-03-23 17:08:53.444747
2379	Chimbu	08	177	2020-03-23 17:08:53.446242	2020-03-23 17:08:53.446242
2380	Milne Bay	03	177	2020-03-23 17:08:53.447946	2020-03-23 17:08:53.447946
2381	Central Province	01	177	2020-03-23 17:08:53.449775	2020-03-23 17:08:53.449775
2382	Autonomous Region in Muslim Mindanao	14	178	2020-03-23 17:08:53.452689	2020-03-23 17:08:53.452689
2383	Northern Mindanao	10	178	2020-03-23 17:08:53.455001	2020-03-23 17:08:53.455001
2384	Mimaropa	41	178	2020-03-23 17:08:53.456744	2020-03-23 17:08:53.456744
2385	Cagayan Valley	02	178	2020-03-23 17:08:53.45872	2020-03-23 17:08:53.45872
2386	Soccsksargen	12	178	2020-03-23 17:08:53.460604	2020-03-23 17:08:53.460604
2387	Caraga	13	178	2020-03-23 17:08:53.462488	2020-03-23 17:08:53.462488
2388	Cordillera Administrative Region	15	178	2020-03-23 17:08:53.464347	2020-03-23 17:08:53.464347
2389	Ilocos	01	178	2020-03-23 17:08:53.46623	2020-03-23 17:08:53.46623
2390	Calabarzon	40	178	2020-03-23 17:08:53.468212	2020-03-23 17:08:53.468212
2391	Western Visayas	06	178	2020-03-23 17:08:53.470057	2020-03-23 17:08:53.470057
2392	Central Luzon	03	178	2020-03-23 17:08:53.472178	2020-03-23 17:08:53.472178
2393	Central Visayas	07	178	2020-03-23 17:08:53.474168	2020-03-23 17:08:53.474168
2394	Eastern Visayas	08	178	2020-03-23 17:08:53.476055	2020-03-23 17:08:53.476055
2395	Zamboanga Peninsula	09	178	2020-03-23 17:08:53.478118	2020-03-23 17:08:53.478118
2396	Davao	11	178	2020-03-23 17:08:53.480478	2020-03-23 17:08:53.480478
2397	Bicol	05	178	2020-03-23 17:08:53.482402	2020-03-23 17:08:53.482402
2398	National Capital Region	NCR	178	2020-03-23 17:08:53.484147	2020-03-23 17:08:53.484147
2399	Islāmābād	08	179	2020-03-23 17:08:53.485915	2020-03-23 17:08:53.485915
2400	Sindh	05	179	2020-03-23 17:08:53.487728	2020-03-23 17:08:53.487728
2401	Punjab	04	179	2020-03-23 17:08:53.48959	2020-03-23 17:08:53.48959
2402	North West Frontier Province	03	179	2020-03-23 17:08:53.491494	2020-03-23 17:08:53.491494
2403	Gilgit-Baltistan	07	179	2020-03-23 17:08:53.493624	2020-03-23 17:08:53.493624
2404	Federally Administered Tribal Areas	01	179	2020-03-23 17:08:53.495534	2020-03-23 17:08:53.495534
2405	Balochistān	02	179	2020-03-23 17:08:53.497495	2020-03-23 17:08:53.497495
2406	Azad Kashmir	06	179	2020-03-23 17:08:53.499394	2020-03-23 17:08:53.499394
2407	Lublin Voivodeship	75	180	2020-03-23 17:08:53.501233	2020-03-23 17:08:53.501233
2408	Lesser Poland Voivodeship	77	180	2020-03-23 17:08:53.503139	2020-03-23 17:08:53.503139
2409	Masovian Voivodeship	78	180	2020-03-23 17:08:53.50482	2020-03-23 17:08:53.50482
2410	Subcarpathian Voivodeship	80	180	2020-03-23 17:08:53.506418	2020-03-23 17:08:53.506418
2411	Podlasie	81	180	2020-03-23 17:08:53.508048	2020-03-23 17:08:53.508048
2412	Świętokrzyskie	84	180	2020-03-23 17:08:53.509682	2020-03-23 17:08:53.509682
2529	Aimeliik	01	186	2020-03-23 17:08:53.742959	2020-03-23 17:08:53.742959
2413	Warmian-Masurian Voivodeship	85	180	2020-03-23 17:08:53.511233	2020-03-23 17:08:53.511233
2414	Lower Silesian Voivodeship	72	180	2020-03-23 17:08:53.513548	2020-03-23 17:08:53.513548
2415	Łódź Voivodeship	74	180	2020-03-23 17:08:53.515703	2020-03-23 17:08:53.515703
2416	Lubusz	76	180	2020-03-23 17:08:53.517677	2020-03-23 17:08:53.517677
2417	Opole Voivodeship	79	180	2020-03-23 17:08:53.519402	2020-03-23 17:08:53.519402
2418	Pomeranian Voivodeship	82	180	2020-03-23 17:08:53.521075	2020-03-23 17:08:53.521075
2419	Silesian Voivodeship	83	180	2020-03-23 17:08:53.522681	2020-03-23 17:08:53.522681
2420	Greater Poland Voivodeship	86	180	2020-03-23 17:08:53.52449	2020-03-23 17:08:53.52449
2421	West Pomeranian Voivodeship	87	180	2020-03-23 17:08:53.526246	2020-03-23 17:08:53.526246
2422	Kujawsko-Pomorskie	73	180	2020-03-23 17:08:53.527795	2020-03-23 17:08:53.527795
2423	Saint-Pierre	97502	181	2020-03-23 17:08:53.529412	2020-03-23 17:08:53.529412
2424	Miquelon-Langlade	97501	181	2020-03-23 17:08:53.531245	2020-03-23 17:08:53.531245
2425	Adjuntas	001	183	2020-03-23 17:08:53.533697	2020-03-23 17:08:53.533697
2426	Aguada	003	183	2020-03-23 17:08:53.5355	2020-03-23 17:08:53.5355
2427	Aguadilla	005	183	2020-03-23 17:08:53.537079	2020-03-23 17:08:53.537079
2428	Aguas Buenas	007	183	2020-03-23 17:08:53.538795	2020-03-23 17:08:53.538795
2429	Aibonito	009	183	2020-03-23 17:08:53.540371	2020-03-23 17:08:53.540371
2430	Añasco	011	183	2020-03-23 17:08:53.542231	2020-03-23 17:08:53.542231
2431	Arecibo	013	183	2020-03-23 17:08:53.543673	2020-03-23 17:08:53.543673
2432	Arroyo	015	183	2020-03-23 17:08:53.545141	2020-03-23 17:08:53.545141
2433	Barceloneta	017	183	2020-03-23 17:08:53.546827	2020-03-23 17:08:53.546827
2434	Barranquitas	019	183	2020-03-23 17:08:53.548354	2020-03-23 17:08:53.548354
2435	Bayamón	021	183	2020-03-23 17:08:53.549892	2020-03-23 17:08:53.549892
2436	Cabo Rojo	023	183	2020-03-23 17:08:53.551628	2020-03-23 17:08:53.551628
2437	Caguas	025	183	2020-03-23 17:08:53.553906	2020-03-23 17:08:53.553906
2438	Camuy	027	183	2020-03-23 17:08:53.555777	2020-03-23 17:08:53.555777
2439	Canovanas	029	183	2020-03-23 17:08:53.557776	2020-03-23 17:08:53.557776
2440	Carolina	031	183	2020-03-23 17:08:53.55985	2020-03-23 17:08:53.55985
2441	Catano	033	183	2020-03-23 17:08:53.561572	2020-03-23 17:08:53.561572
2442	Cayey	035	183	2020-03-23 17:08:53.563369	2020-03-23 17:08:53.563369
2443	Ceiba	037	183	2020-03-23 17:08:53.565414	2020-03-23 17:08:53.565414
2444	Ciales	039	183	2020-03-23 17:08:53.567551	2020-03-23 17:08:53.567551
2445	Cidra	041	183	2020-03-23 17:08:53.569442	2020-03-23 17:08:53.569442
2446	Coamo	043	183	2020-03-23 17:08:53.571649	2020-03-23 17:08:53.571649
2447	Comerio	045	183	2020-03-23 17:08:53.573832	2020-03-23 17:08:53.573832
2448	Corozal	047	183	2020-03-23 17:08:53.575679	2020-03-23 17:08:53.575679
2449	Culebra	049	183	2020-03-23 17:08:53.577481	2020-03-23 17:08:53.577481
2450	Dorado	051	183	2020-03-23 17:08:53.579458	2020-03-23 17:08:53.579458
2451	Fajardo	053	183	2020-03-23 17:08:53.581504	2020-03-23 17:08:53.581504
2452	Florida	054	183	2020-03-23 17:08:53.583381	2020-03-23 17:08:53.583381
2453	Guanica	055	183	2020-03-23 17:08:53.585531	2020-03-23 17:08:53.585531
2454	Guayama	057	183	2020-03-23 17:08:53.587316	2020-03-23 17:08:53.587316
2455	Guayanilla	059	183	2020-03-23 17:08:53.589111	2020-03-23 17:08:53.589111
2456	Guaynabo	061	183	2020-03-23 17:08:53.591083	2020-03-23 17:08:53.591083
2457	Gurabo	063	183	2020-03-23 17:08:53.593515	2020-03-23 17:08:53.593515
2458	Hatillo	065	183	2020-03-23 17:08:53.595078	2020-03-23 17:08:53.595078
2459	Hormigueros	067	183	2020-03-23 17:08:53.596968	2020-03-23 17:08:53.596968
2460	Humacao	069	183	2020-03-23 17:08:53.598988	2020-03-23 17:08:53.598988
2461	Isabela	071	183	2020-03-23 17:08:53.600932	2020-03-23 17:08:53.600932
2462	Municipio de Jayuya	073	183	2020-03-23 17:08:53.604893	2020-03-23 17:08:53.604893
2463	Juana Diaz	075	183	2020-03-23 17:08:53.606861	2020-03-23 17:08:53.606861
2464	Municipio de Juncos	077	183	2020-03-23 17:08:53.60857	2020-03-23 17:08:53.60857
2465	Lajas	079	183	2020-03-23 17:08:53.610474	2020-03-23 17:08:53.610474
2466	Lares	081	183	2020-03-23 17:08:53.612599	2020-03-23 17:08:53.612599
2467	Las Marias	083	183	2020-03-23 17:08:53.614559	2020-03-23 17:08:53.614559
2468	Las Piedras	085	183	2020-03-23 17:08:53.616402	2020-03-23 17:08:53.616402
2469	Loiza	087	183	2020-03-23 17:08:53.618656	2020-03-23 17:08:53.618656
2470	Luquillo	089	183	2020-03-23 17:08:53.620848	2020-03-23 17:08:53.620848
2471	Manati	091	183	2020-03-23 17:08:53.623014	2020-03-23 17:08:53.623014
2472	Maricao	093	183	2020-03-23 17:08:53.624829	2020-03-23 17:08:53.624829
2473	Maunabo	095	183	2020-03-23 17:08:53.626501	2020-03-23 17:08:53.626501
2474	Mayaguez	097	183	2020-03-23 17:08:53.628286	2020-03-23 17:08:53.628286
2475	Moca	099	183	2020-03-23 17:08:53.630238	2020-03-23 17:08:53.630238
2476	Morovis	101	183	2020-03-23 17:08:53.632393	2020-03-23 17:08:53.632393
2477	Naguabo	103	183	2020-03-23 17:08:53.634654	2020-03-23 17:08:53.634654
2478	Naranjito	105	183	2020-03-23 17:08:53.636586	2020-03-23 17:08:53.636586
2479	Orocovis	107	183	2020-03-23 17:08:53.638573	2020-03-23 17:08:53.638573
2480	Patillas	109	183	2020-03-23 17:08:53.640574	2020-03-23 17:08:53.640574
2481	Penuelas	111	183	2020-03-23 17:08:53.6425	2020-03-23 17:08:53.6425
2482	Ponce	113	183	2020-03-23 17:08:53.64432	2020-03-23 17:08:53.64432
2483	Rincon	117	183	2020-03-23 17:08:53.646167	2020-03-23 17:08:53.646167
2484	Quebradillas	115	183	2020-03-23 17:08:53.647995	2020-03-23 17:08:53.647995
2485	Rio Grande	119	183	2020-03-23 17:08:53.649624	2020-03-23 17:08:53.649624
2486	Sabana Grande	121	183	2020-03-23 17:08:53.651361	2020-03-23 17:08:53.651361
2487	Salinas	123	183	2020-03-23 17:08:53.653706	2020-03-23 17:08:53.653706
2488	San German	125	183	2020-03-23 17:08:53.655575	2020-03-23 17:08:53.655575
2489	San Juan	127	183	2020-03-23 17:08:53.657344	2020-03-23 17:08:53.657344
2490	San Lorenzo	129	183	2020-03-23 17:08:53.659094	2020-03-23 17:08:53.659094
2491	San Sebastian	131	183	2020-03-23 17:08:53.660893	2020-03-23 17:08:53.660893
2492	Santa Isabel Municipio	133	183	2020-03-23 17:08:53.662825	2020-03-23 17:08:53.662825
2493	Toa Alta	135	183	2020-03-23 17:08:53.664628	2020-03-23 17:08:53.664628
2494	Toa Baja	137	183	2020-03-23 17:08:53.666406	2020-03-23 17:08:53.666406
2495	Trujillo Alto	139	183	2020-03-23 17:08:53.667941	2020-03-23 17:08:53.667941
2496	Utuado	141	183	2020-03-23 17:08:53.669575	2020-03-23 17:08:53.669575
2497	Vega Alta	143	183	2020-03-23 17:08:53.671313	2020-03-23 17:08:53.671313
2498	Vega Baja	145	183	2020-03-23 17:08:53.673507	2020-03-23 17:08:53.673507
2499	Villalba	149	183	2020-03-23 17:08:53.675172	2020-03-23 17:08:53.675172
2500	Yabucoa	151	183	2020-03-23 17:08:53.676755	2020-03-23 17:08:53.676755
2501	Yauco	153	183	2020-03-23 17:08:53.678415	2020-03-23 17:08:53.678415
2502	Vieques	147	183	2020-03-23 17:08:53.680159	2020-03-23 17:08:53.680159
2503	Gaza Strip	GZ	184	2020-03-23 17:08:53.681633	2020-03-23 17:08:53.681633
2504	West Bank	WE	184	2020-03-23 17:08:53.683303	2020-03-23 17:08:53.683303
2505	Setúbal	19	185	2020-03-23 17:08:53.685105	2020-03-23 17:08:53.685105
2506	Santarém	18	185	2020-03-23 17:08:53.687182	2020-03-23 17:08:53.687182
2507	Portalegre	16	185	2020-03-23 17:08:53.689477	2020-03-23 17:08:53.689477
2508	Lisbon	14	185	2020-03-23 17:08:53.691484	2020-03-23 17:08:53.691484
2509	Leiria	13	185	2020-03-23 17:08:53.693615	2020-03-23 17:08:53.693615
2510	Faro	09	185	2020-03-23 17:08:53.69559	2020-03-23 17:08:53.69559
2511	Évora	08	185	2020-03-23 17:08:53.697435	2020-03-23 17:08:53.697435
2512	Castelo Branco	06	185	2020-03-23 17:08:53.699464	2020-03-23 17:08:53.699464
2513	Beja	03	185	2020-03-23 17:08:53.701153	2020-03-23 17:08:53.701153
2514	Madeira	10	185	2020-03-23 17:08:53.703478	2020-03-23 17:08:53.703478
2515	Viseu	22	185	2020-03-23 17:08:53.705675	2020-03-23 17:08:53.705675
2516	Vila Real	21	185	2020-03-23 17:08:53.709272	2020-03-23 17:08:53.709272
2517	Viana do Castelo	20	185	2020-03-23 17:08:53.71309	2020-03-23 17:08:53.71309
2518	Porto	17	185	2020-03-23 17:08:53.716991	2020-03-23 17:08:53.716991
2519	Guarda	11	185	2020-03-23 17:08:53.720757	2020-03-23 17:08:53.720757
2520	Coimbra	07	185	2020-03-23 17:08:53.722505	2020-03-23 17:08:53.722505
2521	Bragança	05	185	2020-03-23 17:08:53.724191	2020-03-23 17:08:53.724191
2522	Braga	04	185	2020-03-23 17:08:53.72627	2020-03-23 17:08:53.72627
2523	Aveiro	02	185	2020-03-23 17:08:53.729722	2020-03-23 17:08:53.729722
2524	Azores	23	185	2020-03-23 17:08:53.733089	2020-03-23 17:08:53.733089
2525	Ngatpang	11	186	2020-03-23 17:08:53.735278	2020-03-23 17:08:53.735278
2526	Sonsorol	16	186	2020-03-23 17:08:53.737103	2020-03-23 17:08:53.737103
2527	Kayangel	05	186	2020-03-23 17:08:53.739037	2020-03-23 17:08:53.739037
2528	State of Hatohobei	04	186	2020-03-23 17:08:53.741061	2020-03-23 17:08:53.741061
2530	Airai	02	186	2020-03-23 17:08:53.744754	2020-03-23 17:08:53.744754
2531	Angaur	03	186	2020-03-23 17:08:53.746745	2020-03-23 17:08:53.746745
2532	Koror	06	186	2020-03-23 17:08:53.748497	2020-03-23 17:08:53.748497
2533	Melekeok	07	186	2020-03-23 17:08:53.750909	2020-03-23 17:08:53.750909
2534	Ngaraard	08	186	2020-03-23 17:08:53.753669	2020-03-23 17:08:53.753669
2535	Ngchesar	12	186	2020-03-23 17:08:53.756244	2020-03-23 17:08:53.756244
2536	Ngarchelong	09	186	2020-03-23 17:08:53.758911	2020-03-23 17:08:53.758911
2537	Ngardmau	10	186	2020-03-23 17:08:53.76086	2020-03-23 17:08:53.76086
2538	State of Ngeremlengui	13	186	2020-03-23 17:08:53.763055	2020-03-23 17:08:53.763055
2539	Ngiwal	14	186	2020-03-23 17:08:53.765015	2020-03-23 17:08:53.765015
2540	Peleliu	15	186	2020-03-23 17:08:53.766848	2020-03-23 17:08:53.766848
2541	San Pedro	17	187	2020-03-23 17:08:53.768429	2020-03-23 17:08:53.768429
2542	Presidente Hayes	16	187	2020-03-23 17:08:53.770009	2020-03-23 17:08:53.770009
2543	Paraguarí	15	187	2020-03-23 17:08:53.77194	2020-03-23 17:08:53.77194
2544	Ñeembucú	13	187	2020-03-23 17:08:53.774024	2020-03-23 17:08:53.774024
2545	Misiones	12	187	2020-03-23 17:08:53.775825	2020-03-23 17:08:53.775825
2546	Itapúa	11	187	2020-03-23 17:08:53.777459	2020-03-23 17:08:53.777459
2547	Guairá	10	187	2020-03-23 17:08:53.779074	2020-03-23 17:08:53.779074
2548	Cordillera	08	187	2020-03-23 17:08:53.780885	2020-03-23 17:08:53.780885
2549	Concepción	07	187	2020-03-23 17:08:53.782774	2020-03-23 17:08:53.782774
2550	Central	06	187	2020-03-23 17:08:53.784359	2020-03-23 17:08:53.784359
2551	Canindeyú	19	187	2020-03-23 17:08:53.786189	2020-03-23 17:08:53.786189
2552	Caazapá	05	187	2020-03-23 17:08:53.788175	2020-03-23 17:08:53.788175
2553	Caaguazú	04	187	2020-03-23 17:08:53.789828	2020-03-23 17:08:53.789828
2554	Amambay	02	187	2020-03-23 17:08:53.791399	2020-03-23 17:08:53.791399
2555	Alto Paraná	01	187	2020-03-23 17:08:53.793437	2020-03-23 17:08:53.793437
2556	Alto Paraguay	23	187	2020-03-23 17:08:53.795482	2020-03-23 17:08:53.795482
2557	Asunción	22	187	2020-03-23 17:08:53.797092	2020-03-23 17:08:53.797092
2558	Boquerón	24	187	2020-03-23 17:08:53.798736	2020-03-23 17:08:53.798736
2559	Madīnat ash Shamāl	08	188	2020-03-23 17:08:53.800648	2020-03-23 17:08:53.800648
2560	Al Ghuwayrīyah	02	188	2020-03-23 17:08:53.802376	2020-03-23 17:08:53.802376
2561	Al Khawr	04	188	2020-03-23 17:08:53.803927	2020-03-23 17:08:53.803927
2562	Umm Şalāl	09	188	2020-03-23 17:08:53.805504	2020-03-23 17:08:53.805504
2563	Al Jumaylīyah	03	188	2020-03-23 17:08:53.807363	2020-03-23 17:08:53.807363
2564	Ar Rayyān	06	188	2020-03-23 17:08:53.809114	2020-03-23 17:08:53.809114
2565	Ad Dawḩah	01	188	2020-03-23 17:08:53.810749	2020-03-23 17:08:53.810749
2566	Al Wakrah	10	188	2020-03-23 17:08:53.812617	2020-03-23 17:08:53.812617
2567	Jarayān al Bāţinah	11	188	2020-03-23 17:08:53.814417	2020-03-23 17:08:53.814417
2568	Baladīyat Umm Sa‘īd	12	188	2020-03-23 17:08:53.816115	2020-03-23 17:08:53.816115
2569	Réunion	RE	189	2020-03-23 17:08:53.817849	2020-03-23 17:08:53.817849
2570	Judeţul Vrancea	40	190	2020-03-23 17:08:53.819386	2020-03-23 17:08:53.819386
2571	Vâlcea	39	190	2020-03-23 17:08:53.820847	2020-03-23 17:08:53.820847
2572	Vaslui	38	190	2020-03-23 17:08:53.822563	2020-03-23 17:08:53.822563
2573	Tulcea	37	190	2020-03-23 17:08:53.824307	2020-03-23 17:08:53.824307
2574	Timiş	36	190	2020-03-23 17:08:53.825964	2020-03-23 17:08:53.825964
2575	Teleorman	35	190	2020-03-23 17:08:53.827891	2020-03-23 17:08:53.827891
2576	Suceava	34	190	2020-03-23 17:08:53.829661	2020-03-23 17:08:53.829661
2577	Sibiu	33	190	2020-03-23 17:08:53.831452	2020-03-23 17:08:53.831452
2578	Satu Mare	32	190	2020-03-23 17:08:53.833417	2020-03-23 17:08:53.833417
2579	Sălaj	31	190	2020-03-23 17:08:53.835126	2020-03-23 17:08:53.835126
2580	Prahova	30	190	2020-03-23 17:08:53.836898	2020-03-23 17:08:53.836898
2581	Olt	29	190	2020-03-23 17:08:53.838558	2020-03-23 17:08:53.838558
2582	Neamţ	28	190	2020-03-23 17:08:53.840017	2020-03-23 17:08:53.840017
2583	Mureş	27	190	2020-03-23 17:08:53.841515	2020-03-23 17:08:53.841515
2584	Mehedinţi	26	190	2020-03-23 17:08:53.843209	2020-03-23 17:08:53.843209
2585	Maramureş	25	190	2020-03-23 17:08:53.844671	2020-03-23 17:08:53.844671
2586	Iaşi	23	190	2020-03-23 17:08:53.846794	2020-03-23 17:08:53.846794
2587	Ialomiţa	22	190	2020-03-23 17:08:53.850092	2020-03-23 17:08:53.850092
2588	Hunedoara	21	190	2020-03-23 17:08:53.853442	2020-03-23 17:08:53.853442
2589	Harghita	20	190	2020-03-23 17:08:53.855424	2020-03-23 17:08:53.855424
2590	Gorj	19	190	2020-03-23 17:08:53.8574	2020-03-23 17:08:53.8574
2591	Giurgiu	42	190	2020-03-23 17:08:53.859098	2020-03-23 17:08:53.859098
2592	Galaţi	18	190	2020-03-23 17:08:53.860902	2020-03-23 17:08:53.860902
2593	Dolj	17	190	2020-03-23 17:08:53.862679	2020-03-23 17:08:53.862679
2594	Dâmboviţa	16	190	2020-03-23 17:08:53.864529	2020-03-23 17:08:53.864529
2595	Covasna	15	190	2020-03-23 17:08:53.866155	2020-03-23 17:08:53.866155
2596	Constanţa	14	190	2020-03-23 17:08:53.867784	2020-03-23 17:08:53.867784
2597	Cluj	13	190	2020-03-23 17:08:53.86957	2020-03-23 17:08:53.86957
2598	Caraş-Severin	12	190	2020-03-23 17:08:53.871385	2020-03-23 17:08:53.871385
2599	Călăraşi	41	190	2020-03-23 17:08:53.873393	2020-03-23 17:08:53.873393
2600	Buzău	11	190	2020-03-23 17:08:53.875141	2020-03-23 17:08:53.875141
2601	Bucureşti	10	190	2020-03-23 17:08:53.876973	2020-03-23 17:08:53.876973
2602	Braşov	09	190	2020-03-23 17:08:53.878736	2020-03-23 17:08:53.878736
2603	Brăila	08	190	2020-03-23 17:08:53.880818	2020-03-23 17:08:53.880818
2604	Botoşani	07	190	2020-03-23 17:08:53.882818	2020-03-23 17:08:53.882818
2605	Bistriţa-Năsăud	06	190	2020-03-23 17:08:53.884545	2020-03-23 17:08:53.884545
2606	Bihor	05	190	2020-03-23 17:08:53.886086	2020-03-23 17:08:53.886086
2607	Bacău	04	190	2020-03-23 17:08:53.887681	2020-03-23 17:08:53.887681
2608	Argeş	03	190	2020-03-23 17:08:53.889649	2020-03-23 17:08:53.889649
2609	Arad	02	190	2020-03-23 17:08:53.891366	2020-03-23 17:08:53.891366
2610	Alba	01	190	2020-03-23 17:08:53.893394	2020-03-23 17:08:53.893394
2611	Ilfov	43	190	2020-03-23 17:08:53.895107	2020-03-23 17:08:53.895107
2612	Autonomna Pokrajina Vojvodina	VO	191	2020-03-23 17:08:53.896703	2020-03-23 17:08:53.896703
2613	Central Serbia	SE	191	2020-03-23 17:08:53.898464	2020-03-23 17:08:53.898464
2614	Jaroslavl	88	192	2020-03-23 17:08:53.899964	2020-03-23 17:08:53.899964
2615	Voronezj	86	192	2020-03-23 17:08:53.901499	2020-03-23 17:08:53.901499
2616	Vologda	85	192	2020-03-23 17:08:53.902972	2020-03-23 17:08:53.902972
2617	Volgograd	84	192	2020-03-23 17:08:53.904641	2020-03-23 17:08:53.904641
2618	Uljanovsk	81	192	2020-03-23 17:08:53.906632	2020-03-23 17:08:53.906632
2619	Udmurtiya	80	192	2020-03-23 17:08:53.90809	2020-03-23 17:08:53.90809
2620	Tverskaya	77	192	2020-03-23 17:08:53.909745	2020-03-23 17:08:53.909745
2621	Tula	76	192	2020-03-23 17:08:53.911385	2020-03-23 17:08:53.911385
2622	Tatarstan	73	192	2020-03-23 17:08:53.913506	2020-03-23 17:08:53.913506
2623	Tambov	72	192	2020-03-23 17:08:53.915306	2020-03-23 17:08:53.915306
2624	Stavropol'skiy	70	192	2020-03-23 17:08:53.917175	2020-03-23 17:08:53.917175
2625	Smolensk	69	192	2020-03-23 17:08:53.918785	2020-03-23 17:08:53.918785
2626	Saratov	67	192	2020-03-23 17:08:53.920286	2020-03-23 17:08:53.920286
2627	Samara	65	192	2020-03-23 17:08:53.922021	2020-03-23 17:08:53.922021
2628	Rjazan	62	192	2020-03-23 17:08:53.923963	2020-03-23 17:08:53.923963
2629	Rostov	61	192	2020-03-23 17:08:53.925822	2020-03-23 17:08:53.925822
2630	Pskov	60	192	2020-03-23 17:08:53.927768	2020-03-23 17:08:53.927768
2631	Perm	90	192	2020-03-23 17:08:53.929594	2020-03-23 17:08:53.929594
2632	Penza	57	192	2020-03-23 17:08:53.931655	2020-03-23 17:08:53.931655
2633	Orjol	56	192	2020-03-23 17:08:53.933589	2020-03-23 17:08:53.933589
2634	Orenburg	55	192	2020-03-23 17:08:53.93512	2020-03-23 17:08:53.93512
2635	Novgorod	52	192	2020-03-23 17:08:53.936872	2020-03-23 17:08:53.936872
2636	North Ossetia	68	192	2020-03-23 17:08:53.939002	2020-03-23 17:08:53.939002
2637	Nenetskiy Avtonomnyy Okrug	50	192	2020-03-23 17:08:53.940595	2020-03-23 17:08:53.940595
2638	Murmansk	49	192	2020-03-23 17:08:53.942113	2020-03-23 17:08:53.942113
2639	Moscow	48	192	2020-03-23 17:08:53.943703	2020-03-23 17:08:53.943703
2640	Moskovskaya	47	192	2020-03-23 17:08:53.945374	2020-03-23 17:08:53.945374
2641	Mordoviya	46	192	2020-03-23 17:08:53.947368	2020-03-23 17:08:53.947368
2642	Mariy-El	45	192	2020-03-23 17:08:53.949075	2020-03-23 17:08:53.949075
2643	Lipetsk	43	192	2020-03-23 17:08:53.950698	2020-03-23 17:08:53.950698
2644	Leningrad	42	192	2020-03-23 17:08:53.952625	2020-03-23 17:08:53.952625
2645	Sankt-Peterburg	66	192	2020-03-23 17:08:53.954477	2020-03-23 17:08:53.954477
2646	Kursk	41	192	2020-03-23 17:08:53.955954	2020-03-23 17:08:53.955954
2647	Krasnodarskiy	38	192	2020-03-23 17:08:53.957689	2020-03-23 17:08:53.957689
2648	Kostroma	37	192	2020-03-23 17:08:53.959145	2020-03-23 17:08:53.959145
2649	Komi	34	192	2020-03-23 17:08:53.960642	2020-03-23 17:08:53.960642
2650	Kirov	33	192	2020-03-23 17:08:53.962443	2020-03-23 17:08:53.962443
2651	Kareliya	28	192	2020-03-23 17:08:53.964101	2020-03-23 17:08:53.964101
2652	Karachayevo-Cherkesiya	27	192	2020-03-23 17:08:53.965523	2020-03-23 17:08:53.965523
2653	Kaluga	25	192	2020-03-23 17:08:53.966979	2020-03-23 17:08:53.966979
2654	Kalmykiya	24	192	2020-03-23 17:08:53.968435	2020-03-23 17:08:53.968435
2655	Kaliningrad	23	192	2020-03-23 17:08:53.969878	2020-03-23 17:08:53.969878
2656	Kabardino-Balkariya	22	192	2020-03-23 17:08:53.971673	2020-03-23 17:08:53.971673
2657	Ivanovo	21	192	2020-03-23 17:08:53.973641	2020-03-23 17:08:53.973641
2658	Ingushetiya	19	192	2020-03-23 17:08:53.975286	2020-03-23 17:08:53.975286
2659	Nizjnij Novgorod	51	192	2020-03-23 17:08:53.977121	2020-03-23 17:08:53.977121
2660	Dagestan	17	192	2020-03-23 17:08:53.979002	2020-03-23 17:08:53.979002
2661	Chuvashia	16	192	2020-03-23 17:08:53.98068	2020-03-23 17:08:53.98068
2662	Chechnya	12	192	2020-03-23 17:08:53.98219	2020-03-23 17:08:53.98219
2663	Brjansk	10	192	2020-03-23 17:08:53.983727	2020-03-23 17:08:53.983727
2664	Belgorod	09	192	2020-03-23 17:08:53.985841	2020-03-23 17:08:53.985841
2665	Bashkortostan	08	192	2020-03-23 17:08:53.987569	2020-03-23 17:08:53.987569
2666	Astrakhan	07	192	2020-03-23 17:08:53.989424	2020-03-23 17:08:53.989424
2667	Arkhangelskaya	06	192	2020-03-23 17:08:53.991073	2020-03-23 17:08:53.991073
2668	Adygeya	01	192	2020-03-23 17:08:53.992954	2020-03-23 17:08:53.992954
2669	Vladimir	83	192	2020-03-23 17:08:53.994725	2020-03-23 17:08:53.994725
2670	Yamalo-Nenetskiy Avtonomnyy Okrug	87	192	2020-03-23 17:08:53.996617	2020-03-23 17:08:53.996617
2671	Tjumen	78	192	2020-03-23 17:08:53.998435	2020-03-23 17:08:53.998435
2672	Tyva	79	192	2020-03-23 17:08:54.000207	2020-03-23 17:08:54.000207
2673	Tomsk	75	192	2020-03-23 17:08:54.00216	2020-03-23 17:08:54.00216
2674	Sverdlovsk	71	192	2020-03-23 17:08:54.003866	2020-03-23 17:08:54.003866
2675	Omsk	54	192	2020-03-23 17:08:54.005598	2020-03-23 17:08:54.005598
2676	Novosibirsk	53	192	2020-03-23 17:08:54.007123	2020-03-23 17:08:54.007123
2677	Kurgan	40	192	2020-03-23 17:08:54.008679	2020-03-23 17:08:54.008679
2678	Krasnoyarskiy	91	192	2020-03-23 17:08:54.010395	2020-03-23 17:08:54.010395
2679	Khanty-Mansiyskiy Avtonomnyy Okrug	32	192	2020-03-23 17:08:54.012283	2020-03-23 17:08:54.012283
2680	Khakasiya	31	192	2020-03-23 17:08:54.014126	2020-03-23 17:08:54.014126
2681	Kemerovo	29	192	2020-03-23 17:08:54.016127	2020-03-23 17:08:54.016127
2682	Altay	03	192	2020-03-23 17:08:54.018166	2020-03-23 17:08:54.018166
2683	Tsjeljabinsk	13	192	2020-03-23 17:08:54.020263	2020-03-23 17:08:54.020263
2684	Altayskiy	04	192	2020-03-23 17:08:54.022224	2020-03-23 17:08:54.022224
2685	Sakha	63	192	2020-03-23 17:08:54.024234	2020-03-23 17:08:54.024234
2686	Primorskiy	59	192	2020-03-23 17:08:54.026147	2020-03-23 17:08:54.026147
2687	Khabarovsk Krai	30	192	2020-03-23 17:08:54.027686	2020-03-23 17:08:54.027686
2688	Irkutsk	20	192	2020-03-23 17:08:54.029468	2020-03-23 17:08:54.029468
2689	Zabaïkalski	14	192	2020-03-23 17:08:54.031355	2020-03-23 17:08:54.031355
2690	Jewish Autonomous Oblast	89	192	2020-03-23 17:08:54.033428	2020-03-23 17:08:54.033428
2691	Amur	05	192	2020-03-23 17:08:54.035474	2020-03-23 17:08:54.035474
2692	Buryatiya	11	192	2020-03-23 17:08:54.03731	2020-03-23 17:08:54.03731
2693	Sakhalin	64	192	2020-03-23 17:08:54.03911	2020-03-23 17:08:54.03911
2694	Magadan	44	192	2020-03-23 17:08:54.040734	2020-03-23 17:08:54.040734
2695	Kamtsjatka	92	192	2020-03-23 17:08:54.042652	2020-03-23 17:08:54.042652
2696	Chukotskiy Avtonomnyy Okrug	15	192	2020-03-23 17:08:54.044172	2020-03-23 17:08:54.044172
2697	Zabaykal’skiy Kray	93	192	2020-03-23 17:08:54.045636	2020-03-23 17:08:54.045636
2698	Eastern Province	11	193	2020-03-23 17:08:54.047284	2020-03-23 17:08:54.047284
2699	Kigali City	12	193	2020-03-23 17:08:54.048713	2020-03-23 17:08:54.048713
2700	Northern Province	13	193	2020-03-23 17:08:54.05125	2020-03-23 17:08:54.05125
2701	Western Province	14	193	2020-03-23 17:08:54.053472	2020-03-23 17:08:54.053472
2702	Southern Province	15	193	2020-03-23 17:08:54.055131	2020-03-23 17:08:54.055131
2703	Tabūk	19	194	2020-03-23 17:08:54.056792	2020-03-23 17:08:54.056792
2704	Najrān	16	194	2020-03-23 17:08:54.058822	2020-03-23 17:08:54.058822
2705	Makkah	14	194	2020-03-23 17:08:54.060598	2020-03-23 17:08:54.060598
2706	Jīzān	17	194	2020-03-23 17:08:54.062361	2020-03-23 17:08:54.062361
2707	Ḩāʼil	13	194	2020-03-23 17:08:54.064044	2020-03-23 17:08:54.064044
2708	Minţaqat ‘Asīr	11	194	2020-03-23 17:08:54.065792	2020-03-23 17:08:54.065792
2709	Ash Sharqīyah	06	194	2020-03-23 17:08:54.067475	2020-03-23 17:08:54.067475
2710	Ar Riyāḑ	10	194	2020-03-23 17:08:54.069189	2020-03-23 17:08:54.069189
2711	Al Qaşīm	08	194	2020-03-23 17:08:54.07106	2020-03-23 17:08:54.07106
2712	Al Madīnah	05	194	2020-03-23 17:08:54.073241	2020-03-23 17:08:54.073241
2713	Al Jawf	20	194	2020-03-23 17:08:54.075198	2020-03-23 17:08:54.075198
2714	Northern Borders Region	15	194	2020-03-23 17:08:54.07705	2020-03-23 17:08:54.07705
2715	Al Bāḩah	02	194	2020-03-23 17:08:54.07879	2020-03-23 17:08:54.07879
2716	Western Province	11	195	2020-03-23 17:08:54.080632	2020-03-23 17:08:54.080632
2717	Malaita	03	195	2020-03-23 17:08:54.082735	2020-03-23 17:08:54.082735
2718	Isabel	07	195	2020-03-23 17:08:54.084326	2020-03-23 17:08:54.084326
2719	Guadalcanal	06	195	2020-03-23 17:08:54.085994	2020-03-23 17:08:54.085994
2720	Central Province	10	195	2020-03-23 17:08:54.087683	2020-03-23 17:08:54.087683
2721	Temotu	09	195	2020-03-23 17:08:54.08938	2020-03-23 17:08:54.08938
2722	Makira	08	195	2020-03-23 17:08:54.091352	2020-03-23 17:08:54.091352
2723	Choiseul	12	195	2020-03-23 17:08:54.093267	2020-03-23 17:08:54.093267
2724	Rennell and Bellona	13	195	2020-03-23 17:08:54.094777	2020-03-23 17:08:54.094777
2725	Takamaka	23	196	2020-03-23 17:08:54.096441	2020-03-23 17:08:54.096441
2726	Saint Louis	22	196	2020-03-23 17:08:54.098629	2020-03-23 17:08:54.098629
2727	Port Glaud	27	196	2020-03-23 17:08:54.100454	2020-03-23 17:08:54.100454
2728	Pointe Larue	20	196	2020-03-23 17:08:54.102225	2020-03-23 17:08:54.102225
2729	Plaisance	19	196	2020-03-23 17:08:54.104095	2020-03-23 17:08:54.104095
2730	Mont Fleuri	18	196	2020-03-23 17:08:54.105866	2020-03-23 17:08:54.105866
2731	Mont Buxton	17	196	2020-03-23 17:08:54.107669	2020-03-23 17:08:54.107669
2732	English River	26	196	2020-03-23 17:08:54.109701	2020-03-23 17:08:54.109701
2733	Inner Islands	25	196	2020-03-23 17:08:54.111451	2020-03-23 17:08:54.111451
2734	Grand Anse Mahe	24	196	2020-03-23 17:08:54.113611	2020-03-23 17:08:54.113611
2735	Grand Anse Praslin	14	196	2020-03-23 17:08:54.115523	2020-03-23 17:08:54.115523
2736	Glacis	12	196	2020-03-23 17:08:54.117243	2020-03-23 17:08:54.117243
2737	Cascade	11	196	2020-03-23 17:08:54.118998	2020-03-23 17:08:54.118998
2738	Bel Ombre	10	196	2020-03-23 17:08:54.120744	2020-03-23 17:08:54.120744
2739	Bel Air	09	196	2020-03-23 17:08:54.122602	2020-03-23 17:08:54.122602
2740	Beau Vallon	08	196	2020-03-23 17:08:54.124084	2020-03-23 17:08:54.124084
2741	Baie Sainte Anne	07	196	2020-03-23 17:08:54.125807	2020-03-23 17:08:54.125807
2742	Baie Lazare	06	196	2020-03-23 17:08:54.127564	2020-03-23 17:08:54.127564
2743	Anse Royale	05	196	2020-03-23 17:08:54.129375	2020-03-23 17:08:54.129375
2744	Anse Etoile	03	196	2020-03-23 17:08:54.131269	2020-03-23 17:08:54.131269
2745	Anse Boileau	02	196	2020-03-23 17:08:54.133508	2020-03-23 17:08:54.133508
2746	Anse aux Pins	01	196	2020-03-23 17:08:54.135341	2020-03-23 17:08:54.135341
2747	Les Mamelles	29	196	2020-03-23 17:08:54.139303	2020-03-23 17:08:54.139303
2748	Roche Caiman	30	196	2020-03-23 17:08:54.140904	2020-03-23 17:08:54.140904
2749	Au Cap	28	196	2020-03-23 17:08:54.142588	2020-03-23 17:08:54.142588
2750	Northern	43	197	2020-03-23 17:08:54.144505	2020-03-23 17:08:54.144505
2751	Khartoum	29	197	2020-03-23 17:08:54.146271	2020-03-23 17:08:54.146271
2752	Upper Nile State	35	197	2020-03-23 17:08:54.148154	2020-03-23 17:08:54.148154
2753	Red Sea	36	197	2020-03-23 17:08:54.14962	2020-03-23 17:08:54.14962
2754	Lakes State	37	197	2020-03-23 17:08:54.151385	2020-03-23 17:08:54.151385
2755	Gezira	38	197	2020-03-23 17:08:54.153387	2020-03-23 17:08:54.153387
2756	Gedaref	39	197	2020-03-23 17:08:54.154997	2020-03-23 17:08:54.154997
2757	Unity	40	197	2020-03-23 17:08:54.156722	2020-03-23 17:08:54.156722
2758	White Nile	41	197	2020-03-23 17:08:54.158378	2020-03-23 17:08:54.158378
2759	Blue Nile State	42	197	2020-03-23 17:08:54.160184	2020-03-23 17:08:54.160184
2760	Bahr el Gabel	44	197	2020-03-23 17:08:54.161914	2020-03-23 17:08:54.161914
2761	Western Equatoria	45	197	2020-03-23 17:08:54.163452	2020-03-23 17:08:54.163452
2762	Western Bahr al Ghazal	46	197	2020-03-23 17:08:54.164936	2020-03-23 17:08:54.164936
2763	Western Darfur State	47	197	2020-03-23 17:08:54.166416	2020-03-23 17:08:54.166416
2764	Southern Darfur	49	197	2020-03-23 17:08:54.168893	2020-03-23 17:08:54.168893
2765	Southern Kordofan State	50	197	2020-03-23 17:08:54.17056	2020-03-23 17:08:54.17056
2766	Jonglei State	51	197	2020-03-23 17:08:54.172332	2020-03-23 17:08:54.172332
2767	Kassala State	52	197	2020-03-23 17:08:54.17426	2020-03-23 17:08:54.17426
2768	River Nile State	53	197	2020-03-23 17:08:54.175799	2020-03-23 17:08:54.175799
2769	Northern Bahr el Ghazal State	54	197	2020-03-23 17:08:54.177312	2020-03-23 17:08:54.177312
2770	Northern Darfur	55	197	2020-03-23 17:08:54.178895	2020-03-23 17:08:54.178895
2771	Northern Kordofan	56	197	2020-03-23 17:08:54.180352	2020-03-23 17:08:54.180352
2772	Eastern Equatoria	57	197	2020-03-23 17:08:54.181844	2020-03-23 17:08:54.181844
2773	Sinnar State	58	197	2020-03-23 17:08:54.183448	2020-03-23 17:08:54.183448
2774	Warab State	59	197	2020-03-23 17:08:54.184944	2020-03-23 17:08:54.184944
2775	Norrbotten	14	198	2020-03-23 17:08:54.186703	2020-03-23 17:08:54.186703
2776	Västmanland	25	198	2020-03-23 17:08:54.188387	2020-03-23 17:08:54.188387
2777	Västernorrland	24	198	2020-03-23 17:08:54.190124	2020-03-23 17:08:54.190124
2778	Västerbotten	23	198	2020-03-23 17:08:54.192022	2020-03-23 17:08:54.192022
2779	Värmland	22	198	2020-03-23 17:08:54.194237	2020-03-23 17:08:54.194237
2780	Uppsala	21	198	2020-03-23 17:08:54.196154	2020-03-23 17:08:54.196154
2781	Stockholm	26	198	2020-03-23 17:08:54.19806	2020-03-23 17:08:54.19806
2782	Södermanland	18	198	2020-03-23 17:08:54.199733	2020-03-23 17:08:54.199733
2783	Östergötland	16	198	2020-03-23 17:08:54.201264	2020-03-23 17:08:54.201264
2784	Örebro	15	198	2020-03-23 17:08:54.202743	2020-03-23 17:08:54.202743
2785	Kronoberg	12	198	2020-03-23 17:08:54.204262	2020-03-23 17:08:54.204262
2786	Dalarna	10	198	2020-03-23 17:08:54.205798	2020-03-23 17:08:54.205798
2787	Kalmar	09	198	2020-03-23 17:08:54.208107	2020-03-23 17:08:54.208107
2788	Jönköping	08	198	2020-03-23 17:08:54.211748	2020-03-23 17:08:54.211748
2789	Jämtland	07	198	2020-03-23 17:08:54.215055	2020-03-23 17:08:54.215055
2790	Halland	06	198	2020-03-23 17:08:54.217871	2020-03-23 17:08:54.217871
2791	Gotland	05	198	2020-03-23 17:08:54.219467	2020-03-23 17:08:54.219467
2792	Gävleborg	03	198	2020-03-23 17:08:54.221165	2020-03-23 17:08:54.221165
2793	Blekinge	02	198	2020-03-23 17:08:54.222877	2020-03-23 17:08:54.222877
2794	Skåne	27	198	2020-03-23 17:08:54.224606	2020-03-23 17:08:54.224606
2795	Västra Götaland	28	198	2020-03-23 17:08:54.226389	2020-03-23 17:08:54.226389
2796	Central Singapore	01	199	2020-03-23 17:08:54.228139	2020-03-23 17:08:54.228139
2797	North East	02	199	2020-03-23 17:08:54.230285	2020-03-23 17:08:54.230285
2798	South East	04	199	2020-03-23 17:08:54.232839	2020-03-23 17:08:54.232839
2799	South West	05	199	2020-03-23 17:08:54.235176	2020-03-23 17:08:54.235176
2800	North West	03	199	2020-03-23 17:08:54.237158	2020-03-23 17:08:54.237158
2801	Ascension	01	200	2020-03-23 17:08:54.239076	2020-03-23 17:08:54.239076
2802	Tristan da Cunha	03	200	2020-03-23 17:08:54.241192	2020-03-23 17:08:54.241192
2803	Saint Helena	02	200	2020-03-23 17:08:54.242815	2020-03-23 17:08:54.242815
2804	Žalec	N5	201	2020-03-23 17:08:54.244502	2020-03-23 17:08:54.244502
2805	Zagorje ob Savi	E7	201	2020-03-23 17:08:54.24594	2020-03-23 17:08:54.24594
2806	Vrhnika	E5	201	2020-03-23 17:08:54.247307	2020-03-23 17:08:54.247307
2807	Tržič	D5	201	2020-03-23 17:08:54.248777	2020-03-23 17:08:54.248777
2808	Trebnje	D4	201	2020-03-23 17:08:54.250216	2020-03-23 17:08:54.250216
2809	Trbovlje	D3	201	2020-03-23 17:08:54.251967	2020-03-23 17:08:54.251967
2810	Tolmin	D2	201	2020-03-23 17:08:54.254158	2020-03-23 17:08:54.254158
2811	Velenje	D7	201	2020-03-23 17:08:54.255715	2020-03-23 17:08:54.255715
2812	Šmarje pri Jelšah	C5	201	2020-03-23 17:08:54.257321	2020-03-23 17:08:54.257321
2813	Slovenska Konjice	C4	201	2020-03-23 17:08:54.258971	2020-03-23 17:08:54.258971
2814	Slovenska Bistrica	L8	201	2020-03-23 17:08:54.260491	2020-03-23 17:08:54.260491
2815	Slovenj Gradec	C2	201	2020-03-23 17:08:54.261962	2020-03-23 17:08:54.261962
2816	Škofja Loka	B9	201	2020-03-23 17:08:54.263362	2020-03-23 17:08:54.263362
2817	Sežana	B7	201	2020-03-23 17:08:54.264845	2020-03-23 17:08:54.264845
2818	Sevnica	B6	201	2020-03-23 17:08:54.266363	2020-03-23 17:08:54.266363
2819	Šentjur pri Celju	L7	201	2020-03-23 17:08:54.267663	2020-03-23 17:08:54.267663
2820	Ribnica	L1	201	2020-03-23 17:08:54.269152	2020-03-23 17:08:54.269152
2821	Radovljica	A3	201	2020-03-23 17:08:54.270641	2020-03-23 17:08:54.270641
2822	Radlje ob Dravi	A2	201	2020-03-23 17:08:54.272564	2020-03-23 17:08:54.272564
2823	Ptuj	K7	201	2020-03-23 17:08:54.274351	2020-03-23 17:08:54.274351
2824	Postojna	94	201	2020-03-23 17:08:54.275876	2020-03-23 17:08:54.275876
2825	Piran-Pirano	J9	201	2020-03-23 17:08:54.277314	2020-03-23 17:08:54.277314
2826	Ormož	87	201	2020-03-23 17:08:54.278793	2020-03-23 17:08:54.278793
2827	Novo Mesto	J7	201	2020-03-23 17:08:54.280161	2020-03-23 17:08:54.280161
2828	Nova Gorica	84	201	2020-03-23 17:08:54.281617	2020-03-23 17:08:54.281617
2829	Murska Sobota	80	201	2020-03-23 17:08:54.282987	2020-03-23 17:08:54.282987
2830	Mozirje	79	201	2020-03-23 17:08:54.284552	2020-03-23 17:08:54.284552
2831	Metlika	73	201	2020-03-23 17:08:54.286055	2020-03-23 17:08:54.286055
2832	Maribor	J2	201	2020-03-23 17:08:54.287561	2020-03-23 17:08:54.287561
2833	Logatec	64	201	2020-03-23 17:08:54.289016	2020-03-23 17:08:54.289016
2834	Ljutomer	I6	201	2020-03-23 17:08:54.290603	2020-03-23 17:08:54.290603
2835	Litija	I5	201	2020-03-23 17:08:54.292417	2020-03-23 17:08:54.292417
2836	Lenart	I3	201	2020-03-23 17:08:54.294261	2020-03-23 17:08:54.294261
2837	Laško	57	201	2020-03-23 17:08:54.296175	2020-03-23 17:08:54.296175
2838	Krško	54	201	2020-03-23 17:08:54.297963	2020-03-23 17:08:54.297963
2839	Kranj	52	201	2020-03-23 17:08:54.299496	2020-03-23 17:08:54.299496
2840	Koper-Capodistria	50	201	2020-03-23 17:08:54.301074	2020-03-23 17:08:54.301074
2841	Kočevje	H7	201	2020-03-23 17:08:54.302674	2020-03-23 17:08:54.302674
2842	Kamnik	H6	201	2020-03-23 17:08:54.304177	2020-03-23 17:08:54.304177
2843	Jesenice	H4	201	2020-03-23 17:08:54.30585	2020-03-23 17:08:54.30585
2844	Izola-Isola	40	201	2020-03-23 17:08:54.307357	2020-03-23 17:08:54.307357
2845	Ilirska Bistrica	38	201	2020-03-23 17:08:54.308981	2020-03-23 17:08:54.308981
2846	Idrija	36	201	2020-03-23 17:08:54.310609	2020-03-23 17:08:54.310609
2847	Hrastnik	34	201	2020-03-23 17:08:54.312548	2020-03-23 17:08:54.312548
2848	Grosuplje	32	201	2020-03-23 17:08:54.314192	2020-03-23 17:08:54.314192
2849	Gornja Radgona	29	201	2020-03-23 17:08:54.315686	2020-03-23 17:08:54.315686
2850	Dravograd	25	201	2020-03-23 17:08:54.317233	2020-03-23 17:08:54.317233
2851	Domžale	G7	201	2020-03-23 17:08:54.318686	2020-03-23 17:08:54.318686
2852	Črnomelj	17	201	2020-03-23 17:08:54.32026	2020-03-23 17:08:54.32026
2853	Cerknica	13	201	2020-03-23 17:08:54.321786	2020-03-23 17:08:54.321786
2854	Celje	11	201	2020-03-23 17:08:54.323237	2020-03-23 17:08:54.323237
2855	Brežice	08	201	2020-03-23 17:08:54.324629	2020-03-23 17:08:54.324629
2856	Ajdovščina	01	201	2020-03-23 17:08:54.32608	2020-03-23 17:08:54.32608
2857	Hrpelje-Kozina	35	201	2020-03-23 17:08:54.327447	2020-03-23 17:08:54.327447
2858	Divača	19	201	2020-03-23 17:08:54.328831	2020-03-23 17:08:54.328831
2859	Pivka	91	201	2020-03-23 17:08:54.330324	2020-03-23 17:08:54.330324
2860	Loška Dolina	I7	201	2020-03-23 17:08:54.332533	2020-03-23 17:08:54.332533
2861	Loški Potok	66	201	2020-03-23 17:08:54.33426	2020-03-23 17:08:54.33426
2862	Osilnica	88	201	2020-03-23 17:08:54.335849	2020-03-23 17:08:54.335849
2863	Velike Lašče	D8	201	2020-03-23 17:08:54.33729	2020-03-23 17:08:54.33729
2864	Škofljica	C1	201	2020-03-23 17:08:54.338835	2020-03-23 17:08:54.338835
2865	Ig	37	201	2020-03-23 17:08:54.340534	2020-03-23 17:08:54.340534
2866	Brezovica	09	201	2020-03-23 17:08:54.342606	2020-03-23 17:08:54.342606
2867	Borovnica	05	201	2020-03-23 17:08:54.344598	2020-03-23 17:08:54.344598
2868	Vipava	E1	201	2020-03-23 17:08:54.346814	2020-03-23 17:08:54.346814
2869	Komen	49	201	2020-03-23 17:08:54.349205	2020-03-23 17:08:54.349205
2870	Miren-Kostanjevica	J5	201	2020-03-23 17:08:54.351055	2020-03-23 17:08:54.351055
2871	Brda	07	201	2020-03-23 17:08:54.353121	2020-03-23 17:08:54.353121
2872	Kanal	44	201	2020-03-23 17:08:54.354723	2020-03-23 17:08:54.354723
2873	Žiri	F2	201	2020-03-23 17:08:54.356149	2020-03-23 17:08:54.356149
2874	Cerkno	14	201	2020-03-23 17:08:54.35767	2020-03-23 17:08:54.35767
2875	Železniki	F1	201	2020-03-23 17:08:54.359283	2020-03-23 17:08:54.359283
2876	Gorenja Vas-Poljane	27	201	2020-03-23 17:08:54.360793	2020-03-23 17:08:54.360793
2877	Dobrova-Horjul-Polhov Gradec	G4	201	2020-03-23 17:08:54.362222	2020-03-23 17:08:54.362222
2878	Kobarid	46	201	2020-03-23 17:08:54.363857	2020-03-23 17:08:54.363857
2879	Bovec	06	201	2020-03-23 17:08:54.365712	2020-03-23 17:08:54.365712
2880	Bohinj	04	201	2020-03-23 17:08:54.367645	2020-03-23 17:08:54.367645
2881	Bled	03	201	2020-03-23 17:08:54.36971	2020-03-23 17:08:54.36971
2882	Naklo	82	201	2020-03-23 17:08:54.371363	2020-03-23 17:08:54.371363
2883	Kranjska Gora	53	201	2020-03-23 17:08:54.373675	2020-03-23 17:08:54.373675
2884	Preddvor	K5	201	2020-03-23 17:08:54.375294	2020-03-23 17:08:54.375294
2885	Cerklje Na Gorenjskem	12	201	2020-03-23 17:08:54.376817	2020-03-23 17:08:54.376817
2886	Šenčur	B2	201	2020-03-23 17:08:54.378312	2020-03-23 17:08:54.378312
2887	Vodice	E3	201	2020-03-23 17:08:54.379761	2020-03-23 17:08:54.379761
2888	Medvode	71	201	2020-03-23 17:08:54.381447	2020-03-23 17:08:54.381447
2889	Mengeš	72	201	2020-03-23 17:08:54.383233	2020-03-23 17:08:54.383233
2890	Dol Pri Ljubljani	22	201	2020-03-23 17:08:54.384765	2020-03-23 17:08:54.384765
2891	Moravče	77	201	2020-03-23 17:08:54.386412	2020-03-23 17:08:54.386412
2892	Gornji Grad	30	201	2020-03-23 17:08:54.387942	2020-03-23 17:08:54.387942
2893	Luče	I9	201	2020-03-23 17:08:54.389436	2020-03-23 17:08:54.389436
2894	Ravne na Koroškem	K8	201	2020-03-23 17:08:54.390976	2020-03-23 17:08:54.390976
2895	Mežica	74	201	2020-03-23 17:08:54.393374	2020-03-23 17:08:54.393374
2896	Muta	81	201	2020-03-23 17:08:54.395351	2020-03-23 17:08:54.395351
2897	Vuzenica	E6	201	2020-03-23 17:08:54.396849	2020-03-23 17:08:54.396849
2898	Črna na Koroškem	16	201	2020-03-23 17:08:54.398354	2020-03-23 17:08:54.398354
2899	Ljubno	62	201	2020-03-23 17:08:54.399771	2020-03-23 17:08:54.399771
2900	Šoštanj	C7	201	2020-03-23 17:08:54.401239	2020-03-23 17:08:54.401239
2901	Šmartno ob Paki	C6	201	2020-03-23 17:08:54.403217	2020-03-23 17:08:54.403217
2902	Lukovica	68	201	2020-03-23 17:08:54.404694	2020-03-23 17:08:54.404694
2903	Radeče	99	201	2020-03-23 17:08:54.406158	2020-03-23 17:08:54.406158
2904	Ivančna Gorica	39	201	2020-03-23 17:08:54.407667	2020-03-23 17:08:54.407667
2905	Dobrepolje	20	201	2020-03-23 17:08:54.409116	2020-03-23 17:08:54.409116
2906	Semič	B1	201	2020-03-23 17:08:54.411546	2020-03-23 17:08:54.411546
2907	Šentjernej	B4	201	2020-03-23 17:08:54.413584	2020-03-23 17:08:54.413584
2908	Škocjan	B8	201	2020-03-23 17:08:54.415125	2020-03-23 17:08:54.415125
2909	Štore	C9	201	2020-03-23 17:08:54.416634	2020-03-23 17:08:54.416634
2910	Vojnik	N3	201	2020-03-23 17:08:54.418495	2020-03-23 17:08:54.418495
2911	Vitanje	E2	201	2020-03-23 17:08:54.419987	2020-03-23 17:08:54.419987
2912	Zreče	F3	201	2020-03-23 17:08:54.421476	2020-03-23 17:08:54.421476
2913	Mislinja	76	201	2020-03-23 17:08:54.422905	2020-03-23 17:08:54.422905
2914	Ruše	L3	201	2020-03-23 17:08:54.424477	2020-03-23 17:08:54.424477
2915	Kungota	55	201	2020-03-23 17:08:54.426425	2020-03-23 17:08:54.426425
2916	Šentilj	B3	201	2020-03-23 17:08:54.428102	2020-03-23 17:08:54.428102
2917	Pesnica	89	201	2020-03-23 17:08:54.42958	2020-03-23 17:08:54.42958
2918	Duplek	26	201	2020-03-23 17:08:54.431105	2020-03-23 17:08:54.431105
2919	Rače-Fram	98	201	2020-03-23 17:08:54.433601	2020-03-23 17:08:54.433601
2920	Starše	C8	201	2020-03-23 17:08:54.435551	2020-03-23 17:08:54.435551
2921	Kidričevo	45	201	2020-03-23 17:08:54.437075	2020-03-23 17:08:54.437075
2922	Majšperk	J1	201	2020-03-23 17:08:54.438576	2020-03-23 17:08:54.438576
2923	Videm	N2	201	2020-03-23 17:08:54.440133	2020-03-23 17:08:54.440133
2924	Rogaška Slatina	A7	201	2020-03-23 17:08:54.44191	2020-03-23 17:08:54.44191
2925	Rogatec	A8	201	2020-03-23 17:08:54.443623	2020-03-23 17:08:54.443623
2926	Podčetrtek	92	201	2020-03-23 17:08:54.445143	2020-03-23 17:08:54.445143
2927	Kozje	51	201	2020-03-23 17:08:54.446656	2020-03-23 17:08:54.446656
2928	Gorišnica	28	201	2020-03-23 17:08:54.448213	2020-03-23 17:08:54.448213
2929	Zavrč	E9	201	2020-03-23 17:08:54.449977	2020-03-23 17:08:54.449977
2930	Dornava	24	201	2020-03-23 17:08:54.452162	2020-03-23 17:08:54.452162
2931	Juršinci	42	201	2020-03-23 17:08:54.454046	2020-03-23 17:08:54.454046
2932	Sveti Jurij	D1	201	2020-03-23 17:08:54.455657	2020-03-23 17:08:54.455657
2933	Radenci	A1	201	2020-03-23 17:08:54.45711	2020-03-23 17:08:54.45711
2934	Puconci	97	201	2020-03-23 17:08:54.459113	2020-03-23 17:08:54.459113
2935	Rogašovci	A6	201	2020-03-23 17:08:54.460626	2020-03-23 17:08:54.460626
2936	Kuzma	I2	201	2020-03-23 17:08:54.462152	2020-03-23 17:08:54.462152
2937	Gornji Petrovci	31	201	2020-03-23 17:08:54.463636	2020-03-23 17:08:54.463636
2938	Moravske Toplice	78	201	2020-03-23 17:08:54.465152	2020-03-23 17:08:54.465152
2939	Kobilje	47	201	2020-03-23 17:08:54.467239	2020-03-23 17:08:54.467239
2940	Beltinci	02	201	2020-03-23 17:08:54.468792	2020-03-23 17:08:54.468792
2941	Turnišče	D6	201	2020-03-23 17:08:54.470305	2020-03-23 17:08:54.470305
2942	Odranci	86	201	2020-03-23 17:08:54.471988	2020-03-23 17:08:54.471988
2943	Črenšovci	15	201	2020-03-23 17:08:54.473971	2020-03-23 17:08:54.473971
2944	Nazarje	83	201	2020-03-23 17:08:54.476055	2020-03-23 17:08:54.476055
2945	Ljubljana	61	201	2020-03-23 17:08:54.477637	2020-03-23 17:08:54.477637
2946	Žirovnica	N7	201	2020-03-23 17:08:54.479358	2020-03-23 17:08:54.479358
2947	Jezersko	H5	201	2020-03-23 17:08:54.481281	2020-03-23 17:08:54.481281
2948	Solčava	M2	201	2020-03-23 17:08:54.483366	2020-03-23 17:08:54.483366
2949	Komenda	H8	201	2020-03-23 17:08:54.48496	2020-03-23 17:08:54.48496
2950	Horjul	H3	201	2020-03-23 17:08:54.48663	2020-03-23 17:08:54.48663
2951	Šempeter-Vrtojba	L6	201	2020-03-23 17:08:54.488149	2020-03-23 17:08:54.488149
2952	Bloke	F6	201	2020-03-23 17:08:54.489693	2020-03-23 17:08:54.489693
2953	Sodražica	M1	201	2020-03-23 17:08:54.491393	2020-03-23 17:08:54.491393
2954	Trzin	M8	201	2020-03-23 17:08:54.493384	2020-03-23 17:08:54.493384
2955	Prevalje	K6	201	2020-03-23 17:08:54.495006	2020-03-23 17:08:54.495006
2956	Vransko	N4	201	2020-03-23 17:08:54.496474	2020-03-23 17:08:54.496474
2957	Tabor	M5	201	2020-03-23 17:08:54.498106	2020-03-23 17:08:54.498106
2958	Braslovče	F7	201	2020-03-23 17:08:54.499797	2020-03-23 17:08:54.499797
2959	Polzela	K3	201	2020-03-23 17:08:54.501386	2020-03-23 17:08:54.501386
2960	Prebold	K4	201	2020-03-23 17:08:54.502908	2020-03-23 17:08:54.502908
2961	Kostel	H9	201	2020-03-23 17:08:54.504434	2020-03-23 17:08:54.504434
2962	Žužemberk	N8	201	2020-03-23 17:08:54.506407	2020-03-23 17:08:54.506407
2963	Dolenjske Toplice	G6	201	2020-03-23 17:08:54.508062	2020-03-23 17:08:54.508062
2964	Mirna Peč	J6	201	2020-03-23 17:08:54.509711	2020-03-23 17:08:54.509711
2965	Bistrica ob Sotli	F5	201	2020-03-23 17:08:54.511395	2020-03-23 17:08:54.511395
2966	Dobje	G2	201	2020-03-23 17:08:54.513556	2020-03-23 17:08:54.513556
2967	Dobrna	G3	201	2020-03-23 17:08:54.515644	2020-03-23 17:08:54.515644
2968	Oplotnica	J8	201	2020-03-23 17:08:54.517212	2020-03-23 17:08:54.517212
2969	Podvelka	K2	201	2020-03-23 17:08:54.518702	2020-03-23 17:08:54.518702
2970	Ribnica na Pohorju	L2	201	2020-03-23 17:08:54.520167	2020-03-23 17:08:54.520167
2971	Lovrenc na Pohorju	I8	201	2020-03-23 17:08:54.521985	2020-03-23 17:08:54.521985
2972	Selnica ob Dravi	L5	201	2020-03-23 17:08:54.523938	2020-03-23 17:08:54.523938
2973	Hoče-Slivnica	H1	201	2020-03-23 17:08:54.525615	2020-03-23 17:08:54.525615
2974	Miklavž na Dravskem Polju	J4	201	2020-03-23 17:08:54.527203	2020-03-23 17:08:54.527203
2975	Hajdina	G9	201	2020-03-23 17:08:54.530913	2020-03-23 17:08:54.530913
2976	Žetale	N6	201	2020-03-23 17:08:54.533071	2020-03-23 17:08:54.533071
2977	Podlehnik	K1	201	2020-03-23 17:08:54.534806	2020-03-23 17:08:54.534806
2978	Markovci	J3	201	2020-03-23 17:08:54.536264	2020-03-23 17:08:54.536264
2979	Destrnik	G1	201	2020-03-23 17:08:54.537853	2020-03-23 17:08:54.537853
2980	Trnovska Vas	M7	201	2020-03-23 17:08:54.539828	2020-03-23 17:08:54.539828
2981	Sveti Andraž v Slovenskih Goricah	M4	201	2020-03-23 17:08:54.54133	2020-03-23 17:08:54.54133
2982	Cerkvenjak	F9	201	2020-03-23 17:08:54.542774	2020-03-23 17:08:54.542774
2983	Benedikt	F4	201	2020-03-23 17:08:54.544283	2020-03-23 17:08:54.544283
2984	Sveta Ana	M3	201	2020-03-23 17:08:54.545919	2020-03-23 17:08:54.545919
2985	Križevci	I1	201	2020-03-23 17:08:54.547783	2020-03-23 17:08:54.547783
2986	Veržej	N1	201	2020-03-23 17:08:54.549147	2020-03-23 17:08:54.549147
2987	Velika Polana	M9	201	2020-03-23 17:08:54.550445	2020-03-23 17:08:54.550445
2988	Lendava-Lendva	I4	201	2020-03-23 17:08:54.552323	2020-03-23 17:08:54.552323
2989	Dobrovnik-Dobronak	G5	201	2020-03-23 17:08:54.554589	2020-03-23 17:08:54.554589
2990	Tišina	M6	201	2020-03-23 17:08:54.556117	2020-03-23 17:08:54.556117
2991	Cankova	F8	201	2020-03-23 17:08:54.557746	2020-03-23 17:08:54.557746
2992	Grad	G8	201	2020-03-23 17:08:54.559228	2020-03-23 17:08:54.559228
2993	Hodoš-Hodos	H2	201	2020-03-23 17:08:54.56068	2020-03-23 17:08:54.56068
2994	Razkrižje	K9	201	2020-03-23 17:08:54.562443	2020-03-23 17:08:54.562443
2995	Šmartno pri Litiji	L9	201	2020-03-23 17:08:54.564075	2020-03-23 17:08:54.564075
2996	Šalovci	L4	201	2020-03-23 17:08:54.565577	2020-03-23 17:08:54.565577
2997	Jan Mayen	22	202	2020-03-23 17:08:54.567003	2020-03-23 17:08:54.567003
2998	Svalbard	21	202	2020-03-23 17:08:54.56847	2020-03-23 17:08:54.56847
2999	Košický	03	203	2020-03-23 17:08:54.569974	2020-03-23 17:08:54.569974
3000	Prešovský	05	203	2020-03-23 17:08:54.572085	2020-03-23 17:08:54.572085
3001	Žilinský	08	203	2020-03-23 17:08:54.573945	2020-03-23 17:08:54.573945
3002	Banskobystrický	01	203	2020-03-23 17:08:54.575435	2020-03-23 17:08:54.575435
3003	Bratislavský	02	203	2020-03-23 17:08:54.576902	2020-03-23 17:08:54.576902
3004	Nitriansky	04	203	2020-03-23 17:08:54.579051	2020-03-23 17:08:54.579051
3005	Trenčiansky	06	203	2020-03-23 17:08:54.580624	2020-03-23 17:08:54.580624
3006	Trnavský	07	203	2020-03-23 17:08:54.582027	2020-03-23 17:08:54.582027
3007	Western Area	04	204	2020-03-23 17:08:54.583447	2020-03-23 17:08:54.583447
3008	Southern Province	03	204	2020-03-23 17:08:54.5849	2020-03-23 17:08:54.5849
3009	Northern Province	02	204	2020-03-23 17:08:54.586566	2020-03-23 17:08:54.586566
3010	Eastern Province	01	204	2020-03-23 17:08:54.588626	2020-03-23 17:08:54.588626
3011	Serravalle	09	205	2020-03-23 17:08:54.590618	2020-03-23 17:08:54.590618
3012	Chiesanuova	02	205	2020-03-23 17:08:54.594963	2020-03-23 17:08:54.594963
3013	San Marino	07	205	2020-03-23 17:08:54.597427	2020-03-23 17:08:54.597427
3014	Acquaviva	01	205	2020-03-23 17:08:54.600144	2020-03-23 17:08:54.600144
3015	Borgo Maggiore	06	205	2020-03-23 17:08:54.604453	2020-03-23 17:08:54.604453
3016	Domagnano	03	205	2020-03-23 17:08:54.609274	2020-03-23 17:08:54.609274
3017	Faetano	04	205	2020-03-23 17:08:54.61556	2020-03-23 17:08:54.61556
3018	Fiorentino	05	205	2020-03-23 17:08:54.617563	2020-03-23 17:08:54.617563
3019	Montegiardino	08	205	2020-03-23 17:08:54.623045	2020-03-23 17:08:54.623045
3020	Ziguinchor	12	206	2020-03-23 17:08:54.626059	2020-03-23 17:08:54.626059
3021	Thiès	07	206	2020-03-23 17:08:54.627656	2020-03-23 17:08:54.627656
3022	Tambacounda	05	206	2020-03-23 17:08:54.630396	2020-03-23 17:08:54.630396
3023	Saint-Louis	14	206	2020-03-23 17:08:54.633416	2020-03-23 17:08:54.633416
3024	Matam	15	206	2020-03-23 17:08:54.635948	2020-03-23 17:08:54.635948
3025	Louga	13	206	2020-03-23 17:08:54.638241	2020-03-23 17:08:54.638241
3026	Kolda	11	206	2020-03-23 17:08:54.639972	2020-03-23 17:08:54.639972
3027	Kaolack	10	206	2020-03-23 17:08:54.641841	2020-03-23 17:08:54.641841
3028	Fatick	09	206	2020-03-23 17:08:54.643324	2020-03-23 17:08:54.643324
3029	Diourbel	03	206	2020-03-23 17:08:54.644628	2020-03-23 17:08:54.644628
3030	Dakar	01	206	2020-03-23 17:08:54.646117	2020-03-23 17:08:54.646117
3031	Kaffrine	16	206	2020-03-23 17:08:54.647636	2020-03-23 17:08:54.647636
3032	Kédougou	17	206	2020-03-23 17:08:54.649083	2020-03-23 17:08:54.649083
3033	Sédhiou	18	206	2020-03-23 17:08:54.650418	2020-03-23 17:08:54.650418
3034	Woqooyi Galbeed	20	207	2020-03-23 17:08:54.651929	2020-03-23 17:08:54.651929
3035	Togdheer	19	207	2020-03-23 17:08:54.653784	2020-03-23 17:08:54.653784
3036	Shabeellaha Hoose	14	207	2020-03-23 17:08:54.655186	2020-03-23 17:08:54.655186
3037	Middle Shabele	13	207	2020-03-23 17:08:54.656639	2020-03-23 17:08:54.656639
3038	Sanaag	12	207	2020-03-23 17:08:54.658163	2020-03-23 17:08:54.658163
3039	Nugaal	18	207	2020-03-23 17:08:54.659614	2020-03-23 17:08:54.659614
3040	Mudug	10	207	2020-03-23 17:08:54.661031	2020-03-23 17:08:54.661031
3041	Lower Juba	09	207	2020-03-23 17:08:54.662585	2020-03-23 17:08:54.662585
3042	Middle Juba	08	207	2020-03-23 17:08:54.663946	2020-03-23 17:08:54.663946
3043	Hiiraan	07	207	2020-03-23 17:08:54.665347	2020-03-23 17:08:54.665347
3044	Gedo	06	207	2020-03-23 17:08:54.66675	2020-03-23 17:08:54.66675
3045	Galguduud	05	207	2020-03-23 17:08:54.668115	2020-03-23 17:08:54.668115
3046	Bay	04	207	2020-03-23 17:08:54.669557	2020-03-23 17:08:54.669557
3047	Bari	03	207	2020-03-23 17:08:54.670976	2020-03-23 17:08:54.670976
3048	Banaadir	02	207	2020-03-23 17:08:54.672849	2020-03-23 17:08:54.672849
3049	Bakool	01	207	2020-03-23 17:08:54.674394	2020-03-23 17:08:54.674394
3050	Awdal	21	207	2020-03-23 17:08:54.675905	2020-03-23 17:08:54.675905
3051	Sool	22	207	2020-03-23 17:08:54.677317	2020-03-23 17:08:54.677317
3052	Wanica	19	208	2020-03-23 17:08:54.678701	2020-03-23 17:08:54.678701
3053	Sipaliwini	18	208	2020-03-23 17:08:54.680075	2020-03-23 17:08:54.680075
3054	Saramacca	17	208	2020-03-23 17:08:54.681503	2020-03-23 17:08:54.681503
3055	Paramaribo	16	208	2020-03-23 17:08:54.682934	2020-03-23 17:08:54.682934
3056	Para	15	208	2020-03-23 17:08:54.6842	2020-03-23 17:08:54.6842
3057	Nickerie	14	208	2020-03-23 17:08:54.685538	2020-03-23 17:08:54.685538
3058	Marowijne	13	208	2020-03-23 17:08:54.686938	2020-03-23 17:08:54.686938
3059	Coronie	12	208	2020-03-23 17:08:54.688503	2020-03-23 17:08:54.688503
3060	Commewijne	11	208	2020-03-23 17:08:54.690293	2020-03-23 17:08:54.690293
3061	Brokopondo	10	208	2020-03-23 17:08:54.692713	2020-03-23 17:08:54.692713
3062	São Tomé	02	209	2020-03-23 17:08:54.694311	2020-03-23 17:08:54.694311
3063	Príncipe	01	209	2020-03-23 17:08:54.69608	2020-03-23 17:08:54.69608
3064	Usulután	14	210	2020-03-23 17:08:54.698652	2020-03-23 17:08:54.698652
3065	Sonsonate	13	210	2020-03-23 17:08:54.700428	2020-03-23 17:08:54.700428
3066	San Vicente	12	210	2020-03-23 17:08:54.701893	2020-03-23 17:08:54.701893
3067	Santa Ana	11	210	2020-03-23 17:08:54.703232	2020-03-23 17:08:54.703232
3068	San Salvador	10	210	2020-03-23 17:08:54.704736	2020-03-23 17:08:54.704736
3069	San Miguel	09	210	2020-03-23 17:08:54.706151	2020-03-23 17:08:54.706151
3070	Morazán	08	210	2020-03-23 17:08:54.707463	2020-03-23 17:08:54.707463
3071	La Unión	07	210	2020-03-23 17:08:54.708919	2020-03-23 17:08:54.708919
3072	La Paz	06	210	2020-03-23 17:08:54.710486	2020-03-23 17:08:54.710486
3073	La Libertad	05	210	2020-03-23 17:08:54.712263	2020-03-23 17:08:54.712263
3074	Cuscatlán	04	210	2020-03-23 17:08:54.713952	2020-03-23 17:08:54.713952
3075	Chalatenango	03	210	2020-03-23 17:08:54.715429	2020-03-23 17:08:54.715429
3076	Cabañas	02	210	2020-03-23 17:08:54.716878	2020-03-23 17:08:54.716878
3077	Ahuachapán	01	210	2020-03-23 17:08:54.71827	2020-03-23 17:08:54.71827
3078	Tartus	14	212	2020-03-23 17:08:54.719713	2020-03-23 17:08:54.719713
3079	Damascus City	13	212	2020-03-23 17:08:54.721044	2020-03-23 17:08:54.721044
3080	Idlib	12	212	2020-03-23 17:08:54.722392	2020-03-23 17:08:54.722392
3081	Homs	11	212	2020-03-23 17:08:54.723819	2020-03-23 17:08:54.723819
3082	Hama	10	212	2020-03-23 17:08:54.725251	2020-03-23 17:08:54.725251
3083	Aleppo	09	212	2020-03-23 17:08:54.726613	2020-03-23 17:08:54.726613
3084	Rif-dimashq	08	212	2020-03-23 17:08:54.728063	2020-03-23 17:08:54.728063
3085	Deir ez-Zor	07	212	2020-03-23 17:08:54.729399	2020-03-23 17:08:54.729399
3086	Daraa	06	212	2020-03-23 17:08:54.730686	2020-03-23 17:08:54.730686
3087	As-Suwayda	05	212	2020-03-23 17:08:54.732433	2020-03-23 17:08:54.732433
3088	Ar-Raqqah	04	212	2020-03-23 17:08:54.733964	2020-03-23 17:08:54.733964
3089	Quneitra	03	212	2020-03-23 17:08:54.735386	2020-03-23 17:08:54.735386
3090	Latakia	02	212	2020-03-23 17:08:54.736854	2020-03-23 17:08:54.736854
3091	Al-Hasakah	01	212	2020-03-23 17:08:54.738467	2020-03-23 17:08:54.738467
3092	Shiselweni	04	213	2020-03-23 17:08:54.739897	2020-03-23 17:08:54.739897
3093	Manzini	03	213	2020-03-23 17:08:54.741455	2020-03-23 17:08:54.741455
3094	Lubombo	02	213	2020-03-23 17:08:54.742877	2020-03-23 17:08:54.742877
3095	Hhohho	01	213	2020-03-23 17:08:54.744315	2020-03-23 17:08:54.744315
3096	Salamat	13	215	2020-03-23 17:08:54.745734	2020-03-23 17:08:54.745734
3097	Ouaddaï	12	215	2020-03-23 17:08:54.747226	2020-03-23 17:08:54.747226
3098	Biltine	02	215	2020-03-23 17:08:54.74872	2020-03-23 17:08:54.74872
3099	Tandjilé	14	215	2020-03-23 17:08:54.750093	2020-03-23 17:08:54.750093
3100	Moyen-Chari	17	215	2020-03-23 17:08:54.75155	2020-03-23 17:08:54.75155
3101	Mayo-Kébbi	16	215	2020-03-23 17:08:54.753409	2020-03-23 17:08:54.753409
3102	Logone Oriental	09	215	2020-03-23 17:08:54.754981	2020-03-23 17:08:54.754981
3103	Logone Occidental	08	215	2020-03-23 17:08:54.756335	2020-03-23 17:08:54.756335
3104	Lac	07	215	2020-03-23 17:08:54.757829	2020-03-23 17:08:54.757829
3105	Kanem	06	215	2020-03-23 17:08:54.759284	2020-03-23 17:08:54.759284
3106	Guéra	05	215	2020-03-23 17:08:54.760703	2020-03-23 17:08:54.760703
3107	Chari-Baguirmi	15	215	2020-03-23 17:08:54.76213	2020-03-23 17:08:54.76213
3108	Batha	01	215	2020-03-23 17:08:54.763459	2020-03-23 17:08:54.763459
3109	Région du Borkou	23	215	2020-03-23 17:08:54.764828	2020-03-23 17:08:54.764828
3110	Région du Hadjer-Lamis	18	215	2020-03-23 17:08:54.766134	2020-03-23 17:08:54.766134
3111	Région du Mandoul	19	215	2020-03-23 17:08:54.767456	2020-03-23 17:08:54.767456
3112	Région du Mayo-Kébbi Ouest	20	215	2020-03-23 17:08:54.768876	2020-03-23 17:08:54.768876
3113	Région de la Ville de N'Djaména	21	215	2020-03-23 17:08:54.770268	2020-03-23 17:08:54.770268
3114	Région du Barh el Gazel	22	215	2020-03-23 17:08:54.771873	2020-03-23 17:08:54.771873
3115	Ennedi	24	215	2020-03-23 17:08:54.773561	2020-03-23 17:08:54.773561
3116	Région du Sila	25	215	2020-03-23 17:08:54.775078	2020-03-23 17:08:54.775078
3117	Région du Tibesti	26	215	2020-03-23 17:08:54.776534	2020-03-23 17:08:54.776534
3118	Crozet	02	216	2020-03-23 17:08:54.777975	2020-03-23 17:08:54.777975
3119	Kerguelen	03	216	2020-03-23 17:08:54.779501	2020-03-23 17:08:54.779501
3120	Saint-Paul-et-Amsterdam	01	216	2020-03-23 17:08:54.780869	2020-03-23 17:08:54.780869
3121	Îles Éparses	05	216	2020-03-23 17:08:54.782317	2020-03-23 17:08:54.782317
3122	Terre-Adélie	04	216	2020-03-23 17:08:54.783857	2020-03-23 17:08:54.783857
3123	Savanes	26	217	2020-03-23 17:08:54.785253	2020-03-23 17:08:54.785253
3124	Plateaux	25	217	2020-03-23 17:08:54.786711	2020-03-23 17:08:54.786711
3125	Maritime	24	217	2020-03-23 17:08:54.788218	2020-03-23 17:08:54.788218
3126	Centrale	22	217	2020-03-23 17:08:54.789623	2020-03-23 17:08:54.789623
3127	Kara	23	217	2020-03-23 17:08:54.791169	2020-03-23 17:08:54.791169
3128	Uthai Thani	15	218	2020-03-23 17:08:54.793539	2020-03-23 17:08:54.793539
3129	Trang	65	218	2020-03-23 17:08:54.794993	2020-03-23 17:08:54.794993
3130	Tak	08	218	2020-03-23 17:08:54.796351	2020-03-23 17:08:54.796351
3131	Surat Thani	60	218	2020-03-23 17:08:54.79787	2020-03-23 17:08:54.79787
3132	Sukhothai	09	218	2020-03-23 17:08:54.79947	2020-03-23 17:08:54.79947
3133	Ratchaburi	52	218	2020-03-23 17:08:54.801318	2020-03-23 17:08:54.801318
3134	Ranong	59	218	2020-03-23 17:08:54.803787	2020-03-23 17:08:54.803787
3135	Prachuap Khiri Khan	57	218	2020-03-23 17:08:54.806854	2020-03-23 17:08:54.806854
3136	Changwat Phuket	62	218	2020-03-23 17:08:54.809423	2020-03-23 17:08:54.809423
3137	Phetchaburi	56	218	2020-03-23 17:08:54.812116	2020-03-23 17:08:54.812116
3138	Phangnga	61	218	2020-03-23 17:08:54.814279	2020-03-23 17:08:54.814279
3139	Mae Hong Son	01	218	2020-03-23 17:08:54.816011	2020-03-23 17:08:54.816011
3140	Lamphun	05	218	2020-03-23 17:08:54.817487	2020-03-23 17:08:54.817487
3141	Lampang	06	218	2020-03-23 17:08:54.819203	2020-03-23 17:08:54.819203
3142	Krabi	63	218	2020-03-23 17:08:54.820809	2020-03-23 17:08:54.820809
3143	Kanchanaburi	50	218	2020-03-23 17:08:54.822445	2020-03-23 17:08:54.822445
3144	Kamphaeng Phet	11	218	2020-03-23 17:08:54.823925	2020-03-23 17:08:54.823925
3145	Chumphon	58	218	2020-03-23 17:08:54.825547	2020-03-23 17:08:54.825547
3146	Chiang Rai	03	218	2020-03-23 17:08:54.827198	2020-03-23 17:08:54.827198
3147	Chiang Mai	02	218	2020-03-23 17:08:54.828698	2020-03-23 17:08:54.828698
3148	Yasothon	72	218	2020-03-23 17:08:54.830192	2020-03-23 17:08:54.830192
3149	Yala	70	218	2020-03-23 17:08:54.832624	2020-03-23 17:08:54.832624
3150	Uttaradit	10	218	2020-03-23 17:08:54.835262	2020-03-23 17:08:54.835262
3151	Trat	49	218	2020-03-23 17:08:54.837612	2020-03-23 17:08:54.837612
3152	Surin	29	218	2020-03-23 17:08:54.840302	2020-03-23 17:08:54.840302
3153	Suphan Buri	51	218	2020-03-23 17:08:54.842821	2020-03-23 17:08:54.842821
3154	Songkhla	68	218	2020-03-23 17:08:54.845927	2020-03-23 17:08:54.845927
3155	Sisaket	30	218	2020-03-23 17:08:54.84758	2020-03-23 17:08:54.84758
3156	Sing Buri	33	218	2020-03-23 17:08:54.849345	2020-03-23 17:08:54.849345
3157	Satun	67	218	2020-03-23 17:08:54.851145	2020-03-23 17:08:54.851145
3158	Sara Buri	37	218	2020-03-23 17:08:54.85411	2020-03-23 17:08:54.85411
3159	Samut Songkhram	54	218	2020-03-23 17:08:54.857074	2020-03-23 17:08:54.857074
3160	Samut Sakhon	55	218	2020-03-23 17:08:54.859891	2020-03-23 17:08:54.859891
3161	Samut Prakan	42	218	2020-03-23 17:08:54.86216	2020-03-23 17:08:54.86216
3162	Sakon Nakhon	20	218	2020-03-23 17:08:54.865265	2020-03-23 17:08:54.865265
3163	Roi Et	25	218	2020-03-23 17:08:54.867063	2020-03-23 17:08:54.867063
3164	Rayong	47	218	2020-03-23 17:08:54.868554	2020-03-23 17:08:54.868554
3165	Phra Nakhon Si Ayutthaya	36	218	2020-03-23 17:08:54.870106	2020-03-23 17:08:54.870106
3166	Phrae	07	218	2020-03-23 17:08:54.871866	2020-03-23 17:08:54.871866
3167	Phitsanulok	12	218	2020-03-23 17:08:54.87383	2020-03-23 17:08:54.87383
3168	Phichit	13	218	2020-03-23 17:08:54.875507	2020-03-23 17:08:54.875507
3169	Phetchabun	14	218	2020-03-23 17:08:54.877055	2020-03-23 17:08:54.877055
3170	Phayao	41	218	2020-03-23 17:08:54.87868	2020-03-23 17:08:54.87868
3171	Phatthalung	66	218	2020-03-23 17:08:54.880186	2020-03-23 17:08:54.880186
3172	Pattani	69	218	2020-03-23 17:08:54.881777	2020-03-23 17:08:54.881777
3173	Pathum Thani	39	218	2020-03-23 17:08:54.883462	2020-03-23 17:08:54.883462
3174	Nonthaburi	38	218	2020-03-23 17:08:54.88544	2020-03-23 17:08:54.88544
3175	Nong Khai	17	218	2020-03-23 17:08:54.887188	2020-03-23 17:08:54.887188
3176	Narathiwat	31	218	2020-03-23 17:08:54.888785	2020-03-23 17:08:54.888785
3177	Nan	04	218	2020-03-23 17:08:54.89024	2020-03-23 17:08:54.89024
3178	Nakhon Si Thammarat	64	218	2020-03-23 17:08:54.89284	2020-03-23 17:08:54.89284
3179	Nakhon Sawan	16	218	2020-03-23 17:08:54.894509	2020-03-23 17:08:54.894509
3180	Nakhon Ratchasima	27	218	2020-03-23 17:08:54.896105	2020-03-23 17:08:54.896105
3181	Nakhon Phanom	73	218	2020-03-23 17:08:54.897623	2020-03-23 17:08:54.897623
3182	Nakhon Pathom	53	218	2020-03-23 17:08:54.899089	2020-03-23 17:08:54.899089
3183	Nakhon Nayok	43	218	2020-03-23 17:08:54.900553	2020-03-23 17:08:54.900553
3184	Mukdahan	78	218	2020-03-23 17:08:54.902003	2020-03-23 17:08:54.902003
3185	Maha Sarakham	24	218	2020-03-23 17:08:54.903533	2020-03-23 17:08:54.903533
3186	Lop Buri	34	218	2020-03-23 17:08:54.905135	2020-03-23 17:08:54.905135
3187	Loei	18	218	2020-03-23 17:08:54.906703	2020-03-23 17:08:54.906703
3188	Bangkok	40	218	2020-03-23 17:08:54.908161	2020-03-23 17:08:54.908161
3189	Khon Kaen	22	218	2020-03-23 17:08:54.909766	2020-03-23 17:08:54.909766
3190	Kalasin	23	218	2020-03-23 17:08:54.911362	2020-03-23 17:08:54.911362
3191	Chon Buri	46	218	2020-03-23 17:08:54.913469	2020-03-23 17:08:54.913469
3192	Chanthaburi	48	218	2020-03-23 17:08:54.915094	2020-03-23 17:08:54.915094
3193	Chaiyaphum	26	218	2020-03-23 17:08:54.916989	2020-03-23 17:08:54.916989
3194	Chai Nat	32	218	2020-03-23 17:08:54.919318	2020-03-23 17:08:54.919318
3195	Chachoengsao	44	218	2020-03-23 17:08:54.92133	2020-03-23 17:08:54.92133
3196	Buriram	28	218	2020-03-23 17:08:54.923239	2020-03-23 17:08:54.923239
3197	Ang Thong	35	218	2020-03-23 17:08:54.925228	2020-03-23 17:08:54.925228
3198	Udon Thani	76	218	2020-03-23 17:08:54.927285	2020-03-23 17:08:54.927285
3199	Prachin Buri	74	218	2020-03-23 17:08:54.929168	2020-03-23 17:08:54.929168
3200	Ubon Ratchathani	75	218	2020-03-23 17:08:54.930962	2020-03-23 17:08:54.930962
3201	Amnat Charoen	77	218	2020-03-23 17:08:54.933449	2020-03-23 17:08:54.933449
3202	Nong Bua Lamphu	79	218	2020-03-23 17:08:54.937188	2020-03-23 17:08:54.937188
3203	Sa Kaeo	80	218	2020-03-23 17:08:54.939099	2020-03-23 17:08:54.939099
3204	Sughd	03	219	2020-03-23 17:08:54.941274	2020-03-23 17:08:54.941274
3205	Gorno-Badakhshan	01	219	2020-03-23 17:08:54.943203	2020-03-23 17:08:54.943203
3206	Khatlon	02	219	2020-03-23 17:08:54.945095	2020-03-23 17:08:54.945095
3207	Region of Republican Subordination	RR	219	2020-03-23 17:08:54.94684	2020-03-23 17:08:54.94684
3208	Dushanbe	7280679	219	2020-03-23 17:08:54.948655	2020-03-23 17:08:54.948655
3209	Nukunonu	N	220	2020-03-23 17:08:54.950322	2020-03-23 17:08:54.950322
3210	Fakaofo	F	220	2020-03-23 17:08:54.952095	2020-03-23 17:08:54.952095
3211	Atafu	A	220	2020-03-23 17:08:54.953987	2020-03-23 17:08:54.953987
3212	Viqueque	VI	221	2020-03-23 17:08:54.955616	2020-03-23 17:08:54.955616
3213	Manufahi	MF	221	2020-03-23 17:08:54.957878	2020-03-23 17:08:54.957878
3214	Distrito Manatuto	MT	221	2020-03-23 17:08:54.959848	2020-03-23 17:08:54.959848
3215	Distrito Liquiçá	LI	221	2020-03-23 17:08:54.961516	2020-03-23 17:08:54.961516
3216	Distrito Lautém	LA	221	2020-03-23 17:08:54.963367	2020-03-23 17:08:54.963367
3217	Distrito Cova Lima	CO	221	2020-03-23 17:08:54.965228	2020-03-23 17:08:54.965228
3218	Ermera	ER	221	2020-03-23 17:08:54.966841	2020-03-23 17:08:54.966841
3219	Distrito Díli	DI	221	2020-03-23 17:08:54.968348	2020-03-23 17:08:54.968348
3220	Bobonaro	BO	221	2020-03-23 17:08:54.970005	2020-03-23 17:08:54.970005
3221	Distrito Bacau	BA	221	2020-03-23 17:08:54.971657	2020-03-23 17:08:54.971657
3222	Oecussi	OE	221	2020-03-23 17:08:54.973727	2020-03-23 17:08:54.973727
3223	Distrito Ainaro	AN	221	2020-03-23 17:08:54.975266	2020-03-23 17:08:54.975266
3224	Distrito Aileu	AL	221	2020-03-23 17:08:54.97674	2020-03-23 17:08:54.97674
3225	Balkan	02	222	2020-03-23 17:08:54.978187	2020-03-23 17:08:54.978187
3226	Ahal	01	222	2020-03-23 17:08:54.979707	2020-03-23 17:08:54.979707
3227	Daşoguz	03	222	2020-03-23 17:08:54.981777	2020-03-23 17:08:54.981777
3228	Mary	05	222	2020-03-23 17:08:54.983561	2020-03-23 17:08:54.983561
3229	Lebap	04	222	2020-03-23 17:08:54.98504	2020-03-23 17:08:54.98504
3230	Zaghwān	37	223	2020-03-23 17:08:54.986719	2020-03-23 17:08:54.986719
3231	Tūnis	36	223	2020-03-23 17:08:54.988176	2020-03-23 17:08:54.988176
3232	Tawzar	35	223	2020-03-23 17:08:54.989626	2020-03-23 17:08:54.989626
3233	Taţāwīn	34	223	2020-03-23 17:08:54.99142	2020-03-23 17:08:54.99142
3234	Sūsah	23	223	2020-03-23 17:08:54.993415	2020-03-23 17:08:54.993415
3235	Silyānah	22	223	2020-03-23 17:08:54.995082	2020-03-23 17:08:54.995082
3236	Sīdī Bū Zayd	33	223	2020-03-23 17:08:54.996568	2020-03-23 17:08:54.996568
3237	Şafāqis	32	223	2020-03-23 17:08:54.998188	2020-03-23 17:08:54.998188
3238	Qibilī	31	223	2020-03-23 17:08:55.000306	2020-03-23 17:08:55.000306
3239	Qafşah	30	223	2020-03-23 17:08:55.002007	2020-03-23 17:08:55.002007
3240	Qābis	29	223	2020-03-23 17:08:55.003745	2020-03-23 17:08:55.003745
3241	Nābul	19	223	2020-03-23 17:08:55.00536	2020-03-23 17:08:55.00536
3242	Madanīn	28	223	2020-03-23 17:08:55.006963	2020-03-23 17:08:55.006963
3243	Jundūbah	06	223	2020-03-23 17:08:55.008523	2020-03-23 17:08:55.008523
3244	Bin ‘Arūs	27	223	2020-03-23 17:08:55.010146	2020-03-23 17:08:55.010146
3245	Banzart	18	223	2020-03-23 17:08:55.012386	2020-03-23 17:08:55.012386
3246	Bājah	17	223	2020-03-23 17:08:55.01439	2020-03-23 17:08:55.01439
3247	Ariana	38	223	2020-03-23 17:08:55.015864	2020-03-23 17:08:55.015864
3248	Al Qayrawān	03	223	2020-03-23 17:08:55.017459	2020-03-23 17:08:55.017459
3249	Al Qaşrayn	02	223	2020-03-23 17:08:55.01924	2020-03-23 17:08:55.01924
3250	Al Munastīr	16	223	2020-03-23 17:08:55.021384	2020-03-23 17:08:55.021384
3251	Al Mahdīyah	15	223	2020-03-23 17:08:55.022894	2020-03-23 17:08:55.022894
3252	Kef	14	223	2020-03-23 17:08:55.024482	2020-03-23 17:08:55.024482
3253	Gouvernorat de la Manouba	39	223	2020-03-23 17:08:55.026013	2020-03-23 17:08:55.026013
3254	Vava`u	03	224	2020-03-23 17:08:55.02745	2020-03-23 17:08:55.02745
3255	Tongatapu	02	224	2020-03-23 17:08:55.028946	2020-03-23 17:08:55.028946
3256	Ha`apai	01	224	2020-03-23 17:08:55.030426	2020-03-23 17:08:55.030426
3257	Eua	EU	224	2020-03-23 17:08:55.032301	2020-03-23 17:08:55.032301
3258	Niuas	NI	224	2020-03-23 17:08:55.034174	2020-03-23 17:08:55.034174
3259	Yozgat	66	225	2020-03-23 17:08:55.035793	2020-03-23 17:08:55.035793
3260	Van	65	225	2020-03-23 17:08:55.03739	2020-03-23 17:08:55.03739
3261	Uşak	64	225	2020-03-23 17:08:55.038787	2020-03-23 17:08:55.038787
3262	Şanlıurfa	63	225	2020-03-23 17:08:55.040134	2020-03-23 17:08:55.040134
3263	Tunceli	62	225	2020-03-23 17:08:55.04163	2020-03-23 17:08:55.04163
3264	Sivas	58	225	2020-03-23 17:08:55.04323	2020-03-23 17:08:55.04323
3265	Siirt	74	225	2020-03-23 17:08:55.044963	2020-03-23 17:08:55.044963
3266	Niğde	73	225	2020-03-23 17:08:55.046419	2020-03-23 17:08:55.046419
3267	Nevşehir	50	225	2020-03-23 17:08:55.048113	2020-03-23 17:08:55.048113
3268	Muş	49	225	2020-03-23 17:08:55.049767	2020-03-23 17:08:55.049767
3269	Muğla	48	225	2020-03-23 17:08:55.052446	2020-03-23 17:08:55.052446
3270	Mardin	72	225	2020-03-23 17:08:55.05456	2020-03-23 17:08:55.05456
3271	Manisa	45	225	2020-03-23 17:08:55.056114	2020-03-23 17:08:55.056114
3272	Malatya	44	225	2020-03-23 17:08:55.057496	2020-03-23 17:08:55.057496
3273	Kütahya	43	225	2020-03-23 17:08:55.059126	2020-03-23 17:08:55.059126
3274	Konya	71	225	2020-03-23 17:08:55.060822	2020-03-23 17:08:55.060822
3275	Kırşehir	40	225	2020-03-23 17:08:55.062406	2020-03-23 17:08:55.062406
3276	Kayseri	38	225	2020-03-23 17:08:55.064074	2020-03-23 17:08:55.064074
3277	Kahramanmaraş	46	225	2020-03-23 17:08:55.06589	2020-03-23 17:08:55.06589
3278	İzmir	35	225	2020-03-23 17:08:55.067707	2020-03-23 17:08:55.067707
3279	Isparta	33	225	2020-03-23 17:08:55.069318	2020-03-23 17:08:55.069318
3280	Mersin	32	225	2020-03-23 17:08:55.071115	2020-03-23 17:08:55.071115
3281	Hatay	31	225	2020-03-23 17:08:55.073816	2020-03-23 17:08:55.073816
3282	Hakkâri	70	225	2020-03-23 17:08:55.075482	2020-03-23 17:08:55.075482
3283	Gaziantep	83	225	2020-03-23 17:08:55.077432	2020-03-23 17:08:55.077432
3284	Eskişehir	26	225	2020-03-23 17:08:55.079007	2020-03-23 17:08:55.079007
3285	Erzurum	25	225	2020-03-23 17:08:55.080595	2020-03-23 17:08:55.080595
3286	Erzincan	24	225	2020-03-23 17:08:55.082088	2020-03-23 17:08:55.082088
3287	Elazığ	23	225	2020-03-23 17:08:55.083543	2020-03-23 17:08:55.083543
3288	Diyarbakır	21	225	2020-03-23 17:08:55.085474	2020-03-23 17:08:55.085474
3289	Denizli	20	225	2020-03-23 17:08:55.086856	2020-03-23 17:08:55.086856
3290	Burdur	15	225	2020-03-23 17:08:55.088284	2020-03-23 17:08:55.088284
3291	Bitlis	13	225	2020-03-23 17:08:55.089698	2020-03-23 17:08:55.089698
3292	Bingöl	12	225	2020-03-23 17:08:55.091388	2020-03-23 17:08:55.091388
3293	Bilecik	11	225	2020-03-23 17:08:55.093676	2020-03-23 17:08:55.093676
3294	Balıkesir	10	225	2020-03-23 17:08:55.095241	2020-03-23 17:08:55.095241
3295	Aydın	09	225	2020-03-23 17:08:55.096738	2020-03-23 17:08:55.096738
3296	Antalya	07	225	2020-03-23 17:08:55.098139	2020-03-23 17:08:55.098139
3297	Ankara	68	225	2020-03-23 17:08:55.099661	2020-03-23 17:08:55.099661
3298	Ağrı	04	225	2020-03-23 17:08:55.101643	2020-03-23 17:08:55.101643
3299	Afyonkarahisar	03	225	2020-03-23 17:08:55.103305	2020-03-23 17:08:55.103305
3300	Adıyaman	02	225	2020-03-23 17:08:55.104787	2020-03-23 17:08:55.104787
3301	Adana	81	225	2020-03-23 17:08:55.106119	2020-03-23 17:08:55.106119
3302	Osmaniye	91	225	2020-03-23 17:08:55.107551	2020-03-23 17:08:55.107551
3303	Iğdır	88	225	2020-03-23 17:08:55.11016	2020-03-23 17:08:55.11016
3304	Aksaray	75	225	2020-03-23 17:08:55.112953	2020-03-23 17:08:55.112953
3305	Batman	76	225	2020-03-23 17:08:55.11473	2020-03-23 17:08:55.11473
3306	Karaman	78	225	2020-03-23 17:08:55.116787	2020-03-23 17:08:55.116787
3307	Kırıkkale	79	225	2020-03-23 17:08:55.118735	2020-03-23 17:08:55.118735
3308	Şırnak	80	225	2020-03-23 17:08:55.120424	2020-03-23 17:08:55.120424
3309	Kilis	90	225	2020-03-23 17:08:55.122084	2020-03-23 17:08:55.122084
3310	Zonguldak	85	225	2020-03-23 17:08:55.123977	2020-03-23 17:08:55.123977
3311	Trabzon	61	225	2020-03-23 17:08:55.12594	2020-03-23 17:08:55.12594
3312	Tokat	60	225	2020-03-23 17:08:55.127424	2020-03-23 17:08:55.127424
3313	Tekirdağ	59	225	2020-03-23 17:08:55.128897	2020-03-23 17:08:55.128897
3314	Sinop	57	225	2020-03-23 17:08:55.130467	2020-03-23 17:08:55.130467
3315	Samsun	55	225	2020-03-23 17:08:55.133335	2020-03-23 17:08:55.133335
3316	Sakarya	54	225	2020-03-23 17:08:55.134966	2020-03-23 17:08:55.134966
3317	Rize	53	225	2020-03-23 17:08:55.1365	2020-03-23 17:08:55.1365
3318	Ordu	52	225	2020-03-23 17:08:55.13791	2020-03-23 17:08:55.13791
3319	Kocaeli	41	225	2020-03-23 17:08:55.139369	2020-03-23 17:08:55.139369
3320	Kırklareli	39	225	2020-03-23 17:08:55.14106	2020-03-23 17:08:55.14106
3321	Kastamonu	37	225	2020-03-23 17:08:55.142603	2020-03-23 17:08:55.142603
3322	Kars	84	225	2020-03-23 17:08:55.144029	2020-03-23 17:08:55.144029
3323	Istanbul	34	225	2020-03-23 17:08:55.145381	2020-03-23 17:08:55.145381
3324	Gümüşhane	69	225	2020-03-23 17:08:55.146808	2020-03-23 17:08:55.146808
3325	Giresun	28	225	2020-03-23 17:08:55.148326	2020-03-23 17:08:55.148326
3326	Edirne	22	225	2020-03-23 17:08:55.149987	2020-03-23 17:08:55.149987
3327	Çorum	19	225	2020-03-23 17:08:55.151713	2020-03-23 17:08:55.151713
3328	Çankırı	82	225	2020-03-23 17:08:55.153814	2020-03-23 17:08:55.153814
3329	Çanakkale	17	225	2020-03-23 17:08:55.155367	2020-03-23 17:08:55.155367
3330	Bursa	16	225	2020-03-23 17:08:55.158013	2020-03-23 17:08:55.158013
3331	Bolu	14	225	2020-03-23 17:08:55.160262	2020-03-23 17:08:55.160262
3332	Artvin	08	225	2020-03-23 17:08:55.16202	2020-03-23 17:08:55.16202
3333	Amasya	05	225	2020-03-23 17:08:55.163524	2020-03-23 17:08:55.163524
3334	Bartın	87	225	2020-03-23 17:08:55.165403	2020-03-23 17:08:55.165403
3335	Karabük	89	225	2020-03-23 17:08:55.166959	2020-03-23 17:08:55.166959
3336	Yalova	92	225	2020-03-23 17:08:55.168443	2020-03-23 17:08:55.168443
3337	Ardahan	86	225	2020-03-23 17:08:55.170112	2020-03-23 17:08:55.170112
3338	Bayburt	77	225	2020-03-23 17:08:55.171935	2020-03-23 17:08:55.171935
3339	Düzce	93	225	2020-03-23 17:08:55.174234	2020-03-23 17:08:55.174234
3340	Tobago	11	226	2020-03-23 17:08:55.175973	2020-03-23 17:08:55.175973
3341	San Fernando	10	226	2020-03-23 17:08:55.177716	2020-03-23 17:08:55.177716
3342	Port-of-Spain	05	226	2020-03-23 17:08:55.180013	2020-03-23 17:08:55.180013
3343	Mayaro	03	226	2020-03-23 17:08:55.181944	2020-03-23 17:08:55.181944
3344	Arima	01	226	2020-03-23 17:08:55.183465	2020-03-23 17:08:55.183465
3345	Chaguanas	CHA	226	2020-03-23 17:08:55.184962	2020-03-23 17:08:55.184962
3346	Couva-Tabaquite-Talparo	CTT	226	2020-03-23 17:08:55.186449	2020-03-23 17:08:55.186449
3347	Diego Martin	DMN	226	2020-03-23 17:08:55.188049	2020-03-23 17:08:55.188049
3348	Eastern Tobago	ETO	226	2020-03-23 17:08:55.189894	2020-03-23 17:08:55.189894
3349	Penal/Debe	PED	226	2020-03-23 17:08:55.191878	2020-03-23 17:08:55.191878
3350	Princes Town	PRT	226	2020-03-23 17:08:55.193914	2020-03-23 17:08:55.193914
3351	Point Fortin	PTF	226	2020-03-23 17:08:55.196655	2020-03-23 17:08:55.196655
3352	Sangre Grande	SGE	226	2020-03-23 17:08:55.199597	2020-03-23 17:08:55.199597
3353	Siparia	SIP	226	2020-03-23 17:08:55.201147	2020-03-23 17:08:55.201147
3354	San Juan/Laventille	SJL	226	2020-03-23 17:08:55.20279	2020-03-23 17:08:55.20279
3355	Tunapuna/Piarco	TUP	226	2020-03-23 17:08:55.204342	2020-03-23 17:08:55.204342
3356	Nui	NUI	227	2020-03-23 17:08:55.206239	2020-03-23 17:08:55.206239
3357	Nanumea	NMA	227	2020-03-23 17:08:55.207802	2020-03-23 17:08:55.207802
3358	Funafuti	FUN	227	2020-03-23 17:08:55.209246	2020-03-23 17:08:55.209246
3359	Niutao	NIT	227	2020-03-23 17:08:55.210826	2020-03-23 17:08:55.210826
3360	Nanumanga	NMG	227	2020-03-23 17:08:55.212956	2020-03-23 17:08:55.212956
3361	Vaitupu	VAI	227	2020-03-23 17:08:55.214665	2020-03-23 17:08:55.214665
3362	Nukufetau	NKF	227	2020-03-23 17:08:55.216281	2020-03-23 17:08:55.216281
3363	Nukulaelae	NKL	227	2020-03-23 17:08:55.217746	2020-03-23 17:08:55.217746
3364	Fukien	01	228	2020-03-23 17:08:55.219238	2020-03-23 17:08:55.219238
3365	Kaohsiung	02	228	2020-03-23 17:08:55.22073	2020-03-23 17:08:55.22073
3366	Taipei	03	228	2020-03-23 17:08:55.222212	2020-03-23 17:08:55.222212
3367	Taiwan	04	228	2020-03-23 17:08:55.223597	2020-03-23 17:08:55.223597
3368	Kagera	19	229	2020-03-23 17:08:55.225325	2020-03-23 17:08:55.225325
3369	Zanzibar Urban/West	25	229	2020-03-23 17:08:55.226958	2020-03-23 17:08:55.226958
3370	Zanzibar North	22	229	2020-03-23 17:08:55.228514	2020-03-23 17:08:55.228514
3371	Zanzibar Central/South	21	229	2020-03-23 17:08:55.230092	2020-03-23 17:08:55.230092
3372	Tanga	18	229	2020-03-23 17:08:55.231885	2020-03-23 17:08:55.231885
3373	Tabora	17	229	2020-03-23 17:08:55.233794	2020-03-23 17:08:55.233794
3374	Singida	16	229	2020-03-23 17:08:55.235306	2020-03-23 17:08:55.235306
3375	Shinyanga	15	229	2020-03-23 17:08:55.236946	2020-03-23 17:08:55.236946
3376	Rukwa Region	24	229	2020-03-23 17:08:55.238587	2020-03-23 17:08:55.238587
3377	Pwani	02	229	2020-03-23 17:08:55.240166	2020-03-23 17:08:55.240166
3378	Pemba South	20	229	2020-03-23 17:08:55.241654	2020-03-23 17:08:55.241654
3379	Pemba North	13	229	2020-03-23 17:08:55.243392	2020-03-23 17:08:55.243392
3380	Mwanza	12	229	2020-03-23 17:08:55.245085	2020-03-23 17:08:55.245085
3381	Morogoro Region	10	229	2020-03-23 17:08:55.246832	2020-03-23 17:08:55.246832
3382	Mbeya	09	229	2020-03-23 17:08:55.248591	2020-03-23 17:08:55.248591
3383	Mara	08	229	2020-03-23 17:08:55.250897	2020-03-23 17:08:55.250897
3384	Lindi	07	229	2020-03-23 17:08:55.253522	2020-03-23 17:08:55.253522
3385	Kilimanjaro	06	229	2020-03-23 17:08:55.255194	2020-03-23 17:08:55.255194
3386	Kigoma	05	229	2020-03-23 17:08:55.256845	2020-03-23 17:08:55.256845
3387	Iringa	04	229	2020-03-23 17:08:55.258517	2020-03-23 17:08:55.258517
3388	Dodoma	03	229	2020-03-23 17:08:55.260304	2020-03-23 17:08:55.260304
3389	Dar es Salaam	23	229	2020-03-23 17:08:55.261889	2020-03-23 17:08:55.261889
3390	Arusha	26	229	2020-03-23 17:08:55.263425	2020-03-23 17:08:55.263425
3391	Manyara	27	229	2020-03-23 17:08:55.264947	2020-03-23 17:08:55.264947
3392	Ruvuma	14	229	2020-03-23 17:08:55.266425	2020-03-23 17:08:55.266425
3393	Mtwara	11	229	2020-03-23 17:08:55.268034	2020-03-23 17:08:55.268034
3394	Zhytomyrs'ka	27	230	2020-03-23 17:08:55.269953	2020-03-23 17:08:55.269953
3395	Zaporiz'ka	26	230	2020-03-23 17:08:55.271714	2020-03-23 17:08:55.271714
3396	Zakarpats'ka	25	230	2020-03-23 17:08:55.273705	2020-03-23 17:08:55.273705
3397	Volyns'ka	24	230	2020-03-23 17:08:55.275573	2020-03-23 17:08:55.275573
3398	Vinnyts'ka	23	230	2020-03-23 17:08:55.277677	2020-03-23 17:08:55.277677
3399	Ternopil's'ka	22	230	2020-03-23 17:08:55.279504	2020-03-23 17:08:55.279504
3400	Sumy	21	230	2020-03-23 17:08:55.281094	2020-03-23 17:08:55.281094
3401	Misto Sevastopol	20	230	2020-03-23 17:08:55.282615	2020-03-23 17:08:55.282615
3402	Rivnens'ka	19	230	2020-03-23 17:08:55.284182	2020-03-23 17:08:55.284182
3403	Poltava	18	230	2020-03-23 17:08:55.285732	2020-03-23 17:08:55.285732
3404	Odessa	17	230	2020-03-23 17:08:55.287252	2020-03-23 17:08:55.287252
3405	Mykolayivs'ka	16	230	2020-03-23 17:08:55.288721	2020-03-23 17:08:55.288721
3406	L'vivs'ka	15	230	2020-03-23 17:08:55.290241	2020-03-23 17:08:55.290241
3407	Luhans'ka	14	230	2020-03-23 17:08:55.2921	2020-03-23 17:08:55.2921
3408	Kiev	13	230	2020-03-23 17:08:55.294033	2020-03-23 17:08:55.294033
3409	Misto Kyyiv	12	230	2020-03-23 17:08:55.295767	2020-03-23 17:08:55.295767
3410	Avtonomna Respublika Krym	11	230	2020-03-23 17:08:55.297185	2020-03-23 17:08:55.297185
3411	Kirovohrads'ka	10	230	2020-03-23 17:08:55.298733	2020-03-23 17:08:55.298733
3412	Khmel'nyts'ka	09	230	2020-03-23 17:08:55.300417	2020-03-23 17:08:55.300417
3413	Kherson	08	230	2020-03-23 17:08:55.302583	2020-03-23 17:08:55.302583
3414	Kharkivs'ka	07	230	2020-03-23 17:08:55.305505	2020-03-23 17:08:55.305505
3415	Ivano-Frankivs'ka	06	230	2020-03-23 17:08:55.307781	2020-03-23 17:08:55.307781
3416	Donets'ka	05	230	2020-03-23 17:08:55.309821	2020-03-23 17:08:55.309821
3417	Dnipropetrovska	04	230	2020-03-23 17:08:55.312395	2020-03-23 17:08:55.312395
3418	Chernivets'ka	03	230	2020-03-23 17:08:55.315101	2020-03-23 17:08:55.315101
3419	Chernihivs'ka	02	230	2020-03-23 17:08:55.31707	2020-03-23 17:08:55.31707
3420	Cherkas'ka	01	230	2020-03-23 17:08:55.318633	2020-03-23 17:08:55.318633
3421	Masaka	71	231	2020-03-23 17:08:55.3202	2020-03-23 17:08:55.3202
3422	Mpigi	89	231	2020-03-23 17:08:55.321846	2020-03-23 17:08:55.321846
3423	Namutumba	E1	231	2020-03-23 17:08:55.323424	2020-03-23 17:08:55.323424
3424	Bukedea	C3	231	2020-03-23 17:08:55.325142	2020-03-23 17:08:55.325142
3425	Apac	26	231	2020-03-23 17:08:55.326774	2020-03-23 17:08:55.326774
3426	Arua	77	231	2020-03-23 17:08:55.328391	2020-03-23 17:08:55.328391
3427	Bundibugyo	28	231	2020-03-23 17:08:55.331198	2020-03-23 17:08:55.331198
3428	Bushenyi	29	231	2020-03-23 17:08:55.333899	2020-03-23 17:08:55.333899
3429	Gulu	30	231	2020-03-23 17:08:55.335737	2020-03-23 17:08:55.335737
3430	Hoima	31	231	2020-03-23 17:08:55.34413	2020-03-23 17:08:55.34413
3431	Iganga	78	231	2020-03-23 17:08:55.346726	2020-03-23 17:08:55.346726
3432	Jinja	33	231	2020-03-23 17:08:55.349451	2020-03-23 17:08:55.349451
3433	Kabale	34	231	2020-03-23 17:08:55.353362	2020-03-23 17:08:55.353362
3434	Kabarole	79	231	2020-03-23 17:08:55.355696	2020-03-23 17:08:55.355696
3435	Kalangala	36	231	2020-03-23 17:08:55.357289	2020-03-23 17:08:55.357289
3436	Kampala	37	231	2020-03-23 17:08:55.359082	2020-03-23 17:08:55.359082
3437	Kamuli	38	231	2020-03-23 17:08:55.360691	2020-03-23 17:08:55.360691
3438	Kapchorwa	39	231	2020-03-23 17:08:55.362303	2020-03-23 17:08:55.362303
3439	Kasese	40	231	2020-03-23 17:08:55.364184	2020-03-23 17:08:55.364184
3440	Kibale	41	231	2020-03-23 17:08:55.365752	2020-03-23 17:08:55.365752
3441	Kiboga	42	231	2020-03-23 17:08:55.367264	2020-03-23 17:08:55.367264
3442	Kisoro	43	231	2020-03-23 17:08:55.36873	2020-03-23 17:08:55.36873
3443	Kitgum	84	231	2020-03-23 17:08:55.370146	2020-03-23 17:08:55.370146
3444	Kotido	45	231	2020-03-23 17:08:55.371893	2020-03-23 17:08:55.371893
3445	Kumi	46	231	2020-03-23 17:08:55.373983	2020-03-23 17:08:55.373983
3446	Lira	47	231	2020-03-23 17:08:55.375613	2020-03-23 17:08:55.375613
3447	Luwero	70	231	2020-03-23 17:08:55.377398	2020-03-23 17:08:55.377398
3448	Masindi	50	231	2020-03-23 17:08:55.378924	2020-03-23 17:08:55.378924
3449	Mbale	87	231	2020-03-23 17:08:55.380707	2020-03-23 17:08:55.380707
3450	Mbarara	52	231	2020-03-23 17:08:55.382641	2020-03-23 17:08:55.382641
3451	Moroto	88	231	2020-03-23 17:08:55.384293	2020-03-23 17:08:55.384293
3452	Moyo	72	231	2020-03-23 17:08:55.386352	2020-03-23 17:08:55.386352
3453	Mubende	56	231	2020-03-23 17:08:55.388098	2020-03-23 17:08:55.388098
3454	Mukono	90	231	2020-03-23 17:08:55.389945	2020-03-23 17:08:55.389945
3455	Nebbi	58	231	2020-03-23 17:08:55.391723	2020-03-23 17:08:55.391723
3456	Ntungamo	59	231	2020-03-23 17:08:55.39372	2020-03-23 17:08:55.39372
3457	Pallisa	60	231	2020-03-23 17:08:55.395167	2020-03-23 17:08:55.395167
3458	Rakai	61	231	2020-03-23 17:08:55.396673	2020-03-23 17:08:55.396673
3459	Rukungiri	93	231	2020-03-23 17:08:55.398164	2020-03-23 17:08:55.398164
3460	Soroti	95	231	2020-03-23 17:08:55.399565	2020-03-23 17:08:55.399565
3461	Tororo	76	231	2020-03-23 17:08:55.401139	2020-03-23 17:08:55.401139
3462	Adjumani	65	231	2020-03-23 17:08:55.402687	2020-03-23 17:08:55.402687
3463	Bugiri	66	231	2020-03-23 17:08:55.40435	2020-03-23 17:08:55.40435
3464	Busia	67	231	2020-03-23 17:08:55.406815	2020-03-23 17:08:55.406815
3465	Katakwi	69	231	2020-03-23 17:08:55.408652	2020-03-23 17:08:55.408652
3466	Nakasongola	73	231	2020-03-23 17:08:55.410799	2020-03-23 17:08:55.410799
3467	Sembabule	74	231	2020-03-23 17:08:55.413628	2020-03-23 17:08:55.413628
3468	Kaberamaido	80	231	2020-03-23 17:08:55.415935	2020-03-23 17:08:55.415935
3469	Kamwenge	81	231	2020-03-23 17:08:55.417754	2020-03-23 17:08:55.417754
3470	Kanungu	82	231	2020-03-23 17:08:55.420081	2020-03-23 17:08:55.420081
3471	Kayunga	83	231	2020-03-23 17:08:55.42253	2020-03-23 17:08:55.42253
3472	Kyenjojo	85	231	2020-03-23 17:08:55.42442	2020-03-23 17:08:55.42442
3473	Mayuge	86	231	2020-03-23 17:08:55.426748	2020-03-23 17:08:55.426748
3474	Nakapiripirit	91	231	2020-03-23 17:08:55.42874	2020-03-23 17:08:55.42874
3475	Pader	92	231	2020-03-23 17:08:55.431033	2020-03-23 17:08:55.431033
3476	Sironko	94	231	2020-03-23 17:08:55.433465	2020-03-23 17:08:55.433465
3477	Wakiso	96	231	2020-03-23 17:08:55.43613	2020-03-23 17:08:55.43613
3478	Yumbe	97	231	2020-03-23 17:08:55.438886	2020-03-23 17:08:55.438886
3479	Abim	B6	231	2020-03-23 17:08:55.441257	2020-03-23 17:08:55.441257
3480	Amolatar	B7	231	2020-03-23 17:08:55.444158	2020-03-23 17:08:55.444158
3481	Amuria	B8	231	2020-03-23 17:08:55.446933	2020-03-23 17:08:55.446933
3482	Amuru	B9	231	2020-03-23 17:08:55.449533	2020-03-23 17:08:55.449533
3483	Budaka	C1	231	2020-03-23 17:08:55.451312	2020-03-23 17:08:55.451312
3484	Bududa	C2	231	2020-03-23 17:08:55.45436	2020-03-23 17:08:55.45436
3485	Bulisa	C5	231	2020-03-23 17:08:55.456985	2020-03-23 17:08:55.456985
3486	Butaleja	C6	231	2020-03-23 17:08:55.459417	2020-03-23 17:08:55.459417
3487	Dokolo	C7	231	2020-03-23 17:08:55.462088	2020-03-23 17:08:55.462088
3488	Ibanda	C8	231	2020-03-23 17:08:55.464576	2020-03-23 17:08:55.464576
3489	Isingiro	C9	231	2020-03-23 17:08:55.466984	2020-03-23 17:08:55.466984
3490	Kaabong	D1	231	2020-03-23 17:08:55.468933	2020-03-23 17:08:55.468933
3491	Kaliro	D2	231	2020-03-23 17:08:55.471047	2020-03-23 17:08:55.471047
3492	Kiruhura	D3	231	2020-03-23 17:08:55.473511	2020-03-23 17:08:55.473511
3493	Koboko	D4	231	2020-03-23 17:08:55.475477	2020-03-23 17:08:55.475477
3494	Lyantonde	D5	231	2020-03-23 17:08:55.477555	2020-03-23 17:08:55.477555
3495	Manafwa	D6	231	2020-03-23 17:08:55.479916	2020-03-23 17:08:55.479916
3496	Maracha	D7	231	2020-03-23 17:08:55.481862	2020-03-23 17:08:55.481862
3497	Mityana	D8	231	2020-03-23 17:08:55.484096	2020-03-23 17:08:55.484096
3498	Nakaseke	D9	231	2020-03-23 17:08:55.486678	2020-03-23 17:08:55.486678
3499	Oyam	E2	231	2020-03-23 17:08:55.489119	2020-03-23 17:08:55.489119
3500	Bukwa	C4	231	2020-03-23 17:08:55.49184	2020-03-23 17:08:55.49184
3501	Wake Island	450	232	2020-03-23 17:08:55.494439	2020-03-23 17:08:55.494439
3502	Navassa Island	350	232	2020-03-23 17:08:55.496751	2020-03-23 17:08:55.496751
3503	Baker Island	050	232	2020-03-23 17:08:55.498673	2020-03-23 17:08:55.498673
3504	Howland Island	100	232	2020-03-23 17:08:55.500915	2020-03-23 17:08:55.500915
3505	Jarvis Island	150	232	2020-03-23 17:08:55.503258	2020-03-23 17:08:55.503258
3506	Johnston Atoll	200	232	2020-03-23 17:08:55.505513	2020-03-23 17:08:55.505513
3507	Kingman Reef	250	232	2020-03-23 17:08:55.508309	2020-03-23 17:08:55.508309
3508	Midway Islands	300	232	2020-03-23 17:08:55.512324	2020-03-23 17:08:55.512324
3509	Palmyra Atoll	400	232	2020-03-23 17:08:55.514647	2020-03-23 17:08:55.514647
3510	Arkansas	AR	233	2020-03-23 17:08:55.51675	2020-03-23 17:08:55.51675
3511	Washington, D.C.	DC	233	2020-03-23 17:08:55.518923	2020-03-23 17:08:55.518923
3512	Delaware	DE	233	2020-03-23 17:08:55.521297	2020-03-23 17:08:55.521297
3513	Florida	FL	233	2020-03-23 17:08:55.523736	2020-03-23 17:08:55.523736
3514	Georgia	GA	233	2020-03-23 17:08:55.526142	2020-03-23 17:08:55.526142
3515	Kansas	KS	233	2020-03-23 17:08:55.529046	2020-03-23 17:08:55.529046
3516	Louisiana	LA	233	2020-03-23 17:08:55.534667	2020-03-23 17:08:55.534667
3517	Maryland	MD	233	2020-03-23 17:08:55.536577	2020-03-23 17:08:55.536577
3518	Missouri	MO	233	2020-03-23 17:08:55.538656	2020-03-23 17:08:55.538656
3519	Mississippi	MS	233	2020-03-23 17:08:55.540904	2020-03-23 17:08:55.540904
3520	North Carolina	NC	233	2020-03-23 17:08:55.542872	2020-03-23 17:08:55.542872
3521	Oklahoma	OK	233	2020-03-23 17:08:55.544857	2020-03-23 17:08:55.544857
3522	South Carolina	SC	233	2020-03-23 17:08:55.547068	2020-03-23 17:08:55.547068
3523	Tennessee	TN	233	2020-03-23 17:08:55.550313	2020-03-23 17:08:55.550313
3524	Texas	TX	233	2020-03-23 17:08:55.552402	2020-03-23 17:08:55.552402
3525	West Virginia	WV	233	2020-03-23 17:08:55.554175	2020-03-23 17:08:55.554175
3526	Alabama	AL	233	2020-03-23 17:08:55.556089	2020-03-23 17:08:55.556089
3527	Connecticut	CT	233	2020-03-23 17:08:55.558209	2020-03-23 17:08:55.558209
3528	Iowa	IA	233	2020-03-23 17:08:55.559878	2020-03-23 17:08:55.559878
3529	Illinois	IL	233	2020-03-23 17:08:55.561774	2020-03-23 17:08:55.561774
3530	Indiana	IN	233	2020-03-23 17:08:55.563677	2020-03-23 17:08:55.563677
3531	Maine	ME	233	2020-03-23 17:08:55.565806	2020-03-23 17:08:55.565806
3532	Michigan	MI	233	2020-03-23 17:08:55.56754	2020-03-23 17:08:55.56754
3533	Minnesota	MN	233	2020-03-23 17:08:55.56936	2020-03-23 17:08:55.56936
3534	Nebraska	NE	233	2020-03-23 17:08:55.57116	2020-03-23 17:08:55.57116
3535	New Hampshire	NH	233	2020-03-23 17:08:55.57324	2020-03-23 17:08:55.57324
3536	New Jersey	NJ	233	2020-03-23 17:08:55.574974	2020-03-23 17:08:55.574974
3537	New York	NY	233	2020-03-23 17:08:55.576757	2020-03-23 17:08:55.576757
3538	Ohio	OH	233	2020-03-23 17:08:55.578666	2020-03-23 17:08:55.578666
3539	Rhode Island	RI	233	2020-03-23 17:08:55.58062	2020-03-23 17:08:55.58062
3540	Vermont	VT	233	2020-03-23 17:08:55.582286	2020-03-23 17:08:55.582286
3541	Wisconsin	WI	233	2020-03-23 17:08:55.584082	2020-03-23 17:08:55.584082
3542	California	CA	233	2020-03-23 17:08:55.586124	2020-03-23 17:08:55.586124
3543	Colorado	CO	233	2020-03-23 17:08:55.58806	2020-03-23 17:08:55.58806
3544	New Mexico	NM	233	2020-03-23 17:08:55.590065	2020-03-23 17:08:55.590065
3545	Nevada	NV	233	2020-03-23 17:08:55.591898	2020-03-23 17:08:55.591898
3546	Utah	UT	233	2020-03-23 17:08:55.593621	2020-03-23 17:08:55.593621
3547	Arizona	AZ	233	2020-03-23 17:08:55.595424	2020-03-23 17:08:55.595424
3548	Idaho	ID	233	2020-03-23 17:08:55.597618	2020-03-23 17:08:55.597618
3549	Montana	MT	233	2020-03-23 17:08:55.59942	2020-03-23 17:08:55.59942
3550	North Dakota	ND	233	2020-03-23 17:08:55.601393	2020-03-23 17:08:55.601393
3551	Oregon	OR	233	2020-03-23 17:08:55.603569	2020-03-23 17:08:55.603569
3552	South Dakota	SD	233	2020-03-23 17:08:55.60532	2020-03-23 17:08:55.60532
3553	Washington	WA	233	2020-03-23 17:08:55.606849	2020-03-23 17:08:55.606849
3554	Wyoming	WY	233	2020-03-23 17:08:55.608396	2020-03-23 17:08:55.608396
3555	Hawaii	HI	233	2020-03-23 17:08:55.611301	2020-03-23 17:08:55.611301
3556	Alaska	AK	233	2020-03-23 17:08:55.613601	2020-03-23 17:08:55.613601
3557	Kentucky	KY	233	2020-03-23 17:08:55.61547	2020-03-23 17:08:55.61547
3558	Massachusetts	MA	233	2020-03-23 17:08:55.617332	2020-03-23 17:08:55.617332
3559	Pennsylvania	PA	233	2020-03-23 17:08:55.61918	2020-03-23 17:08:55.61918
3560	Virginia	VA	233	2020-03-23 17:08:55.620916	2020-03-23 17:08:55.620916
3561	Treinta y Tres	19	234	2020-03-23 17:08:55.622457	2020-03-23 17:08:55.622457
3562	Tacuarembó	18	234	2020-03-23 17:08:55.624013	2020-03-23 17:08:55.624013
3563	Soriano	17	234	2020-03-23 17:08:55.625712	2020-03-23 17:08:55.625712
3564	San José	16	234	2020-03-23 17:08:55.62736	2020-03-23 17:08:55.62736
3565	Salto	15	234	2020-03-23 17:08:55.628964	2020-03-23 17:08:55.628964
3566	Rocha	14	234	2020-03-23 17:08:55.630685	2020-03-23 17:08:55.630685
3567	Rivera	13	234	2020-03-23 17:08:55.633287	2020-03-23 17:08:55.633287
3568	Río Negro	12	234	2020-03-23 17:08:55.635118	2020-03-23 17:08:55.635118
3569	Paysandú	11	234	2020-03-23 17:08:55.636863	2020-03-23 17:08:55.636863
3570	Montevideo	10	234	2020-03-23 17:08:55.638537	2020-03-23 17:08:55.638537
3571	Maldonado	09	234	2020-03-23 17:08:55.640158	2020-03-23 17:08:55.640158
3572	Lavalleja	08	234	2020-03-23 17:08:55.641665	2020-03-23 17:08:55.641665
3573	Florida	07	234	2020-03-23 17:08:55.643296	2020-03-23 17:08:55.643296
3574	Flores	06	234	2020-03-23 17:08:55.645104	2020-03-23 17:08:55.645104
3575	Durazno	05	234	2020-03-23 17:08:55.646822	2020-03-23 17:08:55.646822
3576	Colonia	04	234	2020-03-23 17:08:55.648584	2020-03-23 17:08:55.648584
3577	Cerro Largo	03	234	2020-03-23 17:08:55.651172	2020-03-23 17:08:55.651172
3578	Canelones	02	234	2020-03-23 17:08:55.653956	2020-03-23 17:08:55.653956
3579	Artigas	01	234	2020-03-23 17:08:55.655565	2020-03-23 17:08:55.655565
3580	Karakalpakstan	09	235	2020-03-23 17:08:55.657027	2020-03-23 17:08:55.657027
3581	Surxondaryo	12	235	2020-03-23 17:08:55.658816	2020-03-23 17:08:55.658816
3582	Samarqand	10	235	2020-03-23 17:08:55.660702	2020-03-23 17:08:55.660702
3583	Qashqadaryo	08	235	2020-03-23 17:08:55.662725	2020-03-23 17:08:55.662725
3584	Buxoro	02	235	2020-03-23 17:08:55.664561	2020-03-23 17:08:55.664561
3585	Toshkent	14	235	2020-03-23 17:08:55.666378	2020-03-23 17:08:55.666378
3586	Toshkent Shahri	13	235	2020-03-23 17:08:55.668119	2020-03-23 17:08:55.668119
3587	Sirdaryo	16	235	2020-03-23 17:08:55.669918	2020-03-23 17:08:55.669918
3588	Navoiy	07	235	2020-03-23 17:08:55.671484	2020-03-23 17:08:55.671484
3589	Namangan	06	235	2020-03-23 17:08:55.673644	2020-03-23 17:08:55.673644
3590	Xorazm	05	235	2020-03-23 17:08:55.675142	2020-03-23 17:08:55.675142
3591	Jizzax	15	235	2020-03-23 17:08:55.676922	2020-03-23 17:08:55.676922
3592	Farg ona	03	235	2020-03-23 17:08:55.678426	2020-03-23 17:08:55.678426
3593	Andijon	01	235	2020-03-23 17:08:55.680071	2020-03-23 17:08:55.680071
3594	Saint Patrick	05	237	2020-03-23 17:08:55.681613	2020-03-23 17:08:55.681613
3595	Saint George	04	237	2020-03-23 17:08:55.683216	2020-03-23 17:08:55.683216
3596	Saint David	03	237	2020-03-23 17:08:55.68494	2020-03-23 17:08:55.68494
3597	Saint Andrew	02	237	2020-03-23 17:08:55.686599	2020-03-23 17:08:55.686599
3598	Grenadines	06	237	2020-03-23 17:08:55.688065	2020-03-23 17:08:55.688065
3599	Charlotte	01	237	2020-03-23 17:08:55.689511	2020-03-23 17:08:55.689511
3600	Zulia	23	238	2020-03-23 17:08:55.691389	2020-03-23 17:08:55.691389
3601	Yaracuy	22	238	2020-03-23 17:08:55.693446	2020-03-23 17:08:55.693446
3602	Trujillo	21	238	2020-03-23 17:08:55.695068	2020-03-23 17:08:55.695068
3603	Táchira	20	238	2020-03-23 17:08:55.696543	2020-03-23 17:08:55.696543
3604	Sucre	19	238	2020-03-23 17:08:55.698053	2020-03-23 17:08:55.698053
3605	Portuguesa	18	238	2020-03-23 17:08:55.69975	2020-03-23 17:08:55.69975
3606	Isla Margarita	17	238	2020-03-23 17:08:55.701578	2020-03-23 17:08:55.701578
3607	Monagas	16	238	2020-03-23 17:08:55.703155	2020-03-23 17:08:55.703155
3608	Miranda	15	238	2020-03-23 17:08:55.704677	2020-03-23 17:08:55.704677
3609	Mérida	14	238	2020-03-23 17:08:55.70674	2020-03-23 17:08:55.70674
3610	Lara	13	238	2020-03-23 17:08:55.708488	2020-03-23 17:08:55.708488
3611	Guárico	12	238	2020-03-23 17:08:55.710363	2020-03-23 17:08:55.710363
3612	Dependencias Federales	24	238	2020-03-23 17:08:55.712305	2020-03-23 17:08:55.712305
3613	Distrito Capital	25	238	2020-03-23 17:08:55.713966	2020-03-23 17:08:55.713966
3614	Falcón	11	238	2020-03-23 17:08:55.715601	2020-03-23 17:08:55.715601
3615	Delta Amacuro	09	238	2020-03-23 17:08:55.717198	2020-03-23 17:08:55.717198
3616	Cojedes	08	238	2020-03-23 17:08:55.719093	2020-03-23 17:08:55.719093
3617	Carabobo	07	238	2020-03-23 17:08:55.720524	2020-03-23 17:08:55.720524
3618	Bolívar	06	238	2020-03-23 17:08:55.722177	2020-03-23 17:08:55.722177
3619	Barinas	05	238	2020-03-23 17:08:55.72389	2020-03-23 17:08:55.72389
3620	Aragua	04	238	2020-03-23 17:08:55.725766	2020-03-23 17:08:55.725766
3621	Apure	03	238	2020-03-23 17:08:55.727499	2020-03-23 17:08:55.727499
3622	Anzoátegui	02	238	2020-03-23 17:08:55.729584	2020-03-23 17:08:55.729584
3623	Amazonas	01	238	2020-03-23 17:08:55.731204	2020-03-23 17:08:55.731204
3624	Vargas	26	238	2020-03-23 17:08:55.733522	2020-03-23 17:08:55.733522
3625	Saint Croix Island	010	240	2020-03-23 17:08:55.736151	2020-03-23 17:08:55.736151
3626	Saint John Island	020	240	2020-03-23 17:08:55.738321	2020-03-23 17:08:55.738321
3627	Saint Thomas Island	030	240	2020-03-23 17:08:55.739946	2020-03-23 17:08:55.739946
3628	Nghệ An	58	241	2020-03-23 17:08:55.741689	2020-03-23 17:08:55.741689
3629	Ninh Bình	59	241	2020-03-23 17:08:55.74333	2020-03-23 17:08:55.74333
3630	Ninh Thuận	60	241	2020-03-23 17:08:55.745217	2020-03-23 17:08:55.745217
3631	Sóc Trăng	65	241	2020-03-23 17:08:55.748655	2020-03-23 17:08:55.748655
3632	Trà Vinh	67	241	2020-03-23 17:08:55.750555	2020-03-23 17:08:55.750555
3633	Tuyên Quang	68	241	2020-03-23 17:08:55.752869	2020-03-23 17:08:55.752869
3634	Vĩnh Long	69	241	2020-03-23 17:08:55.754467	2020-03-23 17:08:55.754467
3635	Yên Bái	70	241	2020-03-23 17:08:55.756089	2020-03-23 17:08:55.756089
3636	Lào Cai	90	241	2020-03-23 17:08:55.75825	2020-03-23 17:08:55.75825
3637	Tiền Giang	37	241	2020-03-23 17:08:55.759857	2020-03-23 17:08:55.759857
3638	Thừa Thiên-Huế	66	241	2020-03-23 17:08:55.761777	2020-03-23 17:08:55.761777
3639	Kon Tum	55	241	2020-03-23 17:08:55.763886	2020-03-23 17:08:55.763886
3640	Thanh Hóa	34	241	2020-03-23 17:08:55.765881	2020-03-23 17:08:55.765881
3641	Thái Bình	35	241	2020-03-23 17:08:55.767927	2020-03-23 17:08:55.767927
3642	Tây Ninh	33	241	2020-03-23 17:08:55.770031	2020-03-23 17:08:55.770031
3643	Sơn La	32	241	2020-03-23 17:08:55.772768	2020-03-23 17:08:55.772768
3644	Quảng Trị	64	241	2020-03-23 17:08:55.7748	2020-03-23 17:08:55.7748
3645	Quảng Ninh	30	241	2020-03-23 17:08:55.776422	2020-03-23 17:08:55.776422
3646	Quảng Ngãi	63	241	2020-03-23 17:08:55.778349	2020-03-23 17:08:55.778349
3647	Quảng Bình	62	241	2020-03-23 17:08:55.781063	2020-03-23 17:08:55.781063
3648	Phú Yên	61	241	2020-03-23 17:08:55.784109	2020-03-23 17:08:55.784109
3649	Hoa Bình	53	241	2020-03-23 17:08:55.785957	2020-03-23 17:08:55.785957
3650	Long An	24	241	2020-03-23 17:08:55.787801	2020-03-23 17:08:55.787801
3651	Lạng Sơn	39	241	2020-03-23 17:08:55.789679	2020-03-23 17:08:55.789679
3652	Lâm Ðồng	23	241	2020-03-23 17:08:55.791445	2020-03-23 17:08:55.791445
3653	Lai Châu	89	241	2020-03-23 17:08:55.793554	2020-03-23 17:08:55.793554
3654	Kiến Giang	21	241	2020-03-23 17:08:55.795382	2020-03-23 17:08:55.795382
3655	Khánh Hoa	54	241	2020-03-23 17:08:55.79725	2020-03-23 17:08:55.79725
3656	Hồ Chí Minh	20	241	2020-03-23 17:08:55.799063	2020-03-23 17:08:55.799063
3657	Hà Tĩnh	52	241	2020-03-23 17:08:55.80123	2020-03-23 17:08:55.80123
3658	Hà Tây	51	241	2020-03-23 17:08:55.80494	2020-03-23 17:08:55.80494
3659	Hà Giang	50	241	2020-03-23 17:08:55.806772	2020-03-23 17:08:55.806772
3660	Gia Lai	49	241	2020-03-23 17:08:55.808944	2020-03-23 17:08:55.808944
3661	Ha Nội	44	241	2020-03-23 17:08:55.811493	2020-03-23 17:08:55.811493
3662	Cần Thơ	87	241	2020-03-23 17:08:55.813702	2020-03-23 17:08:55.813702
3663	Hải Phong	13	241	2020-03-23 17:08:55.815265	2020-03-23 17:08:55.815265
3664	Bình Thuận	47	241	2020-03-23 17:08:55.817018	2020-03-23 17:08:55.817018
3665	Ðồng Tháp	09	241	2020-03-23 17:08:55.81866	2020-03-23 17:08:55.81866
3666	Ðồng Nai	43	241	2020-03-23 17:08:55.820113	2020-03-23 17:08:55.820113
3667	Ðắc Lắk	88	241	2020-03-23 17:08:55.821533	2020-03-23 17:08:55.821533
3668	Bà Rịa-Vũng Tàu	45	241	2020-03-23 17:08:55.823181	2020-03-23 17:08:55.823181
3669	Cao Bằng	05	241	2020-03-23 17:08:55.824623	2020-03-23 17:08:55.824623
3670	Bình Ðịnh	46	241	2020-03-23 17:08:55.826138	2020-03-23 17:08:55.826138
3671	Bến Tre	03	241	2020-03-23 17:08:55.827783	2020-03-23 17:08:55.827783
3672	An Giang	01	241	2020-03-23 17:08:55.829372	2020-03-23 17:08:55.829372
3673	Ðắk Nông	91	241	2020-03-23 17:08:55.831057	2020-03-23 17:08:55.831057
3674	Huyện Ðiện Biên	92	241	2020-03-23 17:08:55.833012	2020-03-23 17:08:55.833012
3675	Bắc Ninh	74	241	2020-03-23 17:08:55.834794	2020-03-23 17:08:55.834794
3676	Bắc Giang	71	241	2020-03-23 17:08:55.837487	2020-03-23 17:08:55.837487
3677	Ðà Nẵng	78	241	2020-03-23 17:08:55.841493	2020-03-23 17:08:55.841493
3678	Bình Dương	75	241	2020-03-23 17:08:55.84413	2020-03-23 17:08:55.84413
3679	Bình Phước	76	241	2020-03-23 17:08:55.846335	2020-03-23 17:08:55.846335
3680	Thái Nguyên	85	241	2020-03-23 17:08:55.847891	2020-03-23 17:08:55.847891
3681	Quảng Nam	84	241	2020-03-23 17:08:55.849342	2020-03-23 17:08:55.849342
3682	Phú Thọ	83	241	2020-03-23 17:08:55.851078	2020-03-23 17:08:55.851078
3683	Nam Ðịnh	82	241	2020-03-23 17:08:55.853361	2020-03-23 17:08:55.853361
3684	Hà Nam	80	241	2020-03-23 17:08:55.855067	2020-03-23 17:08:55.855067
3685	Bắc Kạn	72	241	2020-03-23 17:08:55.857027	2020-03-23 17:08:55.857027
3686	Bạc Liêu	73	241	2020-03-23 17:08:55.858841	2020-03-23 17:08:55.858841
3687	Cà Mau	77	241	2020-03-23 17:08:55.860658	2020-03-23 17:08:55.860658
3688	Hải Dương	79	241	2020-03-23 17:08:55.862313	2020-03-23 17:08:55.862313
3689	Hưng Yên	81	241	2020-03-23 17:08:55.864443	2020-03-23 17:08:55.864443
3690	Vĩnh Phúc	86	241	2020-03-23 17:08:55.86633	2020-03-23 17:08:55.86633
3691	Hau Giang	93	241	2020-03-23 17:08:55.868173	2020-03-23 17:08:55.868173
3692	Tafea	15	242	2020-03-23 17:08:55.870099	2020-03-23 17:08:55.870099
3693	Sanma	13	242	2020-03-23 17:08:55.872203	2020-03-23 17:08:55.872203
3694	Torba	07	242	2020-03-23 17:08:55.87418	2020-03-23 17:08:55.87418
3695	Malampa	16	242	2020-03-23 17:08:55.876036	2020-03-23 17:08:55.876036
3696	Penama	17	242	2020-03-23 17:08:55.87752	2020-03-23 17:08:55.87752
3697	Shefa	18	242	2020-03-23 17:08:55.879228	2020-03-23 17:08:55.879228
3698	Circonscription d'Uvéa	98613	243	2020-03-23 17:08:55.880699	2020-03-23 17:08:55.880699
3699	Circonscription de Sigavé	98612	243	2020-03-23 17:08:55.882362	2020-03-23 17:08:55.882362
3700	Circonscription d'Alo	98611	243	2020-03-23 17:08:55.88405	2020-03-23 17:08:55.88405
3701	Vaisigano	11	244	2020-03-23 17:08:55.885744	2020-03-23 17:08:55.885744
3702	Va`a-o-Fonoti	06	244	2020-03-23 17:08:55.887438	2020-03-23 17:08:55.887438
3703	Tuamasaga	10	244	2020-03-23 17:08:55.890005	2020-03-23 17:08:55.890005
3704	Satupa`itea	09	244	2020-03-23 17:08:55.892224	2020-03-23 17:08:55.892224
3705	Palauli	08	244	2020-03-23 17:08:55.894187	2020-03-23 17:08:55.894187
3706	Gagaifomauga	07	244	2020-03-23 17:08:55.895833	2020-03-23 17:08:55.895833
3707	Gaga`emauga	05	244	2020-03-23 17:08:55.897594	2020-03-23 17:08:55.897594
3708	Fa`asaleleaga	04	244	2020-03-23 17:08:55.899495	2020-03-23 17:08:55.899495
3709	Atua	03	244	2020-03-23 17:08:55.901309	2020-03-23 17:08:55.901309
3710	Aiga-i-le-Tai	02	244	2020-03-23 17:08:55.902845	2020-03-23 17:08:55.902845
3711	A`ana	01	244	2020-03-23 17:08:55.904342	2020-03-23 17:08:55.904342
3712	Opština Vučitrn	28	123	2020-03-23 17:08:55.906097	2020-03-23 17:08:55.906097
3713	Komuna e Vitisë	27	123	2020-03-23 17:08:55.907657	2020-03-23 17:08:55.907657
3714	Komuna e Ferizajt	03	123	2020-03-23 17:08:55.909265	2020-03-23 17:08:55.909265
3715	Komuna e Mitrovicës	15	123	2020-03-23 17:08:55.910964	2020-03-23 17:08:55.910964
3716	Komuna e Thërandës	26	123	2020-03-23 17:08:55.913352	2020-03-23 17:08:55.913352
3717	Komuna e Skenderajt	25	123	2020-03-23 17:08:55.914886	2020-03-23 17:08:55.914886
3718	Komuna e Prizrenit	21	123	2020-03-23 17:08:55.916457	2020-03-23 17:08:55.916457
3719	Komuna e Prishtinës	20	123	2020-03-23 17:08:55.917876	2020-03-23 17:08:55.917876
3720	Opština Podujevo	19	123	2020-03-23 17:08:55.919122	2020-03-23 17:08:55.919122
3721	Komuna e Pejës	18	123	2020-03-23 17:08:55.920429	2020-03-23 17:08:55.920429
3722	Komuna e Rahovecit	22	123	2020-03-23 17:08:55.921753	2020-03-23 17:08:55.921753
3723	Komuna e Lipjanit	13	123	2020-03-23 17:08:55.923064	2020-03-23 17:08:55.923064
3724	Komuna e Leposaviqit	12	123	2020-03-23 17:08:55.924354	2020-03-23 17:08:55.924354
3725	Opština Kamenica	10	123	2020-03-23 17:08:55.925717	2020-03-23 17:08:55.925717
3726	Opština Klina	11	123	2020-03-23 17:08:55.927004	2020-03-23 17:08:55.927004
3727	Komuna e Kaçanikut	09	123	2020-03-23 17:08:55.928298	2020-03-23 17:08:55.928298
3728	Komuna e Istogut	08	123	2020-03-23 17:08:55.929617	2020-03-23 17:08:55.929617
3729	Komuna e Gjilanit	06	123	2020-03-23 17:08:55.930906	2020-03-23 17:08:55.930906
3730	Komuna e Drenasit	07	123	2020-03-23 17:08:55.932698	2020-03-23 17:08:55.932698
3731	Komuna e Dragashit	02	123	2020-03-23 17:08:55.934187	2020-03-23 17:08:55.934187
3732	Komuna e Deçanit	01	123	2020-03-23 17:08:55.935599	2020-03-23 17:08:55.935599
3733	Komuna e Gjakovës	05	123	2020-03-23 17:08:55.93693	2020-03-23 17:08:55.93693
3734	Opština Kosovo Polje	04	123	2020-03-23 17:08:55.938287	2020-03-23 17:08:55.938287
3735	Opština Štrpce	23	123	2020-03-23 17:08:55.939589	2020-03-23 17:08:55.939589
3736	Komuna e Shtimes	24	123	2020-03-23 17:08:55.941061	2020-03-23 17:08:55.941061
3737	Opština Novo Brdo	16	123	2020-03-23 17:08:55.942439	2020-03-23 17:08:55.942439
3738	Komuna e Obiliqit	17	123	2020-03-23 17:08:55.943667	2020-03-23 17:08:55.943667
3739	Komuna e Malisheves	14	123	2020-03-23 17:08:55.944978	2020-03-23 17:08:55.944978
3740	Komuna e Zubin Potokut	29	123	2020-03-23 17:08:55.946386	2020-03-23 17:08:55.946386
3741	Opština Zvečan	30	123	2020-03-23 17:08:55.947677	2020-03-23 17:08:55.947677
3742	Muḩāfaz̧at Ta‘izz	25	245	2020-03-23 17:08:55.949038	2020-03-23 17:08:55.949038
3743	Muḩāfaz̧at Shabwah	05	245	2020-03-23 17:08:55.950365	2020-03-23 17:08:55.950365
3744	Sanaa	16	245	2020-03-23 17:08:55.951801	2020-03-23 17:08:55.951801
3745	Muḩāfaz̧at Şa‘dah	15	245	2020-03-23 17:08:55.953507	2020-03-23 17:08:55.953507
3746	Muḩāfaz̧at Raymah	27	245	2020-03-23 17:08:55.954835	2020-03-23 17:08:55.954835
3747	Muḩāfaz̧at Ma’rib	14	245	2020-03-23 17:08:55.956129	2020-03-23 17:08:55.956129
3748	Al Maḩwīt	10	245	2020-03-23 17:08:55.957443	2020-03-23 17:08:55.957443
3749	Muḩāfaz̧at al Jawf	21	245	2020-03-23 17:08:55.95876	2020-03-23 17:08:55.95876
3750	Ḩaḑramawt	04	245	2020-03-23 17:08:55.960073	2020-03-23 17:08:55.960073
3751	Muḩāfaz̧at Dhamār	11	245	2020-03-23 17:08:55.961349	2020-03-23 17:08:55.961349
3752	Al Mahrah	03	245	2020-03-23 17:08:55.962883	2020-03-23 17:08:55.962883
3753	Al Ḩudaydah	08	245	2020-03-23 17:08:55.964575	2020-03-23 17:08:55.964575
3754	Al Bayḑāʼ	20	245	2020-03-23 17:08:55.965978	2020-03-23 17:08:55.965978
3755	Aden	02	245	2020-03-23 17:08:55.967418	2020-03-23 17:08:55.967418
3756	Abyan	01	245	2020-03-23 17:08:55.96894	2020-03-23 17:08:55.96894
3757	Muḩāfaz̧at aḑ Ḑāli‘	18	245	2020-03-23 17:08:55.970441	2020-03-23 17:08:55.970441
3758	Omran	19	245	2020-03-23 17:08:55.972962	2020-03-23 17:08:55.972962
3759	Muḩāfaz̧at Ḩajjah	22	245	2020-03-23 17:08:55.974964	2020-03-23 17:08:55.974964
3760	Muḩāfaz̧at Ibb	23	245	2020-03-23 17:08:55.976417	2020-03-23 17:08:55.976417
3761	Muḩāfaz̧at Laḩij	24	245	2020-03-23 17:08:55.977848	2020-03-23 17:08:55.977848
3762	Amanat Al Asimah	26	245	2020-03-23 17:08:55.979338	2020-03-23 17:08:55.979338
3763	Acoua	97601	246	2020-03-23 17:08:55.981278	2020-03-23 17:08:55.981278
3764	Bandraboua	97602	246	2020-03-23 17:08:55.983481	2020-03-23 17:08:55.983481
3765	Bandrele	97603	246	2020-03-23 17:08:55.985041	2020-03-23 17:08:55.985041
3766	Bouéni	97604	246	2020-03-23 17:08:55.986402	2020-03-23 17:08:55.986402
3767	Chiconi	97605	246	2020-03-23 17:08:55.987736	2020-03-23 17:08:55.987736
3768	Chirongui	97606	246	2020-03-23 17:08:55.989056	2020-03-23 17:08:55.989056
3769	Dembeni	97607	246	2020-03-23 17:08:55.99049	2020-03-23 17:08:55.99049
3770	Dzaoudzi	97608	246	2020-03-23 17:08:55.992979	2020-03-23 17:08:55.992979
3771	Kani-Kéli	97609	246	2020-03-23 17:08:55.995106	2020-03-23 17:08:55.995106
3772	Koungou	97610	246	2020-03-23 17:08:55.996445	2020-03-23 17:08:55.996445
3773	Mamoudzou	97611	246	2020-03-23 17:08:55.998208	2020-03-23 17:08:55.998208
3774	Mtsamboro	97612	246	2020-03-23 17:08:56.000044	2020-03-23 17:08:56.000044
3775	M'Tsangamouji	97613	246	2020-03-23 17:08:56.001836	2020-03-23 17:08:56.001836
3776	Ouangani	97614	246	2020-03-23 17:08:56.003553	2020-03-23 17:08:56.003553
3777	Pamandzi	97615	246	2020-03-23 17:08:56.005169	2020-03-23 17:08:56.005169
3778	Sada	97616	246	2020-03-23 17:08:56.007047	2020-03-23 17:08:56.007047
3779	Tsingoni	97617	246	2020-03-23 17:08:56.008651	2020-03-23 17:08:56.008651
3780	Free State	03	247	2020-03-23 17:08:56.010369	2020-03-23 17:08:56.010369
3781	KwaZulu-Natal	02	247	2020-03-23 17:08:56.01228	2020-03-23 17:08:56.01228
3782	Eastern Cape	05	247	2020-03-23 17:08:56.014017	2020-03-23 17:08:56.014017
3783	Gauteng	06	247	2020-03-23 17:08:56.015663	2020-03-23 17:08:56.015663
3784	Mpumalanga	07	247	2020-03-23 17:08:56.017188	2020-03-23 17:08:56.017188
3785	Northern Cape	08	247	2020-03-23 17:08:56.01885	2020-03-23 17:08:56.01885
3786	Limpopo	09	247	2020-03-23 17:08:56.02045	2020-03-23 17:08:56.02045
3787	North-West	10	247	2020-03-23 17:08:56.021983	2020-03-23 17:08:56.021983
3788	Western Cape	11	247	2020-03-23 17:08:56.023455	2020-03-23 17:08:56.023455
3789	Western	01	248	2020-03-23 17:08:56.025036	2020-03-23 17:08:56.025036
3790	Southern	07	248	2020-03-23 17:08:56.026613	2020-03-23 17:08:56.026613
3791	North-Western	06	248	2020-03-23 17:08:56.028172	2020-03-23 17:08:56.028172
3792	Northern	05	248	2020-03-23 17:08:56.029733	2020-03-23 17:08:56.029733
3793	Lusaka	09	248	2020-03-23 17:08:56.031187	2020-03-23 17:08:56.031187
3794	Luapula	04	248	2020-03-23 17:08:56.033061	2020-03-23 17:08:56.033061
3795	Eastern	03	248	2020-03-23 17:08:56.034657	2020-03-23 17:08:56.034657
3796	Copperbelt	08	248	2020-03-23 17:08:56.036269	2020-03-23 17:08:56.036269
3797	Central	02	248	2020-03-23 17:08:56.038046	2020-03-23 17:08:56.038046
3798	Midlands	02	249	2020-03-23 17:08:56.04403	2020-03-23 17:08:56.04403
3799	Matabeleland South	07	249	2020-03-23 17:08:56.049171	2020-03-23 17:08:56.049171
3800	Matabeleland North	06	249	2020-03-23 17:08:56.056119	2020-03-23 17:08:56.056119
3801	Masvingo	08	249	2020-03-23 17:08:56.059332	2020-03-23 17:08:56.059332
3802	Mashonaland West Province	05	249	2020-03-23 17:08:56.061935	2020-03-23 17:08:56.061935
3803	Mashonaland East	04	249	2020-03-23 17:08:56.063905	2020-03-23 17:08:56.063905
3804	Mashonaland Central	03	249	2020-03-23 17:08:56.065647	2020-03-23 17:08:56.065647
3805	Manicaland	01	249	2020-03-23 17:08:56.067671	2020-03-23 17:08:56.067671
3806	Bulawayo	09	249	2020-03-23 17:08:56.069852	2020-03-23 17:08:56.069852
3807	Harare Province	10	249	2020-03-23 17:08:56.072483	2020-03-23 17:08:56.072483
\.


--
-- Data for Name: sub_matter_types; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.sub_matter_types (id, sub_matter_type, matter_type_id, created_at, updated_at) FROM stdin;
15	Sub 1 -  Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt	16	2020-03-23 13:01:14.955397	2020-03-23 13:01:14.955397
16	Sub 1 -  Corporate Governance / Gouvernance d'entreprise	17	2020-03-23 13:01:14.960427	2020-03-23 13:01:14.960427
17	Sub 1 -  Employment (non-action) / Recrutement (aucune intervention)	18	2020-03-23 13:01:14.965892	2020-03-23 13:01:14.965892
18	Sub 1 -  General Customer Inquiries / Questions générales de clients	19	2020-03-23 13:01:14.973018	2020-03-23 13:01:14.973018
19	Sub 1 -  Lending and Financing (inc. secured transactions and workouts) / Financement de prê	20	2020-03-23 13:01:14.977987	2020-03-23 13:01:14.977987
20	Sub 1 -  transactions garanties et les redressements)	21	2020-03-23 13:01:14.98161	2020-03-23 13:01:14.98161
21	Sub 1 -  Litigation / Litiges	22	2020-03-23 13:01:14.988101	2020-03-23 13:01:14.988101
22	Sub 1 -  Mergers & Acquisitions / Fusions et acquisitions	23	2020-03-23 13:01:14.992515	2020-03-23 13:01:14.992515
23	Sub 1 -  New Products / Nouveaux produits	24	2020-03-23 13:01:14.996792	2020-03-23 13:01:14.996792
24	Sub 1 -  Real Estate (non-lending) / Immobilier (autres que des prêts)	25	2020-03-23 13:01:15.0007	2020-03-23 13:01:15.0007
25	Sub 1 -  Regulatory / Réglementation	26	2020-03-23 13:01:15.005239	2020-03-23 13:01:15.005239
26	Sub 1 -  Tax / Fiscalité	27	2020-03-23 13:01:15.010782	2020-03-23 13:01:15.010782
27	Sub 1 -  Trademarks / Marques	28	2020-03-23 13:01:15.027254	2020-03-23 13:01:15.027254
28	Sub 1 -  Wills & Estates / Testaments/successions	29	2020-03-23 13:01:15.034462	2020-03-23 13:01:15.034462
29	Sub 2 -  Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt	16	2020-03-23 13:01:30.213295	2020-03-23 13:01:30.213295
30	Sub 2 -  Corporate Governance / Gouvernance d'entreprise	17	2020-03-23 13:01:30.218598	2020-03-23 13:01:30.218598
31	Sub 2 -  Employment (non-action) / Recrutement (aucune intervention)	18	2020-03-23 13:01:30.223036	2020-03-23 13:01:30.223036
32	Sub 2 -  General Customer Inquiries / Questions générales de clients	19	2020-03-23 13:01:30.233212	2020-03-23 13:01:30.233212
33	Sub 2 -  Lending and Financing (inc. secured transactions and workouts) / Financement de prê	20	2020-03-23 13:01:30.238713	2020-03-23 13:01:30.238713
34	Sub 2 -  transactions garanties et les redressements)	21	2020-03-23 13:01:30.246067	2020-03-23 13:01:30.246067
35	Sub 2 -  Litigation / Litiges	22	2020-03-23 13:01:30.249583	2020-03-23 13:01:30.249583
36	Sub 2 -  Mergers & Acquisitions / Fusions et acquisitions	23	2020-03-23 13:01:30.252353	2020-03-23 13:01:30.252353
37	Sub 2 -  New Products / Nouveaux produits	24	2020-03-23 13:01:30.257335	2020-03-23 13:01:30.257335
38	Sub 2 -  Real Estate (non-lending) / Immobilier (autres que des prêts)	25	2020-03-23 13:01:30.262519	2020-03-23 13:01:30.262519
39	Sub 2 -  Regulatory / Réglementation	26	2020-03-23 13:01:30.26766	2020-03-23 13:01:30.26766
40	Sub 2 -  Tax / Fiscalité	27	2020-03-23 13:01:30.27038	2020-03-23 13:01:30.27038
41	Sub 2 -  Trademarks / Marques	28	2020-03-23 13:01:30.273721	2020-03-23 13:01:30.273721
42	Sub 2 -  Wills & Estates / Testaments/successions	29	2020-03-23 13:01:30.277308	2020-03-23 13:01:30.277308
43	Sub 3 -  Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt	16	2020-03-23 13:01:34.543303	2020-03-23 13:01:34.543303
44	Sub 3 -  Corporate Governance / Gouvernance d'entreprise	17	2020-03-23 13:01:34.547644	2020-03-23 13:01:34.547644
45	Sub 3 -  Employment (non-action) / Recrutement (aucune intervention)	18	2020-03-23 13:01:34.55052	2020-03-23 13:01:34.55052
46	Sub 3 -  General Customer Inquiries / Questions générales de clients	19	2020-03-23 13:01:34.553526	2020-03-23 13:01:34.553526
47	Sub 3 -  Lending and Financing (inc. secured transactions and workouts) / Financement de prê	20	2020-03-23 13:01:34.55715	2020-03-23 13:01:34.55715
48	Sub 3 -  transactions garanties et les redressements)	21	2020-03-23 13:01:34.561614	2020-03-23 13:01:34.561614
49	Sub 3 -  Litigation / Litiges	22	2020-03-23 13:01:34.568714	2020-03-23 13:01:34.568714
50	Sub 3 -  Mergers & Acquisitions / Fusions et acquisitions	23	2020-03-23 13:01:34.571799	2020-03-23 13:01:34.571799
51	Sub 3 -  New Products / Nouveaux produits	24	2020-03-23 13:01:34.575848	2020-03-23 13:01:34.575848
52	Sub 3 -  Real Estate (non-lending) / Immobilier (autres que des prêts)	25	2020-03-23 13:01:34.580029	2020-03-23 13:01:34.580029
53	Sub 3 -  Regulatory / Réglementation	26	2020-03-23 13:01:34.583038	2020-03-23 13:01:34.583038
54	Sub 3 -  Tax / Fiscalité	27	2020-03-23 13:01:34.585978	2020-03-23 13:01:34.585978
55	Sub 3 -  Trademarks / Marques	28	2020-03-23 13:01:34.588835	2020-03-23 13:01:34.588835
56	Sub 3 -  Wills & Estates / Testaments/successions	29	2020-03-23 13:01:34.59178	2020-03-23 13:01:34.59178
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.system_settings (id, score_threshold, created_at, updated_at, docusign_access_token) FROM stdin;
1	\N	2020-02-03 15:21:31.904588	2020-02-03 15:21:31.906542	eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjY4MTg1ZmYxLTRlNTEtNGNlOS1hZjFjLTY4OTgxMjIwMzMxNyJ9.eyJUb2tlblR5cGUiOjUsIklzc3VlSW5zdGFudCI6MTU2OTk0NzI5NCwiZXhwIjoxNTY5OTc2MDk0LCJVc2VySWQiOiI5NzIwMWE0My0zNDZlLTQ2ZjItYWExZC0yNDUxMjlhZjcxZjAiLCJzaXRlaWQiOjEsInNjcCI6WyJzaWduYXR1cmUiLCJjbGljay5tYW5hZ2UiLCJvcmdhbml6YXRpb25fcmVhZCIsImdyb3VwX3JlYWQiLCJwZXJtaXNzaW9uX3JlYWQiLCJ1c2VyX3JlYWQiLCJ1c2VyX3dyaXRlIiwiYWNjb3VudF9yZWFkIiwiZG9tYWluX3JlYWQiLCJpZGVudGl0eV9wcm92aWRlcl9yZWFkIiwiZHRyLnJvb21zLnJlYWQiLCJkdHIucm9vbXMud3JpdGUiLCJkdHIuZG9jdW1lbnRzLnJlYWQiLCJkdHIuZG9jdW1lbnRzLndyaXRlIiwiZHRyLnByb2ZpbGUucmVhZCIsImR0ci5wcm9maWxlLndyaXRlIiwiZHRyLmNvbXBhbnkucmVhZCIsImR0ci5jb21wYW55LndyaXRlIl0sImF1ZCI6ImYwZjI3ZjBlLTg1N2QtNGE3MS1hNGRhLTMyY2VjYWUzYTk3OCIsImlzcyI6Imh0dHBzOi8vYWNjb3VudC1kLmRvY3VzaWduLmNvbS8iLCJzdWIiOiI5NzIwMWE0My0zNDZlLTQ2ZjItYWExZC0yNDUxMjlhZjcxZjAiLCJhbXIiOlsiaW50ZXJhY3RpdmUiXSwiYXV0aF90aW1lIjoxNTY5OTQ3MjkyLCJwd2lkIjoiZGY1ZDM1OGYtM2MwOC00ZmMyLWJiZGUtNGE5ZThjZmU3NjkxIn0.keCZYlqJdmLTa_vDve9_vySAI7QJJBizEBzLIVcgmw5wgxljtJHpkurseVPBJuG32fyGsSwsMTyzTvpEr9Lv4EPqU5hiFan-VXbtx32SfKcVpUc5SVdFqVFDtCzYtEPCCTEMKav5QibYa0SOrHi9h44UjbHNK-iWmbwb9T7X3mCPlrOZ4ZsklhplWfV17nfqlysR5d9KN8WFl-IYl6Zq0KSPzWS3GmXYZ-GvRYXZeIbeLhWMFTWrV_DlSkKJHYviW6NPHlcAsP__dX9QaPHfQ1RKWL-EB1aDk-cmqo6uH3w9Nin95jDUL7XAx5LJIs1Y-fNA7lfkFDvyqi5lOgXe3Q
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.technologies (id, vendor, platform, version, service_pack, supported, created_at, updated_at, platform_category, platform_type) FROM stdin;
\.


--
-- Data for Name: technology_values; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.technology_values (id, platform_category, platform_type, vendor, platform, version, service_pack, supported, created_at, updated_at, law_firm_id, form_submission_id, technology_id, checked) FROM stdin;
\.


--
-- Data for Name: third_party_vendors; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.third_party_vendors (id, form_value_id, vendor_name, area, confidentiality_agreement, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: todo_tasks; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.todo_tasks (id, law_firm_id, title, message, severity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: triggers; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.triggers (id, hours, action_type, message, severity_level_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.users (id, email, username, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, deactivated_at, otp_secret_key, google_secret, role, law_firm_id, new_password_set, qr_code_confirmed_at, first_name, last_name, line_of_business, lob_contact_name, two_fa_key, two_fa_key_expires_at) FROM stdin;
1	demolxp@mailinator.com	demo_lxp	$2a$11$0PxHvJGKqrY4WbxaCHY92O.NQUphvygVdXwy5zfSTU7Pdziz84VLa	\N	\N	\N	16	2020-03-25 08:30:37.725858	2020-03-24 16:53:42.991928	::1	::1	2020-02-03 15:21:31.632378	2020-03-25 08:30:37.737345	\N	\N	lhv57o2jj3hcg4ik	lxp	\N	t	\N	\N	\N	\N	\N	3C3FBD	2020-03-23 08:03:02.009424
5	ram@gmail.com	ram@gmail.com	$2a$11$r1n5ltaL5b4QJR6ATl8Pce2Behpa4y4fmQgwjSstvZBB8M80aC5V6	\N	\N	\N	3	2020-03-20 16:58:20.466897	2020-02-03 18:07:32.510248	::1	::1	2020-02-03 17:59:07.502753	2020-03-20 16:58:20.476556	\N	\N	5azkoora4ldfw7ea	master_user	2	t	\N	\N	\N	\N	\N	32933D	2020-03-20 16:59:20.475804
2	demolob@mailinator.com	demo_lob	$2a$11$DqUCkSfvR8bMMZlB9M4VBeqFZ6GXhzJqpi4GlBi8SvVDUHemX3BBW	\N	\N	\N	15	2020-04-01 15:59:18.267693	2020-04-01 12:27:44.216691	::1	::1	2020-02-03 15:21:31.753142	2020-04-01 15:59:18.268893	\N	\N	f62wssgfa4pzt55i	lob	\N	t	\N	\N	\N	\N	\N	FC4571	2020-03-23 10:57:17.469157
4	admin@gmail.com	admin@gmail.com	$2a$11$u3J2FAM0MHzGa527iv6lvexCc3P5.H1/3SsHM8lrS.Q8IEkRjH9Ma	\N	\N	\N	5	2020-04-01 16:20:41.092961	2020-04-01 15:57:03.068375	::1	::1	2020-02-03 17:53:11.225631	2020-04-01 16:20:41.101134	\N	\N	\N	superadmin	\N	t	\N	\N	\N	\N	\N	42EA9B	2020-02-03 18:07:18.951264
6	test123@gmail.com	test123@gmail.com	$2a$11$VYvaR4uUZAfHzo9BJdzbO.kCv9.4PLIuh5g8kjI531TxJfvBbXwD2	\N	\N	\N	0	\N	\N	\N	\N	2020-02-03 18:42:47.794976	2020-02-03 18:43:45.664404	2020-02-03 18:42:47.760852	\N	k6o3gzoxvc5jn7kg	master_user	4	f	\N	\N	\N	\N	\N	\N	\N
3	demolawyers@mailinator.com	demo_lawyers	$2a$11$n0tcDKU9.n56R.NELaeM2O.7oLiNo/2TrxSH8g8umbxfAgOVpj0zm	\N	\N	\N	4	2020-03-23 11:18:26.236018	2020-03-23 11:16:59.812873	::1	::1	2020-02-03 15:21:31.868143	2020-03-23 11:18:26.23701	\N	\N	\N	internal_lawyers	\N	f	\N	\N	\N	\N	\N	F4576B	2020-03-23 11:17:59.821252
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.vendors (id, name, vendor_type, application, form_value_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: manishchhipa1
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
\.


--
-- Name: action_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.action_items_id_seq', 1, false);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.active_admin_comments_id_seq', 1, false);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 5, true);


--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.activity_time_logs_id_seq', 1, false);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: cloud_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.cloud_providers_id_seq', 1, false);


--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.conflict_waivers_id_seq', 1, false);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.countries_id_seq', 284, true);


--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.cyber_security_insurances_id_seq', 1, false);


--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.cyber_security_standards_id_seq', 1, false);


--
-- Name: dropdown_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.dropdown_options_id_seq', 1, false);


--
-- Name: exception_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.exception_requests_id_seq', 37, true);


--
-- Name: faq_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.faq_categories_id_seq', 1, false);


--
-- Name: file_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.file_attachments_id_seq', 1, false);


--
-- Name: follow_ups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.follow_ups_id_seq', 1, false);


--
-- Name: form_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.form_fields_id_seq', 1, false);


--
-- Name: form_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.form_submissions_id_seq', 1, true);


--
-- Name: form_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.form_values_id_seq', 1, false);


--
-- Name: forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.forms_id_seq', 1, false);


--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.frequently_asked_questions_id_seq', 1, false);


--
-- Name: history_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.history_submissions_id_seq', 1, false);


--
-- Name: information_security_policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.information_security_policies_id_seq', 1, false);


--
-- Name: internal_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.internal_notes_id_seq', 1, false);


--
-- Name: jurisdiction_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.jurisdiction_types_id_seq', 5, true);


--
-- Name: jurisdictions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.jurisdictions_id_seq', 1, false);


--
-- Name: law_firms_countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.law_firms_countries_id_seq', 5, true);


--
-- Name: law_firms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.law_firms_id_seq', 24, true);


--
-- Name: law_firms_states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.law_firms_states_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- Name: logics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.logics_id_seq', 1, false);


--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.mailboxer_conversation_opt_outs_id_seq', 1, false);


--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.mailboxer_conversations_id_seq', 1, false);


--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.mailboxer_notifications_id_seq', 1, false);


--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.mailboxer_receipts_id_seq', 1, false);


--
-- Name: matter_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.matter_types_id_seq', 29, true);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- Name: panel_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.panel_requests_id_seq', 4, true);


--
-- Name: queued_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.queued_notifications_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: security_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.security_alerts_id_seq', 1, false);


--
-- Name: security_threats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.security_threats_id_seq', 1, false);


--
-- Name: severity_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.severity_levels_id_seq', 1, false);


--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.shared_bank_informations_id_seq', 1, false);


--
-- Name: states_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.states_id_seq', 1, false);


--
-- Name: sub_matter_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.sub_matter_types_id_seq', 56, true);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 1, true);


--
-- Name: technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.technologies_id_seq', 1, false);


--
-- Name: technology_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.technology_values_id_seq', 1, false);


--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.third_party_vendors_id_seq', 1, false);


--
-- Name: todo_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.todo_tasks_id_seq', 1, false);


--
-- Name: triggers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.triggers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.vendors_id_seq', 1, false);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa1
--

SELECT pg_catalog.setval('public.versions_id_seq', 1, false);


--
-- Name: action_items action_items_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.action_items
    ADD CONSTRAINT action_items_pkey PRIMARY KEY (id);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: activity_time_logs activity_time_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.activity_time_logs
    ADD CONSTRAINT activity_time_logs_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cloud_providers cloud_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cloud_providers
    ADD CONSTRAINT cloud_providers_pkey PRIMARY KEY (id);


--
-- Name: conflict_waivers conflict_waivers_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.conflict_waivers
    ADD CONSTRAINT conflict_waivers_pkey PRIMARY KEY (id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: cyber_security_insurances cyber_security_insurances_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cyber_security_insurances
    ADD CONSTRAINT cyber_security_insurances_pkey PRIMARY KEY (id);


--
-- Name: cyber_security_standards cyber_security_standards_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.cyber_security_standards
    ADD CONSTRAINT cyber_security_standards_pkey PRIMARY KEY (id);


--
-- Name: dropdown_options dropdown_options_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.dropdown_options
    ADD CONSTRAINT dropdown_options_pkey PRIMARY KEY (id);


--
-- Name: exception_requests exception_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.exception_requests
    ADD CONSTRAINT exception_requests_pkey PRIMARY KEY (id);


--
-- Name: faq_categories faq_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.faq_categories
    ADD CONSTRAINT faq_categories_pkey PRIMARY KEY (id);


--
-- Name: file_attachments file_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.file_attachments
    ADD CONSTRAINT file_attachments_pkey PRIMARY KEY (id);


--
-- Name: follow_ups follow_ups_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.follow_ups
    ADD CONSTRAINT follow_ups_pkey PRIMARY KEY (id);


--
-- Name: form_fields form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_pkey PRIMARY KEY (id);


--
-- Name: form_submissions form_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_submissions
    ADD CONSTRAINT form_submissions_pkey PRIMARY KEY (id);


--
-- Name: form_values form_values_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.form_values
    ADD CONSTRAINT form_values_pkey PRIMARY KEY (id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: frequently_asked_questions frequently_asked_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.frequently_asked_questions
    ADD CONSTRAINT frequently_asked_questions_pkey PRIMARY KEY (id);


--
-- Name: history_submissions history_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.history_submissions
    ADD CONSTRAINT history_submissions_pkey PRIMARY KEY (id);


--
-- Name: information_security_policies information_security_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.information_security_policies
    ADD CONSTRAINT information_security_policies_pkey PRIMARY KEY (id);


--
-- Name: internal_notes internal_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.internal_notes
    ADD CONSTRAINT internal_notes_pkey PRIMARY KEY (id);


--
-- Name: jurisdiction_types jurisdiction_types_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.jurisdiction_types
    ADD CONSTRAINT jurisdiction_types_pkey PRIMARY KEY (id);


--
-- Name: jurisdictions jurisdictions_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.jurisdictions
    ADD CONSTRAINT jurisdictions_pkey PRIMARY KEY (id);


--
-- Name: law_firms_countries law_firms_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms_countries
    ADD CONSTRAINT law_firms_countries_pkey PRIMARY KEY (id);


--
-- Name: law_firms law_firms_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms
    ADD CONSTRAINT law_firms_pkey PRIMARY KEY (id);


--
-- Name: law_firms_states law_firms_states_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.law_firms_states
    ADD CONSTRAINT law_firms_states_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: logics logics_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.logics
    ADD CONSTRAINT logics_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversation_opt_outs mailboxer_conversation_opt_outs_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs
    ADD CONSTRAINT mailboxer_conversation_opt_outs_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversations mailboxer_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_conversations
    ADD CONSTRAINT mailboxer_conversations_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_notifications mailboxer_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_notifications
    ADD CONSTRAINT mailboxer_notifications_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_receipts mailboxer_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_receipts
    ADD CONSTRAINT mailboxer_receipts_pkey PRIMARY KEY (id);


--
-- Name: matter_types matter_types_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.matter_types
    ADD CONSTRAINT matter_types_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: panel_requests panel_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.panel_requests
    ADD CONSTRAINT panel_requests_pkey PRIMARY KEY (id);


--
-- Name: queued_notifications queued_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.queued_notifications
    ADD CONSTRAINT queued_notifications_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: security_alerts security_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.security_alerts
    ADD CONSTRAINT security_alerts_pkey PRIMARY KEY (id);


--
-- Name: security_threats security_threats_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.security_threats
    ADD CONSTRAINT security_threats_pkey PRIMARY KEY (id);


--
-- Name: severity_levels severity_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.severity_levels
    ADD CONSTRAINT severity_levels_pkey PRIMARY KEY (id);


--
-- Name: shared_bank_informations shared_bank_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.shared_bank_informations
    ADD CONSTRAINT shared_bank_informations_pkey PRIMARY KEY (id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: sub_matter_types sub_matter_types_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.sub_matter_types
    ADD CONSTRAINT sub_matter_types_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: technologies technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT technologies_pkey PRIMARY KEY (id);


--
-- Name: technology_values technology_values_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.technology_values
    ADD CONSTRAINT technology_values_pkey PRIMARY KEY (id);


--
-- Name: third_party_vendors third_party_vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.third_party_vendors
    ADD CONSTRAINT third_party_vendors_pkey PRIMARY KEY (id);


--
-- Name: todo_tasks todo_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.todo_tasks
    ADD CONSTRAINT todo_tasks_pkey PRIMARY KEY (id);


--
-- Name: triggers triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.triggers
    ADD CONSTRAINT triggers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_activity_logs_on_loggable_type_and_loggable_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_activity_logs_on_loggable_type_and_loggable_id ON public.activity_logs USING btree (loggable_type, loggable_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_form_fields_on_position; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_form_fields_on_position ON public.form_fields USING btree ("position");


--
-- Name: index_mailboxer_conversation_opt_outs_on_conversation_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_conversation_id ON public.mailboxer_conversation_opt_outs USING btree (conversation_id);


--
-- Name: index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type ON public.mailboxer_conversation_opt_outs USING btree (unsubscriber_id, unsubscriber_type);


--
-- Name: index_mailboxer_notifications_on_conversation_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_notifications_on_conversation_id ON public.mailboxer_notifications USING btree (conversation_id);


--
-- Name: index_mailboxer_notifications_on_notified_object_id_and_type; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_notifications_on_notified_object_id_and_type ON public.mailboxer_notifications USING btree (notified_object_id, notified_object_type);


--
-- Name: index_mailboxer_notifications_on_sender_id_and_sender_type; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_notifications_on_sender_id_and_sender_type ON public.mailboxer_notifications USING btree (sender_id, sender_type);


--
-- Name: index_mailboxer_notifications_on_type; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_notifications_on_type ON public.mailboxer_notifications USING btree (type);


--
-- Name: index_mailboxer_receipts_on_notification_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_receipts_on_notification_id ON public.mailboxer_receipts USING btree (notification_id);


--
-- Name: index_mailboxer_receipts_on_receiver_id_and_receiver_type; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_mailboxer_receipts_on_receiver_id_and_receiver_type ON public.mailboxer_receipts USING btree (receiver_id, receiver_type);


--
-- Name: index_queued_notifications_on_deleted_at; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_queued_notifications_on_deleted_at ON public.queued_notifications USING btree (deleted_at);


--
-- Name: index_technologies_on_platform_and_version; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_technologies_on_platform_and_version ON public.technologies USING btree (platform, version);


--
-- Name: index_technologies_on_vendor; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_technologies_on_vendor ON public.technologies USING btree (vendor);


--
-- Name: index_technologies_on_vendor_and_platform; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_technologies_on_vendor_and_platform ON public.technologies USING btree (vendor, platform);


--
-- Name: index_technologies_on_version_and_service_pack; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_technologies_on_version_and_service_pack ON public.technologies USING btree (version, service_pack);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: manishchhipa1
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: mailboxer_conversation_opt_outs mb_opt_outs_on_conversations_id; Type: FK CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs
    ADD CONSTRAINT mb_opt_outs_on_conversations_id FOREIGN KEY (conversation_id) REFERENCES public.mailboxer_conversations(id);


--
-- Name: mailboxer_notifications notifications_on_conversation_id; Type: FK CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_notifications
    ADD CONSTRAINT notifications_on_conversation_id FOREIGN KEY (conversation_id) REFERENCES public.mailboxer_conversations(id);


--
-- Name: mailboxer_receipts receipts_on_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: manishchhipa1
--

ALTER TABLE ONLY public.mailboxer_receipts
    ADD CONSTRAINT receipts_on_notification_id FOREIGN KEY (notification_id) REFERENCES public.mailboxer_notifications(id);


--
-- PostgreSQL database dump complete
--

