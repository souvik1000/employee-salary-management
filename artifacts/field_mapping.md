# ACME – Database Schema & Field Mapping (TypeORM + Meta Tables)

## 1. TypeORM Entities

### A. Department Meta Entity (`src/entities/Department.ts`)
```typescript
import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from "typeorm";
import { Employee } from "./Employee";

@Entity("departments")
export class Department {
  @PrimaryGeneratedColumn("uuid")
  id!: string;

  @Column({ type: "varchar", unique: true })
  code!: string; // e.g., "ENG", "SLS", "MKT", "OPS", "FIN", "HR"

  @Column({ type: "varchar", unique: true })
  name!: string; // e.g., "Engineering", "Sales", "Marketing", "Operations", "Finance", "HR"

  @OneToMany(() => Employee, (employee) => employee.department)
  employees!: Employee[];
}
```

### B. Country & Currency Meta Entity (`src/entities/CountryCurrency.ts`)
```typescript
import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from "typeorm";
import { Employee } from "./Employee";

@Entity("country_currencies")
export class CountryCurrency {
  @PrimaryGeneratedColumn("uuid")
  id!: string;

  @Column({ name: "country_code", type: "varchar", length: 3, unique: true })
  countryCode!: string; // e.g., "USA", "IND", "GBR", "DEU", "CAN"

  @Column({ name: "country_name", type: "varchar", unique: true })
  countryName!: string; // e.g., "United States", "India", "United Kingdom", "Germany", "Canada"

  @Column({ name: "currency_code", type: "varchar", length: 3 })
  currencyCode!: string; // e.g., "USD", "INR", "GBP", "EUR", "CAD"

  @Column({ name: "currency_symbol", type: "varchar", length: 5 })
  currencySymbol!: string; // e.g., "", "₹", "£", "€", "C"

  @Column({ type: "varchar" })
  locale!: string; // e.g., "en-US", "en-IN", "en-GB", "de-DE", "en-CA" (for Intl.NumberFormat)

  @OneToMany(() => Employee, (employee) => employee.countryCurrency)
  employees!: Employee[];
}
```

### C. Unified Employee Entity (`src/entities/Employee.ts`)
```typescript
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from "typeorm";
import { Department } from "./Department";
import { CountryCurrency } from "./CountryCurrency";

@Entity("employees")
@Index(["countryCurrencyId", "departmentId"])
export class Employee {
  @PrimaryGeneratedColumn("uuid")
  id!: string;

  @Column({ name: "employee_id", type: "varchar", unique: true })
  employeeId!: string; // e.g., "EMP-10001"

  @Index()
  @Column({ name: "full_name", type: "varchar" })
  fullName!: string;

  @Column({ type: "varchar", unique: true })
  email!: string;

  @Column({ name: "job_title", type: "varchar" })
  jobTitle!: string;

  // --- Foreign Key: Department Meta ---
  @Index()
  @Column({ name: "department_id", type: "uuid" })
  departmentId!: string;

  @ManyToOne(() => Department, (dept) => dept.employees, { eager: true })
  @JoinColumn({ name: "department_id" })
  department!: Department;

  // --- Foreign Key: Country & Currency Meta ---
  @Index()
  @Column({ name: "country_currency_id", type: "uuid" })
  countryCurrencyId!: string;

  @ManyToOne(() => CountryCurrency, (cc) => cc.employees, { eager: true })
  @JoinColumn({ name: "country_currency_id" })
  countryCurrency!: CountryCurrency;

  // --- Compensation ---
  @Column({
    name: "annual_salary",
    type: "decimal",
    precision: 12,
    scale: 2,
    transformer: {
      to: (value: number) => value,
      from: (value: string) => parseFloat(value),
    },
  })
  annualSalary!: number;

  // --- HR Manager Auth (Null for regular employees) ---
  @Column({ name: "password_hash", type: "varchar", nullable: true, select: false })
  passwordHash!: string | null;

  @Column({ name: "is_hr_admin", type: "boolean", default: false })
  isHrAdmin!: boolean;

  @CreateDateColumn({ name: "created_at" })
  createdAt!: Date;

  @UpdateDateColumn({ name: "updated_at" })
  updatedAt!: Date;
}
```

---

## 2. UI-to-API-to-DB Field Mapping

| UI Label (Stitch Design) | Form / Component | JSON API Key (`camelCase`) | DB Table & Column | Validation & Behavior |
| :--- | :--- | :--- | :--- | :--- |
| **Employee ID** | Add/Edit Form, Table | `employeeId` | `employees.employee_id` | `varchar`, unique, required, regex `/^EMP-\d{4,6}$/` |
| **Full Name** | Add/Edit Form, Table, Header | `fullName` | `employees.full_name` | `varchar`, min 2 chars, max 100 chars |
| **Work Email** | Add/Edit Form, Details | `email` | `employees.email` | `varchar`, unique, valid email format |
| **Department** | Select Dropdown, Filter | `departmentId` *(write)* / `department.name` *(read)* | `employees.department_id` -> `departments.id` | Valid UUID existing in `departments` meta table |
| **Job Title** | Text Input, Table, Details | `jobTitle` | `employees.job_title` | `varchar`, min 2 chars, max 80 chars |
| **Country** | Select Dropdown, Filter | `countryCurrencyId` *(write)* / `countryCurrency.countryName` *(read)* | `employees.country_currency_id` -> `country_currencies.id` | Valid UUID existing in `country_currencies` meta table |
| **Currency** | Read-only Auto-Fill Badge/Input | `countryCurrency.currencyCode` & `currencySymbol` | Derived via `country_currencies` relation | Automatically updates in React UI when `countryCurrencyId` changes |
| **Annual Salary** | Numeric Input, Table, Modal | `annualSalary` | `employees.annual_salary` | `decimal(12,2)`, required, strictly `> 0`, formatted using `countryCurrency.locale` |
| **Password** *(Login)* | `/login` Form | `password` *(input)* | `employees.password_hash` | `varchar` (nullable), `select: false`, `bcrypt` hash |
| **Last Updated** | Details Metadata | `updatedAt` | `employees.updated_at` | `timestamp` (auto-managed) |

---

## 3. Seeded Meta Reference Data (`web-services/database/seeds/seed.ts`)

Your `seed.ts` script will upsert these two meta tables **first**, capture their generated UUIDs, and then assign them across the 10,000 generated employees:

### `departments` Seed Data

| `code` | `name` |
| :--- | :--- |
| `ENG` | Engineering |
| `SLS` | Sales |
| `MKT` | Marketing |
| `OPS` | Operations |
| `FIN` | Finance |
| `HR` | Human Resources |

### `country_currencies` Seed Data

| `countryCode` | `countryName` | `currencyCode` | `currencySymbol` | `locale` | Realistic Seed Salary Range |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `USA` | United States | `USD` | `$` | `en-US` | `65,000 – 210,000` |
| `IND` | India | `INR` | `₹` | `en-IN` | `600,000 – 4,500,000` |
| `GBR` | United Kingdom | `GBP` | `£` | `en-GB` | `45,000 – 150,000` |
| `DEU` | Germany | `EUR` | `€` | `de-DE` | `55,000 – 145,000` |
| `CAN` | Canada | `CAD` | `C$` | `en-CA` | `60,000 – 180,000` |
