--权限
--权限页员工列表
SELECT u.u_id, u.u_email, u.u_name, r2.r_sign FROM CBT_USER u LEFT OUTER JOIN CBT_ROLE r1 ON r1.r_uid = u.u_id and r1.r_sign = 'A' LEFT OUTER JOIN CBT_ROLE r2 ON r2.r_uid = u.u_id and r2.r_sign = 'U' WHERE r1.r_sign = 'A' and u.u_enable = 'T' ORDER BY U_ID

--添加权限
INSERT INTO CBT_ROLE VALUES ('_1', '', 'U');

--取消权限
DELETE FROM CBT_ROLE WHERE R_UID = '' and R_SIGN = 'U'

--通讯录
--员工通讯录查询
select u.u_id, u.u_name, u.u_sex, to_char(u.u_regtime, 'yyyy-mm-dd') as u_enttime, u.u_mobile, u.u_email, u.u_enable from CBT_USER u 
left join CBT_ROLE r on u.u_id = r.r_uid
where r.r_sign = 'A' and u.u_id != '9999' order by U_ID;

--员工搜索
select u.u_id, u.u_name, u.u_sex, to_char(u.u_regtime, 'yyyy-mm-dd') as u_enttime, u.u_mobile, u.u_email, u.u_enable from CBT_USER u left join CBT_ROLE r on u.u_id = r.r_uid
where r.r_sign = 'A' and u.u_id != '9999' and u.u_name like '%管%' order by U_ID;

--员工新增
insert into CBT_USER values (CBS_EMP.nextval, 'jack@shujiao.club', '13905312345', '保管员', '123456', 'M', '0', '24', '山东济南', to_date('2017-2-13 10:01:23', 'yyyy-mm-dd hh24:mi:ss'), 0, 'T', '', '');
insert into CBT_ROLE values ('9001', '9001', 'A');

--员工信息查看
select u_id, u_email, u_mobile, u_name, u_sex, u_age, u_hometown, to_char(u_regtime, 'yyyy-mm-dd') as u_enttime, u_enable, u_note from cbt_user where u_id = '9001';

--员工禁用
update CBT_USER set U_ENABLE = 'F' where U_ID = '9002';

--员工启用
update CBT_USER set U_ENABLE = 'T' where U_ID = '9001';

--员工信息编辑
update CBT_USER set U_EMAIL = 'test2@shujiao.club', U_MOBILE = '15123456789', U_NAME = 'test2', U_SEX = 'M', U_AGE = '22', U_HOMETOWN = 'jinan', U_NOTE = '111' where U_ID = '9003'

--字典
--院校字典选择父节点
select DEPT_ID, DEPT_NAME from CBT_DEPT where DEPT_PARENT = 0 or DEPT_PARENT in (select DEPT_ID from CBT_DEPT where DEPT_PARENT = 0) order by DEPT_ID

--院校字典生成二级ID
select substr(to_char(max(DEPT_ID)+1, '0000'), 2) as newid from CBT_DEPT where DEPT_PARENT = '04'

--院校字典面包屑内容查询
select DEPT_NAME from CBT_DEPT where DEPT_ID = '01'; --B级
select DEPT_NAME from CBT_DEPT where ( DEPT_ID = ( select DEPT_PARENT from CBT_DEPT where DEPT_ID = '0112' ) or DEPT_ID = '0112') order by DEPT_ID; --C级

--院校字典新增
insert into CBT_DEPT values ('020101', '工商管理', '0201', '', '');

--院校字典详情加载
select d1.DEPT_ID, d1.DEPT_NAME, d2.DEPT_NAME as DEPT_PARENTNAME, d1.DEPT_ADDRESS, d1.DEPT_NOTE from CBT_DEPT d1 left join CBT_DEPT d2 on d1.DEPT_PARENT = d2.DEPT_ID where d1.DEPT_ID = '020103';

--院校字典编辑提交
update CBT_DEPT set DEPT_NAME = 'kj', DEPT_ADDRESS = 'kkk', DEPT_NOTE = '' where DEPT_ID = '020103';

--院校字典删除
select 1 from CBT_DEPT where DEPT_PARENT = '0202' group by 1; --1父节点 null叶子节点
delete from CBT_DEPT where DEPT_ID = '0202';

--组织机构字典详情加载
select d1.ORG_ID, d1.ORG_NAME, d2.ORG_NAME as ORG_PARENTNAME, d1.ORG_NOTE from CBT_ORG d1 left join CBT_ORG d2 on d1.ORG_PARENT = d2.ORG_ID where d1.ORG_ID = '060101';

--组织机构字典生成二级ID
select substr(to_char(max(ORG_ID)+1, '0000'), 2) as newid from CBT_ORG where ORG_PARENT = '01'

--组织机构面包屑内容查询
select ORG_NAME from CBT_ORG where ORG_ID = '01'; --B级
select ORG_NAME from CBT_ORG where ( ORG_ID = ( select ORG_PARENT from CBT_ORG where ORG_ID = '0601' ) or ORG_ID = '0601') order by ORG_ID; --C级

--图书分类字典排序
select TYP_ID, TYP_NAME, TYP_NOTE from CBT_BTYPE order by cast(TYP_ID as int)
