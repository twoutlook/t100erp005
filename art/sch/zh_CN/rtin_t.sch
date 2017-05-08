/* 
================================================================================
檔案代號:rtin_t
檔案名稱:銷售多庫儲批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtin_t
(
rtinent       number(5)      ,/* 企業編號 */
rtinsite       varchar2(10)      ,/* 營運據點 */
rtindocno       varchar2(20)      ,/* 出貨單號 */
rtinseq       number(10,0)      ,/* 項次 */
rtinseq1       number(10,0)      ,/* 項序 */
rtin001       varchar2(40)      ,/* 料件編號 */
rtin002       varchar2(256)      ,/* 產品特徵 */
rtin003       varchar2(10)      ,/* 作業編號 */
rtin004       varchar2(10)      ,/* 作業序 */
rtin005       varchar2(10)      ,/* 限定庫位 */
rtin006       varchar2(10)      ,/* 限定儲位 */
rtin007       varchar2(30)      ,/* 限定批號 */
rtin008       varchar2(10)      ,/* 單位 */
rtin009       number(20,6)      ,/* 出貨數量 */
rtin010       varchar2(30)      ,/* 庫存管理特徵 */
rtinud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtinud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtinud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtinud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtinud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtinud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtinud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtinud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtinud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtinud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtinud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtinud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtinud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtinud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtinud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtinud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtinud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtinud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtinud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtinud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtinud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtinud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtinud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtinud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtinud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtinud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtinud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtinud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtinud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtinud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtin_t add constraint rtin_pk primary key (rtinent,rtindocno,rtinseq,rtinseq1) enable validate;

create unique index rtin_pk on rtin_t (rtinent,rtindocno,rtinseq,rtinseq1);

grant select on rtin_t to tiptop;
grant update on rtin_t to tiptop;
grant delete on rtin_t to tiptop;
grant insert on rtin_t to tiptop;

exit;
