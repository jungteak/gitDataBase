--모든 주문의 주문한 사람의 이름과 주문한 책 이름 구매가격을 출력하세요.
select c.name 이름, b.bookname 책이름, o.saleprice 가격 
from customer c , orders o, book b 
where c.custid = o.custid and o.bookid = b.bookid;
--inner join
select c.name 이름, b.bookname 책이름, o.saleprice 가격
from customer c inner join orders o on c.custid = o.custid  
inner join book b on o.bookid = b.bookid ;
--inner join using  사용
select c.name 이름, b.bookname 책이름, o.saleprice 가격 
from orders o inner join book b using (bookid) inner join customer c using (custid); 
-- natural join
select c.name 이름, b.bookname 책이름, o.saleprice 가격
from customer c natural join orders o natural join book b;

--outer 조인
--모든 고객의 주문내역을 출력하세요 (이름 , 구매날짜)
--구매내역이 없는 고객도 출력하세요
select c.name 이름, o.orderdate 구매날짜 from customer c full outer join orders o on c.custid = o.custid;

--















