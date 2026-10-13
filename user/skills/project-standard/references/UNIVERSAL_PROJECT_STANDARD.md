# Universal Project Standard

## Purpose

ეს არის reusable სტანდარტი ახალი software პროექტებისთვის.

Claude-მ ეს დოკუმენტი უნდა გამოიყენოს როგორც საბაზისო არქიტექტურული სტანდარტი ნებისმიერი ტიპის პროექტისთვის, მათ შორის:

- website / web app
- SaaS
- e-commerce
- AI application / AI agent
- API / backend service
- internal tool / dashboard
- automation
- content platform
- marketplace
- mobile app backend
- სხვა software პროექტები

მთავარი პრინციპი:

> **Build the simplest production-ready architecture that solves the current requirements. Add complexity only when a real requirement justifies it.**

არქიტექტურა უნდა მოერგოს პროექტის რეალურ მოთხოვნებს, ზომას, მონაცემებს, integrations-ს, security-ს, მომხმარებლების მოცულობას და deployment გარემოს.

არ უნდა შეიქმნას რთული არქიტექტურა მხოლოდ იმიტომ, რომ უფრო "professional", "enterprise" ან "scalable" გამოიყურებოდეს.

---

# 1. Document Hierarchy

Claude-მ პრიორიტეტები ასე უნდა გაიგოს:

1. System / platform requirements
2. `PROJECT.md` — კონკრეტული პროექტის მოთხოვნები და გადაწყვეტილებები
3. `UNIVERSAL_PROJECT_STANDARD.md` — ეს დოკუმენტი
4. Claude-ის ვარაუდები — მხოლოდ მაშინ, როცა ზემოთ მოცემულში პასუხი არ არსებობს

`PROJECT.md` აღწერს კონკრეტულ პროექტს: რა პრობლემას წყვეტს, ვინ იყენებს, ძირითად features-ს, business rules-ს, integrations-ს, რეალისტურ scale-ს, deployment-ს, constraints-ს, მიმდინარე ეტაპს, technical decisions-ს და open questions-ს.

თუ `PROJECT.md` კონკრეტულ მოთხოვნას ადგენს, ის ამ დოკუმენტის შესაბამის default-ს ცვლის.

ამ დოკუმენტში მოცემული folder trees, routes, services, technologies, components და modules არის **მაგალითები და არა checklist**. Claude-მ შექმნას მხოლოდ ის, რაც პროექტს რეალურად სჭირდება.

თუ მნიშვნელოვანი საკითხი არც `PROJECT.md`-შია და არც ამ standard-ში, Claude-მ ჯერ შეფასოს შესაძლო მარტივი ვარიანტები და, თუ გადაწყვეტილება არსებითად ცვლის architecture-ს ან business behavior-ს, დააფიქსიროს ის `PROJECT.md`-ის decision log-ში.

---

# 2. Requirements Before Architecture

კოდის წერამდე Claude-მ უნდა განსაზღვროს:

1. რა ტიპის პროექტია?
2. ვინ არის მომხმარებელი?
3. რა არის MVP / Stage 1?
4. რა არის მთავარი user/business flow?
5. რა მონაცემები არსებობს?
6. რა integrations არის საჭირო?
7. არის თუ არა authentication / authorization საჭირო?
8. ეხება თუ არა პროექტი ფულს, payments-ს, inventory-ს, sensitive data-ს ან user-generated content-ს?
9. რა არის რეალისტური მიმდინარე scale?
10. სად უნდა განთავსდეს პროექტი?
11. რა უნდა დარჩეს მარტივი ახლა?
12. რა შეიძლება დაემატოს მოგვიანებით მხოლოდ რეალური საჭიროების შემთხვევაში?

Claude-მ არ უნდა ააგოს hypothetical future architecture.

---

# 3. Existing Projects

თუ Claude მუშაობს უკვე არსებულ project-ზე:

- არსებული stack, conventions, folder structure და patterns პრიორიტეტულია ამ დოკუმენტის defaults-თან შედარებით
- არ გადაიტანო project სხვა framework-ზე, ORM-ზე, styling solution-ზე ან package manager-ზე მხოლოდ იმიტომ, რომ ეს დოკუმენტი სხვა default-ს ასახელებს
- ახალი კოდი უნდა ჰგავდეს გარშემო არსებულ კოდს (naming, error handling, file layout)
- თუ არსებული structure რეალურ პრობლემას ქმნის, Claude-მ შესთავაზოს ცვლილება და დაასაბუთოს — და არა ჩუმად გადააწყოს

> **In an existing project, consistency with the codebase beats this document's defaults.**

---

# 4. When to Ask vs. When to Assume

Claude-მ კითხვა უნდა დასვას, როცა პასუხი არსებითად ცვლის:

- data model-ს ან schema-ს, რომლის შეცვლაც მოგვიანებით ძვირია
- money, payments, permissions ან sensitive data-ს behavior-ს
- deployment target-ს ან ძირითად technology choice-ს
- business rule-ს, რომელიც მომხმარებელზე პირდაპირ აისახება

სხვა შემთხვევებში Claude-მ აირჩიოს გონივრული, მარტივი და შექცევადი ვარიანტი, მოკლედ დააფიქსიროს ვარაუდი და გააგრძელოს მუშაობა.

კითხვები დაჯგუფდეს ერთად და არ დაისვას ისეთი, რომლის პასუხიც უკვე არის `PROJECT.md`-ში ან კოდში.

---

# 5. Complexity Tiers

პროექტის სირთულე განისაზღვრება რეალური მოთხოვნებიდან და არა მხოლოდ პროექტის სახელიდან.

## Tier 1 — Simple

მაგალითები:

