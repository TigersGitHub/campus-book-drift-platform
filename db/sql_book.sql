--�Ƽ�ͼ���ҳ��ѯ
select a2.* from (select a1.*, rownum rn from (
SELECT REC_ID, substr(REC_ISBN, 1, 3)||'-'||substr(REC_ISBN, 4, 1)||'-'||substr(REC_ISBN, 5, 3)||'-'||substr(REC_ISBN, 8, 5)||'-'||substr(REC_ISBN, 13, 1) as REC_ISBN, t.typ_name as REC_TYPE, REC_NAME_CH, REC_AUTHOR_CH, cp.corp_name as REC_CORPNAME, REC_CLICK, to_char(REC_SPPRICE*(REC_CLICK/REC_PAYBALANCE), '0.00') as REC_TOTALPRICE, REC_ENABLE FROM CBT_RECOMMEND INNER JOIN CBT_BTYPE t on t.typ_id = rec_type INNER JOIN CBT_CORPORATION cp on cp.corp_id = REC_CORPID order by REC_TOTALPRICE desc
) a1) a2 where rn <= 10 and rn > 0

--�Ƽ�ͼ������
INSERT INTO CBT_RECOMMEND VALUES ('id', 'isbn', 'type', 'namech', 'nameen', 'auch', 'auen', 'press', 'lan', 'image', 'price', 'sellprice', to_date('2017-01-01 12:00:00', 'yyyy-mm-dd hh24:mi:ss'), '', 'corp', 'url', '0', 'spprice', 'paybal', 'T', 'note');

--�Ƽ�ͼ��༭����
SELECT REC_ISBN, REC_TYPE, REC_NAME_CH, REC_NAME_EN, REC_AUTHOR_CH, REC_AUTHOR_EN, REC_PRESS, REC_LANGUAGE, REC_IMAGE, REC_PRICE, REC_SELLPRICE, REC_CORPID, REC_URL, REC_SPPRICE, REC_PAYBALANCE, REC_NOTE FROM CBT_RECOMMEND WHERE REC_ID = 'REC201703170001'

--�Ƽ�ͼ��༭�ύ
UPDATE CBT_RECOMMEND SET REC_ISBN = '9787040377453', REC_TYPE = '1', REC_NAME_CH = '', REC_NAME_EN = '', REC_AUTHOR_CH = '', REC_AUTHOR_EN = '', REC_PRESS = '', REC_LANGUAGE = '', REC_PRICE = '', REC_SELLPRICE = '', REC_CORPID = '', REC_URL = '', REC_SPPRICE = '', REC_PAYBALANCE = '', REC_NOTE = '', REC_LASTMDF = to_date('', 'yyyy-mm-dd hh24:mi:ss') WHERE REC_ID = ''

--�Ƽ�ͼ�����
UPDATE CBT_RECOMMEND SET REC_ENABLE = 'F' WHERE REC_ID = ''

--�Ƽ�ͼ������
UPDATE CBT_RECOMMEND SET REC_ENABLE = 'T' WHERE REC_ID = ''

--ͼ������ҳ��ѯ
select a2.* from (select a1.*, rownum rn from (
SELECT b.BOOK_ID, substr(b.book_isbn, 1, 3)||'-'||substr(b.book_isbn, 4, 1)||'-'||substr(b.book_isbn, 5, 3)||'-'||substr(b.book_isbn, 8, 5)||'-'||substr(b.book_isbn, 13, 1) as BOOK_ISBN, t.typ_name as book_type, b.book_name_ch, decode(b.book_issell, 'Y', '���ֽ���', 'N', 'ͼ��Ư��') as BOOK_ISSELL, b.book_sellprice, decode(b.book_isexist, 'Y', '����', 'N', '�۳�') as BOOK_ISEXIST, o.ord_status, b.book_enable FROM CBT_BOOK b left outer join CBT_ORDER o ON o.ord_bookid = b.book_id INNER JOIN CBT_BTYPE t on t.typ_id = b.book_type WHERE 1=1 order by b.book_addtime desc
) a1) a2 where rn <= 10 and rn > 0

