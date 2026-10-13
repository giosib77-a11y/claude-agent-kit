---
name: project-standard
description: Universal technical standard for software projects (architecture, stack choice, folder structure, database, security, AI apps, testing, deployment). Use this skill whenever you plan or change architecture, choose a technology or dependency, design a data model or API, create folders/modules/services, set up a new project, or check whether work is "done" — even if the user does not mention the standard.
---

# Project Standard

სრული სტანდარტი: `references/UNIVERSAL_PROJECT_STANDARD.md`.

ფაილი დიდია — წაიკითხე მხოლოდ ამოცანისთვის საჭირო სექციები (`grep -n "^# "` გიჩვენებს სარჩევს).

## რომელი სექციები როდის

| ამოცანა | სექციები |
| --- | --- |
| ახალი პროექტი | Requirements Before Architecture, Complexity Tiers, Architecture Selection Rule, Default Technology Strategy, Final Output Expected from Claude Before Implementation, Appendix A |
| არსებული პროექტი | Existing Projects, When to Ask vs. When to Assume |
| ახალი dependency / service / folder | Technology Selection Rules, Folder Rules, Complexity Gate, What Claude Must NOT Do by Default |
| Database / data | Database Rules, Money / Financial Data, Data Integrity, Idempotency |
| Auth / security | Authentication, Authorization, Security Baseline, Personal Data / Privacy |
| Integrations / AI | External Integrations, AI / LLM Projects |
| დასრულება | Claude's Build Process, Completion Rule |

## უცვლელი წესები
- არქიტექტურა მოთხოვნებიდან; complexity მხოლოდ რეალური საჭიროებით
- `PROJECT.md` სტანდარტის default-ებს ცვლის
- არსებულ პროექტში მისი conventions სტანდარტის default-ებზე მაღლა დგას
