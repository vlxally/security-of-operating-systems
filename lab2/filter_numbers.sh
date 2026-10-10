#!/bin/bash

processed=0

> even.txt
> odd.txt

for num in "$@"; do
    if ((num % 3 == 0)); then
	continue
    fi

    if ((num % 2 == 0)); then
	echo "$num" >> even.txt
    else
	echo "$num" >> odd.txt
    fi

    (( processed++ ))
done

echo "Всего обработано чисел: $processed"