- static website
- landing page
- portfolio
- simple content site
- small CRUD tool
- simple calculator / utility
- small internal tool

Default:

```text
single application
+
minimal dependencies
+
simple deployment
```

Backend, database, global state ან separate services არ იქმნება, თუ პროექტს არ სჭირდება.

## Tier 2 — Standard

მაგალითები:

- normal web application
- small SaaS
- dashboard
- e-commerce
- authenticated application
- application with database and integrations

Typical shape:

```text
frontend
+
backend/API
+
PostgreSQL
+
object storage when needed
+
external providers when needed
```

Frontend და backend შეიძლება ერთ აპლიკაციაშიც იყოს, თუ მოთხოვნები ამას ამართლებს.

## Tier 3 — Complex

მაგალითები:

- multi-tenant SaaS
- heavy AI workflows
- substantial background processing
- realtime system
- high-volume API
- complex third-party integrations
- significant data processing

შეიძლება საჭირო გახდეს:

```text
web application
+
API
+
database
+
queue/workers
+
cache
+
object storage
+
external services
```

თითოეული დამატება ცალკე უნდა იყოს დასაბუთებული.

## Tier 4 — Scale / Distributed

მხოლოდ რეალური და გაზომილი საჭიროების შემთხვევაში:

- მაღალი traffic / request volume
- რამდენიმე დამოუკიდებლად scaling workload
- მკაცრი availability მოთხოვნები
- დიდი event processing
- multi-region requirements
- სხვადასხვა გუნდის მიერ ცალკე სერვისების ownership

შეიძლება საჭირო გახდეს distributed architecture, dedicated services, read replicas, CDN, queues, caches ან სხვა infrastructure.

**Tier 4 არასდროს არის default.**

---

# 6. Architecture Selection Rule

Claude-მ ჯერ უნდა გადაწყვიტოს:

> **რამდენად რთული უნდა იყოს ეს პროექტი ახლა?**

და არა:

> **რა არის ყველაზე ძლიერი architecture, რომელიც შეიძლება მომავალში დამჭირდეს?**

Evolution-ის default გზა:

```text
single app
↓
single backend service
↓
modular monolith
↓
separate services
↓
distributed architecture
```

შემდეგ ეტაპზე გადასვლა ხდება მაშინ, როცა მიმდინარე ეტაპი რეალურ მოთხოვნას ვეღარ აკმაყოფილებს, ან გაზომილი პრობლემა ამას მოითხოვს.

---

# 7. Default Technology Strategy

არ არსებობს ერთი სავალდებულო stack ყველა პროექტისთვის.

Claude-მ technology უნდა შეარჩიოს project type, requirements, team constraints, deployment და maintenance cost-ის მიხედვით.

### Web frontend default

```text
Next.js + TypeScript
App Router
Tailwind CSS
```

UI primitives:

```text
shadcn/ui — მხოლოდ საჭირო კომპონენტები
```

### Python backend default

```text
FastAPI
Python
Pydantic
SQLAlchemy
Alembic
```

თუ სხვა ecosystem კონკრეტულ პროექტს უკეთ ერგება, შეიძლება სხვა backend stack-ის გამოყენება.

### Database default

```text
PostgreSQL
```

Managed option:

```text
Supabase ან სხვა managed PostgreSQL
```

### Storage default

```text
object storage when needed
```

მაგალითად:

```text
Supabase Storage
S3-compatible storage
Cloudflare R2
```

### Non-SEO SPA / internal dashboard

თუ public SEO და server rendering საჭირო არ არის, შეიძლება უფრო მარტივი იყოს:

```text
Vite + React + TypeScript
```

არჩევანი ჩაიწეროს `PROJECT.md`-ში.

### Mobile

თუ project-ს mobile client სჭირდება, stack შეირჩეს ცალკე (მაგ. React Native / Expo ან native) და დაფიქსირდეს `PROJECT.md`-ში. ეს დოკუმენტი mobile client-ის შიდა architecture-ს დეტალურად არ არეგულირებს.

### Package managers / tooling

გამოიყენე ecosystem-ის ბუნებრივი tooling. მაგალითად `pnpm` frontend-ზე და `uv` Python backend-ზე.

Lockfile (`pnpm-lock.yaml`, `uv.lock` და ა.შ.) ყოველთვის commit-დება.

### Code quality tooling

Default, თუ project-ს უკვე სხვა tooling არ აქვს:

```text
TypeScript: strict mode + ESLint + Prettier (ან Biome)
Python: Ruff (lint + format) + type checker (mypy ან pyright)
```

Lint/format წესები იყოს ავტომატური და არა ხელით დასაცავი.

---

# 8. Technology Selection Rules

ახალი technology-ის დამატებამდე უპასუხე:

1. რა კონკრეტულ პრობლემას წყვეტს?
2. პრობლემა რეალურია თუ hypothetical?
3. არსებული stack-ით შეიძლება ამის გაკეთება?
4. რა complexity-ს მატებს?
5. რა maintenance cost მოაქვს?
6. რამდენად ხშირად იქნება გამოყენებული?
7. არის თუ არა უფრო მარტივი ალტერნატივა?

თუ მარტივი გადაწყვეტა საკმარისია, აირჩიე მარტივი გადაწყვეტა.

ახალი dependency მხოლოდ "best practice"-ის სახელით არ დაამატო.

Dependency-ის დამატებისას ასევე შეამოწმე:

- აქტიურად მხარდაჭერილია თუ არა
- license თავსებადია თუ არა project-თან
- რამდენად დიდია (განსაკუთრებით frontend bundle-ზე გავლენა)
- ხომ არ აკეთებს იმას, რაც რამდენიმე ხაზი კოდით კეთდება

