/* 
================================================================================
檔案代號:oofi_t
檔案名稱:自動編碼最大流水號紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofi_t
(
oofient       number(5)      ,/* 企業編號 */
oofi001       varchar2(10)      ,/* 編碼分類 */
oofi002       varchar2(40)      ,/* 流水號前編碼 */
oofi003       number(10,0)      ,/* 最大流水號 */
oofiownid       varchar2(20)      ,/* 資料所有者 */
oofiowndp       varchar2(10)      ,/* 資料所屬部門 */
ooficrtid       varchar2(20)      ,/* 資料建立者 */
ooficrtdp       varchar2(10)      ,/* 資料建立部門 */
ooficrtdt       timestamp(0)      ,/* 資料創建日 */
oofimodid       varchar2(20)      ,/* 資料修改者 */
oofimoddt       timestamp(0)      ,/* 最近修改日 */
oofistus       varchar2(10)      ,/* 狀態碼 */
oofiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofi_t add constraint oofi_pk primary key (oofient,oofi001,oofi002) enable validate;

create unique index oofi_pk on oofi_t (oofient,oofi001,oofi002);

grant select on oofi_t to tiptop;
grant update on oofi_t to tiptop;
grant delete on oofi_t to tiptop;
grant insert on oofi_t to tiptop;

exit;
