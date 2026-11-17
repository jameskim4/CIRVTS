-- ============================================================================
-- Cybersecurity Incident & Vulnerability Tracking System (CIRVTS)
-- Client: Apex Financial Services
-- File: sql/insert_data.sql
-- Description: Populates sample data across all 6 normalized CIRVTS tables
-- ============================================================================

USE cirvts_db;

-- ----------------------------------------------------------------------------
-- 1. Insert Sample Data: employees (10 records)
-- ----------------------------------------------------------------------------
INSERT INTO employees (employee_id, first_name, last_name, email, job_role, department, hire_date) VALUES
(1, 'Sarah', 'Jenkins', 's.jenkins@apexfinancial.com', 'Senior SOC Analyst', 'Information Security', '2021-03-15'),
(2, 'Marcus', 'Vance', 'm.vance@apexfinancial.com', 'Incident Response Lead', 'Information Security', '2020-07-01'),
(3, 'Elena', 'Rostova', 'e.rostova@apexfinancial.com', 'SOC Analyst II', 'Information Security', '2022-11-10'),
(4, 'David', 'Kim', 'd.kim@apexfinancial.com', 'Vulnerability Management Engineer', 'Information Security', '2022-02-20'),
(5, 'Priya', 'Patel', 'p.patel@apexfinancial.com', 'Senior Systems Administrator', 'IT Infrastructure', '2019-09-05'),
(6, 'Carlos', 'Mendez', 'c.mendez@apexfinancial.com', 'Linux Infrastructure Engineer', 'IT Infrastructure', '2021-06-14'),
(7, 'Hannah', 'Abbott', 'h.abbott@apexfinancial.com', 'Network Security Engineer', 'Network Operations', '2020-10-12'),
(8, 'Liam', 'OConnor', 'l.oconnor@apexfinancial.com', 'Cloud Platform Engineer', 'Cloud Engineering', '2023-01-09'),
(9, 'Maya', 'Lin', 'm.lin@apexfinancial.com', 'Wealth Management Advisor', 'Retail Banking', '2022-05-18'),
(10, 'Robert', 'Chen', 'r.chen@apexfinancial.com', 'Compliance & Risk Auditor', 'Risk & Compliance', '2023-04-03');

-- ----------------------------------------------------------------------------
-- 2. Insert Sample Data: assets (12 records)
-- ----------------------------------------------------------------------------
INSERT INTO assets (asset_id, hostname, asset_type, operating_system, ip_address, criticality, location, owner_id) VALUES
(1, 'core-banking-db01.apexfin.local', 'Database Server', 'Red Hat Enterprise Linux 9.2', '10.10.20.11', 'Critical', 'Primary Data Center - NYC', 6),
(2, 'online-banking-gw01.apexfin.local', 'Web Server', 'Ubuntu Server 22.04 LTS', '10.10.10.15', 'Critical', 'AWS us-east-1', 8),
(3, 'perimeter-fw-edge01.apexfin.local', 'Firewall Appliance', 'PAN-OS 11.1', '10.10.1.1', 'Critical', 'Primary Data Center - NYC', 7),
(4, 'corp-ad-dc01.apexfin.local', 'Domain Controller', 'Windows Server 2022', '10.10.5.10', 'Critical', 'Primary Data Center - NYC', 5),
(5, 'branch-vpn-gw01.apexfin.local', 'VPN Gateway', 'Cisco Secure Firewall ASA', '198.51.100.24', 'High', 'DR Data Center - NJ', 7),
(6, 'wire-transfer-app02.apexfin.local', 'Application Server', 'Windows Server 2019', '10.10.30.22', 'High', 'Primary Data Center - NYC', 5),
(7, 'payment-api-k8s04.apexfin.local', 'Container Host', 'Ubuntu Server 24.04 LTS', '10.20.40.104', 'High', 'AWS us-east-1', 8),
(8, 'wealth-ws-042.apexfin.local', 'Workstation', 'Windows 11 Enterprise', '10.30.12.42', 'Medium', 'NYC HQ - Floor 14', 9),
(9, 'audit-ws-019.apexfin.local', 'Workstation', 'macOS Sequoia 15.1', '10.30.14.19', 'Medium', 'NYC HQ - Floor 18', 10),
(10, 'ci-build-runner01.apexfin.local', 'Build Server', 'Debian 12 Bookworm', '10.40.10.8', 'Medium', 'AWS us-west-2', 6),
(11, 'uat-portal-01.apexfin.local', 'Application Server', 'Ubuntu Server 22.04 LTS', '10.40.20.19', 'Low', 'AWS us-west-2', 8),
(12, 'lobby-kiosk-av03.apexfin.local', 'IoT / Kiosk Endpoint', 'Embedded Linux 5.15', '10.50.5.33', 'Low', 'NYC HQ - Branch Lobby', 5);

