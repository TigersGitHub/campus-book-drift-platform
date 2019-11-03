-- Create sequence 1
create sequence CBS_USER
minvalue 10001
maxvalue 999999999999
start with 10001
increment by 1
cache 10;

-- Create sequence 2
create sequence CBS_ADR
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;

-- Create sequence 3
create sequence CBS_BOOK
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;

-- Create sequence 4
create sequence CBS_BLANG
minvalue 1
maxvalue 99
start with 1
increment by 1
cache 10;

-- Create sequence 5
create sequence CBS_BFMT
minvalue 1
maxvalue 99
start with 1
increment by 1
cache 10;

-- Create sequence 6
create sequence CBS_BTYPE
minvalue 1
maxvalue 99
start with 1
increment by 1
cache 10;

-- Create sequence 7
create sequence CBS_ORDER
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;

-- Create sequence 8
create sequence CBS_COMMENT
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;

-- Create sequence 9
create sequence CBS_NOTICE
minvalue 1
maxvalue 9999
start with 14
increment by 1
cache 10
cycle;

-- Create sequence 10
create sequence CBS_HELP
minvalue 1
maxvalue 9999
start with 12
increment by 1
cache 10
cycle;

-- Create sequence 11
create sequence CBS_ADVICE
minvalue 1
maxvalue 9999
start with 5
increment by 1
cache 10
cycle;

-- Create sequence 12
create sequence CBS_EMP
minvalue 9001
maxvalue 9998
start with 9005
increment by 1
cache 10;

-- Create sequence 13
create sequence CBS_RECOMMEND
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;

-- Create sequence 14
create sequence CBS_CORPORATION
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10;

-- Create sequence 15
create sequence CBS_FAVORITE
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 10
cycle;
