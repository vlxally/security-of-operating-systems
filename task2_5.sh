#!/bin/bash

all_hashes=$(md5sum * 2>/dev/null | sort)
duplicate_hashes=$(echo "$all_hashes" | cut -d' ' -f1 | uniq -d)

if [ -z "$duplicate_hashes" ]; then
    echo "Дубликатов не найдено!"
    exit 0
fi

echo "$duplicate_hashes" | while read -r hash; do
    files=$(echo "$all_hashes" | grep "^$hash ")
    count=$(echo "$files" | wc -l)

    echo "Количество дубликатов: $count"
    echo "$files" | awk '{print $2}'
done
