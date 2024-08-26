philo_finish_exit_code=0
philo_dir=../philo
include_inc=-I../philo/inc
log_dir=logs
outfile=temp.txt
mem_log=logs/mem.log
thread_log=logs/thread.log
makesan=Makefile
valgrind="valgrind --leak-check=full --show-leak-kinds=all --error-exitcode=42 --log-file=$mem_log"