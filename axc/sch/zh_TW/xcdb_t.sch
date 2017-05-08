/* 
================================================================================
檔案代號:xcdb_t
檔案名稱:在製成本要素成本期初開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcdb_t
(
xcdbent       number(5)      ,/* 企業編號 */
xcdbld       varchar2(5)      ,/* 帳套 */
xcdbcomp       varchar2(10)      ,/* 法人組織 */
xcdb001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdb002       varchar2(30)      ,/* 成本域 */
xcdb003       varchar2(10)      ,/* 成本計算類型 */
xcdb004       number(5,0)      ,/* 年度 */
xcdb005       number(5,0)      ,/* 期別 */
xcdb006       varchar2(20)      ,/* 工單編號 */
xcdb007       varchar2(40)      ,/* 元件編號 */
xcdb008       varchar2(256)      ,/* 特性 */
xcdb009       varchar2(30)      ,/* 批號 */
xcdb010       varchar2(10)      ,/* 成本次要素 */
xcdb011       varchar2(1)      ,/* 元件類型 */
xcdb101       number(20,6)      ,/* 當月期末數量 */
xcdb102       number(20,6)      ,/* 當月期末金額-金額合計 */
xcdbownid       varchar2(20)      ,/* 資料所有者 */
xcdbowndp       varchar2(10)      ,/* 資料所屬部門 */
xcdbcrtid       varchar2(20)      ,/* 資料建立者 */
xcdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcdbcrtdt       timestamp(0)      ,/* 資料創建日 */
xcdbmodid       varchar2(20)      ,/* 資料修改者 */
xcdbmoddt       timestamp(0)      ,/* 最近修改日 */
xcdbcnfid       varchar2(20)      ,/* 資料確認者 */
xcdbcnfdt       timestamp(0)      ,/* 資料確認日 */
xcdbpstid       varchar2(20)      ,/* 資料過帳者 */
xcdbpstdt       timestamp(0)      ,/* 資料過帳日 */
xcdbstus       varchar2(10)      ,/* 狀態碼 */
xcdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdb_t add constraint xcdb_pk primary key (xcdbent,xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,xcdb008,xcdb009,xcdb010) enable validate;

create unique index xcdb_pk on xcdb_t (xcdbent,xcdbld,xcdb001,xcdb002,xcdb003,xcdb004,xcdb005,xcdb006,xcdb007,xcdb008,xcdb009,xcdb010);

grant select on xcdb_t to tiptop;
grant update on xcdb_t to tiptop;
grant delete on xcdb_t to tiptop;
grant insert on xcdb_t to tiptop;

exit;
