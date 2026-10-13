#!/usr/bin/env bash
# Stop hook: Claude-ის მიერ პასუხის დასრულებისას უშვებს შემოწმებებს.
# თუ რომელიმე ჩავარდა, Claude-ს უბრუნებს შეცდომას და აიძულებს გააგრძელოს მუშაობა.

# ---- შეავსე ამ პროექტის ბრძანებებით (ცარიელი სია = hook არაფერს აკეთებს) ----
CHECKS=(
  # "pnpm lint"
  # "pnpm typecheck"
  # "uv run ruff check ."
  # "uv run pytest -q"
)
# ------------------------------------------------------------------------------

INPUT=$(cat)

# უსასრულო ციკლისგან დაცვა: თუ Claude უკვე ამ hook-ის გამო აგრძელებს, აღარ დაბლოკო.
if echo "$INPUT" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

[ ${#CHECKS[@]} -eq 0 ] && exit 0

cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

# თუ git-ში ცვლილება არ არის (მაგ. მხოლოდ საუბარი იყო), შემოწმება არ გაეშვება.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  [ -z "$(git status --porcelain)" ] && exit 0
fi

FAILED=0
for cmd in "${CHECKS[@]}"; do
  OUTPUT=$(bash -c "$cmd" 2>&1)
  if [ $? -ne 0 ]; then
    FAILED=1
    echo "Verification failed: $cmd" >&2
    echo "$OUTPUT" | tail -40 >&2
    echo "" >&2
  fi
done

if [ $FAILED -ne 0 ]; then
  echo "Fix the failures above before finishing. If a failure is unrelated to your change, explain it to the user instead." >&2
  exit 2
fi
exit 0
