/* 
================================================================================
檔案代號:crdb_t
檔案名稱:會員價值規則設定維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table crdb_t
(
crdbent       number(5)      ,/* 企業編號 */
crdbstus       varchar2(1)      ,/* 狀態 */
crdb001       varchar2(10)      ,/* 會員價值編號 */
crdb002       varchar2(1)      ,/* R等級 */
crdb003       varchar2(1)      ,/* F等級 */
crdb004       varchar2(1)      ,/* M等級 */
crdb005       varchar2(3)      ,/* 等級標識 */
crdb006       varchar2(255)      ,/* 備註 */
crdbownid       varchar2(20)      ,/* 資料所有者 */
crdbowndp       varchar2(10)      ,/* 資料所屬部門 */
crdbcrtid       varchar2(20)      ,/* 資料建立者 */
crdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
crdbcrtdt       timestamp(0)      ,/* 資料創建日 */
crdbmodid       varchar2(20)      ,/* 資料修改者 */
crdbmoddt       timestamp(0)      ,/* 最近修改日 */
crdb007       number(15,3)      ,/* RFM得分 */
crdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crdb_t add constraint crdb_pk primary key (crdbent,crdb001,crdb002,crdb003,crdb004) enable validate;

create unique index crdb_pk on crdb_t (crdbent,crdb001,crdb002,crdb003,crdb004);

grant select on crdb_t to tiptop;
grant update on crdb_t to tiptop;
grant delete on crdb_t to tiptop;
grant insert on crdb_t to tiptop;

exit;
