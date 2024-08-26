#!/bin/bash

#REFERENCE: https://stackoverflow.com/questions/26465496/rounding-up-float-point-numbers-bash
#REFERENCE: https://stackoverflow.com/questions/12722095/how-do-i-use-floating-point-arithmetic-in-bash
#REFERENCE: https://stackoverflow.com/questions/16436000/bash-run-command-for-certain-time
#REFERENCE: https://stackoverflow.com/questions/10823635/how-to-include-file-in-a-bash-shell-script
#REFERENCE: https://accu.org/journals/overload/21/114/floyd_1867/

. config.sh

arg="../philo/philo 4 410 200 200"
num="4"
die="410"
eat="200"
sleep="200"
even=$(echo "$(($num % 2))")
lunches="0"

make -C $philo_dir re

if [ ! -f $1 ]; then
    echo "executable not found!"
	exit 1
fi

echo $arg
echo $num
echo $die
echo $eat
echo $sleep

rm -rf $log_dir
mkdir -p $log_dir

round() {
  printf "%.${2}f" "${1}"
}

if [[ $even == "0" ]]; then
echo even
multi=$(bc -l <<< "($num - 2) / $num")
else
multi=$(bc -l <<< "($num - 1) / $num")
fi

sum_multi=$(bc -l <<< "$multi * $eat")
sum_total=$(bc -l <<< "$sum_multi + $eat + $sleep")
sum_total_rounded=$(printf "%.0f\n" "$sum_total" 2> /dev/null)

if [[ $die > $sum_total_rounded ]]; then
death=false
else
death=true
fi

if [[ $num == 1 ]]; then
death=true
fi

make -C $philo_dir fclean
mkdir -p $philo_dir/temp
mv $philo_dir/Makefile $philo_dir/temp/
cp $makesan $philo_dir
make -C $philo_dir all

timeout 10 $arg &> $thread_log
thread_exit_code=$(echo $?)

make -C $philo_dir fclean
rm -rf $philo_dir/$makesan
mv $philo_dir/temp/Makefile $philo_dir
rm -rf $philo_dir/temp

# timeout 10 $arg > $outfile
# exit_code=$(echo $?)
# timeout 10 $valgrind $arg > /dev/null
# mem_exit_code=$(echo $?)
echo $exit_code
echo $mem_exit_code
echo $thread_exit_code
echo $death
exit 0
