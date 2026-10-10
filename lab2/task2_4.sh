#!/bin/bash

file_count=0
total_bytes=0
total_lines=0

for file in ~/*.txt; do
	echo "$file"

	bytes=$(wc -c < "$file")
	lines=$(wc -l < "$file")

	file_count=$((file_count + 1))
	total_bytes=$((total_bytes + bytes))
	total_lines=$((total_lines + lines))
done

echo "Найдено файлов: $file_count"
echo "Суммарный размер: $total_bytes байт"
echo "Суммарное количество строк: $total_lines"