-- ----------------------------------------------------------------------------
-- 3. Insert Sample Data: vulnerabilities (10 records)
-- ----------------------------------------------------------------------------
INSERT INTO vulnerabilities (vuln_id, cve_id, title, cvss_score, severity, published_date) VALUES
(1, 'CVE-2024-3094', 'XZ Utils Malicious Backdoor in liblzma Compression Library', 10.0, 'Critical', '2024-03-29'),
(2, 'CVE-2024-3400', 'Palo Alto PAN-OS GlobalProtect Command Injection Vulnerability', 10.0, 'Critical', '2024-04-12'),
(3, 'CVE-2024-6387', 'OpenSSH regreSSHion Unauthenticated Remote Code Execution', 8.1, 'High', '2024-07-01'),
(4, 'CVE-2024-21413', 'Microsoft Outlook Moniker Link Remote Code Execution', 9.8, 'Critical', '2024-02-13'),
(5, 'CVE-2024-38077', 'Windows Remote Desktop Licensing Service RCE (MadLicense)', 9.8, 'Critical', '2024-07-09'),
(6, 'CVE-2023-44487', 'HTTP/2 Rapid Reset Distributed Denial of Service (DDoS)', 7.5, 'High', '2023-10-10'),
(7, 'CVE-2024-4577', 'PHP CGI Argument Injection Remote Code Execution on Windows', 9.8, 'Critical', '2024-06-06'),
(8, 'CVE-2024-27198', 'JetBrains TeamCity Authentication Bypass Vulnerability', 9.8, 'Critical', '2024-03-04'),
(9, 'CVE-2024-43451', 'Windows NTLM Hash Disclosure Spoofing Vulnerability', 6.5, 'Medium', '2024-11-12'),
(10, 'CVE-2023-38545', 'cURL SOCKS5 Heap-Based Buffer Overflow Vulnerability', 3.7, 'Low', '2023-10-11');

-- ----------------------------------------------------------------------------
-- 4. Insert Sample Data: incidents (8 records)
-- ----------------------------------------------------------------------------
INSERT INTO incidents (incident_id, title, incident_type, severity, status, detected_at, resolved_at, ioc, root_cause, analyst_id, reported_by) VALUES
(1, 'Spear-Phishing Credential Harvesting Targeting Wealth Advisors', 'Phishing', 'High', 'Resolved', '2026-09-02 08:42:00', '2026-09-02 14:15:00', 'hxxp://apexfin-client-portal[.]com/login', 'User clicked spoofed client wire request; session token revoked by SOC', 1, 9),
(2, 'Suspicious Outbound C2 Beaconing from Perimeter Firewall', 'Command & Control', 'Critical', 'Resolved', '2026-09-10 02:18:00', '2026-09-10 11:45:00', '185.220.101.44:443 (SHA256: 9f86d081884c7d65...)', 'Unpatched CVE-2024-3400 exploited via GlobalProtect telemetry interface', 2, 7),
(3, 'Unauthorized Privilege Escalation Attempt on Domain Controller', 'Privilege Escalation', 'Critical', 'Contained', '2026-10-14 19:05:00', NULL, 'EventID 4672 / Kerberoasting SPN spike from 10.30.12.42', 'Compromised workstation service ticket abused legacy SPN account', 2, 1),
(4, 'Ransomware Staging Activity Detected on Wire Transfer Server', 'Malware / Ransomware', 'Critical', 'Investigating', '2026-11-12 03:50:00', NULL, 'vssadmin.exe delete shadows / SHA256: 4b227777d4dd1fc6...', 'Initial access via unpatched RDG licensing service (CVE-2024-38077)', 1, 5),
(5, 'HTTP/2 Rapid Reset Volumetric DDoS on Online Banking Gateway', 'Denial of Service', 'High', 'Resolved', '2026-08-21 15:10:00', '2026-08-21 17:30:00', 'ASN 14061 / 1.4M RPS TLS flood on 10.10.10.15', 'Missing HTTP/2 stream concurrency rate-limiting on WAF edge', 3, 8),
(6, 'Malicious Build Artifact Injection in CI/CD Pipeline', 'Supply Chain', 'High', 'Contained', '2026-11-05 11:22:00', NULL, 'rogue-admin-token-9921 / POST /app/rest/users', 'Exploitation of TeamCity authentication bypass (CVE-2024-27198)', 4, 6),
(7, 'Anomalous SSH Brute-Force & Recon on Payment API Host', 'Brute Force', 'Medium', 'Closed', '2026-07-19 22:04:00', '2026-07-20 01:10:00', '45.33.32.156 (14,200 failed root logins)', 'Temporary security group rule exposed SSH port 22 to 0.0.0.0/0', 3, 8),
(8, 'Suspicious Macro Document Opened on Audit Workstation', 'Malware', 'Low', 'Resolved', '2026-10-28 10:15:00', '2026-10-28 11:05:00', 'Q3_Compliance_Review.docm (MD5: e99a18c428cb38d5...)', 'Blocked by EDR macro execution policy; no lateral movement observed', 3, 10);

