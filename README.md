# MineIntel AI

### AI-Powered Geological, Mining & Reporting Intelligence Platform
**Smart India Hackathon 2026 — Problem Statement 26023**

> **Prototype status:** This repository currently contains a **Flutter frontend prototype only**. The application uses **mock/static data** to demonstrate the MineIntel AI product flow and UI. It does **not** currently connect to a production backend, real mining documents, OCR services, a vector database, an LLM/RAG pipeline, or real enterprise data sources.

The prototype demonstrates the intended experience of turning mining and geological information into a searchable, verifiable and report-ready intelligence workflow.

---

## Table of contents

1. [What this project is](#1-what-this-project-is)
2. [Problem statement](#2-problem-statement)
3. [Prototype vs. real system](#3-prototype-vs-real-system)
4. [What is implemented now](#4-what-is-implemented-now)
5. [What the real system will use](#5-what-the-real-system-will-use)
6. [Architecture](#6-architecture)
7. [Product flow](#7-product-flow)
8. [Screens](#8-screens)
9. [Technology stack](#9-technology-stack)
10. [Project structure](#10-project-structure)
11. [Prerequisites](#11-prerequisites)
12. [Run the Flutter app](#12-run-the-flutter-app)
13. [Mock data model](#13-mock-data-model)
14. [Real-data implementation plan](#14-real-data-implementation-plan)
15. [Security and governance](#15-security-and-governance)
16. [Current limitations](#16-current-limitations)
17. [Future roadmap](#17-future-roadmap)
18. [Three-minute demo](#18-three-minute-demo)
19. [Credits](#19-credits)

---

## 1. What this project is

MineIntel AI is a concept platform for CMPDI / CIL subsidiaries that aims to convert scattered geological and mining records into:

- searchable organizational knowledge
- evidence-backed answers
- deterministic verification
- structured mining reports
- traceable and reviewable outputs

The product concept combines **Document Intelligence, RAG, Verification and Automated Reporting**.

The intended product loop is:

```text
Documents
   ↓
Upload & Ingestion
   ↓
OCR / Document Understanding
   ↓
Extraction & Normalization
   ↓
Knowledge Index
   ↓
Ask AI
   ↓
Evidence & Citations
   ↓
Deterministic Verification
   ↓
Report Generation
   ↓
Human Review / Approval
```

The current Flutter application focuses on demonstrating the **frontend experience of this flow**. The backend and AI/data pipeline are planned for the real implementation.

---

## 2. Problem statement

Mining and geological information can be distributed across PDFs, spreadsheets, scanned records and legacy reports. Finding the correct information is not enough; users also need to know where a value came from, whether calculations are correct and whether conflicting information exists.

MineIntel AI is designed to address this by providing a governed intelligence layer for:

- document ingestion
- OCR and extraction
- mining/geological knowledge management
- natural-language question answering
- source/page/table citations
- deterministic calculations
- conflict detection
- report generation
- review and approval

The concept book defines the core principle as:

> **AI discovers and explains; deterministic logic verifies; humans approve high-impact outputs.**

---

## 3. Prototype vs. real system

This is the most important distinction for the current repository.

### Current prototype

| Area | What we use now |
|---|---|
| Frontend | **Flutter** mobile application |
| Data | **Mock / static demo data** |
| Backend | **Not implemented in this repository** |
| API | **No production API connection** |
| Database | **No database** |
| Authentication | UI/demo flow only; not production authentication |
| Documents | Mock document records |
| OCR | Not implemented |
| Table extraction | Not implemented |
| Knowledge index | Mock UI representation |
| Vector database | Not implemented |
| RAG | Not implemented |
| LLM | Not connected to the app |
| Verification | UI/demo representation; real verification engine is planned |
| Reports | UI/report workflow demonstration |
| Audit logs | Not implemented |
| RBAC | UI role representation; backend enforcement is not implemented |
| Object storage | Not implemented |
| Background workers | Not implemented |

### Real system

| Area | What the real implementation should use |
|---|---|
| Frontend | React / Next.js + Tailwind CSS, or the Flutter frontend retained as the client |
| Backend | Node.js / Express or FastAPI |
| AI service | Python service for OCR, retrieval and model orchestration |
| OCR | PaddleOCR or Tesseract depending on document quality |
| Database | PostgreSQL |
| Vector search | pgvector or Qdrant |
| Object storage | S3-compatible storage |
| Queue / cache | Redis + background workers |
| Documents | Real mining/geological PDFs, scans, spreadsheets and legacy records |
| Knowledge retrieval | Hybrid keyword + semantic vector search with metadata filtering |
| LLM | Approved enterprise/hosted/private LLM behind a provider abstraction |
| Verification | Deterministic mining formulas and consistency checks |
| Reports | Evidence-backed report generation with human approval |
| Security | RBAC, tenant/workspace isolation, encryption, audit logs and secret management |
| Deployment | Docker, with Kubernetes-ready architecture for future scale |
| Observability | Logs, job metrics and retrieval/evaluation metrics |

The real-system technology direction above follows the MineIntel AI concept architecture: frontend, API, document parsing, AI/RAG, verification, data storage and asynchronous workers.

---

## 4. What is implemented now

The current repository is intentionally kept small so the SIH prototype can demonstrate the product experience without pretending that mock data is operational mining data.

### Implemented

- Flutter application shell
- Splash screen
- Login screen
- Role selection
- Dashboard
- KPI cards
- Production-vs-target visualization
- Quick actions
- Recent activity
- Ask AI interface
- Source/citation-style UI
- Confidence indicators
- Knowledge Hub
- Search/filter UI
- Report Studio
- Report status workflow
- Report generation UI
- Report review/approval UI
- Navigation and animations
- Mock data to populate the screens

### Not implemented yet

- Real document upload pipeline
- OCR
- Table extraction
- Real document parsing
- PostgreSQL
- Vector database
- Embeddings
- Hybrid retrieval
- RAG orchestration
- Production LLM integration
- Real mining calculations service
- Conflict detection engine
- Real report-generation backend
- Persistent users
- Production RBAC
- Audit logging
- Enterprise deployment

---

## 5. What the real system will use

The concept book divides MineIntel AI into six connected product areas:

### A. Intelligence Ingestion

Real documents will be uploaded with metadata and provenance.

```text
PDF / Scan / Spreadsheet / Legacy Record
                    ↓
              Document Intake
                    ↓
            OCR / Extraction
                    ↓
         Metadata + Normalization
```

Every extracted fact should retain its source document, page/sheet, extraction method, timestamp and confidence.

### B. Mining Knowledge Hub

The real knowledge layer should store:

- mines/projects
- boreholes
- coal seams
- production periods
- overburden
- reports
- extracted evidence
- document chunks
- tables
- entities and relationships

Structured values should remain linked to their original evidence.

### C. AI Reporting Assistant

The real assistant should use RAG instead of relying only on model memory.

```text
User Question
     ↓
Intent Understanding
     ↓
Hybrid Search
     ├── Keyword Search
     ├── Semantic Search
     └── Metadata Filters
     ↓
Reranking
     ↓
Evidence Set
     ↓
LLM
     ↓
Cited Answer
```

The system should avoid presenting a confident answer when sufficient evidence is not available.

### D. Verification Engine

The LLM should not be responsible for calculations when a deterministic formula exists.

For example:

```text
Stripping Ratio =
Overburden Volume / Coal Production
```

The system should show:

- input values
- source references
- formula
- units
- calculated result

It should also identify conflicting values between sources.

### E. Report Studio

The real system should:

1. select an approved template
2. retrieve verified facts
3. insert source references
4. generate structured tables
5. draft narrative sections
6. allow human review
7. export the approved report

A generated report should remain a **reviewable draft until the responsible human approves it**.

### F. Governance Layer

The production system should provide:

- authentication
- role-based access control
- least-privilege permissions
- workspace/subsidiary isolation
- audit logs
- document/report versioning
- secret management
- human approval for high-impact outputs

---

## 6. Architecture

### Current prototype architecture

```text
┌─────────────────────────────────────────────┐
│                Flutter App                  │
│                                             │
│  Splash → Login → Dashboard → Knowledge     │
│                    ↓          Hub            │
│                 Ask AI → Report Studio      │
│                                             │
│              Mock / Static Data             │
└─────────────────────────────────────────────┘
```

There is currently no production backend or external data pipeline connected to the application.

### Intended real architecture

```text
┌───────────────┐
│     Users     │
└───────┬───────┘
        ↓
┌──────────────────────┐
│ Web / Mobile Client  │
│ Dashboard / AI /     │
│ Knowledge / Reports  │
└──────────┬───────────┘
           ↓
┌──────────────────────┐
│ API / Authentication │
│ RBAC / Orchestration │
└──────────┬───────────┘
           ↓
 ┌─────────┼───────────────────────────┐
 ↓         ↓            ↓              ↓
Document  AI / RAG   Verification   Reports
Service   Service       Engine        Service
 ↓         ↓            ↓              ↓
OCR      Embeddings   Rules/Math     Templates
 ↓         ↓
 └─────────┼───────────────────────────┘
           ↓
 ┌────────────────────────────────────┐
 │ PostgreSQL + pgvector / Qdrant     │
 │ S3-compatible object storage       │
 │ Redis + background workers         │
 └────────────────────────────────────┘
```

---

## 7. Product flow

The complete intended workflow is:

| Stage | Intended system behavior | Current prototype |
|---|---|---|
| 1. Login | Authenticate user and load authorized workspace | UI/demo |
| 2. Upload | Store document and metadata | Mock UI |
| 3. Process | OCR, extract, normalize and index | Mock UI |
| 4. Ask | Retrieve evidence and understand question | Mock AI interface |
| 5. Evidence | Show source/page/table references | Mock citation UI |
| 6. Verify | Calculate, compare and flag conflicts | UI demonstration |
| 7. Report | Assemble approved facts | Report UI |
| 8. Approve | Human reviews and finalizes | UI workflow |

The concept book describes this workflow as:

```text
Login → Upload → Process → Ask → Evidence → Verify → Report → Approve
```

---

## 8. Screens

The current frontend contains six major product areas:

### 1. Splash Screen

- animated MineIntel branding
- product identity
- loading/entry experience

### 2. Login Screen

- email/password interface
- role selector
- roles represented in the prototype include:
  - Geologist
  - Mining Engineer
  - Reporting Officer
  - Management
  - Reviewer / Approver
  - Administrator

### 3. Dashboard

The dashboard demonstrates:

- documents ingested
- pending reviews
- reports generated
- active conflicts
- production vs. target
- quick actions
- recent activity

### 4. Ask AI

The interface demonstrates the intended RAG assistant experience:

- natural-language questions
- answers
- source references
- confidence indicators
- deterministic calculation traces

### 5. Knowledge Hub

The Knowledge Hub demonstrates:

- searchable documents
- filtering
- document metadata
- confidence indicators
- knowledge/document browsing

### 6. Report Studio

The Report Studio demonstrates:

- report list
- Draft status
- Under Review status
- Approved status
- Needs Verification status
- generate-from-template flow
- report details
- review/approval workflow

---

## 9. Technology stack

### Current prototype

| Layer | Technology |
|---|---|
| Application | Flutter |
| Language | Dart |
| UI | Flutter Material / Cupertino |
| Date formatting | `intl` |
| Icons | `cupertino_icons` |
| Data | Local mock/static data |
| Backend | None |
| Database | None |
| AI | None connected |
| Deployment | Flutter-supported platforms |

The current `pubspec.yaml` contains Flutter, `cupertino_icons` and `intl` as the main dependencies.

### Intended production stack

| Layer | Technology |
|---|---|
| Frontend | React / Next.js + Tailwind CSS |
| Backend | Node.js / Express or FastAPI |
| AI service | Python |
| OCR | PaddleOCR / Tesseract |
| Database | PostgreSQL |
| Vector search | pgvector / Qdrant |
| Object storage | S3-compatible storage |
| Queue / cache | Redis + workers |
| Deployment | Docker / Kubernetes-ready |
| Observability | Logs + job/retrieval/evaluation metrics |

---

## 10. Project structure

The current repository is a Flutter application.

A typical structure is:

```text
mineintel_ai/
├── README.md
├── pubspec.yaml
├── analysis_options.yaml
├── android/
├── ios/
├── web/
├── lib/
│   ├── main.dart
│   ├── theme.dart
│   └── screens/
│       ├── splash.dart
│       ├── login.dart
│       ├── dashboard.dart
│       ├── ask_ai.dart
│       ├── knowledge_hub.dart
│       └── report_studio.dart
└── test/
```

> File names can evolve as the frontend is refined. The important distinction is that the current repository is the **frontend prototype**, while the backend/AI/data architecture described above is the planned production system.

---

## 11. Prerequisites

Install:

- Flutter 3.x
- Dart 3.x
- Android Studio, VS Code or another Flutter-compatible IDE
- Android emulator, iOS simulator or a physical device

Check Flutter:

```bash
flutter doctor
```

---

## 12. Run the Flutter app

Clone the repository and enter the project:

```bash
git clone <repository-url>
cd mineintel_ai
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

For an Android release APK:

```bash
flutter build apk --release
```

The current app does not require a backend server, database or API key to demonstrate the frontend prototype.

---

## 13. Mock data model

The current screens use representative demo values so the interface can be demonstrated without real mining records.

Examples of information represented by mock data include:

```text
Documents
├── document name
├── document type
├── mine/project
├── reporting period
├── status
└── confidence

Mining facts
├── production
├── target
├── overburden
├── seam information
└── geological records

AI responses
├── question
├── answer
├── source
├── confidence
└── calculation trace

Reports
├── title
├── status
├── created date
├── sections
└── review state
```

### Important

These values are **for UI demonstration only**.

They should not be interpreted as:

- official CMPDI/CIL data
- real mine measurements
- verified geological information
- actual production figures
- real AI predictions
- official reports

---

## 14. Real-data implementation plan

Replacing mock data with real data should happen in stages.

### Phase 1 — Document ingestion

Connect the frontend to an API:

```text
Flutter/Web Client
       ↓
Upload API
       ↓
Object Storage
       ↓
Processing Queue
```

Supported inputs should include:

- PDF
- scanned PDF/image
- spreadsheet
- legacy report
- structured record

### Phase 2 — OCR and extraction

A Python document service can perform:

```text
Document
   ↓
OCR
   ↓
Text + Tables + Layout
   ↓
Metadata
   ↓
Normalized Records
```

The extracted information should preserve provenance.

### Phase 3 — Knowledge index

Create:

- document chunks
- embeddings
- metadata
- structured mining entities
- source references

Use:

- PostgreSQL for structured metadata
- pgvector or Qdrant for semantic retrieval
- S3-compatible storage for original files

### Phase 4 — RAG assistant

Connect the Ask AI screen to:

```text
Question
   ↓
Query processing
   ↓
Hybrid retrieval
   ↓
Reranking
   ↓
Evidence context
   ↓
LLM
   ↓
Cited answer
```

The answer should expose its supporting evidence.

### Phase 5 — Verification

Move calculations to backend deterministic functions.

Example:

```text
Input:
Overburden = source value
Coal Production = source value

Formula:
Stripping Ratio =
Overburden / Coal Production

Output:
Result + Inputs + Formula + Sources
```

The backend should also compare values from different documents and flag conflicts.

### Phase 6 — Reporting

The Report Studio frontend should call a report-generation service that:

- loads an approved template
- inserts verified facts
- adds source references
- creates tables
- drafts narrative
- sends the report for review
- exports PDF/DOCX-ready output

### Phase 7 — Governance

Add:

- real authentication
- RBAC
- workspace/subsidiary isolation
- audit logs
- versioning
- approval workflow
- secret management
- encryption
- monitoring

---

## 15. Security and governance

The concept is intended for operational and business-sensitive mining information.

A real deployment should include:

- least-privilege access
- role-based permissions
- workspace/subsidiary isolation
- encryption in transit and at rest
- audit logging
- document/report versioning
- secure secret management
- server-side API credentials
- explicit human approval for high-impact outputs

The frontend prototype does **not** provide these production guarantees yet.

---

## 16. Current limitations

This repository is a **frontend concept prototype**, not a production MineIntel AI system.

### Data limitations

- Data displayed by the app is mock/static.
- No real CMPDI/CIL datasets are connected.
- No real geological documents are ingested.
- No real production database is used.

### AI limitations

- No production LLM is connected to the current frontend.
- No real RAG pipeline is running.
- No embeddings or vector search are running.
- No production OCR model is running.

### Backend limitations

- No backend API is currently required by the prototype.
- No persistent database is connected.
- No production authentication service is connected.
- No audit service is connected.

### Verification limitations

The current interface demonstrates where verification will appear, but production calculations should be implemented in a deterministic backend verification service using validated mining formulas and source-linked inputs.

---

## 17. Future roadmap

### MVP backend

- [ ] Node.js/Express or FastAPI backend
- [ ] Authentication and RBAC
- [ ] PostgreSQL
- [ ] S3-compatible document storage
- [ ] Document upload API
- [ ] OCR pipeline
- [ ] Metadata extraction
- [ ] Table extraction
- [ ] Knowledge indexing
- [ ] pgvector/Qdrant retrieval
- [ ] RAG assistant
- [ ] Source citations
- [ ] Deterministic verification
- [ ] Conflict detection
- [ ] Report generation
- [ ] Audit logging

### Scale-up

- [ ] Redis/background workers
- [ ] Larger document collections
- [ ] Cross-subsidiary isolation
- [ ] Model/provider abstraction
- [ ] Kubernetes-ready deployment
- [ ] Observability and evaluation metrics
- [ ] Private/on-premise deployment option
- [ ] Advanced mining analytics
- [ ] Topic intelligence and word-cloud generation

---

## 18. Three-minute demo

The prototype can be demonstrated as a product walkthrough:

| Time | Scene | What to show |
|---|---|---|
| 0:00–0:25 | Splash → Login | Product identity and role-based entry |
| 0:25–0:55 | Dashboard | KPIs, activity and mining overview |
| 0:55–1:25 | Ask AI | Ask a mining/geological question |
| 1:25–1:55 | Evidence | Show source/citation-style interface |
| 1:55–2:25 | Verification | Show calculation/conflict concept |
| 2:25–3:00 | Report Studio | Generate, review and approve report concept |

### Demo statement

> **“The current prototype demonstrates the complete MineIntel AI user experience using mock data. In the real system, those mock records will be replaced by real mining documents, OCR, a searchable knowledge layer, RAG, deterministic verification and evidence-backed report generation.”**

---

## 19. Credits

Built as a **Smart India Hackathon 2026** project concept for:

**Problem Statement 26023 — MineIntel AI: AI-Powered Geological, Mining & Reporting Intelligence Platform for CMPDI / CIL Subsidiaries**

This repository represents the **frontend demonstration/prototype stage** of the proposed system. It should not be treated as an official CMPDI, CIL or government information system.
