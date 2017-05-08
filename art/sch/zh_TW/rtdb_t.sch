/* 
================================================================================
檔案代號:rtdb_t
檔案名稱:供應商生命週期表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdb_t
(
rtdbent       number(5)      ,/* 企業編號 */
rtdb001       varchar2(10)      ,/* 生命週期編號 */
rtdb002       number(5,0)      ,/* 生命週期順序 */
rtdb003       varchar2(20)      ,/* 程序編號 */
rtdbstus       varchar2(10)      ,/* 狀態 */
rtdbownid       varchar2(20)      ,/* 資料所有者 */
rtdbowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdbcrtid       varchar2(20)      ,/* 資料建立者 */
rtdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdbcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdbmodid       varchar2(20)      ,/* 資料修改者 */
rtdbmoddt       timestamp(0)      ,/* 最近修改日 */
rtdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdb_t add constraint rtdb_pk primary key (rtdbent,rtdb001,rtdb003) enable validate;

create unique index rtdb_pk on rtdb_t (rtdbent,rtdb001,rtdb003);

grant select on rtdb_t to tiptop;
grant update on rtdb_t to tiptop;
grant delete on rtdb_t to tiptop;
grant insert on rtdb_t to tiptop;

exit;
