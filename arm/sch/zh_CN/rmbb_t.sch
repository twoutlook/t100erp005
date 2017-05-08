/* 
================================================================================
檔案代號:rmbb_t
檔案名稱:RMA報價单单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmbb_t
(
rmbbent       number(5)      ,/* 企業編號 */
rmbbsite       varchar2(10)      ,/* 營運據點 */
rmbbdocno       varchar2(20)      ,/* 單據單號 */
rmbb000       number(10,0)      ,/* 版本 */
rmbbseq       number(10,0)      ,/* RMA項次 */
rmbb001       number(20,6)      ,/* 材料金額 */
rmbb002       number(20,6)      ,/* 費用金額 */
rmbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rmbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rmbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rmbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rmbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rmbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rmbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rmbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rmbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rmbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rmbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rmbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rmbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rmbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rmbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rmbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rmbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rmbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rmbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rmbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rmbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rmbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rmbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rmbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rmbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rmbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rmbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rmbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rmbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rmbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rmbb_t add constraint rmbb_pk primary key (rmbbent,rmbbdocno,rmbb000,rmbbseq) enable validate;

create unique index rmbb_pk on rmbb_t (rmbbent,rmbbdocno,rmbb000,rmbbseq);

grant select on rmbb_t to tiptop;
grant update on rmbb_t to tiptop;
grant delete on rmbb_t to tiptop;
grant insert on rmbb_t to tiptop;

exit;
