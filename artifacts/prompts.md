# Prompt History & Agent Execution Log

This document records all user prompts, execution timestamps, models used, and the agent's understanding for transparency and auditability.

---

## Prompt 1

* **Timestamp:** `2026-11-18 02:02:25 +05:30`
* **Model Used:** `Gemini 3.8 Flash (High)`
* **Exact Prompt:**
```text
In this application, the folder is named employee-salary-management and has two folders: one is web-services (required for the backend), and another is webapp (required for the frontend).

Before starting this project, I have the PDF ready @file:@[r:\FrontEnd\ReactApps\Test\employee-salary-management\Salary Management Assessment- Candidates.pdf].

The problem to be solved is that currently, ACME org’s HR team manages salary data for 10,000 employees across multiple countries, with everything managed via Excel, which is tedious. We want the HR manager to manage the salary data via web-based software and be able to answer questions about how the org pays people.

Now, for this problem, First complete the one-page requirements document under docs folder about the goal, scope, features to solve this problem and extra features, And what you are delibarately leaving out and why? And also mention the tech [It'll be React/Node with PostgreSQL using TypeORM (or SQLite with TypeORM if possible)].

Once this is completed, I will move into the artifacts
```

* **Understanding & Action Summary:**
  * Analyzed the assessment PDF and extracted key constraints: ACME org has 10,000 employees globally; transitioning from Excel to web software; target user is HR Manager; need to answer questions on how the organization pays people.
  * Formulated a comprehensive one-page PRD at `docs/requirements.md` covering:
    * **Goal & Problem Statement:** Replace unscalable spreadsheets with a web-based compensation management system.
    * **Scope & Core Features:** High-performance employee grid with server-side pagination/filtering/sorting over 10,000 rows, salary profile CRUD, multi-currency to USD normalization, executive compensation analytics dashboard, and realistic 10,000 records seeder.
    * **Extra Features:** What-If salary revision modeling, CSV export, and salary change audit trail.
    * **Deliberately Out of Scope:** Banking disbursal (ACH/SWIFT), intricate multi-country statutory tax engines, real-time floating FX tickers, employee self-service portal, heavy multi-tenant SSO.
    * **Tech Stack:** React (Vite, Tailwind, Recharts) + Node.js (TypeScript, Express) + TypeORM with dual SQLite/PostgreSQL support.
  * Initialized Git repository and created initial commit.

---

## Prompt 2

* **Timestamp:** `2026-11-18 02:30:32 +05:30`
* **Model Used:** `Gemini 3.8 Flash (High)`
* **Exact Prompt:**
```text
Whenever write any prompt, please add those to the artifacts/prompts.md

Prompt includes the time it was executed, what I actually prompted, and which model used, and small summarization of the understanding.

Note:
Add a AGENTS.md which will be used in every prompts and add this instruction over there. And from the next time, for all the prompt follow this.
```

* **Understanding & Action Summary:**
  * Created `AGENTS.md` at the repository root outlining the mandatory rule for all current and future agent sessions to log each prompt into `artifacts/prompts.md` with:
    1. Timestamp
    2. Model used
    3. Exact prompt text
    4. Comprehension summary
  * Backfilled Prompt 1 and logged Prompt 2 into `artifacts/prompts.md`.
  * Committed `AGENTS.md` and `artifacts/prompts.md` to Git for tracking.

---

## Prompt 3

* **Timestamp:** `2026-11-20 03:44:46 +05:30`
* **Model Used:** `Gemini 3.8 Flash (High)`
* **Exact Prompt:**
```text
Please review the PRD presented inside docs/requirments.md I have generated it. an I see that, it's covering so many things for the given simple problem statement.

"Currently, ACME org’s HR team manages salary data for 10,000 employees across multiple countries, with everything managed via excels, which is tedious. We want the HR manager to manage the salaries data via web-based software and be able to answer questions about how the org pays people"

Check, what are the things can be altered so that, developed feature for phase 1 will be simple and clean the future related target of few things with a very clear view and understanding.
```

* **Understanding & Action Summary:**
  * Reviewed `docs/requirements.md` in contrast with the candidate assessment brief (`Salary Management Assessment- Candidates.pdf`).
  * Identified that the original PRD suffered from feature bloat (e.g. what-if budget simulators, box plots, complex multi-tier comp ratio equity algorithms, dual DB setups).
  * Outlined a clean, focused Phase 1 (MVP) delivering the two core requirements with high quality:
    1. Fast, responsive web-based management of 10,000 multi-country records (search, sort, pagination, edit).
    2. Straightforward executive compensation analytics answering "how the org pays people" (total spend, country/department breakdowns, average/median salary).
  * Categorized non-essential and advanced capabilities into Phase 2 / Future Roadmap to demonstrate solid product judgment and disciplined engineering.
