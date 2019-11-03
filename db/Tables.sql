prompt PL/SQL Developer import file
prompt Created on 2017年6月1日 by Fred Shen
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
values ('ADV201701210001', '我的建议就是↑', 'RT~', '9999', to_timestamp('21-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, null, null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201701220002', '没有建议！', 'RT~', '9999', to_timestamp('22-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, null, null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201701230003', '网站炒鸡好用~', '就是好用！继续加油！', '9999', to_timestamp('23-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '感谢您对书角网的支持！', '9999', to_timestamp('24-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'T');
insert into CBT_ADVICE (adv_id, adv_title, adv_content, adv_author, adv_addtime, adv_reply, adv_reauthor, adv_retime, adv_note, adv_enable)
values ('ADV201702010004', '建议不要局限在校园内', '希望尽快推广到全市，让更多的人参与其中！', '9999', to_timestamp('01-02-2017 20:30:26.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '您的建议我们将尽快处理，感谢您对书角网的支持！', '9999', to_timestamp('15-03-2017 16:17:59.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'T');
commit;
prompt 4 records loaded
prompt Loading CBT_BFMT...
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('1', '16开', '260*185mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('4', '大32开', '204*140mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('5', '64开', '130*92mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('2', '大16开', '297*210mm');
insert into CBT_BFMT (fmt_id, fmt_name, fmt_note)
values ('3', '32开', '184*130mm');
commit;
prompt 5 records loaded
prompt Loading CBT_BLANG...
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('1', '中文', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('3', '英语', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('5', '日语', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('2', '英语', null);
insert into CBT_BLANG (lan_id, lan_name, lan_note)
values ('4', '西班牙语', null);
commit;
prompt 5 records loaded
prompt Loading CBT_BTYPE...
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('1', '马列中社', 'A 马克思主义、列宁主义、毛泽东思想、邓小平理论');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('2', '哲学宗教', 'B 哲学、宗教');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('3', '社会科学', 'C 社会科学总论');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('4', '政法军事', 'D 政治、法律 E 军事');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('5', '经济管理', 'F 经济');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('6', '教科文体', 'G 文化、科学、教育、体育');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('7', '语言文字', 'H 语言、文字');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('8', '文学艺术', 'I 文学 J 艺术');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('9', '历史地理', 'K 历史、地理');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('10', '自然科学', 'N 自然科学总论');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('11', '数理化学', 'O 数理科学和化学');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('12', '天文地科', 'P 天文学、地球科学');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('13', '生物科学', 'Q 生物科学');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('14', '医药卫生', 'R 医药、卫生');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('15', '农业科学', 'S 农业科学');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('17', '交通运输', 'U 交通运输');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('18', '航空航天', 'V 航空、航天');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('19', '环境安全', 'X 环境科学、安全科学');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('16', '工业技术', 'T 工业技术');
insert into CBT_BTYPE (typ_id, typ_name, typ_note)
values ('20', '综合图书', 'Z 综合性图书');
commit;
prompt 20 records loaded
prompt Loading CBT_DEPT...
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0201', '商学院', '02', '济南大学第D1教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('05', '山东师范大学长清湖校区', '0', '山东省济南市长清区大学科技园大学路1号', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('06', '山东大学中心校区', '0', '山东省济南市历下区山大南路27号', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020104', '会计学（双学位）', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020103', '会计学', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020101', '工商管理', '0201', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0', '全部院校', '-1', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('01', '济南大学西校区', '0', '山东省济南市市中区南辛庄西路336号', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0112', '信息科学与工程学院', '01', '济南大学第12教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011201', '计算机科学与技术', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0101', '材料科学与工程学院', '01', '济南大学第6教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0102', '自动化与电气工程学院', '01', '济南大学第1教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0103', '机械工程学院', '01', '济南大学第13教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0104', '数学科学学院', '01', '济南大学第7教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0105', '物理科学与技术学院', '01', '济南大学第7教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0106', '外国语学院', '01', '济南大学第1教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('0107', '文学院', '01', '济南大学第10教学楼', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011202', '通信工程', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011203', '网络工程', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('011204', '电子信息科学与技术', '0112', null, null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('02', '济南大学东校区', '0', '山东省济南市市中区舜耕路13号', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('03', '山东财经大学燕山校区', '0', '山东省济南市历下区二环东路7366号', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('04', '山东师范大学主校区', '0', '山东省济南市历下区文化东路88号 ', null);
insert into CBT_DEPT (dept_id, dept_name, dept_parent, dept_address, dept_note)
values ('020102', '工商管理（双学位）', '0201', null, null);
commit;
prompt 24 records loaded
prompt Loading CBT_USER...
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9003', 'test@shujiao.club', '15123456789', 'test', '123123', 'M', '0', 18, '山东济南', to_timestamp('15-02-2017 10:20:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('24-02-2017 10:03:33.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('10001', 'imtiger@shujiao.club', '15012345678', '丶风起', 's38626', 'M', '011201', 18, null, to_timestamp('23-02-2017 10:39:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 100, 'T', null, null);
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9001', 'mgr_tiger@shujiao.club', '15853107903', '管理虎', 's38626', 'M', '0', 22, '山东济南', to_timestamp('13-02-2017 10:01:23.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('03-05-2017 14:02:23.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9999', 'admin@shujiao.club', '13905312345', '超级管理员', 's38626', 'M', '020101', 18, '山东济南', to_timestamp('01-01-2017 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, to_timestamp('30-03-2017 17:09:22.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9004', 'test2@shujiao.club', '15012345679', 'test2', 'test22', 'F', '0', 18, '北京朝阳', to_timestamp('24-02-2017 10:05:43.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, null);
insert into CBT_USER (u_id, u_email, u_mobile, u_name, u_pw, u_sex, u_deptid, u_age, u_hometown, u_regtime, u_score, u_enable, u_note, u_lastupdate)
values ('9002', 'mgr_bunny@shujiao.club', '13181728270', '管理兔', '1234567abc', 'F', '0', 21, '山东济南', to_timestamp('14-02-2017 14:25:01.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 'T', null, null);
commit;
prompt 6 records loaded
prompt Loading CBT_BOOK...
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250015', '9787552010824', '19', '大雾霾', null, '[澳]彼得？布林布尔科姆 ', null, '上海社会科学院出版社', to_date('01-01-2016', 'dd-mm-yyyy'), '1', '1', 304, 'P', '1', 'N', 45, 0, to_timestamp('25-04-2017 14:47:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/dawumai.jpg', '自中世纪以来，伦敦城的空气就一直饱受煤烟污染。《大雾霾：中世纪以来的伦敦空气污染史》便讨论了中世纪以来伦敦的空气污染历史、公众对污染认识的变化以及污染治理的艰难历程。在17世纪初，伦敦便有了“雾都”的声誉。到了19世纪，雾甚至成了造访伦敦的游客们必看的“特色”景观。在1952年著名的大雾霾爆发之前，英国人已经认识到了烟雾对人的健康影响。而对污染的治理，却经历了一个漫长的过程。甚至直到现在，空气污染，严重的雾霾天气，仍然是现代社会亟待解决的问题。', null, 0, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250013', '9787508651880', '5', '创京东', null, '李志刚', null, '中信出版集团', to_date('01-06-2015', 'dd-mm-yyyy'), '1', '1', 292, 'P', '1', 'N', 49.8, 0, to_timestamp('25-04-2017 14:40:07.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/chuangjd.jpg', '5月22日，由中信出版集团出品的《创京东:刘强东亲述创业之路》一书开启预售，据悉，该书是京东和刘强东唯一授权的一本公司传记，由知名商业作家，资深媒体人李志刚历时一年，采访了258位相关人士后撰述成文，向读者展现了京东12年的成败得失与发展历程。该书不仅有刘强东亲自作序，更有周鸿祎、徐小平、徐新、张磊、吴晓波鼎力推荐，一份两万字的刘强东内部讲话更是在书中首次完整发布。', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250014', '9787802486942', '16', 'Android开发从入门到精通', null, '扶松柏', null, '北京希望电子出版社', to_date('01-01-2012', 'dd-mm-yyyy'), '1', '1', 541, 'P', '1', 'Y', 69, 29, to_timestamp('25-04-2017 14:42:13.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/androidrmjt.jpg', '《Android开发从入门到精通》系统讲解了Android软件开发的基础知识，图文并茂地帮助读者学习和掌握SDK、开发流程以及常用的API等。书中以讲述实战实例为导向，用一个个典型应用生动地引领读者进行项目开发实践。《Android开发从入门到精通》是一本内容翔实，理论实践紧密结合的教程。', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250016', '9787121193941', '16', '疯狂Ajax讲义', null, '李刚', null, '电子工业出版社', to_date('01-02-2013', 'dd-mm-yyyy'), '1', '1', 624, 'P', '3', 'Y', 79, 39, to_timestamp('25-04-2017 14:48:45.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('25-04-2017 14:49:59.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'Y', 'T', 'images/bookimage/ajax.jpg', '本书详细介绍了jQuery1.8、ExtJs4.1、Prototype1.7、DWR这4个最常用的Ajax框架的用法，并针对每个框架提供了一个实用案例，让读者理论联系实际。这部分内容是“疯狂软件教育中心”的标准讲义，它既包含了实际AjaX开发的重点和难点，也融人了大量学习者的学习经验和感悟。再由笔者以丰富的授课经验为基础，深入浅出地介绍它们，希望读者真正掌握Ajax开发的精髓。', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250019', '9787508630069', '8', '史蒂夫·乔布斯传', 'Steve Jobs:A Biography', '[美]沃尔特·艾萨克森', 'Walter Isaacson', '中信出版社', to_date('24-10-2011', 'dd-mm-yyyy'), '1', '1', 560, 'P', '1', 'Y', 68, 20, to_timestamp('25-04-2017 15:13:41.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/stevejobs.jpg', '《史蒂夫·乔布斯传》由著名作家沃尔特·艾萨克森在过去两年与乔布斯面对面交流40多次、对乔布斯100多位家庭成员、朋友、竞争对手和同事的采访的基础上撰写而成。艾萨克森是原《时代周刊》主编、CNN董事长兼首席执行官。撰写过爱因斯坦传记、基辛格传记、富兰克林传记等畅销书籍。', null, 4, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290005', '9787303103331', '5', '管理学概论', 'Introduction of Management', '张彩利', 'Caili Zhang', '北京师范大学出版社', to_date('01-04-2010', 'dd-mm-yyyy'), '1', '1', 100, 'P', '第三版', 'N', 32.8, 0, to_timestamp('29-03-2017 10:10:27.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/glxgl.jpg', '本书以适应高职高专教学改革需要、充分体现高职高专教材特色作为出发点和切入点，努力从内容和形式上有所突破或改进。在内容取舍上力求以实用性、系统性、针对性为原则，并注重知识的更新，尽可能将一些新的管理成果和我国的改革经验引入教材，同时注重知识的实用性，选择与学生成长及技能培养关系紧密的内容。在教材编写方式上，编者不但注重理论的陈述和介绍，还设置了足够的案例和案例分析，力求做到案例、讲解与思考的有机结合，充分地调动学生积极思考，培养学生的管理意识及思维能力，便于学生全面建立管理学的基本知识体系，系统掌握管理学的基本理论和方法。', null, 4, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703240001', '9787040389692', '1', '毛泽东思想和中国特色社会主义理论体系概论', 'Mao Zedong Thought and socialism with Chinese characteristics system info introduction', '本书编写组', null, '清华大学出版社', to_date('24-03-2017', 'dd-mm-yyyy'), '1', '1', 324, 'P', '2017年第1版', 'Y', 18, 9.9, to_timestamp('24-03-2017 19:05:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/mzd.jpg', '毛泽东思想和中国特色社会主义理论体系概论课程是一门思想政治理论课，其主要任务是帮助学生学习毛泽东思想和中国特色社会主义理论体系的基本内容，帮助学生理解毛泽东思想和中国特色社会主义理论体系是马克思主义的基本原理与中国实际相结合的两次伟大的理论成果，是中国共产党集体智慧的结晶。为了加强高等学校思想政治理论课教学，提高思想政治理论课教学针对性和实效性，我们组织编写了这本《毛泽东思想和中国特色社会主义理论体系概论》一书。本书在编写过程中着力贯彻党的十七大精神，结合学生在学习这门课时遇到的问题，进行重点阐述，增强了思想政治理论课的针对性和实用性。通过本书的学习，培养学生运用马克思主义的立场、观点和方法分析问题、解决问题的能力，增强贯彻党的基本理论、基本路线、基本纲领以及各项方针政策的自觉性、坚定性，积极投身到全面建设小康社会的伟大实践，是我们出版本书的目的。本教材在编写过程中，参阅了大量的教材、著作和文献，吸收、借鉴国内外很多专家学者的研究成果，得到经济科学出版社的理解和大力支持，在此表示诚挚的感谢。限于编者水平及编写时间，书中难免有不妥之处，敬请各位读者、专家批评指正。', null, 20, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290006', '9787040396638', '11', '高等数学', null, '同济大学数学系', null, '高等教育出版社', to_date('01-07-2014', 'dd-mm-yyyy'), '1', '1', 785, 'P', '第七版', 'Y', 74.4, 19.9, to_timestamp('29-03-2017 10:20:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'N', 'T', 'images/bookimage/gs.jpg', '本书是同济大学数学系编的《高等数学》第七版，从整体上说与第六版没有多大变化，内容深广度符合“工科类本科数学基础课程教学基本要求”，适合高等院校工科类各专业学生使用。' || chr(13) || '' || chr(10) || '本书分上下两册出版，上册包括函数与极限、导数与微分、微分中值定理与导数的应用、不定积分、定积分及其应用、微分方程等内容，书末还附有二阶和三阶行列式简介、基本初等函数的图形、几种常用的曲线、积分表、习题答案与提示；下册包括向量代数与空间解析几何、多元函数微分法及其应用、重积分、曲线积分与曲面积分、无穷级数等内容，书末还附有习题答案与提示。', null, 15, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201703290007', '9787302059325', '16', '人月神话', 'The Mythical Man-Month', '布鲁克斯', 'FrederickP.Brooks.Jr.', '清华大学出版社', to_date('01-11-2002', 'dd-mm-yyyy'), '2', '1', 369, 'P', '第一版', 'N', 29.8, 0, to_timestamp('29-03-2017 10:25:48.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('30-03-2017 15:34:55.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'N', 'T', 'images/bookimage/rysh.jpg', '《人月神话》内容源于作者Brooks在IBM公司任System计算机系列以及其庞大的软件系统OS项目经理时的实践经验。《人月神话》探索了达成一致性的困难和解决的方法，并探讨了软件工程管理的其他方面。在《人月神话（英文版）》中，既有很多发人深省的观点，又有大量软件工程的实践，为每个复杂项目的管理者给出了自己的真知灼见大型编程项目深受由于人力划分产生的管理问题的困扰，保持产品本身的概念完整性是一个至关重要的需求。《人月神话(英文版)》探索了达成一致性的困难和解决的方法，并探讨了软件工程管理的其他方面。《人月神话(英文版)》适合任何软件开发行业的从业人员阅读，对软件开发人员、软件项目经理、系统分析师更是必读之作。', null, 13, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250017', '9787544737951', '8', '绝望锻炼了我：朴槿惠自传', null, '[韩]朴槿惠', null, '译林出版社', to_date('01-05-2013', 'dd-mm-yyyy'), '1', '1', 313, 'P', '1', 'N', 35, 0, to_timestamp('25-04-2017 14:52:57.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/pjh.jpg', '本书为韩国首位女总统朴槿惠唯一亲笔自传。在书中，朴槿惠以最平实的笔触，娓娓道出她的过往人生，处处可见她对父母的追慕与怀念之情、对韩国人民怀抱的使命感，以及历经大起大落后的省思与坚韧。', null, 1, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250011', '9787115275790', '16', 'JavaScript高级程序设计', 'Professional JavaScript for Web Developers', '[美]扎卡斯', 'Nicholas C.Zakas', '人民邮电出版社', to_date('01-01-2006', 'dd-mm-yyyy'), '1', '1', 616, 'P', '1', 'Y', 99, 49, to_timestamp('25-04-2017 14:26:37.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/jshigh.jpg', '本书从最早期Netscape浏览器中的JavaScript开始讲起，直到当前它对XML和Web服务的具体支持，内容主要涉及JavaScript的语言特点、JavaScript与浏览器的交互、更高级的JavaScript技巧，以及与在Web应用程序中部署JavaScript解决方案有关的问题，如错误处理、调试、安全性、优化/混淆化、XML和Web服务，最后介绍应用所有这些知识来创建动态用户界面。本书适合有一定编程经验的开发人员阅读，也可作为高校相关专业课程的教材。', null, 6, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250012', '9787213052545', '6', '大数据时代', 'Big Data:A Revolution That Will Transform How We Live, Work, and Think', '[奥地利] 维克托·迈尔-舍恩伯格', null, '浙江人民出版社', to_date('01-01-2013', 'dd-mm-yyyy'), '1', '1', 240, 'P', '1', 'Y', 49.9, 29.9, to_timestamp('25-04-2017 14:36:30.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'N', 'T', 'images/bookimage/bigdata.jpg', '维克托·迈尔·舍恩伯格在书中前瞻性地指出，大数据带来的信息风暴正在变革我们的生活、工作和思维，大数据开启了一次重大的时代转型，并用三个部分讲述了大数据时代的思维变革、商业变革和管理变革。', null, 3, '9999');
insert into CBT_BOOK (book_id, book_isbn, book_type, book_name_ch, book_name_en, book_author_ch, book_author_en, book_press, book_pressdate, book_language, book_format, book_page, book_cover, book_version, book_issell, book_price, book_sellprice, book_addtime, book_lastmdf, book_isexist, book_enable, book_image, book_detail, book_note, book_click, book_seller)
values ('BOOK201704250018', '9787508610450', '8', '希拉里传：掌权美国的女人', 'A Woman In Charge', '吴韵汐', null, '中信出版社', to_date('11-01-2008', 'dd-mm-yyyy'), '1', '1', 300, 'P', '1', 'N', 48, 0, to_timestamp('25-04-2017 14:56:08.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'Y', 'T', 'images/bookimage/xll.jpg', '作为叱咤美国政坛三十余载的女人，希拉里担当过诸多角色： 名满华盛顿的金牌律师、特立独行的州长夫人、优雅坚韧的白宫女主人、行遍世界的铁腕国务卿、有希望的总统候选人…… 在不同的历史时刻，希拉里一如既往的长袖善舞，但真实的希拉里到底是怎样的？这些盛名背后希拉里背负了什么？ 透过本书，全面认识她，认识即将面对的未来世界格局。', null, 5, '9999');
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
values ('02', '天津', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0401', '重庆市', '04', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010104', '海淀区', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0301', '上海市', '03', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010101', '东城区', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010102', '西城区', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('04', '重庆', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0201', '天津市', '02', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0501', '济南市', '05', '书角网总部所在地');
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050101', '市中区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('01', '北京', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('03', '上海', '0', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0101', '北京市', '01', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('010103', '朝阳区', '0101', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050102', '历下区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050103', '天桥区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050104', '历城区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050105', '槐荫区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050106', '长清区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050107', '章丘区', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050108', '济阳县', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050109', '商河县', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050110', '平阴县', '0501', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0502', '青岛市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050201', '市北区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050202', '市南区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050203', '黄岛区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050204', '崂山区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050205', '李沧区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050206', '城阳区', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050207', '胶州市', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050208', '即墨市', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050209', '平度市', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('050210', '莱西市', '0502', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0503', '淄博市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0504', '泰安市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0505', '莱芜市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0506', '威海市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0507', '潍坊市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0508', '枣庄市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0509', '聊城市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0510', '东营市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0511', '烟台市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0512', '济宁市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0513', '日照市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0514', '滨州市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0515', '德州市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0516', '临沂市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('0517', '菏泽市', '05', null);
insert into CBT_ORG (org_id, org_name, org_parent, org_note)
values ('05', '山东省', '0', null);
commit;
prompt 51 records loaded
prompt Loading CBT_USERADR...
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201704250021', '10001', '沈先生', '18601012345', '01', '0101', '010103', '光华路32号', null, to_timestamp('25-04-2017 17:50:24.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'F');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('123123123123', '10001', '沈先生', '15812345678', '05', '0501', '050101', '南辛庄西路336号', '250022', to_timestamp('24-02-2017 10:39:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'T');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201703310001', '9999', '沈宏泰', '15853107903', '01', '0101', '010103', '国门大厦A101', null, to_timestamp('31-03-2017 11:49:03.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'F');
insert into CBT_USERADR (adr_id, adr_uid, adr_uname, adr_phone, adr_prov, adr_city, adr_dist, adr_address, adr_zipcode, adr_addtime, adr_lastmdf, adr_note, adr_enable, adr_default)
values ('ADR201703310011', '9999', '沈宏泰', '15853107903', '05', '0501', '050101', '南辛庄西路336号', null, to_timestamp('31-03-2017 16:29:34.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'T', 'T');
commit;
prompt 4 records loaded
prompt Loading CBT_EXPRESS...
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('sf', '顺丰速递', 'aaa', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('jd', '京东快递', 'bbb', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('sto', '申通速递', 'ccc', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('yto', '圆通速递', 'ddd', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('yunda', '韵达快递', 'eee', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('zto', '中通快递', 'fff', '123', null);
insert into CBT_EXPRESS (exp_id, exp_name, exp_linkman, exp_tel, exp_note)
values ('rfd', '如风达', 'ggg123', '13901012345', null);
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
values ('COM201704090003', 'ORD201704060011', 'C', to_timestamp('09-04-2017 14:12:21.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'G', '书很新，质量很好', 'T', null, '9999');
insert into CBT_COMMENT (com_id, com_ordid, com_source, com_time, com_type, com_comment, com_enable, com_note, com_userid)
values ('COM201704090004', 'ORD201704060011', 'S', to_timestamp('09-04-2017 14:26:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'G', '交易愉快', 'T', null, '9999');
commit;
prompt 2 records loaded
prompt Loading CBT_CORPORATION...
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('1', '京东叁佰陆拾度电子商务有限公司', '刘强东', '13901080123', '北京市海淀区苏州街72号北京经济技术开发区科创十四街', null, '京东');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('2', '浙江天猫网络有限公司', '张勇', '13901080456', '浙江省杭州市余杭区五常街道五常大道168号3号楼三层', null, '天猫');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('3', '北京当当网信息技术有限公司', '李国庆', '18612345678', '北京市东城区藏经馆胡同17号1幢一层', null, '当当');
insert into CBT_CORPORATION (corp_id, corp_name, corp_linkman, corp_tel, corp_address, corp_note, corp_shortname)
values ('4', '新华书店', '店长', '15812345678', '济南市市中区经十路', null, '新华书店');
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
values ('HELP201701110001', '示例帮助1', '9999', to_timestamp('11-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701120002', '示例帮助2', '9999', to_timestamp('12-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701130003', '示例帮助3', '9999', to_timestamp('13-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701140004', '示例帮助4', '9999', to_timestamp('14-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701150005', '示例帮助5', '9999', to_timestamp('15-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701160006', '示例帮助6', '9999', to_timestamp('16-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701170007', '示例帮助7', '9999', to_timestamp('17-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701180008', '示例帮助8', '9999', to_timestamp('18-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701190009', '示例帮助9', '9999', to_timestamp('19-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701200010', '示例帮助10', '9999', to_timestamp('20-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, 'jweifojgioewhiofejwi', null);
insert into CBT_HELP (help_id, help_title, help_author, help_addtime, help_mdfperson, help_lastmdf, help_content, help_note)
values ('HELP201701210011', '示例帮助11', '9999', to_timestamp('21-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '9999', to_timestamp('14-03-2017 17:49:20.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '123jweifojgioewhiofejwi', '123');
commit;
prompt 12 records loaded
prompt Loading CBT_NOTICE...
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701190012', '请妥善保管个人账号密码', 'A', '9999', to_timestamp('19-01-2017 13:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '请妥善保管个人账号密码！保证个人信息财产安全！', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140006', '万达集团发来贺电！', 'N', '9999', to_timestamp('14-01-2017 14:25:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312321132', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701150007', '1月15日系统维护公告', 'A', '9999', to_timestamp('15-01-2017 14:22:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312313', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701120001', '1月12日系统维护公告', 'A', '9999', to_timestamp('12-01-2017 14:16:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '12312313123', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701170010', '1月17日系统维护公告', 'A', '9999', to_timestamp('17-01-2017 14:15:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1231231', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701160009', '济南大学领导视察书角网运营中心', 'N', '9999', to_timestamp('16-01-2017 14:30:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '123213', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140005', '阿里巴巴集团发来贺电！', 'N', '9999', to_timestamp('14-01-2017 14:13:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '13123123131', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140004', '京东集团发来贺电！', 'N', '9999', to_timestamp('14-01-2017 14:11:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '123123', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701130002', '书角网即日起面向济南大学校内师生启动试运营', 'N', '9999', to_timestamp('13-01-2017 14:05:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '4567777', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701140003', '1月14日系统维护公告', 'A', '9999', to_timestamp('14-01-2017 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1234444', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701150008', '济南大学信息学院领导视察书角网运营中心', 'N', '9999', to_timestamp('15-01-2017 14:29:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '1232333', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201703090013', '3月9日系统维护公告', 'A', '9999', to_timestamp('09-03-2017 10:23:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '9999', to_timestamp('09-03-2017 11:52:48.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '　　尊敬的书角网用户，本站定于2017年3月9日晚23:00进行系统更新维护，预计持续1小时，届时请保存好个人数据，不要登录系统。' || chr(13) || '' || chr(10) || '　　由此给您带来的不便，敬请谅解！' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '                                                                                    书角网开发中心' || chr(13) || '' || chr(10) || '' || chr(13) || '' || chr(10) || '                                                                                     2017年3月9日', null);
insert into CBT_NOTICE (ntc_id, ntc_title, ntc_type, ntc_author, ntc_addtime, ntc_mdfperson, ntc_lastmdf, ntc_content, ntc_note)
values ('NTC201701190011', '书角网即将上线！', 'N', '9999', to_timestamp('19-01-2017 09:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null, '书角网即将上线！敬请期待', null);
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
values ('REC201703010000', '9787040377453', '1', '马克思主义基本原理概论(2013年修订版)', null, '本书编写组', null, '高等教育出版社', '1', 'images/bookimage/mks.jpg' || chr(10) || '', 21, 18, to_timestamp('20-03-2017 17:26:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('09-04-2017 22:01:45.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'https://item.jd.com/11431370.html', 3176, 1.5, 1000, 'T', null);
insert into CBT_RECOMMEND (rec_id, rec_isbn, rec_type, rec_name_ch, rec_name_en, rec_author_ch, rec_author_en, rec_press, rec_language, rec_image, rec_price, rec_sellprice, rec_addtime, rec_lastmdf, rec_corpid, rec_url, rec_click, rec_spprice, rec_paybalance, rec_enable, rec_note)
values ('REC201703170001', '9787302224464', '16', 'C程序设计（第四版）', 'C Programming Language(Version 4)', '谭浩强', 'Haoqiang Tan', '清华大学出版社', '1', 'images/bookimage/c.jpg', 39.8, 9.9, to_timestamp('17-03-2017 10:20:04.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), to_timestamp('09-04-2017 22:03:44.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'https://item.jd.com/11052214.html', 2105, 3, 1000, 'T', null);
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
