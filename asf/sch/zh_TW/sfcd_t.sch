/* 
================================================================================
檔案代號:sfcd_t
檔案名稱:工單製程check in/out項目資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfcd_t
(
sfcdent       number(5)      ,/* 企業編號 */
sfcdsite       varchar2(10)      ,/* 營運據點 */
sfcddocno       varchar2(20)      ,/* 單號 */
sfcd001       number(10,0)      ,/* RUN CARD */
sfcd002       number(10,0)      ,/* 項次 */
sfcd003       varchar2(10)      ,/* 項目 */
sfcd004       varchar2(1)      ,/* 型態 */
sfcd005       number(15,3)      ,/* 下限 */
sfcd006       number(15,3)      ,/* 上限 */
sfcd007       varchar2(80)      ,/* 預設值 */
sfcd008       varchar2(1)      ,/* 必要 */
sfcd009       varchar2(1)      ,/* check in/check out */
sfcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfcd_t add constraint sfcd_pk primary key (sfcdent,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd009) enable validate;

create unique index sfcd_pk on sfcd_t (sfcdent,sfcddocno,sfcd001,sfcd002,sfcd003,sfcd004,sfcd009);

grant select on sfcd_t to tiptop;
grant update on sfcd_t to tiptop;
grant delete on sfcd_t to tiptop;
grant insert on sfcd_t to tiptop;

exit;
