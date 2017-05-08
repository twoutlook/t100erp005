/* 
================================================================================
檔案代號:gzdb_t
檔案名稱:支援資料庫設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzdb_t
(
gzdbstus       varchar2(10)      ,/* 狀態碼 */
gzdb001       varchar2(10)      ,/* 資料庫廠牌編號 */
gzdb002       varchar2(20)      ,/* 資料庫廠牌名稱 */
gzdb003       varchar2(10)      ,/* 資料庫支援版本編號 */
gzdb004       varchar2(80)      ,/* 資料庫支援版本名稱 */
gzdbownid       varchar2(20)      ,/* 資料所有者 */
gzdbowndp       varchar2(10)      ,/* 資料所屬部門 */
gzdbcrtid       varchar2(20)      ,/* 資料建立者 */
gzdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzdbcrtdt       timestamp(0)      ,/* 資料創建日 */
gzdbmodid       varchar2(20)      ,/* 資料修改者 */
gzdbmoddt       timestamp(0)      ,/* 最近修改日 */
gzdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzdb_t add constraint gzdb_pk primary key (gzdb001,gzdb003) enable validate;

create unique index gzdb_pk on gzdb_t (gzdb001,gzdb003);

grant select on gzdb_t to tiptop;
grant update on gzdb_t to tiptop;
grant delete on gzdb_t to tiptop;
grant insert on gzdb_t to tiptop;

exit;
