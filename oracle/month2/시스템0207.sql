--���� ���� 
--create user c##scott identified by tiger
--default tablespace users 
--temporary tablespace temp 
--profile default;
--
--grant connect, resource to c##scott;
--GRANT UNLIMITED TABLESPACE TO c##scott;
--alter user c##scott account unlock;

--���� ����
--create user c##������ identified by ��й�ȣ
--default tablespace users 
--temporary tablespace temp 
--profile default;

--��й�ȣ ����
--alter user ������ identified by ���� ���;

--������ �Բ� ��� ������ ����
--drop user ������ cascade;

--��������
create user c##orclstudy
IDENTIFIED by oracle;
--���Ѻο�
grant CREATE SESSION to c##orclstudy;
grant resource, create table to c##orclstudy;
--�������� revoke
revoke resource, create table from c##orclstudy;

--�� ���� >> �ý��� ����
create role c##rolestudy;

--�ѿ� ���� �ο� �� �� >> �ý��� ���� : DBA���� �ؾ��� / ��ü ���� : ��ü ������ �������� �ؾ���

grant connect, resource, create view, create synonym
to c##rolestudy;
--�� >> ���� ���� �ο�
grant c##rolestudy to c##orclstudy; 

drop role c##rolestudy;

--����� �ʱ�
----���� ����
--create user ������ identified by ���� ���
--default tablespace users 
--temporary tablespace temp 
--profile default;
--grant connect, resource to ������;
--GRANT UNLIMITED TABLESPACE TO ������;
--alter user ������ account unlock;
--
----��� ����
--alter user ������ identified by ���� ���;
----���� ����
--drop user ������ cascade;

















