/* 
================================================================================
檔案代號:gldb_t
檔案名稱:合併組織結構單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldb_t
(
gldbent       number(5)      ,/* 企業代碼 */
gldbownid       varchar2(20)      ,/* 資料所有者 */
gldbowndp       varchar2(10)      ,/* 資料所屬部門 */
gldbcrtid       varchar2(20)      ,/* 資料建立者 */
gldbcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldbcrtdt       timestamp(0)      ,/* 資料創建日 */
gldbmodid       varchar2(20)      ,/* 資料修改者 */
gldbmoddt       timestamp(0)      ,/* 最近修改日 */
gldbstus       varchar2(10)      ,/* 狀態碼 */
gldbld       varchar2(5)      ,/* 合併帳別 */
gldb001       varchar2(10)      ,/* 上層公司 */
gldb002       varchar2(5)      ,/* 帳別 */
gldbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldb_t add constraint gldb_pk primary key (gldbent,gldbld,gldb001) enable validate;

create unique index gldb_pk on gldb_t (gldbent,gldbld,gldb001);

grant select on gldb_t to tiptop;
grant update on gldb_t to tiptop;
grant delete on gldb_t to tiptop;
grant insert on gldb_t to tiptop;

exit;