-- ----------------------------------------------------------------------------
-- 5. Insert Sample Data: incident_assets (11 records)
-- ----------------------------------------------------------------------------
INSERT INTO incident_assets (ia_id, incident_id, asset_id, impact_level, asset_status) VALUES
(1, 1, 8, 'Moderate', 'Restored'),
(2, 2, 3, 'Compromised', 'Restored'),
(3, 2, 5, 'Low', 'Online'),
(4, 3, 4, 'High', 'Isolated'),
(5, 3, 8, 'Compromised', 'Reimaging'),
(6, 4, 6, 'Compromised', 'Quarantined'),
(7, 4, 1, 'Low', 'Isolated'),
(8, 5, 2, 'High', 'Restored'),
(9, 6, 10, 'Compromised', 'Quarantined'),
(10, 7, 7, 'Low', 'Restored'),
(11, 8, 9, 'Low', 'Restored');

-- ----------------------------------------------------------------------------
-- 6. Insert Sample Data: asset_vulnerabilities (14 records)
-- ----------------------------------------------------------------------------
INSERT INTO asset_vulnerabilities (av_id, asset_id, vuln_id, detected_date, sla_due_date, patched_date, patch_status, assigned_admin_id) VALUES
(1, 3, 2, '2026-04-14', '2026-04-17', '2026-09-10', 'Patched', 7),
(2, 2, 3, '2026-07-03', '2026-07-10', '2026-07-08', 'Patched', 8),
(3, 1, 3, '2026-07-03', '2026-07-10', '2026-07-09', 'Patched', 6),
(4, 8, 4, '2026-08-15', '2026-08-22', '2026-08-20', 'Patched', 5),
(5, 6, 5, '2026-10-25', '2026-11-01', NULL, 'In Progress', 5),
(6, 4, 5, '2026-10-25', '2026-11-01', '2026-10-30', 'Patched', 5),
(7, 2, 6, '2026-08-10', '2026-08-24', '2026-08-22', 'Patched', 8),
(8, 6, 7, '2026-11-01', '2026-11-08', NULL, 'Unpatched', 5),
(9, 10, 8, '2026-10-20', '2026-10-27', NULL, 'In Progress', 6),
(10, 8, 9, '2026-11-13', '2026-12-13', NULL, 'Unpatched', 5),
(11, 9, 9, '2026-11-13', '2026-12-13', NULL, 'Mitigated', 5),
(12, 11, 10, '2026-09-01', '2026-11-30', NULL, 'Accepted Risk', 8),
(13, 10, 1, '2026-04-01', '2026-04-03', '2026-04-02', 'Patched', 6),
(14, 7, 3, '2026-07-04', '2026-07-11', NULL, 'Unpatched', 8);
