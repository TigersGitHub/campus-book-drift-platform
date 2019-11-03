prompt PL/SQL Developer import file
prompt Created on 2017��6��1�� by Fred Shen
set feedback off
set define off
prompt Disabling triggers for CBT_ADVICE...
alter table CBT_ADVICE disable all triggers;
prompt Disabling triggers for CBT_BFMT...
alter table CBT_BFMT disable all triggers;
prompt Disabling triggers for CBT_BLANG...
alter table CBT_BLANG disable all triggers;
prompt Disabling triggers for CBT_BTYPE...
alter table CBT_BTYPE disable all triggers;
prompt Disabling triggers for CBT_DEPT...
alter table CBT_DEPT disable all triggers;
prompt Disabling triggers for CBT_USER...
alter table CBT_USER disable all triggers;
prompt Disabling triggers for CBT_BOOK...
alter table CBT_BOOK disable all triggers;
prompt Disabling triggers for CBT_CAROUSEL...
alter table CBT_CAROUSEL disable all triggers;
prompt Disabling triggers for CBT_ORG...
alter table CBT_ORG disable all triggers;
prompt Disabling triggers for CBT_USERADR...
alter table CBT_USERADR disable all triggers;
prompt Disabling triggers for CBT_EXPRESS...
alter table CBT_EXPRESS disable all triggers;
prompt Disabling triggers for CBT_ORDER...
alter table CBT_ORDER disable all triggers;
prompt Disabling triggers for CBT_COMMENT...
alter table CBT_COMMENT disable all triggers;
prompt Disabling triggers for CBT_CORPORATION...
alter table CBT_CORPORATION disable all triggers;
prompt Disabling triggers for CBT_FAVORITE...
alter table CBT_FAVORITE disable all triggers;
prompt Disabling triggers for CBT_HELP...
alter table CBT_HELP disable all triggers;
prompt Disabling triggers for CBT_NOTICE...
alter table CBT_NOTICE disable all triggers;
prompt Disabling triggers for CBT_POORPW...
alter table CBT_POORPW disable all triggers;
prompt Disabling triggers for CBT_RECOMMEND...
alter table CBT_RECOMMEND disable all triggers;
prompt Disabling triggers for CBT_ROLE...
alter table CBT_ROLE disable all triggers;
prompt Disabling foreign key constraints for CBT_USER...
alter table CBT_USER disable constraint USER_DEPT;
prompt Disabling foreign key constraints for CBT_BOOK...
alter table CBT_BOOK disable constraint BOOK_FORMAT;
alter table CBT_BOOK disable constraint BOOK_LANG;
alter table CBT_BOOK disable constraint BOOK_TYPE;
alter table CBT_BOOK disable constraint BOOK_USER_S;
prompt Disabling foreign key constraints for CBT_USERADR...
alter table CBT_USERADR disable constraint ADR_CITY;
alter table CBT_USERADR disable constraint ADR_DIST;
alter table CBT_USERADR disable constraint ADR_PROV;
alter table CBT_USERADR disable constraint ADR_USER;
prompt Disabling foreign key constraints for CBT_ORDER...
alter table CBT_ORDER disable constraint ORDER_ADR;
alter table CBT_ORDER disable constraint ORDER_BOOK;
alter table CBT_ORDER disable constraint ORDER_EXP;
alter table CBT_ORDER disable constraint ORDER_USER_C;
alter table CBT_ORDER disable constraint ORDER_USER_S;
prompt Disabling foreign key constraints for CBT_COMMENT...
alter table CBT_COMMENT disable constraint COM_ORDER;
prompt Disabling foreign key constraints for CBT_FAVORITE...
alter table CBT_FAVORITE disable constraint FAV_BOOK;
alter table CBT_FAVORITE disable constraint FAV_USER;
prompt Disabling foreign key constraints for CBT_RECOMMEND...
alter table CBT_RECOMMEND disable constraint REC_CORP;
alter table CBT_RECOMMEND disable constraint REC_LANG;
alter table CBT_RECOMMEND disable constraint REC_TYPE;
prompt Disabling foreign key constraints for CBT_ROLE...
alter table CBT_ROLE disable constraint ROLE_USER;
prompt Deleting CBT_ROLE...
delete from CBT_ROLE;
commit;
prompt Deleting CBT_RECOMMEND...
delete from CBT_RECOMMEND;
commit;
prompt Deleting CBT_POORPW...
delete from CBT_POORPW;
commit;
prompt Deleting CBT_NOTICE...
delete from CBT_NOTICE;
commit;
prompt Deleting CBT_HELP...
delete from CBT_HELP;
commit;
prompt Deleting CBT_FAVORITE...
delete from CBT_FAVORITE;
commit;
prompt Deleting CBT_CORPORATION...
delete from CBT_CORPORATION;
commit;
prompt Deleting CBT_COMMENT...
delete from CBT_COMMENT;
commit;
prompt Deleting CBT_ORDER...
delete from CBT_ORDER;
commit;
prompt Deleting CBT_EXPRESS...
delete from CBT_EXPRESS;
commit;
prompt Deleting CBT_USERADR...
delete from CBT_USERADR;
commit;
prompt Deleting CBT_ORG...
delete from CBT_ORG;
commit;
prompt Deleting CBT_CAROUSEL...
delete from CBT_CAROUSEL;
commit;
prompt Deleting CBT_BOOK...
delete from CBT_BOOK;
commit;
prompt Deleting CBT_USER...
delete from CBT_USER;
commit;
prompt Deleting CBT_DEPT...
delete from CBT_DEPT;
commit;
prompt Deleting CBT_BTYPE...
delete from CBT_BTYPE;
commit;
prompt Deleting CBT_BLANG...
delete from CBT_BLANG;
commit;
prompt Deleting CBT_BFMT...
delete from CBT_BFMT;
commit;
prompt Deleting CBT_ADVICE...
delete from CBT_ADVICE;
commit;
prompt Loading CBT_ADVICE...
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201701210001', '�ҵĽ�����ǡ�', 'RT~', '9999', to_timestamp('21-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, null, null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201701220002', 'û�н��飡', 'RT~', '9999', to_timestamp('22-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, null, null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201701230003', '��վ��������~', '���Ǻ��ã��������ͣ�', '9999', to_timestamp('23-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '��л�����������֧�֣�', '9999', to_timestamp('24-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201702010004', '���鲻Ҫ������У԰��', 'ϣ�������ƹ㵽ȫ�У��ø�����˲������У�', '9999', to_timestamp('01-02-2017 20:30:26.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '���Ľ������ǽ����촦����л�����������֧�֣�', '9999', to_timestamp('15-03-2017 16:17:59.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'T');
commit;
prompt 4 records loaded
prompt Loading CBT_BFMT...
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('1', '16��', '260*185mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('4', '��32��', '204*140mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('5', '64��', '130*92mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('2', '��16��', '297*210mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('3', '32��', '184*130mm');
commit;
prompt 5 records loaded
prompt Loading CBT_BLANG...
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('1', '����', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('3', 'Ӣ��', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('5', '����', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('2', 'Ӣ��', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('4', '��������', null);
commit;
prompt 5 records loaded
prompt Loading CBT_BTYPE...
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('1', '��������', 'A ���˼���塢�������塢ë��˼�롢��Сƽ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('2', '��ѧ�ڽ�', 'B ��ѧ���ڽ�');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('3', '����ѧ', 'C ����ѧ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('4', '��������', 'D ���Ρ����� E ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('5', '���ù���', 'F ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('6', '�̿�����', 'G �Ļ�����ѧ������������');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('7', '��������', 'H ���ԡ�����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('8', '��ѧ����', 'I ��ѧ J ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('9', '��ʷ����', 'K ��ʷ������');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('10', '��Ȼ��ѧ', 'N ��Ȼ��ѧ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('11', '����ѧ', 'O �����ѧ�ͻ�ѧ');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('12', '���ĵؿ�', 'P ����ѧ�������ѧ');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('13', '�����ѧ', 'Q �����ѧ');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('14', 'ҽҩ����', 'R ҽҩ������');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('15', 'ũҵ��ѧ', 'S ũҵ��ѧ');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('17', '��ͨ����', 'U ��ͨ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('18', '���պ���', 'V ���ա�����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('19', '������ȫ', 'X ������ѧ����ȫ��ѧ');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('16', '��ҵ����', 'T ��ҵ����');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('20', '�ۺ�ͼ��', 'Z �ۺ���ͼ��');
commit;
prompt 20 records loaded
prompt Loading CBT_DEPT...
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0201', '��ѧԺ', '02', '���ϴ�ѧ��D1��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('05', 'ɽ��ʦ����ѧ�����У��', '0', 'ɽ��ʡ�����г�������ѧ�Ƽ�԰��ѧ·1��', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('06', 'ɽ����ѧ����У��', '0', 'ɽ��ʡ������������ɽ����·27��', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020104', '���ѧ��˫ѧλ��', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020103', '���ѧ', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020101', '���̹���', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0', 'ȫ��ԺУ', '-1', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('01', '���ϴ�ѧ��У��', '0', 'ɽ��ʡ����������������ׯ��·336��', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0112', '��Ϣ��ѧ�빤��ѧԺ', '01', '���ϴ�ѧ��12��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011201', '�������ѧ�뼼��', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0101', '���Ͽ�ѧ�빤��ѧԺ', '01', '���ϴ�ѧ��6��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0102', '�Զ������������ѧԺ', '01', '���ϴ�ѧ��1��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0103', '��е����ѧԺ', '01', '���ϴ�ѧ��13��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0104', '��ѧ��ѧѧԺ', '01', '���ϴ�ѧ��7��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0105', '�����ѧ�뼼��ѧԺ', '01', '���ϴ�ѧ��7��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0106', '�����ѧԺ', '01', '���ϴ�ѧ��1��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0107', '��ѧԺ', '01', '���ϴ�ѧ��10��ѧ¥', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011202', 'ͨ�Ź���', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011203', '���繤��', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011204', '������Ϣ��ѧ�뼼��', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('02', '���ϴ�ѧ��У��', '0', 'ɽ��ʡ������������˴��·13��', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('03', 'ɽ���ƾ���ѧ��ɽУ��', '0', 'ɽ��ʡ������������������·7366��', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('04', 'ɽ��ʦ����ѧ��У��', '0', 'ɽ��ʡ�������������Ļ���·88�� ', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020102', '���̹���˫ѧλ��', '0201', null, null);
commit;
prompt 24 records loaded
prompt Loading CBT_USER...
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9003', 'test@shujiao.club', '15123456789', 'test', '123123', 'M', '0', 18, 'ɽ������', to_timestamp('15-02-2017 10:20:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('24-02-2017 10:03:33.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('10001', 'imtiger@shujiao.club', '15012345678', 'ؼ����', 's38626', 'M', '011201', 18, null, to_timestamp('23-02-2017 10:39:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 100, 'T', null, null);
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9001', 'mgr_tiger@shujiao.club', '15853107903', '����', 's38626', 'M', '0', 22, 'ɽ������', to_timestamp('13-02-2017 10:01:23.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('03-05-2017 14:02:23.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9999', 'admin@shujiao.club', '13905312345', '��������Ա', 's38626', 'M', '020101', 18, 'ɽ������', to_timestamp('01-01-2017 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('30-03-2017 17:09:22.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9004', 'test2@shujiao.club', '15012345679', 'test2', 'test22', 'F', '0', 18, '��������', to_timestamp('24-02-2017 10:05:43.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, null);
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9002', 'mgr_bunny@shujiao.club', '13181728270', '������', '1234567abc', 'F', '0', 21, 'ɽ������', to_timestamp('14-02-2017 14:25:01.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, null);
commit;
prompt 6 records loaded
prompt Loading CBT_BOOK...
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250015', '9787552010824', '19', '������', null, '[��]�˵ã����ֲ�����ķ ', null, '�Ϻ�����ѧԺ������', to_date('01-01-2016', 'dd-mm-yyyy'), '1', '1', 304, 'P', '1', 'N', 45, 0, to_timestamp('25-04-2017 14:47:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/dawumai.jpg', '���������������׶سǵĿ�����һֱ����ú����Ⱦ�������������������������׶ؿ�����Ⱦʷ���������������������׶صĿ�����Ⱦ��ʷ�����ڶ���Ⱦ��ʶ�ı仯�Լ���Ⱦ����ļ������̡���17���ͳ����׶ر����ˡ�����������������19���ͣ���������������׶ص��ο��Ǳؿ��ġ���ɫ�����ۡ���1952�������Ĵ���������֮ǰ��Ӣ�����Ѿ���ʶ����������˵Ľ���Ӱ�졣������Ⱦ������ȴ������һ�������Ĺ��̡�����ֱ�����ڣ�������Ⱦ�����ص�������������Ȼ���ִ����ؽ����������⡣', null, 0, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250013', '9787508651880', '5', '������', null, '��־��', null, '���ų��漯��', to_date('01-06-2015', 'dd-mm-yyyy'), '1', '1', 292, 'P', '1', 'N', 49.8, 0, to_timestamp('25-04-2017 14:40:07.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/chuangjd.jpg', '5��22�գ������ų��漯�ų�Ʒ�ġ�������:��ǿ��������ҵ֮·��һ�鿪��Ԥ�ۣ���Ϥ�������Ǿ�������ǿ��Ψһ��Ȩ��һ����˾���ǣ���֪����ҵ���ң�����ý������־����ʱһ�꣬�ɷ���258λ�����ʿ��׫�����ģ������չ���˾���12��ĳɰܵ�ʧ�뷢չ���̡����鲻������ǿ���������򣬸����ܺ�t����Сƽ�����¡����ڡ������������Ƽ���һ�������ֵ���ǿ���ڲ����������������״�����������', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250014', '9787802486942', '16', 'Android���������ŵ���ͨ', null, '���ɰ�', null, '����ϣ�����ӳ�����', to_date('01-01-2012', 'dd-mm-yyyy'), '1', '1', 541, 'P', '1', 'Y', 69, 29, to_timestamp('25-04-2017 14:42:13.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/androidrmjt.jpg', '��Android���������ŵ���ͨ��ϵͳ������Android��������Ļ���֪ʶ��ͼ�Ĳ�ï�ذ�������ѧϰ������SDK�����������Լ����õ�API�ȡ������Խ���ʵսʵ��Ϊ������һ��������Ӧ��������������߽�����Ŀ����ʵ������Android���������ŵ���ͨ����һ��������ʵ������ʵ�����ܽ�ϵĽ̡̳�', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250016', '9787121193941', '16', '���Ajax����', null, '���', null, '���ӹ�ҵ������', to_date('01-02-2013', 'dd-mm-yyyy'), '1', '1', 624, 'P', '3', 'Y', 79, 39, to_timestamp('25-04-2017 14:48:45.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-04-2017 14:49:59.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'Y', 'T', 'images/bookimage/ajax.jpg', '������ϸ������jQuery1.8��ExtJs4.1��Prototype1.7��DWR��4����õ�Ajax��ܵ��÷��������ÿ������ṩ��һ��ʵ�ð������ö���������ϵʵ�ʡ��ⲿ�������ǡ��������������ġ��ı�׼���壬���Ȱ�����ʵ��AjaX�������ص���ѵ㣬Ҳ�����˴���ѧϰ�ߵ�ѧϰ����͸������ɱ����Էḻ���ڿξ���Ϊ����������ǳ���ؽ������ǣ�ϣ��������������Ajax�����ľ��衣', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250019', '9787508630069', '8', 'ʷ�ٷ��ǲ�˹��', 'Steve Jobs:A Biography', '[��]�ֶ��ء�������ɭ', 'Walter Isaacson', '���ų�����', to_date('24-10-2011', 'dd-mm-yyyy'), '1', '1', 560, 'P', '1', 'Y', 68, 20, to_timestamp('25-04-2017 15:13:41.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/stevejobs.jpg', '��ʷ�ٷ��ǲ�˹���������������ֶ��ء�������ɭ�ڹ�ȥ�������ǲ�˹����潻��40��Ρ����ǲ�˹100��λ��ͥ��Ա�����ѡ��������ֺ�ͬ�µĲɷõĻ�����׫д���ɡ�������ɭ��ԭ��ʱ���ܿ������ࡢCNN���³�����ϯִ�й١�׫д������˹̹���ǡ������񴫼ǡ��������ִ��ǵȳ����鼮��', null, 4, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290005', '9787303103331', '5', '����ѧ����', 'Introduction of Management', '�Ų���', 'Caili Zhang', '����ʦ����ѧ������', to_date('01-04-2010', 'dd-mm-yyyy'), '1', '1', 100, 'P', '������', 'N', 32.8, 0, to_timestamp('29-03-2017 10:10:27.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/glxgl.jpg', '��������Ӧ��ְ��ר��ѧ�ĸ���Ҫ��������ָ�ְ��ר�̲���ɫ��Ϊ�����������㣬Ŭ�������ݺ���ʽ������ͻ�ƻ�Ľ���������ȡ����������ʵ���ԡ�ϵͳ�ԡ������Ϊԭ�򣬲�ע��֪ʶ�ĸ��£������ܽ�һЩ�µĹ���ɹ����ҹ��ĸĸﾭ������̲ģ�ͬʱע��֪ʶ��ʵ���ԣ�ѡ����ѧ���ɳ�������������ϵ���ܵ����ݡ��ڽ̲ı�д��ʽ�ϣ����߲���ע�����۵ĳ����ͽ��ܣ����������㹻�İ����Ͱ�����������������������������˼�����л���ϣ���ֵص���ѧ������˼��������ѧ���Ĺ�����ʶ��˼ά����������ѧ��ȫ�潨������ѧ�Ļ���֪ʶ��ϵ��ϵͳ���չ���ѧ�Ļ������ۺͷ�����', null, 4, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703240001', '9787040389692', '1', 'ë��˼����й���ɫ�������������ϵ����', 'Mao Zedong Thought and socialism with Chinese characteristics system info introduction', '�����д��', null, '�廪��ѧ������', to_date('24-03-2017', 'dd-mm-yyyy'), '1', '1', 324, 'P', '2017���1��', 'Y', 18, 9.9, to_timestamp('24-03-2017 19:05:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/mzd.jpg', 'ë��˼����й���ɫ�������������ϵ���ۿγ���һ��˼���������ۿΣ�����Ҫ�����ǰ���ѧ��ѧϰë��˼����й���ɫ�������������ϵ�Ļ������ݣ�����ѧ�����ë��˼����й���ɫ�������������ϵ�����˼����Ļ���ԭ�����й�ʵ�����ϵ�����ΰ������۳ɹ������й������������ǻ۵Ľᾧ��Ϊ�˼�ǿ�ߵ�ѧУ˼���������ۿν�ѧ�����˼���������ۿν�ѧ����Ժ�ʵЧ�ԣ�������֯��д���Ȿ��ë��˼����й���ɫ�������������ϵ���ۡ�һ�顣�����ڱ�д�����������᳹����ʮ�ߴ��񣬽��ѧ����ѧϰ���ſ�ʱ���������⣬�����ص��������ǿ��˼���������ۿε�����Ժ�ʵ���ԡ�ͨ�������ѧϰ������ѧ���������˼������������۵�ͷ����������⡢����������������ǿ�᳹���Ļ������ۡ�����·�ߡ����������Լ���������ߵ��Ծ��ԡ��ᶨ�ԣ�����Ͷ��ȫ�潨��С������ΰ��ʵ���������ǳ��汾���Ŀ�ġ����̲��ڱ�д�����У������˴����Ľ̲ġ����������ף����ա����������ܶ�ר��ѧ�ߵ��о��ɹ����õ����ÿ�ѧ����������ʹ���֧�֣��ڴ˱�ʾ��ֿ�ĸ�л�����ڱ���ˮƽ����дʱ�䣬���������в���֮���������λ���ߡ�ר������ָ����', null, 20, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290006', '9787040396638', '11', '�ߵ���ѧ', null, 'ͬ�ô�ѧ��ѧϵ', null, '�ߵȽ���������', to_date('01-07-2014', 'dd-mm-yyyy'), '1', '1', 785, 'P', '���߰�', 'Y', 74.4, 19.9, to_timestamp('29-03-2017 10:20:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'N', 'T', 'images/bookimage/gs.jpg', '������ͬ�ô�ѧ��ѧϵ��ġ��ߵ���ѧ�����߰棬��������˵�������û�ж��仯���������ȷ��ϡ������౾����ѧ�����γ̽�ѧ����Ҫ�󡱣��ʺϸߵ�ԺУ�������רҵѧ��ʹ�á�' || chr(13) || '' || chr(10) || '���������������棬�ϲ���������뼫�ޡ�������΢�֡�΢����ֵ�����뵼����Ӧ�á��������֡������ּ���Ӧ�á�΢�ַ��̵����ݣ���ĩ�����ж��׺���������ʽ��顢�������Ⱥ�����ͼ�Ρ����ֳ��õ����ߡ����ֱ�ϰ�������ʾ���²��������������ռ�������Ρ���Ԫ����΢�ַ�����Ӧ�á��ػ��֡����߻�����������֡�����������ݣ���ĩ������ϰ�������ʾ��', null, 15, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290007', '9787302059325', '16', '������', 'The Mythical Man-Month', '��³��˹', 'FrederickP.Brooks.Jr.', '�廪��ѧ������', to_date('01-11-2002', 'dd-mm-yyyy'), '2', '1', 369, 'P', '��һ��', 'N', 29.8, 0, to_timestamp('29-03-2017 10:25:48.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-03-2017 15:34:55.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'N', 'T', 'images/bookimage/rysh.jpg', '�������񻰡�����Դ������Brooks��IBM��˾��System�����ϵ���Լ����Ӵ�����ϵͳOS��Ŀ����ʱ��ʵ�����顣�������񻰡�̽���˴��һ���Ե����Ѻͽ���ķ�������̽����������̹�����������档�ڡ������񻰣�Ӣ�İ棩���У����кܶ෢����ʡ�Ĺ۵㣬���д���������̵�ʵ����Ϊÿ��������Ŀ�Ĺ����߸������Լ�����֪�Ƽ����ͱ����Ŀ���������������ֲ����Ĺ�����������ţ����ֲ�Ʒ����ĸ�����������һ��������Ҫ�����󡣡�������(Ӣ�İ�)��̽���˴��һ���Ե����Ѻͽ���ķ�������̽����������̹�����������档��������(Ӣ�İ�)���ʺ��κ����������ҵ�Ĵ�ҵ��Ա�Ķ��������������Ա�������Ŀ����ϵͳ����ʦ���Ǳض�֮����', null, 13, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250017', '9787544737951', '8', '�����������ң����Ȼ��Դ�', null, '[��]���Ȼ�', null, '���ֳ�����', to_date('01-05-2013', 'dd-mm-yyyy'), '1', '1', 313, 'P', '1', 'N', 35, 0, to_timestamp('25-04-2017 14:52:57.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/pjh.jpg', '����Ϊ������λŮ��ͳ���Ȼ�Ψһ�ױ��Դ��������У����Ȼ�����ƽʵ�ıʴ����渵������Ĺ��������������ɼ����Ը�ĸ��׷Ľ�뻳��֮�顢�Ժ������񻳱���ʹ���У��Լ��������������ʡ˼����͡�', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250011', '9787115275790', '16', 'JavaScript�߼��������', 'Professional JavaScript for Web Developers', '[��]����˹', 'Nicholas C.Zakas', '�����ʵ������', to_date('01-01-2006', 'dd-mm-yyyy'), '1', '1', 616, 'P', '1', 'Y', 99, 49, to_timestamp('25-04-2017 14:26:37.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/jshigh.jpg', '�����������Netscape������е�JavaScript��ʼ����ֱ����ǰ����XML��Web����ľ���֧�֣�������Ҫ�漰JavaScript�������ص㡢JavaScript��������Ľ��������߼���JavaScript���ɣ��Լ�����WebӦ�ó����в���JavaScript��������йص����⣬����������ԡ���ȫ�ԡ��Ż�/��������XML��Web����������Ӧ��������Щ֪ʶ��������̬�û����档�����ʺ���һ����̾���Ŀ�����Ա�Ķ���Ҳ����Ϊ��У���רҵ�γ̵Ľ̲ġ�', null, 6, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250012', '9787213052545', '6', '������ʱ��', 'Big Data:A Revolution That Will Transform How We Live, Work, and Think', '[�µ���] ά���С�����-�������', null, '�㽭���������', to_date('01-01-2013', 'dd-mm-yyyy'), '1', '1', 240, 'P', '1', 'Y', 49.9, 29.9, to_timestamp('25-04-2017 14:36:30.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'N', 'T', 'images/bookimage/bigdata.jpg', 'ά���С��������������������ǰհ�Ե�ָ���������ݴ�������Ϣ�籩���ڱ�����ǵ����������˼ά�������ݿ�����һ���ش��ʱ��ת�ͣ������������ֽ����˴�����ʱ����˼ά����ҵ���͹����', null, 3, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250018', '9787508610450', '8', 'ϣ���ﴫ����Ȩ������Ů��', 'A Woman In Charge', '����ϫ', null, '���ų�����', to_date('11-01-2008', 'dd-mm-yyyy'), '1', '1', 300, 'P', '1', 'N', 48, 0, to_timestamp('25-04-2017 14:56:08.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/xll.jpg', '��Ϊ߳��������̳��ʮ���ص�Ů�ˣ�ϣ���ﵣ��������ɫ�� ������ʢ�ٵĽ�����ʦ���������е��ݳ����ˡ����ż��͵İ׹�Ů���ˡ��б��������������䡢��ϣ������ͳ��ѡ�ˡ��� �ڲ�ͬ����ʷʱ�̣�ϣ����һ������ĳ������裬����ʵ��ϣ���ﵽ���������ģ���Щʢ������ϣ���ﱳ����ʲô�� ͸�����飬ȫ����ʶ������ʶ������Ե�δ�������֡�', null, 5, '9999');
commit;
prompt 13 records loaded
prompt Loading CBT_CAROUSEL...
insert into CBT_CAROUSEL (csl_id, csl_target, csl_type, csl_src, csl_note)
values ('2', null, 'N', 'images/carousel2.jpg', null);
insert into CBT_CAROUSEL (csl_id, csl_target, csl_type, csl_src, csl_note)
values ('3', null, 'N', 'images/carousel3.jpg', null);
insert into CBT_CAROUSEL (csl_id, csl_target, csl_type, csl_src, csl_note)
values ('1', 'http://www.baidu.com/', 'T', 'images/carousel1.jpg', 'test');
commit;
prompt 3 records loaded
prompt Loading CBT_ORG...
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('null', 'null', 'null', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('02', '���', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0401', '������', '04', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010104', '������', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0301', '�Ϻ���', '03', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010101', '������', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010102', '������', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('04', '����', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0201', '�����', '02', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0501', '������', '05', '������ܲ����ڵ�');
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050101', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('01', '����', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('03', '�Ϻ�', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0101', '������', '01', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010103', '������', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050102', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050103', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050104', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050105', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050106', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050107', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050108', '������', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050109', '�̺���', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050110', 'ƽ����', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0502', '�ൺ��', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050201', '�б���', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050202', '������', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050203', '�Ƶ���', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050204', '��ɽ��', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050205', '�����', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050206', '������', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050207', '������', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050208', '��ī��', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050209', 'ƽ����', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050210', '������', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0503', '�Ͳ���', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0504', '̩����', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0505', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0506', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0507', 'Ϋ����', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0508', '��ׯ��', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0509', '�ĳ���', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0510', '��Ӫ��', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0511', '��̨��', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0512', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0513', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0514', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0515', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0516', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0517', '������', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('05', 'ɽ��ʡ', '0', null);
commit;
prompt 51 records loaded
prompt Loading CBT_USERADR...
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201704250021', '10001', '������', '18601012345', '01', '0101', '010103', '�⻪·32��', null, to_timestamp('25-04-2017 17:50:24.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'F');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('123123123123', '10001', '������', '15812345678', '05', '0501', '050101', '����ׯ��·336��', '250022', to_timestamp('24-02-2017 10:39:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'T');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201703310001', '9999', '���̩', '15853107903', '01', '0101', '010103', '���Ŵ���A101', null, to_timestamp('31-03-2017 11:49:03.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'F');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201703310011', '9999', '���̩', '15853107903', '05', '0501', '050101', '����ׯ��·336��', null, to_timestamp('31-03-2017 16:29:34.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'T');
commit;
prompt 4 records loaded
prompt Loading CBT_EXPRESS...
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('sf', '˳���ٵ�', 'aaa', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('jd', '�������', 'bbb', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('sto', '��ͨ�ٵ�', 'ccc', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('yto', 'Բͨ�ٵ�', 'ddd', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('yunda', '�ϴ���', 'eee', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('zto', '��ͨ���', 'fff', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('rfd', '����', 'ggg123', '13901012345', null);
commit;
prompt 7 records loaded
prompt Loading CBT_ORDER...
insert into CBT_ORDER (ord_id, ord_bookid, ord_seller, ord_customer, ord_adrid, ord_ordtime, ord_finishtime, ord_ordway, ord_expid, ord_selcom, ord_cuscom, ord_status, ord_msg, ord_note, ord_expcorp)
values ('ORD201704050006', 'BOOK201703290006', '9999', '9999', 'ADR201703310011', to_timestamp('05-04-2017 18:06:34.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('07-04-2017 10:33:23.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'E', null, 'F', 'F', '6', null, null, null);
insert into CBT_ORDER (ord_id, ord_bookid, ord_seller, ord_customer, ord_adrid, ord_ordtime, ord_finishtime, ord_ordway, ord_expid, ord_selcom, ord_cuscom, ord_status, ord_msg, ord_note, ord_expcorp)
values ('ORD201704070014', 'BOOK201703290006', '9999', '9999', 'ADR201703310011', to_timestamp('07-04-2017 10:44:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'E', '123123', 'F', 'F', '3', null, null, 'sf');
insert into CBT_ORDER (ord_id, ord_bookid, ord_seller, ord_customer, ord_adrid, ord_ordtime, ord_finishtime, ord_ordway, ord_expid, ord_selcom, ord_cuscom, ord_status, ord_msg, ord_note, ord_expcorp)
values ('ORD201704060011', 'BOOK201703290007', '9999', '9999', 'ADR201703310011', to_timestamp('06-04-2017 09:54:19.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'F', null, 'T', 'T', '5', null, null, null);
insert into CBT_ORDER (ord_id, ord_bookid, ord_seller, ord_customer, ord_adrid, ord_ordtime, ord_finishtime, ord_ordway, ord_expid, ord_selcom, ord_cuscom, ord_status, ord_msg, ord_note, ord_expcorp)
values ('ORD201704260021', 'BOOK201704250012', '9999', '10001', '123123123123', to_timestamp('26-04-2017 09:47:19.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'F', null, 'F', 'F', '2', null, null, null);
commit;
prompt 4 records loaded
prompt Loading CBT_COMMENT...
insert into CBT_COMMENT (com_id, com_ordid, com_source, com_time, com_type, com_comment, com_enable, com_note, com_userid)
values ('COM201704090003', 'ORD201704060011', 'C', to_timestamp('09-04-2017 14:12:21.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'G', '����£������ܺ�', 'T', null, '9999');
insert into CBT_COMMENT (com_id, com_ordid, com_source, com_time, com_type, com_comment, com_enable, com_note, com_userid)
values ('COM201704090004', 'ORD201704060011', 'S', to_timestamp('09-04-2017 14:26:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'G', '�������', 'T', null, '9999');
commit;
prompt 2 records loaded
prompt Loading CBT_CORPORATION...
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('1', '��������½ʰ�ȵ����������޹�˾', '��ǿ��', '13901080123', '�����к��������ݽ�72�ű������ü����������ƴ�ʮ�Ľ�', null, '����');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('2', '�㽭��è�������޹�˾', '����', '13901080456', '�㽭ʡ�������ຼ���峣�ֵ��峣���168��3��¥����', null, '��è');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('3', '������������Ϣ�������޹�˾', '�����', '18612345678', '�����ж������ؾ��ݺ�ͬ17��1��һ��', null, '����');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('4', '�»����', '�곤', '15812345678', '��������������ʮ·', null, '�»����');
commit;
prompt 4 records loaded
prompt Loading CBT_FAVORITE...
insert into CBT_FAVORITE (fav_id, fav_bookid, fav_userid, fav_addtime, fav_enable, fav_note)
values ('FAV201703290007', 'BOOK201703290005', '9999', to_timestamp('29-03-2017 10:27:38.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'T', null);
insert into CBT_FAVORITE (fav_id, fav_bookid, fav_userid, fav_addtime, fav_enable, fav_note)
values ('FAV201704260011', 'BOOK201704250011', '9999', to_timestamp('26-04-2017 14:54:05.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'T', null);
commit;
prompt 2 records loaded
prompt Loading CBT_HELP...
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201703140012', 'test', 'null', to_timestamp('14-03-2017 15:46:34.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '123', 'null');
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701110001', 'ʾ������1', '9999', to_timestamp('11-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701120002', 'ʾ������2', '9999', to_timestamp('12-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701130003', 'ʾ������3', '9999', to_timestamp('13-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701140004', 'ʾ������4', '9999', to_timestamp('14-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701150005', 'ʾ������5', '9999', to_timestamp('15-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701160006', 'ʾ������6', '9999', to_timestamp('16-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701170007', 'ʾ������7', '9999', to_timestamp('17-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701180008', 'ʾ������8', '9999', to_timestamp('18-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701190009', 'ʾ������9', '9999', to_timestamp('19-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701200010', 'ʾ������10', '9999', to_timestamp('20-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701210011', 'ʾ������11', '9999', to_timestamp('21-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '9999', to_timestamp('14-03-2017 17:49:20.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '123jweifojgioewhiofejwi', '123');
commit;
prompt 12 records loaded
prompt Loading CBT_NOTICE...
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701190012', '�����Ʊ��ܸ����˺�����', 'A', '9999', to_timestamp('19-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '�����Ʊ��ܸ����˺����룡��֤������Ϣ�Ʋ���ȫ��', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140006', '��Ｏ�ŷ����ص磡', 'N', '9999', to_timestamp('14-01-2017 14:25:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312321132', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701150007', '1��15��ϵͳά������', 'A', '9999', to_timestamp('15-01-2017 14:22:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312313', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701120001', '1��12��ϵͳά������', 'A', '9999', to_timestamp('12-01-2017 14:16:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312313123', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701170010', '1��17��ϵͳά������', 'A', '9999', to_timestamp('17-01-2017 14:15:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1231231', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701160009', '���ϴ�ѧ�쵼�Ӳ��������Ӫ����', 'N', '9999', to_timestamp('16-01-2017 14:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '123213', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140005', '����Ͱͼ��ŷ����ص磡', 'N', '9999', to_timestamp('14-01-2017 14:13:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '13123123131', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140004', '�������ŷ����ص磡', 'N', '9999', to_timestamp('14-01-2017 14:11:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '123123', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701130002', '�����������������ϴ�ѧУ��ʦ����������Ӫ', 'N', '9999', to_timestamp('13-01-2017 14:05:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '4567777', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140003', '1��14��ϵͳά������', 'A', '9999', to_timestamp('14-01-2017 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1234444', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701150008', '���ϴ�ѧ��ϢѧԺ�쵼�Ӳ��������Ӫ����', 'N', '9999', to_timestamp('15-01-2017 14:29:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1232333', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201703090013', '3��9��ϵͳά������', 'A', '9999', to_timestamp('09-03-2017 10:23:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '9999', to_timestamp('09-03-2017 11:52:48.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '�����𾴵�������û�����վ����2017��3��9����23:00����ϵͳ����ά����Ԥ�Ƴ���1Сʱ����ʱ�뱣��ø������ݣ���Ҫ��¼ϵͳ��' || chr(13) || '' || chr(10) || '�����ɴ˸��������Ĳ��㣬�����½⣡' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '                                                                                    �������������' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '                                                                                     2017��3��9��', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701190011', '������������ߣ�', 'N', '9999', to_timestamp('19-01-2017 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '������������ߣ������ڴ�', null);
commit;
prompt 13 records loaded
prompt Loading CBT_POORPW...
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('1', '123456', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('2', '111111', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('3', '222222', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('4', '333333', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('5', '444444', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('6', '555555', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('7', '666666', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('8', '777777', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('9', '888888', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('10', '999999', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('11', '000000', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('12', 'password', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('13', 'username', 'T', null);
insert into CBT_POORPW (ppw_id, ppw_pw, ppw_enable, ppw_note)
values ('14', 'shujiao', 'F', null);
commit;
prompt 14 records loaded
prompt Loading CBT_RECOMMEND...
insert into CBT_RECOMMEND (rec_id, rec_isbn, rec_type, rec_name_ch, rec_name_en, rec_author_ch, rec_author_en, rec_press, rec_language, rec_image, rec_price, rec_sellprice, rec_addtime, rec_lastmdf, rec_corpid, rec_url, rec_click, rec_spprice, rec_paybalance, rec_enable, rec_note)
values ('REC201703010000', '9787040377453', '1', '���˼�������ԭ�����(2013���޶���)', null, '�����д��', null, '�ߵȽ���������', '1', 'images/bookimage/mks.jpg' || chr(10) || '', 21, 18, to_timestamp('20-03-2017 17:26:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('09-04-2017 22:01:45.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'https://item.jd.com/11431370.html', 3176, 1.5, 1000, 'T', null);
insert into CBT_RECOMMEND (rec_id, rec_isbn, rec_type, rec_name_ch, rec_name_en, rec_author_ch, rec_author_en, rec_press, rec_language, rec_image, rec_price, rec_sellprice, rec_addtime, rec_lastmdf, rec_corpid, rec_url, rec_click, rec_spprice, rec_paybalance, rec_enable, rec_note)
values ('REC201703170001', '9787302224464', '16', 'C������ƣ����İ棩', 'C Programming Language(Version 4)', '̷��ǿ', 'Haoqiang Tan', '�廪��ѧ������', '1', 'images/bookimage/c.jpg', 39.8, 9.9, to_timestamp('17-03-2017 10:20:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('09-04-2017 22:03:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'https://item.jd.com/11052214.html', 2105, 3, 1000, 'T', null);
commit;
prompt 2 records loaded
prompt Loading CBT_ROLE...
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9001_1', '9001', 'U');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9002', '9002', 'A');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9999_1', '9999', 'U');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9999', '9999', 'A');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9001', '9001', 'A');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9003', '9003', 'A');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('10001', '10001', 'U');
insert into CBT_ROLE (r_id, r_uid, r_sign)
values ('9004', '9004', 'A');
commit;
prompt 8 records loaded
prompt Enabling foreign key constraints for CBT_USER...
alter table CBT_USER enable constraint USER_DEPT;
prompt Enabling foreign key constraints for CBT_BOOK...
alter table CBT_BOOK enable constraint BOOK_FORMAT;
alter table CBT_BOOK enable constraint BOOK_LANG;
alter table CBT_BOOK enable constraint BOOK_TYPE;
alter table CBT_BOOK enable constraint BOOK_USER_S;
prompt Enabling foreign key constraints for CBT_USERADR...
alter table CBT_USERADR enable constraint ADR_CITY;
alter table CBT_USERADR enable constraint ADR_DIST;
alter table CBT_USERADR enable constraint ADR_PROV;
alter table CBT_USERADR enable constraint ADR_USER;
prompt Enabling foreign key constraints for CBT_ORDER...
alter table CBT_ORDER enable constraint ORDER_ADR;
alter table CBT_ORDER enable constraint ORDER_BOOK;
alter table CBT_ORDER enable constraint ORDER_EXP;
alter table CBT_ORDER enable constraint ORDER_USER_C;
alter table CBT_ORDER enable constraint ORDER_USER_S;
prompt Enabling foreign key constraints for CBT_COMMENT...
alter table CBT_COMMENT enable constraint COM_ORDER;
prompt Enabling foreign key constraints for CBT_FAVORITE...
alter table CBT_FAVORITE enable constraint FAV_BOOK;
alter table CBT_FAVORITE enable constraint FAV_USER;
prompt Enabling foreign key constraints for CBT_RECOMMEND...
alter table CBT_RECOMMEND enable constraint REC_CORP;
alter table CBT_RECOMMEND enable constraint REC_LANG;
alter table CBT_RECOMMEND enable constraint REC_TYPE;
prompt Enabling foreign key constraints for CBT_ROLE...
alter table CBT_ROLE enable constraint ROLE_USER;
prompt Enabling triggers for CBT_ADVICE...
alter table CBT_ADVICE enable all triggers;
prompt Enabling triggers for CBT_BFMT...
alter table CBT_BFMT enable all triggers;
prompt Enabling triggers for CBT_BLANG...
alter table CBT_BLANG enable all triggers;
prompt Enabling triggers for CBT_BTYPE...
alter table CBT_BTYPE enable all triggers;
prompt Enabling triggers for CBT_DEPT...
alter table CBT_DEPT enable all triggers;
prompt Enabling triggers for CBT_USER...
alter table CBT_USER enable all triggers;
prompt Enabling triggers for CBT_BOOK...
alter table CBT_BOOK enable all triggers;
prompt Enabling triggers for CBT_CAROUSEL...
alter table CBT_CAROUSEL enable all triggers;
prompt Enabling triggers for CBT_ORG...
alter table CBT_ORG enable all triggers;
prompt Enabling triggers for CBT_USERADR...
alter table CBT_USERADR enable all triggers;
prompt Enabling triggers for CBT_EXPRESS...
alter table CBT_EXPRESS enable all triggers;
prompt Enabling triggers for CBT_ORDER...
alter table CBT_ORDER enable all triggers;
prompt Enabling triggers for CBT_COMMENT...
alter table CBT_COMMENT enable all triggers;
prompt Enabling triggers for CBT_CORPORATION...
alter table CBT_CORPORATION enable all triggers;
prompt Enabling triggers for CBT_FAVORITE...
alter table CBT_FAVORITE enable all triggers;
prompt Enabling triggers for CBT_HELP...
alter table CBT_HELP enable all triggers;
prompt Enabling triggers for CBT_NOTICE...
alter table CBT_NOTICE enable all triggers;
prompt Enabling triggers for CBT_POORPW...
alter table CBT_POORPW enable all triggers;
prompt Enabling triggers for CBT_RECOMMEND...
alter table CBT_RECOMMEND enable all triggers;
prompt Enabling triggers for CBT_ROLE...
alter table CBT_ROLE enable all triggers;
set feedback on
set define on
prompt Done.
