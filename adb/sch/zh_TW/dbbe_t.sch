/* 
================================================================================
檔案代號:dbbe_t
檔案名稱:庫存組織出貨範圍設定-銷售渠道範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbbe_t
(
dbbeent       number(5)      ,/* 企業編號 */
dbbesite       varchar2(10)      ,/* 營運據點 */
dbbe001       varchar2(10)      ,/* 庫位編號 */
dbbe002       varchar2(10)      ,/* 渠道編號 */
dbbeownid       varchar2(20)      ,/* 資料所有者 */
dbbeowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbecrtid       varchar2(20)      ,/* 資料建立者 */
dbbecrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbecrtdt       timestamp(0)      ,/* 資料創建日 */
dbbemodid       varchar2(20)      ,/* 資料修改者 */
dbbemoddt       timestamp(0)      ,/* 最近修改日 */
dbbestus       varchar2(10)      ,/* 狀態碼 */
dbbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbe_t add constraint dbbe_pk primary key (dbbeent,dbbesite,dbbe001,dbbe002) enable validate;

create unique index dbbe_pk on dbbe_t (dbbeent,dbbesite,dbbe001,dbbe002);

grant select on dbbe_t to tiptop;
grant update on dbbe_t to tiptop;
grant delete on dbbe_t to tiptop;
grant insert on dbbe_t to tiptop;

exit;
