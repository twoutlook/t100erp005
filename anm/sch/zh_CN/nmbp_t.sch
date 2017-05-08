/* 
================================================================================
檔案代號:nmbp_t
檔案名稱:內部資金排程項目利息資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbp_t
(
nmbpent       number(5)      ,/* 企業編碼 */
nmbpdocno       varchar2(20)      ,/* 利息單號 */
nmbpseq       number(10,0)      ,/* 利息項次 */
nmbpseq1       number(10,0)      ,/* 項次 */
nmbp001       varchar2(10)      ,/* 資金中心 */
nmbp002       number(5,0)      ,/* 年度 */
nmbp003       number(5,0)      ,/* 月份 */
nmbp004       varchar2(10)      ,/* 調度項目 */
nmbp005       varchar2(10)      ,/* 撥出/撥入單位內部帳戶 */
nmbp006       varchar2(10)      ,/* 撥入/撥出組織 */
nmbp007       varchar2(10)      ,/* 幣別 */
nmbp008       number(20,6)      ,/* 本金 */
nmbp009       number(10,6)      ,/* 年利率 */
nmbp010       date      ,/* 計息起始日 */
nmbp011       number(20,6)      ,/* 利息金額 */
nmbp012       varchar2(20)      ,/* 調撥單據 */
nmbp013       number(10,0)      ,/* 項次 */
nmbp014       number(5,0)      ,/* 日 */
nmbp015       varchar2(10)      ,/* 交易對象 */
nmbpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbp_t add constraint nmbp_pk primary key (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp014) enable validate;

create unique index nmbp_pk on nmbp_t (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp014);

grant select on nmbp_t to tiptop;
grant update on nmbp_t to tiptop;
grant delete on nmbp_t to tiptop;
grant insert on nmbp_t to tiptop;

exit;
