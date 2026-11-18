-- ============================================================================
-- Cybersecurity Incident & Vulnerability Tracking System (CIRVTS)
-- Client: Apex Financial Services
-- File: sql/queries.sql
-- Description: Analytical & operational queries aligned with documentation.md
-- ============================================================================

USE cirvts_db;

-- ----------------------------------------------------------------------------
-- Query 1 (Doc Question 1): Which company assets have High or Critical
-- vulnerabilities that have not yet been resolved?
-- ----------------------------------------------------------------------------
SELECT 
    ast.asset_id,
    ast.hostname,
    ast.asset_type,
    ast.criticality AS asset_criticality,
    v.cve_id,
    v.title AS vulnerability_title,
    v.severity AS vuln_severity,
    v.cvss_score,
    av.detected_date,
    av.sla_due_date,
    av.patch_status,
    CONCAT(adm.first_name, ' ', adm.last_name) AS assigned_admin
FROM assets ast
JOIN asset_vulnerabilities av ON ast.asset_id = av.asset_id
JOIN vulnerabilities v ON av.vuln_id = v.vuln_id
JOIN employees adm ON av.assigned_admin_id = adm.employee_id
WHERE v.severity IN ('High', 'Critical')
  AND av.patch_status IN ('Unpatched', 'In Progress')
ORDER BY v.cvss_score DESC, av.sla_due_date ASC;

-- ----------------------------------------------------------------------------
-- Query 2 (Doc Question 2): Which employees are responsible for unresolved
-- security incidents, and how severe are those incidents?
-- ----------------------------------------------------------------------------
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS analyst_name,
    e.job_role,
    i.incident_id,
    i.title AS incident_title,
    i.incident_type,
    i.severity,
    i.status,
    i.detected_at,
    GROUP_CONCAT(CONCAT(ast.hostname, ' [', ia.asset_status, ']') SEPARATOR ', ') AS affected_assets
FROM employees e
JOIN incidents i ON e.employee_id = i.analyst_id
LEFT JOIN incident_assets ia ON i.incident_id = ia.incident_id
LEFT JOIN assets ast ON ia.asset_id = ast.asset_id
WHERE i.status IN ('Open', 'Investigating', 'Contained')
GROUP BY e.employee_id, analyst_name, e.job_role, i.incident_id, i.title, i.incident_type, i.severity, i.status, i.detected_at
ORDER BY FIELD(i.severity, 'Critical', 'High', 'Medium', 'Low'), i.detected_at ASC;

-- ----------------------------------------------------------------------------
-- Query 3 (Doc Question 3 / Compliance Audit): Overdue Vulnerability SLAs
-- Lists unpatched or in-progress vulnerabilities past their SLA due date.
-- ----------------------------------------------------------------------------
SELECT 
    av.av_id,
    ast.hostname,
    ast.criticality AS asset_criticality,
    v.cve_id,
    v.cvss_score,
    av.detected_date,
    av.sla_due_date,
    DATEDIFF(CURRENT_DATE, av.sla_due_date) AS days_overdue,
    av.patch_status,
    CONCAT(adm.first_name, ' ', adm.last_name) AS assigned_admin,
    adm.email AS admin_email
FROM asset_vulnerabilities av
JOIN assets ast ON av.asset_id = ast.asset_id
JOIN vulnerabilities v ON av.vuln_id = v.vuln_id
JOIN employees adm ON av.assigned_admin_id = adm.employee_id
WHERE av.patch_status IN ('Unpatched', 'In Progress')
  AND av.sla_due_date < CURRENT_DATE
ORDER BY days_overdue DESC, v.cvss_score DESC;

-- ----------------------------------------------------------------------------
-- Query 4: Incident Mean Time to Resolve (MTTR) in Hours by Severity
-- ----------------------------------------------------------------------------
SELECT 
    severity,
    COUNT(*) AS resolved_incident_count,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, detected_at, resolved_at)) / 60.0, 2) AS avg_mttr_hours,
    ROUND(MIN(TIMESTAMPDIFF(MINUTE, detected_at, resolved_at)) / 60.0, 2) AS min_mttr_hours,
    ROUND(MAX(TIMESTAMPDIFF(MINUTE, detected_at, resolved_at)) / 60.0, 2) AS max_mttr_hours
FROM incidents
WHERE resolved_at IS NOT NULL
GROUP BY severity
ORDER BY FIELD(severity, 'Critical', 'High', 'Medium', 'Low');

-- ----------------------------------------------------------------------------
-- Query 5: Asset Risk Posture Summary (Combining Incidents & Open CVEs)
-- ----------------------------------------------------------------------------
SELECT 
    ast.asset_id,
    ast.hostname,
    ast.asset_type,
    ast.criticality,
    CONCAT(own.first_name, ' ', own.last_name) AS asset_owner,
    COUNT(DISTINCT ia.incident_id) AS incident_count,
    COUNT(DISTINCT CASE WHEN av.patch_status IN ('Unpatched', 'In Progress') THEN av.av_id END) AS open_cve_count,
    COALESCE(MAX(CASE WHEN av.patch_status IN ('Unpatched', 'In Progress') THEN v.cvss_score END), 0.0) AS highest_open_cvss
FROM assets ast
JOIN employees own ON ast.owner_id = own.employee_id
LEFT JOIN incident_assets ia ON ast.asset_id = ia.asset_id
LEFT JOIN asset_vulnerabilities av ON ast.asset_id = av.asset_id
LEFT JOIN vulnerabilities v ON av.vuln_id = v.vuln_id
GROUP BY ast.asset_id, ast.hostname, ast.asset_type, ast.criticality, asset_owner
ORDER BY FIELD(ast.criticality, 'Critical', 'High', 'Medium', 'Low'), highest_open_cvss DESC, incident_count DESC;