--ͼ���������
SELECT b.book_isbn, t.typ_name as book_type, b.book_name_ch, b.book_name_en, b.book_author_ch, b.book_author_en, b.book_press, to_char(b.book_pressdate, 'yyyy-mm-dd') as book_pressdate, l.lan_name as book_language,  f.fmt_name as BOOK_FORMAT, b.book_page, decode(b.book_cover, 'P', 'ƽװ', 'R', '��װ') as BOOK_COVER, b.book_version, decode(b.book_issell, 'Y', '���ֽ���', 'N', 'ͼ��Ư��') as book_issell, b.book_price, b.book_sellprice, decode(b.book_isexist, 'Y', '����', 'N', '�۳�') as book_isexist, b.book_image, b.book_detail, b.book_note FROM CBT_BOOK b INNER JOIN CBT_BTYPE t on t.typ_id = b.book_type INNER JOIN CBT_BLANG l on l.lan_id = b.book_language INNER JOIN CBT_BFMT f on f.fmt_id = b.book_format WHERE BOOK_ID = 'B201703240001'

--��ҳͼ�������ϼܣ�8չλ��
select a2.* from (select a1.*, rownum rn from (
SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL, fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '' WHERE b.book_enable = 'T' ORDER BY BOOK_ADDTIME DESC
) a1) a2 where rn <= 8

--��ҳͼ�����Ŷ��֣�4չλ��
select a2.* from (select a1.*, rownum rn from (
SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '' WHERE b.book_enable = 'T' and b.book_issell = 'Y' ORDER BY BOOK_ADDTIME DESC
) a1) a2 where rn <= 4

--��ҳͼ������Ư����4չλ��
select a2.* from (select a1.*, rownum rn from (
SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '' WHERE b.book_enable = 'T' and b.book_issell = 'N' ORDER BY BOOK_ADDTIME DESC
) a1) a2 where rn <= 4

--��ҳ�����Ƽ���4չλ��
select a2.* from (select a1.*, rownum rn from (
SELECT r.rec_id, r.rec_name_ch, r.rec_press, r.rec_image, r.rec_price, r.rec_sellprice FROM CBT_RECOMMEND r WHERE r.rec_enable = 'T' ORDER BY REC_CLICK DESC
) a1) a2 where rn <= 4

--��ӵ��ղؼ�
INSERT INTO CBT_FAVORITE values ('id', 'bid', 'uid', to_date('', 'yyyy-mm-dd hh24:mi:ss'), 'T', '')

--��ȡ�ղؼ�ID
select CBS_FAVORITE.Nextval from dual

--ͳ�Ƹ��˶���
SELECT '1' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '' and ord_status = '1' union SELECT '3' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '' and ord_status = '3' union SELECT '4' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '' and ord_status = '4'

--ͼ���ҳ����
select a2.* from (select a1.*, rownum rn from (
SELECT BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL, fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id WHERE b.book_enable = 'T' ORDER BY BOOK_ADDTIME DESC
) a1) a2 where rn <= 10 and rn > 0

--�Ƽ�ͼ���ҳ����
select a2.* from (select a1.*, rownum rn from (
SELECT REC_ID, REC_NAME_CH, REC_PRESS, REC_IMAGE, REC_PRICE, REC_SELLPRICE FROM CBT_RECOMMEND WHERE REC_ENABLE = 'T' ORDER BY REC_CLICK DESC
) a1) a2 where rn <= 10 and rn > 0

--�ղؼ�ͼ���ҳ����
SELECT ceil(count(FAV_ID)/10) as TOTALPAGE FROM CBT_FAVORITE INNER JOIN CBT_BOOK ON BOOK_ID = FAV_BOOKID WHERE FAV_USERID = '9999' and FAV_ENABLE = 'T' and BOOK_NAME_CH like '%ë��%' and BOOK_ISSELL = 'Y' and BOOK_TYPE = '1'

