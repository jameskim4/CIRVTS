-- ============================================================================
-- Cybersecurity Incident & Vulnerability Tracking System (CIRVTS)
-- Client: Apex Financial Services
-- Team: Team 1 Cybersecurity (James Kim, Ni Jin, Amine Belhayania)
-- File: sql/create_tables.sql
-- Description: Creates the CIRVTS relational database schema (MySQL 8.0+)
-- ============================================================================

DROP DATABASE IF EXISTS cirvts_db;
CREATE DATABASE cirvts_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE cirvts_db;

-- ----------------------------------------------------------------------------
-- 1. Table: employees
-- Stores SOC analysts, incident responders, IT admins, and asset owners.
-- ----------------------------------------------------------------------------
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    job_role VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. Table: assets
-- Stores Apex Financial Services servers, workstations, firewalls, and apps.
-- ----------------------------------------------------------------------------
CREATE TABLE assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    hostname VARCHAR(80) NOT NULL UNIQUE,
    asset_type VARCHAR(30) NOT NULL,
    operating_system VARCHAR(50) NOT NULL,
    ip_address VARCHAR(15) NOT NULL,
    criticality ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL DEFAULT 'Medium',
    location VARCHAR(50) NOT NULL,
    owner_id INT NOT NULL,
    CONSTRAINT fk_assets_owner
        FOREIGN KEY (owner_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. Table: vulnerabilities
-- Stores cataloged CVEs and security weaknesses discovered in assessments.
-- ----------------------------------------------------------------------------
CREATE TABLE vulnerabilities (
    vuln_id INT AUTO_INCREMENT PRIMARY KEY,
    cve_id VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(150) NOT NULL,
    cvss_score DECIMAL(3,1) NOT NULL CHECK (cvss_score >= 0.0 AND cvss_score <= 10.0),
    severity ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
    published_date DATE NOT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. Table: incidents
-- Stores cybersecurity incidents, investigation assignments, and root causes.
-- ----------------------------------------------------------------------------
CREATE TABLE incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    incident_type VARCHAR(40) NOT NULL,
    severity ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
    status ENUM('Open', 'Investigating', 'Contained', 'Resolved', 'Closed') NOT NULL DEFAULT 'Open',
    detected_at DATETIME NOT NULL,
    resolved_at DATETIME NULL,
    ioc VARCHAR(150) NULL,
    root_cause VARCHAR(150) NULL,
    analyst_id INT NOT NULL,
    reported_by INT NOT NULL,
    CONSTRAINT fk_incidents_analyst
        FOREIGN KEY (analyst_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_incidents_reporter
        FOREIGN KEY (reported_by) REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. Table: incident_assets (Junction Table: M:N between incidents & assets)
-- Resolves 1NF/M:N relationship tracking assets impacted in each incident.
-- ----------------------------------------------------------------------------
CREATE TABLE incident_assets (
    ia_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_id INT NOT NULL,
    asset_id INT NOT NULL,
    impact_level ENUM('Low', 'Moderate', 'High', 'Compromised') NOT NULL DEFAULT 'Moderate',
    asset_status ENUM('Online', 'Isolated', 'Quarantined', 'Reimaging', 'Restored') NOT NULL DEFAULT 'Online',
    CONSTRAINT uq_incident_asset UNIQUE (incident_id, asset_id),
    CONSTRAINT fk_ia_incident
        FOREIGN KEY (incident_id) REFERENCES incidents(incident_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_ia_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. Table: asset_vulnerabilities (Junction Table: M:N between assets & vulns)
-- Tracks CVE detections per asset, remediation SLAs, and assigned IT admins.
-- ----------------------------------------------------------------------------
CREATE TABLE asset_vulnerabilities (
    av_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    vuln_id INT NOT NULL,
    detected_date DATE NOT NULL,
    sla_due_date DATE NOT NULL,
    patched_date DATE NULL,
    patch_status ENUM('Unpatched', 'In Progress', 'Patched', 'Mitigated', 'Accepted Risk') NOT NULL DEFAULT 'Unpatched',
    assigned_admin_id INT NOT NULL,
    CONSTRAINT uq_asset_vuln UNIQUE (asset_id, vuln_id),
    CONSTRAINT fk_av_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_av_vuln
        FOREIGN KEY (vuln_id) REFERENCES vulnerabilities(vuln_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_av_admin
        FOREIGN KEY (assigned_admin_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Performance Indexes
CREATE INDEX idx_incidents_status_severity ON incidents(status, severity);
CREATE INDEX idx_incidents_detected_at ON incidents(detected_at);
CREATE INDEX idx_av_patch_status_sla ON asset_vulnerabilities(patch_status, sla_due_date);
CREATE INDEX idx_assets_criticality ON assets(criticality);
