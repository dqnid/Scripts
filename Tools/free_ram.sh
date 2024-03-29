#!/bin/bash
# Display the top applications of memory usage
# http://www.cyberciti.biz/faq/linux-check-memory-usage/#comment-51021
 
while read command percent rss; do 
  if [[ "${command}" != "COMMAND" ]]; then 
    rss="$(bc <<< "scale=2;${rss}/1024")" 
  fi
  printf " %-26s%-8s%s\n" "${command}" "${percent}" "${rss} MB" \
  | sed 's/COMMAND/PROGRAM/' | sed 's/RSS MB/#MEM/'
done < <(ps -A --sort -rss -o comm,pmem,rss | head -n 20)