--�ղؼз�ҳ����
select a2.* from (select a1.*, rownum rn from (
SELECT FAV_ID, BOOK_ID, BOOK_NAME_CH, BOOK_PRESS, BOOK_IMAGE, BOOK_PRICE, BOOK_SELLPRICE, BOOK_ISSELL FROM CBT_BOOK b INNER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id WHERE b.book_enable = 'T' and fav.fav_enable = 'T' and fav.fav_userid = '9999' ORDER BY fav.fav_addtime DESC
) a1) a2 where rn <= 10 and rn > 0

--ȡ���ղ�
DELETE FROM CBT_FAVORITE WHERE FAV_ID = '' and FAV_USERID = ''

--��������ͳ�ƶ������ղؼ�����
SELECT 'CURRENT' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '9999' and ord_status in ('1','2','3','4') union SELECT 'ALL' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_ORDER WHERE ord_customer = '9999' union SELECT 'FAVORITE' as STATUS, COUNT(*) as ORDCOUNT FROM CBT_FAVORITE WHERE FAV_USERID = '9999'

--��ͨ������ת���ӵ����
UPDATE CBT_BOOK b SET b.book_click = b.book_click + 1 WHERE b.book_id = 'B201703240001'

--�Ƽ�ͼ����ת���ӵ����
UPDATE CBT_RECOMMEND r SET r.rec_click = r.rec_click + 1 WHERE r.rec_id = '1'
SELECT r.rec_url FROM CBT_RECOMMEND r WHERE r.rec_id = '1'

--ͼ���������
SELECT b.BOOK_ID, b.BOOK_ISBN, t.typ_name as BOOK_TYPE, b.book_name_ch, b.book_name_en, b.book_author_ch, b.book_author_en, b.book_press, to_char(b.book_pressdate, 'yyyy-mm-dd') as book_pressdate, l.lan_name as book_language, f.fmt_name as book_format, b.book_page, decode(b.book_cover, 'P', 'ƽװ', 'R', '��װ') as BOOK_COVER, b.book_version, b.book_issell, b.book_price, b.book_sellprice, b.book_isexist, b.book_image, b.book_detail, b.book_note, b.book_click, fav.fav_enable as FAVORITE FROM CBT_BOOK b LEFT OUTER JOIN CBT_BTYPE t ON t.typ_id = b.book_type LEFT OUTER JOIN CBT_BLANG l ON l.lan_id = b.book_language LEFT OUTER JOIN CBT_BFMT f ON f.fmt_id = b.book_format LEFT OUTER JOIN CBT_FAVORITE fav on fav.fav_bookid = b.book_id and fav.fav_userid = '9999' WHERE b.BOOK_ID = 'BOOK201703290007' and b.book_enable = 'T'

--������ǰ3λ�Ƽ�ͼ��
select a2.* from (select a1.*, rownum rn from (
SELECT r.rec_id, r.rec_name_ch, r.rec_press, r.rec_image, r.rec_price, r.rec_sellprice FROM CBT_RECOMMEND r WHERE REC_TYPE = (SELECT BOOK_TYPE FROM CBT_BOOK WHERE BOOK_ID = 'B201703240001') and r.rec_enable = 'T' ORDER BY REC_CLICK DESC
) a1) a2 where rn <= 3

--���ͼ��
SELECT trim(to_char(CBS_BOOK.NEXTVAL, '0000')) as BOOKID FROM DUAL
INSERT INTO CBT_BOOK values (CBS_BOOK.NEXTVAL, 'isbn', 'type', 'name_ch', 'name_en', 'authch', 'authen', 'press', to_date('pressdate', 'yyyy-mm-dd'), 'lan', 'fmt', page, 'cover', 'version', 'issell', 'price', 'sp', to_date('', 'yyyy-mm-dd hh24:mi:ss'), '', 'Y', 'T', '', 'detail', '', 0, 'seller')

--�ѷ����б��ҳ���
SELECT ceil(count(BOOK_ID)/10) as TOTALPAGE FROM CBT_BOOK b WHERE b.book_seller = '9999'

