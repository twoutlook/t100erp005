/* 
================================================================================
檔案代號:xcbm_t
檔案名稱:成本勾稽核對項目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcbm_t
(
xcbment       number(5)      ,/* 企業編號 */
xcbmownid       varchar2(20)      ,/* 資料所有者 */
xcbmowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbmcrtid       varchar2(20)      ,/* 資料建立者 */
xcbmcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbmcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbmmodid       varchar2(20)      ,/* 資料修改者 */
xcbmmoddt       timestamp(0)      ,/* 最近修改日 */
xcbmstus       varchar2(10)      ,/* 狀態碼 */
xcbmld       varchar2(5)      ,/* 帳別 */
xcbm001       varchar2(10)      ,/* 核對項目 */
xcbm002       varchar2(20)      ,/* 子報表/程式編號 */
xcbm003       varchar2(80)      ,/* 備註 */
xcbm004       varchar2(1)      ,/* 選擇否 */
xcbm005       number(10,0)      ,/* 序號 */
xcbm006       varchar2(10)      ,/* 成本計算類型 */
xcbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbm_t add constraint xcbm_pk primary key (xcbment,xcbmld,xcbm001,xcbm005,xcbm006) enable validate;

create unique index xcbm_pk on xcbm_t (xcbment,xcbmld,xcbm001,xcbm005,xcbm006);

grant select on xcbm_t to tiptop;
grant update on xcbm_t to tiptop;
grant delete on xcbm_t to tiptop;
grant insert on xcbm_t to tiptop;

exit;
