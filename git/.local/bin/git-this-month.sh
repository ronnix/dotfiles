#!/bin/bash
set -o verbose
set -o errexit
START=$(python -c "from datetime import date ; print(date.today().replace(day=1))")
END=$(python -c "from datetime import date, timedelta ; from calendar import monthrange ; start = date.today().replace(day=1) ; print(start + timedelta(days=monthrange(start.year, start.month)[1] - 1))")
git log --all \
  --author="$(git config --get user.name)" \
  --after="$START" --before="$END" \
  --format="%cd %h %s" --date=iso | sort