ამავე კითხვებს ეყრდნობა **Complexity Gate** სექცია, რომელიც ყველა ტიპის ახალ დამატებას ეხება.

---

# 9. Default Project Structure

შუალედური web application-ის მაგალითი:

```text
project/
├── frontend/
│   ├── src/
│   │   ├── app/
│   │   ├── components/
│   │   ├── features/
│   │   ├── services/
│   │   ├── hooks/
│   │   ├── lib/
│   │   └── types/
│   ├── public/
│   └── package.json
│
├── backend/
│   ├── app/
│   │   ├── core/
│   │   ├── db/
│   │   ├── models/
│   │   ├── schemas/
│   │   ├── routes/
│   │   └── services/
│   ├── migrations/
│   ├── tests/
│   └── pyproject.toml
│
├── docs/
├── .env.example
├── PROJECT.md
└── README.md
```

მაგრამ simple project-ისთვის შეიძლება საკმარისი იყოს:

```text
src/
├── app/
├── components/
└── lib/
```

ან ერთი app folder-იც კი.

---

# 10. Folder Rules

Folder არ იქმნება მხოლოდ "clean architecture"-ის საჩვენებლად.

არ შექმნა წინასწარ:

- empty folders
- generic utility folders
- service layer ერთი trivial function-ისთვის
- feature folder ერთი პატარა ფაილისთვის
- repository layer ყველგან
- adapter/factory layer hypothetical provider switching-ისთვის
- abstraction მხოლოდ abstraction-ის გამო

> **Create a folder because the project needs the responsibility, not because the architecture diagram looks cleaner.**

---

# 11. Separation of Responsibilities

სადაც რამდენიმე ფენა არსებობს, პასუხისმგებლობები იყოს მკაფიო.

### Frontend

- UI
- routes
- rendering
- user interaction
- client state
- API communication
- SEO
- accessibility

### Backend

- business logic
- authorization
- validation
- database operations
- integrations
- background jobs when needed
- server-side calculations

### Database

- persistent data
- relationships
- constraints
- indexes
- transactions

### External services

- payments
- email/SMS
- storage
- AI providers
- search
- analytics
- shipping

External provider-ის კონკრეტული logic შესაბამის application module-ში რჩება.

---

# 12. Business Logic Rule

Business logic არ უნდა იყოს შემთხვევით მიმოფანტული UI components-ში, route handlers-ში ან utility files-ში.

მაგრამ პატარა პროექტში პატარა rule-ისთვის ზედმეტი service architecture არ შეიქმნას.

მაგალითად, ასეთი ჯაჭვი საჭიროების გარეშე არ შექმნა:

```text
route
→ repository
→ service factory
→ use case factory
→ adapter
→ repository interface
→ database
```

თუ პირდაპირი route → service → database საკმარისია, გამოიყენე ის.

---

# 13. API Architecture

თუ პროექტს backend/API აქვს:

```text
Client
→ API
→ business logic
→ database / external services
```

API contract იყოს მკაფიო და consistent.

FastAPI/Pydantic პროექტებში default:

```text
Pydantic schemas
→ OpenAPI
→ generated frontend types
```

ხელით დუბლირებული API types მაქსიმალურად აირიდე.

### API conventions

- ერთიანი error response format მთელ API-ში
- სწორი HTTP status codes
- list endpoints-ს ჰქონდეს pagination, თუ შედეგი შეიძლება გაიზარდოს
- naming consistent იყოს (მაგ. ერთი სტილი: `snake_case` ან `camelCase` JSON-ში)
- API versioning (`/v1`) მხოლოდ მაშინ, როცა გარე consumers არსებობს, რომელთა გატეხვაც არ შეიძლება
- breaking change გარე consumer-ისთვის არ კეთდება შეთანხმების ან migration გზის გარეშე

---

# 14. Server vs Client Rendering

Web project-ში default არის server-side rendering / Server Components, როცა browser interaction აუცილებელი არ არის.

Client-side code გამოიყენე მხოლოდ როცა საჭიროა:

- interactive state
- event handlers
- browser APIs
- client-only libraries
- realtime client behavior

`"use client"` რაც შეიძლება დაბალ component დონეზე იყოს.

---

# 15. State Management

State-ის შენახვის ადგილის არჩევის default თანმიმდევრობა:

```text
local component state
↓
URL state
↓
server state
↓
context
↓
global state library
```

Redux, Zustand ან სხვა global state მხოლოდ რეალური shared-state complexity-ის შემთხვევაში.

URL-ში შეინახე shareable / navigational state, მაგალითად:

- search
- filters
- sort
- pagination
- selected view

---

# 16. Data Fetching

Default:

- server-side fetch სადაც შესაძლებელია
- client fetching მხოლოდ საჭიროებისას
- duplicate requests არ უნდა არსებობდეს მიზეზის გარეშე
- ერთი domain-ის data-access logic არ უნდა დუბლირდეს მრავალ ადგილას

თუ framework-ს აქვს უფრო სწორი server-side data fetching, page-level initial data-სთვის შემთხვევითი `useEffect` fetching არ გამოიყენო.

---

# 17. Caching

Caching გადაწყვეტილება მოთხოვნიდან უნდა გამომდინარეობდეს.

Cache შეიძლება გამოყენებული იყოს:

- public content-ზე
- expensive read-only data-ზე
- rarely-changing resources-ზე
- performance bottleneck-ის მოსაგვარებლად

დაუფიქრებლად არ cache-ო:

- private user data
- authentication state
- transactional data
- rapidly changing state
- security-sensitive state

Rule:

> **Cache only when stale data, latency, load or cost creates a real problem.**

