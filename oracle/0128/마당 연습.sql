--1
select bookname,price from book;
--2
select price,bookname from book;
--3
select bookid,bookname,publisher,price from book;
--4
select distinct publisher from book; 
--5
select bookname,price from book where price < 20000 order by price;
--6
select bookname,price from book where price between 10000 and 20000 order by price;
--7
select bookname,publisher from book where publisher in ('굿스포츠','대한미디어');
--8
select publisher,bookname from book where bookname = '축구의 역사';
--9
select publisher,bookname from book where bookname like '%축구%';
--10
select bookname from book where bookname like ('_구%');
--11
select * from book where price >= 20000 and bookname like ('%축구%');
--12
select * from book where publisher in ('굿스포츠','대한미디어');
--13
select * from book order by bookname;
--14
select * from book order by price,bookname;
--15
select * from book order by price desc , publisher;
--16
select sum(saleprice) from orders;
--17
select custid,count(custid) from orders o where o.saleprice >= 8000 group by custid having count(custid) > 1;
--18
select * from customer c natural join orders o;
--19
select * from customer c natural join orders o order by custid;
--20
select c.name,b.bookname,b.price from book b natural join customer c natural join orders o;
--21
select c.name 이름,sum(o.saleprice) 총판매액 
from book b natural join customer c natural join orders o 
group by c.name order by c.name;
--22
select c.name,listagg(b.bookname,',') 
from book b natural join customer c natural join orders o
group by c.name;
--23 = 22
--24
select c.name,b.bookname
from book b natural join customer c natural join orders o
where b.price = 20000;
--25
select c.name,o.saleprice
from customer c  full outer join orders o on o.custid = c.custid; 
--26
select max(price) from book;
--27
select name from customer 
where custid = any(select custid from orders);
--28
select name from customer c natural join orders o
where o.bookid = any(select bookid from book where publisher = '대한미디어');
--29
select REPLACE(bookname,'축구','농구') from book where bookname like '%축구%';
--30
select bookname,length(bookname) from book where publisher = '굿스포츠';
--31
select substr(name,1,1) 성,count(name) 인원 from customer group by substr(name,1,1);
--32
select to_char((orderdate+10),'yyyy-mm-dd dy') 구매확정일 from orders;
--33
select * from orders where orderdate = '2020/07/07';
--34
select name,nvl(phone,'연락처 없음') from customer;