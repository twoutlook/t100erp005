/* 
================================================================================
檔案代號:gzte_t
檔案名稱:模組流程文件管理表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table gzte_t
(
gzteownid       varchar2(20)      ,/* 資料所有者 */
gzteowndp       varchar2(10)      ,/* 資料所屬部門 */
gztecrtid       varchar2(20)      ,/* 資料建立者 */
gztecrtdp       varchar2(10)      ,/* 資料建立部門 */
gztecrtdt       timestamp(0)      ,/* 資料創建日 */
gztemodid       varchar2(20)      ,/* 資料修改者 */
gztemoddt       timestamp(0)      ,/* 最近修改日 */
gztestus       varchar2(10)      ,/* 狀態碼 */
gzte001       varchar2(10)      ,/* 流程編號 */
gzte002       varchar2(4)      ,/* 歸屬模組 */
gzte003       varchar2(20)      ,/* SOP 文件檔案編號 */
gzteud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzteud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzteud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzteud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzteud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzteud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzteud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzteud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzteud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzteud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzteud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzteud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzteud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzteud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzteud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzteud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzteud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzteud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzteud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzteud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzteud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzteud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzteud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzteud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzteud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzteud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzteud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzteud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzteud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzteud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzte004       varchar2(20)      /* 應用專題文件編號 */
);
alter table gzte_t add constraint gzte_pk primary key (gzte001) enable validate;

create unique index gzte_pk on gzte_t (gzte001);

grant select on gzte_t to tiptop;
grant update on gzte_t to tiptop;
grant delete on gzte_t to tiptop;
grant insert on gzte_t to tiptop;

exit;
