/* 
================================================================================
檔案代號:xcav_t
檔案名稱:成本次要素分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcav_t
(
xcavent       number(5)      ,/* 企業編號 */
xcavownid       varchar2(20)      ,/* 資料所有者 */
xcavowndp       varchar2(10)      ,/* 資料所屬部門 */
xcavcrtid       varchar2(20)      ,/* 資料建立者 */
xcavcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcavcrtdt       timestamp(0)      ,/* 資料創建日 */
xcavmodid       varchar2(20)      ,/* 資料修改者 */
xcavmoddt       timestamp(0)      ,/* 最近修改日 */
xcavstus       varchar2(10)      ,/* 狀態碼 */
xcav001       varchar2(10)      ,/* 成本次要素分類編號 */
xcavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcav_t add constraint xcav_pk primary key (xcavent,xcav001) enable validate;

create unique index xcav_pk on xcav_t (xcavent,xcav001);

grant select on xcav_t to tiptop;
grant update on xcav_t to tiptop;
grant delete on xcav_t to tiptop;
grant insert on xcav_t to tiptop;

exit;
