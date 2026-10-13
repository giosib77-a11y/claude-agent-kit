# Claude Agent Kit — v2 (ავტონომიური რეჟიმით)

Claude Code-ის კონფიგურაცია, რომელიც პროექტებს `UNIVERSAL_PROJECT_STANDARD.md`-ის მიხედვით აწყობს — ხელით (`/next-task`) ან ავტონომიურად (`/build`).

## რა არის შიგნით

```text
user/                              → ~/.claude/  (Windows: C:\Users\<name>\.claude\)
├── CLAUDE.md                      უნივერსალური წესები
├── skills/
│   ├── project-standard/          სტანდარტი (Claude თავად ტვირთავს)
│   ├── new-project/               /new-project — მოთხოვნები, PROJECT.md, გეგმა
│   ├── next-task/                 /next-task  — ერთი task executor-ით (ხელით)
│   ├── finish-check/              /finish-check — ეტაპის შემოწმება, severity
│   └── build/                     /build — ★ ორკესტრატორი (ავტონომიური)
└── agents/
    ├── task-executor.md           ★ ერთი task-ის შემსრულებელი (სუფთა კონტექსტი)
    └── standard-reviewer.md       დამოუკიდებელი review

project-template/                  → თითოეული პროექტის root
├── CLAUDE.md
├── PROGRESS.md                    + Backlog, Run State
└── .claude/
    ├── settings.json              + permissions, SubagentStop hook
    └── hooks/verify.sh
```

## v1 → v2: რა შეიცვალა

| ფაილი | ცვლილება |
| --- | --- |
| `agents/task-executor.md` | **ახალი.** task-ს სუფთა კონტექსტში ასრულებს, აბრუნებს სტრუქტურირებულ report-ს. PROGRESS.md-ს და commit-ს არ ეხება |
| `skills/build/` | **ახალი.** ორკესტრატორი გაჩერების წესებით და fix-ის ლიმიტით |
| `skills/next-task/` | სამუშაოს executor-ს გადასცემს, report-ს გადაამოწმებს, nit-ებს Backlog-ში წერს |
| `skills/finish-check/` | severity-ის მკაცრი განსაზღვრება, Done = 0 critical + 0 should-fix, nit → Backlog, Accepted Risks, დაჯგუფება |
| `skills/new-project/` | `Accepted Risks` სექცია, permissions-ის სია, ახალი PROGRESS ფორმატი |
| `project-template/.claude/settings.json` | `acceptEdits` + git allow/deny + SubagentStop hook |
| `user/CLAUDE.md` | მხოლოდ ერთი ხაზი: Verification-ის წესი, რომელიც შენ უკვე ხელით შეცვალე `~/.claude/CLAUDE.md`-ში. გლობალურს **არ გადააწერო** |
| `project-standard`, `standard-reviewer`, `verify.sh`, `project-template/CLAUDE.md` | **უცვლელი** |

## 1. განახლება v1-დან

**გლობალური** — ჩააკოპირე და ჩაანაცვლე მხოლოდ ეს:

```text
user/agents/task-executor.md        → ~/.claude/agents/
user/skills/build/                  → ~/.claude/skills/
user/skills/next-task/SKILL.md      → ~/.claude/skills/next-task/
user/skills/finish-check/SKILL.md   → ~/.claude/skills/finish-check/
user/skills/new-project/SKILL.md    → ~/.claude/skills/new-project/
```

`~/.claude/CLAUDE.md` **არ გადააწერო** — შიგნით შენი ჩამატებებია, ხოლო kit-ის ვერსიაში ახალი არაფერია, რაც შენს გლობალურ ფაილს აკლია.

Claude Code განაახლე (`claude update`) — subagent-ებს და SubagentStop hook-ს ახალი ვერსია სჭირდება. შემოწმება: Claude Code-ში `/agents` → სიაში უნდა ჩანდეს `task-executor`.

