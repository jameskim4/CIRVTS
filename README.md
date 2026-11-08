# Cybersecurity Incident & Vulnerability Tracking System (CIRVTS)

**Team:** Team 1 Cybersecurity  
**Project Type:** Relational Database Design and Development  
**Status:** In Development

## 1. Project Overview

The Cybersecurity Incident & Vulnerability Tracking System (CIRVTS) is a relational database project designed to help organizations manage and track cybersecurity incidents, system vulnerabilities, IT assets, and remediation activities.

The project uses Apex Financial Services, a fictional financial institution, as its use case. The organization manages sensitive customer information, financial applications, and internal IT infrastructure.

CIRVTS aims to provide a centralized database where cybersecurity information can be stored, organized, and retrieved efficiently.

## 2. Project Purpose

The purpose of CIRVTS is to improve how organizations manage cybersecurity incidents and vulnerabilities.

Security information is often spread across spreadsheets, emails, and separate tracking systems. This can make it difficult for security teams to identify affected systems, monitor unresolved vulnerabilities, and determine who is responsible for addressing security issues.

CIRVTS is intended to address these challenges by organizing relevant information in a centralized relational database.

The primary users of the proposed system include:

- **Security Analysts:** Track security incidents, investigate threats, and monitor incident resolution.
- **IT Systems Administrators:** Manage IT assets, identify vulnerabilities, and track remediation activities.
- **Compliance and Risk Auditors:** Review historical incidents, remediation records, and information relevant to security audits.

## 3. Technologies Used

The project is planned around the following technologies:

| Technology      | Purpose                                                   |
| --------------- | --------------------------------------------------------- |
| MySQL 8.0       | Relational database management system                     |
| MySQL Workbench | Database design, SQL development, and administration      |
| SQL             | Creating, managing, and querying database records         |
| Git             | Version control                                           |
| GitHub          | Repository hosting, documentation, and team collaboration |
| Markdown        | Project documentation                                     |

## 4. Database Features

CIRVTS is being designed to support the following functionality.

### Security Incident Management

- Record cybersecurity incidents.
- Track incident severity and status.
- Assign incidents to responsible employees.
- Retrieve unresolved incidents.

### Vulnerability Management

- Record discovered vulnerabilities.
- Identify affected IT assets.
- Track vulnerability severity.
- Monitor remediation progress.

### IT Asset Management

- Maintain an inventory of company IT assets.
- Identify asset ownership.
- Associate vulnerabilities with affected systems.

### Remediation Tracking

- Record actions taken to address vulnerabilities.
- Identify employees responsible for remediation.
- Track completion dates and verification status.

### Reporting and Auditing

- Retrieve historical security incidents.
- Identify unresolved vulnerabilities.
- Review remediation activities.
- Support compliance reporting.

**Note:** These are planned database capabilities. Implementation and testing are ongoing.

## 5. Database Design

The proposed database uses a relational structure to organize cybersecurity information into separate tables.

### Proposed Tables

| Table                | Description                                                            |
| -------------------- | ---------------------------------------------------------------------- |
| Employees            | Stores information about employees responsible for security operations |
| Assets               | Stores information about company computers, servers, and applications  |
| SecurityIncidents    | Tracks reported cybersecurity incidents                                |
| Vulnerabilities      | Stores identified security vulnerabilities                             |
| RemediationRecords   | Tracks actions taken to address vulnerabilities                        |
| AssetVulnerabilities | Connects vulnerabilities to affected IT assets                         |

### Proposed Relationships

- **Employees → SecurityIncidents:** One-to-Many
- **Employees → RemediationRecords:** One-to-Many
- **Employees → Assets:** One-to-Many
- **Vulnerabilities → RemediationRecords:** One-to-Many
- **Assets ↔ Vulnerabilities:** Many-to-Many, implemented through AssetVulnerabilities

These relationships are part of the preliminary database design and may change as the team finalizes its requirements.

### Entity Relationship Diagram (ERD)

The Entity Relationship Diagram will illustrate the database tables, primary keys, foreign keys, and relationships.

**Current Status:** ERD development in progress.

Once completed, the diagram will be available in the `design/` directory.

<!-- Uncomment the following line after uploading the ERD. -->
<!-- ![CIRVTS Entity Relationship Diagram](design/erd_diagram.png) -->

## 6. Project Structure

The repository is organized into the following directories:

```text
CIRVTS/
│
├── README.md
│
├── docs/
│   ├── project_requirements.pdf
│   ├── project_overview.md
│   ├── documentation.md
│   ├── team_ground_rules.pdf
│   └── database_normalization_analysis.pdf
│
├── sql/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── queries.sql
│
└── design/
    ├── erd_diagram.png
    └── cirvts_model.mwb
```

### Directory Descriptions

**docs/**

Contains project requirements, written documentation, team agreements, and database design analysis.

**sql/**

Contains SQL scripts used to create database tables, insert sample data, and execute queries.

**design/**

Contains the Entity Relationship Diagram and MySQL Workbench database model.

**README.md**

Provides an overview of the project, its purpose, database features, and instructions for using the repository.

_Note: The directory structure above represents the intended organization. Some files may not be available until later development phases._

## 7. How to Run the SQL Scripts

The following instructions describe the planned process for setting up the CIRVTS database once the SQL scripts are completed.

### Prerequisites

- MySQL Server 8.0 or a compatible version
- MySQL Workbench
- Git (optional)

### Setup Instructions

1. Download or clone the GitHub repository.
2. Open MySQL Workbench.
3. Connect to a local MySQL server.
4. Open `sql/create_tables.sql` and execute the script to create the database tables.
5. Open `sql/insert_data.sql` and execute the script to insert sample records.
6. Open `sql/queries.sql` to execute the provided SQL queries.
7. Review the results in MySQL Workbench.

**Current Status:** SQL implementation and setup instructions will be finalized as the project progresses.

## 8. Team Contributions

This project is developed by **Team 1 Cybersecurity**.

| Team Member      | Responsibilities                                             |
| ---------------- | ------------------------------------------------------------ |
| James Kim        | Database requirements and preliminary normalization analysis |
| Ni Jin           | To be confirmed                                              |
| Amine Belhayania | To be confirmed                                              |

Team members collaborate on project planning, database design, documentation, and implementation.

Individual responsibilities will be updated as development progresses.

## 9. Project Documentation

Additional documentation is available in the `docs/` directory.

| Document                            | Description                                                         |
| ----------------------------------- | ------------------------------------------------------------------- |
| project_requirements.pdf            | Database use case, stakeholders, requirements, and success criteria |
| project_overview.md                 | General project description and objectives                          |
| documentation.md                    | Proposed database tables, relationships, and functionality          |
| team_ground_rules.pdf               | Team communication, collaboration, and responsibilities             |
| database_normalization_analysis.pdf | Individual database normalization and relationship analysis         |

## 10. Future Development

The next stages of the project include:

1. Finalizing the database requirements.
2. Reviewing and finalizing the proposed database tables.
3. Creating the Entity Relationship Diagram.
4. Implementing the database using MySQL.
5. Inserting sample data.
6. Developing SQL queries.
7. Testing database relationships and constraints.
8. Updating the documentation to reflect the completed database.

## 11. Conclusion

The Cybersecurity Incident & Vulnerability Tracking System is intended to provide a structured approach to organizing cybersecurity information.

By applying relational database design principles, normalization, and SQL, CIRVTS aims to improve data consistency, reduce duplicate records, and make cybersecurity information easier to manage.

The project also provides an opportunity for Team 1 Cybersecurity to practice database design, SQL development, documentation, and collaborative software development using GitHub.
