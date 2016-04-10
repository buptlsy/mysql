--查看表的相关信息
show table status like `user`

--基准测试方法
--http_load

--循环请求给定的url列表
http_load -parallel 1 -seconds 10 urls.txt

--模拟同时5个并发用户在进行请求
http_load -parallel 5 -seconds 10 urls.txt

--每秒5次
http_load -rate 5 -seconds 10 urls.txt

--sysbench
--sysbench的cpu基准测试
sysbench --test=cpu --cpu-max-prime=2000 run

--sysbench的文件Io基准测试
sysbench --test=fileio --file-total-size=150G prepare
sysbench --test=fileio --file-total-size=150G --file-test-mode=rndw --init-rng=on --max-time=300 --max-requests=0 run
sysbench --test=fileio --file-total-size=150G cleanup

--sysbench的oltp基准测试.简单的事务处理系统的工作负载
sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=test --mysql-user=root prepare
sysbench --test=oltp --oltp-table-size=1000000 --mysql-db=test --mysql-user=root --max-time=60 --oltp-read-only=on --max-requests=0 --num-threads=8 run
--sysbench的内存、线程、互斥锁、顺序写