---

# 18. Database Rules

Default relational database:

```text
PostgreSQL
```

საჭიროების შემთხვევაში შეიძლება სხვა database, მაგრამ გადაწყვეტილება უნდა ემყარებოდეს რეალურ data model-ს.

### ძირითადი წესები

- foreign keys სადაც საჭიროა
- unique constraints DB დონეზე
- check constraints სადაც საჭიროა
- indexes საჭირო lookup/filter fields-ზე
- timestamps where useful
- transaction boundaries მკაფიოდ
- schema changes მხოლოდ migrations-ით
- უკვე გაშვებული migration არ რედაქტირდება
- timestamps ინახება UTC-ში, timezone-aware ტიპით (PostgreSQL-ში `timestamptz`); local time მხოლოდ display დონეზე
- destructive migration (column/table წაშლა, ტიპის შეცვლა) production-ზე ეტაპობრივად, data-ს დაკარგვის რისკის შეფასებით
- soft delete მხოლოდ მაშინ, როცა business ან audit requirement ამას მოითხოვს

NoSQL database არ აირჩიო მხოლოდ იმიტომ, რომ "modern" არის, თუ relational model უკეთესად აგვარებს ამოცანას.

---

# 19. Money / Financial Data

თუ პროექტი ეხება ფულს:

- float არ გამოიყენო
- გამოიყენე integer minor units ან Decimal / NUMERIC
- currency ყოველთვის explicit იყოს
- rounding rules იყოს ცენტრალიზებული
- საბოლოო financial calculation backend-ზე მოხდეს

Frontend-ის მიერ გამოგზავნილი ფასი არასდროს არის საბოლოო source of truth.

---

# 20. Data Integrity

თუ პროექტს აქვს:

- orders
- payments
- inventory
- balances
- credits
- usage limits
- quotas
- financial records

კრიტიკული ოპერაციები უნდა იყოს transactional.

სადაც საჭიროა:

```text
validate
→ transaction
→ write
→ commit
```

თუ ოპერაციის ნაწილობრივ შესრულებას მონაცემთა გაფუჭება შეუძლია, უნდა არსებობდეს შესაბამისი atomic behavior.

### Concurrency

Transaction მარტო არ იცავს race condition-ისგან. სადაც ორმა პარალელურმა request-მა შეიძლება ერთი და იგივე რესურსი შეცვალოს (stock, balance, quota, unique slot), გამოიყენე შესაბამისი მექანიზმი:

- atomic conditional update (მაგ. `UPDATE ... SET stock = stock - 1 WHERE stock >= 1`)
- row-level lock (`SELECT ... FOR UPDATE`)
- optimistic locking (version column)
- unique constraint როგორც საბოლოო დაცვა

"Read → check in code → write" pattern კრიტიკულ data-ზე lock-ის ან conditional update-ის გარეშე არ გამოიყენო.

---

# 21. Idempotency

Idempotency საჭიროა იმ ოპერაციებზე, სადაც request-ის გამეორებამ შეიძლება duplicate side effect გამოიწვიოს.

მაგალითად:

- payment creation
- order creation
- webhook handling
- billing
- credit consumption
- external side effects

მაგრამ ყველა endpoint-ზე idempotency ავტომატურად არ დაამატო.

---

# 22. Authentication

Auth მხოლოდ მაშინ, როცა user identity რეალურად საჭიროა.

Default security principles:

- secure sessions
- httpOnly cookies where cookie-based auth is used
- Secure in production
- appropriate SameSite policy
- modern password hashing (მაგ. Argon2id ან bcrypt)
- rate limiting sensitive auth endpoints
- session expiry და logout, რომელიც session-ს რეალურად აუქმებს
- password reset / email verification tokens: ერთჯერადი, ვადიანი და DB-ში hashed სახით
- auth error messages არ უნდა ამჟღავნებდეს, არსებობს თუ არა account

Custom auth-ის თავიდან დაწერას, როცა managed provider ან framework-ის მზა solution საკმარისია, უპირატესობა არ ენიჭება.

Auth provider შეიძლება იყოს:

- application-managed auth
- Supabase Auth
- Clerk
- Auth0
- სხვა შესაბამისი provider

Provider-ის არჩევანი ჩაიწეროს `PROJECT.md`-ში.

---

# 23. Authorization

Authentication ≠ Authorization.

Protected operation backend-ზე უნდა ამოწმებდეს:

```text
Who is the user?
+
What are they allowed to do?
```

Frontend-ის UI hiding authorization-ს არ ცვლის.

Roles / permissions მხოლოდ საჭიროების მიხედვით.

---

# 24. Security Baseline

ყველა production project-ში მინიმუმი:

- input validation
- authorization
- secure secret handling
- environment variables
- SQL injection protection
- XSS protection
- correct CORS configuration
- rate limiting where appropriate
- safe production errors
- secure cookies where applicable
- dependency auditing/update process
- HTTPS in production
- least-privilege access
- CSRF protection, სადაც cookie-based auth და state-changing requests არსებობს
- security headers (მაგ. CSP, HSTS, X-Content-Type-Options) public web app-ში
- webhook signature verification ყველა incoming webhook-ზე
- SSRF-ისგან დაცვა, თუ server user-ის მიერ მოწოდებულ URL-ებს იძახებს

Secrets არ უნდა მოხვდეს:

- git-ში
- frontend bundle-ში
- public environment variables-ში
- logs-ში

---

# 25. Personal Data / Privacy

თუ project ინახავს personal data-ს:

