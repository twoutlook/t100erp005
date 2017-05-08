/* 
================================================================================
檔案代號:loab_t
檔案名稱:相關文件資料庫儲存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table loab_t
(
loabent       number(5)      ,/* 企業編號 */
loab001       varchar2(500)      ,/* 單據組合Key */
loab002       varchar2(80)      ,/* 未使用屬性 */
loab003       varchar2(80)      ,/* 未使用屬性 */
loab004       varchar2(80)      ,/* 未使用屬性 */
loab005       varchar2(80)      ,/* 未使用屬性 */
loab006       number(5,0)      ,/* 文件版本 */
loab007       number(5,0)      ,/* 文件序號 */
loab008       blob      ,/* 文件檔案 */
loabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
loabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
loabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
loabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
loabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
loabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
loabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
loabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
loabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
loabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
loabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
loabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
loabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
loabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
loabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
loabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
loabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
loabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
loabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
loabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
loabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
loabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
loabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
loabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
loabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
loabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
loabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
loabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
loabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
loabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table loab_t add constraint loab_pk primary key (loabent,loab001,loab006,loab007) enable validate;

create unique index loab_pk on loab_t (loabent,loab001,loab006,loab007);

grant select on loab_t to tiptop;
grant update on loab_t to tiptop;
grant delete on loab_t to tiptop;
grant insert on loab_t to tiptop;

exit;