--�ѷ����б����
select a2.* from (select a1.*, rownum rn from (
SELECT BOOK_ID, substr(BOOK_NAME_CH, 0, 6) AS BOOK_NAME_CH, length(BOOK_NAME_CH) AS BOOK_NAME_LEN, substr(BOOK_DETAIL, 0, 46) AS BOOK_DETAIL, length(BOOK_DETAIL) AS BOOK_DETAIL_LEN, BOOK_SELLPRICE, BOOK_IMAGE, BOOK_ISSELL, BOOK_ISEXIST, BOOK_ENABLE FROM CBT_BOOK WHERE book_seller = '9999' and book_enable = 'T' ORDER BY BOOK_ADDTIME desc
) a1) a2 where rn <= 8 and rn > 0

--�ѷ����༭�ύ
UPDATE CBT_BOOK b SET b.book_isbn = '', b.book_type = '', b.book_name_ch = '', b.book_name_en = '', b.book_author_ch = '', b.book_author_en = '', b.book_press = '', b.book_pressdate = to_date('', 'yyyy-mm-dd'), b.book_language = '', b.book_format = '', b.book_page = '', b.book_cover = '', b.book_version = '', b.book_issell = '', b.book_price = '', b.book_sellprice = '', b.book_lastmdf = to_date('', 'yyyy-mm-dd hh24:mi:ss'), b.book_detail = '' WHERE b.book_id = ''

--��������Ԥ����
SELECT u.u_id, u.u_email, u.u_mobile, u.u_name, u.u_sex, d1.dept_name as u_dept1, d2.dept_name as u_dept2, d3.dept_name as u_dept3, u.u_age, u.u_hometown, r.r_sign as u_role FROM CBT_USER u 
LEFT OUTER JOIN CBT_ROLE r ON r.r_uid = u.u_id and r.r_sign = 'U' 
LEFT OUTER JOIN CBT_DEPT d1 ON d1.dept_id = substr(u.u_deptid, 0, 2) and r.r_sign = 'U' 
LEFT OUTER JOIN CBT_DEPT d2 ON d2.dept_id = substr(u.u_deptid, 0, 4) and r.r_sign = 'U' 
LEFT OUTER JOIN CBT_DEPT d3 ON d3.dept_id = substr(u.u_deptid, 0, 6) and r.r_sign = 'U' 
WHERE u.u_id = '9999'

--���������޸�
UPDATE CBT_USER u set u.u_name = '', u.u_email = '', u.u_mobile = '', u.u_sex = '', u.u_age = '', u.u_hometown = '', u.u_lastupdate = to_date('', 'yyyy-mm-dd hh24:mi:ss') WHERE u.u_id = ''

--�ջ���ַ����
SELECT ADR_UNAME, ADR_PHONE, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, o3.org_name as ADR_DIST, ADR_ADDRESS, ADR_ZIPCODE FROM CBT_USERADR LEFT OUTER JOIN CBT_ORG o1 on o1.org_id = ADR_PROV LEFT OUTER JOIN CBT_ORG o2 on o2.org_id = ADR_CITY LEFT OUTER JOIN CBT_ORG o3 on o3.org_id = ADR_DIST WHERE ADR_UID = '10001' and ADR_ENABLE = 'T' ORDER BY ADR_ADDTIME desc 

--�ջ���ַ����
SELECT COUNT(*) AS ADRCOUNT FROM CBT_USERADR WHERE ADR_UID = '9999' and ADR_ENABLE = 'T'

--��ӵ�ַ
SELECT trim(to_char(CBS_ADR.NEXTVAL, '0000')) as ADRID FROM DUAL
INSERT INTO CBT_USERADR VALUES ('ADR'+CBS_ADR.NEXTVAL, '9999', '������', '10086', '01', '0101', '010101', 'luxxxhao', '100011', to_date('addtime', 'yyyy-mm-dd hh24:mi:ss'), '', '', 'T', 'F')

--ɾ����ַ
UPDATE CBT_USERADR SET ADR_ENABLE = 'F' WHERE ADR_ID = ''