**არსებული პროექტები** (ცალ-ცალკე, თითოეულში):
1. `.claude/settings.json` ჩაანაცვლე ახლით.
2. Claude-ს მიწერე:
   ```text
   PROGRESS.md-ს დაამატე სექციები "Backlog (needs user decision)" და "Run State" ახალი შაბლონის მიხედვით, PROJECT.md-ს — "Accepted Risks". შემომთავაზე ამ პროექტის უსაფრთხო ბრძანებები permissions.allow-ისთვის.
   ```
3. შემოთავაზებული ბრძანებები გადახედე და დაამატე `settings.json`-ის `allow`-ში.

## 2. ახალი პროექტი

```text
mkdir → git init → project-template-ის კოპირება → claude
/build <პროექტის აღწერა>      (ან /new-project <აღწერა>)
```

ორივე შემთხვევაში Claude ჯერ კითხვებს დაგისვამს, შექმნის PROJECT.md-ს და გეგმას და **გაჩერდება**. შემოწმების შემდეგ დაამატე შემოთავაზებული permissions, შეამოწმე `verify.sh`-ის `CHECKS` (setup task-ის შემდეგ executor თავად შეავსებს) და გააგრძელე.

## 3. ავტონომიური რეჟიმი — ეტაპობრივად

```text
ეტაპი 1:  /next-task  ×2-3     executor-ით ხარისხი იგივეა? report-ები სწორია?
ეტაპი 2:  /build 2             ორი task, მერე გაჩერება
ეტაპი 3:  /build 5             როცა ენდობი
ეტაპი 4:  /build stage         მხოლოდ სავალდებულო გაჩერებები
```

`/build` ყოველთვის ჩერდება: გეგმის შემდეგ, როცა რამე შენგან სჭირდება, destructive მოქმედებამდე, scope-ის ცვლილებისას, ერთი task-ის ორჯერ ჩავარდნისას, checkpoint-ზე და ეტაპის ბოლოს. ახალ ეტაპს და Backlog-ს **არასდროს** იწყებს თავისით.

ეტაპის ბოლოს: ერთი ავტომატური finish-check → მაქსიმუმ 2 გამოსწორების რაუნდი მიზნობრივი გადამოწმებით → გაჩერება. მეორე სრული `/finish-check` მხოლოდ შენი ბრძანებით.

შეწყვეტის (ლიმიტი, დახურვა) შემდეგ უბრალოდ ისევ `/build` — `PROGRESS.md`-ის `Run State`-იდან გააგრძელებს.

## 4. Permissions — რა ხდება

`settings.json`-ში `acceptEdits` ნიშნავს: ფაილების რედაქტირებას პროექტის შიგნით Claude ნებართვის გარეშე აკეთებს (git ყველაფერს იმახსოვრებს). Bash ბრძანებები, რომლებიც `allow`-ში არ არის, ისევ ნებართვას ითხოვს. `deny` კრძალავს push-ს, `rm -rf`-ს, publish-ს, `.env`-ის წაკითხვას.

**`bypassPermissions` / `--dangerously-skip-permissions` არ გამოიყენო.** deny წესები 100%-იანი გარანტია არ არის — მთავარი დაცვა git და გაჩერების წესებია.

## 5. Hooks

`verify.sh` ორჯერ ეშვება:
- **SubagentStop** (`task-executor`): executor ჩავარდნილი შემოწმებებით ვერ დაასრულებს — მისი ცვლილებები ჯერ არ არის commit-ში, hook სწორედ მათ ამოწმებს
- **Stop**: მთავარი სესიის დასრულებისას, თუ დაუ-commit-ებელი ცვლილებებია

## 6. სისტემის გაუმჯობესება

- Claude ერთსა და იმავე შეცდომას ორჯერ უშვებს → წესი პროექტის ან გლობალურ `CLAUDE.md`-ში
- task-ის შესრულების ხარისხი → `agents/task-executor.md`
- როდის ჩერდება ორკესტრატორი → `skills/build/SKILL.md`
- რას თვლის პრობლემად → `skills/finish-check/SKILL.md` (severity)
