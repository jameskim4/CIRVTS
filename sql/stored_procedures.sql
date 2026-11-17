-- ============================================================================
-- Cybersecurity Incident & Vulnerability Tracking System (CIRVTS)
-- Client: Apex Financial Services
-- File: sql/stored_procedures.sql
-- Description: Reusable stored procedures for SOC incident & patch workflows
-- ============================================================================

USE cirvts_db;

DELIMITER //

-- ----------------------------------------------------------------------------
-- Procedure 1: sp_LogNewIncident
-- Logs a new security incident and links the primary affected asset atomically.
-- ----------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_LogNewIncident //
CREATE PROCEDURE sp_LogNewIncident(
    IN p_title VARCHAR(150),
    IN p_incident_type VARCHAR(40),
    IN p_severity ENUM('Low', 'Medium', 'High', 'Critical'),
    IN p_detected_at DATETIME,
    IN p_ioc VARCHAR(150),
    IN p_analyst_id INT,
    IN p_reported_by INT,
    IN p_primary_asset_id INT,
    IN p_impact_level ENUM('Low', 'Moderate', 'High', 'Compromised'),
    IN p_asset_status ENUM('Online', 'Isolated', 'Quarantined', 'Reimaging', 'Restored')
)
BEGIN
    DECLARE v_new_incident_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO incidents (
        title, incident_type, severity, status, detected_at, ioc, analyst_id, reported_by
    ) VALUES (
        p_title, p_incident_type, p_severity, 'Open', p_detected_at, p_ioc, p_analyst_id, p_reported_by
    );

    SET v_new_incident_id = LAST_INSERT_ID();

    IF p_primary_asset_id IS NOT NULL THEN
        INSERT INTO incident_assets (
            incident_id, asset_id, impact_level, asset_status
        ) VALUES (
            v_new_incident_id, p_primary_asset_id, p_impact_level, p_asset_status
        );
    END IF;

    COMMIT;

    SELECT v_new_incident_id AS created_incident_id;
END //

-- ----------------------------------------------------------------------------
-- Procedure 2: sp_CompleteVulnerabilityPatch
-- Marks an asset vulnerability as Patched and records the completion date.
-- ----------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_CompleteVulnerabilityPatch //
CREATE PROCEDURE sp_CompleteVulnerabilityPatch(
    IN p_av_id INT,
    IN p_patched_date DATE
)
BEGIN
    UPDATE asset_vulnerabilities
    SET patch_status = 'Patched',
        patched_date = COALESCE(p_patched_date, CURRENT_DATE)
    WHERE av_id = p_av_id;

    SELECT 
        av.av_id,
        ast.hostname,
        v.cve_id,
        av.patch_status,
        av.patched_date,
        av.sla_due_date,
        CASE 
            WHEN av.patched_date <= av.sla_due_date THEN 'Met SLA'
            ELSE 'Breached SLA'
        END AS sla_compliance
    FROM asset_vulnerabilities av
    JOIN assets ast ON av.asset_id = ast.asset_id
    JOIN vulnerabilities v ON av.vuln_id = v.vuln_id
    WHERE av.av_id = p_av_id;
END //

DELIMITER ;
