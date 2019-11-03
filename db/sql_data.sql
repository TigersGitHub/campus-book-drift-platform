--用户搜索
select U_ID, U_NAME, U_SEX, d.DEPT_NAME as U_COLLEGENAME, U_MOBILE, U_EMAIL, U_SCORE, U_ENABLE from CBT_USER u inner join CBT_DEPT d on d.DEPT_ID = (select dept_parent from CBT_DEPT where dept_id = (select dept_parent from CBT_DEPT where dept_id = u.u_deptid)) where U_NAME like '%%' order by U_ID

--用户搜索分页
select a2.* from (select a1.*, rownum rn from (
select U_ID, U_NAME, U_SEX, d.DEPT_NAME as U_COLLEGENAME, U_MOBILE, U_EMAIL, U_SCORE, U_ENABLE from CBT_USER u inner join CBT_DEPT d on d.DEPT_ID = (select dept_parent from CBT_DEPT where dept_id = (select dept_parent from CBT_DEPT where dept_id = u.u_deptid)) where U_NAME like '%%' order by U_ID
) a1) a2 where rn <= 10 and rn > 0

--用户启用
update CBT_USER set U_ENABLE = 'T' where U_ID = ''

--用户禁用
update CBT_USER set U_ENABLE = 'F' where U_ID = ''

--用户编辑加载
select U_ID, U_NAME, U_SEX, U_AGE, U_HOMETOWN, U_EMAIL, U_MOBILE, U_DEPTID, d1.dept_name as U_DEPT1, d2.dept_name as U_DEPT2, d3.dept_name as U_DEPT3, to_char(U_REGTIME, 'yyyy-mm-dd') as U_REGTIME, U_SCORE, U_ENABLE, U_NOTE from CBT_USER inner join CBT_DEPT d1 on d1.dept_id = substr(U_DEPTID, 0, 2) inner join CBT_DEPT d2 on d2.dept_id = substr(U_DEPTID, 0, 4) inner join CBT_DEPT d3 on d3.dept_id = U_DEPTID where U_ID = '10001'

--用户院校变更保存
update CBT_USER set U_DEPTID = '011201' where U_ID = '10001'

--用户编辑保存
update CBT_USER set U_NAME = 'SCOTT', U_SEX = 'F', U_AGE = 18, U_EMAIL = '', U_MOBILE = '', U_HOMETOWN = '', U_NOTE = '' where U_ID = '10001'

--地址加载
select ADR_ID, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID order by ADR_ID

--地址分页加载
select a2.* from (select a1.*, rownum rn from (
select ADR_ID, ADR_UID, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID where 1=1 order by ADR_ID
) a1) a2 where rn <= 10 and rn > 0

--地址编辑加载
select ADR_ID, ADR_UID, u.U_NAME as ADR_USERNAME, ADR_UNAME, o1.ORG_NAME as ADR_PROV, o2.ORG_NAME as ADR_CITY, o3.ORG_NAME as ADR_DIST, ADR_ADDRESS, ADR_PHONE, ADR_ZIPCODE, ADR_NOTE from CBT_USERADR a inner join CBT_ORG o1 on a.ADR_PROV = o1.ORG_ID inner join CBT_ORG o2 on a.ADR_CITY = o2.ORG_ID inner join CBT_ORG o3 on a.ADR_DIST = o3.ORG_ID 
inner join CBT_USER u on u.u_id = adr_uid where ADR_ID = '123123123123'

--轮播列表加载
select CSL_ID, CSL_SRC, CSL_TYPE, CSL_TARGET, CSL_NOTE from CBT_CAROUSEL order by CSL_ID

--获取轮播ID
select max(CSL_ID) + 1 as NEWID from CBT_CAROUSEL

--轮播新增
insert into CBT_CAROUSEL values('4', '', 'B', 'images/123', '')

--轮播修改
update CBT_CAROUSEL c set c.csl_target = '', c.csl_type = 'A', c.csl_src = '123', c.csl_note = '' where c.csl_id = '4'

