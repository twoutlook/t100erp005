/* 
================================================================================
檔案代號:oocc_t
檔案名稱:單位換算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocc_t
(
ooccstus       varchar2(10)      ,/* 狀態碼 */
ooccent       number(5)      ,/* 企業編號 */
oocc001       varchar2(10)      ,/* 來源單位 */
oocc002       number(20,6)      ,/* 來源數量 */
oocc003       varchar2(10)      ,/* 目的單位 */
oocc004       number(20,6)      ,/* 目的數量 */
ooccownid       varchar2(20)      ,/* 資料所有者 */
ooccowndp       varchar2(10)      ,/* 資料所屬部門 */
oocccrtid       varchar2(20)      ,/* 資料建立者 */
oocccrtdp       varchar2(10)      ,/* 資料建立部門 */
oocccrtdt       timestamp(0)      ,/* 資料創建日 */
ooccmodid       varchar2(20)      ,/* 資料修改者 */
ooccmoddt       timestamp(0)      ,/* 最近修改日 */
ooccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocc_t add constraint oocc_pk primary key (ooccent,oocc001,oocc003) enable validate;

create unique index oocc_pk on oocc_t (ooccent,oocc001,oocc003);

grant select on oocc_t to tiptop;
grant update on oocc_t to tiptop;
grant delete on oocc_t to tiptop;
grant insert on oocc_t to tiptop;

exit;
