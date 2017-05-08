/* 
================================================================================
檔案代號:stdb_t
檔案名稱:內部結算參數設定資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stdb_t
(
stdbent       number(5)      ,/* 企業編號 */
stdb001       varchar2(10)      ,/* 流程代碼 */
stdb002       varchar2(10)      ,/* 結算中心 */
stdb003       varchar2(10)      ,/* 業務類型 */
stdb004       varchar2(10)      ,/* 對象類型 */
stdb005       varchar2(10)      ,/* 供貨對象 */
stdb006       varchar2(10)      ,/* 需求對象 */
stdb007       varchar2(10)      ,/* 關聯交易頻率 */
stdb008       varchar2(10)      ,/* 往來關係 */
stdb009       varchar2(1)      ,/* 退可沖銷 */
stdb010       varchar2(80)      ,/* 備註 */
stdbownid       varchar2(20)      ,/* 資料所有者 */
stdbowndp       varchar2(10)      ,/* 資料所屬部門 */
stdbcrtid       varchar2(20)      ,/* 資料建立者 */
stdbcrtdp       varchar2(10)      ,/* 資料建立部門 */
stdbcrtdt       timestamp(0)      ,/* 資料創建日 */
stdbmodid       varchar2(20)      ,/* 資料修改者 */
stdbmoddt       timestamp(0)      ,/* 最近修改日 */
stdbstus       varchar2(10)      ,/* 狀態碼 */
stdbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdb_t add constraint stdb_pk primary key (stdbent,stdb001) enable validate;

create unique index stdb_pk on stdb_t (stdbent,stdb001);

grant select on stdb_t to tiptop;
grant update on stdb_t to tiptop;
grant delete on stdb_t to tiptop;
grant insert on stdb_t to tiptop;

exit;
