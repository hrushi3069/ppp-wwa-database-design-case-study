
## Worldwide Awaydays (PPP) Database Design and Analysis

---

## Overview

This report presents a complete data management case study for Worldwide Awaydays (PPP). It focuses on designing a relational database system to manage party events, guests, bookings, payments, suppliers, and activities.

The study also explores business intelligence opportunities, GDPR compliance, security architecture, and the comparison between relational and graph database systems.

---

## Task 1: Logical Database Design

The PPP system is designed to manage:
- Party details and event structures  
- Guest information including passport and health data  
- Accommodation and activity bookings  
- Supplier management  
- Payment tracking and cancellations  

### Business Rules & Queries
The system supports different query levels:

**Must Queries**
- Record guest details with health and passport information  
- Categorise activities  
- Manage bookings (create, update, cancel)  

**Should Queries**
- Match guests to activities in a party  
- Supplier payment summaries  
- Activity and guest reporting  

**Could Queries**
- Cost per guest analysis  
- Average event cost per guest  
- Outstanding balances per guest or party  

**Optional Enhancements**
- Automated triggers for payment updates  
- Safety validation for health risks in activities  
- Activity capacity control procedures  

---

## Task 2: Business Intelligence (BI)

The PPP database supports BI analysis for decision-making.

### Key BI Areas
- Revenue, cost, and profit analysis per destination  
- Customer behaviour and spending patterns  
- Supplier performance and commission tracking  
- Activity popularity and seasonal trends  
- Cancellation and risk analysis  

### Data Warehouse Design
A **star schema** is used:
- Fact tables: bookings, payments, expenses  
- Dimension tables: guests, suppliers, activities, destinations  

---

## Task 3: GDPR and Data Security

The system processes sensitive personal data including:
- Names, contact details, passport data  
- Payment and booking history  
- Health and allergy information  

### Key Risks
- Identity theft and fraud  
- Data breaches and reputational damage  
- Unauthorized access to sensitive health data  

### GDPR Principles Applied
- Lawfulness, fairness, and transparency  
- Purpose limitation  
- Data minimisation  
- Accuracy and storage limitation  
- Integrity and confidentiality  

### Security Controls
- Role-based access control (RBAC)  
- Encryption of sensitive data (in transit and at rest)  
- Audit logging and monitoring  
- Secure third-party data sharing  
- GDPR-compliant data retention policies  

---

## Task 4: Relational vs Graph Databases

### Relational Database (RDBMS)
Used for:
- Bookings  
- Payments  
- Guest records  
- Supplier management  

**Strengths**
- Strong ACID compliance  
- High data integrity  
- Ideal for financial transactions  
- Easy integration with BI tools  

---

### Graph Database
Used for:
- Recommendation systems  
- Social/referral analysis  
- Relationship mapping between guests and activities  

**Strengths**
- Efficient relationship traversal  
- Better for multi-hop queries  
- Useful for personalisation and marketing insights  

---

### Final Recommendation
A **hybrid approach** is recommended:
- RDBMS as the core system of record  
- Graph database for advanced analytics and recommendations  

---

## Conclusion

This case study demonstrates how structured relational database design ensures operational efficiency, data integrity, and GDPR compliance for Worldwide Awaydays. It also highlights how graph databases can extend the system for advanced customer insights and relationship analysis.

---

 
