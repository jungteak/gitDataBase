--계정 생성 
--create user c##scott identified by tiger
--default tablespace users 
--temporary tablespace temp 
--profile default;
--
--grant connect, resource to c##scott;
--GRANT UNLIMITED TABLESPACE TO c##scott;
--alter user c##scott account unlock;

--계정 생성
--create user c##계정명 identified by 비밀번호
--default tablespace users 
--temporary tablespace temp 
--profile default;

--비밀번호 변경
--alter user 계정명 identified by 수정 비번;

--계정과 함께 모든 데이터 삭제
--drop user 계정명 cascade;

--계정생성
create user c##orclstudy
IDENTIFIED by oracle;
--권한부여
grant CREATE SESSION to c##orclstudy;
grant resource, create table to c##orclstudy;
--권한제거 revoke
revoke resource, create table from c##orclstudy;

--롤 생성 >> 시스템 계정
create role c##rolestudy;

--롤에 권한 부여 할 때 >> 시스템 권한 : DBA에서 해야함 / 객체 권한 : 객체 소유한 계정에서 해야함

grant connect, resource, create view, create synonym
to c##rolestudy;
--롤 >> 계정 권한 부여
grant c##rolestudy to c##orclstudy; 

drop role c##rolestudy;

--강사님 필기
----계정 생성
--create user 계정명 identified by 계정 비번
--default tablespace users 
--temporary tablespace temp 
--profile default;
--grant connect, resource to 계정명;
--GRANT UNLIMITED TABLESPACE TO 계정명;
--alter user 계정명 account unlock;
--
----비번 수정
--alter user 계정명 identified by 수정 비번;
----계정 삭제
--drop user 계정명 cascade;

















