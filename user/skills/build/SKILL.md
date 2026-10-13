---
name: build
description: Autonomous orchestrator — plans the project if needed, then runs tasks one by one through the task-executor subagent, verifies, commits, runs the stage finish-check and a limited number of fix rounds, stopping at mandatory checkpoints.
disable-model-invocation: true
---

# Build (ორკესტრატორი)

შენ ხარ ორკესტრატორი. **პროდუქტის კოდს თავად არ წერ** — task-ებს `task-executor` subagent-ს გადასცემ. შენ ხარ `PROGRESS.md`-ის, `PROJECT.md`-ის Decision Log-ის და commit-ების ერთადერთი მფლობელი.

არგუმენტები: $ARGUMENTS
- რიცხვი N → გაჩერება ყოველი N task-ის შემდეგ (default: **2**)
- `stage` → გაჩერება მხოლოდ სავალდებულო წერტილებზე
- დანარჩენი ტექსტი → მომხმარებლის მითითებები/გადაწყვეტილებები

## პროცედურები (ფაილებად წაიკითხე და შეასრულე)
`~` = მომხმარებლის საქაღალდე (Windows-ზე `%USERPROFILE%`, მაგ. `C:\Users\<name>`).
- დაგეგმვა: `~/.claude/skills/new-project/SKILL.md`
- ერთი task: `~/.claude/skills/next-task/SKILL.md` — ნაბიჯები 2–6
- ეტაპის შემოწმება და severity-ის განსაზღვრება: `~/.claude/skills/finish-check/SKILL.md`

## ფაზა 0 — State
წაიკითხე `PROJECT.md`, `PROGRESS.md`, პროექტის `CLAUDE.md`. `PROGRESS.md`-ის `## Run State` სექციიდან აიღე მთვლელები (თუ არ არსებობს, შექმენი):

```markdown
## Run State
- Finish-check this stage: not run | done
- Fix rounds this stage: 0/2
- Failed attempts: —
```

თუ `Current Stage` შეიცვალა (მომხმარებელმა ახალი stage დაიწყო), `Run State` განულე: `not run`, `0/2`, `—`.

## ფაზა 1 — დაგეგმვა
თუ `PROJECT.md` ან `PROGRESS.md`-ის task-ები არ არსებობს: შეასრულე new-project-ის პროცედურა ($ARGUMENTS-ის ტექსტი = პროექტის აღწერა). **⏸ ყოველთვის გაჩერდი** და დაელოდე მომხმარებლის დადასტურებას. ამ გაშვებაში კოდზე არ გადახვიდე.

## ფაზა 2 — Task-ების ციკლი
სანამ მიმდინარე stage-ში დაუსრულებელი task არსებობს:
1. შეასრულე next-task-ის ნაბიჯები 2–6 (executor → შემოწმება → state → commit)
2. `failed` → `Failed attempts`-ში +1 ამ task-ზე; ერთი task-ის მეორე `failed` → ⏸
3. შეამოწმე გაჩერების წესები (ქვემოთ). თუ არცერთი — გააგრძელე

## ფაზა 3 — ეტაპის ბოლო
როცა მიმდინარე stage-ში დაუსრულებელი task აღარ არის:

1. თუ `Finish-check this stage: not run` → შეასრულე finish-check-ის პროცედურა, მთვლელში ჩაწერე `done`.
2. თუ 0 critical და 0 should-fix ღიაა → **Stage Done** → ⏸ საბოლოო report.
3. თუ ღიაა critical/should-fix და `Fix rounds < 2` → `Fix rounds` +1, შეასრულე მხოლოდ ეს task-ები (ფაზა 2-ის წესით), შემდეგ **მიზნობრივი გადამოწმება**: სრული lint/typecheck/tests/build + თითოეული გასწორებული პრობლემის ხელახლა გამეორება. სრული finish-check **თავიდან არ ეშვება**. დაბრუნდი მე-2 პუნქტზე.
4. თუ `Fix rounds = 2` და მაინც ღიაა critical/should-fix → ⏸ report.

მეორე სრული finish-check ავტომატურად არასდროს ეშვება — მხოლოდ მომხმარებლის `/finish-check`-ით.

## ⏸ გაჩერების წესები — ყოველთვის
1. ფაზა 1-ის შემდეგ (არქიტექტურა და roadmap)
2. executor-მა დააბრუნა `blocked`, ან აქვს `Questions for user`
3. საჭიროა რამე მომხმარებლისგან: ანგარიში, key, login, გადაწყვეტილება
4. destructive ან შეუქცევადი მოქმედება: მონაცემების წაშლა, production migration, deploy, push, გლობალური ინსტალაცია
5. `PROJECT.md`-ის მოთხოვნების, scope-ის ან არქიტექტურის შეცვლა
6. ერთი task მეორედ `failed`
7. ამ გაშვებაში შესრულდა N task (checkpoint; `stage` რეჟიმში არ მოქმედებს)
8. Stage Done, ან fix-ის ლიმიტი ამოიწურა
9. executor-ის report-ი და შენი გადამოწმება ერთმანეთს არ ემთხვევა

## არასდროს
- ახალი stage-ის დაწყება (ყოველთვის ⏸ — მომხმარებელი წყვეტს)
- Backlog-იდან task-ის აღება
- push, deploy, გლობალური გარემოს შეცვლა მომხმარებლის თანხმობის გარეშე
- `verify.sh`-ის `CHECKS`-იდან შემოწმების ამოღება, `--no-verify`, ტესტის წაშლა ან გამოტოვება იმისთვის, რომ "გაიაროს"
- `.claude/settings.json`-ის ან permissions-ის შეცვლა

## Report ყოველ ⏸-ზე (ქართულად, მოკლედ)
- **რატომ გავჩერდი** (წესის ნომერი)
- ამ გაშვებაში შესრულებული task-ები და commit-ები
- verification-ის მდგომარეობა და რა ვერ შემოწმდა
- მნიშვნელოვანი გადაწყვეტილებები
- **რა მჭირდება შენგან**
- გაგრძელება: `/build` (ან `/build N`)

ყოველი task ცალკე commit-ია და მთვლელები `PROGRESS.md`-შია, ამიტომ შეწყვეტის (ლიმიტი, დახურვა) შემდეგ `/build` იქიდან გააგრძელებს, სადაც გაჩერდა.