--新闻公告列表加载
select decode(n.ntc_type,'A','公告','N','新闻') as ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author order by n.NTC_ADDTIME desc

--新闻公告列表加载（倒序分页）
select a2.* from (select a1.*, rownum rn from (
select decode(n.ntc_type,'A','公告','N','新闻') as ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author where 1=1 order by n.NTC_ADDTIME desc
) a1) a2 where rn <= 20 and rn > 10

--新闻公告详情
select n.ntc_type, n.ntc_id, n.ntc_title, n.ntc_content, u.u_name as ntc_author, to_char(n.ntc_addtime, 'yyyy-mm-dd hh24:mi:ss') as ntc_addtime from CBT_NOTICE n inner join CBT_USER u on u.u_id = n.ntc_author where n.ntc_id = 'test1'

--新闻公告添加
INSERT INTO CBT_NOTICE VALUES ('id', 'tit', 'type', 'author', to_date('', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'content', 'note')

--新闻公告获取编号
SELECT trim(TO_CHAR(CBS_NOTICE.NEXTVAL,'0000')) FROM DUAL

--新闻公告编辑
UPDATE CBT_NOTICE n SET n.ntc_title = '', n.ntc_type = '', n.ntc_mdfperson = '', n.ntc_lastmdf = to_date('', 'yyyy-mm-dd hh24:mi:ss'), n.ntc_content = '', n.ntc_note = '' WHERE n.ntc_id = ''

--帮助列表加载（倒序分页）
select a2.* from (select a1.*, rownum rn from (
select n.HELP_ID, n.HELP_TITLE, n.HELP_CONTENT, u.U_NAME as HELP_AUTHOR, to_char(n.help_addtime, 'yyyy-mm-dd') as help_addtime from CBT_HELP n inner join CBT_USER u on u.u_id = n.help_author where 1=1 order by n.HELP_ADDTIME desc
) a1) a2 where rn <= 10 and rn > 0

--帮助详情
select n.help_id, n.help_title, n.help_content, u.u_name as help_author, to_char(n.help_addtime, 'yyyy-mm-dd hh24:mi:ss') as help_addtime, n.help_note from CBT_HELP n inner join CBT_USER u on u.u_id = n.help_author where n.help_id = 'HELP201703140018'

--帮助编辑
update CBT_HELP h set HELP_TITLE = '12312', HELP_CONTENT = '3123', h.help_mdfperson = '9999', h.help_lastmdf = to_date('2017-03-14 16:35:00', 'yyyy-mm-dd hh24:mi:ss'), h.help_note = '123' WHERE h.help_id = 'HELP201703140014'

--帮助获取编号
SELECT trim(TO_CHAR(CBS_HELP.NEXTVAL,'0000')) HELPID FROM DUAL

--帮助添加
INSERT INTO CBT_HELP VALUES ('id', 'tit', 'author', to_date('', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'content', 'note')

--建议加载
select a2.* from (select a1.*, rownum rn from (
select n.ADV_ID, n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME from CBT_ADVICE n inner join CBT_USER u on u.u_id = n.adv_author where 1=1 order by n.ADV_ADDTIME desc
) a1) a2 where rn <= 10 and rn > 0

--建议详情
SELECT ad.ADV_ID, ad.adv_title, ad.adv_content, u.U_NAME as ADV_AUTHOR, to_char(ad.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME from CBT_ADVICE ad inner join CBT_USER u on u.u_id = ad.ADV_AUTHOR where ad.ADV_ID = ''

--建议及审阅查看
select n.ADV_TITLE, n.ADV_CONTENT, u.U_NAME as ADV_AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd') as ADV_ADDTIME, ADV_REPLY, u1.U_NAME as ADV_REAUTHOR, to_char(n.ADV_RETIME, 'yyyy-mm-dd') as ADV_RETIME FROM CBT_ADVICE n INNER JOIN CBT_USER u ON u.U_ID = n.ADV_AUTHOR INNER JOIN CBT_USER u1 ON u1.u_id = n.ADV_REAUTHOR WHERE n.ADV_ID = ''
