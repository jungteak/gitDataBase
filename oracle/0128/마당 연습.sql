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
select bookname,publisher from book where publisher in ('�½�����','���ѹ̵��');
--8
select publisher,bookname from book where bookname = '�౸�� ����';
--9
select publisher,bookname from book where bookname like '%�౸%';
--10
select bookname from book where bookname like ('_��%');
--11
select * from book where price >= 20000 and bookname like ('%�౸%');
--12
select * from book where publisher in ('�½�����','���ѹ̵��');
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
select c.name �̸�,sum(o.saleprice) ���Ǹž� 
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
where o.bookid = any(select bookid from book where publisher = '���ѹ̵��');
--29
select REPLACE(bookname,'�౸','��') from book where bookname like '%�౸%';
--30
select bookname,length(bookname) from book where publisher = '�½�����';
--31
select substr(name,1,1) ��,count(name) �ο� from customer group by substr(name,1,1);
--32
select to_char((orderdate+10),'yyyy-mm-dd dy') ����Ȯ���� from orders;
--33
select * from orders where orderdate = '2020/07/07';
--34
select name,nvl(phone,'����ó ����') from customer;