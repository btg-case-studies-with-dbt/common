-- ============================================================
-- resource_utilization_db_cleanup.sql
-- THREE SECTIONS — run only what you need.
--
--   SECTION 1: BRONZE DATA (btg_resource_utilization)
--     Level 1: TRUNCATE all bronze tables — wipes data, keeps structure
--     Level 2: DROP all bronze tables — removes tables and indexes
--     Level 3: DROP raw_bronze schema — removes everything
--
--   SECTION 2: DBT SCHEMAS (btg_resource_utilization)
--     Drops all dbt-created schemas — personal, dev, snapshots, packages
--     Run after Section 1 Level 3 for a full dev database reset
--
--   SECTION 3: PROD DATABASE
--     Drops the entire prod_resource_utilization_postgres database
--     Run as superuser connected to a different database
--
-- WARNING: These operations are IRREVERSIBLE.
-- Run each section deliberately — do not run the whole file at once.
-- ============================================================


-- ============================================================
-- SECTION 1: BRONZE DATA — btg_resource_utilization
-- ============================================================

-- ── Level 1: TRUNCATE all bronze tables ──────────────────────
-- Wipes all data. Keeps table structure, indexes, and constraints.
-- Use this to reset data without rebuilding the schema.

/*

TRUNCATE TABLE raw_bronze.config_model_dimensions                  RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.config_model_region_availability         RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.customer_details                         RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.inference_user_token_usage_open_source   RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.inference_user_token_usage_proprietary   RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.resource_accelerator_inventory           RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.resource_model_utilization               RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.resource_model_instance_allocation       RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.quota_default_rate_limits                RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.quota_customer_rate_limit_adjustments    RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.revenue_account_daily                    RESTART IDENTITY CASCADE;
TRUNCATE TABLE raw_bronze.quota_customer_rate_limit_requests       RESTART IDENTITY CASCADE;

*/


-- ── Level 2: DROP all bronze tables ──────────────────────────
-- Removes tables and indexes. CASCADE drops dependent objects.

/*

DROP TABLE IF EXISTS raw_bronze.config_model_dimensions                  CASCADE;
DROP TABLE IF EXISTS raw_bronze.config_model_region_availability         CASCADE;
DROP TABLE IF EXISTS raw_bronze.customer_details                         CASCADE;
DROP TABLE IF EXISTS raw_bronze.inference_user_token_usage_open_source   CASCADE;
DROP TABLE IF EXISTS raw_bronze.inference_user_token_usage_proprietary   CASCADE;
DROP TABLE IF EXISTS raw_bronze.resource_accelerator_inventory           CASCADE;
DROP TABLE IF EXISTS raw_bronze.resource_model_utilization               CASCADE;
DROP TABLE IF EXISTS raw_bronze.resource_model_instance_allocation       CASCADE;
DROP TABLE IF EXISTS raw_bronze.quota_default_rate_limits                CASCADE;
DROP TABLE IF EXISTS raw_bronze.quota_customer_rate_limit_adjustments    CASCADE;
DROP TABLE IF EXISTS raw_bronze.revenue_account_daily                    CASCADE;
DROP TABLE IF EXISTS raw_bronze.quota_customer_rate_limit_requests       CASCADE;

*/


-- ── Level 3: DROP raw_bronze schema ──────────────────────────

/*

DROP SCHEMA IF EXISTS raw_bronze CASCADE;

*/


-- ============================================================
-- SECTION 2: DBT SCHEMAS — btg_resource_utilization
-- Drops all schemas created by dbt — personal, dev, snapshots, packages.
-- CASCADE removes all tables, views, and objects inside each schema.
-- ============================================================

/*

-- Personal schemas (dbt_kanja_*)
DROP SCHEMA IF EXISTS dbt_kanja                    CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_staging_silver     CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_mart_gold          CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_seeds              CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_snapshots          CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_elementary         CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_dbt_project_evaluator CASCADE;
DROP SCHEMA IF EXISTS dbt_kanja_dbt_test__audit    CASCADE;
DROP SCHEMA IF EXISTS dbt_test__audit              CASCADE;

-- Dev schemas (dev_*)
DROP SCHEMA IF EXISTS dev_staging_silver           CASCADE;
DROP SCHEMA IF EXISTS dev_mart_gold                CASCADE;
DROP SCHEMA IF EXISTS dev_seeds                    CASCADE;
DROP SCHEMA IF EXISTS dev_snapshots                CASCADE;
DROP SCHEMA IF EXISTS dev_elementary               CASCADE;
DROP SCHEMA IF EXISTS dev_dbt_project_evaluator    CASCADE;

-- Shared schemas
DROP SCHEMA IF EXISTS snapshots                    CASCADE;

-- Leftover schemas from old prod approach (if any)
DROP SCHEMA IF EXISTS staging_silver               CASCADE;
DROP SCHEMA IF EXISTS mart_gold                    CASCADE;
DROP SCHEMA IF EXISTS seeds                        CASCADE;
DROP SCHEMA IF EXISTS prod                         CASCADE;

-- Drop all roles
DROP ROLE IF EXISTS data_engineer;
DROP ROLE IF EXISTS analytics_engineer;
DROP ROLE IF EXISTS data_scientist;
DROP ROLE IF EXISTS business_user;
DROP ROLE IF EXISTS partner_dw_engineer;

*/


-- ============================================================
-- SECTION 3: PROD DATABASE — prod_resource_utilization_postgres
-- Run as superuser connected to a different database (e.g. postgres).
-- WARNING: Drops the entire prod database — irreversible.
-- ============================================================

/*

DROP DATABASE IF EXISTS prod_resource_utilization_postgres;

*/


-- ============================================================
-- VERIFICATION
-- Run after any section to confirm what remains.
-- ============================================================

-- Check remaining schemas in dev database
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name NOT IN ('pg_catalog', 'information_schema', 'public')
AND schema_name NOT LIKE 'pg_%'
ORDER BY schema_name;

-- Check remaining tables in raw_bronze
SELECT schemaname, tablename
FROM pg_tables
WHERE schemaname = 'raw_bronze'
ORDER BY tablename;

-- Check remaining roles
SELECT rolname
FROM pg_roles
WHERE rolname IN ('data_engineer', 'analytics_engineer', 'data_scientist', 'business_user', 'partner_dw_engineer')
ORDER BY rolname;
