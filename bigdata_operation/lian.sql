show databases;
use zhuyangjian;
show tables;
select * from kihon1
limit 10;
select * from prize
limit 10;
select * from kihon1
where houjin_name like "%共同組合%" /*粗错查找用like  就好了容易搞错*/
limit 10;
select houjin_name, postal_num from kihon1
where houjin_name like "%大学"
limit 10;
select * from kihon1
inner join prize
   on kihon1.houjin_num=prize.houjin_num
where kihon1.houjin_name like "%大学"
limit 100;

select * from

