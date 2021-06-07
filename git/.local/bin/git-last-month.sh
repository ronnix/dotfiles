#!/bin/bash
set -o errexit
START=$(python -c "from datetime import date, timedelta ; print((date.today().replace(day=1) - timedelta(days=1)).replace(day=1))")
END=$(python -c "from datetime import date, timedelta ; print(date.today().replace(day=1) - timedelta(days=1))")
git log --all \
  --author="$(git config --get user.name)" \
  --after="$START" --before="$END" \
  --format="%cd %h %s" --date=iso | sort
