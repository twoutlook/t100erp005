/* 
================================================================================
檔案代號:ooct_t
檔案名稱:國際標準單位換算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooct_t
(
ooctent       number(5)      ,/* 企業編號 */
ooct001       varchar2(10)      ,/* 來源單位 */
ooct002       number(20,6)      ,/* 來源數量 */
ooct003       varchar2(10)      ,/* 目的單位 */
ooct004       number(20,6)      ,/* 目的數量 */
ooctownid       varchar2(20)      ,/* 資料所有者 */
ooctowndp       varchar2(10)      ,/* 資料所屬部門 */
ooctcrtid       varchar2(20)      ,/* 資料建立者 */
ooctcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooctcrtdt       timestamp(0)      ,/* 資料創建日 */
ooctmodid       varchar2(20)      ,/* 資料修改者 */
ooctmoddt       timestamp(0)      ,/* 最近修改日 */
ooctstus       varchar2(10)      ,/* 狀態碼 */
ooctud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooctud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooctud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooctud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooctud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooctud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooctud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooctud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooctud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooctud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooctud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooctud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooctud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooctud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooctud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooctud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooctud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooctud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooctud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooctud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooctud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooctud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooctud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooctud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooctud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooctud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooctud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooctud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooctud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooctud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooct_t add constraint ooct_pk primary key (ooctent,ooct001,ooct003) enable validate;

create unique index ooct_pk on ooct_t (ooctent,ooct001,ooct003);

grant select on ooct_t to tiptop;
grant update on ooct_t to tiptop;
grant delete on ooct_t to tiptop;
grant insert on ooct_t to tiptop;

exit;
