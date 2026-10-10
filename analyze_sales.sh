#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Ошибка: не указано имя CSV-файла" >&2
    exit 1
fi

CSV_FILE="$1"

if [ ! -f "$CSV_FILE" ]; then
    echo "Ошибка: файл '$CSV_FILE' не найден" >&2
    exit 1
fi

read -r total_sum avg_price max_price max_product <<< $(awk -F',' '
NR > 1 {
    price = $3 + 0
    total += price
    count++

    if (price > max) {
	max = price
	max_prod = $2
    }
}
END {
    if (count > 0) {
	avg = total / count
	printf "%.2f %.2f %.2f %s\n", total, avg, max, max_prod
    } else {
	print "0 0 0 N/A"
    }
}' "$CSV_FILE")

echo "Отчёт о продажах:" | tee sales_report.txt
echo "Общая сумма продаж: $total_sum руб." | tee -a sales_report.txt
echo "Средняя стоимость продажи: $avg_price руб." | tee -a sales_report.txt
echo "Самая дорогая продажа: $max_price руб. $max_product" | tee -a sales_report.txt
