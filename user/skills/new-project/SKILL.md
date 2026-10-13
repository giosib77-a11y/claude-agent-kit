---
name: new-project
description: Start a new project — clarify requirements, create PROJECT.md and PROGRESS.md, and propose an architecture for approval before any implementation.
disable-model-invocation: true
---

# New Project

მიზანი: implementation-მდე მოთხოვნები, არქიტექტურა და გეგმა ფაილებში დაფიქსირდეს და მე დავადასტურო.

ჩემი აღწერა: $ARGUMENTS

## ნაბიჯები

1. **სტანდარტი.** გამოიყენე `project-standard` skill: Requirements Before Architecture, Complexity Tiers, Default Technology Strategy, Appendix A.

2. **მოთხოვნები.** თუ არსებითი ინფორმაცია აკლია (ვინ იყენებს, MVP, მონაცემები, integrations, auth, ფული/sensitive data, hosting), დამისვი კითხვები **ერთად, ერთ შეტყობინებაში**. მხოლოდ ისეთი, რომლის პასუხიც არქიტექტურას ცვლის. დანარჩენზე აირჩიე მარტივი ვარიანტი და მონიშნე როგორც ვარაუდი. პასუხების მიღებამდე შემდეგ ნაბიჯზე არ გადახვიდე.

3. **`PROJECT.md`.** შექმენი Appendix A შაბლონით. Decision Log-ში ჩაწერე stack-ის და tier-ის არჩევა მიზეზით. ბოლოს დაამატე ცარიელი სექცია `## Accepted Risks` (რისკები, რომლებსაც შეგნებულად ვიღებთ და finish-check აღარ უნდა ახსენებდეს).

4. **არქიტექტურული შეჯამება** (მოკლედ, report-ის გარეშე):
   project type, complexity tier, stack, high-level architecture, folder structure, main entities, integrations, security-sensitive areas, testing strategy, რატომ არ არის საჭირო უფრო რთული ვარიანტი.

5. **`PROGRESS.md`.** დაყავი Stage 1 მცირე task-ებად. თითო task:
   - ერთ სესიაში დასრულებადი
   - შემოწმებადი შედეგით ("done when ...")
   - პირველი task ჩვეულებრივ: setup + lint/typecheck/test/build-ის მუშა კონფიგურაცია
   ფორმატი იხ. ქვემოთ.

6. **პროექტის `CLAUDE.md`.** შექმენი ან განაახლე: stack, ზუსტი ბრძანებები (dev, lint, typecheck, test, build, migrations), project-specific conventions. მოკლედ — 50 ხაზამდე.

7. **Permissions.** პროექტის `.claude/settings.json`-ის `permissions.allow`-ში შესათავაზებლად მოამზადე ამ stack-ის **უსაფრთხო** ბრძანებები (მაგ. `Bash(pnpm lint)`, `Bash(pnpm test *)`, `Bash(uv run *)`, `Bash(uv sync)`). არ შეიტანო: publish, deploy, გლობალური ინსტალაცია, ბაზაზე migration არა-ლოკალურად. ფაილი თავად არ შეცვალო — სია აჩვენე გეგმაში, მომხმარებელი დაამატებს ან დაგავალებს.

8. **გაჩერდი.** კოდი ჯერ არ დაწერო. მკითხე, ვადასტურებ თუ არა გეგმას. შემდეგ ნაბიჯად მიუთითე `/next-task` (ხელით) ან `/build` (ავტონომიურად).

## PROGRESS.md ფორმატი

```markdown
# Progress

## Current Stage
Stage 1 — MVP

## Tasks
- [ ] 1. Title — done when: ...
- [ ] 2. Title — done when: ...

## Backlog (needs user decision)

## Run State
- Finish-check this stage: not run
- Fix rounds this stage: 0/2
- Failed attempts: —

## Last Session
- Date:
- Done:
- Verification:
- Known issues / blockers:
- Next:
```
