/* 
================================================================================
檔案代號:isab_t
檔案名稱:申報單位可申報其他稅種資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isab_t
(
isabent       number(5)      ,/* 企業編號 */
isab001       varchar2(10)      ,/* 申報單位代碼 */
isab002       varchar2(10)      ,/* 稅種代碼 */
isab003       varchar2(1)      ,/* 併增值稅申報否 */
isab004       varchar2(1)      ,/* 申報週期 */
isab005       number(5,0)      ,/* 申報年度 */
isab006       number(5,0)      ,/* 申報月份 */
isabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isab_t add constraint isab_pk primary key (isabent,isab001,isab002) enable validate;

create unique index isab_pk on isab_t (isabent,isab001,isab002);

grant select on isab_t to tiptop;
grant update on isab_t to tiptop;
grant delete on isab_t to tiptop;
grant insert on isab_t to tiptop;

exit;
