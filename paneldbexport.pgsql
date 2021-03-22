--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

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

SET default_with_oids = false;

--
-- Name: action_items; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.action_items (
    id integer NOT NULL,
    security_threat_id integer,
    law_firm_id integer,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.action_items OWNER TO manish;

--
-- Name: action_items_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.action_items_id_seq
    START WITH 252
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.action_items_id_seq OWNER TO manish;

--
-- Name: action_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.action_items_id_seq OWNED BY public.action_items.id;


--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.active_admin_comments (
    id integer NOT NULL,
    namespace character varying,
    body text,
    resource_id character varying NOT NULL,
    resource_type character varying NOT NULL,
    author_type character varying,
    author_id integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.active_admin_comments OWNER TO manish;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_admin_comments_id_seq OWNER TO manish;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.activity_logs (
    id integer NOT NULL,
    law_firm_id integer,
    event_type character varying,
    custom_message character varying,
    loggable_type character varying,
    loggable_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    read boolean,
    notify boolean,
    email character varying,
    source character varying,
    status character varying
);


ALTER TABLE public.activity_logs OWNER TO manish;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.activity_logs_id_seq
    START WITH 1209
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_logs_id_seq OWNER TO manish;

--
-- Name: activity_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.activity_logs_id_seq OWNED BY public.activity_logs.id;


--
-- Name: activity_time_logs; Type: TABLE; Schema: public; Owner: manish
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    network_discovery_never boolean DEFAULT false,
    penetration_testing_never boolean DEFAULT false,
    vulnerability_assessment_never boolean DEFAULT false,
    hardware_refresh_never boolean DEFAULT false,
    hardware_inventory_never boolean DEFAULT false,
    software_inventory_never boolean DEFAULT false
);


ALTER TABLE public.activity_time_logs OWNER TO manish;

--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.activity_time_logs_id_seq
    START WITH 31
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_time_logs_id_seq OWNER TO manish;

--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.activity_time_logs_id_seq OWNED BY public.activity_time_logs.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role character varying
);


ALTER TABLE public.admin_users OWNER TO manish;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_users_id_seq OWNER TO manish;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO manish;

--
-- Name: cloud_providers; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.cloud_providers (
    id integer NOT NULL,
    form_value_id integer,
    name character varying,
    service character varying,
    data_store_location_ca character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    cloud_type character varying,
    data character varying,
    encrypted_in_flight character varying,
    encrypted_at_rest character varying
);


ALTER TABLE public.cloud_providers OWNER TO manish;

--
-- Name: cloud_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.cloud_providers_id_seq
    START WITH 28
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cloud_providers_id_seq OWNER TO manish;

--
-- Name: cloud_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.cloud_providers_id_seq OWNED BY public.cloud_providers.id;


--
-- Name: conflict_waivers; Type: TABLE; Schema: public; Owner: manishchhipa
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


ALTER TABLE public.conflict_waivers OWNER TO manishchhipa;

--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa
--

CREATE SEQUENCE public.conflict_waivers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conflict_waivers_id_seq OWNER TO manishchhipa;

--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa
--

ALTER SEQUENCE public.conflict_waivers_id_seq OWNED BY public.conflict_waivers.id;


--
-- Name: cyber_security_insurances; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.cyber_security_insurances (
    id integer NOT NULL,
    company character varying,
    coverage character varying,
    coverage_amount character varying,
    policy character varying,
    form_value_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    date_of_expiry date,
    standing character varying
);


ALTER TABLE public.cyber_security_insurances OWNER TO manish;

--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.cyber_security_insurances_id_seq
    START WITH 40
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cyber_security_insurances_id_seq OWNER TO manish;

--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.cyber_security_insurances_id_seq OWNED BY public.cyber_security_insurances.id;


--
-- Name: cyber_security_standards; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.cyber_security_standards (
    id integer NOT NULL,
    rank character varying,
    standard character varying,
    date_of_certification date,
    renewal date,
    form_value_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status character varying
);


ALTER TABLE public.cyber_security_standards OWNER TO manish;

--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.cyber_security_standards_id_seq
    START WITH 59
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cyber_security_standards_id_seq OWNER TO manish;

--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.cyber_security_standards_id_seq OWNED BY public.cyber_security_standards.id;


--
-- Name: dropdown_options; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.dropdown_options (
    id integer NOT NULL,
    key character varying,
    value character varying,
    form_field_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    score double precision DEFAULT 0.0
);


ALTER TABLE public.dropdown_options OWNER TO manish;

--
-- Name: dropdown_options_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.dropdown_options_id_seq
    START WITH 414
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dropdown_options_id_seq OWNER TO manish;

--
-- Name: dropdown_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.dropdown_options_id_seq OWNED BY public.dropdown_options.id;


--
-- Name: exception_requests; Type: TABLE; Schema: public; Owner: manishchhipa
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
    minority_owned text,
    minority_owned_details text,
    women_owned text,
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
    pay_type character varying,
    docusign_envelope_id character varying,
    notes text
);


ALTER TABLE public.exception_requests OWNER TO manishchhipa;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa
--

CREATE SEQUENCE public.exception_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exception_requests_id_seq OWNER TO manishchhipa;

--
-- Name: exception_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa
--

ALTER SEQUENCE public.exception_requests_id_seq OWNED BY public.exception_requests.id;


