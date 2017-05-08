/* 
================================================================================
檔案代號:nmas_t
檔案名稱:企业银行账户明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmas_t
(
nmasent       number(5)      ,/* 企业编号 */
nmas001       varchar2(10)      ,/* 账户编码 */
nmas002       varchar2(10)      ,/* 交易账户编码 */
nmas003       varchar2(10)      ,/* 交易币种 */
nmas004       varchar2(1)      ,/* POS帐户否 */
nmas005       varchar2(1)      ,/* 下传POS否 */
nmasud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
nmasud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
nmasud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
nmasud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
nmasud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
nmasud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
nmasud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
nmasud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
nmasud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
nmasud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
nmasud011       number(20,6)      ,/* 自定义栏位(数字)011 */
nmasud012       number(20,6)      ,/* 自定义栏位(数字)012 */
nmasud013       number(20,6)      ,/* 自定义栏位(数字)013 */
nmasud014       number(20,6)      ,/* 自定义栏位(数字)014 */
nmasud015       number(20,6)      ,/* 自定义栏位(数字)015 */
nmasud016       number(20,6)      ,/* 自定义栏位(数字)016 */
nmasud017       number(20,6)      ,/* 自定义栏位(数字)017 */
nmasud018       number(20,6)      ,/* 自定义栏位(数字)018 */
nmasud019       number(20,6)      ,/* 自定义栏位(数字)019 */
nmasud020       number(20,6)      ,/* 自定义栏位(数字)020 */
nmasud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
nmasud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
nmasud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
nmasud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
nmasud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
nmasud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
nmasud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
nmasud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
nmasud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
nmasud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table nmas_t add constraint nmas_pk primary key (nmasent,nmas001,nmas002) enable validate;

create unique index nmas_pk on nmas_t (nmasent,nmas001,nmas002);

grant select on nmas_t to tiptop;
grant update on nmas_t to tiptop;
grant delete on nmas_t to tiptop;
grant insert on nmas_t to tiptop;

exit;
