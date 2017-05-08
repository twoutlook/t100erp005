/* 
================================================================================
檔案代號:rmbd_t
檔案名稱:RMA報價单费用明細档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmbd_t
(
rmbdent       number(5)      ,/* 企業編號 */
rmbdsite       varchar2(10)      ,/* 營運據點 */
rmbddocno       varchar2(20)      ,/* 單據單號 */
rmbd000       number(10,0)      ,/* 版本 */
rmbdseq       number(10,0)      ,/* RMA項次 */
rmbdseq1       number(10,0)      ,/* 項序 */
rmbd001       varchar2(40)      ,/* 維修項目 */
rmbd002       number(20,6)      ,/* 數量 */
rmbd003       number(20,6)      ,/* 單價 */
rmbd004       number(20,6)      ,/* 未稅金額 */
rmbd005       number(20,6)      ,/* 含稅金額 */
rmbd006       number(20,6)      ,/* 稅額 */
rmbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rmbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rmbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rmbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rmbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rmbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rmbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rmbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rmbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rmbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rmbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rmbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rmbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rmbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rmbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rmbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rmbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rmbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rmbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rmbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rmbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rmbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rmbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rmbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rmbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rmbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rmbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rmbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rmbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rmbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rmbd_t add constraint rmbd_pk primary key (rmbdent,rmbddocno,rmbd000,rmbdseq,rmbdseq1) enable validate;

create unique index rmbd_pk on rmbd_t (rmbdent,rmbddocno,rmbd000,rmbdseq,rmbdseq1);

grant select on rmbd_t to tiptop;
grant update on rmbd_t to tiptop;
grant delete on rmbd_t to tiptop;
grant insert on rmbd_t to tiptop;

exit;
