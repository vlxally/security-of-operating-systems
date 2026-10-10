#!/bin/bash

usage() {
    cat <<EOF
Использование: $0 [ОПЦИИ] ЧИСЛО1 ЧИСЛО2 ...

Опции выбора операции:
  -a Сложение (+)
  -s Вычитание (-)
  -m Умножение (*)
  -d Деление (/)
  -p Возведение в степень (^)

Другие опции:
  -h  Показать справку
  -v  Включить подробный вывод
  -o <file>  Записать результат в файл

EOF
    exit 0
}

operation=""
output_file=""
flag=0

while getopts "hvo:asmdp" opt; do
    case $opt in
	h) usage ;;
	v) flag=1 ;;
	o) output_file="$OPTARG" ;;
	a) operation="+" ;;
	s) operation="-" ;;
	m) operation="*" ;;
	d) operation="/" ;;
	p) operation="^" ;;
	\?)
	    echo "Ошибка: неверная опция -$OPTARG" >&2
	    usage
	    ;;
	:)
	    echo "Ошибка: опция $OPTARG требует аргумент" >&2
	    exit 1
	    ;;
    esac
done

shift $((OPTIND - 1))
numbers=("$@")

if [ -z "$operation" ]; then
    echo "Ошибка: не выбрана операция" >&2
    exit 1
fi

if [ ${#numbers[@]} -eq 0 ]; then
    echo "Ошибка: не переданы числа" >&2
    exit 1
fi

if [ "$operation" = "/" ] && [ ${#numbers[@]} -lt 2 ]; then
    echo "Ошибка: для деления нужно минимум 2 числа" >&2
    exit 1
fi

result="${numbers[0]}"
expression="${numbers[0]}"

for (( i=1; i<${#numbers[@]}; i++ )); do
    num="${numbers[$i]}"

    if [ "$operation" = "/" ] && [ "$num" = "0" ]; then
	echo "Ошибка: деление на ноль" >&2
	exit 1
    fi

    expression="$expression $operation $num"

    result=$(echo "$expression" | bc -l)

    if [ $flag -eq 1 ]; then
	echo "Шаг $i: $expression = $result"
    fi
done

final_output="Результат ($operation): $result"

if [ -n "$output_file" ]; then
    echo "$final_output" > "$output_file"
    echo "Результат записан в файл: $output_file"
    echo "$final_output"
else
    echo "$final_output"
fi