--
-- Name: faq_categories; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.faq_categories (
    id integer NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.faq_categories OWNER TO manish;

--
-- Name: faq_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.faq_categories_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.faq_categories_id_seq OWNER TO manish;

--
-- Name: faq_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.faq_categories_id_seq OWNED BY public.faq_categories.id;


--
-- Name: file_attachments; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.file_attachments (
    id integer NOT NULL,
    file character varying,
    form_value_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    iv text,
    key text,
    attachable_type character varying,
    attachable_id integer
);


ALTER TABLE public.file_attachments OWNER TO manish;

--
-- Name: file_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.file_attachments_id_seq
    START WITH 328
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_attachments_id_seq OWNER TO manish;

--
-- Name: file_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.file_attachments_id_seq OWNED BY public.file_attachments.id;


--
-- Name: follow_ups; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.follow_ups (
    id integer NOT NULL,
    form_submission_id integer,
    loggable_type character varying,
    loggable_id integer,
    status character varying,
    note_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.follow_ups OWNER TO manish;

--
-- Name: follow_ups_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.follow_ups_id_seq
    START WITH 83
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follow_ups_id_seq OWNER TO manish;

--
-- Name: follow_ups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.follow_ups_id_seq OWNED BY public.follow_ups.id;


--
-- Name: form_fields; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.form_fields (
    id integer NOT NULL,
    min character varying,
    max character varying,
    required boolean,
    label character varying,
    type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
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


ALTER TABLE public.form_fields OWNER TO manish;

--
-- Name: form_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.form_fields_id_seq
    START WITH 237
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_fields_id_seq OWNER TO manish;

--
-- Name: form_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.form_fields_id_seq OWNED BY public.form_fields.id;


--
-- Name: form_submissions; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.form_submissions (
    id integer NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    form_id integer,
    form_process_id integer,
    submitted boolean DEFAULT false,
    submitted_on timestamp(6) without time zone,
    law_firm_id integer,
    total_score double precision,
    status character varying,
    reason character varying,
    assessor_score double precision,
    system_score double precision,
    expiry_date date,
    locked_by_id integer,
    locked_at timestamp(6) without time zone,
    last_submitted_by_id integer,
    approved_at timestamp(6) without time zone,
    evidence_status character varying,
    form_relationship_id integer,
    form_diversity_id integer,
    form_innovation_id integer,
    form_resourcing_id integer
);


ALTER TABLE public.form_submissions OWNER TO manish;

--
-- Name: form_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.form_submissions_id_seq
    START WITH 109
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_submissions_id_seq OWNER TO manish;

--
-- Name: form_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.form_submissions_id_seq OWNED BY public.form_submissions.id;


--
-- Name: form_values; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.form_values (
    id integer NOT NULL,
    form_field_id integer,
    submittable_id integer,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    submittable_type character varying,
    form_field_label character varying,
    file_value character varying,
    checked boolean DEFAULT false,
    form_value_iv character varying,
    form_value_key character varying,
    multi_select_value text
);


ALTER TABLE public.form_values OWNER TO manish;

--
-- Name: form_values_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.form_values_id_seq
    START WITH 4801
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_values_id_seq OWNER TO manish;

--
-- Name: form_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.form_values_id_seq OWNED BY public.form_values.id;


--
-- Name: forms; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.forms (
    id integer NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    group_form boolean,
    step character varying
);


ALTER TABLE public.forms OWNER TO manish;

--
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.forms_id_seq
    START WITH 22
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forms_id_seq OWNER TO manish;

--
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.forms_id_seq OWNED BY public.forms.id;


--
-- Name: frequently_asked_questions; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.frequently_asked_questions (
    id integer NOT NULL,
    question character varying,
    answer text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    faq_category_id integer
);


ALTER TABLE public.frequently_asked_questions OWNER TO manish;

--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.frequently_asked_questions_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.frequently_asked_questions_id_seq OWNER TO manish;

--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.frequently_asked_questions_id_seq OWNED BY public.frequently_asked_questions.id;


--
-- Name: history_submissions; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.history_submissions (
    id integer NOT NULL,
    incident_type character varying,
    impact character varying,
    discovery_time character varying,
    source character varying,
    data_loss character varying,
    incident_details text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    form_submission_id integer,
    checked boolean DEFAULT false
);


ALTER TABLE public.history_submissions OWNER TO manish;

--
-- Name: history_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.history_submissions_id_seq
    START WITH 63
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_submissions_id_seq OWNER TO manish;

--
-- Name: history_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.history_submissions_id_seq OWNED BY public.history_submissions.id;


--
-- Name: information_security_policies; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.information_security_policies (
    id integer NOT NULL,
    policy character varying,
    last_reviewed date,
    last_updated date,
    freq_of_review character varying,
    form_value_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    upload_policy character varying,
    independent_review character varying,
    communication_status character varying
);


ALTER TABLE public.information_security_policies OWNER TO manish;

--
-- Name: information_security_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.information_security_policies_id_seq
    START WITH 115
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.information_security_policies_id_seq OWNER TO manish;

--
-- Name: information_security_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.information_security_policies_id_seq OWNED BY public.information_security_policies.id;


--
-- Name: internal_notes; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.internal_notes (
    id integer NOT NULL,
    message text,
    sender_id integer,
    law_firm_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.internal_notes OWNER TO manish;

--
-- Name: internal_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.internal_notes_id_seq
    START WITH 42
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.internal_notes_id_seq OWNER TO manish;

--
-- Name: internal_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.internal_notes_id_seq OWNED BY public.internal_notes.id;


--
-- Name: jurisdictions; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.jurisdictions (
    id integer NOT NULL,
    country character varying,
    city character varying,
    law_firm_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.jurisdictions OWNER TO manish;

--
-- Name: jurisdictions_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.jurisdictions_id_seq
    START WITH 10
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jurisdictions_id_seq OWNER TO manish;

--
-- Name: jurisdictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.jurisdictions_id_seq OWNED BY public.jurisdictions.id;


--
-- Name: law_firms; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.law_firms (
    id integer NOT NULL,
    name character varying,
    description character varying,
    email character varying,
    phone character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
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
    initial_date_of_engagement_with_the_bank timestamp(6) without time zone,
    type_of_matters_your_law_firm_handles_for_us text,
    type_of_services_your_law_firm_provides_generally text,
    confidentiality_level_of_matters_that_are_handled text,
    number_of_lawyers character varying,
    relationship_manager_name character varying,
    relationship_manager_phone character varying,
    law_firm_category character varying
);


ALTER TABLE public.law_firms OWNER TO manish;

--
-- Name: law_firms_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.law_firms_id_seq
    START WITH 99
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.law_firms_id_seq OWNER TO manish;

--
-- Name: law_firms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.law_firms_id_seq OWNED BY public.law_firms.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: manish
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.locations OWNER TO manish;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 19
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO manish;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: logics; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.logics (
    id integer NOT NULL,
    listen_field_id integer,
    change_field_id integer,
    form_id integer,
    logic_to_be_applied character varying,
    "values" character varying,
    perform_action character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.logics OWNER TO manish;

--
-- Name: logics_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.logics_id_seq
    START WITH 265
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logics_id_seq OWNER TO manish;

--
-- Name: logics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.logics_id_seq OWNED BY public.logics.id;


--
-- Name: mailboxer_conversation_opt_outs; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.mailboxer_conversation_opt_outs (
    id integer NOT NULL,
    unsubscriber_type character varying,
    unsubscriber_id integer,
    conversation_id integer
);


ALTER TABLE public.mailboxer_conversation_opt_outs OWNER TO manish;

--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.mailboxer_conversation_opt_outs_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_conversation_opt_outs_id_seq OWNER TO manish;

--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.mailboxer_conversation_opt_outs_id_seq OWNED BY public.mailboxer_conversation_opt_outs.id;


--
-- Name: mailboxer_conversations; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.mailboxer_conversations (
    id integer NOT NULL,
    subject character varying DEFAULT ''::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.mailboxer_conversations OWNER TO manish;

--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.mailboxer_conversations_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_conversations_id_seq OWNER TO manish;

--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.mailboxer_conversations_id_seq OWNED BY public.mailboxer_conversations.id;


--
-- Name: mailboxer_notifications; Type: TABLE; Schema: public; Owner: manish
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
    updated_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    global boolean DEFAULT false,
    expires timestamp(6) without time zone
);


ALTER TABLE public.mailboxer_notifications OWNER TO manish;

--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.mailboxer_notifications_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_notifications_id_seq OWNER TO manish;

--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.mailboxer_notifications_id_seq OWNED BY public.mailboxer_notifications.id;


--
-- Name: mailboxer_receipts; Type: TABLE; Schema: public; Owner: manish
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    is_delivered boolean DEFAULT false,
    delivery_method character varying,
    message_id character varying
);


ALTER TABLE public.mailboxer_receipts OWNER TO manish;

--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.mailboxer_receipts_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mailboxer_receipts_id_seq OWNER TO manish;

--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.mailboxer_receipts_id_seq OWNED BY public.mailboxer_receipts.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    law_firm_id integer,
    message_type character varying,
    message text,
    step character varying,
    admin_user_id integer,
    sender character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    form_submission_id integer,
    follow_up_id integer,
    deleted_at timestamp(6) without time zone
);


ALTER TABLE public.notes OWNER TO manish;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 125
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO manish;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: panel_requests; Type: TABLE; Schema: public; Owner: manishchhipa
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


ALTER TABLE public.panel_requests OWNER TO manishchhipa;

--
-- Name: panel_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa
--

CREATE SEQUENCE public.panel_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.panel_requests_id_seq OWNER TO manishchhipa;

--
-- Name: panel_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa
--

ALTER SEQUENCE public.panel_requests_id_seq OWNED BY public.panel_requests.id;


--
-- Name: queued_notifications; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.queued_notifications (
    id integer NOT NULL,
    trigger_at timestamp(6) without time zone,
    trigger_id integer,
    action_item_id integer,
    triggered boolean DEFAULT false,
    deleted_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    severity_negative_factor double precision
);


ALTER TABLE public.queued_notifications OWNER TO manish;

--
-- Name: queued_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.queued_notifications_id_seq
    START WITH 691
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queued_notifications_id_seq OWNER TO manish;

--
-- Name: queued_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.queued_notifications_id_seq OWNED BY public.queued_notifications.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: manishchhipa
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


ALTER TABLE public.reviews OWNER TO manishchhipa;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: manishchhipa
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO manishchhipa;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manishchhipa
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO manish;

--
-- Name: security_alerts; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.security_alerts (
    id integer NOT NULL,
    title character varying,
    description text,
    severity character varying,
    link character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    alert_date timestamp(6) without time zone
);


ALTER TABLE public.security_alerts OWNER TO manish;

--
-- Name: security_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.security_alerts_id_seq
    START WITH 14
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.security_alerts_id_seq OWNER TO manish;

--
-- Name: security_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.security_alerts_id_seq OWNED BY public.security_alerts.id;


--
-- Name: security_threats; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.security_threats (
    id integer NOT NULL,
    title character varying,
    description text,
    severity_level_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    severity_negative_factor double precision,
    vendor text,
    platform text,
    version text,
    service_pack text
);


ALTER TABLE public.security_threats OWNER TO manish;

--
-- Name: security_threats_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.security_threats_id_seq
    START WITH 41
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.security_threats_id_seq OWNER TO manish;

--
-- Name: security_threats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.security_threats_id_seq OWNED BY public.security_threats.id;


--
-- Name: severity_levels; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.severity_levels (
    id integer NOT NULL,
    name character varying,
    color character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.severity_levels OWNER TO manish;

--
-- Name: severity_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.severity_levels_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.severity_levels_id_seq OWNER TO manish;

--
-- Name: severity_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.severity_levels_id_seq OWNED BY public.severity_levels.id;


--
-- Name: shared_bank_informations; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.shared_bank_informations (
    id integer NOT NULL,
    form_value_id integer,
    name character varying,
    purpose character varying,
    level_of_access character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.shared_bank_informations OWNER TO manish;

--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.shared_bank_informations_id_seq
    START WITH 26
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shared_bank_informations_id_seq OWNER TO manish;

--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.shared_bank_informations_id_seq OWNED BY public.shared_bank_informations.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.system_settings (
    id integer NOT NULL,
    score_threshold double precision,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    docusign_access_token text
);


ALTER TABLE public.system_settings OWNER TO manish;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.system_settings_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_settings_id_seq OWNER TO manish;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: technologies; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.technologies (
    id integer NOT NULL,
    vendor character varying,
    platform character varying,
    version character varying,
    service_pack character varying,
    supported character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    platform_category character varying,
    platform_type character varying
);


ALTER TABLE public.technologies OWNER TO manish;

--
-- Name: technologies_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.technologies_id_seq
    START WITH 191
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technologies_id_seq OWNER TO manish;

--
-- Name: technologies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.technologies_id_seq OWNED BY public.technologies.id;


--
-- Name: technology_values; Type: TABLE; Schema: public; Owner: manish
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
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    law_firm_id integer,
    form_submission_id integer,
    technology_id integer,
    checked boolean DEFAULT false
);


ALTER TABLE public.technology_values OWNER TO manish;

--
-- Name: technology_values_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.technology_values_id_seq
    START WITH 222
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.technology_values_id_seq OWNER TO manish;

--
-- Name: technology_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.technology_values_id_seq OWNED BY public.technology_values.id;


--
-- Name: third_party_vendors; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.third_party_vendors (
    id integer NOT NULL,
    form_value_id integer,
    vendor_name character varying,
    area character varying,
    confidentiality_agreement character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.third_party_vendors OWNER TO manish;

--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.third_party_vendors_id_seq
    START WITH 51
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.third_party_vendors_id_seq OWNER TO manish;

--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.third_party_vendors_id_seq OWNED BY public.third_party_vendors.id;


--
-- Name: todo_tasks; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.todo_tasks (
    id integer NOT NULL,
    law_firm_id integer,
    title character varying,
    message character varying,
    severity character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.todo_tasks OWNER TO manish;

--
-- Name: todo_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.todo_tasks_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todo_tasks_id_seq OWNER TO manish;

--
-- Name: todo_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.todo_tasks_id_seq OWNED BY public.todo_tasks.id;


--
-- Name: triggers; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.triggers (
    id integer NOT NULL,
    hours integer,
    action_type character varying,
    message character varying,
    severity_level_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.triggers OWNER TO manish;

--
-- Name: triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.triggers_id_seq
    START WITH 8
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.triggers_id_seq OWNER TO manish;

--
-- Name: triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.triggers_id_seq OWNED BY public.triggers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    username character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    deactivated_at timestamp(6) without time zone,
    otp_secret_key character varying,
    google_secret character varying,
    role character varying,
    law_firm_id integer,
    new_password_set boolean DEFAULT false,
    qr_code_confirmed_at timestamp(6) without time zone,
    first_name character varying,
    last_name character varying,
    line_of_business character varying,
    lob_contact_name character varying
);


ALTER TABLE public.users OWNER TO manish;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.users_id_seq
    START WITH 96
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO manish;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    name character varying,
    vendor_type character varying,
    application character varying,
    form_value_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.vendors OWNER TO manish;

--
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.vendors_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_id_seq OWNER TO manish;

--
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: manish
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_type character varying NOT NULL,
    item_id integer NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.versions OWNER TO manish;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: manish
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO manish;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: manish
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: action_items id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.action_items ALTER COLUMN id SET DEFAULT nextval('public.action_items_id_seq'::regclass);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: activity_logs id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_logs_id_seq'::regclass);


--
-- Name: activity_time_logs id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.activity_time_logs ALTER COLUMN id SET DEFAULT nextval('public.activity_time_logs_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: cloud_providers id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cloud_providers ALTER COLUMN id SET DEFAULT nextval('public.cloud_providers_id_seq'::regclass);


--
-- Name: conflict_waivers id; Type: DEFAULT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.conflict_waivers ALTER COLUMN id SET DEFAULT nextval('public.conflict_waivers_id_seq'::regclass);


--
-- Name: cyber_security_insurances id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cyber_security_insurances ALTER COLUMN id SET DEFAULT nextval('public.cyber_security_insurances_id_seq'::regclass);


--
-- Name: cyber_security_standards id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cyber_security_standards ALTER COLUMN id SET DEFAULT nextval('public.cyber_security_standards_id_seq'::regclass);


--
-- Name: dropdown_options id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.dropdown_options ALTER COLUMN id SET DEFAULT nextval('public.dropdown_options_id_seq'::regclass);


--
-- Name: exception_requests id; Type: DEFAULT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.exception_requests ALTER COLUMN id SET DEFAULT nextval('public.exception_requests_id_seq'::regclass);


--
-- Name: faq_categories id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.faq_categories ALTER COLUMN id SET DEFAULT nextval('public.faq_categories_id_seq'::regclass);


--
-- Name: file_attachments id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.file_attachments ALTER COLUMN id SET DEFAULT nextval('public.file_attachments_id_seq'::regclass);


--
-- Name: follow_ups id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.follow_ups ALTER COLUMN id SET DEFAULT nextval('public.follow_ups_id_seq'::regclass);


--
-- Name: form_fields id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_fields ALTER COLUMN id SET DEFAULT nextval('public.form_fields_id_seq'::regclass);


--
-- Name: form_submissions id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_submissions ALTER COLUMN id SET DEFAULT nextval('public.form_submissions_id_seq'::regclass);


--
-- Name: form_values id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_values ALTER COLUMN id SET DEFAULT nextval('public.form_values_id_seq'::regclass);


--
-- Name: forms id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.forms ALTER COLUMN id SET DEFAULT nextval('public.forms_id_seq'::regclass);


--
-- Name: frequently_asked_questions id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.frequently_asked_questions ALTER COLUMN id SET DEFAULT nextval('public.frequently_asked_questions_id_seq'::regclass);


--
-- Name: history_submissions id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.history_submissions ALTER COLUMN id SET DEFAULT nextval('public.history_submissions_id_seq'::regclass);


--
-- Name: information_security_policies id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.information_security_policies ALTER COLUMN id SET DEFAULT nextval('public.information_security_policies_id_seq'::regclass);


--
-- Name: internal_notes id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.internal_notes ALTER COLUMN id SET DEFAULT nextval('public.internal_notes_id_seq'::regclass);


--
-- Name: jurisdictions id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.jurisdictions ALTER COLUMN id SET DEFAULT nextval('public.jurisdictions_id_seq'::regclass);


--
-- Name: law_firms id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.law_firms ALTER COLUMN id SET DEFAULT nextval('public.law_firms_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: logics id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.logics ALTER COLUMN id SET DEFAULT nextval('public.logics_id_seq'::regclass);


--
-- Name: mailboxer_conversation_opt_outs id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_conversation_opt_outs_id_seq'::regclass);


--
-- Name: mailboxer_conversations id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_conversations ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_conversations_id_seq'::regclass);


--
-- Name: mailboxer_notifications id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_notifications ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_notifications_id_seq'::regclass);


--
-- Name: mailboxer_receipts id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_receipts ALTER COLUMN id SET DEFAULT nextval('public.mailboxer_receipts_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: panel_requests id; Type: DEFAULT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.panel_requests ALTER COLUMN id SET DEFAULT nextval('public.panel_requests_id_seq'::regclass);


--
-- Name: queued_notifications id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.queued_notifications ALTER COLUMN id SET DEFAULT nextval('public.queued_notifications_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: security_alerts id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.security_alerts ALTER COLUMN id SET DEFAULT nextval('public.security_alerts_id_seq'::regclass);


--
-- Name: security_threats id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.security_threats ALTER COLUMN id SET DEFAULT nextval('public.security_threats_id_seq'::regclass);


--
-- Name: severity_levels id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.severity_levels ALTER COLUMN id SET DEFAULT nextval('public.severity_levels_id_seq'::regclass);


--
-- Name: shared_bank_informations id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.shared_bank_informations ALTER COLUMN id SET DEFAULT nextval('public.shared_bank_informations_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: technologies id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.technologies ALTER COLUMN id SET DEFAULT nextval('public.technologies_id_seq'::regclass);


--
-- Name: technology_values id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.technology_values ALTER COLUMN id SET DEFAULT nextval('public.technology_values_id_seq'::regclass);


--
-- Name: third_party_vendors id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.third_party_vendors ALTER COLUMN id SET DEFAULT nextval('public.third_party_vendors_id_seq'::regclass);


--
-- Name: todo_tasks id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.todo_tasks ALTER COLUMN id SET DEFAULT nextval('public.todo_tasks_id_seq'::regclass);


--
-- Name: triggers id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.triggers ALTER COLUMN id SET DEFAULT nextval('public.triggers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Data for Name: action_items; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.action_items (id, security_threat_id, law_firm_id, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.active_admin_comments (id, namespace, body, resource_id, resource_type, author_type, author_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.activity_logs (id, law_firm_id, event_type, custom_message, loggable_type, loggable_id, created_at, updated_at, read, notify, email, source, status) FROM stdin;
1210	100	account_created	Onboarded	LawFirm	100	2019-09-13 04:31:12.202921	2019-09-13 04:31:12.202921	\N	t	manpreet@grcconsulting.ca	User	\N
1211	100	information_security_policy_request_initiated	SEAL process started	FormSubmission	110	2019-09-18 04:51:26.048744	2019-09-18 04:51:26.048744	\N	t	4cb81e6b@check.com	User	\N
1212	101	account_created	Onboarded	LawFirm	101	2019-09-18 14:58:38.795704	2019-09-18 14:58:38.795704	\N	t	manpreet@grcconsulting.ca	User	\N
1213	101	information_security_policy_request_initiated	SEAL process started	FormSubmission	111	2019-09-18 15:00:09.087923	2019-09-18 15:00:09.087923	\N	t	2cafea76@check.com	User	\N
1214	102	account_created	Onboarded	LawFirm	102	2019-09-18 15:23:44.54083	2019-09-18 15:23:44.54083	\N	t	manpreet@grcconsulting.ca	User	\N
1215	103	information_security_policy_request_initiated	SEAL process started	FormSubmission	112	2019-09-18 19:52:01.102927	2019-09-18 19:52:01.102927	\N	t	a213a5fa@check.com	User	\N
1216	103	information_security_policy_request_initiated	SEAL process started	FormSubmission	113	2019-09-18 20:08:57.185446	2019-09-18 20:08:57.185446	\N	t	manpreet@grcconsulting.ca	User	\N
1217	103	information_security_policy_submitted	SEAL form submitted	FormSubmission	113	2019-09-18 20:17:09.536974	2019-09-18 20:17:09.536974	\N	t	a213a5fa@check.com	User	\N
1218	104	account_created	Onboarded	LawFirm	104	2019-09-19 13:21:58.360792	2019-09-19 13:21:58.360792	\N	t	a213a5fa@check.com	User	\N
1219	105	account_created	Onboarded	LawFirm	105	2019-09-20 18:57:28.185606	2019-09-20 18:57:28.185606	\N	t	manpreet@grcconsulting.ca	User	\N
1220	104	information_security_policy_request_initiated	SEAL process started	FormSubmission	114	2019-09-24 14:37:53.135195	2019-09-24 14:37:53.135195	\N	t	lxpuser@mailinator.com	User	\N
1221	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	6	2019-09-25 03:26:56.189235	2019-09-25 03:26:56.189235	\N	f	2c9e31e6@check.com	User	\N
1222	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	7	2019-09-25 03:42:23.780531	2019-09-25 03:42:23.780531	\N	f	2c9e31e6@check.com	User	\N
1223	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	8	2019-09-25 03:43:49.585014	2019-09-25 03:43:49.585014	\N	f	2c9e31e6@check.com	User	\N
1224	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	9	2019-09-25 04:09:30.821843	2019-09-25 04:09:30.821843	\N	t	2c9e31e6@check.com	User	\N
1225	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	10	2019-09-25 04:09:49.348783	2019-09-25 04:09:49.348783	\N	t	2c9e31e6@check.com	User	\N
1226	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	11	2019-09-25 04:20:35.379743	2019-09-25 04:20:35.379743	\N	t	2c9e31e6@check.com	User	\N
1227	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	12	2019-09-25 04:23:29.655727	2019-09-25 04:23:29.655727	\N	t	2c9e31e6@check.com	User	\N
1228	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	13	2019-09-25 04:24:30.163816	2019-09-25 04:24:30.163816	\N	t	2c9e31e6@check.com	User	\N
1229	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	14	2019-09-25 04:25:54.005598	2019-09-25 04:25:54.005598	\N	t	2c9e31e6@check.com	User	\N
1230	105	conflict_waiver_status_updated_by_lxp	Conflict waiver status updated	ConflictWaiver	8	2019-09-25 15:55:17.281027	2019-09-25 15:55:17.281027	\N	t	218d2d1b@check.com	User	\N
1231	104	conflict_waiver_status_updated_by_lxp	Conflict waiver status updated	ConflictWaiver	9	2019-09-25 15:55:31.967652	2019-09-25 15:55:31.967652	\N	t	2c9e31e6@check.com	User	\N
1232	105	conflict_waiver_status_updated_by_lxp	Conflict waiver status updated	ConflictWaiver	8	2019-09-25 16:16:09.256075	2019-09-25 16:16:09.256075	\N	t	218d2d1b@check.com	User	\N
1233	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	15	2019-09-27 05:00:50.012	2019-09-27 05:00:50.012	\N	t	2c9e31e6@check.com	User	\N
1234	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	16	2019-09-27 13:49:27.876128	2019-09-27 13:49:27.876128	\N	t	2c9e31e6@check.com	User	\N
1235	105	information_security_policy_request_initiated	SEAL process started	FormSubmission	115	2019-09-27 13:50:10.953125	2019-09-27 13:50:10.953125	\N	t	218d2d1b@check.com	User	\N
1236	105	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	17	2019-09-27 13:50:23.336119	2019-09-27 13:50:23.336119	\N	t	218d2d1b@check.com	User	\N
1237	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	18	2019-09-30 04:09:29.451992	2019-09-30 04:09:29.451992	\N	t	2c9e31e6@check.com	User	\N
1238	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	19	2019-09-30 04:22:44.16369	2019-09-30 04:22:44.16369	\N	t	2c9e31e6@check.com	User	\N
1239	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	20	2019-09-30 04:27:47.205152	2019-09-30 04:27:47.205152	\N	t	2c9e31e6@check.com	User	\N
1240	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	21	2019-09-30 04:28:27.482719	2019-09-30 04:28:27.482719	\N	t	2c9e31e6@check.com	User	\N
1241	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	22	2019-09-30 14:13:00.007399	2019-09-30 14:13:00.007399	\N	t	2c9e31e6@check.com	User	\N
1242	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	23	2019-09-30 15:46:06.175495	2019-09-30 15:46:06.175495	\N	t	2c9e31e6@check.com	User	\N
1243	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	24	2019-09-30 16:11:23.937667	2019-09-30 16:11:23.937667	\N	t	2c9e31e6@check.com	User	\N
1244	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	25	2019-09-30 16:18:44.080622	2019-09-30 16:18:44.080622	\N	t	2c9e31e6@check.com	User	\N
1245	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	26	2019-09-30 16:20:33.196251	2019-09-30 16:20:33.196251	\N	t	2c9e31e6@check.com	User	\N
1246	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	27	2019-09-30 16:22:09.861773	2019-09-30 16:22:09.861773	\N	t	2c9e31e6@check.com	User	\N
1247	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	28	2019-09-30 16:24:07.397141	2019-09-30 16:24:07.397141	\N	t	2c9e31e6@check.com	User	\N
1248	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	29	2019-09-30 16:26:59.198528	2019-09-30 16:26:59.198528	\N	t	2c9e31e6@check.com	User	\N
1249	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	30	2019-09-30 16:29:35.709298	2019-09-30 16:29:35.709298	\N	t	2c9e31e6@check.com	User	\N
1250	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	31	2019-09-30 16:30:47.400101	2019-09-30 16:30:47.400101	\N	t	2c9e31e6@check.com	User	\N
1251	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	32	2019-09-30 16:36:13.733905	2019-09-30 16:36:13.733905	\N	t	2c9e31e6@check.com	User	\N
1252	104	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	33	2019-09-30 16:38:31.276474	2019-09-30 16:38:31.276474	\N	t	2c9e31e6@check.com	User	\N
1253	107	account_created	Onboarded	LawFirm	107	2019-10-03 17:00:43.806171	2019-10-03 17:00:43.806171	\N	t	lxpuser@mailinator.com	User	\N
1254	109	information_security_policy_request_initiated	SEAL process started	FormSubmission	116	2019-10-04 14:42:16.693705	2019-10-04 14:42:16.693705	\N	t	lxpuser@mailinator.com	User	\N
1255	109	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	34	2019-10-04 14:44:06.34584	2019-10-04 14:44:06.34584	\N	t	f44b6965@check.com	User	\N
1256	110	information_security_policy_request_initiated	SEAL process started	FormSubmission	117	2019-10-04 14:56:45.778715	2019-10-04 14:56:45.778715	\N	t	lxpuser@mailinator.com	User	\N
1257	112	information_security_policy_request_initiated	SEAL process started	FormSubmission	118	2019-10-10 04:46:57.51722	2019-10-10 04:46:57.51722	\N	t	b213de2e@check.com	User	\N
1258	112	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	35	2019-10-10 04:48:54.410907	2019-10-10 04:48:54.410907	\N	t	b213de2e@check.com	User	\N
1259	113	information_security_policy_request_initiated	SEAL process started	FormSubmission	119	2019-10-17 15:07:42.105389	2019-10-17 15:07:42.105389	\N	t	lxpuser@mailinator.com	User	\N
1260	114	information_security_policy_request_initiated	SEAL process started	FormSubmission	120	2019-10-17 15:28:28.627505	2019-10-17 15:28:28.627505	\N	t	lxpuser@mailinator.com	User	\N
1261	114	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	36	2019-10-17 17:54:35.570784	2019-10-17 17:54:35.570784	\N	t	44a303e4@check.com	User	\N
1262	114	information_security_policy_submitted	SEAL form submitted	FormSubmission	120	2019-10-17 17:56:09.243944	2019-10-17 17:56:09.243944	\N	t	44a303e4@check.com	User	\N
1263	114	follow_up	Follow up requested	FormSubmission	120	2019-10-17 17:57:19.068547	2019-10-17 17:57:19.068547	\N	t	lxpuser@mailinator.com	User	\N
1264	114	information_security_policy_submitted	SEAL form submitted	FormSubmission	120	2019-10-17 18:20:44.06558	2019-10-17 18:20:44.06558	\N	t	44a303e4@check.com	User	\N
1265	115	information_security_policy_request_initiated	SEAL process started	FormSubmission	121	2019-10-18 17:28:50.040005	2019-10-18 17:28:50.040005	\N	t	lxpuser@mailinator.com	User	\N
1266	115	conflict_waiver_submited	New Conflict waiver submited	ConflictWaiver	37	2019-10-18 17:39:21.001869	2019-10-18 17:39:21.001869	\N	t	c7ee952a@check.com	User	\N
1267	115	information_security_policy_submitted	SEAL form submitted	FormSubmission	121	2019-10-18 17:42:22.186103	2019-10-18 17:42:22.186103	\N	t	c7ee952a@check.com	User	\N
1268	115	follow_up	Follow up requested	FormSubmission	121	2019-10-18 17:43:45.80828	2019-10-18 17:43:45.80828	\N	t	lxpuser@mailinator.com	User	\N
1269	115	information_security_policy_submitted	SEAL form submitted	FormSubmission	121	2019-10-18 17:44:50.916556	2019-10-18 17:44:50.916556	\N	t	c7ee952a@check.com	User	\N
1270	115	follow_up	Follow up requested	FormSubmission	121	2019-10-18 17:46:51.128357	2019-10-18 17:46:51.128357	\N	t	lxpuser@mailinator.com	User	\N
1271	115	information_security_policy_submitted	SEAL form submitted	FormSubmission	121	2019-10-18 18:18:19.065679	2019-10-18 18:18:19.065679	\N	t	c7ee952a@check.com	User	\N
1272	115	follow_up	Follow up requested	FormSubmission	121	2019-10-18 18:34:19.648695	2019-10-18 18:34:19.648695	\N	t	lxpuser@mailinator.com	User	\N
1273	115	information_security_policy_submitted	SEAL form submitted	FormSubmission	121	2019-10-18 18:40:15.672887	2019-10-18 18:40:15.672887	\N	t	c7ee952a@check.com	User	\N
1274	115	follow_up	Follow up requested	FormSubmission	121	2019-10-18 19:42:32.867001	2019-10-18 19:42:32.867001	\N	t	lxpuser@mailinator.com	User	\N
1275	115	information_security_policy_submitted	SEAL form submitted	FormSubmission	121	2019-10-18 19:43:02.592426	2019-10-18 19:43:02.592426	\N	t	c7ee952a@check.com	User	\N
1276	116	account_created	Onboarded	LawFirm	116	2019-11-04 03:11:36.291564	2019-11-04 03:11:36.291564	\N	t	lxpuser@mailinator.com	User	\N
1277	119	account_created	Onboarded	LawFirm	119	2019-11-04 03:18:55.10744	2019-11-04 03:18:55.10744	\N	t	lxpuser@mailinator.com	User	\N
1279	123	account_created	Onboarded	LawFirm	123	2019-11-04 03:27:39.796004	2019-11-04 03:27:39.796004	\N	t	lxpuser@mailinator.com	User	\N
1280	123	information_security_policy_request_initiated	SEAL process started	FormSubmission	122	2019-11-04 14:45:18.289897	2019-11-04 14:45:18.289897	\N	t	lxpuser@mailinator.com	User	\N
1281	127	account_created	Onboarded	LawFirm	127	2019-11-06 04:33:03.081495	2019-11-06 04:33:03.081495	\N	t	lxpuser@mailinator.com	User	\N
1282	127	information_security_policy_request_initiated	SEAL process started	FormSubmission	123	2019-11-06 04:33:58.659097	2019-11-06 04:33:58.659097	\N	t	manishqqqqq@mailinator.com	User	\N
1283	128	account_created	Onboarded	LawFirm	128	2019-11-06 13:12:14.693661	2019-11-06 13:12:14.693661	\N	t	lxpuser@mailinator.com	User	\N
1284	128	information_security_policy_request_initiated	SEAL process started	FormSubmission	124	2019-11-07 15:43:27.146128	2019-11-07 15:43:27.146128	\N	t	abc@gmail.com	User	\N
\.


--
-- Data for Name: activity_time_logs; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.activity_time_logs (id, network_discovery, penetration_testing, vulnerability_assessment, hardware_refresh, hardware_inventory, software_inventory, form_value_id, created_at, updated_at, network_discovery_never, penetration_testing_never, vulnerability_assessment_never, hardware_refresh_never, hardware_inventory_never, software_inventory_never) FROM stdin;
32	\N	\N	\N	\N	\N	\N	4809	2019-09-18 04:51:40.889713	2019-09-18 04:51:40.889713	f	f	f	f	f	f
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, role) FROM stdin;
1	manpreet@grcconsulting.ca	$2a$11$gIyG95QA29dexRs5GCP12OHvRoDjj2VM4JX5M980WrIxu48Wrzswy	\N	\N	\N	95	2017-05-24 15:21:38.398075	2017-05-23 19:49:02.517739	99.228.49.180	99.228.49.180	2017-03-05 20:22:54.465231	2017-05-24 15:21:38.40395	\N
2	sealadmin@grcconsulting.ca	$2a$11$7ESMsfhhgU7biCwBXkVFJ.i8kEUBvtZioq1QUFy0aaT0EEv47Ci6q	\N	\N	\N	112	2017-05-29 13:02:31.324447	2017-05-29 13:02:14.421198	184.151.179.94	184.151.179.94	2017-03-23 14:05:38.268567	2017-05-29 13:02:31.336803	\N
3	sealadmin@bmo.com	$2a$11$HxqUO0wxkv906kgIMjpz5.hKIz0mRAgI57eFvPQ99jZ9d.5FWxkNG	\N	\N	\N	45	2017-05-05 13:29:30.224267	2017-04-12 01:13:13.134477	69.157.79.144	69.157.79.144	2017-04-11 18:50:54.886556	2019-09-13 04:10:19.167089	\N
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-03-05 16:43:56.355914	2018-10-22 23:15:35.801674
\.


--
-- Data for Name: cloud_providers; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.cloud_providers (id, form_value_id, name, service, data_store_location_ca, created_at, updated_at, cloud_type, data, encrypted_in_flight, encrypted_at_rest) FROM stdin;
\.


--
-- Data for Name: conflict_waivers; Type: TABLE DATA; Schema: public; Owner: manishchhipa
--

COPY public.conflict_waivers (id, name_of_law_firm, contact_details, bmo_business_contact, reason, user_id, created_at, updated_at, confirm_waiver, lxp_status, internal_lawyers_status, law_firm_id, assigned_to_id) FROM stdin;
\.


--
-- Data for Name: cyber_security_insurances; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.cyber_security_insurances (id, company, coverage, coverage_amount, policy, form_value_id, created_at, updated_at, date_of_expiry, standing) FROM stdin;
\.


--
-- Data for Name: cyber_security_standards; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.cyber_security_standards (id, rank, standard, date_of_certification, renewal, form_value_id, created_at, updated_at, status) FROM stdin;
\.


--
-- Data for Name: dropdown_options; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.dropdown_options (id, key, value, form_field_id, created_at, updated_at, score) FROM stdin;
257	No	no	162	2017-05-23 17:22:21.211925	2017-05-23 17:22:21.211925	0
259	No	no	164	2017-05-23 17:23:53.439074	2017-05-23 17:23:53.439074	0
267	No	no	168	2017-05-23 17:27:06.253577	2017-05-23 17:27:06.253577	0
268	Yes	yes	170	2017-05-23 17:29:17.048767	2017-05-23 17:29:17.048767	0
269	No	no	170	2017-05-23 17:29:17.05214	2017-05-23 17:29:17.05214	0
271	No	no	171	2017-05-23 17:29:35.308543	2017-05-23 17:29:35.308543	0
291	No	no	177	2017-05-23 17:41:43.975933	2017-05-23 17:41:43.975933	0
292	Yes	yes	178	2017-05-23 17:42:49.301065	2017-05-23 17:42:49.301065	0
293	No	no	178	2017-05-23 17:42:49.304639	2017-05-23 17:42:49.304639	0
295	No	no	180	2017-05-23 17:44:36.915329	2017-05-23 17:44:36.915329	0
297	No	no	181	2017-05-23 17:44:36.921475	2017-05-23 17:44:36.921475	0
299	No	no	183	2017-05-23 17:48:35.712959	2017-05-23 17:48:35.712959	0
300	Yes	yes	186	2017-05-23 17:55:06.145172	2017-05-23 17:55:06.145172	0
301	No	no	186	2017-05-23 17:55:06.148785	2017-05-23 17:55:06.148785	0
278	Lawyers	Lawyers	174	2017-05-23 17:39:14.860749	2018-10-04 18:22:09.777486	5
279	Para-Legals	Para-Legals	174	2017-05-23 17:39:14.864476	2018-10-04 18:22:09.779893	5
280	All Non Lawyers, Non Para Legal Staff	All Non Lawyers, Non Para Legal Staff	174	2017-05-23 17:39:14.866622	2018-10-04 18:22:09.781571	5
281	Contractors	Contractors	174	2017-05-23 17:39:14.86891	2018-10-04 18:22:09.783187	5
282	Vendor supplied personnel	Vendor supplied personnel	174	2017-05-23 17:39:14.871091	2018-10-04 18:22:09.784722	5
272	New Personnel hired by your firm directly	New Personnel hired by your firm directly	173	2017-05-23 17:38:21.795823	2018-10-04 18:22:09.79041	5
290	Yes	yes	177	2017-05-23 17:41:43.972348	2018-10-04 18:22:09.822737	5
335	No	no	194	2017-05-23 18:02:20.197951	2017-05-23 18:02:20.197951	0
355	Periodic testing	Periodic testing	199	2017-05-23 18:09:05.021859	2017-05-23 18:09:05.021859	0
356	Planned drills	Planned drills	199	2017-05-23 18:09:05.024533	2017-05-23 18:09:05.024533	0
357	Surprise drills	Surprise drills	199	2017-05-23 18:09:05.027411	2017-05-23 18:09:05.027411	0
359	No	no	202	2017-05-23 18:10:34.390047	2017-05-23 18:10:34.390047	0
368	No	no	172	2017-05-23 19:52:05.437827	2017-05-23 19:52:05.437827	0
369	To be filled yet	To be filled yet	182	2017-05-23 19:57:39.151831	2017-05-23 19:57:39.151831	0
371	No	no	169	2017-05-23 20:32:43.249398	2017-05-23 20:32:43.249398	0
377	Instructional videos	Instructional videos	218	2017-05-31 18:20:52.331727	2017-05-31 18:20:52.331727	0
378	Yes	yes	220	2017-05-31 18:24:27.851477	2017-05-31 18:24:27.851477	5
379	No	no	220	2017-05-31 18:24:27.854916	2017-05-31 18:24:27.854916	0
380	Yes	yes	223	2017-05-31 18:28:48.436981	2017-05-31 18:28:48.436981	0
381	No	no	223	2017-05-31 18:28:48.441086	2017-05-31 18:28:48.441086	0
382	Yes	yes	224	2017-05-31 18:30:50.312966	2017-05-31 18:30:50.312966	5
383	No	no	224	2017-05-31 18:30:50.316679	2017-05-31 18:30:50.316679	0
384	Yes	yes	225	2017-05-31 18:32:04.368622	2017-05-31 18:32:04.368622	5
385	No	no	225	2017-05-31 18:32:04.371275	2017-05-31 18:32:04.371275	0
386	Yes	yes	226	2017-05-31 18:32:04.376529	2017-05-31 18:32:04.376529	0
387	No	no	226	2017-05-31 18:32:04.378192	2017-05-31 18:32:04.378192	0
388	Yes	yes	227	2017-05-31 18:35:26.575997	2017-05-31 18:35:26.575997	0
389	No	no	227	2017-05-31 18:35:26.579108	2017-05-31 18:35:26.579108	0
407	Yes	yes	230	2017-05-31 18:48:31.584549	2017-05-31 18:48:31.584549	5
408	No	no	230	2017-05-31 18:48:31.589469	2017-05-31 18:48:31.589469	0
409	Yes	yes	217	2017-06-01 14:55:03.610305	2017-06-01 14:55:03.610305	5
410	No	no	217	2017-06-01 14:55:03.61374	2017-06-01 14:55:03.61374	0
260	On Premises	On Premises	166	2017-05-23 17:25:30.78608	2018-10-04 18:10:45.375709	3
261	Colocated	Colocated	166	2017-05-23 17:25:30.792325	2018-10-04 18:10:45.377669	5
262	Cloud	Cloud	166	2017-05-23 17:25:30.794593	2018-10-04 18:10:45.379191	4
263	File Room	File Room	166	2017-05-23 17:25:30.796906	2018-10-04 18:10:45.380707	5
264	Storage Vendor	Storage Vendor	166	2017-05-23 17:25:30.800173	2018-10-04 18:10:45.382151	5
265	Data Loss	Data Loss	166	2017-05-23 17:25:30.801874	2018-10-04 18:10:45.383659	5
256	Yes	yes	162	2017-05-23 17:22:21.204258	2018-10-04 18:10:45.398354	5
390	Data Loss	Data Loss	233	2017-05-31 18:40:33.070356	2018-10-04 18:10:45.410671	5
391	Data Destruction	Data Destruction	233	2017-05-31 18:40:33.078341	2018-10-04 18:10:45.412293	5
370	Yes	yes	169	2017-05-23 20:32:43.241726	2018-10-04 18:10:45.4462	5
367	Yes	yes	172	2017-05-23 19:52:05.434174	2018-10-04 18:22:09.787472	5
360	Internal	Internal	184	2017-05-23 18:25:44.827258	2018-10-04 18:22:09.833955	5
361	External	External	184	2017-05-23 18:25:44.829195	2018-10-04 18:22:09.83564	5
362	Both	Both	184	2017-05-23 18:25:44.831476	2018-10-04 18:22:09.837172	5
364	24x7	24x7	185	2017-05-23 18:25:44.844302	2018-10-04 18:22:09.839913	5
365	Extended Business Hours	Extended Business Hours	185	2017-05-23 18:26:27.00538	2018-10-04 18:22:09.84148	3
366	Business Hours	Business Hours	185	2017-05-23 18:26:27.00872	2018-10-04 18:22:09.843003	2
411	Pre-approved but triggered on incident	Pre-approved but triggered on incident	236	2018-06-25 00:15:15.85929	2018-10-04 18:22:09.845759	4
412	Approved and provisioned	Approved and provisioned	236	2018-06-25 00:15:15.863656	2018-10-04 18:22:09.847335	4
413	Approval required at the time of incident	Approval required at the time of incident	236	2018-06-25 00:15:15.869171	2018-10-04 18:22:09.848876	4
332	Remote wiping	Remote wiping	193	2017-05-23 18:01:13.513026	2018-10-04 18:22:09.905295	5
333	Ability to disable access remotely	Ability to disable access remotely	193	2017-05-23 18:01:13.515445	2018-10-04 18:22:09.906777	5
334	Yes	yes	194	2017-05-23 18:02:20.193672	2018-10-04 18:22:09.909367	5
336	Active	Active	195	2017-05-23 18:04:42.168162	2018-10-04 18:22:09.912148	5
337	Approved	Approved	195	2017-05-23 18:04:42.172547	2018-10-04 18:22:09.913641	5
338	Regularly reviewed	Regularly reviewed	195	2017-05-23 18:04:42.17516	2018-10-04 18:22:09.915212	5
339	Published Guideline	Published Guideline	196	2017-05-23 18:09:04.969287	2018-10-04 18:22:09.917946	5
340	Published Tips	Published Tips	196	2017-05-23 18:09:04.976968	2018-10-04 18:22:09.919638	5
341	Regular Training	Regular Training	196	2017-05-23 18:09:04.980108	2018-10-04 18:22:09.921229	5
392	Cyber Theft	Cyber Theft	233	2017-05-31 18:40:33.081763	2018-10-04 18:10:45.413776	5
393	Denial Of Service	Denial Of Service	233	2017-05-31 18:40:33.0836	2018-10-04 18:10:45.416577	5
394	Reputational Risk	Reputational Risk	233	2017-05-31 18:40:33.08529	2018-10-04 18:10:45.418355	5
395	Failure to Safeguard Data	Failure to Safeguard Data	233	2017-05-31 18:40:33.087783	2018-10-04 18:10:45.420467	5
396	Defamation	Defamation	233	2017-05-31 18:40:33.089522	2018-10-04 18:10:45.422248	5
397	Damage to Business	Damage to Business	233	2017-05-31 18:40:33.092135	2018-10-04 18:10:45.424186	5
398	Damage to Customers	Damage to Customers	233	2017-05-31 18:40:33.094121	2018-10-04 18:10:45.426103	5
399	Damage to Third Parties	Damage to Third Parties	233	2017-05-31 18:40:33.096099	2018-10-04 18:10:45.427788	5
400	Post Incidence Public Relations Expenses	Post Incidence Public Relations Expenses	233	2017-05-31 18:40:33.097858	2018-10-04 18:10:45.429711	5
401	Investigative Expenses	Investigative Expenses	233	2017-05-31 18:40:33.099779	2018-10-04 18:10:45.431597	5
258	Yes	yes	164	2017-05-23 17:23:53.434848	2018-10-04 18:10:45.440489	5
266	Yes	yes	168	2017-05-23 17:27:06.250466	2018-10-04 18:10:45.443393	5
270	Yes	yes	171	2017-05-23 17:29:35.303919	2018-10-04 18:10:45.448916	5
402	Periodic Review of Security Policies	Periodic Review of Security Policies	234	2017-05-31 18:43:28.415578	2018-10-04 18:10:45.451964	5
403	Conduct Risk Assessment	Conduct Risk Assessment	234	2017-05-31 18:43:28.419323	2018-10-04 18:10:45.453777	5
404	Conduct Penetration testing	Conduct Penetration testing	234	2017-05-31 18:43:28.42118	2018-10-04 18:10:45.455426	5
405	Review Incidence Response Plan	Review Incidence Response Plan	234	2017-05-31 18:43:28.423672	2018-10-04 18:10:45.456949	5
406	Conduct Vulnerability Assessment	Conduct Vulnerability Assessment	234	2017-05-31 18:43:28.425531	2018-10-04 18:10:45.45845	5
417	26-50%	26-50%	238	2019-09-18 05:31:32.441104	2019-09-18 05:35:08.987803	3
273	New Personnel hired through third parties or agencies	New Personnel hired through third parties or agencies	173	2017-05-23 17:38:21.799559	2018-10-04 18:22:09.792079	5
274	All Vendor supplied personnel	All Vendor supplied personnel	173	2017-05-23 17:38:21.801459	2018-10-04 18:22:09.793697	5
275	All current personnel	All current personnel	173	2017-05-23 17:38:21.805618	2018-10-04 18:22:09.795232	5
276	All non Lawyer staff	All non Lawyer staff	173	2017-05-23 17:38:21.808404	2018-10-04 18:22:09.796817	5
277	All non Para-Legal Staff	All non Para-Legal Staff	173	2017-05-23 17:38:21.81146	2018-10-04 18:22:09.798505	5
287	Password required to be changed every 90 days	Password required to be changed every 90 days	176	2017-05-23 17:40:51.134629	2018-10-04 18:22:09.802543	5
288	Password Complexity required more than 8 char with Capital letters and special Characters	Password Complexity required more than 8 char with Capital letters and special Characters	176	2017-05-23 17:40:51.138469	2018-10-04 18:22:09.804671	5
289	Training users on the best practices for password management	Training users on the best practices for password management	176	2017-05-23 17:40:51.141365	2018-10-04 18:22:09.807075	5
283	Before communicating intent to terminate employment/contract	Before communicating intent to terminate employment/contract	175	2017-05-23 17:40:06.960796	2018-10-04 18:22:09.811418	5
284	After communicating intent but before end of employment/contract	After communicating intent but before end of employment/contract	175	2017-05-23 17:40:06.964203	2018-10-04 18:22:09.813778	5
285	Within 2 weeks of end of employment/contract	Within 2 weeks of end of employment/contract	175	2017-05-23 17:40:06.966411	2018-10-04 18:22:09.816185	5
286	Depends upon level of user / user type	Depends upon level of user / user type	175	2017-05-23 17:40:06.968792	2018-10-04 18:22:09.818421	5
294	Yes	yes	180	2017-05-23 17:44:36.911244	2018-10-04 18:22:09.82563	5
296	Yes	yes	181	2017-05-23 17:44:36.919215	2018-10-04 18:22:09.82838	5
298	Yes	yes	183	2017-05-23 17:48:35.710136	2018-10-04 18:22:09.831137	5
302	Access to select personnel only	Access to select personnel only	187	2017-05-23 17:56:44.839915	2018-10-04 18:22:09.851658	5
303	Visitor log	Visitor log	187	2017-05-23 17:56:44.843176	2018-10-04 18:22:09.853311	5
304	Monitoring (Video, Motion Sensors etc. )	Monitoring (Video, Motion Sensors etc. )	187	2017-05-23 17:56:44.845201	2018-10-04 18:22:09.854811	5
305	Physical Controls (Locs, Keypad access etc. )	Physical Controls (Locs, Keypad access etc. )	187	2017-05-23 17:56:44.847561	2018-10-04 18:22:09.856376	5
306	Specialised third party access controls	Specialised third party access controls	187	2017-05-23 17:56:44.849724	2018-10-04 18:22:09.857917	5
307	Access to select personnel only	Access to select personnel only	188	2017-05-23 17:56:44.853612	2018-10-04 18:22:09.861218	5
308	Monitoring	Monitoring	188	2017-05-23 17:56:44.856294	2018-10-04 18:22:09.862837	5
309	Physical Controls	Physical Controls	188	2017-05-23 17:56:44.85842	2018-10-04 18:22:09.864453	5
310	Specialised third party controls	Specialised third party controls	188	2017-05-23 17:56:44.860631	2018-10-04 18:22:09.866061	5
311	Announcing user name when joined	Announcing user name when joined	189	2017-05-23 18:01:13.46291	2018-10-04 18:22:09.868877	5
312	Beeping user name when joined	Beeping user name when joined	189	2017-05-23 18:01:13.467403	2018-10-04 18:22:09.870425	5
313	Ability to check users on the call	Ability to check users on the call	189	2017-05-23 18:01:13.469262	2018-10-04 18:22:09.872082	5
314	Ability to prevent recording by attendees	Ability to prevent recording by attendees	189	2017-05-23 18:01:13.471884	2018-10-04 18:22:09.873544	5
315	Access using passcode	Access using passcode	189	2017-05-23 18:01:13.473737	2018-10-04 18:22:09.874951	5
316	Encrypted Communication	Encrypted Communication	190	2017-05-23 18:01:13.476937	2018-10-04 18:22:09.877636	5
317	Restricted Access to PBX/VoIP Servers	Restricted Access to PBX/VoIP Servers	190	2017-05-23 18:01:13.478881	2018-10-04 18:22:09.879167	5
318	Restricted Call Forwarding	Restricted Call Forwarding	190	2017-05-23 18:01:13.48087	2018-10-04 18:22:09.880666	5
319	Voice Mail Password Strength	Voice Mail Password Strength	190	2017-05-23 18:01:13.482961	2018-10-04 18:22:09.882132	5
320	Access Controlled	Access Controlled	191	2017-05-23 18:01:13.486105	2018-10-04 18:22:09.884814	5
321	Scan to self	Scan to self	191	2017-05-23 18:01:13.48828	2018-10-04 18:22:09.886297	5
322	Scan to others	Scan to others	191	2017-05-23 18:01:13.490174	2018-10-04 18:22:09.88781	5
323	Scan to external emails restricted	Scan to external emails restricted	191	2017-05-23 18:01:13.492188	2018-10-04 18:22:09.88926	5
324	Encryption enforced on USB/External Hard Drives	Encryption enforced on USB/External Hard Drives	192	2017-05-23 18:01:13.495382	2018-10-04 18:22:09.892094	5
325	DVD/CD copying restricted	DVD/CD copying restricted	192	2017-05-23 18:01:13.497553	2018-10-04 18:22:09.893618	5
326	Use of personal cloud storage restricted	Use of personal cloud storage restricted	192	2017-05-23 18:01:13.499464	2018-10-04 18:22:09.895111	5
327	Use of external VPN restricted	Use of external VPN restricted	192	2017-05-23 18:01:13.5014	2018-10-04 18:22:09.896645	5
328	System Monitoring	System Monitoring	192	2017-05-23 18:01:13.503563	2018-10-04 18:22:09.898104	5
329	Password protection	Password protection	193	2017-05-23 18:01:13.50706	2018-10-04 18:22:09.900829	5
330	Encrypted content	Encrypted content	193	2017-05-23 18:01:13.509014	2018-10-04 18:22:09.902317	5
331	Auto wiping on multiple failed attempts	Auto wiping on multiple failed attempts	193	2017-05-23 18:01:13.511121	2018-10-04 18:22:09.903835	5
342	Testing	Testing	196	2017-05-23 18:09:04.982589	2018-10-04 18:22:09.922669	5
343	Web based self-paced training	Web based self-paced training	197	2017-05-23 18:09:04.987319	2018-10-04 18:22:09.925603	3
344	In person training	In person training	197	2017-05-23 18:09:04.990075	2018-10-04 18:22:09.927148	5
345	Tip sheets	Tip sheets	197	2017-05-23 18:09:04.992701	2018-10-04 18:22:09.928606	1.5
346	Reminders	Reminders	197	2017-05-23 18:09:04.995156	2018-10-04 18:22:09.930077	2
347	Seminars	Seminars	197	2017-05-23 18:09:04.997585	2018-10-04 18:22:09.931951	1
348	Short Videos	Short Videos	197	2017-05-23 18:09:05.000454	2018-10-04 18:22:09.933623	1
349	Web based self-paced training	Web based self-paced training	198	2017-05-23 18:09:05.004939	2018-10-04 18:22:09.936989	3
350	In person training	In person training	198	2017-05-23 18:09:05.007494	2018-10-04 18:22:09.93867	4
351	Tip sheets	Tip sheets	198	2017-05-23 18:09:05.009946	2018-10-04 18:22:09.940769	2
352	Reminders	Reminders	198	2017-05-23 18:09:05.012844	2018-10-04 18:22:09.942444	2
353	Seminars	Seminars	198	2017-05-23 18:09:05.015609	2018-10-04 18:22:09.944087	3
354	Short Videos	Short Videos	198	2017-05-23 18:09:05.018057	2018-10-04 18:22:09.945616	2
358	Yes	yes	202	2017-05-23 18:10:34.384725	2018-10-04 18:22:09.948441	5
372	Training	Training	218	2017-05-31 18:20:52.31849	2018-10-04 18:22:09.951514	5
373	In Person Training	In Person Training	218	2017-05-31 18:20:52.323992	2018-10-04 18:22:09.953267	5
374	Tip Sheets	Tip Sheets	218	2017-05-31 18:20:52.325829	2018-10-04 18:22:09.954733	3
375	Reminders	Reminders	218	2017-05-31 18:20:52.328243	2018-10-04 18:22:09.956614	5
376	Seminars	Seminars	218	2017-05-31 18:20:52.330042	2018-10-04 18:22:09.958332	3
415	Yes	Yes	239	2019-09-18 05:31:32.414851	2019-09-18 05:35:08.978249	5
416	No	No	239	2019-09-18 05:31:32.431614	2019-09-18 05:35:08.983006	0
420	1-25%	1-25%	238	2019-09-18 05:31:32.467196	2019-09-18 05:35:08.985645	5
418	51-75%	51-75%	238	2019-09-18 05:31:32.443545	2019-09-18 05:35:08.99229	1
419	76-100	76-100	238	2019-09-18 05:31:32.445256	2019-09-18 05:35:08.994115	0
421	Yes	Yes	247	2019-09-18 14:30:27.419124	2019-09-18 14:30:27.419124	5
422	No	No	247	2019-09-18 14:30:27.423302	2019-09-18 14:30:27.423302	0
423	Yes	Yes	246	2019-09-18 14:30:27.433078	2019-09-18 14:30:27.433078	5
424	No	No	246	2019-09-18 14:30:27.435426	2019-09-18 14:30:27.435426	5
425	Yes	Yes	245	2019-09-18 14:31:39.181686	2019-09-18 14:31:39.181686	5
426	No	No	245	2019-09-18 14:31:39.185669	2019-09-18 14:31:39.185669	0
427	Yes	Yes	244	2019-09-18 14:31:39.191993	2019-09-18 14:31:39.191993	5
428	No	No	244	2019-09-18 14:31:39.193873	2019-09-18 14:31:39.193873	0
429	Yes	Yes	243	2019-09-18 14:44:15.465874	2019-09-18 14:44:15.465874	5
430	No	No	243	2019-09-18 14:44:15.522421	2019-09-18 14:44:15.522421	0
431	Yes	Yes	242	2019-09-18 14:44:15.567283	2019-09-18 14:44:15.567283	5
432	No	No	242	2019-09-18 14:44:15.569353	2019-09-18 14:44:15.569353	0
433	Yes	Yes	241	2019-09-18 14:45:35.810856	2019-09-18 14:45:35.810856	5
434	No	No	241	2019-09-18 14:45:35.813492	2019-09-18 14:45:35.813492	0
435	>$5,000,000	>$5,000,000	240	2019-09-18 14:45:35.820027	2019-09-18 14:45:35.820027	5
436	>$2,500,000	>$2,500,000	240	2019-09-18 14:45:35.821624	2019-09-18 14:45:35.821624	4
437	>$1,000,000	>$1,000,000	240	2019-09-18 14:45:35.8233	2019-09-18 14:45:35.8233	3
438	>$1	>$1	240	2019-09-18 14:45:35.826052	2019-09-18 14:45:35.826052	2
\.


--
-- Data for Name: exception_requests; Type: TABLE DATA; Schema: public; Owner: manishchhipa
--

COPY public.exception_requests (id, requested_by, user_id, submitted_by_email, line_of_business, lob_contact_name, law_firm_id, request_type, law_firm_category, minority_owned, minority_owned_details, women_owned, women_owned_details, matter_name, created_at, updated_at, matter_types, law_firm_name, business_manager_name, business_manager_phone, business_manager_email, lxp_status, lxp_id, internal_lawyers_status, internal_lawyers_id, pay_type, docusign_envelope_id, notes) FROM stdin;
\.


--
-- Data for Name: faq_categories; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.faq_categories (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: file_attachments; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.file_attachments (id, file, form_value_id, created_at, updated_at, iv, key, attachable_type, attachable_id) FROM stdin;
\.


--
-- Data for Name: follow_ups; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.follow_ups (id, form_submission_id, loggable_type, loggable_id, status, note_id, created_at, updated_at) FROM stdin;
1	2	TechnologyValue	1	resolved	\N	2017-03-06 22:37:12.902628	2017-03-06 22:39:39.875179
2	3	TechnologyValue	13	resolved	\N	2017-03-07 03:13:15.621445	2017-03-07 14:32:04.429564
3	2	FormValue	12	pending	\N	2017-03-15 18:55:41.276601	2017-03-15 18:55:41.276601
4	9	FormValue	134	resolved	\N	2017-03-20 15:33:57.199902	2017-03-20 15:35:25.269405
5	3	TechnologyValue	11	pending	\N	2017-03-20 19:15:50.304108	2017-03-20 19:15:50.304108
6	3	TechnologyValue	14	pending	\N	2017-03-20 19:16:00.054355	2017-03-20 19:16:00.054355
7	10	FormValue	\N	pending	\N	2017-03-20 21:12:06.290935	2017-03-20 21:12:06.290935
8	10	FormValue	\N	pending	\N	2017-03-20 21:12:37.908113	2017-03-20 21:12:37.908113
9	10	FormValue	\N	pending	\N	2017-03-22 17:58:48.470463	2017-03-22 17:58:48.470463
10	10	FormValue	\N	pending	\N	2017-03-22 18:01:20.820024	2017-03-22 18:01:20.820024
15	10	FormValue	\N	pending	\N	2017-03-22 19:03:54.466557	2017-03-22 19:03:54.466557
16	15	FormValue	284	resolved	\N	2017-03-23 13:33:51.43851	2017-03-23 13:41:34.295613
17	15	FormValue	289	resolved	\N	2017-03-23 13:34:02.426463	2017-03-23 13:41:37.081067
18	19	FormValue	478	resolved	\N	2017-03-31 19:45:30.754009	2017-03-31 19:48:16.523713
19	21	FormValue	562	resolved	\N	2017-04-03 19:45:28.941436	2017-04-03 19:46:51.165524
20	21	FormValue	577	resolved	\N	2017-04-03 19:45:47.23714	2017-04-03 19:46:58.706851
21	22	FormValue	641	resolved	\N	2017-04-05 04:17:30.40001	2017-04-05 04:22:49.661307
13	14	FormValue	211	resolved	\N	2017-03-22 18:33:58.885567	2017-04-10 15:23:16.0814
11	14	FormValue	202	review	\N	2017-03-22 18:33:02.544403	2017-03-22 18:33:02.544403
12	14	FormValue	217	review	\N	2017-03-22 18:33:48.244631	2017-03-22 18:33:48.244631
14	14	FormValue	222	review	\N	2017-03-22 18:41:26.016715	2017-03-22 18:41:26.016715
22	14	FormValue	185	review	\N	2017-04-10 15:22:56.005698	2017-04-10 15:22:56.005698
23	28	FormValue	737	review	\N	2017-04-11 21:01:36.313674	2017-04-11 21:01:36.313674
24	29	FormValue	765	resolved	\N	2017-04-12 00:27:41.779263	2017-04-12 00:39:01.024381
25	40	FormValue	1070	review	\N	2017-04-13 00:12:12.607733	2017-04-13 00:12:12.607733
26	51	FormValue	1402	review	\N	2017-04-13 15:18:40.658437	2017-04-13 15:18:40.658437
27	48	FormValue	1333	resolved	\N	2017-04-13 16:30:50.883713	2017-04-13 16:34:24.510157
28	48	FormValue	1351	resolved	\N	2017-04-13 16:30:58.199246	2017-04-13 16:36:09.03556
29	57	HistorySubmission	36	review	\N	2017-04-26 20:16:10.733842	2017-04-26 20:16:10.733842
30	62	HistorySubmission	45	review	\N	2017-05-04 15:44:37.053235	2017-05-04 15:44:37.053235
31	63	FormValue	2011	review	\N	2017-05-04 18:21:28.931914	2017-05-04 18:21:28.931914
32	64	FormValue	2047	review	\N	2017-05-04 19:29:30.281225	2017-05-04 19:29:30.281225
33	65	FormValue	2090	review	\N	2017-05-05 13:50:07.308338	2017-05-05 13:50:07.308338
34	66	FormValue	2131	review	\N	2017-05-08 17:50:10.029616	2017-05-08 17:50:10.029616
35	69	FormValue	2221	resolved	\N	2017-05-09 15:09:38.776253	2017-05-09 15:12:08.774184
58	79	FormValue	2797	resolved	\N	2017-06-01 15:01:41.639442	2017-06-01 15:05:37.37186
59	79	FormValue	2861	resolved	\N	2017-06-01 15:03:17.480054	2017-06-01 15:05:52.869245
36	71	FormValue	2263	resolved	\N	2017-05-09 16:45:58.059441	2017-05-09 16:58:49.288213
37	71	FormValue	2287	resolved	\N	2017-05-09 16:48:25.311982	2017-05-09 16:59:18.735813
38	72	FormValue	2305	review	\N	2017-05-09 17:20:06.820903	2017-05-09 17:20:06.820903
39	72	FormValue	2307	review	\N	2017-05-09 17:22:31.74983	2017-05-09 17:22:31.74983
40	72	FormValue	2306	review	\N	2017-05-09 17:29:55.810073	2017-05-09 17:29:55.810073
60	81	FormValue	2963	resolved	\N	2017-06-05 17:55:08.907446	2017-06-05 17:57:13.64982
61	82	FormValue	3033	pending	\N	2017-06-06 15:00:59.759801	2017-06-06 15:00:59.759801
41	73	FormValue	2379	resolved	\N	2017-05-11 15:25:02.770106	2017-05-11 15:38:21.803077
42	73	FormValue	2380	resolved	\N	2017-05-11 15:25:14.924315	2017-05-11 15:38:35.337861
43	73	FormValue	2390	resolved	\N	2017-05-11 15:25:25.158327	2017-05-11 15:38:46.718788
44	73	FormValue	2388	resolved	\N	2017-05-11 15:25:42.09484	2017-05-11 15:38:52.365058
46	73	FormValue	2393	resolved	\N	2017-05-11 15:26:00.127709	2017-05-11 15:38:56.833001
47	73	FormValue	2394	resolved	\N	2017-05-11 15:26:07.154974	2017-05-11 15:38:59.328648
48	73	FormValue	2397	resolved	\N	2017-05-11 15:26:23.936523	2017-05-11 15:39:04.416767
49	73	FormValue	2398	resolved	\N	2017-05-11 15:26:31.80911	2017-05-11 15:39:06.984234
50	73	FormValue	2410	resolved	\N	2017-05-11 15:26:38.764684	2017-05-11 15:39:19.334043
51	73	FormValue	2399	resolved	\N	2017-05-11 15:26:48.787808	2017-05-11 15:39:21.727408
52	73	FormValue	2411	resolved	\N	2017-05-11 15:26:53.901762	2017-05-11 15:39:24.00502
53	73	FormValue	2412	resolved	\N	2017-05-11 15:26:59.112004	2017-05-11 15:39:25.964147
54	73	FormValue	2400	resolved	\N	2017-05-11 15:27:04.856326	2017-05-11 15:39:28.042202
55	73	FormValue	2401	resolved	\N	2017-05-11 15:27:11.350622	2017-05-11 15:39:30.253205
57	73	FormValue	2403	resolved	\N	2017-05-11 15:27:23.431384	2017-05-11 15:39:36.342599
56	73	FormValue	2402	resolved	\N	2017-05-11 15:27:17.156916	2017-05-11 15:40:11.38049
45	73	FormValue	2392	resolved	\N	2017-05-11 15:25:51.145632	2017-05-11 15:40:19.978363
62	83	FormValue	3062	resolved	\N	2017-06-07 16:49:18.36074	2017-06-07 17:01:09.194913
73	91	FormValue	3580	resolved	\N	2017-06-13 15:08:12.832952	2017-06-13 15:08:21.95533
74	91	FormValue	3581	resolved	\N	2017-06-13 15:08:28.371411	2017-06-16 15:36:18.236866
63	85	FormValue	3130	resolved	\N	2017-06-07 17:41:24.804446	2017-06-07 17:47:41.91938
64	85	FormValue	3131	resolved	\N	2017-06-07 17:41:57.809153	2017-06-07 17:47:45.728637
65	85	FormValue	3152	resolved	\N	2017-06-07 17:42:28.138522	2017-06-07 17:47:55.996827
66	85	FormValue	3179	resolved	\N	2017-06-07 17:42:58.030024	2017-06-07 17:47:58.606579
67	85	TechnologyValue	161	resolved	\N	2017-06-07 17:43:34.423648	2017-06-07 17:48:07.00811
68	85	TechnologyValue	163	resolved	\N	2017-06-07 17:43:41.791694	2017-06-07 17:48:13.350752
69	88	FormValue	3250	review	\N	2017-06-08 18:27:39.784721	2017-06-08 18:27:39.784721
70	88	FormValue	3258	review	\N	2017-06-08 18:28:07.645016	2017-06-08 18:28:07.645016
71	88	FormValue	3277	review	\N	2017-06-08 18:29:03.76728	2017-06-08 18:29:03.76728
72	90	TechnologyValue	178	resolved	\N	2017-06-12 19:36:43.472549	2017-06-12 19:39:51.479597
75	96	TechnologyValue	201	resolved	\N	2017-06-22 19:10:18.160494	2017-06-22 19:14:50.339944
76	97	FormValue	4044	pending	\N	2017-06-22 19:48:02.694183	2017-06-22 19:48:02.694183
77	97	FormValue	4055	pending	\N	2017-06-22 19:55:07.548805	2017-06-22 19:55:07.548805
78	97	FormValue	4051	pending	\N	2017-06-22 19:55:14.935017	2017-06-22 19:55:14.935017
79	85	TechnologyValue	164	pending	\N	2017-06-22 19:57:34.855642	2017-06-22 19:57:34.855642
80	105	FormValue	4598	review	\N	2018-10-04 18:23:30.963894	2018-10-04 18:23:30.963894
81	105	FormValue	4634	review	\N	2018-10-04 18:23:54.574572	2018-10-04 18:23:54.574572
82	105	FormValue	4655	review	\N	2018-10-04 18:24:09.728813	2018-10-04 18:24:09.728813
87	121	FormValue	4885	review	\N	2019-10-18 17:46:43.431631	2019-10-18 17:46:43.431631
85	120	FormValue	4873	resolved	\N	2019-10-17 17:57:14.556456	2019-10-17 18:20:14.887563
84	120	FormValue	4872	resolved	\N	2019-10-17 17:56:59.260354	2019-10-17 18:20:17.774482
86	121	FormValue	4884	review	\N	2019-10-18 17:43:19.054606	2019-10-18 17:43:19.054606
88	121	FormValue	4886	review	\N	2019-10-18 18:34:16.064665	2019-10-18 18:34:16.064665
89	121	FormValue	4890	review	\N	2019-10-18 19:42:30.460501	2019-10-18 19:42:30.460501
\.


--
-- Data for Name: form_fields; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.form_fields (id, min, max, required, label, type, created_at, updated_at, form_id, formable_id, formable_type, parent_id, "position", group_form_id, repeater, custom_logic, show_when_form_field_id, show_when_form_field_value, scored, score, help_description) FROM stdin;
241	\N	\N	f	Is your firm a customer of BMO?	DropdownField	2019-09-18 14:23:13.142246	2019-10-18 17:41:50.113311	\N	24	Form	\N	0	\N	\N	\N	\N	\N	\N	\N	Is your firm a customer of BMO?
240	\N	\N	f	What isthe dollar amount of your firm’s banking relationship? ($) 	DropdownField	2019-09-18 14:23:13.129915	2019-10-18 17:41:50.122264	\N	24	Form	\N	1	\N	\N	\N	\N	\N	\N	\N	What isthe dollar amount of your firm’s banking relationship? ($) 
247	\N	\N	f	Does your firm use Legal Process Outsourcing?	DropdownField	2019-09-18 14:28:41.509799	2019-10-18 17:42:08.227179	\N	27	Form	\N	0	\N	\N	\N	\N	\N	\N	\N	Does your firm use Legal Process Outsourcing?
246	\N	\N	f	Does your firm use alternative internal legal professional sourcing (non-partnership track lawyers; paralegals, etc.)?	DropdownField	2019-09-18 14:28:41.504787	2019-10-18 17:42:08.259273	\N	27	Form	\N	1	\N	\N	\N	\N	\N	\N	\N	Does your firm use alternative internal legal professional sourcing (non-partnership track lawyers; paralegals, etc.)?
243	\N	\N	f	Is your firm a certified minority/woman owned firm?	DropdownField	2019-09-18 14:28:01.559238	2019-10-18 17:42:00.752868	\N	25	Form	\N	0	\N	\N	\N	\N	\N	\N	\N	Is your firm a certified minority/woman owned firm?
242	\N	\N	f	Does your firm have an internal program for regularly tracking diversity?	DropdownField	2019-09-18 14:28:01.550587	2019-10-18 17:42:00.763098	\N	25	Form	\N	1	\N	\N	\N	\N	\N	\N	\N	Does your firm have an internal program for regularly tracking diversity?
245	\N	\N	f	Does your firm have internal process improvement initiatives	DropdownField	2019-09-18 14:28:21.450074	2019-10-18 17:42:08.052207	\N	26	Form	\N	0	\N	\N	\N	\N	\N	\N	\N	Does your firm have internal process improvement initiatives
244	\N	\N	f	Does your firm have client-facing process improvement initiatives?	DropdownField	2019-09-18 14:28:21.445163	2019-10-18 17:42:08.061768	\N	26	Form	\N	1	\N	\N	\N	\N	\N	\N	\N	Does your firm have client-facing process improvement initiatives?
174	\N	\N	f	For personnel that have access to Bank Information , which of the following are required to sign Confidentiality Agreement	MultiSelectField	2017-05-23 17:38:21.814463	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
191	\N	\N	f	What are the steps taken to unauthorized access to Fax and Scanners?	MultiSelectField	2017-05-23 17:54:23.397508	2019-09-18 05:29:58.28038	\N	21	Form	\N	11	\N	\N	\N	\N	\N	\N	\N	
235	\N	\N	f	Upload Evidence.	UploadField	2017-05-31 18:43:28.428114	2019-09-18 05:29:58.28038	\N	20	Form	171	3	\N	\N	\N	\N	\N	\N	5	
166	\N	\N	f	Where is Bank Information stored?	MultiSelectField	2017-05-23 17:24:30.970452	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
171	\N	\N	f	Have you retained a “Managed Security Service Provider” to assist with firm’s Information security Initiatives?	DropdownField	2017-05-23 17:29:17.055671	2019-09-18 05:29:58.28038	\N	20	Form	\N	5	\N	\N	\N	\N	\N	\N	\N	
233	\N	\N	f	Select all coverages that apply	MultiSelectField	2017-05-31 18:38:59.57704	2019-09-18 05:29:58.28038	\N	20	Form	162	3	\N	\N	\N	\N	\N	\N	\N	
192	\N	\N	f	What controls are in place to prevent mass unauthorized data transfer by employees?	MultiSelectField	2017-05-23 17:54:23.400178	2019-09-18 05:29:58.28038	\N	21	Form	\N	12	\N	\N	\N	\N	\N	\N	\N	
193	\N	\N	f	What controls are in place to prevent unauthorized access to a lost device with bank information?	MultiSelectField	2017-05-23 17:54:23.402711	2019-09-18 05:29:58.28038	\N	21	Form	\N	13	\N	\N	\N	\N	\N	\N	\N	
196	\N	\N	f	What measures do you take to ensure that your user population is able to identify if information is confidential or not?  Select all that apply.	MultiSelectField	2017-05-23 18:04:42.177895	2019-09-18 05:29:58.28038	\N	21	Form	\N	15	\N	\N	\N	\N	\N	\N	\N	
161	\N	\N	f	Cyber security standards	CyberSecurityStandardField	2017-05-23 17:21:20.460207	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	5	test
160	\N	\N	f	Please enter all information security policies that are in effect at your law firm.	InformationSecurityPolicyField	2017-05-23 17:21:20.444323	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	5	Please upload listed policies and evidence supporting Communication Status such as email, site link etc.
163	\N	\N	f	List all providers	CyberSecurityInsuranceField	2017-05-23 17:22:21.215647	2019-09-18 05:29:58.28038	\N	20	Form	162	3	\N	\N	\N	\N	\N	\N	5	
162	\N	\N	f	Do you have a Cyber Security Insurance Policy (or related policy) that protects against losses resulting from breaches?	DropdownField	2017-05-23 17:21:20.464943	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
167	\N	\N	f	If you directly use a cloud provider to store Bank Information, please provide the following:	CloudProviderField	2017-05-23 17:26:23.87343	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	2	
165	\N	\N	f	List other organization that you may have shared the bank information with (Such as eDiscovery firms, process servers, legal process outsourcers, consulting firms etc. )	SharedBankInformationField	2017-05-23 17:23:53.442231	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	3.5	
234	\N	\N	f	List any services provided to you by a Managed Security Company: 	MultiSelectField	2017-05-31 18:42:05.378547	2019-09-18 05:29:58.28038	\N	20	Form	171	3	\N	\N	\N	\N	\N	\N	\N	
164	\N	\N	f	Is the bank named as additional insured on this policy.	DropdownField	2017-05-23 17:22:53.114122	2019-09-18 05:29:58.28038	\N	20	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
168	\N	\N	f	Do you have Information Security Officer(s) on staff?	DropdownField	2017-05-23 17:26:23.879087	2019-09-18 05:29:58.28038	\N	20	Form	\N	4	\N	\N	\N	\N	\N	\N	\N	
177	\N	\N	f	Do you have an InfoSec Threat Model for your firm?	DropdownField	2017-05-23 17:40:51.144532	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
195	\N	\N	f	Select all that applies	MultiSelectField	2017-05-23 18:02:20.201451	2019-09-18 05:29:58.28038	\N	21	Form	194	3	\N	\N	\N	\N	\N	\N	\N	
194	\N	\N	f	Do you have an information security best practices document ?	DropdownField	2017-05-23 18:01:36.428993	2019-09-18 05:29:58.28038	\N	21	Form	\N	14	\N	\N	\N	\N	\N	\N	\N	
199	\N	\N	f	How do you test the preparedness of users with elevated access?	MultiSelectField	2017-05-23 18:04:42.190316	2019-09-18 05:29:58.28038	\N	21	Form	217	10	\N	\N	\N	\N	\N	\N	\N	
217	\N	\N	f	Do you provide security training to users with elevated access?	DropdownField	2017-05-31 18:03:52.85846	2019-09-18 05:29:58.28038	\N	21	Form	\N	17	\N	\N	\N	\N	\N	\N	\N	
218	\N	\N	f	What measures do you take to ensure that your user population is familiar with and trained on security best practices? Select all that apply.	MultiSelectField	2017-05-31 18:19:23.806488	2019-09-18 05:29:58.28038	\N	21	Form	\N	20	\N	\N	\N	\N	\N	\N	\N	
221	\N	\N	f	If yes, date of last review?	DateField	2017-05-31 18:24:27.858425	2019-09-18 05:29:58.28038	\N	21	Form	220	3	\N	\N	\N	\N	\N	\N	\N	
223	\N	\N	f	Does the information security incidence response team have elevated access levels that are accessible and kept in secured storage for emergencies?	DropdownField	2017-05-31 18:26:24.420147	2019-09-18 05:29:58.28038	\N	21	Form	224	3	\N	\N	\N	\N	\N	\N	\N	
226	\N	\N	f	Are they external to your firm? 	DropdownField	2017-05-31 18:30:50.328577	2019-09-18 05:29:58.28038	\N	21	Form	224	3	\N	\N	\N	\N	\N	\N	\N	
225	\N	\N	f	Are they internal to your firm?	DropdownField	2017-05-31 18:30:50.319383	2019-09-18 05:29:58.28038	\N	21	Form	224	3	\N	\N	\N	\N	\N	\N	\N	
224	\N	\N	f	Do you have 24x7 access to a trained information security incidence response team that can mitigate active threats? 	DropdownField	2017-05-31 18:28:48.443395	2019-09-18 05:29:58.28038	\N	21	Form	\N	22	\N	\N	\N	\N	\N	\N	\N	
169	\N	\N	f	Are they Certified or Trained in Information Security?	DropdownField	2017-05-23 17:27:06.256327	2019-09-18 05:29:58.28038	\N	20	Form	168	3	\N	\N	\N	\N	\N	\N	\N	
175	\N	\N	f	When is system access revoked when terminating personnel. (i.e contractors, lawyers, vendors , non-lawyers)	MultiSelectField	2017-05-23 17:39:14.874014	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
209	\N	\N	f	If it’s tested, date of last tested	DateField	2017-05-31 15:13:29.470015	2019-09-18 05:29:58.28038	\N	21	Form	180	3	\N	\N	\N	\N	\N	\N	\N	
206	\N	\N	f	If it’s reviewed internally, date of review	DateField	2017-05-31 15:09:16.554342	2019-09-18 05:29:58.28038	\N	21	Form	177	3	\N	\N	\N	\N	\N	\N	\N	
216	\N	\N	f	Upload the incident response plan	UploadField	2017-05-31 15:38:05.672284	2019-09-18 05:29:58.28038	\N	21	Form	181	3	\N	\N	\N	\N	\N	\N	\N	
176	\N	\N	f	What controls are in place around password protection?	MultiSelectField	2017-05-23 17:40:06.971696	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
211	\N	\N	f	If yes, when was it last reviewed internally? 	DateField	2017-05-31 15:32:39.77892	2019-09-18 05:29:58.28038	\N	21	Form	181	3	\N	\N	\N	\N	\N	\N	\N	
182	\N	\N	f	Please provide date of the following activities.	ActivityTimeLogField	2017-05-23 17:47:09.549451	2019-09-18 05:29:58.28038	\N	21	Form	\N	5	\N	\N	\N	\N	\N	\N	\N	
184	\N	\N	f	CISRT Team is	DropdownField	2017-05-23 17:48:35.71551	2019-09-18 05:29:58.28038	\N	21	Form	183	3	\N	\N	\N	\N	\N	\N	\N	
187	\N	\N	f	What are the steps taken to unauthorized access to File Rooms	MultiSelectField	2017-05-23 17:54:23.386362	2019-09-18 05:29:58.28038	\N	21	Form	\N	7	\N	\N	\N	\N	\N	\N	\N	
188	\N	\N	f	What are the steps taken to unauthorized access to Server Rooms?	MultiSelectField	2017-05-23 17:54:23.38948	2019-09-18 05:29:58.28038	\N	21	Form	\N	8	\N	\N	\N	\N	\N	\N	\N	
189	\N	\N	f	What are the steps taken to unauthorized access to Conference Calls?	MultiSelectField	2017-05-23 17:54:23.392034	2019-09-18 05:29:58.28038	\N	21	Form	\N	9	\N	\N	\N	\N	\N	\N	\N	
190	\N	\N	f	What are the steps taken to unauthorized access to Telephone conversations	MultiSelectField	2017-05-23 17:54:23.394825	2019-09-18 05:29:58.28038	\N	21	Form	\N	10	\N	\N	\N	\N	\N	\N	\N	
201	\N	\N	f	Upload evidence of training.	UploadField	2017-05-23 18:05:51.622983	2019-09-18 05:29:58.28038	\N	21	Form	198	3	\N	\N	\N	\N	\N	\N	\N	
203	\N	\N	f	Please Upload.	UploadField	2017-05-23 18:10:34.394142	2019-09-18 05:29:58.28038	\N	21	Form	202	3	\N	\N	\N	\N	\N	\N	\N	
219	\N	\N	f	Upload evidence that such training occurs and on a regular and timely basis	UploadField	2017-05-31 18:20:52.334203	2019-09-18 05:29:58.28038	\N	21	Form	218	3	\N	\N	\N	\N	\N	\N	\N	
222	\N	\N	f	Upload evidence	UploadField	2017-05-31 18:24:27.865733	2019-09-18 05:29:58.28038	\N	21	Form	220	3	\N	\N	\N	\N	\N	\N	\N	
220	\N	\N	f	Do you have an active, approved and regularly reviewed information security best practices document (or similar)?	DropdownField	2017-05-31 18:22:42.480235	2019-09-18 05:29:58.28038	\N	21	Form	\N	21	\N	\N	\N	\N	\N	\N	\N	
210	\N	\N	f	Date of last review	DateField	2017-05-31 15:13:29.475255	2019-09-18 05:29:58.28038	\N	21	Form	180	3	\N	\N	\N	\N	\N	\N	\N	
213	\N	\N	f	Upload Evidence	UploadField	2017-05-31 15:34:24.434949	2019-09-18 05:29:58.28038	\N	21	Form	177	3	\N	\N	\N	\N	\N	\N	\N	
180	\N	\N	f	Do you have an intrusion detection plan?	DropdownField	2017-05-23 17:44:15.065704	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
205	\N	\N	f	If it’s reviewed externally, date of review	DateField	2017-05-31 15:09:16.545624	2019-09-18 05:29:58.28038	\N	21	Form	177	3	\N	\N	\N	\N	\N	\N	\N	
173	\N	\N	f	Who do you do background checks on?	MultiSelectField	2017-05-23 17:36:54.650313	2019-09-18 05:29:58.28038	\N	21	Form	172	3	\N	\N	\N	\N	\N	\N	\N	
172	\N	\N	f	Do you conduct security background checks on personnel/users?	DropdownField	2017-05-23 17:36:34.185087	2019-09-18 05:29:58.28038	\N	21	Form	\N	3	\N	\N	\N	\N	\N	\N	\N	
212	\N	\N	f	If yes, when was it last reviewed externally? 	DateField	2017-05-31 15:32:39.784547	2019-09-18 05:29:58.28038	\N	21	Form	181	3	\N	\N	\N	\N	\N	\N	\N	
185	\N	\N	f	Availability	DropdownField	2017-05-23 17:48:35.71904	2019-09-18 05:29:58.28038	\N	21	Form	183	3	\N	\N	\N	\N	\N	\N	\N	
181	\N	\N	f	Do you have an Incident Response Plan?	DropdownField	2017-05-23 17:44:15.069844	2019-09-18 05:29:58.28038	\N	21	Form	\N	4	\N	\N	\N	\N	\N	\N	\N	
236	\N	\N	f	Access	MultiSelectField	2018-06-25 00:13:44.778446	2019-09-18 05:29:58.28038	\N	21	Form	183	5	\N	\N	\N	\N	\N	\N	\N	
200	\N	\N	f	Upload evidence of training.	UploadField	2017-05-23 18:05:51.616688	2019-09-18 05:29:58.28038	\N	21	Form	197	3	\N	\N	\N	\N	\N	\N	\N	
183	\N	\N	f	Do you have an access to a Computer Security Incident Response Team (CSIRT)	DropdownField	2017-05-23 17:47:38.993367	2019-09-18 05:29:58.28038	\N	21	Form	\N	6	\N	\N	\N	\N	\N	\N	\N	
197	\N	\N	f	What type of training is provided to ensure that all personnel are well versed with security best practices.	MultiSelectField	2017-05-23 18:04:42.181567	2019-09-18 05:29:58.28038	\N	21	Form	\N	16	\N	\N	\N	\N	\N	\N	\N	
198	\N	\N	f	What steps are taken to ensure security training for users with elevated access to bank information.	MultiSelectField	2017-05-23 18:04:42.185137	2019-09-18 05:29:58.28038	\N	21	Form	\N	17	\N	\N	\N	\N	\N	\N	\N	
202	\N	\N	f	Do you have a breach declaration policy that controls who, when and how affected and/or concerned parties are notified?	DropdownField	2017-05-23 18:09:51.21918	2019-09-18 05:29:58.28038	\N	21	Form	\N	19	\N	\N	\N	\N	\N	\N	\N	
239	\N	\N	f	Percentage of matters that required revised pricing	DropdownField	2019-09-18 05:29:58.280129	2019-11-04 14:45:22.172447	\N	23	Form	\N	0	\N	\N	\N	\N	\N	\N	\N	Percentage of matters that required revised pricing
238	\N	\N	f	Does your firm prepare, track and share budgets with BMO? 	DropdownField	2019-09-18 05:29:58.160134	2019-11-04 14:45:22.190222	\N	23	Form	\N	1	\N	\N	\N	\N	\N	\N	\N	Does your firm prepare, track and share budgets with BMO? 
\.


--
-- Data for Name: form_submissions; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.form_submissions (id, name, created_at, updated_at, form_id, form_process_id, submitted, submitted_on, law_firm_id, total_score, status, reason, assessor_score, system_score, expiry_date, locked_by_id, locked_at, last_submitted_by_id, approved_at, evidence_status, form_relationship_id, form_diversity_id, form_innovation_id, form_resourcing_id) FROM stdin;
115	\N	2019-09-27 13:50:07.915958	2019-09-27 13:50:07.915958	23	\N	f	\N	105	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
117	\N	2019-10-04 14:56:42.766457	2019-10-04 14:56:42.766457	23	\N	f	\N	110	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
116	\N	2019-10-04 14:42:13.586503	2019-10-07 16:05:46.328067	23	\N	f	\N	109	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
118	\N	2019-10-10 04:46:54.526923	2019-10-10 04:47:02.261735	23	\N	f	\N	112	\N	started	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
119	\N	2019-10-17 15:07:39.239678	2019-10-17 15:07:39.239678	23	\N	f	\N	113	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
121	\N	2019-10-18 17:28:46.93553	2019-10-18 19:43:15.706518	23	\N	t	2019-10-18 19:42:59.46504	115	\N	approved	\N	\N	2.60000000000000009	2020-10-19	\N	\N	121	2019-10-18 19:43:15.703507	\N	24	25	26	27
122	\N	2019-11-04 14:45:15.151951	2019-11-04 14:45:22.193898	23	\N	f	\N	123	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
123	\N	2019-11-06 04:33:55.658136	2019-11-06 04:33:55.658136	23	\N	f	\N	127	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
124	\N	2019-11-07 15:43:23.772637	2019-11-07 15:43:23.772637	23	\N	f	\N	128	\N	sent	\N	\N	\N	\N	\N	\N	\N	\N	\N	24	25	26	27
120	\N	2019-10-17 15:28:25.398953	2019-10-17 18:21:34.603033	23	\N	t	2019-10-17 18:20:41.223785	114	\N	approved	\N	\N	3.60000000000000009	2020-10-17	\N	\N	120	2019-10-17 18:21:34.60194	\N	24	25	26	27
113	\N	2019-09-18 20:08:48.29677	2019-09-18 20:36:51.731021	23	\N	t	2019-09-18 20:17:03.058551	103	3.60000000000000009	approved	\N	4	2.10000000000000009	2020-09-19	\N	\N	101	2019-09-18 20:27:46.305031	\N	24	25	26	27
114	\N	2019-09-24 14:37:47.529782	2019-09-25 03:03:59.998303	23	\N	f	\N	104	\N	started	\N	\N	\N	\N	\N	\N	102	\N	\N	24	25	26	27
\.


--
-- Data for Name: form_values; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.form_values (id, form_field_id, submittable_id, value, created_at, updated_at, submittable_type, form_field_label, file_value, checked, form_value_iv, form_value_key, multi_select_value) FROM stdin;
4802	174	110	\N	2019-09-18 04:51:39.496604	2019-09-18 04:51:39.496604	FormSubmission	For personnel that have access to Bank Information , which of the following are required to sign Confidentiality Agreement	\N	f	\N	\N	\N
4803	175	110	\N	2019-09-18 04:51:39.520222	2019-09-18 04:51:39.520222	FormSubmission	When is system access revoked when terminating personnel. (i.e contractors, lawyers, vendors , non-lawyers)	\N	f	\N	\N	\N
4804	180	110	\N	2019-09-18 04:51:39.537499	2019-09-18 04:51:39.537499	FormSubmission	Do you have an intrusion detection plan?	\N	f	\N	\N	\N
4805	177	110	\N	2019-09-18 04:51:39.554885	2019-09-18 04:51:39.554885	FormSubmission	Do you have an InfoSec Threat Model for your firm?	\N	f	\N	\N	\N
4806	172	110	\N	2019-09-18 04:51:39.59073	2019-09-18 04:51:39.59073	FormSubmission	Do you conduct security background checks on personnel/users?	\N	f	\N	\N	\N
4807	176	110	\N	2019-09-18 04:51:39.620492	2019-09-18 04:51:39.620492	FormSubmission	What controls are in place around password protection?	\N	f	\N	\N	\N
4808	181	110	\N	2019-09-18 04:51:39.643482	2019-09-18 04:51:39.643482	FormSubmission	Do you have an Incident Response Plan?	\N	f	\N	\N	\N
4809	182	110	\N	2019-09-18 04:51:39.658935	2019-09-18 04:51:39.658935	FormSubmission	Please provide date of the following activities.	\N	f	\N	\N	\N
4810	183	110	\N	2019-09-18 04:51:39.673688	2019-09-18 04:51:39.673688	FormSubmission	Do you have an access to a Computer Security Incident Response Team (CSIRT)	\N	f	\N	\N	\N
4811	187	110	\N	2019-09-18 04:51:39.687496	2019-09-18 04:51:39.687496	FormSubmission	What are the steps taken to unauthorized access to File Rooms	\N	f	\N	\N	\N
4812	188	110	\N	2019-09-18 04:51:39.700592	2019-09-18 04:51:39.700592	FormSubmission	What are the steps taken to unauthorized access to Server Rooms?	\N	f	\N	\N	\N
4813	189	110	\N	2019-09-18 04:51:39.722188	2019-09-18 04:51:39.722188	FormSubmission	What are the steps taken to unauthorized access to Conference Calls?	\N	f	\N	\N	\N
4814	190	110	\N	2019-09-18 04:51:39.73853	2019-09-18 04:51:39.73853	FormSubmission	What are the steps taken to unauthorized access to Telephone conversations	\N	f	\N	\N	\N
4815	191	110	\N	2019-09-18 04:51:39.75445	2019-09-18 04:51:39.75445	FormSubmission	What are the steps taken to unauthorized access to Fax and Scanners?	\N	f	\N	\N	\N
4816	192	110	\N	2019-09-18 04:51:39.773005	2019-09-18 04:51:39.773005	FormSubmission	What controls are in place to prevent mass unauthorized data transfer by employees?	\N	f	\N	\N	\N
4817	193	110	\N	2019-09-18 04:51:39.789001	2019-09-18 04:51:39.789001	FormSubmission	What controls are in place to prevent unauthorized access to a lost device with bank information?	\N	f	\N	\N	\N
4818	194	110	\N	2019-09-18 04:51:39.804565	2019-09-18 04:51:39.804565	FormSubmission	Do you have an information security best practices document ?	\N	f	\N	\N	\N
4819	196	110	\N	2019-09-18 04:51:39.818641	2019-09-18 04:51:39.818641	FormSubmission	What measures do you take to ensure that your user population is able to identify if information is confidential or not?  Select all that apply.	\N	f	\N	\N	\N
4820	197	110	\N	2019-09-18 04:51:39.830121	2019-09-18 04:51:39.830121	FormSubmission	What type of training is provided to ensure that all personnel are well versed with security best practices.	\N	f	\N	\N	\N
4821	198	110	\N	2019-09-18 04:51:39.850968	2019-09-18 04:51:39.850968	FormSubmission	What steps are taken to ensure security training for users with elevated access to bank information.	\N	f	\N	\N	\N
4822	217	110	\N	2019-09-18 04:51:39.871473	2019-09-18 04:51:39.871473	FormSubmission	Do you provide security training to users with elevated access?	\N	f	\N	\N	\N
4823	202	110	\N	2019-09-18 04:51:39.888622	2019-09-18 04:51:39.888622	FormSubmission	Do you have a breach declaration policy that controls who, when and how affected and/or concerned parties are notified?	\N	f	\N	\N	\N
4824	218	110	\N	2019-09-18 04:51:39.911852	2019-09-18 04:51:39.911852	FormSubmission	What measures do you take to ensure that your user population is familiar with and trained on security best practices? Select all that apply.	\N	f	\N	\N	\N
4825	220	110	\N	2019-09-18 04:51:39.92976	2019-09-18 04:51:39.92976	FormSubmission	Do you have an active, approved and regularly reviewed information security best practices document (or similar)?	\N	f	\N	\N	\N
4826	224	110	\N	2019-09-18 04:51:39.946427	2019-09-18 04:51:39.946427	FormSubmission	Do you have 24x7 access to a trained information security incidence response team that can mitigate active threats? 	\N	f	\N	\N	\N
4827	210	110	\N	2019-09-18 04:51:40.104832	2019-09-18 04:51:40.104832	FormSubmission	Date of last review	\N	f	\N	\N	\N
4828	209	110	\N	2019-09-18 04:51:40.134913	2019-09-18 04:51:40.134913	FormSubmission	If it’s tested, date of last tested	\N	f	\N	\N	\N
4829	213	110	\N	2019-09-18 04:51:40.286665	2019-09-18 04:51:40.286665	FormSubmission	Upload Evidence	\N	f	\N	\N	\N
4830	206	110	\N	2019-09-18 04:51:40.326389	2019-09-18 04:51:40.326389	FormSubmission	If it’s reviewed internally, date of review	\N	f	\N	\N	\N
4831	205	110	\N	2019-09-18 04:51:40.351519	2019-09-18 04:51:40.351519	FormSubmission	If it’s reviewed externally, date of review	\N	f	\N	\N	\N
4832	173	110	\N	2019-09-18 04:51:40.548918	2019-09-18 04:51:40.548918	FormSubmission	Who do you do background checks on?	\N	f	\N	\N	\N
4833	216	110	\N	2019-09-18 04:51:40.682149	2019-09-18 04:51:40.682149	FormSubmission	Upload the incident response plan	\N	f	\N	\N	\N
4834	211	110	\N	2019-09-18 04:51:40.712174	2019-09-18 04:51:40.712174	FormSubmission	If yes, when was it last reviewed internally? 	\N	f	\N	\N	\N
4835	212	110	\N	2019-09-18 04:51:40.735419	2019-09-18 04:51:40.735419	FormSubmission	If yes, when was it last reviewed externally? 	\N	f	\N	\N	\N
4836	185	110	\N	2019-09-18 04:51:40.94787	2019-09-18 04:51:40.94787	FormSubmission	Availability	\N	f	\N	\N	\N
4837	184	110	\N	2019-09-18 04:51:40.976101	2019-09-18 04:51:40.976101	FormSubmission	CISRT Team is	\N	f	\N	\N	\N
4838	236	110	\N	2019-09-18 04:51:40.995411	2019-09-18 04:51:40.995411	FormSubmission	Access	\N	f	\N	\N	\N
4839	195	110	\N	2019-09-18 04:51:41.312066	2019-09-18 04:51:41.312066	FormSubmission	Select all that applies	\N	f	\N	\N	\N
4840	200	110	\N	2019-09-18 04:51:41.430886	2019-09-18 04:51:41.430886	FormSubmission	Upload evidence of training.	\N	f	\N	\N	\N
4841	201	110	\N	2019-09-18 04:51:41.522675	2019-09-18 04:51:41.522675	FormSubmission	Upload evidence of training.	\N	f	\N	\N	\N
4842	199	110	\N	2019-09-18 04:51:41.603647	2019-09-18 04:51:41.603647	FormSubmission	How do you test the preparedness of users with elevated access?	\N	f	\N	\N	\N
4843	203	110	\N	2019-09-18 04:51:41.682065	2019-09-18 04:51:41.682065	FormSubmission	Please Upload.	\N	f	\N	\N	\N
4844	219	110	\N	2019-09-18 04:51:41.767608	2019-09-18 04:51:41.767608	FormSubmission	Upload evidence that such training occurs and on a regular and timely basis	\N	f	\N	\N	\N
4845	222	110	\N	2019-09-18 04:51:41.849398	2019-09-18 04:51:41.849398	FormSubmission	Upload evidence	\N	f	\N	\N	\N
4846	221	110	\N	2019-09-18 04:51:41.874739	2019-09-18 04:51:41.874739	FormSubmission	If yes, date of last review?	\N	f	\N	\N	\N
4847	223	110	\N	2019-09-18 04:51:41.97754	2019-09-18 04:51:41.97754	FormSubmission	Does the information security incidence response team have elevated access levels that are accessible and kept in secured storage for emergencies?	\N	f	\N	\N	\N
4848	226	110	\N	2019-09-18 04:51:42.007448	2019-09-18 04:51:42.007448	FormSubmission	Are they external to your firm? 	\N	f	\N	\N	\N
4849	225	110	\N	2019-09-18 04:51:42.028475	2019-09-18 04:51:42.028475	FormSubmission	Are they internal to your firm?	\N	f	\N	\N	\N
4850	239	111	Yes	2019-09-18 15:00:11.961016	2019-09-18 15:00:23.839378	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4851	238	111	26-50%	2019-09-18 15:00:11.979695	2019-09-18 15:00:23.850193	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4852	239	112	No	2019-09-18 19:52:06.777815	2019-09-18 19:52:21.427017	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4853	238	112	26-50%	2019-09-18 19:52:06.8108	2019-09-18 19:52:21.442372	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4854	239	113	No	2019-09-18 20:10:02.113556	2019-09-18 20:10:16.911337	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4855	238	113	26-50%	2019-09-18 20:10:02.153819	2019-09-18 20:10:16.930267	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4856	241	113	Yes	2019-09-18 20:10:38.172818	2019-09-18 20:13:16.044376	FormSubmission	Is your firm a customer of BMO?	\N	f	\N	\N	\N
4857	240	113	>$1,000,000	2019-09-18 20:10:38.206451	2019-09-18 20:13:16.070562	FormSubmission	What isthe dollar amount of your firm’s banking relationship? ($) 	\N	f	\N	\N	\N
4858	243	113	Yes	2019-09-18 20:13:40.642064	2019-09-18 20:13:52.555525	FormSubmission	Is your firm a certified minority/woman owned firm?	\N	f	\N	\N	\N
4859	242	113	No	2019-09-18 20:13:40.67531	2019-09-18 20:13:52.568263	FormSubmission	Does your firm have an internal program for regularly tracking diversity?	\N	f	\N	\N	\N
4860	245	113	No	2019-09-18 20:13:52.72341	2019-09-18 20:14:03.650125	FormSubmission	Does your firm have internal process improvement initiatives	\N	f	\N	\N	\N
4861	244	113	Yes	2019-09-18 20:13:52.744426	2019-09-18 20:14:03.662373	FormSubmission	Does your firm have client-facing process improvement initiatives?	\N	f	\N	\N	\N
4862	247	113	\N	2019-09-18 20:14:03.879202	2019-09-18 20:14:03.879202	FormSubmission	Does your firm use Legal Process Outsourcing?	\N	f	\N	\N	\N
4863	246	113	\N	2019-09-18 20:14:03.909564	2019-09-18 20:14:03.909564	FormSubmission	Does your firm use alternative internal legal professional sourcing (non-partnership track lawyers; paralegals, etc.)?	\N	f	\N	\N	\N
4864	239	114		2019-09-24 16:10:39.239951	2019-09-25 03:03:59.732136	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4865	238	114		2019-09-24 16:10:39.271098	2019-09-25 03:03:59.747493	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4866	241	114	\N	2019-09-25 03:03:59.944934	2019-09-25 03:03:59.944934	FormSubmission	Is your firm a customer of BMO?	\N	f	\N	\N	\N
4867	240	114	\N	2019-09-25 03:03:59.990667	2019-09-25 03:03:59.990667	FormSubmission	What isthe dollar amount of your firm’s banking relationship? ($) 	\N	f	\N	\N	\N
4868	239	116	\N	2019-10-07 16:05:46.28056	2019-10-07 16:05:46.28056	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4869	238	116	\N	2019-10-07 16:05:46.322822	2019-10-07 16:05:46.322822	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4870	239	118	\N	2019-10-10 04:47:02.224356	2019-10-10 04:47:02.224356	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4871	238	118	\N	2019-10-10 04:47:02.25097	2019-10-10 04:47:02.25097	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4872	239	120	Yes	2019-10-17 17:54:47.525683	2019-10-17 17:55:31.882224	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4873	238	120	26-50%	2019-10-17 17:54:47.5593	2019-10-17 17:55:31.900569	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4874	241	120	Yes	2019-10-17 17:55:32.041584	2019-10-17 17:55:40.462737	FormSubmission	Is your firm a customer of BMO?	\N	f	\N	\N	\N
4875	240	120	>$1,000,000	2019-10-17 17:55:32.063986	2019-10-17 17:55:40.480473	FormSubmission	What isthe dollar amount of your firm’s banking relationship? ($) 	\N	f	\N	\N	\N
4876	243	120	Yes	2019-10-17 17:55:40.600708	2019-10-17 17:55:50.202836	FormSubmission	Is your firm a certified minority/woman owned firm?	\N	f	\N	\N	\N
4877	242	120	Yes	2019-10-17 17:55:40.628871	2019-10-17 17:55:50.212272	FormSubmission	Does your firm have an internal program for regularly tracking diversity?	\N	f	\N	\N	\N
4878	245	120	Yes	2019-10-17 17:55:50.344645	2019-10-17 17:55:57.341152	FormSubmission	Does your firm have internal process improvement initiatives	\N	f	\N	\N	\N
4879	244	120	Yes	2019-10-17 17:55:50.369577	2019-10-17 17:55:57.348798	FormSubmission	Does your firm have client-facing process improvement initiatives?	\N	f	\N	\N	\N
4880	247	120	\N	2019-10-17 17:55:57.488122	2019-10-17 17:55:57.488122	FormSubmission	Does your firm use Legal Process Outsourcing?	\N	f	\N	\N	\N
4881	246	120	\N	2019-10-17 17:55:57.524399	2019-10-17 17:55:57.524399	FormSubmission	Does your firm use alternative internal legal professional sourcing (non-partnership track lawyers; paralegals, etc.)?	\N	f	\N	\N	\N
4882	239	121	Yes	2019-10-18 17:41:29.051276	2019-10-18 17:41:41.356716	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4883	238	121	26-50%	2019-10-18 17:41:29.082193	2019-10-18 17:41:41.372835	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
4884	241	121	No	2019-10-18 17:41:41.51966	2019-10-18 17:41:50.111115	FormSubmission	Is your firm a customer of BMO?	\N	f	\N	\N	\N
4885	240	121	>$1,000,000	2019-10-18 17:41:41.543923	2019-10-18 17:41:50.120602	FormSubmission	What isthe dollar amount of your firm’s banking relationship? ($) 	\N	f	\N	\N	\N
4886	243	121	Yes	2019-10-18 17:41:50.255214	2019-10-18 17:42:00.751248	FormSubmission	Is your firm a certified minority/woman owned firm?	\N	f	\N	\N	\N
4887	242	121	No	2019-10-18 17:41:50.276453	2019-10-18 17:42:00.761088	FormSubmission	Does your firm have an internal program for regularly tracking diversity?	\N	f	\N	\N	\N
4888	245	121	Yes	2019-10-18 17:42:00.93249	2019-10-18 17:42:08.049805	FormSubmission	Does your firm have internal process improvement initiatives	\N	f	\N	\N	\N
4889	244	121	Yes	2019-10-18 17:42:00.956659	2019-10-18 17:42:08.059948	FormSubmission	Does your firm have client-facing process improvement initiatives?	\N	f	\N	\N	\N
4890	247	121	\N	2019-10-18 17:42:08.223493	2019-10-18 17:42:08.223493	FormSubmission	Does your firm use Legal Process Outsourcing?	\N	f	\N	\N	\N
4891	246	121	\N	2019-10-18 17:42:08.256729	2019-10-18 17:42:08.256729	FormSubmission	Does your firm use alternative internal legal professional sourcing (non-partnership track lawyers; paralegals, etc.)?	\N	f	\N	\N	\N
4892	239	122	\N	2019-11-04 14:45:22.16885	2019-11-04 14:45:22.16885	FormSubmission	Percentage of matters that required revised pricing	\N	f	\N	\N	\N
4893	238	122	\N	2019-11-04 14:45:22.188863	2019-11-04 14:45:22.188863	FormSubmission	Does your firm prepare, track and share budgets with BMO? 	\N	f	\N	\N	\N
\.


--
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.forms (id, name, created_at, updated_at, group_form, step) FROM stdin;
20	Policy	2017-05-23 17:18:02.336652	2019-03-04 19:37:36.7507	f	policy
24	Relationship	2019-09-18 14:23:13.119198	2019-10-18 17:41:50.13004	f	relationship
25	Diversity	2019-09-18 14:28:01.548912	2019-10-18 17:42:00.771121	f	diversity
26	Innovation	2019-09-18 14:28:21.443131	2019-10-18 17:42:08.070059	f	innovation
27	Resourcing	2019-09-18 14:28:41.495916	2019-10-18 17:42:08.268033	f	resourcing
23	Pricing	2019-09-18 05:28:25.625562	2019-11-04 14:45:22.195502	f	pricing
21	Process	2017-05-23 17:34:53.204044	2019-09-18 04:51:42.043718	f	process
\.


--
-- Data for Name: frequently_asked_questions; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.frequently_asked_questions (id, question, answer, created_at, updated_at, faq_category_id) FROM stdin;
\.


--
-- Data for Name: history_submissions; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.history_submissions (id, incident_type, impact, discovery_time, source, data_loss, incident_details, created_at, updated_at, form_submission_id, checked) FROM stdin;
\.


--
-- Data for Name: information_security_policies; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.information_security_policies (id, policy, last_reviewed, last_updated, freq_of_review, form_value_id, created_at, updated_at, upload_policy, independent_review, communication_status) FROM stdin;
\.


--
-- Data for Name: internal_notes; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.internal_notes (id, message, sender_id, law_firm_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: jurisdictions; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.jurisdictions (id, country, city, law_firm_id, created_at, updated_at) FROM stdin;
1	Canada	---\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	70	2017-05-31 20:26:05.703528	2017-05-31 20:26:05.703528
2	Canada	---\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n	71	2017-06-01 14:33:29.247735	2017-06-01 14:33:29.247735
5	Canada	---\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	75	2017-06-07 16:36:01.559243	2017-06-07 16:36:01.559243
3	United States of America	---\n- ''\n- ''\n- ''\n	73	2017-06-05 17:31:49.843263	2017-06-08 20:49:35.858132
7	Canada	---\n- ''\n- ''\n- ''\n- ''\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	77	2017-06-07 17:16:00.243112	2017-06-08 20:52:40.284136
6	Canada	---\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	76	2017-06-07 17:10:14.48562	2017-06-08 21:12:47.278832
8	Canada	---\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	78	2017-06-08 01:14:33.517335	2017-07-11 19:25:26.567049
9	Canada	---\n- ''\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	89	2018-05-16 16:45:42.583514	2018-05-16 16:46:37.564892
4	Canada	---\n- ''\n- ''\n- ''\n- Alberta\n- British Columbia\n- Manitoba\n- New Brunswick\n- Newfoundland and Labrador\n- Nova Scotia\n- Ontario\n- Prince Edward Island\n- Quebec\n- Saskatchewan\n- Northwest Territories\n- Nunavut\n- Yukon\n	74	2017-06-06 14:46:23.874793	2018-05-16 22:46:40.979719
\.


--
-- Data for Name: law_firms; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.law_firms (id, name, description, email, phone, created_at, updated_at, user_id, relationship_manager_email, law_firm_type, parent_company, practice_area, sister_firm, principle_name, principle_title, principle_contact_info, profile_completed, max_users, public_uid, updated_by_lawfirm, initial_date_of_engagement_with_the_bank, type_of_matters_your_law_firm_handles_for_us, type_of_services_your_law_firm_provides_generally, confidentiality_level_of_matters_that_are_handled, number_of_lawyers, relationship_manager_name, relationship_manager_phone, law_firm_category) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.locations (id, address1, address2, city, province, country, postal_code, law_firm_id, created_at, updated_at) FROM stdin;
20	\N	\N	\N	\N	CA	\N	100	2019-09-13 04:31:11.989528	2019-09-13 04:31:11.989528
21	\N	\N	\N	\N	CA	\N	101	2019-09-18 14:58:38.645139	2019-09-18 14:58:38.645139
22	\N	\N	\N	\N	AX	\N	102	2019-09-18 15:23:44.381674	2019-09-18 15:23:44.381674
23	\N	\N	\N	\N	CA	\N	103	2019-09-18 19:51:56.593889	2019-09-18 19:51:56.593889
24	\N	\N	\N	\N	CA	\N	104	2019-09-19 13:21:58.152614	2019-09-19 13:21:58.152614
25	\N	\N	\N	\N	AG	\N	105	2019-09-20 18:57:27.579508	2019-09-20 18:57:27.579508
\.


--
-- Data for Name: logics; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.logics (id, listen_field_id, change_field_id, form_id, logic_to_be_applied, "values", perform_action, created_at, updated_at) FROM stdin;
174	162	163	20	when	yes	show	2017-05-23 17:33:18.724478	2017-05-23 17:33:18.724478
181	168	169	20	when	yes	show	2017-05-23 17:33:18.753392	2017-05-23 17:33:18.753392
185	172	173	21	when	yes	show	2017-05-23 18:25:44.777005	2017-05-23 18:25:44.777005
192	178	179	21	when	yes	show	2017-05-23 18:25:44.804147	2017-05-23 18:25:44.804147
198	183	184	21	when	yes	show	2017-05-23 18:25:44.824577	2017-05-23 18:25:44.824577
210	194	195	21	when	yes	show	2017-05-23 18:25:44.88081	2017-05-23 18:25:44.88081
221	202	203	21	when	yes	show	2017-05-23 18:25:44.913827	2017-05-23 18:25:44.913827
214	197	200	21	when		show	2017-05-23 18:25:44.89349	2017-05-23 20:03:56.981123
217	198	201	21	when		show	2017-05-23 18:25:44.901889	2017-05-23 20:14:39.979702
225	177	206	21	when	yes	show	2017-05-31 15:11:28.778578	2017-06-02 19:29:46.794898
222	170	204	20	when	yes	show	2017-05-30 20:07:27.070327	2017-05-30 20:07:27.070327
227	178	207	21	when	yes	show	2017-05-31 15:11:28.794197	2017-06-02 19:29:46.802579
233	177	213	21	when	yes	show	2017-05-31 15:34:24.440977	2017-05-31 15:34:24.440977
234	178	214	21	when	yes	show	2017-05-31 15:36:28.757998	2017-05-31 15:36:28.757998
235	180	215	21	when	yes	show	2017-05-31 15:38:05.670058	2017-05-31 15:38:05.670058
239	217	199	21	when	yes	show	2017-05-31 18:06:55.391062	2017-05-31 18:06:55.391062
243	218	219	21	when		show	2017-05-31 18:20:52.337161	2017-05-31 18:20:52.337161
246	220	221	21	when	yes	show	2017-05-31 18:24:27.862574	2017-05-31 18:24:27.862574
247	220	222	21	when	yes	show	2017-05-31 18:24:27.868975	2017-05-31 18:24:27.868975
248	224	223	21	when	yes	show	2017-05-31 18:26:24.423969	2017-05-31 18:29:24.565187
251	224	225	21	when	yes	show	2017-05-31 18:30:50.323337	2017-05-31 18:30:50.323337
252	224	226	21	when	yes	show	2017-05-31 18:30:50.332942	2017-05-31 18:30:50.332942
254	227	228	20	when	yes	show	2017-05-31 18:35:26.583825	2017-05-31 18:35:26.583825
258	230	231	20	when	yes	show	2017-05-31 18:37:33.515357	2017-05-31 18:37:33.515357
261	171	234	20	when	yes	show	2017-05-31 18:42:05.385069	2017-05-31 18:42:05.385069
228	178	208	21	when	yes	show	2017-05-31 15:11:28.800429	2017-06-02 19:29:46.805469
229	180	209	21	when	yes	show	2017-05-31 15:13:29.472916	2017-06-02 19:29:46.811083
230	180	210	21	when	yes	show	2017-05-31 15:13:29.477433	2017-06-02 19:29:46.813916
231	181	211	21	when	yes	show	2017-05-31 15:32:39.78216	2017-06-02 19:29:46.819733
232	181	212	21	when	yes	show	2017-05-31 15:32:39.787418	2017-06-02 19:29:46.822559
199	183	185	21	when	yes	show	2017-05-23 18:25:44.840993	2017-06-02 19:29:46.82918
260	162	233	20	when	yes	show	2017-05-31 18:38:59.581544	2017-06-02 19:24:03.368641
262	171	235	20	when	yes	show	2017-05-31 18:43:28.430993	2017-06-02 19:24:03.392233
255	227	229	20	when	yes	show	2017-05-31 18:35:26.588529	2017-06-02 19:24:03.40068
259	230	232	20	when	yes	show	2017-05-31 18:37:33.5198	2017-06-02 19:24:03.407793
224	177	205	21	when	yes	show	2017-05-31 15:11:28.773699	2017-06-02 19:29:46.791794
236	\N	216	21	when	yes	show	2017-05-31 15:38:05.67431	2017-07-14 17:46:12.724214
\.


--
-- Data for Name: mailboxer_conversation_opt_outs; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.mailboxer_conversation_opt_outs (id, unsubscriber_type, unsubscriber_id, conversation_id) FROM stdin;
\.


--
-- Data for Name: mailboxer_conversations; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.mailboxer_conversations (id, subject, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mailboxer_notifications; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.mailboxer_notifications (id, type, body, subject, sender_type, sender_id, conversation_id, draft, notification_code, notified_object_type, notified_object_id, attachment, updated_at, created_at, global, expires) FROM stdin;
\.


--
-- Data for Name: mailboxer_receipts; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.mailboxer_receipts (id, receiver_type, receiver_id, notification_id, is_read, trashed, deleted, mailbox_type, created_at, updated_at, is_delivered, delivery_method, message_id) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.notes (id, law_firm_id, message_type, message, step, admin_user_id, sender, created_at, updated_at, form_submission_id, follow_up_id, deleted_at) FROM stdin;
126	\N	request_information	Not good	pricing_step	\N	lxpuser@mailinator.com	2019-10-17 17:56:59.430808	2019-10-17 17:56:59.430808	\N	84	\N
127	\N	request_information	Right ?	pricing_step	\N	lxpuser@mailinator.com	2019-10-17 17:57:14.566177	2019-10-17 17:57:14.566177	\N	85	\N
128	\N	request_information	ok	pricing_step	\N	44a303e4@check.com	2019-10-17 18:17:55.370811	2019-10-17 18:17:55.370811	\N	84	\N
129	\N	request_information	ok	pricing_step	\N	44a303e4@check.com	2019-10-17 18:18:22.452219	2019-10-17 18:18:22.452219	\N	84	\N
130	\N	request_information	Ok it's good	pricing_step	\N	44a303e4@check.com	2019-10-17 18:19:33.965548	2019-10-17 18:19:33.965548	\N	85	\N
131	\N	request_information	I think it's not good	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 17:43:19.255974	2019-10-18 17:43:19.255974	\N	86	\N
132	\N	request_information	test	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 17:45:41.315199	2019-10-18 17:45:41.315199	\N	86	\N
133	\N	request_information	ok	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 17:46:43.43991	2019-10-18 17:46:43.43991	\N	87	\N
134	\N	request_information	sdfsdf	relationship_step	\N	c7ee952a@check.com	2019-10-18 18:01:48.47073	2019-10-18 18:01:48.47073	\N	86	\N
135	\N	request_information	sdf	relationship_step	\N	c7ee952a@check.com	2019-10-18 18:16:54.77438	2019-10-18 18:16:54.77438	\N	87	\N
136	\N	request_information	dmo	relationship_step	\N	c7ee952a@check.com	2019-10-18 18:17:16.56556	2019-10-18 18:17:16.56556	\N	86	\N
137	\N	request_information	ok	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 18:29:47.741431	2019-10-18 18:29:47.741431	\N	86	\N
138	\N	request_information	manish	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 18:30:17.406674	2019-10-18 18:30:17.406674	\N	86	\N
139	\N	request_information	Hello	diversity_step	\N	lxpuser@mailinator.com	2019-10-18 18:34:16.105911	2019-10-18 18:34:16.105911	\N	88	\N
140	\N	request_information	ok	diversity_step	\N	c7ee952a@check.com	2019-10-18 18:40:04.345669	2019-10-18 18:40:04.345669	\N	88	\N
141	\N	request_information	done	diversity_step	\N	lxpuser@mailinator.com	2019-10-18 18:40:30.090262	2019-10-18 18:40:30.090262	\N	88	\N
142	\N	request_information	okk	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 19:41:07.470582	2019-10-18 19:41:07.470582	\N	87	\N
143	\N	request_information	ok	relationship_step	\N	lxpuser@mailinator.com	2019-10-18 19:41:12.62373	2019-10-18 19:41:12.62373	\N	86	\N
144	\N	request_information	ok	diversity_step	\N	lxpuser@mailinator.com	2019-10-18 19:41:21.082891	2019-10-18 19:41:21.082891	\N	88	\N
145	\N	request_information	sdf	resourcing_step	\N	lxpuser@mailinator.com	2019-10-18 19:42:30.535477	2019-10-18 19:42:30.535477	\N	89	\N
146	\N	request_information	ok	resourcing_step	\N	c7ee952a@check.com	2019-10-18 19:42:52.885095	2019-10-18 19:42:52.885095	\N	89	\N
\.


--
-- Data for Name: panel_requests; Type: TABLE DATA; Schema: public; Owner: manishchhipa
--

COPY public.panel_requests (id, requested_by, user_id, submitted_by_email, line_of_business, lob_contact_name, law_firm_id, request_type, law_firm_category, minority_owned, minority_owned_details, women_owned, women_owned_details, matter_name, matter_types, created_at, updated_at, law_firm_name, business_manager_name, business_manager_phone, business_manager_email) FROM stdin;
\.


--
-- Data for Name: queued_notifications; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.queued_notifications (id, trigger_at, trigger_id, action_item_id, triggered, deleted_at, created_at, updated_at, severity_negative_factor) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: manishchhipa
--

COPY public.reviews (id, reviewable_id, reviewable_type, status, status_from, description, actor_id, assigned_to_id, created_at, updated_at, pay_type) FROM stdin;
143	31	ExceptionRequest	\N	\N	OK	98	104	2019-11-11 15:00:10.076896	2019-11-11 15:00:10.076896	\N
144	31	ExceptionRequest	APPROVED	\N	OK	104	\N	2019-11-11 15:00:45.538444	2019-11-11 15:00:45.538444	\N
114	19	ExceptionRequest	\N	\N	test	98	104	2019-10-04 14:32:00.490024	2019-10-04 14:32:00.490024	\N
115	19	ExceptionRequest	APPROVED	\N	esat	104	\N	2019-10-04 14:32:37.307968	2019-10-04 14:32:37.307968	\N
116	19	ExceptionRequest	APPROVED	\N	ok	98	\N	2019-10-04 14:33:27.336832	2019-10-04 14:33:27.336832	\N
117	20	ExceptionRequest	\N	\N	sdfsdf	98	104	2019-10-04 14:37:06.171209	2019-10-04 14:37:06.171209	\N
118	20	ExceptionRequest	APPROVED	\N	ok	104	\N	2019-10-04 14:37:43.898326	2019-10-04 14:37:43.898326	\N
119	20	ExceptionRequest	APPROVED	\N	ok	98	\N	2019-10-04 14:39:01.318532	2019-10-04 14:39:01.318532	\N
120	34	ConflictWaiver	APPROVED	\N	sdfsdf	98	104	2019-10-04 14:45:44.012865	2019-10-04 14:45:44.012865	\N
121	23	ExceptionRequest	\N	\N	Ok Approved 	98	104	2019-10-10 04:33:41.789942	2019-10-10 04:33:41.789942	\N
122	23	ExceptionRequest	APPROVED	\N	Ok Done 	104	\N	2019-10-10 04:36:25.701092	2019-10-10 04:36:25.701092	\N
123	23	ExceptionRequest	APPROVED	\N	Ok Done	98	\N	2019-10-10 04:37:39.615843	2019-10-10 04:37:39.615843	\N
124	23	ExceptionRequest	APPROVED	APPROVED	Ok Done	98	\N	2019-10-10 04:38:52.169096	2019-10-10 04:38:52.169096	\N
125	22	ExceptionRequest	\N	\N		98	\N	2019-10-10 05:10:02.190523	2019-10-10 05:10:02.190523	\N
126	21	ExceptionRequest	\N	APPROVED	test	98	104	2019-10-17 15:20:55.272552	2019-10-17 15:20:55.272552	\N
127	23	ExceptionRequest	APPROVED	APPROVED	tet	104	\N	2019-10-17 15:21:21.515423	2019-10-17 15:21:21.515423	\N
128	21	ExceptionRequest	APPROVED	REJECTED	sdf	104	\N	2019-10-17 15:21:35.958908	2019-10-17 15:21:35.958908	\N
129	24	ExceptionRequest	\N	\N	ok	98	104	2019-10-17 15:23:34.53613	2019-10-17 15:23:34.53613	\N
130	24	ExceptionRequest	APPROVED	\N	ok	104	\N	2019-10-17 15:24:00.520221	2019-10-17 15:24:00.520221	\N
131	25	ExceptionRequest	\N	\N	Assinged to lawyer	98	104	2019-10-17 15:30:49.87023	2019-10-17 15:30:49.87023	\N
132	25	ExceptionRequest	APPROVED	\N	Ok Aapproved	104	\N	2019-10-17 15:32:42.123838	2019-10-17 15:32:42.123838	\N
133	25	ExceptionRequest	\N	\N	test	98	104	2019-10-17 15:37:25.363142	2019-10-17 15:37:25.363142	\N
134	25	ExceptionRequest	APPROVED		ok	104	\N	2019-10-17 15:37:59.046422	2019-10-17 15:37:59.046422	\N
135	25	ExceptionRequest	\N	\N	ok	98	104	2019-10-17 15:40:32.578532	2019-10-17 15:40:32.578532	\N
136	25	ExceptionRequest	APPROVED	\N	ok	104	\N	2019-10-17 15:40:59.157743	2019-10-17 15:40:59.157743	\N
137	25	ExceptionRequest	APPROVED	\N	ok done	98	\N	2019-10-17 15:41:41.168184	2019-10-17 15:41:41.168184	\N
138	26	ExceptionRequest	\N	\N	ok	98	104	2019-10-18 16:57:27.011369	2019-10-18 16:57:27.011369	\N
139	26	ExceptionRequest	APPROVED	\N	ok	104	\N	2019-10-18 17:00:52.964841	2019-10-18 17:00:52.964841	\N
140	26	ExceptionRequest	APPROVED	\N	ok done	98	\N	2019-10-18 17:01:52.633074	2019-10-18 17:01:52.633074	\N
141	28	ExceptionRequest	\N	\N	ok	98	104	2019-11-06 15:08:36.731497	2019-11-06 15:08:36.731497	\N
142	28	ExceptionRequest	APPROVED	\N	ok	104	\N	2019-11-06 15:37:57.880181	2019-11-06 15:37:57.880181	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: manish
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
20170324191631
20170327202132
20170327204204
20170327181241
20170324170653
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
20191002043306
20191002144917
20191001235852
20191002001001
20191003163528
20191104025318
20191104150301
20191104150712
20191105160453
\.


--
-- Data for Name: security_alerts; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.security_alerts (id, title, description, severity, link, created_at, updated_at, alert_date) FROM stdin;
\.


--
-- Data for Name: security_threats; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.security_threats (id, title, description, severity_level_id, created_at, updated_at, severity_negative_factor, vendor, platform, version, service_pack) FROM stdin;
\.


--
-- Data for Name: severity_levels; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.severity_levels (id, name, color, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: shared_bank_informations; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.shared_bank_informations (id, form_value_id, name, purpose, level_of_access, created_at, updated_at) FROM stdin;
1	3404	Iron Mountain 	Archive	No Access.	2017-06-09 00:38:43.099699	2017-06-09 00:38:43.099699
3	3509	asdfsef	sdfsdf	sdfsdf	2017-06-12 19:15:25.365866	2017-06-12 19:15:25.365866
4	3509	sdfsdf	sdfsdfsdf	sdfsdfsd	2017-06-12 19:15:25.369662	2017-06-12 19:15:25.369662
6	3809				2017-06-13 21:44:20.276443	2017-06-13 21:44:20.276443
7	3584				2017-06-14 14:26:31.876652	2017-06-14 14:26:31.876652
5	3681	Commonwealth Legal Inc.	Assist with collection and processing of electronic documents and/or paper documents, including creation, administration of database, etc.	Has access to client documents in relation to proceedings, no access to the firm’s own IT systems	2017-06-13 18:59:21.00545	2017-06-21 01:17:46.363524
8	3681	H&A eDiscovery	Assist with collection and processing of electronic documents and/or paper documents, including creation, administration of database, etc.	Has access to client documents in relation to proceedings, no access to the firm’s own IT systems	2017-06-21 01:17:46.367096	2017-06-21 01:17:46.367096
9	3681	Hewlett Packard Enterprise (contracted to BMO)	Assist with collection and processing of electronic documents and/or paper documents, including creation, administration of database, etc.	Has access to client documents in relation to proceedings, no access to the firm’s own IT systems	2017-06-21 01:17:46.369228	2017-06-21 01:17:46.369228
10	3681	KAP Litigation	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.370879	2017-06-21 01:17:46.370879
11	3681	Kilrea Bliff & Process Servers	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.372442	2017-06-21 01:17:46.372442
12	3681	Nixon Legal Services	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.37414	2017-06-21 01:17:46.37414
13	3681	Omega Process Servers	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.376293	2017-06-21 01:17:46.376293
14	3681	Reliable Process Servers Inc.	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.378111	2017-06-21 01:17:46.378111
15	3681	Paquette & Associés Process Servers	Filing and service of court documents, conducting searches of public database	Only has access to documents to be filed with Courts. 	2017-06-21 01:17:46.381052	2017-06-21 01:17:46.381052
16	3681	Novus Law (as instructed by BMO)	Providing legal analysis, preparing briefs, and other litigation strategy consulting and support.	Has access to client documents in relation to proceedings, no access to the firm’s own IT systems	2017-06-21 01:17:46.383485	2017-06-21 01:17:46.383485
17	3977				2017-06-22 19:02:20.307751	2017-06-22 19:02:20.307751
18	4048	fgf			2017-06-22 20:03:54.189325	2017-06-22 20:03:54.189325
20	4128				2017-06-22 20:25:50.399635	2017-06-22 20:25:50.399635
21	4204				2017-07-12 19:29:25.936177	2017-07-12 19:29:25.936177
22	4342	Law firm of So and So	eDiscovery	Read Write	2018-06-19 13:30:33.350355	2018-06-19 13:30:33.350355
23	4598	test	TEST	TEST	2018-10-04 18:25:49.342013	2018-10-04 18:25:49.342013
24	4674	Test	Test	Test	2018-10-08 23:17:07.97435	2018-10-08 23:17:07.97435
25	4674	Test	Test	Test	2018-10-08 23:17:07.982921	2018-10-08 23:17:07.982921
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.system_settings (id, score_threshold, created_at, updated_at, docusign_access_token) FROM stdin;
1	2	2017-03-20 04:50:22.968014	2019-10-25 17:27:28.767548	eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjY4MTg1ZmYxLTRlNTEtNGNlOS1hZjFjLTY4OTgxMjIwMzMxNyJ9.eyJUb2tlblR5cGUiOjUsIklzc3VlSW5zdGFudCI6MTU3MjAyNDQ0MiwiZXhwIjoxNTcyMDUzMjQyLCJVc2VySWQiOiI5NzIwMWE0My0zNDZlLTQ2ZjItYWExZC0yNDUxMjlhZjcxZjAiLCJzaXRlaWQiOjEsInNjcCI6WyJzaWduYXR1cmUiLCJjbGljay5tYW5hZ2UiLCJvcmdhbml6YXRpb25fcmVhZCIsImdyb3VwX3JlYWQiLCJwZXJtaXNzaW9uX3JlYWQiLCJ1c2VyX3JlYWQiLCJ1c2VyX3dyaXRlIiwiYWNjb3VudF9yZWFkIiwiZG9tYWluX3JlYWQiLCJpZGVudGl0eV9wcm92aWRlcl9yZWFkIiwiZHRyLnJvb21zLnJlYWQiLCJkdHIucm9vbXMud3JpdGUiLCJkdHIuZG9jdW1lbnRzLnJlYWQiLCJkdHIuZG9jdW1lbnRzLndyaXRlIiwiZHRyLnByb2ZpbGUucmVhZCIsImR0ci5wcm9maWxlLndyaXRlIiwiZHRyLmNvbXBhbnkucmVhZCIsImR0ci5jb21wYW55LndyaXRlIl0sImF1ZCI6ImYwZjI3ZjBlLTg1N2QtNGE3MS1hNGRhLTMyY2VjYWUzYTk3OCIsImlzcyI6Imh0dHBzOi8vYWNjb3VudC1kLmRvY3VzaWduLmNvbS8iLCJzdWIiOiI5NzIwMWE0My0zNDZlLTQ2ZjItYWExZC0yNDUxMjlhZjcxZjAiLCJhbXIiOlsiaW50ZXJhY3RpdmUiXSwiYXV0aF90aW1lIjoxNTcyMDI0NDM4LCJwd2lkIjoiZGY1ZDM1OGYtM2MwOC00ZmMyLWJiZGUtNGE5ZThjZmU3NjkxIn0.vWMnDiKcG9UX32kFyR-JUuewrOwlABqJEi33NHToj1EOWn6d70B6hYlOfsBJvmoiKsQSlcG-A6oT95OOS9Z-YOb0DGpTVOcevXqLte4V916inYqJKXc5rnxNg2gDMd5djnF2YJMMESrpRDphxC0M4ATkq3z6mcxtkuRbBJ-jAruIOk1bdDxzyWXVwEuesfop9JhbDC80wQfkMWBGNrnUUbYqdFIBemEQJYwRdgEjG-oiA5Km6uJzjtnVoNb-9a7xMW6MrPg8lsNtqfy_uFaCfnHJBLxFZ9e6UGFBO9tYr_QfJbseVAH_Y3Sd_y5_8x17-BTpCVJvYbnyE3QUCR8zwA
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.technologies (id, vendor, platform, version, service_pack, supported, created_at, updated_at, platform_category, platform_type) FROM stdin;
1	Microsoft	Windows	2012	1	\N	2017-03-06 21:33:19.941683	2017-03-06 21:33:19.941683	\N	\N
2	RedHat	Linux	10	1	\N	2017-03-06 21:33:59.571529	2017-03-06 21:33:59.571529	\N	\N
3	Microsoft	Windows	2010	2	\N	2017-03-06 21:36:50.575467	2017-03-06 21:36:50.575467	\N	\N
4	RedHat	Linux	10	1	\N	2017-03-06 22:32:27.869261	2017-03-06 22:32:27.869261	\N	\N
5	Microsoft	Windows	2012	1	\N	2017-03-06 22:32:27.87469	2017-03-06 22:32:27.87469	\N	\N
6	Microsoft	Windows	2010	2	\N	2017-03-06 22:33:09.107857	2017-03-06 22:33:09.107857	\N	\N
7	Microsoft	Windows	2010	2	\N	2017-03-06 22:33:09.118473	2017-03-06 22:33:09.118473	\N	\N
8	Microsoft	Windows	2010	2	\N	2017-03-06 22:33:09.122551	2017-03-06 22:33:09.122551	\N	\N
9	Microsoft	Windows	2010	2	\N	2017-03-06 22:33:09.127839	2017-03-06 22:33:09.127839	\N	\N
10	Microsoft	Windows	2010	2	\N	2017-03-06 22:33:09.131768	2017-03-06 22:33:09.131768	\N	\N
11	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.452836	2017-03-07 03:11:59.452836	\N	\N
12	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.459416	2017-03-07 03:11:59.459416	\N	\N
13	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.463157	2017-03-07 03:11:59.463157	\N	\N
14	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.467455	2017-03-07 03:11:59.467455	\N	\N
15	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.47135	2017-03-07 03:11:59.47135	\N	\N
16	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.475003	2017-03-07 03:11:59.475003	\N	\N
17	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.479037	2017-03-07 03:11:59.479037	\N	\N
18	Microsoft	Windows	2012	1	\N	2017-03-07 03:11:59.482652	2017-03-07 03:11:59.482652	\N	\N
19	Microsoft	Windows	2010	2	\N	2017-03-20 15:33:18.748547	2017-03-20 15:33:18.748547	\N	\N
20	Microsoft	Windows	2010	2	\N	2017-03-22 18:27:47.631654	2017-03-22 18:27:47.631654	\N	\N
21	RedHat	Linux	10	1	\N	2017-03-22 18:27:47.638441	2017-03-22 18:27:47.638441	\N	\N
22	RedHat	Linux	10	1	\N	2017-03-22 18:27:47.643034	2017-03-22 18:27:47.643034	\N	\N
23	Apple	Mac OS	El Capitan	1	\N	2017-03-22 18:27:47.647649	2017-03-22 18:27:47.647649	\N	\N
24	Microsoft	Windows	2010	2	\N	2017-03-23 13:24:45.833409	2017-03-23 13:24:45.833409	\N	\N
25	Microsoft	Windows	2010	2	\N	2017-03-23 13:24:45.840544	2017-03-23 13:24:45.840544	\N	\N
26	Microsoft	Window	2012	1	\N	2017-03-23 13:24:45.84509	2017-03-23 13:24:45.84509	\N	\N
27	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.476424	2017-03-23 15:01:16.476424	\N	\N
28	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.483086	2017-03-23 15:01:16.483086	\N	\N
29	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.487878	2017-03-23 15:01:16.487878	\N	\N
30	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.492034	2017-03-23 15:01:16.492034	\N	\N
31	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.496435	2017-03-23 15:01:16.496435	\N	\N
32	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.500809	2017-03-23 15:01:16.500809	\N	\N
33	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.504983	2017-03-23 15:01:16.504983	\N	\N
34	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.509284	2017-03-23 15:01:16.509284	\N	\N
35	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.513292	2017-03-23 15:01:16.513292	\N	\N
36	Microsoft	Window	2012	1	\N	2017-03-23 15:01:16.51734	2017-03-23 15:01:16.51734	\N	\N
37	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.417985	2017-03-31 19:41:08.417985	\N	\N
38	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.428356	2017-03-31 19:41:08.428356	\N	\N
39	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.43448	2017-03-31 19:41:08.43448	\N	\N
40	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.440888	2017-03-31 19:41:08.440888	\N	\N
41	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.446802	2017-03-31 19:41:08.446802	\N	\N
42	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.453498	2017-03-31 19:41:08.453498	\N	\N
43	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.459679	2017-03-31 19:41:08.459679	\N	\N
44	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.46568	2017-03-31 19:41:08.46568	\N	\N
45	Microsoft	Window	2012	1	\N	2017-03-31 19:41:08.472531	2017-03-31 19:41:08.472531	\N	\N
46	Microsoft	Window	2012	1	\N	2017-04-03 19:42:08.569548	2017-04-03 19:42:08.569548	\N	\N
47	Apple	Mac OS	El Capitan	1	\N	2017-04-03 19:42:08.576958	2017-04-03 19:42:08.576958	\N	\N
48	RedHat	Linux	10	1	\N	2017-04-03 19:42:08.581747	2017-04-03 19:42:08.581747	\N	\N
49	Apple	Mac OS	El Capitan	1	\N	2017-04-03 19:42:08.586218	2017-04-03 19:42:08.586218	\N	\N
50	RedHat	Linux	10	1	\N	2017-04-03 19:42:08.591393	2017-04-03 19:42:08.591393	\N	\N
51	RedHat	Linux	10	1	\N	2017-04-03 19:42:08.596349	2017-04-03 19:42:08.596349	\N	\N
52	RedHat	Linux	10	1	\N	2017-04-03 19:42:08.601109	2017-04-03 19:42:08.601109	\N	\N
53	RedHat	Linux	10	1	\N	2017-04-03 19:42:08.605779	2017-04-03 19:42:08.605779	\N	\N
54	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.198088	2017-04-03 20:35:45.198088	\N	\N
55	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.21007	2017-04-03 20:35:45.21007	\N	\N
56	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.216899	2017-04-03 20:35:45.216899	\N	\N
57	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.222341	2017-04-03 20:35:45.222341	\N	\N
58	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.228628	2017-04-03 20:35:45.228628	\N	\N
59	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.234	2017-04-03 20:35:45.234	\N	\N
60	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.240316	2017-04-03 20:35:45.240316	\N	\N
61	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.24617	2017-04-03 20:35:45.24617	\N	\N
62	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.252269	2017-04-03 20:35:45.252269	\N	\N
63	Microsoft	Window	2012	1	\N	2017-04-03 20:35:45.257945	2017-04-03 20:35:45.257945	\N	\N
64	Microsoft	Windows	2012	1	\N	2017-04-11 20:52:26.353154	2017-04-11 20:52:26.353154	\N	\N
65	Microsoft	Windows	10	SP1	\N	2017-04-12 00:23:45.70182	2017-04-12 00:23:45.70182	operating_systems	server
66	Microsoft	Windows	10	SP1	\N	2017-04-12 00:25:14.438904	2017-04-12 00:25:14.438904	operating_systems	server
67	Microsoft	Windows	10	SP1	\N	2017-04-13 00:11:18.24562	2017-04-13 00:11:18.24562	operating_systems	server
68	Microsoft	Windows	10	SP1	\N	2017-04-13 15:08:01.193967	2017-04-13 15:08:01.193967	operating_systems	server
69	iManage Inc.	Worksite	9.2	SP1	\N	2017-04-13 15:09:17.861779	2017-04-13 15:09:17.861779	storage_archival	software
70	Norton (Anti Virus)	Windows	7	2	\N	2017-04-13 15:09:55.005175	2017-04-13 15:09:55.005175	infosec_technologies	software
71	Microsoft	Windows	7	3	\N	2017-04-13 15:10:14.558677	2017-04-13 15:10:14.558677	operating_systems	client
72	Microsoft	Windows	10	SP1	\N	2017-04-13 15:17:05.48116	2017-04-13 15:17:05.48116	operating_systems	server
73	Microsoft	Windows	7	3	\N	2017-04-13 15:17:05.487828	2017-04-13 15:17:05.487828	operating_systems	client
74	Drupal	Redhat Linux 	7	3	\N	2017-04-13 15:17:05.493605	2017-04-13 15:17:05.493605	web_platforms	internet
75	Redhat	Linux	7.9	4	\N	2017-04-13 15:17:05.49855	2017-04-13 15:17:05.49855	web_platforms	intranet
76	Microsoft	Windows	10	SP1	\N	2017-04-19 19:04:15.378077	2017-04-19 19:04:15.378077	operating_systems	server
77	Microsoft	Windows	7	3	\N	2017-04-19 19:04:15.385712	2017-04-19 19:04:15.385712	operating_systems	client
78	Drupal	Redhat Linux 	7	3	\N	2017-04-19 19:04:15.389733	2017-04-19 19:04:15.389733	web_platforms	internet
79	Redhat	Linux	7.9	4	\N	2017-04-19 19:04:15.394463	2017-04-19 19:04:15.394463	web_platforms	intranet
80	Cisco	Pix Firewall	10.0	2	\N	2017-04-19 19:04:15.398655	2017-04-19 19:04:15.398655	infosec_technologies	hardware
81	Cisco	Pix Firewall	10.0	2	\N	2017-04-19 19:04:25.824698	2017-04-19 19:04:25.824698	infosec_technologies	hardware
82	Linux	Linux	9	Sp2	\N	2017-04-20 15:35:20.901043	2017-04-20 15:35:20.901043	operating_systems	server
83	Drupal	Redhat Linux 	7	3	\N	2017-04-22 02:37:06.214689	2017-04-22 02:37:06.214689	web_platforms	internet
84	Drupal	Redhat Linux 	7	3	\N	2017-04-26 20:10:54.872743	2017-04-26 20:10:54.872743	web_platforms	internet
85	Drupal	Redhat Linux 	7	3	\N	2017-04-26 20:11:23.661439	2017-04-26 20:11:23.661439	web_platforms	internet
86	Drupal	Redhat Linux 	7	3	\N	2017-04-26 20:11:23.82906	2017-04-26 20:11:23.82906	web_platforms	internet
87	Microsoft	Windows	10	SP1	\N	2017-05-04 14:42:54.496732	2017-05-04 14:42:54.496732	operating_systems	server
88	Microsoft	Windows	7	3	\N	2017-05-04 14:49:18.583924	2017-05-04 14:49:18.583924	operating_systems	client
89	Drupal	Redhat Linux 	7	3	\N	2017-05-04 14:49:18.59336	2017-05-04 14:49:18.59336	web_platforms	internet
90	Redhat	Linux	7.9	4	\N	2017-05-04 14:49:18.630349	2017-05-04 14:49:18.630349	web_platforms	intranet
91	Microsoft	Windows	10	SP1	\N	2017-05-04 15:41:38.280868	2017-05-04 15:41:38.280868	operating_systems	server
92	Linux	Linux	9	Sp2	\N	2017-05-04 15:46:55.533413	2017-05-04 15:46:55.533413	operating_systems	server
93	Amazon	AWS	10	None	\N	2017-05-05 13:49:12.83863	2017-05-05 13:49:12.83863	operating_systems	server
94	Amazon	AWS	10	None	\N	2017-05-08 17:49:07.369277	2017-05-08 17:49:07.369277	operating_systems	server
95	Microsoft	Azure	1	NA	\N	2017-05-08 17:49:07.379385	2017-05-08 17:49:07.379385	operating_systems	client
96	Amazon	AWS	10	None	\N	2017-05-08 18:11:33.363727	2017-05-08 18:11:33.363727	operating_systems	server
97	Amazon	AWS	10	None	\N	2017-05-08 19:05:09.781599	2017-05-08 19:05:09.781599	operating_systems	server
98	Microsoft	Windows	10	SP1	\N	2017-05-09 15:03:16.593512	2017-05-09 15:03:16.593512	operating_systems	server
99	Amazon	AWS	10	None	\N	2017-05-09 15:03:16.601399	2017-05-09 15:03:16.601399	operating_systems	server
100	Microsoft	Azure	1	NA	\N	2017-05-09 15:03:16.606874	2017-05-09 15:03:16.606874	operating_systems	client
101	Microsoft	Azure	1	NA	\N	2017-05-09 15:03:41.496136	2017-05-09 15:03:41.496136	operating_systems	client
102	Amazon	AWS	10	None	\N	2017-05-09 16:38:28.738821	2017-05-09 16:38:28.738821	operating_systems	server
103	Amazon	AWS	10	None	\N	2017-05-09 17:18:57.712588	2017-05-09 17:18:57.712588	operating_systems	server
104	Microsoft	Windows	10	SP1	\N	2017-05-09 17:18:57.718131	2017-05-09 17:18:57.718131	operating_systems	server
105	Microsoft	Azure	1	NA	\N	2017-05-09 17:18:57.722263	2017-05-09 17:18:57.722263	operating_systems	client
106	Amazon	AWS	10	None	\N	2017-05-11 15:19:30.610928	2017-05-11 15:19:30.610928	operating_systems	server
107	Microsoft	Windows	7	3	\N	2017-05-11 15:20:10.990981	2017-05-11 15:20:10.990981	operating_systems	client
108	Seagate	External Drive	NA	NA	\N	2017-05-11 15:20:10.997801	2017-05-11 15:20:10.997801	storage_archival	hardware
109	Drupal	Redhat Linux 	7	3	\N	2017-05-11 15:20:52.286165	2017-05-11 15:20:52.286165	web_platforms	internet
110	Redhat	Linux	7.9	4	\N	2017-05-11 15:20:52.293448	2017-05-11 15:20:52.293448	web_platforms	intranet
111	Cisco	Pix Firewall	10.0	2	\N	2017-05-11 15:20:52.298574	2017-05-11 15:20:52.298574	infosec_technologies	hardware
112	Norton (Anti Virus)	Windows	7	2	\N	2017-05-11 15:20:52.303928	2017-05-11 15:20:52.303928	infosec_technologies	software
113	iManage Inc.	Worksite	9.2	SP1	\N	2017-05-11 15:20:52.308437	2017-05-11 15:20:52.308437	storage_archival	software
114	Microsoft	Windows	10	SP1	\N	2017-06-01 14:59:34.622995	2017-06-01 14:59:34.622995	operating_systems	server
115	Microsoft	Windows	7	3	\N	2017-06-01 14:59:34.63104	2017-06-01 14:59:34.63104	operating_systems	client
116	Drupal	Redhat Linux 	7	3	\N	2017-06-01 14:59:34.635511	2017-06-01 14:59:34.635511	web_platforms	internet
117	Redhat	Linux	7.9	4	\N	2017-06-01 14:59:34.640115	2017-06-01 14:59:34.640115	web_platforms	intranet
118	Cisco	Pix Firewall	10.0	2	\N	2017-06-01 14:59:34.644567	2017-06-01 14:59:34.644567	infosec_technologies	hardware
119	Norton (Anti Virus)	Windows	7	2	\N	2017-06-01 14:59:34.648607	2017-06-01 14:59:34.648607	infosec_technologies	software
120	Seagate	External Drive	NA	NA	\N	2017-06-01 14:59:34.653736	2017-06-01 14:59:34.653736	storage_archival	hardware
121	iManage Inc.	Worksite	9.2	SP1	\N	2017-06-01 14:59:34.658237	2017-06-01 14:59:34.658237	storage_archival	software
122	Microsoft	Windows	10	SP1	\N	2017-06-07 16:47:47.688251	2017-06-07 16:47:47.688251	operating_systems	server
123	Linux	Linux	9	Sp2	\N	2017-06-07 16:47:47.700109	2017-06-07 16:47:47.700109	operating_systems	server
124	Microsoft	Azure	1	NA	\N	2017-06-07 16:47:47.707618	2017-06-07 16:47:47.707618	operating_systems	client
125	Drupal	Redhat Linux 	7	3	\N	2017-06-07 16:47:47.71622	2017-06-07 16:47:47.71622	web_platforms	internet
126	Redhat	Linux	7.9	4	\N	2017-06-07 16:47:47.724614	2017-06-07 16:47:47.724614	web_platforms	intranet
127	Cisco	Pix Firewall	10.0	2	\N	2017-06-07 16:47:47.731982	2017-06-07 16:47:47.731982	infosec_technologies	hardware
128	Norton (Anti Virus)	Windows	7	2	\N	2017-06-07 16:47:47.73959	2017-06-07 16:47:47.73959	infosec_technologies	software
129	Seagate	External Drive	NA	NA	\N	2017-06-07 16:47:47.744325	2017-06-07 16:47:47.744325	storage_archival	hardware
130	iManage Inc.	Worksite	9.2	SP1	\N	2017-06-07 16:47:47.750441	2017-06-07 16:47:47.750441	storage_archival	software
131	Microsoft	Windows	10	SP1	\N	2017-06-07 17:31:03.413614	2017-06-07 17:31:03.413614	operating_systems	server
132	Microsoft	Azure	1	NA	\N	2017-06-07 17:31:03.426234	2017-06-07 17:31:03.426234	operating_systems	client
133	Drupal	Redhat Linux 	7	3	\N	2017-06-07 17:31:03.435019	2017-06-07 17:31:03.435019	web_platforms	internet
134	Redhat	Linux	7.9	4	\N	2017-06-07 17:31:03.443986	2017-06-07 17:31:03.443986	web_platforms	intranet
135	Cisco	Pix Firewall	10.0	2	\N	2017-06-07 17:31:03.453669	2017-06-07 17:31:03.453669	infosec_technologies	hardware
136	Norton (Anti Virus)	Windows	7	3	\N	2017-06-07 17:31:03.4606	2017-06-07 17:31:03.4606	infosec_technologies	software
137	Seagate	External Drive	NA	NA	\N	2017-06-07 17:31:03.467946	2017-06-07 17:31:03.467946	storage_archival	hardware
138	iManage Inc.	Worksite	9.2	SP1	\N	2017-06-07 17:31:03.474844	2017-06-07 17:31:03.474844	storage_archival	software
139	Microsoft	Windows	10	SP1	\N	2017-06-08 18:27:02.655567	2017-06-08 18:27:02.655567	operating_systems	server
140	Microsoft	Azure	1	NA	\N	2017-06-08 18:27:02.668616	2017-06-08 18:27:02.668616	operating_systems	client
141	Drupal	Redhat Linux 	7	3	\N	2017-06-08 18:27:02.677014	2017-06-08 18:27:02.677014	web_platforms	internet
142	Redhat	Linux	7.9	4	\N	2017-06-08 18:27:02.683967	2017-06-08 18:27:02.683967	web_platforms	intranet
143	Cisco	Pix Firewall	10.0	2	\N	2017-06-08 18:27:02.691359	2017-06-08 18:27:02.691359	infosec_technologies	hardware
144	Norton (Anti Virus)	Windows	7	2	\N	2017-06-08 18:27:02.698368	2017-06-08 18:27:02.698368	infosec_technologies	software
145	Seagate	External Drive	NA	NA	\N	2017-06-08 18:27:02.705358	2017-06-08 18:27:02.705358	storage_archival	hardware
146	iManage Inc.	Worksite	9.2	SP1	\N	2017-06-08 18:27:02.713336	2017-06-08 18:27:02.713336	storage_archival	software
147	Microsoft	Windows	10	SP1	\N	2017-06-09 11:17:21.069361	2017-06-09 11:17:21.069361	operating_systems	server
148	Linux	Linux	9	Sp2	\N	2017-06-12 19:22:40.426046	2017-06-12 19:22:40.426046	operating_systems	server
149	Microsoft. 	Windows.	2008	SP1	\N	2017-06-21 01:40:13.607327	2017-06-21 01:40:13.607327	operating_systems	server
150	Microsoft. 	Windows.	2008	SP1	\N	2017-06-21 01:40:17.568698	2017-06-21 01:40:17.568698	operating_systems	server
151	Microsoft. 	Windows.	2012	SP1	\N	2017-06-21 02:01:47.932908	2017-06-21 02:01:47.932908	operating_systems	server
152	Microsoft. 	Windows.	2012	.	\N	2017-06-21 02:03:52.479246	2017-06-21 02:03:52.479246	operating_systems	server
153	Microsoft	Windows.	7.	sp1.	\N	2017-06-21 02:08:57.900664	2017-06-21 02:08:57.900664	operating_systems	client
154	iManage	FileSite	9.0	.	\N	2017-06-21 02:08:57.910502	2017-06-21 02:08:57.910502	web_platforms	internet
155	Microsoft.	Office.	2010.	.	\N	2017-06-21 02:08:57.917422	2017-06-21 02:08:57.917422	web_platforms	internet
156	Microsoft.	Exchange.	2010.	.	\N	2017-06-21 02:08:57.941262	2017-06-21 02:08:57.941262	web_platforms	intranet
157	Microsoft	Windows.	7.	sp1.	\N	2017-06-21 02:09:01.722385	2017-06-21 02:09:01.722385	operating_systems	client
158	iManage	FileSite	9.0	.	\N	2017-06-21 02:09:01.733668	2017-06-21 02:09:01.733668	web_platforms	internet
159	Microsoft.	Office.	2010.	.	\N	2017-06-21 02:09:01.743867	2017-06-21 02:09:01.743867	web_platforms	internet
160	Microsoft.	Exchange.	2010.	.	\N	2017-06-21 02:09:01.754253	2017-06-21 02:09:01.754253	web_platforms	intranet
161	Forcepoint	V5000	G2	.	\N	2017-06-21 02:11:34.623428	2017-06-21 02:11:34.623428	infosec_technologies	hardware
162	Sophos	AV Client	10.6	.	\N	2017-06-21 02:11:34.631631	2017-06-21 02:11:34.631631	infosec_technologies	software
163	iManage Inc..	Worksite.	.	.	\N	2017-06-21 02:11:34.636359	2017-06-21 02:11:34.636359	storage_archival	software
164	Forcepoint	V5000	G2	.	\N	2017-06-21 02:38:45.160926	2017-06-21 02:38:45.160926	infosec_technologies	hardware
165	Sophos	AV Client	10.6	.	\N	2017-06-21 02:38:45.168359	2017-06-21 02:38:45.168359	infosec_technologies	software
166	iManage Inc..	Worksite.	.	.	\N	2017-06-21 02:38:45.174836	2017-06-21 02:38:45.174836	storage_archival	software
167	McAfee.	VirusScan	8.8.0	.	\N	2017-06-21 02:40:47.285984	2017-06-21 02:40:47.285984	infosec_technologies	software
168	Forcepoint.	Web Security	8.1	.	\N	2017-06-21 02:40:47.294197	2017-06-21 02:40:47.294197	infosec_technologies	software
169	McAfee.	VirusScan	8.8.0	.	\N	2017-06-21 02:40:55.878513	2017-06-21 02:40:55.878513	infosec_technologies	software
170	Forcepoint.	Web Security	8.1	.	\N	2017-06-21 02:40:55.885125	2017-06-21 02:40:55.885125	infosec_technologies	software
171	Checkpoint.	Firewall.	.	.	\N	2017-06-21 02:42:47.591123	2017-06-21 02:42:47.591123	infosec_technologies	hardware
172	Checkpoint.	Firewall.	.	.	\N	2017-06-21 02:42:54.408615	2017-06-21 02:42:54.408615	infosec_technologies	hardware
173	Amazon	AWS	10	None	\N	2017-06-22 19:07:15.635903	2017-06-22 19:07:15.635903	operating_systems	server
174	Microsoft	Windows	10	SP1	\N	2017-07-17 20:40:23.094357	2017-07-17 20:40:23.094357	operating_systems	server
175	Linux	Linux	9	Sp2	\N	2017-07-17 20:42:38.225129	2017-07-17 20:42:38.225129	operating_systems	server
176	Linux	Linux	9	Sp2	\N	2017-07-18 15:15:39.61549	2017-07-18 15:15:39.61549	operating_systems	server
177	Microsoft	Windows	10	SP1	\N	2017-07-18 16:04:56.882812	2017-07-18 16:04:56.882812	operating_systems	server
178	Microsoft	Windows	10	SP1	\N	2017-07-18 16:17:16.659515	2017-07-18 16:17:16.659515	operating_systems	server
179	Linux	Linux	9	Sp2	\N	2017-07-18 16:17:42.533229	2017-07-18 16:17:42.533229	operating_systems	server
180	Amazon	AWS	10	None	\N	2017-07-18 16:17:42.540191	2017-07-18 16:17:42.540191	operating_systems	server
181	Microsoft. 	Windows.	2008	SP1	\N	2017-07-18 16:19:33.021166	2017-07-18 16:19:33.021166	operating_systems	server
182	Microsoft	Windows	7	3	\N	2017-07-18 16:20:24.850102	2017-07-18 16:20:24.850102	operating_systems	client
183	Microsoft	Azure	1	NA	\N	2017-07-18 16:20:24.857204	2017-07-18 16:20:24.857204	operating_systems	client
184	Microsoft	Windows	7	3	\N	2017-07-18 16:20:24.862412	2017-07-18 16:20:24.862412	operating_systems	client
185	Linux	Linux	9	Sp2	\N	2018-09-18 17:29:01.133338	2018-09-18 17:29:01.133338	operating_systems	server
186	Linux	Linux	9		\N	2018-09-23 20:13:10.879105	2018-09-23 20:13:10.879105	operating_systems	server
187	Microsoft	Windows	7		\N	2018-09-24 02:10:34.717697	2018-09-24 02:10:34.717697	operating_systems	client
188	Amazon				\N	2018-09-24 03:10:30.429617	2018-09-24 03:10:30.429617	operating_systems	server
189	Amazon				\N	2018-09-24 03:14:11.168861	2018-09-24 03:14:11.168861	operating_systems	server
190	Linux				\N	2018-09-24 03:16:24.659108	2018-09-24 03:16:24.659108	operating_systems	server
\.


--
-- Data for Name: technology_values; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.technology_values (id, platform_category, platform_type, vendor, platform, version, service_pack, supported, created_at, updated_at, law_firm_id, form_submission_id, technology_id, checked) FROM stdin;
\.


--
-- Data for Name: third_party_vendors; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.third_party_vendors (id, form_value_id, vendor_name, area, confidentiality_agreement, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: todo_tasks; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.todo_tasks (id, law_firm_id, title, message, severity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: triggers; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.triggers (id, hours, action_type, message, severity_level_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.users (id, email, username, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, deactivated_at, otp_secret_key, google_secret, role, law_firm_id, new_password_set, qr_code_confirmed_at, first_name, last_name, line_of_business, lob_contact_name) FROM stdin;
39	6d282d70@check.com	0f7beae8	$2a$11$KXoq1pzOCgYD7fUL9PQXBOQV46B94H6s40NX27ss2QbYLD5L2VHf6	\N	\N	\N	0	\N	\N	\N	\N	2017-04-13 04:49:03.674316	2017-04-19 19:10:58.086071	2017-04-19 19:10:58.06266	\N	6l6abp4bdojneaie	\N	\N	f	\N	\N	\N	\N	\N
41	1c45468c@check.com	6a81e2b4	$2a$11$924pc.sKiBSlJ4GGTaMdlupQ.o8o8VFEMn/lsiKCjPy/Sz5t4rwtG	\N	\N	\N	2	2017-04-13 04:59:12.847238	2017-04-13 04:51:40.391517	69.157.79.144	69.157.79.144	2017-04-13 04:49:05.297716	2017-04-18 03:58:34.719203	2017-04-18 03:58:34.703359	\N	hde5gvqi3ha34nhj	\N	\N	f	\N	\N	\N	\N	\N
49	37ccefdc@check.com	0fb1f69c	$2a$11$QnpSbxGnb6Hi6sN5P3sgY.OMigAprcp5kR0VvHlr.zf66sLFXnWDW	a5b028296e3f73fc174def2a521749e3e1916881b09ec84074e4a093c5d731b0	2017-04-25 15:36:17.924311	\N	1	2017-04-25 15:38:10.332807	2017-04-25 15:38:10.332807	184.151.179.183	184.151.179.183	2017-04-25 15:36:17.561048	2017-04-26 19:31:18.640098	2017-04-26 19:31:18.588275	\N	iwclcvokchmecuzl	\N	\N	f	\N	\N	\N	\N	\N
27	6d9ee655@check.com	bb5b8a72	$2a$11$3HvDP483eIBTEpBwX72Y5OhjsbMkEt0IN1sizum/ziQdqy/nqFHNG	57872158b83d603eef956470d4775e7adb199de02eb12b996cd77afd2208ef5a	2017-04-04 14:38:54.942909	\N	2	2017-04-05 04:48:20.994305	2017-04-05 04:04:45.259325	76.64.226.132	76.64.226.132	2017-04-04 14:38:54.591743	2017-04-05 04:55:53.878755	2017-04-05 04:55:53.825354	\N	7voctblitbq2huqe	\N	\N	f	\N	\N	\N	\N	\N
40	bb29b4d0@check.com	b3ba6237	$2a$11$rV7ssTC8bl61eUK8gFyywelIAvPBXbfo.ZvG5x2/ezF49RbyJCphO	\N	\N	\N	1	2017-04-13 04:59:52.360305	2017-04-13 04:59:52.360305	69.157.79.144	69.157.79.144	2017-04-13 04:49:03.932402	2017-04-13 05:01:18.091402	2017-04-13 05:01:18.060302	\N	xzu5przsiyhv2z5i	\N	\N	f	\N	\N	\N	\N	\N
67	sealadmin@bmo.com	sealadmin@bmo.com	$2a$11$mToLSny2yMi8OI.1k44mHumvd6eHsxrdokx2XbafgU6hceGeAhEpa	\N	\N	\N	59	2018-06-24 23:59:34.255118	2018-06-14 03:39:53.917119	173.34.20.222	65.92.125.189	2017-05-24 17:06:25.811378	2018-06-24 23:59:34.262993	\N	\N	\N	superadmin	\N	f	\N	\N	\N	\N	\N
65	sealadmin@grcconsulting.ca	sealadmin@grcconsulting.ca	$2a$11$kDJ6s1Smcf9QSht9NN04B.LDHKgyQNliXmgK66moWQ8jCzToB8CFS	\N	\N	\N	124	2018-10-22 23:29:27.381419	2018-10-18 04:05:25.725786	127.0.0.1	127.0.0.1	2017-05-24 17:06:25.303803	2018-10-22 23:29:27.382395	\N	\N	\N	superadmin	\N	f	\N	\N	\N	\N	\N
66	manpreet@grcconsulting.ca	manpreet@grcconsulting.ca	$2a$11$aaGCKr5AjoXZAHI/GCjkyOH0m5KtO6pjppWmY35HoZJmbCqfKubde	\N	\N	\N	8	2019-09-10 17:38:39.665748	2019-03-04 19:36:49.517152	127.0.0.1	127.0.0.1	2017-05-24 17:06:25.559724	2019-09-10 17:38:39.667481	\N	\N	\N	superadmin	\N	f	\N	\N	\N	\N	\N
107	lxpuser1@mailinator.com	lxpuser1	$2a$11$/Owva/iDqRCAbGPOUR6xj.6.9fXagGnGbXYopwlX227hR0Iz2Tzhm	\N	\N	\N	0	\N	\N	\N	\N	2019-10-01 15:26:12.292376	2019-10-01 15:26:12.292376	\N	\N	\N	lxp	\N	f	\N	\N	\N	\N	\N
108	lobuser@mailinator.com	lobuser	$2a$11$3BnyEtfXY8U.w9zwrllB..8Zg/m5oNNbw5SubooWRnHrx3jpuk4pm	\N	\N	\N	0	\N	\N	\N	\N	2019-10-01 15:33:39.210708	2019-10-01 15:33:39.210708	\N	\N	\N	lob	\N	f	\N	\N	\N	\N	\N
109	demolxp@mailinator.com	demo_lxp	$2a$11$tZjJcseaht6XkXry8yJ9.ujlhvL3pGdjzqCmbfE4KnH.g/fZYhhaK	\N	\N	\N	0	\N	\N	\N	\N	2019-10-01 15:40:22.279271	2019-10-01 15:40:22.279271	\N	\N	\N	lxp	\N	f	\N	\N	\N	\N	\N
111	demolawyers@mailinator.com	demo_lawyers	$2a$11$/MuKuK/uobGoJFBr5DPRG.9I0vuhHbPmwGdgqCg8oLk3u52iBlXci	\N	\N	\N	0	\N	\N	\N	\N	2019-10-01 15:40:22.507816	2019-10-01 15:40:22.507816	\N	\N	\N	internal_lawyers	\N	f	\N	\N	\N	\N	\N
96	manpreet@grcconsulting.ca	manpreetnarang	$2a$11$EUYDerz4ukJb8uQtgQaixOw1SC638JmHxucZZPkH/N/CzLYKUtEsi	\N	\N	\N	35	2019-11-07 13:53:16.472947	2019-11-06 17:04:45.810454	::1	::1	2019-09-10 17:28:50.320119	2019-11-07 13:53:16.476321	\N	\N	qeo667ynslya3oxu	superadmin	\N	t	\N	\N	\N	\N	\N
110	demolob@mailinator.com	demo_lob	$2a$11$TrbUJN6yspc5AzudLQ/pJOcUmHD/gWx/mg8m8M.qo8t359EXKChLC	\N	\N	\N	1	2019-10-01 15:40:31.920906	2019-10-01 15:40:31.920906	::1	::1	2019-10-01 15:40:22.394291	2019-10-01 18:14:21.76053	\N	\N	jwkjiexbif5py6mv	lob	\N	t	\N	\N	\N	\N	\N
106	manish@grcconsulting.ca	lob	$2a$11$u95YdDPiGeXHAnBcM9YnGeDnTLp/Bi4HcXlzQUkk6jEGPgCsAYiFG	\N	\N	\N	113	2019-11-13 20:14:23.043444	2019-11-12 16:31:10.461022	::1	::1	2019-10-01 14:15:44.164282	2019-11-13 20:14:23.047315	\N	\N	ulwbvxywnisvsdmd	lob	\N	t	\N	Lob User	sdfsdf	Technology & Operations	TEST
127	manish@mailinator.com	manish@mailinator.com	$2a$11$AsWKieNdPXsHbSq5v/uGUOBjzOsXevA/aiQd16SM5HO6S7GBbnU9i	\N	\N	\N	2	2019-11-06 03:32:35.471662	2019-11-06 03:30:49.044409	::1	::1	2019-11-05 18:53:24.842337	2019-11-06 03:32:35.474065	\N	\N	\N	lob	\N	f	\N	test	chhipa	LOB	RRRRR
126	vishnu@grcconsulting.ca	Vishnu@grcconsulting.ca	$2a$11$EUIFBFK5j9K9b6AxkwYzT.O21keeoZRLiRe1R8MgIqIeuR1o2svSi	\N	\N	\N	0	\N	\N	\N	\N	2019-11-05 17:30:46.439166	2019-11-05 17:30:46.439166	\N	\N	\N	lxp	\N	f	\N	Vishnu	Kunara	\N	\N
104	lawyers@mailinator.com	lawyers	$2a$11$TUJtHoEUnFP72N47ZF3GteK30Ts0ywH4HtUGTDy3Bal1V78WOVe.K	\N	\N	\N	38	2019-11-11 15:00:28.617909	2019-11-07 17:01:54.356089	::1	::1	2019-09-25 17:10:03.963865	2019-11-11 15:00:28.619006	\N	\N	\N	internal_lawyers	\N	t	\N	\N	\N	\N	\N
98	lxpuser@mailinator.com	lxpuser	$2a$11$ENSOWoY5/HIKLf87YRh7G.yp311CNuo/GR6NCUc4CfhbWvpINwjte	\N	\N	\N	188	2019-11-12 18:17:55.633105	2019-11-12 15:36:45.775059	::1	::1	2019-09-13 17:33:59.325748	2019-11-12 18:17:55.634873	\N	\N	hswiof7hj5b2pcn6	lxp	\N	t	\N	MLXP	MLXP		
130	om@abcc.com	om@abcc.com	$2a$11$9zpypRP4KXnDH8Pah2BiZ.vScXgRGlzMX2.RVn9ciRp/GjH//.CYC	\N	\N	\N	0	\N	\N	\N	\N	2019-11-06 17:16:38.472414	2019-11-06 17:35:53.229923	\N	\N	\N	lob	\N	f	\N	Om	k	Capital Markets	LOB1
131	om@asdasd.com	om@asdasd.com	$2a$11$MoDfYZlji3lrbIXyGSGnc.9usr6adFzrf4khNke6MneALilG0U5ce	\N	\N	\N	3	2019-11-07 03:13:32.265995	2019-11-07 03:10:54.751877	::1	::1	2019-11-06 17:54:18.221646	2019-11-07 03:13:32.272532	\N	\N	\N	lxp	\N	f	\N	Om	prakash		
139	gssdf	gssdf	$2a$11$/dDgajafyUg1xcminW0E1ezYTZi1HLyQGsAJBX/TVqIw7Gc.i77ba	a1b1bc551f8762e79c3524c80063483d1a2aaf5503c306444ce25abe7fec2b65	2019-11-12 19:45:33.246326	\N	0	\N	\N	\N	\N	2019-11-12 15:31:54.427586	2019-11-12 19:45:33.24698	2019-11-13 01:15:18	\N	qmefsygr6pziyjlw	master_user	151	f	\N	\N	\N	\N	\N
138	abc@grcconsulting.ca	abc@grcconsulting.ca	$2a$11$cFNq72KoXIP5r3qvMBf0GOGKY6kdHzUgp8/lPZ7P5RsR7wySNLtZS	\N	\N	\N	0	\N	\N	\N	\N	2019-11-12 15:11:32.082905	2019-11-12 15:11:32.082905	2019-11-12 15:31:54.418053	\N	\N	user	150	f	\N	\N	\N	\N	\N
141	sdfsdf@sdfsdfsd.sdfds	sdfsdf@sdfsdfsd.sdfds	$2a$11$0hnWBuRsuBjjZWZcCFUYHOkZ.a4UgIx6whg1DO4JjqKhI4EL9n0nK	\N	\N	\N	0	\N	\N	\N	\N	2019-11-13 20:15:00.767006	2019-11-13 20:15:00.767006	2019-11-13 20:15:00.689108	\N	\N	master_user	153	f	\N	\N	\N	\N	\N
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.vendors (id, name, vendor_type, application, form_value_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: manish
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
\.


--
-- Name: action_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.action_items_id_seq', 253, false);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.active_admin_comments_id_seq', 3, false);


--
-- Name: activity_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.activity_logs_id_seq', 1284, true);


--
-- Name: activity_time_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.activity_time_logs_id_seq', 32, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 5, false);


--
-- Name: cloud_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.cloud_providers_id_seq', 29, false);


--
-- Name: conflict_waivers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa
--

SELECT pg_catalog.setval('public.conflict_waivers_id_seq', 37, true);


--
-- Name: cyber_security_insurances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.cyber_security_insurances_id_seq', 41, false);


--
-- Name: cyber_security_standards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.cyber_security_standards_id_seq', 60, false);


--
-- Name: dropdown_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.dropdown_options_id_seq', 438, true);


--
-- Name: exception_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa
--

SELECT pg_catalog.setval('public.exception_requests_id_seq', 31, true);


--
-- Name: faq_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.faq_categories_id_seq', 3, false);


--
-- Name: file_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.file_attachments_id_seq', 329, false);


--
-- Name: follow_ups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.follow_ups_id_seq', 89, true);


--
-- Name: form_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.form_fields_id_seq', 247, true);


--
-- Name: form_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.form_submissions_id_seq', 124, true);


--
-- Name: form_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.form_values_id_seq', 4893, true);


--
-- Name: forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.forms_id_seq', 27, true);


--
-- Name: frequently_asked_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.frequently_asked_questions_id_seq', 3, false);


--
-- Name: history_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.history_submissions_id_seq', 64, false);


--
-- Name: information_security_policies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.information_security_policies_id_seq', 116, false);


--
-- Name: internal_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.internal_notes_id_seq', 43, false);


--
-- Name: jurisdictions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.jurisdictions_id_seq', 11, false);


--
-- Name: law_firms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.law_firms_id_seq', 153, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.locations_id_seq', 25, true);


--
-- Name: logics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.logics_id_seq', 266, false);


--
-- Name: mailboxer_conversation_opt_outs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.mailboxer_conversation_opt_outs_id_seq', 3, false);


--
-- Name: mailboxer_conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.mailboxer_conversations_id_seq', 3, false);


--
-- Name: mailboxer_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.mailboxer_notifications_id_seq', 3, false);


--
-- Name: mailboxer_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.mailboxer_receipts_id_seq', 3, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.notes_id_seq', 146, true);


--
-- Name: panel_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa
--

SELECT pg_catalog.setval('public.panel_requests_id_seq', 22, true);


--
-- Name: queued_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.queued_notifications_id_seq', 692, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manishchhipa
--

SELECT pg_catalog.setval('public.reviews_id_seq', 144, true);


--
-- Name: security_alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.security_alerts_id_seq', 15, false);


--
-- Name: security_threats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.security_threats_id_seq', 42, false);


--
-- Name: severity_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.severity_levels_id_seq', 5, false);


--
-- Name: shared_bank_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.shared_bank_informations_id_seq', 27, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 3, false);


--
-- Name: technologies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.technologies_id_seq', 192, false);


--
-- Name: technology_values_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.technology_values_id_seq', 223, false);


--
-- Name: third_party_vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.third_party_vendors_id_seq', 52, false);


--
-- Name: todo_tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.todo_tasks_id_seq', 3, false);


--
-- Name: triggers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.triggers_id_seq', 9, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.users_id_seq', 141, true);


--
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.vendors_id_seq', 7, false);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: manish
--

SELECT pg_catalog.setval('public.versions_id_seq', 3, false);


--
-- Name: action_items action_items_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.action_items
    ADD CONSTRAINT action_items_pkey PRIMARY KEY (id);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- Name: activity_time_logs activity_time_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.activity_time_logs
    ADD CONSTRAINT activity_time_logs_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cloud_providers cloud_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cloud_providers
    ADD CONSTRAINT cloud_providers_pkey PRIMARY KEY (id);


--
-- Name: conflict_waivers conflict_waivers_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.conflict_waivers
    ADD CONSTRAINT conflict_waivers_pkey PRIMARY KEY (id);


--
-- Name: cyber_security_insurances cyber_security_insurances_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cyber_security_insurances
    ADD CONSTRAINT cyber_security_insurances_pkey PRIMARY KEY (id);


--
-- Name: cyber_security_standards cyber_security_standards_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.cyber_security_standards
    ADD CONSTRAINT cyber_security_standards_pkey PRIMARY KEY (id);


--
-- Name: dropdown_options dropdown_options_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.dropdown_options
    ADD CONSTRAINT dropdown_options_pkey PRIMARY KEY (id);


--
-- Name: exception_requests exception_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.exception_requests
    ADD CONSTRAINT exception_requests_pkey PRIMARY KEY (id);


--
-- Name: faq_categories faq_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.faq_categories
    ADD CONSTRAINT faq_categories_pkey PRIMARY KEY (id);


--
-- Name: file_attachments file_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.file_attachments
    ADD CONSTRAINT file_attachments_pkey PRIMARY KEY (id);


--
-- Name: follow_ups follow_ups_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.follow_ups
    ADD CONSTRAINT follow_ups_pkey PRIMARY KEY (id);


--
-- Name: form_fields form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_pkey PRIMARY KEY (id);


--
-- Name: form_submissions form_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_submissions
    ADD CONSTRAINT form_submissions_pkey PRIMARY KEY (id);


--
-- Name: form_values form_values_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.form_values
    ADD CONSTRAINT form_values_pkey PRIMARY KEY (id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: frequently_asked_questions frequently_asked_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.frequently_asked_questions
    ADD CONSTRAINT frequently_asked_questions_pkey PRIMARY KEY (id);


--
-- Name: history_submissions history_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.history_submissions
    ADD CONSTRAINT history_submissions_pkey PRIMARY KEY (id);


--
-- Name: information_security_policies information_security_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.information_security_policies
    ADD CONSTRAINT information_security_policies_pkey PRIMARY KEY (id);


--
-- Name: internal_notes internal_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.internal_notes
    ADD CONSTRAINT internal_notes_pkey PRIMARY KEY (id);


--
-- Name: jurisdictions jurisdictions_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.jurisdictions
    ADD CONSTRAINT jurisdictions_pkey PRIMARY KEY (id);


--
-- Name: law_firms law_firms_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.law_firms
    ADD CONSTRAINT law_firms_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: logics logics_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.logics
    ADD CONSTRAINT logics_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversation_opt_outs mailboxer_conversation_opt_outs_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs
    ADD CONSTRAINT mailboxer_conversation_opt_outs_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_conversations mailboxer_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_conversations
    ADD CONSTRAINT mailboxer_conversations_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_notifications mailboxer_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_notifications
    ADD CONSTRAINT mailboxer_notifications_pkey PRIMARY KEY (id);


--
-- Name: mailboxer_receipts mailboxer_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_receipts
    ADD CONSTRAINT mailboxer_receipts_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: panel_requests panel_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.panel_requests
    ADD CONSTRAINT panel_requests_pkey PRIMARY KEY (id);


--
-- Name: queued_notifications queued_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.queued_notifications
    ADD CONSTRAINT queued_notifications_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: manishchhipa
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: security_alerts security_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.security_alerts
    ADD CONSTRAINT security_alerts_pkey PRIMARY KEY (id);


--
-- Name: security_threats security_threats_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.security_threats
    ADD CONSTRAINT security_threats_pkey PRIMARY KEY (id);


--
-- Name: severity_levels severity_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.severity_levels
    ADD CONSTRAINT severity_levels_pkey PRIMARY KEY (id);


--
-- Name: shared_bank_informations shared_bank_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.shared_bank_informations
    ADD CONSTRAINT shared_bank_informations_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: technologies technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT technologies_pkey PRIMARY KEY (id);


--
-- Name: technology_values technology_values_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.technology_values
    ADD CONSTRAINT technology_values_pkey PRIMARY KEY (id);


--
-- Name: third_party_vendors third_party_vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.third_party_vendors
    ADD CONSTRAINT third_party_vendors_pkey PRIMARY KEY (id);


--
-- Name: todo_tasks todo_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.todo_tasks
    ADD CONSTRAINT todo_tasks_pkey PRIMARY KEY (id);


--
-- Name: triggers triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.triggers
    ADD CONSTRAINT triggers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_activity_logs_on_loggable_type_and_loggable_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_activity_logs_on_loggable_type_and_loggable_id ON public.activity_logs USING btree (loggable_type, loggable_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: manish
--

CREATE UNIQUE INDEX index_admin_users_on_email ON public.admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: manish
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON public.admin_users USING btree (reset_password_token);


--
-- Name: index_form_fields_on_position; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_form_fields_on_position ON public.form_fields USING btree ("position");


--
-- Name: index_mailboxer_conversation_opt_outs_on_conversation_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_conversation_id ON public.mailboxer_conversation_opt_outs USING btree (conversation_id);


--
-- Name: index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type ON public.mailboxer_conversation_opt_outs USING btree (unsubscriber_id, unsubscriber_type);


--
-- Name: index_mailboxer_notifications_on_conversation_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_notifications_on_conversation_id ON public.mailboxer_notifications USING btree (conversation_id);


--
-- Name: index_mailboxer_notifications_on_notified_object_id_and_type; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_notifications_on_notified_object_id_and_type ON public.mailboxer_notifications USING btree (notified_object_id, notified_object_type);


--
-- Name: index_mailboxer_notifications_on_sender_id_and_sender_type; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_notifications_on_sender_id_and_sender_type ON public.mailboxer_notifications USING btree (sender_id, sender_type);


--
-- Name: index_mailboxer_notifications_on_type; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_notifications_on_type ON public.mailboxer_notifications USING btree (type);


--
-- Name: index_mailboxer_receipts_on_notification_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_receipts_on_notification_id ON public.mailboxer_receipts USING btree (notification_id);


--
-- Name: index_mailboxer_receipts_on_receiver_id_and_receiver_type; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_mailboxer_receipts_on_receiver_id_and_receiver_type ON public.mailboxer_receipts USING btree (receiver_id, receiver_type);


--
-- Name: index_queued_notifications_on_deleted_at; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_queued_notifications_on_deleted_at ON public.queued_notifications USING btree (deleted_at);


--
-- Name: index_technologies_on_platform_and_version; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_technologies_on_platform_and_version ON public.technologies USING btree (platform, version);


--
-- Name: index_technologies_on_vendor; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_technologies_on_vendor ON public.technologies USING btree (vendor);


--
-- Name: index_technologies_on_vendor_and_platform; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_technologies_on_vendor_and_platform ON public.technologies USING btree (vendor, platform);


--
-- Name: index_technologies_on_version_and_service_pack; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_technologies_on_version_and_service_pack ON public.technologies USING btree (version, service_pack);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: manish
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: manish
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: manish
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: mailboxer_conversation_opt_outs mb_opt_outs_on_conversations_id; Type: FK CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_conversation_opt_outs
    ADD CONSTRAINT mb_opt_outs_on_conversations_id FOREIGN KEY (conversation_id) REFERENCES public.mailboxer_conversations(id);


--
-- Name: mailboxer_notifications notifications_on_conversation_id; Type: FK CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_notifications
    ADD CONSTRAINT notifications_on_conversation_id FOREIGN KEY (conversation_id) REFERENCES public.mailboxer_conversations(id);


--
-- Name: mailboxer_receipts receipts_on_notification_id; Type: FK CONSTRAINT; Schema: public; Owner: manish
--

ALTER TABLE ONLY public.mailboxer_receipts
    ADD CONSTRAINT receipts_on_notification_id FOREIGN KEY (notification_id) REFERENCES public.mailboxer_notifications(id);


--
-- PostgreSQL database dump complete
--

