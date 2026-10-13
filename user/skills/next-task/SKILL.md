---
name: next-task
description: Take the next unfinished task from PROGRESS.md, delegate it to the task-executor subagent, check its report, update project state and commit.
disable-model-invocation: true
---

# Next Task

ერთი სრული ციკლი ერთ task-ზე. დამატებითი მითითება ან გადაწყვეტილება (არასავალდებულო): $ARGUMENTS

ეს პროცედურა `/build`-საც იყენებს (ნაბიჯები 2–6).

## ნაბიჯები

1. **State.** წაიკითხე `PROJECT.md`, `PROGRESS.md` და პროექტის `CLAUDE.md`. თუ `PROGRESS.md` არ არსებობს ან task-ები ცარიელია, გაჩერდი და შემომთავაზე `/new-project` (არსებული პროექტისთვის — `PROJECT.md`/`PROGRESS.md`-ის შექმნა codebase-ის შესწავლის შემდეგ).

2. **Task.** აიღე მიმდინარე stage-ის პირველი დაუსრულებელი task. **მხოლოდ ერთი.** თუ ზედმეტად დიდია, ჯერ დაყავი `PROGRESS.md`-ში და აიღე პირველი ნაწილი. Backlog-იდან task არასდროს აიღო.

3. **Delegate.** გადაეცი task `task-executor` subagent-ს: task-ის ტექსტი, "done when" პირობები, მომხმარებლის შესაბამისი გადაწყვეტილებები ($ARGUMENTS-იდან ან `PROJECT.md`-იდან). თუ `task-executor` ხელმისაწვდომი არ არის, შეასრულე თავად, `~/.claude/agents/task-executor.md`-ის წესებით.

4. **Check.** executor-ის report ბრმად არ მიიღო:
   - `blocked` ან `failed` → არაფერი დაა-commit-ო; მომხმარებელს აჩვენე მიზეზი/კითხვები და გაჩერდი
   - `done` → თავად გაუშვი პროექტის სწრაფი შემოწმებები (lint, typecheck, tests) და `git status`/`git diff --stat`-ით დარწმუნდი, რომ შეცვლილი ფაილები report-ს ემთხვევა და task-ის გარეთ არაფერი შეცვლილა. თუ რამე არ ემთხვევა — გაჩერდი და აჩვენე.

5. **Update state.**
   - `PROGRESS.md`: task მონიშნე `[x]`, შეავსე "Last Session"
   - `New tasks discovered`: critical/should-fix → მიმდინარე stage-ის task-ებში (ერთი მიზეზი ან ერთი ადგილი → ერთი task); nit და stage-ის გარეთ არსებული იდეები → `Backlog (needs user decision)`
   - `Decisions`: მნიშვნელოვანი → `PROJECT.md`-ის Decision Log

6. **Commit.** focused commit, მკაფიო message ინგლისურად. push მხოლოდ მომხმარებლის თხოვნით.

7. **Report** (მოკლედ, ქართულად): რა გაკეთდა, verification (executor-ის + შენი გადამოწმება), რა ვერ შემოწმდა, გადაწყვეტილებები, შემდეგი task. შემდეგ task-ზე თავად არ გადახვიდე.
