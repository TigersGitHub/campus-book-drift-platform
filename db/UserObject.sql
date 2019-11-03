------------------------------------------------
-- Export file for user SCOTT@CBDTS-DEV       --
-- Created by Fred Shen on 2017/6/1, 21:32:17 --
------------------------------------------------

set define off
spool UserObject.log

prompt
prompt Creating table CBT_ADVICE
prompt =========================
prompt
create table SCOTT.CBT_ADVICE
(
  adv_id       VARCHAR2(36) not null,
  adv_title    VARCHAR2(100) not null,
  adv_content  VARCHAR2(1000) not null,
  adv_author   VARCHAR2(36) not null,
  adv_addtime  TIMESTAMP(6) not null,
  adv_reply    VARCHAR2(1000),
  adv_reauthor VARCHAR2(36),
  adv_retime   TIMESTAMP(6),
  adv_note     VARCHAR2(255),
  adv_enable   VARCHAR2(1) default 'T' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_ADVICE
  add primary key (ADV_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_BFMT
prompt =======================
prompt
create table SCOTT.CBT_BFMT
(
  fmt_id   VARCHAR2(2) not null,
  fmt_name VARCHAR2(12) not null,
  fmt_note VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_BFMT
  add primary key (FMT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_BLANG
prompt ========================
prompt
create table SCOTT.CBT_BLANG
(
  lan_id   VARCHAR2(2) not null,
  lan_name VARCHAR2(12) not null,
  lan_note VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_BLANG
  add primary key (LAN_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_BTYPE
prompt ========================
prompt
create table SCOTT.CBT_BTYPE
(
  typ_id   VARCHAR2(2) not null,
  typ_name VARCHAR2(12) not null,
  typ_note VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_BTYPE
  add constraint CBT_BTYPE_PK primary key (TYP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_DEPT
prompt =======================
prompt
create table SCOTT.CBT_DEPT
(
  dept_id      VARCHAR2(6) not null,
  dept_name    VARCHAR2(36) not null,
  dept_parent  VARCHAR2(6) not null,
  dept_address VARCHAR2(255),
  dept_note    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_DEPT
  add primary key (DEPT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_USER
prompt =======================
prompt
create table SCOTT.CBT_USER
(
  u_id         VARCHAR2(36) not null,
  u_email      VARCHAR2(36) not null,
  u_mobile     VARCHAR2(11) not null,
  u_name       VARCHAR2(24) not null,
  u_pw         VARCHAR2(16) not null,
  u_sex        VARCHAR2(1) not null,
  u_deptid     VARCHAR2(6) not null,
  u_age        NUMBER,
  u_hometown   VARCHAR2(24),
  u_regtime    TIMESTAMP(6) not null,
  u_score      NUMBER not null,
  u_enable     VARCHAR2(1) not null,
  u_note       VARCHAR2(255),
  u_lastupdate TIMESTAMP(6)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index SCOTT.U_UNIQUE_EAM on SCOTT.CBT_USER (U_EMAIL, U_MOBILE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_USER
  add primary key (U_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_USER
  add constraint USER_DEPT foreign key (U_DEPTID)
  references SCOTT.CBT_DEPT (DEPT_ID);

prompt
prompt Creating table CBT_BOOK
prompt =======================
prompt
create table SCOTT.CBT_BOOK
(
  book_id        VARCHAR2(36) not null,
  book_isbn      VARCHAR2(13) not null,
  book_type      VARCHAR2(2) not null,
  book_name_ch   VARCHAR2(100) not null,
  book_name_en   VARCHAR2(200),
  book_author_ch VARCHAR2(36) not null,
  book_author_en VARCHAR2(36),
  book_press     VARCHAR2(36),
  book_pressdate DATE,
  book_language  VARCHAR2(2) not null,
  book_format    VARCHAR2(2) not null,
  book_page      NUMBER,
  book_cover     VARCHAR2(1),
  book_version   VARCHAR2(16),
  book_issell    VARCHAR2(1) not null,
  book_price     NUMBER(6,2) default 0.00,
  book_sellprice NUMBER(6,2) default 0.00,
  book_addtime   TIMESTAMP(6) not null,
  book_lastmdf   TIMESTAMP(6),
  book_isexist   VARCHAR2(1) not null,
  book_enable    VARCHAR2(1) not null,
  book_image     VARCHAR2(255),
  book_detail    VARCHAR2(1000),
  book_note      VARCHAR2(255),
  book_click     NUMBER default 0 not null,
  book_seller    VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SCOTT.CBT_BOOK.book_id
  is '图书编号';
comment on column SCOTT.CBT_BOOK.book_isbn
  is 'ISBN-13';
comment on column SCOTT.CBT_BOOK.book_type
  is '图书类别编号';
comment on column SCOTT.CBT_BOOK.book_name_ch
  is '图书题名-中文';
comment on column SCOTT.CBT_BOOK.book_name_en
  is '图书题名-英文';
comment on column SCOTT.CBT_BOOK.book_author_ch
  is '图书作者-中文';
comment on column SCOTT.CBT_BOOK.book_author_en
  is '图书作者-英文';
comment on column SCOTT.CBT_BOOK.book_press
  is '出版社';
comment on column SCOTT.CBT_BOOK.book_pressdate
  is '出版时间';
comment on column SCOTT.CBT_BOOK.book_language
  is '图书语种编号';
comment on column SCOTT.CBT_BOOK.book_format
  is '图书规格编号';
comment on column SCOTT.CBT_BOOK.book_page
  is '页数';
comment on column SCOTT.CBT_BOOK.book_cover
  is '包装方式 P:平装 R:精装';
comment on column SCOTT.CBT_BOOK.book_version
  is '版次';
comment on column SCOTT.CBT_BOOK.book_issell
  is '上架类型 Y:出售 N:非出售(漂流)';
comment on column SCOTT.CBT_BOOK.book_price
  is '定价';
comment on column SCOTT.CBT_BOOK.book_sellprice
  is '售价';
comment on column SCOTT.CBT_BOOK.book_addtime
  is '添加时间';
comment on column SCOTT.CBT_BOOK.book_lastmdf
  is '最后修改时间';
comment on column SCOTT.CBT_BOOK.book_isexist
  is '是否在售';
comment on column SCOTT.CBT_BOOK.book_enable
  is '是否可用';
comment on column SCOTT.CBT_BOOK.book_image
  is '封面图片路径';
comment on column SCOTT.CBT_BOOK.book_detail
  is '图书详情';
comment on column SCOTT.CBT_BOOK.book_note
  is '备注';
comment on column SCOTT.CBT_BOOK.book_click
  is '点击量';
comment on column SCOTT.CBT_BOOK.book_seller
  is '卖方ID';
alter table SCOTT.CBT_BOOK
  add primary key (BOOK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_BOOK
  add constraint BOOK_FORMAT foreign key (BOOK_FORMAT)
  references SCOTT.CBT_BFMT (FMT_ID);
alter table SCOTT.CBT_BOOK
  add constraint BOOK_LANG foreign key (BOOK_LANGUAGE)
  references SCOTT.CBT_BLANG (LAN_ID);
alter table SCOTT.CBT_BOOK
  add constraint BOOK_TYPE foreign key (BOOK_TYPE)
  references SCOTT.CBT_BTYPE (TYP_ID);
alter table SCOTT.CBT_BOOK
  add constraint BOOK_USER_S foreign key (BOOK_SELLER)
  references SCOTT.CBT_USER (U_ID);

prompt
prompt Creating table CBT_CAROUSEL
prompt ===========================
prompt
create table SCOTT.CBT_CAROUSEL
(
  csl_id     VARCHAR2(2) not null,
  csl_target VARCHAR2(36),
  csl_type   VARCHAR2(1) default 'N' not null,
  csl_src    VARCHAR2(255) not null,
  csl_note   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_CAROUSEL
  add primary key (CSL_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_ORG
prompt ======================
prompt
create table SCOTT.CBT_ORG
(
  org_id     VARCHAR2(6) not null,
  org_name   VARCHAR2(24) not null,
  org_parent VARCHAR2(6) not null,
  org_note   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_ORG
  add primary key (ORG_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_USERADR
prompt ==========================
prompt
create table SCOTT.CBT_USERADR
(
  adr_id      VARCHAR2(36) not null,
  adr_uid     VARCHAR2(36) not null,
  adr_uname   VARCHAR2(24) not null,
  adr_phone   VARCHAR2(11) not null,
  adr_prov    VARCHAR2(6) not null,
  adr_city    VARCHAR2(6) not null,
  adr_dist    VARCHAR2(6) not null,
  adr_address VARCHAR2(255) not null,
  adr_zipcode VARCHAR2(6),
  adr_addtime TIMESTAMP(6) not null,
  adr_lastmdf TIMESTAMP(6),
  adr_note    VARCHAR2(255),
  adr_enable  VARCHAR2(1) not null,
  adr_default VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_USERADR
  add primary key (ADR_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_USERADR
  add constraint ADR_CITY foreign key (ADR_CITY)
  references SCOTT.CBT_ORG (ORG_ID);
alter table SCOTT.CBT_USERADR
  add constraint ADR_DIST foreign key (ADR_DIST)
  references SCOTT.CBT_ORG (ORG_ID);
alter table SCOTT.CBT_USERADR
  add constraint ADR_PROV foreign key (ADR_PROV)
  references SCOTT.CBT_ORG (ORG_ID);
alter table SCOTT.CBT_USERADR
  add constraint ADR_USER foreign key (ADR_UID)
  references SCOTT.CBT_USER (U_ID);

prompt
prompt Creating table CBT_EXPRESS
prompt ==========================
prompt
create table SCOTT.CBT_EXPRESS
(
  exp_id      VARCHAR2(8) not null,
  exp_name    VARCHAR2(100) not null,
  exp_linkman VARCHAR2(12) not null,
  exp_tel     VARCHAR2(11) not null,
  exp_note    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_EXPRESS
  add primary key (EXP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_ORDER
prompt ========================
prompt
create table SCOTT.CBT_ORDER
(
  ord_id         VARCHAR2(36) not null,
  ord_bookid     VARCHAR2(36) not null,
  ord_seller     VARCHAR2(36) not null,
  ord_customer   VARCHAR2(36) not null,
  ord_adrid      VARCHAR2(36),
  ord_ordtime    TIMESTAMP(6) not null,
  ord_finishtime TIMESTAMP(6),
  ord_ordway     VARCHAR2(1),
  ord_expid      VARCHAR2(24),
  ord_selcom     VARCHAR2(1),
  ord_cuscom     VARCHAR2(1),
  ord_status     VARCHAR2(2) not null,
  ord_msg        VARCHAR2(255),
  ord_note       VARCHAR2(255),
  ord_expcorp    VARCHAR2(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SCOTT.CBT_ORDER.ord_id
  is '订单ID';
comment on column SCOTT.CBT_ORDER.ord_bookid
  is '购买图书ID';
comment on column SCOTT.CBT_ORDER.ord_seller
  is '售方ID';
comment on column SCOTT.CBT_ORDER.ord_customer
  is '购方ID';
comment on column SCOTT.CBT_ORDER.ord_adrid
  is '购方地址ID';
comment on column SCOTT.CBT_ORDER.ord_ordtime
  is '订单创建时间';
comment on column SCOTT.CBT_ORDER.ord_finishtime
  is '订单结束时间';
comment on column SCOTT.CBT_ORDER.ord_ordway
  is '交易方式 E:快递/F:面交';
comment on column SCOTT.CBT_ORDER.ord_expid
  is '快递单号';
comment on column SCOTT.CBT_ORDER.ord_selcom
  is '卖家评否';
comment on column SCOTT.CBT_ORDER.ord_cuscom
  is '买家评否';
comment on column SCOTT.CBT_ORDER.ord_status
  is '订单状态';
comment on column SCOTT.CBT_ORDER.ord_msg
  is '买家留言';
comment on column SCOTT.CBT_ORDER.ord_note
  is '备注';
comment on column SCOTT.CBT_ORDER.ord_expcorp
  is '快递公司';
alter table SCOTT.CBT_ORDER
  add primary key (ORD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_ORDER
  add constraint ORDER_ADR foreign key (ORD_ADRID)
  references SCOTT.CBT_USERADR (ADR_ID);
alter table SCOTT.CBT_ORDER
  add constraint ORDER_BOOK foreign key (ORD_BOOKID)
  references SCOTT.CBT_BOOK (BOOK_ID);
alter table SCOTT.CBT_ORDER
  add constraint ORDER_EXP foreign key (ORD_EXPCORP)
  references SCOTT.CBT_EXPRESS (EXP_ID);
alter table SCOTT.CBT_ORDER
  add constraint ORDER_USER_C foreign key (ORD_CUSTOMER)
  references SCOTT.CBT_USER (U_ID);
alter table SCOTT.CBT_ORDER
  add constraint ORDER_USER_S foreign key (ORD_SELLER)
  references SCOTT.CBT_USER (U_ID);

prompt
prompt Creating table CBT_COMMENT
prompt ==========================
prompt
create table SCOTT.CBT_COMMENT
(
  com_id      VARCHAR2(36) not null,
  com_ordid   VARCHAR2(36) not null,
  com_source  VARCHAR2(1) not null,
  com_time    TIMESTAMP(6) not null,
  com_type    VARCHAR2(1) not null,
  com_comment VARCHAR2(1000) not null,
  com_enable  VARCHAR2(1) not null,
  com_note    VARCHAR2(255),
  com_userid  VARCHAR2(36) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SCOTT.CBT_COMMENT.com_id
  is '评价ID';
comment on column SCOTT.CBT_COMMENT.com_ordid
  is '所属订单ID';
comment on column SCOTT.CBT_COMMENT.com_source
  is '评价方';
comment on column SCOTT.CBT_COMMENT.com_time
  is '评价时间';
comment on column SCOTT.CBT_COMMENT.com_type
  is '评价类别 好评/差评';
comment on column SCOTT.CBT_COMMENT.com_comment
  is '评价内容';
comment on column SCOTT.CBT_COMMENT.com_enable
  is '是否可用';
comment on column SCOTT.CBT_COMMENT.com_note
  is '备注';
comment on column SCOTT.CBT_COMMENT.com_userid
  is '评价人ID';
alter table SCOTT.CBT_COMMENT
  add primary key (COM_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_COMMENT
  add constraint COM_ORDER foreign key (COM_ORDID)
  references SCOTT.CBT_ORDER (ORD_ID);

prompt
prompt Creating table CBT_CORPORATION
prompt ==============================
prompt
create table SCOTT.CBT_CORPORATION
(
  corp_id        VARCHAR2(4) not null,
  corp_name      VARCHAR2(100) not null,
  corp_linkman   VARCHAR2(12) not null,
  corp_tel       VARCHAR2(11) not null,
  corp_address   VARCHAR2(255) not null,
  corp_note      VARCHAR2(255),
  corp_shortname VARCHAR2(8) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_CORPORATION
  add primary key (CORP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_FAVORITE
prompt ===========================
prompt
create table SCOTT.CBT_FAVORITE
(
  fav_id      VARCHAR2(36) not null,
  fav_bookid  VARCHAR2(36) not null,
  fav_userid  VARCHAR2(36) not null,
  fav_addtime TIMESTAMP(6) not null,
  fav_enable  VARCHAR2(1) default 'T' not null,
  fav_note    VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_FAVORITE
  add primary key (FAV_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_FAVORITE
  add constraint FAV_BOOK foreign key (FAV_BOOKID)
  references SCOTT.CBT_BOOK (BOOK_ID);
alter table SCOTT.CBT_FAVORITE
  add constraint FAV_USER foreign key (FAV_USERID)
  references SCOTT.CBT_USER (U_ID);

prompt
prompt Creating table CBT_HELP
prompt =======================
prompt
create table SCOTT.CBT_HELP
(
  help_id        VARCHAR2(36) not null,
  help_title     VARCHAR2(100) not null,
  help_author    VARCHAR2(36) not null,
  help_addtime   TIMESTAMP(6) not null,
  help_mdfperson VARCHAR2(36),
  help_lastmdf   TIMESTAMP(6),
  help_content   VARCHAR2(1000) not null,
  help_note      VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_HELP
  add primary key (HELP_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_NOTICE
prompt =========================
prompt
create table SCOTT.CBT_NOTICE
(
  ntc_id        VARCHAR2(36) not null,
  ntc_title     VARCHAR2(100) not null,
  ntc_type      VARCHAR2(1) not null,
  ntc_author    VARCHAR2(36) not null,
  ntc_addtime   TIMESTAMP(6) not null,
  ntc_mdfperson VARCHAR2(36),
  ntc_lastmdf   TIMESTAMP(6),
  ntc_content   VARCHAR2(1000) not null,
  ntc_note      VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_NOTICE
  add primary key (NTC_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_POORPW
prompt =========================
prompt
create table SCOTT.CBT_POORPW
(
  ppw_id     VARCHAR2(36) not null,
  ppw_pw     VARCHAR2(16) not null,
  ppw_enable VARCHAR2(1) not null,
  ppw_note   VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_POORPW
  add primary key (PPW_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_POORPW
  add unique (PPW_PW)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt
prompt Creating table CBT_RECOMMEND
prompt ============================
prompt
create table SCOTT.CBT_RECOMMEND
(
  rec_id         VARCHAR2(36) not null,
  rec_isbn       VARCHAR2(13) not null,
  rec_type       VARCHAR2(2) not null,
  rec_name_ch    VARCHAR2(100) not null,
  rec_name_en    VARCHAR2(100),
  rec_author_ch  VARCHAR2(36) not null,
  rec_author_en  VARCHAR2(36),
  rec_press      VARCHAR2(36),
  rec_language   VARCHAR2(2) not null,
  rec_image      VARCHAR2(255) not null,
  rec_price      NUMBER(6,2) not null,
  rec_sellprice  NUMBER(6,2) not null,
  rec_addtime    TIMESTAMP(6) not null,
  rec_lastmdf    TIMESTAMP(6),
  rec_corpid     VARCHAR2(4) not null,
  rec_url        VARCHAR2(255) not null,
  rec_click      NUMBER default 0 not null,
  rec_spprice    NUMBER(6,2) not null,
  rec_paybalance NUMBER default 1000 not null,
  rec_enable     VARCHAR2(1) not null,
  rec_note       VARCHAR2(255)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SCOTT.CBT_RECOMMEND.rec_id
  is '图书ID';
comment on column SCOTT.CBT_RECOMMEND.rec_isbn
  is 'ISBN-13';
comment on column SCOTT.CBT_RECOMMEND.rec_type
  is '图书类别';
comment on column SCOTT.CBT_RECOMMEND.rec_name_ch
  is '中文书名';
comment on column SCOTT.CBT_RECOMMEND.rec_name_en
  is '英文书名';
comment on column SCOTT.CBT_RECOMMEND.rec_author_ch
  is '中文作者';
comment on column SCOTT.CBT_RECOMMEND.rec_author_en
  is '英文作者';
comment on column SCOTT.CBT_RECOMMEND.rec_press
  is '出版社';
comment on column SCOTT.CBT_RECOMMEND.rec_language
  is '正文语种';
comment on column SCOTT.CBT_RECOMMEND.rec_image
  is '封照路径';
comment on column SCOTT.CBT_RECOMMEND.rec_price
  is '定价';
comment on column SCOTT.CBT_RECOMMEND.rec_sellprice
  is '售价';
comment on column SCOTT.CBT_RECOMMEND.rec_addtime
  is '添加时间';
comment on column SCOTT.CBT_RECOMMEND.rec_lastmdf
  is '修改时间';
comment on column SCOTT.CBT_RECOMMEND.rec_corpid
  is '厂商编号';
comment on column SCOTT.CBT_RECOMMEND.rec_url
  is '商品链接';
comment on column SCOTT.CBT_RECOMMEND.rec_click
  is '点击量';
comment on column SCOTT.CBT_RECOMMEND.rec_spprice
  is '推广单价';
comment on column SCOTT.CBT_RECOMMEND.rec_paybalance
  is '结算单位';
comment on column SCOTT.CBT_RECOMMEND.rec_enable
  is '图书状态';
comment on column SCOTT.CBT_RECOMMEND.rec_note
  is '备注';
alter table SCOTT.CBT_RECOMMEND
  add primary key (REC_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_RECOMMEND
  add constraint REC_CORP foreign key (REC_CORPID)
  references SCOTT.CBT_CORPORATION (CORP_ID);
alter table SCOTT.CBT_RECOMMEND
  add constraint REC_LANG foreign key (REC_LANGUAGE)
  references SCOTT.CBT_BLANG (LAN_ID);
alter table SCOTT.CBT_RECOMMEND
  add constraint REC_TYPE foreign key (REC_TYPE)
  references SCOTT.CBT_BTYPE (TYP_ID);

prompt
prompt Creating table CBT_ROLE
prompt =======================
prompt
create table SCOTT.CBT_ROLE
(
  r_id   VARCHAR2(36) not null,
  r_uid  VARCHAR2(36) not null,
  r_sign VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_ROLE
  add primary key (R_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SCOTT.CBT_ROLE
  add constraint ROLE_USER foreign key (R_UID)
  references SCOTT.CBT_USER (U_ID);

prompt
prompt Creating sequence CBS_ADR
prompt =========================
prompt
create sequence SCOTT.CBS_ADR
minvalue 1
maxvalue 9999
start with 31
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_ADVICE
prompt ============================
prompt
create sequence SCOTT.CBS_ADVICE
minvalue 1
maxvalue 9999
start with 5
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_BFMT
prompt ==========================
prompt
create sequence SCOTT.CBS_BFMT
minvalue 1
maxvalue 99
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_BLANG
prompt ===========================
prompt
create sequence SCOTT.CBS_BLANG
minvalue 1
maxvalue 99
start with 11
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_BOOK
prompt ==========================
prompt
create sequence SCOTT.CBS_BOOK
minvalue 1
maxvalue 9999
start with 21
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_BTYPE
prompt ===========================
prompt
create sequence SCOTT.CBS_BTYPE
minvalue 1
maxvalue 99
start with 23
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_COMMENT
prompt =============================
prompt
create sequence SCOTT.CBS_COMMENT
minvalue 1
maxvalue 9999
start with 11
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_CORPORATION
prompt =================================
prompt
create sequence SCOTT.CBS_CORPORATION
minvalue 1
maxvalue 9999
start with 21
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_EMP
prompt =========================
prompt
create sequence SCOTT.CBS_EMP
minvalue 9001
maxvalue 9998
start with 9005
increment by 1
cache 10;

prompt
prompt Creating sequence CBS_FAVORITE
prompt ==============================
prompt
create sequence SCOTT.CBS_FAVORITE
minvalue 1
maxvalue 9999
start with 21
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_HELP
prompt ==========================
prompt
create sequence SCOTT.CBS_HELP
minvalue 1
maxvalue 9999
start with 12
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_NOTICE
prompt ============================
prompt
create sequence SCOTT.CBS_NOTICE
minvalue 1
maxvalue 9999
start with 14
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_ORDER
prompt ===========================
prompt
create sequence SCOTT.CBS_ORDER
minvalue 1
maxvalue 9999
start with 31
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_RECOMMEND
prompt ===============================
prompt
create sequence SCOTT.CBS_RECOMMEND
minvalue 1
maxvalue 9999
start with 11
increment by 1
cache 10
cycle;

prompt
prompt Creating sequence CBS_USER
prompt ==========================
prompt
create sequence SCOTT.CBS_USER
minvalue 10001
maxvalue 999999999999
start with 10011
increment by 1
cache 10;


spool off
