--�û�����
select U_ID, U_NAME, U_SEX, d.DEPT_NAME as U_COLLEGENAME, U_MOBILE, U_EMAIL, U_SCORE, U_ENABLE from CBT_USER u inner join CBT_DEPT d on d.DEPT_ID = (select dept_parent from CBT_DEPT where dept_id = (select dept_parent from CBT_DEPT where dept_id = u.u_deptid)) where U_NAME like '%%' order by U_ID

--�û�������ҳ
select a2.* from (select a1.*, rownum rn from (
select U_ID, U_NAME, U_SEX, d.DEPT_NAME as U_COLLEGENAME, U_MOBILE, U_EMAIL, U_SCORE, U_ENABLE from CBT_USER u inner join CBT_DEPT d on d.DEPT_ID = (select dept_parent from CBT_DEPT where dept_id = (select dept_parent from CBT_DEPT where dept_id = u.u_deptid)) where U_NAME like '%%' order by U_ID
) a1) a2 where rn <= 10 and rn > 0

--�û�����
update CBT_USER set U_ENABLE = 'T' where U_ID = ''

--�û�����
update CBT_USER set U_ENABLE = 'F' where U_ID = ''

--�û��༭����
select U_ID, U_NAME, U_SEX, U_AGE, U_HOMETOWN, U_EMAIL, U_MOBILE, U_DEPTID, d1.dept_name as U_DEPT1, d2.dept_name as U_DEPT2, d3.dept_name as U_DEPT3, to_char(U_REGTIME, 'yyyy-mm-dd') as U_REGTIME, U_SCORE, U_ENABLE, U_NOTE from CBT_USER inner join CBT_DEPT d1 on d1.dept_id = substr(U_DEPTID, 0, 2) inner join CBT_DEPT d2 on d2.dept_id = substr(U_DEPTID, 0, 4) inner join CBT_DEPT d3 on d3.dept_id = U_DEPTID where U_ID = '10001'

--�û�ԺУ�������
update CBT_USER set U_DEPTID = '011201' where U_ID = '10001'

--�û��༭����
update CBT_USER set U_NAME = 'SCOTT', U_SEX = 'F', U_AGE = 18, U_EMAIL = '', U_MOBILE = '', U_HOMETOWN = '', U_NOTE = '' where U_ID = '10001'

--��ַ����
select ADR_ID, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID order by ADR_ID

--��ַ��ҳ����
select a2.* from (select a1.*, rownum rn from (
select ADR_ID, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID where 1=1 order by ADR_ID
) a1) a2 where rn <= 10 and rn > 0

--��ַ�༭����
select ADR_ID, ADR_UID, u.U_NAME as ADR_USERNAME, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE, ADR_NOTE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID 
inner join CBT_USER u on u.u_id = adr_uid where ADR_ID = '123123123123'

--�ֲ��б����
select CSL_ID, CSL_SRC, CSL_TYPE, CSL_TARGET, CSL_NOTE from CBT_CAROUSEL order by CSL_ID

--��ȡ�ֲ�ID
select max(CSL_ID) + 1 as NEWID from CBT_CAROUSEL

--�ֲ�����
insert into CBT_CAROUSEL values('4', '', 'B', 'images/123', '')

--�ֲ��޸�
update CBT_CAROUSEL c set c.csl_target = '', c.csl_type = 'A', c.csl_src = '123', c.csl_note = '' where c.csl_id = '4'

--���Ź����б����
select decode(n.ntc_type,'A','����','N','����') as ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author order by n.NTC_ADDTIME desc

--���Ź����б���أ������ҳ��
select a2.* from (select a1.*, rownum rn from (
select decode(n.ntc_type,'A','����','N','����') as ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author where 1=1 order by n.NTC_ADDTIME desc
) a1) a2 where rn <= 20 and rn > 10

--���Ź�������
select n.ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd hh24:mi:ss') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author where n.ntc_id = 'test1'

--���Ź������
INSERT INTO CBT_NOTICE VALUES ('id', 'tit', 'type', 'author', to_date('', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'content', 'note')

--���Ź����ȡ���
SELECT trim(TO_CHAR(CBS_NOTICE.NEXTVAL,'0000')) FROM DUAL

--���Ź���༭
UPDATE CBT_NOTICE n SET n.ntc_title = '', n.ntc_type = '', n.ntc_mdfperson = '', n.ntc_lastmdf = to_date('', 'yyyy-mm-dd hh24:mi:ss'), n.ntc_content = '', n.ntc_note = '' WHERE n.ntc_id = ''

--�����б���أ������ҳ��
select a2.* from (select a1.*, rownum rn from (
select n.HELP_ID, n.HELP_TITLE, n.HELP_CONTENT, u.U_NAME as HELP_AUTHOR, to_char(n.help_addtime, 'yyyy-mm-dd') as help_addtime from CBT_HELP n inner join CBT_USER u on u.u_id = n.help_author where 1=1 order by n.HELP_ADDTIME desc
) a1) a2 where rn <= 10 and rn > 0

--��������
select n.help_id, n.help_title, n.help_content, u.u_name as help_author, to_char(n.help_addtime, 'yyyy-mm-dd hh24:mi:ss') as help_addtime, n.help_note from CBT_HELP n inner join CBT_USER u on u.u_id = n.help_author where n.help_id = 'HELP201703140018'

--�����༭
update CBT_HELP h set HELP_TITLE = '12312', HELP_CONTENT = '3123', h.help_mdfperson = '9999', h.help_lastmdf = to_date('2017-03-14 16:35:00', 'yyyy-mm-dd hh24:mi:ss'), h.help_note = '123' WHERE h.help_id = 'HELP201703140014'

--������ȡ���
SELECT trim(TO_CHAR(CBS_HELP.NEXTVAL,'0000')) HELPID FROM DUAL

--�������
INSERT INTO CBT_HELP VALUES ('id', 'tit', 'author', to_date('', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'content', 'note')

--�������
select a2.* from (select a1.*, rownum rn from (
select n.ADV_ID, n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME from CBT_ADVICE n inner join CBT_USER u on u.u_id = n.adv_author where 1=1 order by n.ADV_ADDTIME desc
) a1) a2 where rn <= 10 and rn > 0

--��������
SELECT ad.ADV_ID, ad.adv_title, ad.adv_content, u.U_NAME as ADV_AUTHOR, to_char(ad.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME from CBT_ADVICE ad inner join CBT_USER u on u.u_id = ad.ADV_AUTHOR where ad.ADV_ID = ''

--���鼰���Ĳ鿴
select n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME, ADV_REPLY, u1.U_NAME as ADV_REAUTHOR, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME FROM CBT_ADVICE n INNER JOIN CBT_USER u ON u.U_ID = n.ADV_AUTHOR INNER JOIN CBT_USER u1 ON u1.u_id = n.ADV_REAUTHOR WHERE n.ADV_ID = ''
