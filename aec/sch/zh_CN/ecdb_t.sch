/* 
================================================================================
檔案代號:ecdb_t
檔案名稱:料件製程作業說明維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ecdb_t
(
ecdbent       number(5)      ,/* 企業編號 */
ecdbsite       varchar2(10)      ,/* 營運據點 */
ecdb001       varchar2(40)      ,/* 製程料號 */
ecdb002       varchar2(10)      ,/* 製程編號 */
ecdb003       number(10,0)      ,/* 製程項次 */
ecdb004       varchar2(10)      ,/* 作業編號 */
ecdb005       varchar2(10)      ,/* 作業序 */
ecdb006       varchar2(10)      ,/* 預設項目 */
ecdb007       varchar2(10)      ,/* 單位 */
ecdb008       number(20,6)      ,/* 下限 */
ecdb009       number(20,6)      ,/* 上限 */
ecdb010       number(20,6)      ,/* 預設值 */
ecdb011       varchar2(500)      ,/* 說明 */
ecdb012       varchar2(1)      ,/* 類型 */
ecdbownid       varchar2(20)      ,/* 資料所有者 */
ecdbowndp       varchar2(10)      ,/* 資料所屬部門 */
ecdbcrtid       varchar2(20)      ,/* 資料建立者 */
ecdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
ecdbcrtdt       timestamp(0)      ,/* 資料創建日 */
ecdbmodid       varchar2(20)      ,/* 資料修改者 */
ecdbmoddt       timestamp(0)      ,/* 最近修改日 */
ecdbstus       varchar2(10)      ,/* 狀態碼 */
ecdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecdb_t add constraint ecdb_pk primary key (ecdbent,ecdbsite,ecdb001,ecdb002,ecdb003,ecdb006) enable validate;

create unique index ecdb_pk on ecdb_t (ecdbent,ecdbsite,ecdb001,ecdb002,ecdb003,ecdb006);

grant select on ecdb_t to tiptop;
grant update on ecdb_t to tiptop;
grant delete on ecdb_t to tiptop;
grant insert on ecdb_t to tiptop;

exit;
