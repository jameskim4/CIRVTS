# CIRVTS Database Documentation

## 1. Introduction

The Cybersecurity Incident & Vulnerability Tracking System (CIRVTS) is a proposed relational database designed to organize cybersecurity incidents, vulnerabilities, IT assets, and remediation activities.

The database is intended to support security analysts, IT administrators, and compliance personnel by providing a centralized location for managing cybersecurity information.

This document describes the proposed database structure, table relationships, normalization principles, and expected functionality.

## 2. Technologies

The following technologies are planned for the project:

- **MySQL:** Relational database management system.
- **MySQL Workbench:** Database design, SQL development, and database administration.
- **SQL:** Language used to create, retrieve, update, and delete database records.
- **Git:** Version control for tracking project changes.
- **GitHub:** Repository hosting and team collaboration.

## 3. Proposed Database Tables

The initial database design includes six tables.

### 3.1 Employees

Stores information about employees responsible for investigating cybersecurity incidents and performing remediation activities.

**Proposed Columns:**

| Column     | Description                         |
| ---------- | ----------------------------------- |
| EmployeeID | Unique identifier for each employee |
| FirstName  | Employee's first name               |
| LastName   | Employee's last name                |
| JobTitle   | Employee's job title                |
| Email      | Employee's email address            |

**Primary Key:** EmployeeID

### 3.2 Assets

Stores information about company computers, servers, applications, and other IT assets.

**Proposed Columns:**

| Column          | Description                                |
| --------------- | ------------------------------------------ |
| AssetID         | Unique identifier for each asset           |
| AssetName       | Name of the asset                          |
| AssetType       | Type of asset                              |
| OperatingSystem | Operating system associated with the asset |
| AssetOwnerID    | Employee responsible for the asset         |

**Primary Key:** AssetID

**Proposed Foreign Key:** AssetOwnerID references Employees.EmployeeID.

### 3.3 SecurityIncidents

Stores information about cybersecurity incidents reported within the organization.

**Proposed Columns:**

| Column              | Description                                   |
| ------------------- | --------------------------------------------- |
| IncidentID          | Unique identifier for each incident           |
| IncidentDescription | Description of the security incident          |
| Severity            | Severity level of the incident                |
| DateReported        | Date the incident was reported                |
| Status              | Current status of the incident                |
| AssignedEmployeeID  | Employee assigned to investigate the incident |

**Primary Key:** IncidentID

**Foreign Key:** AssignedEmployeeID references Employees.EmployeeID.

### 3.4 Vulnerabilities

Stores information about security vulnerabilities discovered through scans or assessments.

**Proposed Columns:**

| Column            | Description                              |
| ----------------- | ---------------------------------------- |
| VulnerabilityID   | Unique identifier for each vulnerability |
| VulnerabilityName | Name of the vulnerability                |
| Description       | Description of the security issue        |
| Severity          | Severity level                           |
| DateDiscovered    | Date the vulnerability was discovered    |
| Status            | Current vulnerability status             |

**Primary Key:** VulnerabilityID

### 3.5 RemediationRecords

Tracks actions taken by employees to resolve identified vulnerabilities.

**Proposed Columns:**

| Column             | Description                                   |
| ------------------ | --------------------------------------------- |
| RemediationID      | Unique identifier for each remediation record |
| VulnerabilityID    | Vulnerability associated with the remediation |
| AssignedEmployeeID | Employee responsible for the remediation      |
| ActionTaken        | Description of the remediation activity       |
| DateCompleted      | Date the remediation was completed            |
| VerificationStatus | Whether the remediation has been verified     |

**Primary Key:** RemediationID

**Foreign Keys:**

- VulnerabilityID references Vulnerabilities.VulnerabilityID.
- AssignedEmployeeID references Employees.EmployeeID.

### 3.6 AssetVulnerabilities

Stores information about vulnerabilities affecting specific IT assets.

This table represents the many-to-many relationship between Assets and Vulnerabilities.

**Proposed Columns:**

| Column            | Description                                       |
| ----------------- | ------------------------------------------------- |
| AssetID           | Identifier of the affected asset                  |
| VulnerabilityID   | Identifier of the associated vulnerability        |
| DateDetected      | Date the vulnerability was detected on the asset  |
| RemediationStatus | Current remediation status for the affected asset |

**Composite Primary Key:** AssetID and VulnerabilityID

**Foreign Keys:**

- AssetID references Assets.AssetID.
- VulnerabilityID references Vulnerabilities.VulnerabilityID.

