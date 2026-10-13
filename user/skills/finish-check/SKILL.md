---
name: finish-check
description: ამოწმებს, ნამდვილად დასრულებულია თუ არა მიმდინარე stage ან პროექტი სტანდარტის Completion Rule-ის მიხედვით, პრობლემებს სიმძიმით ალაგებს და აკლებულს PROGRESS.md-ში წერს.
disable-model-invocation: true
---

# Finish Check

შეამოწმე, ნამდვილად დასრულებულია თუ არა მიმდინარე stage (ან აქ მითითებული ნაწილი: $ARGUMENTS). ეს პროცედურა `/build`-საც იყენებს.

## სიმძიმის განსაზღვრება (მკაცრად)
- **critical** — მონაცემების დაკარგვა ან გაფუჭება, უსაფრთხოების პრობლემა, tenant-ების იზოლაციის დარღვევა, ფული/მარაგი არასწორად ითვლება, მთავარი ფუნქცია არ მუშაობს
- **should-fix** — `PROJECT.md`-ის წესი ირღვევა, ან ჩვეულებრივ გამოყენებაში ჩნდება შეცდომა ან არასწორი შედეგი
- **nit** — ყველაფერი დანარჩენი: ტექსტი, იშვიათი edge case, სილამაზე, "კარგი იქნებოდა"

**Done** = 0 critical და 0 should-fix. nit-ები Done-ს არ აბრკოლებს.

## ნაბიჯები

1. **კონტექსტი.** წაიკითხე `PROJECT.md` (მათ შორის `Accepted Risks`), `PROGRESS.md` (მათ შორის Backlog) და `project-standard` skill-ის სექციები: Completion Rule, Claude's Build Process (Step 6 — Simplify), Production Readiness vs Complexity.

2. **სრული verification:** lint, typecheck, tests, build.

3. **საკუთარი შემოწმება:**
   - stage-ის ყველა task შესრულებულია და შედეგი `PROJECT.md`-ის მოთხოვნებს შეესაბამება
   - security-sensitive ადგილები (auth, authorization, payments, uploads, secrets, personal data) — Security Baseline-ის მიხედვით
   - data integrity: transactions, constraints, idempotency, concurrency — სადაც საჭიროა
   - ოპერაცია, რომელიც რამდენიმე ჩანაწერს ცვლის (მაგ. სტატუსი + მარაგი), ერთ transaction-შია, ან ნაწილობრივ ჩავარდნაზე მონაცემები შეთანხმებული რჩება
   - ყველა გარე გამოძახებას (AI, API, HTTP) აქვს timeout და შეცდომის დამუშავება
   - შეცდომის გზები: არასწორი input, გარე შეცდომები, შეწყვეტა — ხელით გაშვებითაც, რეალურ პირობებში
   - სისტემა მომხმარებლის მაგივრად ჩუმად არაფერს ირჩევს: სიიდან პირველი ელემენტის აღება ან default-ის ჩასმა, როცა რამდენიმე ვარიანტი შეიძლება არსებობდეს
   - კონფიგურაციის შეცდომაზე დაცვა არ ითიშება (production fail-closed): აკლებული ან არასწორი env ცვლადი ხმამაღლა ჩავარდება და ჩუმად არ გათიშავს დაცვას
   - loading / error / empty states მთავარ flows-ში (თუ UI არის)
   - `.env.example` სრულია; secrets არ არის კოდში, git-ში, ლოგებში ან ტესტების გამოტანაში
   - README-ში გაშვების ინსტრუქცია სწორია
   - ზედმეტი complexity: abstractions, dependencies, folders, dead code

4. **დამოუკიდებელი review.** გამოიძახე `standard-reviewer` subagent. გადაეცი: რა შეამოწმოს (მიმდინარე stage-ის ცვლილებები ან მთელი პროექტი), და რომ `PROJECT.md`-ის Accepted Risks და `PROGRESS.md`-ის Backlog გაითვალისწინოს.

5. **reviewer-ის მიგნებების გადამოწმება.** reviewer-ის სიას ბრმად არ ენდო: თითოეული critical/should-fix ახლანდელ კოდში თავად გადაამოწმე. თუ არ დადასტურდა — ჩაწერე, რატომ (მაგ. კოდი უკვე სხვაგვარად მუშაობს, ან პროექტის მასშტაბისთვის ზედმეტია).

6. **დალაგება:**
   - `Accepted Risks`-ში და Backlog-ში უკვე ჩაწერილი არ გაიმეორო
   - critical/should-fix მტკიცებულებით დაადასტურე (გაიმეორე), სადაც შესაძლებელია; დაუდასტურებელი ცალკე მონიშნე
   - ჩაწერამდე დააჯგუფე: თუ რამდენიმე პრობლემას ერთი მიზეზი აქვს ან ერთი და იგივე ადგილზე სწორდება, ჩაწერე ერთ task-ად, ხოლო ცალკეული სიმპტომები ჩამოწერე "done when" პირობებად. განსხვავებული პრობლემები დატოვე ცალკე task-ებად.
   - critical/should-fix → `PROGRESS.md`-ის მიმდინარე stage-ის task-ებში, severity-ის მითითებით
   - nit → `PROGRESS.md`-ის `Backlog (needs user decision)`-ში
   - რასაც მისაღებ რისკად თვლი → "Proposed accepted risks" (მხოლოდ report-ში; `PROJECT.md`-ში მომხმარებლის თანხმობით ემატება)
   - `PROGRESS.md`-ის ცვლილება დაა-commit-ე

7. **Report:**
   - ✅ რა არის რიგზე (რა სფეროები შემოწმდა)
   - ❌ task-ები (severity-ით) და Backlog-ში გადატანილი nit-ები
   - ❓ შესამოწმებელი — ეჭვები, რომლებიც ვერ დადასტურდა
   - 🚫 reviewer-ის მიგნებები, რომლებიც არ დადასტურდა, და რატომ
   - Proposed accepted risks
   - დასკვნა: **Done / Not done** (ზემოთ მოცემული განსაზღვრებით)

ამ skill-ში კოდი არ გაასწორო — მხოლოდ შეამოწმე და ჩაწერე. გასწორება `/next-task`-ით ან `/build`-ით.