- შეაგროვე მხოლოდ ის, რაც რეალურად საჭიროა (data minimization)
- ზუსტად იცოდე, სად ინახება personal data (DB, storage, logs, third-party providers)
- personal data არ უნდა მოხვდეს logs-ში, analytics-ში ან AI provider-თან საჭიროების გარეშე
- თუ მომხმარებლებს account აქვთ, დაგეგმე account/data deletion
- retention period განისაზღვროს იქ, სადაც კანონი ან business ამას მოითხოვს
- analytics/tracking cookies-ისთვის consent, სადაც ეს იურიდიულად საჭიროა (მაგ. GDPR)

იურიდიული მოთხოვნები (GDPR, ადგილობრივი კანონმდებლობა) ჩაიწეროს `PROJECT.md`-ში.

---

# 26. File Uploads

თუ პროექტს file upload აქვს:

- გამოიყენე object storage ან შესაბამისი storage
- validate type
- validate size
- sanitize / validate metadata
- authorization upload/download operation-ზე
- DB-ში შეინახე მხოლოდ საჭირო metadata

დიდი image-processing ან media pipeline მხოლოდ საჭიროების შემთხვევაში.

---

# 27. External Integrations

External providers უნდა იყვნენ მკაფიოდ გამოყოფილი application-ში.

მაგალითად:

```text
services/
├── payments/
├── email/
├── storage/
├── ai/
└── shipping/
```

მაგრამ პატარა project-ში შეიძლება საკმარისი იყოს:

```text
services/payment.py
```

არ გააკეთო თავიდანვე:

```text
BaseProvider
ProviderFactory
ProviderRegistry
AdapterFactory
```

სანამ ასეთი abstraction-ს რამდენიმე რეალური implementation არ სჭირდება.

### Reliability rules

ყველა external call-ს უნდა ჰქონდეს:

- explicit timeout
- გააზრებული error handling (provider-ის შეცდომამ მთელი application არ უნდა ჩამოაგდოს)
- retry with backoff მხოლოდ idempotent ან idempotency key-ით დაცულ ოპერაციებზე

Incoming webhooks:

- signature verification
- idempotent processing (ერთი და იგივე event შეიძლება რამდენჯერმე მოვიდეს)
- სწრაფი 2xx პასუხი, მძიმე დამუშავება — საჭიროებისას background-ში

---

# 28. AI / LLM Projects

AI project-ში default architecture არ უნდა იყოს complex agent platform.

საწყისი ფორმა:

```text
User
→ application
→ model
→ tool/data access if needed
→ response
```

შემდეგ, რეალური საჭიროების მიხედვით:

```text
workflow
→ structured output
→ tool calling
→ retrieval
→ state
→ memory
→ multi-step agent
→ queue/background processing
```

LangGraph, Agents SDK, vector DB, RAG და სხვა სპეციალიზებული tools ემატება მხოლოდ შესაბამისი requirement-ის შემთხვევაში.

### AI-specific rules

- API keys backend-ზე
- model output არ ითვლება trusted data-დ
- tool permissions მკაფიო უნდა იყოს
- user input არის untrusted input
- structured output გამოიყენე როცა downstream code-ს strict schema სჭირდება
- deterministic logic არ გადააბარო AI-ს, როცა ჩვეულებრივი code უკეთესია
- costly model calls შეამცირე სადაც შესაძლებელია
- prompt injection გაითვალისწინე: retrieved documents, web content და user input შეიძლება შეიცავდეს model-ის მანიპულირების მცდელობას
- side-effect მქონე tools (წაშლა, გაგზავნა, გადახდა) საჭიროებს მკაცრ authorization-ს და, სადაც რისკი მაღალია, human confirmation-ს
- model calls-ს ჰქონდეს timeout, error handling და fallback behavior
- usage/cost limits (per user ან per tenant), თუ ხარჯი შეიძლება უკონტროლოდ გაიზარდოს
- model name/version იყოს configuration-ში და არა მიმოფანტული კოდში
- prompts ინახებოდეს ორგანიზებულად და version control-ში
- მნიშვნელოვანი AI behavior-ისთვის შექმენი მცირე evaluation set (მაგალითები + მოსალოდნელი შედეგი), რომ prompt/model ცვლილებამ შეუმჩნეველი regression არ გამოიწვიოს

---

# 29. Search

Search განვითარდეს საჭიროების მიხედვით:

```text
simple DB query
↓
full-text search
↓
fuzzy search
↓
dedicated search
↓
semantic/vector search
```

Elasticsearch / OpenSearch / vector DB თავიდანვე არ დაამატო, თუ database search საკმარისია.

---

# 30. Background Jobs / Queues

Background worker / queue დაამატე როცა:

- task დიდხანს გრძელდება
- request-ს არ უნდა დაელოდოს
- retry საჭიროა
- scheduled processing არსებობს
- მაღალი მოცულობის event processing არსებობს

მარტივი synchronous operation queue-ში არ გადაიტანო მხოლოდ "scalable" არქიტექტურისთვის.

---

# 31. Realtime

Realtime მხოლოდ მაშინ, როცა რეალური realtime requirement არსებობს:

- chat
- collaboration
- live status
- live notifications
- live dashboards
- streaming

სხვა შემთხვევებში request/response default-ია.

---

# 32. Notifications

შესაძლო channels:

- email
- SMS
- push
- messaging platforms
- in-app

Notification failure არ უნდა აფუჭებდეს ძირითად transaction-ს, თუ notification თვითონ არ არის business operation-ის აუცილებელი ნაწილი.

მაგალითად:

```text
create business record
→ commit
→ notify
```

Queue გამოიყენე მხოლოდ მაშინ, როცა synchronous sending რეალურ პრობლემას ქმნის.

---

# 33. SEO

