# ACME – Employee Salary Management System (MVP)
## Technical Planning & UI/UX Design Notes

---

## 1. Tech Stack & Architecture Overview

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Frontend** | **React 19+ (Vite SPA) + React Router v6** | Fast client-side routing with protected HR Manager routes |
| **Data Fetching** | **TanStack Query (React Query)** | Caching, debounced search queries, and automatic dashboard invalidation on salary updates |
| **UI & Styling** | **Tailwind CSS + Shadcn UI** | Accessible components (`Table`, `Dialog`, `Form`, `Select`, `Badge`) matching the *Precision Payroll* design system |
| **Charts** | **Recharts** (via Shadcn Charts) | Horizontal bar charts, vertical bar charts, and donut charts |
| **Backend API** | **Node.js + Express.js** | RESTful API handling auth, server-side pagination, search/filter queries, and validation |
| **Auth** | **JWT (HTTP-Only Cookie or Bearer Token)** | Simple single-role authentication for the HR Manager persona |
| **Database & ORM** | **PostgreSQL + TypeORM** | Relational storage, indexing for 10,000+ rows, and SQL aggregations |
| **Validation** | **Zod + React Hook Form** | Shared schema validation across client forms and Express middleware |

---

## 2. Authentication & Routing Flow (Login Gate)

Since this is a login-protected internal application for a single persona (**HR Manager**):
* **Public Route (`/login`):** Clean centered Shadcn `Card` matching the *Precision Payroll* navy/slate theme. Pre-fill or provide demo credentials on the login screen for easy reviewer/demo access.
* **Protected Layout (`/`):** Wraps `/dashboard`, `/employees`, `/employees/new`, `/employees/:id`, and `/analytics` in an `<AuthGuard>` component. Unauthenticated requests redirect to `/login`.
* **No Complex RBAC:** Per the PRD (*Advanced role-based permissions* are out of scope), a single seeded HR Manager account (`hr.admin@acme.com`) is sufficient.

---

## 3. Screen-by-Screen Design & Scope Pruning

### Screen 0: HR Login (`/login`)
* **Design:** Centered white card on `bg-slate-50` background, ACME Precision Payroll logo, Email & Password inputs, and a "Sign In" primary button.

### Screen 1: HR Dashboard (`/dashboard`)
* **Design:** 3 top KPI cards (`Total Employees`, `Average Salary`, `Total Annual Expenditure`), 2 bar charts (by Department & Country), and 2 donut charts (Expenditure share).
* **Design Decision:** Include a **Currency Selector (`USD | INR | GBP | EUR`)** at the top right so KPIs and charts compute accurately without live FX conversion.

### Screen 2: Employee Management (`/employees`)
* **Design:** Search bar, Country & Department dropdown filters, `+ Add Employee` CTA, paginated Shadcn `DataTable`, and bottom pagination bar (`Showing 1 to 20 of 10,000 results`).
* **Design Decision:** All search (`400ms` debounced), filtering, and pagination happen via Express query params (`?page=1&limit=20&search=...&country=...&department=...`).

### Screen 3: Salary Management Modal (`Dialog`)
* **Design:** Triggered from row actions on the Employee Management table or from the Employee Details header.
* **Scope Pruning:** Keep only `Current Salary (read-only)`, `New Annual Salary`, and `Currency`. Drop effective date, reason codes, and approval workflows.

### Screen 4: Salary Analytics (`/analytics`)
* **Design:** Full-width charts + bottom *Department/Country Compensation Summary* table.
* **Design Decision:** Powered by the same `/api/analytics` aggregation endpoint as the dashboard; omit export-to-PDF/CSV buttons for MVP.

### Screen 5: Add / Edit Employee & Validation (`/employees/new`)
* **Design:** Two-card form layout (*Personal & Role Info* + *Compensation Details*) with inline red field highlights on validation failure.
* **Design Decision:** Selecting `Country` auto-sets the `Currency` field (`USA -> USD`, `India -> INR`, `UK -> GBP`, `Germany -> EUR`, `Canada -> CAD`).

### Screen 6: Employee Details (`/employees/:id`)
* **Design:** Header with initials avatar (`MV`), name, role badge, and `Edit Employee` / `Update Salary` buttons.
* **Scope Pruning:** Keep only **Employee Information** and **Current Compensation** cards.
