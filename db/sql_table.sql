-- Create table 1
create table CBT_USER
(
  u_id       VARCHAR2(36) primary key not null,
  u_email    VARCHAR2(36) not null,
  u_mobile   VARCHAR2(11) not null,
  u_name     VARCHAR2(24) not null,
  u_pw       VARCHAR2(16) not null,
  u_sex      VARCHAR2(1) not null,
  u_deptid   VARCHAR2(6) not null,
  u_age      NUMBER,
  u_hometown VARCHAR2(8),
  u_regtime  TIMESTAMP(6) not null,
  u_lastupdate  TIMESTAMP(6),
  u_score    NUMBER not null,
  u_enable   VARCHAR2(1) not null,
  u_note     VARCHAR2(255)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table CBT_USER
  add constraint CBT_USER_FK_DEPT foreign key (U_DEPTID)
  references CBT_DEPT (DEPT_ID);

-- Create table 2
create table CBT_ROLE
(
  R_ID	VARCHAR2(36) primary key not null,
  R_UID	VARCHAR2(36) not null,
  R_SIGN	VARCHAR2(1)
);
-- Create/Recreate primary, unique and foreign key constraints 
alter table CBT_ROLE
  add constraint CBT_ROLE_FK_USER foreign key (R_UID)
  references CBT_USER (U_ID);

-- Create table 3
create table CBT_DEPT
(
  DEPT_ID VARCHAR2(6) primary key not null,
  DEPT_NAME VARCHAR2(24) not null,
  DEPT_PARENT VARCHAR2(6) not null,
  DEPT_ADDRESS  VARCHAR2(255),
  DEPT_NOTE VARCHAR2(255)
)

-- Create table 4
create table CBT_USERADR
(
  ADR_ID  VARCHAR2(36) primary key not null,
  ADR_UID VARCHAR2(36) not null,
  ADR_UNAME VARCHAR2(24) not null, --收货人姓名
  ADR_PHONE VARCHAR2(11) not null,
  ADR_PROV  VARCHAR2(6) not null,
  ADR_CITY  VARCHAR2(6) not null,
  ADR_DIST  VARCHAR2(6) not null,
  ADR_ADDRESS VARCHAR2(255) not null,
  ADR_ZIPCODE VARCHAR2(6),
  ADR_ADDTIME TIMESTAMP not null,
  ADR_LASTMDF TIMESTAMP not null,
  ADR_ENABLE VARCHAR2(1) not null,
  ADR_DEFAULT VARCHAR2(1),
  ADR_NOTE  VARCHAR2(255)   
)
-- Create/Recreate primary, unique and foreign key constraints 
alter table CBT_USERADR
  add constraint CBT_USERADR_FK1 foreign key (ADR_UID)
  references cbt_user (U_ID);
alter table CBT_USERADR
  add constraint CBT_USERADR_FK2 foreign key (ADR_PROV)
  references cbt_org (ORG_ID);
alter table CBT_USERADR
  add constraint CBT_USERADR_FK3 foreign key (ADR_CITY)
  references cbt_org (ORG_ID);
alter table CBT_USERADR
  add constraint CBT_USERADR_FK4 foreign key (ADR_DIST)
  references cbt_org (ORG_ID);

-- Create table 5
create table CBT_ORG
(
  ORG_ID  VARCHAR2(6) primary key not null,
  ORG_NAME  VARCHAR2(24) not null,
  ORG_PARENT  VARCHAR2(6) not null,
  ORG_NOTE  VARCHAR2(255)
)

-- Create table 6
create table CBT_BOOK
(
  BOOK_ID VARCHAR2(36)  primary key not null,
  BOOK_ISBN VARCHAR2(13)  not null,
  BOOK_TYPE VARCHAR2(2)   not null,
  BOOK_NAME_CH  VARCHAR2(100)  not null,
  BOOK_NAME_EN  VARCHAR2(100),
  BOOK_AUTHOR_CH  VARCHAR2(36) not null,
  BOOK_AUTHOR_EN  VARCHAR2(36),
  BOOK_PRESS  VARCHAR2(36),
  BOOK_PRESSDATE  DATE,
  BOOK_LANGUAGE VARCHAR2(2) not null,
  BOOK_FORMAT VARCHAR2(2) not null,
  BOOK_PAGE NUMBER,
  BOOK_COVER  VARCHAR2(1),
  BOOK_VERSION  VARCHAR2(16),    
  BOOK_ISSELL VARCHAR2(1) not null,
  BOOK_PRICE  DECIMAL(6, 2) default 0.00,
  BOOK_SELLPRICE  DECIMAL(6, 2) default 0.00,   
  BOOK_ADDTIME  TIMESTAMP not null,
  BOOK_LASTMDF  TIMESTAMP,
  BOOK_ISEXIST  VARCHAR2(1) not null,
  BOOK_ENABLE VARCHAR2(1) not null,
  BOOK_IMAGE	VARCHAR2(255),
  BOOK_DETAIL	VARCHAR2(255),
  BOOK_CLICK  NUMBER default 0 not null,
  BOOK_NOTE VARCHAR2(255),
  BOOK_SELLER VARCHAR2(32) not null
)
-- Create/Recreate primary, unique and foreign key constraints 
alter table CBT_BOOK
  add constraint CBT_BOOK_FK_TYPE foreign key (BOOK_TYPE)
  references cbt_btype (TYP_ID);
alter table CBT_BOOK
  add constraint CBT_BOOK_FK_LANG foreign key (BOOK_LANGUAGE)
  references cbt_blang (LAN_ID);
alter table CBT_BOOK
  add constraint CBT_BOOK_FK_FORMAT foreign key (BOOK_FORMAT)
  references cbt_bfmt (FMT_ID);
alter table CBT_BOOK
  add constraint CBT_BOOK_FK_SELLER foreign key (BOOK_SELLER)
  references CBT_USER (U_ID);

-- Create table 7
create table CBT_BLANG
(
  LAN_ID  VARCHAR2(2) primary key not null,
  LAN_NAME  VARCHAR2(8) not null,
  LAN_NOTE  VARCHAR2(255)   
)

-- Create table 8
create table CBT_BFMT
(
  FMT_ID  VARCHAR2(2) primary key not null,
  FMT_NAME  VARCHAR2(8)   not null,
  FMT_NOTE  VARCHAR2(255)   
)

-- Create table 9
create table CBT_BTYPE
(
  typ_id   VARCHAR2(2) primary key not null,
  typ_name VARCHAR2(8) not null,
  typ_note VARCHAR2(255)
)

-- Create table 10
create table CBT_ORDER
(
  ORD_ID  VARCHAR2(36) primary key not null,
  ORD_BOOKID  VARCHAR2(36)  not null,
  ORD_SELLER  VARCHAR2(36)  not null,
  ORD_CUSTOMER  VARCHAR2(36)  not null,
  ORD_ADRID VARCHAR2(36),
  ORD_ORDTIME TIMESTAMP   not null,
  ORD_FINISHTIME  TIMESTAMP,
  ORD_ORDWAY  VARCHAR2(1),
  ORD_EXPCORP  VARCHAR2(2),
  ORD_EXPID VARCHAR2(24),
  ORD_SELCOM  VARCHAR2(1),   
  ORD_CUSCOM  VARCHAR2(1),  
  ORD_STATUS  VARCHAR2(2) not null,
  ORD_MSG VARCHAR2(255),
  ORD_NOTE  VARCHAR2(255)   
)
alter table CBT_ORDER
  add constraint CBT_ORDER_FK_BOOKID foreign key (ORD_BOOKID)
  references CBT_BOOK (BOOK_ID);
alter table CBT_ORDER
  add constraint CBT_ORDER_FK_SELLER foreign key (ORD_SELLER)
  references CBT_USER (U_ID);
alter table CBT_ORDER
  add constraint CBT_ORDER_FK_CUSTOMER foreign key (ORD_CUSTOMER)
  references CBT_USER (U_ID);
alter table CBT_ORDER
  add constraint CBT_ORDER_FK_ADR foreign key (ORD_ADRID)
  references CBT_USERADR (ADR_ID);
alter table CBT_ORDER
  add constraint ORDER_EXP foreign key (ORD_EXPCORP)
  references CBT_EXPRESS (EXP_ID);

-- Create table 11
create table CBT_COMMENT
(
  COM_ID  VARCHAR2(36)  primary key not null,
  COM_ORDID VARCHAR2(36)  not null,
  COM_SOURCE  VARCHAR2(1)  not null,
  COM_TIME  TIMESTAMP   not null,
  COM_TYPE  VARCHAR2(1)  not null,
  COM_COMMENT VARCHAR2(1000)   not null,
  COM_ENABLE  VARCHAR2(1) not null,
  COM_NOTE  VARCHAR2(255)   
)
alter table CBT_COMMENT
  add constraint CBT_COMMENT_FK_ORDER foreign key (COM_ORDID)
  references CBT_ORDER (ORD_ID);

-- Create table 13
create table CBT_CAROUSEL
(
  CSL_ID	VARCHAR2(2) primary key not null,
  CSL_TARGET VARCHAR2(36),
  CSL_TYPE VARCHAR2(1) default 'N' not null,
  CSL_SRC	VARCHAR2(255) not null,
  CSL_NOTE	VARCHAR2(255)
)

-- Create table 14
create table CBT_NOTICE
(
  NTC_ID  VARCHAR2(36) primary key not null,
  NTC_TITLE VARCHAR2(100) not null,
  NTC_TYPE  VARCHAR2(1) not null,
  NTC_AUTHOR  VARCHAR2(36) not null,
  NTC_ADDTIME TIMESTAMP not null,
  NTC_MDFPERSON VARCHAR2(36),
  NTC_LASTMDF TIMESTAMP,
  NTC_CONTENT VARCHAR2(1000) not null,
  NTC_NOTE  VARCHAR2(255)
)

-- Create table 15
create table CBT_POORPW
(
  PPW_ID  VARCHAR2(36)  primary key  not null,
  PPW_PW  VARCHAR2(16)  unique not null,
  PPW_ENABLE  VARCHAR2(1)   not null,
  PPW_NOTE  VARCHAR2(255)   
)

-- Create table 16
create table CBT_HELP
(
  HELP_ID VARCHAR2(36) primary key not null,
  HELP_TITLE  VARCHAR2(100) not null,
  HELP_AUTHOR VARCHAR2(36) not null,
  HELP_ADDTIME  TIMESTAMP not null,
  HELP_MDFPERSON  VARCHAR2(36),
  HELP_LASTMDF  TIMESTAMP,
  HELP_CONTENT  VARCHAR2(1000) not null,
  HELP_NOTE VARCHAR2(255)   
)

-- Create table 17
create table CBT_ADVICE
(
  ADV_ID  VARCHAR2(36)  primary key not null,
  ADV_TITLE  VARCHAR2(100) not null,
  ADV_CONTENT VARCHAR2(1000) not null,
  ADV_AUTHOR  VARCHAR2(36) not null,
  ADV_ADDTIME TIMESTAMP not null,
  ADV_REEXIST	VARCHAR(1) not null,
  ADV_REPLY VARCHAR2(1000),
  ADV_REAUTHOR  VARCHAR2(36),    
  ADV_RETIME  TIMESTAMP,
  ADV_NOTE  VARCHAR2(255)   
)

-- Create table 18
create table CBT_RECOMMEND
(
  REC_ID  VARCHAR2(36)  primary key not null, 
  REC_ISBN  VARCHAR2(13) not null,
  REC_TYPE  VARCHAR2(2)  not null,
  REC_NAME_CH VARCHAR2(100)   not null,
  REC_NAME_EN VARCHAR2(100),     
  REC_AUTHOR_CH VARCHAR2(36) not null,
  REC_AUTHOR_EN VARCHAR2(36),
  REC_PRESS VARCHAR2(36),
  REC_LANGUAGE  VARCHAR2(2) not null,
  REC_IMAGE VARCHAR2(255),
  REC_PRICE DECIMAL(6, 2)   not null,
  REC_SELLPRICE DECIMAL(6, 2)  not null,
  REC_ADDTIME TIMESTAMP   not null,
  REC_LASTMDF TIMESTAMP   not null,
  REC_CORPID VARCHAR2(4)  not null,
  REC_URL VARCHAR2(255)  not null,
  REC_CLICK NUMBER  default 0 not null,
  REC_SPPRICE DECIMAL(6, 2)  not null,
  REC_PAYBALANCE  NUMBER  default 1000 not null,
  REC_ENABLE  VARCHAR2(1) not null,
  REC_NOTE  VARCHAR2(255)
)
alter table CBT_RECOMMEND
  add constraint CBT_RECOMMEND_FK_TYPE foreign key (REC_TYPE)
  references cbt_btype (TYP_ID);
alter table CBT_RECOMMEND
  add constraint CBT_RECOMMEND_FK_LANG foreign key (REC_LANGUAGE)
  references cbt_blang (LAN_ID);
alter table CBT_RECOMMEND
  add constraint CBT_RECOMMEND_FK_CORPID foreign key (REC_CORPID)
  references CBT_CORPORATION (CORP_ID);
  
-- Create table 19
create table CBT_CORPORATION
(
  CORP_ID VARCHAR2(4) primary key not null, 
  CORP_NAME VARCHAR2(100)  not null, 
  CORP_LINKMAN  VARCHAR2(12)  not null, 
  CORP_TEL  VARCHAR2(11)    not null, 
  CORP_ADDRESS  VARCHAR2(255)  not null, 
  CORP_NOTE VARCHAR2(255)
)

--Create table 20
create table CBT_FAVORITE
(
  FAV_ID  VARCHAR2(36) primary key not null,
  FAV_BOOKID  VARCHAR2(36)  not null,
  FAV_USERID  VARCHAR2(36)  not null,
  FAV_ADDTIME TIMESTAMP   not null,
  FAV_ENABLE VARCHAR2(1) default 'T' not null,
  FAV_NOTE  VARCHAR2(255)   
)
alter table CBT_FAVORITE
  add constraint CBT_FAVORITE_FK_BOOKID foreign key (FAV_BOOKID)
  references CBT_BOOK (BOOK_ID);
alter table CBT_FAVORITE
  add constraint CBT_FAVORITE_FK_UID foreign key (FAV_USERID)
  references CBT_USER (U_ID);

--Create table 21
create table CBT_EXPRESS
(
	EXP_ID  VARCHAR2(8) primary key not null,
  EXP_NAME  VARCHAR2(100)   not null,
  EXP_LINKMAN VARCHAR2(12)  not null,
  EXP_TEL VARCHAR2(11)      not null,
  EXP_NOTE  VARCHAR2(255)
)