SEO მხოლოდ მაშინ არის architecture requirement, როცა public web pages discovery-სთვის მნიშვნელოვანია.

ასეთ პროექტებში საჭიროა საჭიროების მიხედვით:

- metadata
- canonical URLs
- sitemap
- robots
- Open Graph
- structured data
- semantic HTML
- index/noindex rules

Dashboard/internal application-ს SEO layer არ დაამატო checklist-ის გამო.

---

# 34. Accessibility

Public UI-სთვის default:

- semantic HTML
- keyboard navigation
- visible focus
- accessible labels
- accessible forms
- appropriate contrast
- alt text
- meaningful error messages
- screen-reader compatible interaction

Accessibility UI development-ის ნაწილია და არ უნდა დარჩეს მხოლოდ საბოლოო QA task-ად.

---

# 35. Localization

i18n მხოლოდ საჭიროების შემთხვევაში.

თუ multilingual project არის:

- translation structure
- locale-aware routing where useful
- date/number/currency formatting
- hreflang where relevant
- locale-specific content rules

ერთენოვან პროექტს i18n framework არ დაემატოს მხოლოდ მომავლის ვარაუდით.

---

# 36. Validation

Validation სწორ საზღვარზე უნდა იყოს.

### Frontend

UX validation:

- required fields
- format hints
- immediate feedback

### Backend

Security/business validation:

- schema validation
- authorization
- business rules
- database constraints

Frontend validation backend validation-ს ვერ ჩაანაცვლებს.

---

# 37. Errors

ყველა მნიშვნელოვან flow-ს უნდა ჰქონდეს შესაბამისი:

```text
loading
error
empty
success
```

Production API errors-ში არ გამოაჩინო:

- stack traces
- SQL/database internals
- secret values
- internal provider details

დეტალური ტექნიკური ინფორმაცია logs-ში უნდა დარჩეს.

---

# 38. Logging / Monitoring

### Simple project

საკმარისია:

- useful application logs
- deployment/platform logs
- basic platform monitoring

### Production / larger project

საჭიროების მიხედვით შეიძლება დაემატოს:

- structured logs
- error tracking
- metrics
- tracing
- uptime monitoring

Sentry, OpenTelemetry და მსგავსი tools მხოლოდ რეალური საჭიროებისას.

### Logging rules

- logs-ში არ მოხვდეს secrets, tokens, passwords და ზედმეტი personal data
- სადაც რამდენიმე service ან request flow არსებობს, გამოიყენე request/correlation ID
- log levels გამოიყენე გააზრებულად (production-ში debug noise არ უნდა იყოს)

---

# 39. Performance

Default optimization:

- efficient database queries
- appropriate indexes
- pagination
- optimized images/assets
- reasonable client bundle size
- avoiding unnecessary client JS
- avoiding duplicate requests
- sensible caching

Premature optimization არ კეთდება.

> **Measure first → identify bottleneck → optimize the actual bottleneck.**

---

# 40. Testing Strategy

Testing უნდა იყოს risk-based.

პრიორიტეტი:

1. critical business logic
2. data integrity
3. authentication/authorization
4. critical API behavior
5. critical user flows
6. integrations
7. UI details

### Test types

```text
Unit
→ pure logic

Integration
→ DB / API / services

E2E
→ critical user journeys
```

ყველა პატარა helper-ისთვის test suite საჭირო არ არის.

---

# 41. Deployment

### Simple

```text
single application
+
single deployment
```

### Standard web app

```text
frontend hosting
+
backend hosting
+
managed database
+
object storage when needed
```

### Complex

საჭიროების მიხედვით:

- worker
- queue
- cache
- CDN
- monitoring
- staging

Deployment architecture უნდა მიჰყვეს რეალურ workload-ს.

---

# 42. Environments

მინიმუმ:

```text
local
production
```

staging ემატება მაშინ, როცა project/team/deployment process ამას ამართლებს.

Environment-ებს უნდა ჰქონდეს შესაბამისი secrets/data boundaries.

Development data production-ში არ უნდა მოხვდეს.

Production data development/local გარემოში არ უნდა გადავიდეს anonymization-ის გარეშე, თუ ის personal ან sensitive data-ს შეიცავს.

---

# 43. Configuration

Configuration environment variables-ში.

ქონდეს:

```text
.env.example
```

რომელშიც არის variable names და safe examples — არა რეალური secrets.

Configuration იყოს centralised და predictable.

Required environment variables უნდა მოწმდებოდეს application-ის გაშვებისას (მაგ. Pydantic Settings ან schema validation), რომ missing config აშკარა error-ით გამოჩნდეს და არა runtime-ში შემთხვევით.

---

# 44. Backups / Recovery

თუ project ინახავს მნიშვნელოვან data-ს:

- production database-ს უნდა ჰქონდეს automatic backups (managed provider-ის backup-იც საკმარისია, თუ ჩართულია და შემოწმებულია)
- იცოდე, როგორ ხდება restore — backup, რომლის აღდგენაც არასდროს გამოცდილა, არასანდოა
- object storage-ში არსებული მნიშვნელოვანი files-ისთვისაც განისაზღვროს recovery გზა
- destructive operations-მდე (დიდი migration, bulk delete) დარწმუნდი, რომ ახალი backup არსებობს

---

# 45. Git / Change Management

- მცირე, focused commits
- მკაფიო commit messages
- `main` იყოს buildable
- unrelated changes არ შეერიოს task-ს
- დიდი refactor მხოლოდ რეალური მიზეზით

ერთი პატარა feature-ის გამო მთელი architecture არ გადააწყო.

ასევე:

