# ACME Organization — Employee Salary Management System
## Product Requirements Document (PRD)

---

### 1. Executive Summary & Goal
* **Target Organization:** ACME Org (Global enterprise with 10,000+ employees operating across multiple countries).
* **Target Persona:** HR Manager of the organization.
* **Goal:** Replace slow, brittle, and error-prone multi-country Excel spreadsheets with a high-performance, web-based Salary Management platform. The system empowers HR leadership to maintain compensation records for 10,000+ employees and instantly answer strategic questions regarding organizational pay equity, geographical distribution, and departmental budget allocation.

---

### 2. Problem Statement
ACME Org's HR team currently tracks compensation for 10,000 employees distributed across multiple countries and currencies exclusively using desktop spreadsheets. 
* **Operational Bottlenecks:** Files are bloated, slow to load, lack audit trails, risk data corruption, and provide no role-based concurrency.
* **Analytical Blindspots:** Spreadsheets cannot easily answer high-level executive questions such as:
  * *"How much does ACME spend on compensation globally and by department?"*
  * *"How do our salary distributions compare across countries, factoring in currency differences?"*
  * *"Where are our pay disparities, comp-ratio outliers, or wage compressions?"*

---

### 3. Scope & Core Features (MVP)

#### A. High-Performance Employee Directory & Salary Grid
* **Server-Side Pagination & Sorting:** Sub-second retrieval across 10,000 records with pagination (default 20, 50, 100 per page) and sorting by Name, Department, Title, Base Salary, and Normalized USD Salary.
* **Multi-Facet Search & Filtering:** Instant filtering by Country, Department, Job Title, Currency, and Salary Range.
* **Normalized Currency View:** Displays local contracted salary (e.g., EUR, GBP, INR, JPY, CAD) alongside a normalized base currency (USD) using a configurable exchange rate reference.

#### B. Salary Profile & Record Management (CRUD)
* **Employee Compensation Dossier:** View comprehensive compensation records: Employee ID, Full Name, Email, Country, Department, Job Title, Seniority Tier, Base Salary, Currency, Normalized USD Salary, and Last Review Date.
* **Add / Update Compensation:** Validated workflows to add new employees or adjust existing salary packages with input sanity checks (prevent negative salaries, invalid currencies, or missing mandatory attributes).
* **Inline / Quick Actions:** Fast editing modal for salary updates directly from the roster view.

#### C. Executive Compensation Analytics Dashboard ("How ACME Pays People")
* **Global Payroll Overview KPIs:**
  * Total Global Annual Payroll (USD normalized).
  * Mean and Median Salary org-wide.
  * Total Headcount and Average Comp by Department and Country.
* **Departmental & Regional Pay Comparison:**
  * Breakdown charts (bar/column) comparing total and average compensation by Department (Engineering, Sales, Marketing, HR, Operations, Finance, Product).
  * Geographic spend distribution across global hubs (e.g., US, UK, Germany, India, Singapore, Canada, Japan).
* **Pay Equity & Distribution Insights:**
  * Box-plot / quartile distribution of salaries across seniority levels (Junior, Mid, Senior, Lead, Director, VP) to detect outliers, salary compression, or internal inequities.
  * Highest and lowest compensation brackets with immediate visibility into outliers.

#### D. 10,000 Records Seeding & Performance
* **Realistic Seeding Engine:** CLI script seeding 10,000 realistic, geographically consistent employee records (realistic names, locations, valid currencies, departments, and realistic salary bands).
* **Database Indexing:** Indexed columns (`department`, `country`, `normalized_salary_usd`, `name`) ensuring search and filter queries execute in `< 50ms`.

---

### 4. Extra / Value-Add Features

1. **What-If Budget & Salary Increase Modeling:**
   * A scenario simulator allowing the HR Manager to test org-wide or department-specific percentage raises (e.g., *"Simulate a 4.5% cost-of-living adjustment for the Engineering department in India & UK"*) and view the immediate budgetary impact before committing.
2. **Export to CSV / Report Generator:**
   * One-click filtered CSV export for compliance reporting, board decks, and external audit.
3. **Salary Change History / Audit Trail:**
   * Track salary revisions with change timestamps, previous vs. new salary, and adjustment reason (e.g., Annual Review, Promotion, Market Adjustment).

---

### 5. Deliberately Out of Scope & Rationale

| Feature | Reason for Omission in V1 |
| :--- | :--- |
| **Banking / Direct Deposit Disbursal** | ACME's goal is compensation *planning, analysis, and management*, not treasury transaction processing. Banking integrations require localized banking licenses, clearing house compliance, and are handled by specialized payroll processors. |
| **Complex Country-Specific Tax & Statutory Deductions** | Local Tax Codes across multiple jurisdictions change frequently. Total gross/base compensation is the universal metric for strategic org compensation decisions. |
| **Live Floating FX Market Tickers** | Compensation budgets are calculated against quarterly or annual pegged corporate exchange rates. Fluctuating live market FX creates unpredictable noise in HR budgeting. |
| **Employee Self-Service Portal** | The target persona is explicitly the HR Manager of this organization. End-user payslip downloads and self-service requests are out of scope for the assessment. |
| **Complex Multi-Tenant Enterprise SAML / SSO** | To avoid unnecessary complexity during assessment review, authentication will use streamlined single HR Manager session/state rather than heavy enterprise identity providers. |

---

### 6. Technology Stack Architecture

#### Frontend (`webapp`)
* **Framework:** React 19+ with TypeScript (Vite bundler for instant development and high-performance builds).
* **Styling & UI Components:** Modern Shadcn UI built with Tailwind CSS and Lucide React icons for a responsive, clean, enterprise dashboard aesthetic.
* **Data Visualization:** Recharts for analytics charts (payroll distribution, departmental breakdown, geographic spend).
* **Data Fetching & State:** React Query / Custom hook architecture with debounce handling for zero-lag filtering and pagination.
* **Testing:** Vitest + React Testing Library for component and interaction unit testing.

#### Backend (`web-services`)
* **Runtime & Framework:** Node.js with TypeScript and Express.js (layered clean architecture: Routes $\rightarrow$ Controllers $\rightarrow$ Services $\rightarrow$ Repositories $\rightarrow$ Entities).
* **ORM & Database:** TypeORM configured with SQLite by default for zero-config, portable, and instant local execution/evaluation, with seamless switchable configuration for PostgreSQL.
* **Seeding Utility:** Standalone TypeScript script leveraging `@faker-js/faker` generating 10,000 deterministic records in batched database transactions.
* **Validation & Security:** `zod` / `class-validator` for API payload sanitization and error handling middleware.
* **Testing:** Jest + Supertest for end-to-end API and unit testing.

---

### 7. Non-Functional Requirements & Success Metrics
* **Performance:** Query latency under $100\text{ms}$ for paginated reads, filtering, and aggregate analytics queries over 10,000 records.
* **Data Integrity:** Strict schema validation with foreign keys and transactional consistency for salary modifications.
* **Simplicity & Usability:** Zero required configuration to run locally (`npm install && npm run seed && npm run dev`).