--��ַ�༭����
SELECT ADR_UNAME, ADR_PHONE, ADR_PROV, ADR_CITY, ADR_DIST, ADR_ADDRESS, ADR_ZIPCODE FROM CBT_USERADR WHERE ADR_ID = ''

--��ַ�༭�ύ
UPDATE CBT_USERADR SET ADR_U_NAME = '', ADR_PHONE = '', ADR_PROV = '', ADR_CITY = '', ADR_DIST = '', ADR_ADDRESS = '', ADR_ZIPCODE = '', ADR_LASTMDF = '' WHERE ADR_ID = ''

--����Ĭ�ϵ�ַ
UPDATE CBT_USERADR SET ADR_DEFAULT = 'F' WHERE ADR_UID = '9999'
UPDATE CBT_USERADR SET ADR_DEFAULT = 'T' WHERE ADR_ID = 'ADR201703310001'

--��ȡĬ�ϵ�ַ
SELECT ADR_ID FROM CBT_USERADR WHERE ADR_UID = '9999' and ADR_DEFAULT = 'T'

--�µ�ǰ����
SELECT a.adr_uname, a.adr_phone, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, o3.org_name as ADR_DIST, a.adr_address, a.adr_zipcode, b.book_isbn, b.book_name_ch, b.book_name_en, b.book_author_ch, b.book_author_en, b.book_press, b.book_cover, b.book_version, b.book_sellprice, b.book_isexist, b.book_enable, b.book_image, b.book_seller FROM CBT_BOOK b, CBT_USERADR a LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist WHERE b.BOOK_ID = 'BOOK201703290006' and a.adr_uid = '9999' and a.adr_default = 'T' and a.adr_enable = 'T'

--�����ջ���ַ
SELECT a.adr_id, a.adr_default, a.adr_uname, a.adr_phone, o1.org_name as ADR_PROV, o2.org_name as ADR_CITY, o3.org_name as ADR_DIST, a.adr_address, a.adr_zipcode FROM CBT_USERADR a LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist WHERE a.adr_uid = '9999'

--�µ�
UPDATE CBT_BOOK SET BOOK_ISEXIST = 'F' WHERE BOOK_ID = ''
INSERT INTO CBT_ORDER VALUES ('ORD'+CBS_ORDER.Nextval, 'bookid', (SELECT book_seller FROM CBT_BOOK WHERE book_id = 'bookid'), 'customer', 'adrid', to_date('ordtime', 'yyyy-mm-dd hh24:mi:ss'), '', 'way', 'expid', 'F', 'F', '1', 'msg', '', 'expcorp')

--�����տ���Ϣ
SELECT ORD_ID, BOOK_NAME_CH AS ORD_BOOKNAME, BOOK_SELLPRICE AS ORD_PRICE FROM CBT_ORDER INNER JOIN CBT_BOOK ON BOOK_ID = ORD_BOOKID WHERE ORD_ID = ''

--����״̬���Ѹ���
UPDATE CBT_ORDER o SET o.ord_status = '2' WHERE o.ord_id = ''

--δ��ɶ����������
SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi:ss') as ORD_TIME, b.book_sellprice as ORD_PRICE, a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) as ORD_ADDRESS, '��'||b.book_name_ch||'��'||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') as ORD_STATUSNAME
FROM CBT_ORDER o 
INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid 
INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid 
LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov 
LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city 
LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist
WHERE o.ord_status = '2' and o.ord_customer = '9999'
ORDER BY o.ord_ordtime desc

--�����б�
select a2.* from (select a1.*, rownum rn from (
SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi:ss') as ORD_TIME, b.book_sellprice as ORD_PRICE, a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) as ORD_ADDRESS, '��'||b.book_name_ch||'��'||b.book_author_ch||' ��' as ORD_TITLE, o.ord_status, decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') as ORD_STATUSNAME
FROM CBT_ORDER o 
INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid 
INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid 
LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov 
LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city 
LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist
ORDER BY o.ord_ordtime desc
) a1) a2 where rn <= 10 and rn > 0

