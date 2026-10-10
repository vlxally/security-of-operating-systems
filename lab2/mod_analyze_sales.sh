#!/bin/bash

usage() {
    cat <<EOF
Использование: $0 [ОПЦИИ} <csv-file>

ОпцииЖ
  -f csv Вывести данные в формате CSV
  -g Сгенерировать SQL-запросы для PostgreSQL
  -h Показать справку

EOF
     exit 0
}

output_format="text"
generate_sql=0

while getopts "f:gh" opt; do
    case $opt in
	f)
	    if [ "$OPTARG" = "csv" ]; then
		output_format="csv"
	    else
		echo "Ошибка: поддерживается только csv" >&2
		exit 1
	    fi
	    ;;
	g)
	    generate_sql=1
	    output_format="sql"
	    ;;
	h) usage ;;
	\?)
	    echo "Ошибка: неверная опция -$OPTARG" >&2
	    usage
	    ;;
	:)
	    echo "Ошибка: опция -$OPTARG требует аргумент" >&2
	    exit 1
	    ;;
    esac
done

shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
    echo "Ошибка: не указано имя CSV-файла" >&2
    exit 1
fi

CSV_FILE="$1"

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

if [ "$output_format" = "csv" ]; then
    echo "metric,value" | tee sales_report.csv
    echo "total_sales,$total_sum" | tee -a sales_report.csv
    echo "average_price,$avg_price" | tee -a sales_report.csv
    echo "max_sale,$max_price" | tee -a sales_report.csv
    echo "max_product,$max_product" | tee -a sales_report.csv
elif [ "$output_format" = "sql" ]; then
    {
	echo "CREATE TABLE IF NOT EXISTS sales_report (metric TEXT, value TEXT);"
	echo "INSERT INTO sales_report VALUES ('total_sales', '$total_sum');"
	echo "INSERT INTO sales_report VALUES ('average_price', '$avg_price');"
	echo "INSERT INTO sales_report VALUES ('max_sale', '$max_price');"
	echo "INSERT INTO sales_report VALUES ('max_product', '$max_product');"
    } | tee sales_report.sql
else
    {
	echo "Общая сумма продаж: $total_sum руб." | tee -a sales_report.txt
	echo "Средняя стоимость продажи: $avg_price руб." | tee -a sales_report.txt
	echo "Самая дорогая продажа: $max_price руб. $max_product" | tee -a sales_report.txt
    }
fi
