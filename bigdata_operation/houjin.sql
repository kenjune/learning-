show databases;
use zhuyangjian;
show tables;
show create table users;
select * from kihon;
create table `kihon1` (
	`houjin_num` varchar(45) not null,
    `houjin_name` varchar(300) default null,
	`houjin_fugigana` varchar(300) default null,
    `houjin_english` varchar(300) default null,
    `postal_num` varchar(45) default null,
    `address` varchar(300) default null,
    `status` varchar(45) default null,
    `clousure_date` varchar(45) default null,
    `clousure_reason` varchar(45) default null,
    `daihyo_name` varchar(100) default null,
    `daihyo_role` varchar(100) default null,
    `capital` varchar(45) default null,
    `employee` varchar(45) default null,
    `employee_male` varchar(45) default null,
    `employee,female` varchar(45) default null,
    `goods_list` varchar(300) default null,
    `gaiyou` varchar(5000) default null,
    `website` varchar(300) default null,
    `setsuriritsu` varchar(45) default null,
	`foundation_year` varchar(45) default null,
    `last_updates` varchar(45) default null,
    `shikaku` varchar(45) default null,
    primary key (`houjin_num`)
    )engine=innodb default charset=utf8mb4;
show variables like 'local_infile';
set global local_infile = 1;
show variables like 'local_infile';

load data local infile 'D:\/kinhon.csv' replace
into table zhuyangjian.kihon1
fields
	 terminated by ','
     enclosed by '"'
lines
     terminated by '\r\n'
     ignore 1 rows
     ;
select * from zhuyangjian.kihon1
limit 5000;
select * from zhuyangjian.kihon1
where houjin_name like "%共済組合%"
limit 5000;
select * from zhuyangjian.kihon1
where houjin_name like "%大学";
show databases;
use zhuyangjian;
create table `prize` (
 `houjin_num` varchar(45) not null,
 `houjin_name_with_num` varchar(300) default null,
 `address_with_num` varchar(300) default null,
 `houjin_name` varchar(300) default null,
 `adress` varchar(300) default null,
 `date` varchar(100) default null,
 `prize_nmae` varchar(100) default null,
 `prize target` varchar(300) default null,
 `department` varchar(100) default null,
 `ministry` varchar(100) default null
 ) engine=innoDB default charset=utf8mb4;
 select * from zhuyangjian.prize;
 load data local infile 'D:\/Hyoshojoho.csv' replace
 into table zhuyangjian.prize
 fields
    terminated by ','
    enclosed by '"'
lines
    terminated by '\r\n'
    ignore 1 rows;
    select * from zhuyangjian.prize;
select * from zhuyangjian.kihon1
 inner join prize
     on kihon1.houjin_num=prize.houjin_num
where kihon1.houjin_name like "%大学";

select * from zhuyangjian.kihon1
 inner join prize 
   on kihon1.houjin_num=prize.houjin_num
where kihon1.houjin_name like "トヨタ%";

select * from prize; /*按大学都道府来统计日本政府各个部门颁发的奖项 */
select kihon1.houjin_name, left(kihon1.address, 3) as 都道府県  
,ministry, count(kihon1.houjin_num) as 表彰数
from zhuyangjian.kihon1  /*前面的内容是选择，as 是制作表头的与语法，count数数制作新的一列，from下半部分制作表格使用inner on生成新的部分表格*/
inner join prize
   on kihon1.houjin_num = prize.houjin_num
where kihon1.houjin_name like "%大学"
group by ministry, houjin_name, 都道府県
order by houjin_name, 表彰数 desc; 

/*统计都道府所有的企业 */
select left(address, 3) as 都道府県, count(houjin_num) as 企業数
   from zhuyangjian.kihon1
group by 都道府県 
order by 企業数 desc;

/*统计都道府所有倒闭的企业 */
select left(address, 3) as 都道府県, count(houjin_num) as 企業数
 from zhuyangjian.kihon1
where kihon1.status="閉鎖"
group by 都道府県
order by 企業数 desc;

use zhuyangjian;
select * from kihon1
where kihon1.status="閉鎖"
limit 10;

select left(kihon1.address, 3) as 都道府県, left(kihon1.clousure_date, 4) as 閉鎖年,
count(kihon1.houjin_name) as 企業数 from kihon1
where kihon1.status="閉鎖"
group by 都道府県, 閉鎖年
order by 都道府県, 閉鎖年 desc
;

select * from kihon1
limit 10;

select left(kihon1.foundation_year, 4) as 設立,
count(kihon1.houjin_name) as 企業数 from kihon1
group by  設立
order by  設立 desc;




 


                                               