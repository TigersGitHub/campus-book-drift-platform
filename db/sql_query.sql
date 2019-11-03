--新闻公告最新6条标题加载
select NTC_ID, NTC_TYPE, NTC_TITLE from (
    select NTC_ID, NTC_TYPE, NTC_TITLE from CBT_NOTICE n order by NTC_ADDTIME desc
) where rownum <= 6;

--新闻公告列表按时间倒序分页查询
select NTC_ID, NTC_TYPE, NTC_TITLE, to_char(NTC_ADDTIME, 'yyyy-mm-dd') as ADDTIME from (
    select NTC_ID, NTC_TYPE, NTC_TITLE, NTC_ADDTIME, rownum from (
        select NTC_ID, NTC_TYPE, NTC_TITLE, NTC_ADDTIME from CBT_NOTICE n 
        --where NTC_TYPE = 'A'
        order by NTC_ADDTIME desc
    ) where rownum <= 10
    minus
    select NTC_ID, NTC_TYPE, NTC_TITLE, NTC_ADDTIME, rownum from (
        select NTC_ID, NTC_TYPE, NTC_TITLE, NTC_ADDTIME from CBT_NOTICE n 
        --where NTC_TYPE = 'A'
        order by NTC_ADDTIME desc
    ) where rownum <= 0
) order by NTC_ADDTIME desc

--新闻公告列表按时间倒序分页查询(2017-3-10改进版)
select a2.* from (select a1.*, rownum rn from (
       select NTC_ID, NTC_TYPE, NTC_TITLE, to_char(NTC_ADDTIME, 'yyyy-mm-dd') as ADDTIME
       from CBT_NOTICE n --where NTC_TYPE = 'A'
       order by NTC_ADDTIME desc
) a1) a2 where rn <= 20 and rn > 10

--新闻公告页数
select ceil(count(NTC_ID)/10) as TOTALPAGE from CBT_NOTICE --where NTC_TYPE = 'A'

--帮助列表按时间倒序分页查询
select HELP_ID, HELP_TITLE, to_char(HELP_ADDTIME, 'yyyy-mm-dd') as ADDTIME from (
    select HELP_ID, HELP_TITLE, HELP_ADDTIME, rownum from (
        select HELP_ID, HELP_TITLE, HELP_ADDTIME from CBT_HELP n 
        order by HELP_ADDTIME desc
    ) where rownum <= 20
    minus
    select HELP_ID, HELP_TITLE, HELP_ADDTIME, rownum from (
        select HELP_ID, HELP_TITLE, HELP_ADDTIME from CBT_HELP n 
        order by HELP_ADDTIME desc
    ) where rownum <= 10
) order by HELP_ADDTIME desc

--帮助列表按时间倒序分页查询(2017-3-10改进版)
select a2.* from (select a1.*, rownum rn from (
       select HELP_ID, HELP_TITLE, to_char(HELP_ADDTIME, 'yyyy-mm-dd') as ADDTIME 
       from CBT_HELP n order by HELP_ADDTIME desc
) a1) a2 where rn <= 20 and rn > 10

--帮助页数
select ceil(count(HELP_ID)/10) as TOTALPAGE from CBT_HELP

--帮助内容
select n.HELP_TITLE, u.U_NAME as AUTHOR, to_char(n.HELP_ADDTIME, 'yyyy-mm-dd hh24:mi:ss') as ADDTIME, n.HELP_CONTENT
from CBT_HELP n inner join CBT_USER u on n.HELP_AUTHOR = u.U_ID where HELP_ID = 'test1'

--建议列表按时间倒序分页查询
select ADV_ID, ADV_TITLE, to_char(ADV_ADDTIME, 'yyyy-mm-dd') as ADDTIME from (
    select ADV_ID, ADV_TITLE, ADV_ADDTIME, rownum from (
        select ADV_ID, ADV_TITLE, ADV_ADDTIME from CBT_ADVICE n 
        order by ADV_ADDTIME desc
    ) where rownum <= 10
    minus
    select ADV_ID, ADV_TITLE, ADV_ADDTIME, rownum from (
        select ADV_ID, ADV_TITLE, ADV_ADDTIME from CBT_ADVICE n 
        order by ADV_ADDTIME desc
    ) where rownum <= 0
) order by ADV_ADDTIME desc

--建议列表按时间倒序分页查询(2017-3-10改进版)
select a2.* from (select a1.*, rownum rn from (
       select ADV_ID, ADV_TITLE, to_char(ADV_ADDTIME, 'yyyy-mm-dd') as ADDTIME
       from CBT_ADVICE n order by ADV_ADDTIME desc
) a1) a2 where rn <= 10 and rn > 0

--建议页数
select ceil(count(ADV_ID)/10) as TOTALPAGE from CBT_ADVICE

--建议内容
select n.ADV_ID, n.ADV_TITLE, u.U_NAME as AUTHOR, to_char(n.ADV_ADDTIME, 'yyyy-mm-dd hh24:mi:ss') as ADDTIME, n.ADV_CONTENT, n.ADV_REAUTHOR from CBT_ADVICE n inner join CBT_USER u on n.ADV_AUTHOR = u.U_ID 
where n.ADV_ID = 'test3'

--建议回复
select u.U_NAME as REAUTHOR, to_char(n.ADV_RETIME, 'yyyy-mm-dd hh24:mi:ss') as RETIME, n.ADV_REPLY as REPLY from CBT_ADVICE n inner join CBT_USER u on n.ADV_REAUTHOR = u.U_ID where n.ADV_ID = 'test3'
