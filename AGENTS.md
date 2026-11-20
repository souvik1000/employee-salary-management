# Agent Guidelines & Workflow Rules

This document specifies mandatory guidelines and instructions for AI agents working in this repository.

---

## 1. Prompt Logging Requirement (Mandatory)

For **every** prompt or request received from the user, the agent **must** append a log entry to [`artifacts/prompts.md`](file:///r:/FrontEnd/ReactApps/Test/employee-salary-management/artifacts/prompts.md).

Each prompt log entry must include the following details:
1. **Timestamp:** The date and time the prompt was received/executed (e.g., `YYYY-MM-DD HH:mm:ss [Timezone]`).
2. **Model Used:** The active AI model (e.g., `Gemini 3.8 Flash (High)`).
3. **Exact Prompt:** The verbatim prompt text provided by the user.
4. **Comprehension Summary:** A concise summary of the agent's understanding of the task and planned actions.

---

## 2. Development & Engineering Standards

* **Incremental Commits:** Regularly make clear, semantic git commits for each milestone, architectural decision, and feature implementation to reflect thoughtful progression.
* **Architecture Integrity:** Maintain clean separation of concerns between `web-services` (backend API, database entities, repositories, seeders) and `webapp` (frontend React components, state, hooks, visualizations).
* **Production Quality Code:** Write maintainable, type-safe TypeScript with comprehensive error handling and input validation.
* **Performance:** Ensure backend endpoints and frontend data grids are optimized to handle 10,000+ employee records seamlessly (e.g., server-side pagination, database indexing, query optimization, debounced search).
* **Artifacts & Documentation:** Maintain all planning, design, architecture, prompt logs, and trade-off notes in `artifacts/` and `docs/`.
