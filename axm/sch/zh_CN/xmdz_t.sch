/* 
================================================================================
檔案代號:xmdz_t
檔案名稱:銷售合約累計定價明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table xmdz_t
(
xmdzent       number(5)      ,/* 企業編號 */
xmdzsite       varchar2(10)      ,/* 營運據點 */
xmdzdocno       varchar2(20)      ,/* 單號 */
xmdzseq       number(10,0)      ,/* 項次 */
xmdzseq1       number(10,0)      ,/* 項序 */
xmdz001       number(20,6)      ,/* 到達數量 */
xmdz002       number(20,6)      ,/* 單價 */
xmdz003       number(20,6)      ,/* 折扣率 */
xmdz004       date      ,/* 數量到達日期 */
xmdz005       varchar2(20)      ,/* 數量到達參考單號 */
xmdzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdz_t add constraint xmdz_pk primary key (xmdzent,xmdzdocno,xmdzseq,xmdzseq1) enable validate;

create unique index xmdz_pk on xmdz_t (xmdzent,xmdzdocno,xmdzseq,xmdzseq1);

grant select on xmdz_t to tiptop;
grant update on xmdz_t to tiptop;
grant delete on xmdz_t to tiptop;
grant insert on xmdz_t to tiptop;

exit;