- `.gitignore` თავიდანვე (`.env`, build outputs, dependencies, local files)
- lockfiles commit-დება
- generated files commit-დება მხოლოდ მაშინ, როცა ამის მიზეზი არსებობს

### CI

როცა project-ს repository და production deployment აქვს, მინიმალური CI ავტომატურად უშვებს:

```text
lint
typecheck
tests
build
```

რთული CI/CD pipeline მხოლოდ რეალური საჭიროებისას.

---

# 46. Documentation

ყველა project-ს უნდა ჰქონდეს იმდენი documentation, რამდენიც მის maintenance-ს სჭირდება.

მინიმუმ ჩვეულებრივ:

```text
README.md
PROJECT.md
.env.example
```

Decision log შეინახე `PROJECT.md`-ში.

ათობით დოკუმენტი მხოლოდ documentation-ის დასამატებლად არ შექმნა.

---

# 47. Seed / Demo Data

თუ local development-ს database სჭირდება:

- reproducible seed data
- production-safe seed process
- საჭიროების გარეშე mock API layer არ შექმნა

---

# 48. Reuse Strategy

Reusable code შექმენი მაშინ, როცა reuse რეალურად არსებობს.

Default:

```text
copy + adapt
```

და არა:

```text
shared package
mega-library
framework
```

Shared package განიხილება მაშინ, როცა რამდენიმე აქტიური project რეალურად იზიარებს ერთსა და იმავე stable implementation-ს.

ცალკე project-ის business logic ავტომატურად shared framework-ად არ გადაიქცეს.

---

# 49. Architecture Evolution

პროექტი განვითარდეს ეტაპობრივად.

### Stage 1 — Core

მხოლოდ MVP-ისთვის საჭირო functionality.

### Stage 2 — Production Hardening

საჭიროების მიხედვით:

- security review
- important tests
- logging
- monitoring
- backups
- performance review
- deployment hardening

### Stage 3 — Business Features

მხოლოდ `PROJECT.md`-ის მოთხოვნით.

### Stage 4 — Scale

მხოლოდ მაშინ, როცა მიმდინარე architecture-ს რეალური limitation აქვს ან გაზომილი bottleneck არსებობს.

---

# 50. Complexity Gate

ყოველი ახალი:

- dependency
- folder
- service
- abstraction
- database
- queue
- worker
- cache
- external provider
- framework
- architectural pattern

უნდა გაიაროს ეს კითხვები:

1. რა კონკრეტულ პრობლემას წყვეტს?
2. პრობლემა რეალურია და ახლანდელია?
3. არსებული architecture-ით შეიძლება მისი გადაჭრა?
4. რა complexity-ს ამატებს?
5. რა maintenance cost მოაქვს?
6. ხშირად გამოიყენება თუ ერთჯერადია?
7. არსებობს თუ არა უფრო მარტივი გადაწყვეტა?

თუ მარტივი გადაწყვეტა საკმარისია:

> **აირჩიე მარტივი გადაწყვეტა.**

---

# 51. Architecture Decision Log

მნიშვნელოვანი architectural decisions ჩაიწეროს `PROJECT.md`-ში.

მაგალითი:

```text
Decision:
Use PostgreSQL.

Reason:
The project needs relational data, constraints and transactions.

Alternatives considered:
MongoDB.

Why rejected:
No practical benefit for the current requirements.
```

Decision log არ უნდა გახდეს diary. მხოლოდ ისეთი გადაწყვეტილებები ჩაიწეროს, რომელთა შეცვლაც მოგვიანებით architecture-ს ან behavior-ს მნიშვნელოვნად შეეხება.

---

# 52. Claude's Build Process

Claude-მ project არ უნდა ააწყოს ქაოსურად.

## Step 1 — Understand

წაიკითხე:

- `PROJECT.md`
- existing code
- package configuration
- environment setup
- database schema
- existing documentation

არსებულ project-ში ჯერ გაიგე არსებული conventions და მხოლოდ შემდეგ შეცვალე კოდი.

## Step 2 — Classify

განსაზღვრე:

- project type
- complexity tier
- required stack
- required infrastructure
- major business/security/data risks

## Step 3 — Design

დაგეგმე მხოლოდ საჭირო:

- architecture
- folder structure
- data model
- APIs
- integrations
- deployment

## Step 4 — Implement

ააშენე მცირე, logically grouped ეტაპებით.

## Step 5 — Verify

მნიშვნელოვანი ცვლილებების შემდეგ გაუშვი project-ის შესაბამისი:

```text
lint
↓
typecheck
↓
tests
↓
build
↓
manual inspection
```

ზუსტი commands დამოკიდებულია stack-ზე.

## Step 6 — Simplify

დასრულებისას შეამოწმე:

- ზედმეტი abstraction ხომ არ დაემატა?
- duplicate logic ხომ არ არსებობს?
- უსარგებლო folders ხომ არ შეიქმნა?
- ზედმეტი dependency ხომ არ დაემატა?
- იგივე შედეგი უფრო მარტივად ხომ არ მიიღწევა?

## Step 7 — Document

განაახლე საჭიროების შემთხვევაში:

- `PROJECT.md`
- decision log
- README

---

# 53. Claude Must Adapt the Structure to the Project

ეს არის ამ standard-ის ერთ-ერთი მთავარი წესი.

Claude-მ **არ უნდა ჩასვას ერთი და იგივე folder structure ყველა project-ში**.

მაგალითად:

### Simple landing page

```text
src/
├── app/
├── components/
└── styles/
```

### Standard web application

```text
frontend/
backend/
```

### AI application

შეიძლება ჰქონდეს:

```text
app/
├── routes/
├── services/
├── ai/
├── tools/
└── data/
```

### Heavy processing project

შეიძლება გახდეს:

