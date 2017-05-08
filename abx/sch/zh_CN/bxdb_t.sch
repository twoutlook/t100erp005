/* 
================================================================================
檔案代號:bxdb_t
檔案名稱:保稅機器設備單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxdb_t
(
bxdbent       number(5)      ,/* 企業編號 */
bxdbsite       varchar2(10)      ,/* 營運據點 */
bxdb001       varchar2(20)      ,/* 機器設備編號 */
bxdb002       varchar2(80)      ,/* 機器設備中文名稱 */
bxdb003       varchar2(80)      ,/* 機器設備英文名稱 */
bxdb004       varchar2(255)      ,/* 機器設備規格 */
bxdb005       varchar2(10)      ,/* 型態 */
bxdb006       varchar2(20)      ,/* 主件編號 */
bxdb007       varchar2(20)      ,/* 報單號碼 */
bxdb008       varchar2(10)      ,/* 單位 */
bxdb009       number(20,6)      ,/* 數量 */
bxdb010       number(20,6)      ,/* 稅捐計帳金額 */
bxdb011       varchar2(40)      ,/* 管理局核准文號 */
bxdb012       date      ,/* 放行日期 */
bxdb013       date      ,/* 記帳到期日 */
bxdb014       date      ,/* 稽核日期 */
bxdb015       varchar2(255)      ,/* 備註 */
bxdb016       number(20,6)      ,/* 帳面結餘數量 */
bxdbownid       varchar2(20)      ,/* 資料所有者 */
bxdbowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdbcrtid       varchar2(20)      ,/* 資料建立者 */
bxdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdbcrtdt       timestamp(0)      ,/* 資料創建日 */
bxdbmodid       varchar2(20)      ,/* 資料修改者 */
bxdbmoddt       timestamp(0)      ,/* 最近修改日 */
bxdbcnfid       varchar2(20)      ,/* 資料確認者 */
bxdbcnfdt       timestamp(0)      ,/* 資料確認日 */
bxdbstus       varchar2(10)      ,/* 狀態碼 */
bxdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxdb_t add constraint bxdb_pk primary key (bxdbent,bxdbsite,bxdb001) enable validate;

create unique index bxdb_pk on bxdb_t (bxdbent,bxdbsite,bxdb001);

grant select on bxdb_t to tiptop;
grant update on bxdb_t to tiptop;
grant delete on bxdb_t to tiptop;
grant insert on bxdb_t to tiptop;

exit;
