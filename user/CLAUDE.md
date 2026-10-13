# Universal Working Rules

ეს წესები ყველა პროექტზე მოქმედებს. ტექნიკური სტანდარტი არის `project-standard` skill-ში (`UNIVERSAL_PROJECT_STANDARD.md`). არქიტექტურის, stack-ის, folder structure-ის, data model-ის ან ახალი dependency-ის შესახებ გადაწყვეტილების მიღებამდე გამოიყენე ის.

## პრიორიტეტები
1. ჩემი მიმდინარე მოთხოვნა
2. პროექტის `PROJECT.md` და პროექტის `CLAUDE.md`
3. `UNIVERSAL_PROJECT_STANDARD.md`
4. შენი ვარაუდები — მხოლოდ მაშინ, როცა ზემოთ პასუხი არ არის

თუ ჩემი მოთხოვნა ეწინააღმდეგება `PROJECT.md`-ს ან security / data integrity წესებს, ჯერ მითხარი და მერე შეასრულე.

## მთავარი პრინციპი
Build the simplest production-ready solution that solves the current requirements. Complexity must be justified by real requirements, not hypothetical future needs.

ყოველი დამატების წინ: რა რეალურ პრობლემას აგვარებს და შეიძლება თუ არა უფრო მარტივად?

## Project state
- `PROJECT.md` — მოთხოვნები, გადაწყვეტილებები, Decision Log
- `PROGRESS.md` — task-ების სია და სტატუსი; ახალ სესიაში აქედან გააგრძელე
- სესიის დასაწყისში, თუ ეს ფაილები არსებობს, ჯერ ისინი წაიკითხე
- მნიშვნელოვანი გადაწყვეტილების შემდეგ თავად განაახლე `PROJECT.md` (Decision Log)

## მუშაობის წესი
- არსებულ codebase-ში ჯერ შეისწავლე conventions და დაიცავი; ფართო refactor მხოლოდ რეალური მიზეზით
- სამუშაო მცირე, შემოწმებად ეტაპებად
- კითხვები: სტანდარტის "When to Ask vs. When to Assume"; მოთხოვნებს ნუ მოიგონებ; ვარაუდი აშკარად მონიშნე
- destructive ან შეუქცევადი მოქმედება (data წაშლა, production deploy, force push, migration production-ზე) მხოლოდ ჩემი დადასტურებით

## Verification
- ცვლილების შემდეგ გაუშვი პროექტის შესაბამისი lint, typecheck, tests, build
- ის, რაც ვერ შეამოწმე, პირდაპირ თქვი
- "მუშაობს", "გამოსწორდა", "აღარ არის საჭირო" თქვი მხოლოდ მაშინ, როცა გაშვებული ბრძანება ან ტესტი ზუსტად ამ კონკრეტულ მტკიცებას ამოწმებს. საერთო lint/tests-ის გავლა არ ნიშნავს, რომ თითოეული ცვლილება შემოწმდა.

## პასუხის ფორმატი
- ახსნა ქართულად; კოდი, comments, ცვლადები და commit messages ინგლისურად
- მნიშვნელოვანი გადაწყვეტილებები ახსენი მოკლედ; რთულ ვარიანტზე — რატომ არ კმარა მარტივი
- თუ ჩემი იდეა ზედმეტად რთული ან არასწორია, პირდაპირ მითხარი