## 4. Database Relationships

The proposed database contains several relationships.

| Table 1         | Table 2            | Relationship                |
| --------------- | ------------------ | --------------------------- |
| Employees       | SecurityIncidents  | One-to-Many (1:M)           |
| Employees       | RemediationRecords | One-to-Many (1:M)           |
| Employees       | Assets             | One-to-Many (1:M), proposed |
| Vulnerabilities | RemediationRecords | One-to-Many (1:M)           |
| Assets          | Vulnerabilities    | Many-to-Many (M:N)          |

The many-to-many relationship between Assets and Vulnerabilities will be implemented through the AssetVulnerabilities junction table.

This allows one vulnerability to affect multiple assets while also allowing one asset to have multiple vulnerabilities.

## 5. Database Normalization

The proposed database design follows the principles of First, Second, and Third Normal Form.

### First Normal Form (1NF)

Each column should contain a single value, and each record should be uniquely identifiable.

For example, if a security incident affects multiple assets, the database should not store several asset identifiers in one field.

Instead, each incident-to-asset association should be stored separately in an appropriate relationship table.

An additional IncidentAssets junction table could be introduced if the team decides that incidents must be linked directly to multiple assets.

### Second Normal Form (2NF)

Every non-key column must depend on the entire primary key.

For example, AssetVulnerabilities uses AssetID and VulnerabilityID as a composite primary key.

Information such as AssetName belongs in the Assets table because it depends only on AssetID.

The AssetVulnerabilities table should store information specific to the asset-vulnerability combination, such as DateDetected.

### Third Normal Form (3NF)

Non-key attributes should not depend on other non-key attributes.

For example, SecurityIncidents should not repeatedly store employee names and email addresses.

Instead, employee information should be stored in Employees, while SecurityIncidents references the assigned employee through AssignedEmployeeID.

This reduces duplicated information and makes updates easier.

## 6. Expected Database Functionality

The proposed database should support the following operations:

### Incident Management

- Record new security incidents.
- Assign incidents to employees.
- Track incident severity and status.
- Retrieve unresolved incidents.

### Vulnerability Management

- Record discovered vulnerabilities.
- Identify affected IT assets.
- Track vulnerability severity.
- Monitor remediation progress.

### Asset Management

- Maintain an inventory of company IT assets.
- Identify asset ownership.
- Retrieve vulnerabilities associated with specific assets.

### Remediation Tracking

- Record remediation activities.
- Identify employees responsible for remediation.
- Track completion dates.
- Review remediation verification status.

## 7. Example Database Questions

The database should eventually support queries such as:

**Question 1:** Which company assets have high-severity vulnerabilities that have not been resolved?

Expected tables:

- Assets
- Vulnerabilities
- AssetVulnerabilities

**Question 2:** Which employees are responsible for unresolved security incidents?

Expected tables:

- Employees
- SecurityIncidents

**Question 3:** Which vulnerabilities have remediation activities that are still awaiting verification?

Expected tables:

- Vulnerabilities
- RemediationRecords

These are examples of the information users should be able to retrieve once the database has been implemented.

## 8. Database Design

The Entity Relationship Diagram (ERD) will illustrate the tables, primary keys, foreign keys, and relationships.

The finalized ERD will be stored in the repository's `design/` directory.

**Current Status:** Database design in progress.

## 9. SQL Scripts

SQL scripts will be organized in the repository's `sql/` directory.

The planned files include:

| File                  | Purpose                                         |
| --------------------- | ----------------------------------------------- |
| create_tables.sql     | Creates the database tables and relationships   |
| insert_data.sql       | Inserts sample data                             |
| queries.sql           | Contains SQL queries for retrieving information |
| stored_procedures.sql | Contains stored procedures, if implemented      |

The team will update this documentation as SQL development progresses.

## 10. Future Development

As the project progresses, the team plans to:

1. Finalize the database requirements.
2. Review and finalize the proposed tables.
3. Create the Entity Relationship Diagram.
4. Implement the database using MySQL.
5. Insert sample records.
6. Develop SQL queries to retrieve cybersecurity information.
7. Test database relationships and constraints.
8. Update the project documentation to reflect the completed implementation.

## 11. Conclusion

CIRVTS is intended to provide a structured approach to tracking cybersecurity incidents, vulnerabilities, affected assets, and remediation activities.

By separating information into related tables and applying database normalization principles, the project aims to reduce duplicate information and improve data consistency.

The proposed database design will continue to evolve as Team 1 Cybersecurity works toward the final implementation.