--ȡ���µ�
UPDATE CBT_ORDER o SET o.ord_status = '6', o.ord_finishtime = to_date('finishtime', 'yyyy-mm-dd hh24:mi:ss') WHERE o.ORD_ID = '' and o.ord_customer = ''
UPDATE CBT_BOOK SET BOOK_ISEXIST = 'Y' WHERE BOOK_ID = (SELECT o.ord_bookid FROM CBT_ORDER o WHERE o.ord_id = 'ORD201704070012')

--��������
SELECT o.ord_id, to_char(o.ord_ordtime, 'yyyy-mm-dd hh24:mi:ss') as ORD_TIME, b.book_sellprice as ORD_PRICE, a.adr_uname as ORD_NAME, a.adr_phone as ORD_TEL, (o1.org_name||o2.org_name||o3.org_name||a.adr_address) as ORD_ADDRESS, a.adr_zipcode as ORD_ZIPCODE, b.book_name_ch||'��'||b.book_version||'��'||b.book_author_ch||' �� '||b.book_press as ORD_TITLE, o.ord_status, decode(o.ord_status, '1', '������', '2', '������', '3', '���ջ�', '4', '������', '5', '�����', '6', '�ѹر�') as ORD_STATUSNAME, decode(o.ord_ordway, 'E', '��ݽ���', 'F', '���潻��') as ORD_ORDWAY, o.ord_msg, o.ord_expid, o.ord_expcorp, o.ord_seller, u.u_name as ORD_SELLERNAME, o.ord_selcom, o.ord_cuscom 
FROM CBT_ORDER o 
INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid 
INNER JOIN CBT_USERADR a ON a.adr_id = o.ord_adrid 
INNER JOIN CBT_USER u ON u.u_id = o.ord_seller
LEFT OUTER JOIN CBT_ORG o1 ON o1.org_id = a.adr_prov 
LEFT OUTER JOIN CBT_ORG o2 ON o2.org_id = a.adr_city 
LEFT OUTER JOIN CBT_ORG o3 ON o3.org_id = a.adr_dist
WHERE ORD_ID = 'ORD201704070014'

--����ɶ���ҳ��
SELECT ceil(count(o.ORD_ID)/10) as TOTALPAGE FROM CBT_ORDER o INNER JOIN CBT_BOOK b ON b.book_id = o.ord_bookid WHERE o.ord_customer = '9999' and o.ord_status in ('5', '6')
and ORD_ORDTIME >= to_date('2017-04-07 00:00:00', 'yyyy-mm-dd hh24:mi:ss')

--�����б�(����Ϊ����ʱ��ҵ����� union ����Ϊ���ʱ���ҵ�����)
SELECT c.com_id, o.ord_id as com_order, b.book_id as com_book, to_char(c.com_time, 'yyyy-mm-dd hh24:mi') as com_time, c.com_userid, u.u_name as com_username, decode(c.com_type, 'G', '����', 'B', '����') as com_type, c.com_comment, b.book_name_ch||' '||b.book_author_ch||' �� '||b.book_press as com_bookinfo FROM CBT_COMMENT c INNER JOIN CBT_ORDER o ON o.ord_id = c.com_ordid INNER JOIN CBT_BOOK b on o.ord_bookid = b.book_id INNER JOIN CBT_USER u ON u.u_id = c.com_userid WHERE (c.com_source = 'C' and o.ord_seller = '9999') or (c.com_source = 'S' and o.ord_customer = '9999') and COM_ENABLE = 'T' and o.ord_status = '5' ORDER BY COM_TIME desc

--�����б��ҳ
SELECT ceil(count(COM_ID)/10) as TOTALPAGE FROM CBT_COMMENT c INNER JOIN CBT_ORDER o ON o.ord_id = c.com_ordid WHERE (c.com_source = 'C' and o.ord_seller = '9999') or (c.com_source = 'S' and o.ord_customer = '9999') and COM_ENABLE = 'T' and o.ord_status = '5'
