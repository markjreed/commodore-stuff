#!/usr/bin/env bash
lo=
hi=
lines=("10 FOR A=%d TO %d"
       "20 : READ B"
       "30 : POKE A,B"
       "40 NEXT A"
       "50 SYS %d")
n=0
line=
for byte in $(od -An -v -t u1 "$@"); do
  if [[ -z $lo ]]; then
    lo=$byte
    continue
  fi
  if [[ -z $hi ]]; then
    hi=$byte
    (( start = lo + 256 * hi ))
    continue
  fi

  if [[ -z $line ]]; then 
    line="$(( (${#lines[@]} + 1)*10 )) DATA $byte"
  else
    line="$line,$byte"
    if (( ${#line} > 83 )); then
      lines+=("$line")
      line=
    fi
  fi
  (( n = n + 1 )) 
done
if [[ -n $line ]]; then
  lines+=("$line")
fi
(( end = start + n - 1 ))
lines[0]=$(printf "${lines[0]}" $start $end)
lines[4]=$(printf "${lines[4]}" $start)
printf '%s\n' "${lines[@]}"
