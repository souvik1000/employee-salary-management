# ACME – Employee Salary Management System
## Product Requirements Document (MVP)

### 1. Goal
Build a centralized web-based salary management system that replaces Excel-based salary tracking and enables ACME's HR Manager to efficiently manage compensation data for 10,000 employees across multiple countries.

The system should also provide visibility into how the organization pays its employees through simple salary analytics.

### 2. Target User
**Primary Persona: HR Manager**

Responsible for managing employee salary information, maintaining accurate compensation records, and understanding salary distribution across departments and countries.

### 3. Scope & Core Features

**A. Employee Management**
- View all 10,000 employee records in a searchable, paginated table.
- Search employees by name or employee ID.
- Filter employees by country and department.
- View individual employee details.
- Add new employees and edit existing employee information.

**B. Salary Management**
- Maintain employee salary, currency, department, job title, and country.
- Update employee salary information.
- Validate salary inputs to prevent invalid records.

**C. HR Dashboard & Salary Analytics**
- Display total employee count, average salary, and total annual salary expenditure.
- Show average salary by department and country.
- Visualize salary expenditure across departments and countries.
- Provide an overview of the organization's compensation distribution.

**D. Data & Performance**
- Seed the database with 10,000 realistic employee records across multiple countries and departments.
- Support pagination and efficient searching/filtering.
- Ensure dashboard metrics reflect the latest employee salary data.

### 4. Deliberately Out of Scope

| Feature | Reason |
|---|---|
| Payroll processing and salary disbursement | The application focuses on salary management, not payment processing. |
| Tax calculations and deductions | Country-specific tax rules add unnecessary complexity to the MVP. |
| Employee self-service portal | The primary user is the HR Manager. |
| Advanced role-based permissions | Can be introduced when multiple user roles are required. |
| Salary revision history and approval workflows | Not essential for initial salary management functionality. |
| Live currency conversion | Can be introduced in a future phase when standardized global salary comparisons are required. |

### 5. Success Criteria
- HR Manager can manage 10,000 employee records.
- Employee information can be searched and filtered efficiently.
- Employee salaries can be added and updated.
- Dashboard provides accurate salary insights by department and country.
- Application is deployed and accessible through a public URL.
- A demo video demonstrates the primary workflows.

**MVP Focus:** Deliver a simple, reliable employee salary management platform that eliminates spreadsheet dependency and helps HR understand organizational compensation.