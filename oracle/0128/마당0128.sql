--��� �ֹ��� �ֹ��� ����� �̸��� �ֹ��� å �̸� ���Ű����� ����ϼ���.
select c.name �̸�, b.bookname å�̸�, o.saleprice ���� 
from customer c , orders o, book b 
where c.custid = o.custid and o.bookid = b.bookid;
--inner join
select c.name �̸�, b.bookname å�̸�, o.saleprice ����
from customer c inner join orders o on c.custid = o.custid  
inner join book b on o.bookid = b.bookid ;
--inner join using  ���
select c.name �̸�, b.bookname å�̸�, o.saleprice ���� 
from orders o inner join book b using (bookid) inner join customer c using (custid); 
-- natural join
select c.name �̸�, b.bookname å�̸�, o.saleprice ����
from customer c natural join orders o natural join book b;

--outer ����
--��� ���� �ֹ������� ����ϼ��� (�̸� , ���ų�¥)
--���ų����� ���� ���� ����ϼ���
select c.name �̸�, o.orderdate ���ų�¥ from customer c full outer join orders o on c.custid = o.custid;

--