```text
app/
worker/
queue/
db/
```

### E-commerce

შეიძლება დასჭირდეს:

```text
catalog/
cart/
checkout/
orders/
inventory/
payments/
admin/
```

მაგრამ არცერთი ეს structure არ არის mandatory.

> **The project determines the structure. This document determines the principles used to choose it.**

---

# 54. Domain-Specific Architecture

ეს დოკუმენტი არის universal base.

თუ project type-ს თავისი მნიშვნელოვანი წესები აქვს, ისინი უნდა დაემატოს project-specific standard-ით ან `PROJECT.md`-ით.

### E-commerce

საჭიროების მიხედვით:

- pricing
- inventory
- orders
- delivery
- payments
- order snapshots
- stock atomicity
- checkout idempotency

### AI

საჭიროების მიხედვით:

- model providers
- prompts
- structured outputs
- tools
- retrieval
- agent workflows
- memory
- usage/cost controls

### SaaS

საჭიროების მიხედვით:

- tenants
- subscriptions
- billing
- usage limits
- roles/permissions

### Marketplace

საჭიროების მიხედვით:

- sellers
- commissions
- seller permissions
- payouts
- seller-specific order flows

### Content Platform

საჭიროების მიხედვით:

- CMS model
- drafts
- publishing workflow
- media
- SEO

**Domain-specific complexity მხოლოდ მაშინ აქტიურდება, როცა project ამას მოითხოვს.**

---

# 55. What Claude Must NOT Do by Default

Claude-მ მხოლოდ "best practice"-ის სახელით არ უნდა დაამატოს:

- microservices
- Kubernetes
- Redis
- Kafka
- RabbitMQ
- Elasticsearch / OpenSearch
- vector database
- event bus
- CQRS
- event sourcing
- repository pattern everywhere
- generic service factories
- generic adapters
- complex dependency injection
- global state libraries
- custom design systems
- multiple backend services
- separate admin application
- background worker system
- staging infrastructure
- complex caching
- advanced observability stack

თუ `PROJECT.md` ან გაზომილი რეალური requirement ამას არ ამართლებს.

---

# 56. Production Readiness vs Complexity

სიმარტივე არ ნიშნავს დაუცველობას ან უხარისხო კოდს.

> **Simple architecture, not careless architecture.**

მაგალითად, ასეთი architecture:

```text
Next.js
+
FastAPI
+
PostgreSQL
```

შეიძლება იყოს სრულად production-ready.

მაგრამ თუ project-ს აქვს payments, inventory, sensitive data ან authentication, შესაბამისი:

- validation
- transactions
- authorization
- idempotency
- security

უნდა არსებობდეს, თუნდაც architecture ძალიან მარტივი იყოს.

---

# 57. Final Output Expected from Claude Before Implementation

სანამ ძირითადი implementation დაიწყება, Claude-მ უნდა შეძლოს მოკლედ აჩვენოს:

1. Project type
2. Complexity tier
3. Chosen stack
4. High-level architecture
5. Proposed folder structure
6. Main data entities
7. Main integrations
8. Security-sensitive areas
9. Main testing strategy
10. რატომ არის არჩეული ეს complexity და რატომ არ არის საჭირო უფრო რთული architecture

ეს არ უნდა გახდეს დიდი report. მიზანია არქიტექტურული გადაწყვეტილების სწრაფი შემოწმება.

თუ სტრუქტურა აშკარად სწორია და მნიშვნელოვანი ambiguity არ არსებობს, implementation უნდა დაიწყოს ზედმეტი discussion-ის გარეშე.

---

# 58. Completion Rule

"Done" არ ნიშნავს:

> "კოდი დავწერე."

"Done" ნიშნავს:

- requirement implemented
- architecture consistent
- validation present where needed
- important tests pass
- build passes where applicable
- no known critical regression
- project state updated
- unnecessary complexity removed

"Done" უნდა იყოს გამყარებული verification evidence-ით.

---

# 59. Final Principles

> **Architecture follows requirements.**

> **Complexity is earned by real need.**

> **Use the simplest production-ready solution that works now.**

> **Build correctly where correctness matters.**

> **Do not solve imaginary future problems today.**

> **In an existing project, follow the existing conventions.**

> **Start simple. Measure. Evolve when the project proves it needs more.**

> **The project type, scale and requirements determine the structure; this document determines how Claude chooses that structure.**

---

# Appendix A — `PROJECT.md` Template

მინიმალური შაბლონი. არასაჭირო სექციები შეიძლება გამოტოვდეს.

```markdown
# Project Name

## Overview
რა პრობლემას წყვეტს და ვისთვის.

## Users
ვინ იყენებს, რა როლები არსებობს.

## Current Stage
მაგ. Stage 1 — MVP.

## Scope
### In scope (current stage)
- ...
### Out of scope (for now)
- ...

## Core Flows
მთავარი user/business flows.

## Business Rules
კრიტიკული წესები (pricing, limits, permissions და ა.შ.).

## Data
მთავარი entities და მათი კავშირები.

## Integrations
გარე providers და რისთვის გამოიყენება.

## Stack & Architecture
- Complexity tier:
- Frontend:
- Backend:
- Database:
- Storage:
- Auth:
- Hosting / deployment:

## Realistic Scale
მომხმარებლების / requests / data-ს რეალისტური მოცულობა.

## Security & Privacy
Sensitive data, legal requirements, auth/authorization notes.

## Constraints
Budget, deadlines, team, hosting limits, language/region.

## Decision Log
### YYYY-MM-DD — Decision title
- Decision:
- Reason:
- Alternatives considered:
- Why rejected:

## Open Questions
- ...
```

