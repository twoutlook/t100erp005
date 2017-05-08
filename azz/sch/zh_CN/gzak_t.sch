/* 
================================================================================
檔案代號:gzak_t
檔案名稱:基本資料還原控管設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzak_t
(
gzak001       varchar2(10)      ,/* 資料類型 */
gzak002       varchar2(15)      ,/* 檢查表格代號 */
gzak003       varchar2(20)      ,/* 檢查欄位代號 */
gzak004       varchar2(15)      ,/* 單頭表格代號 */
gzak005       varchar2(20)      ,/* 單頭狀態欄位代號 */
gzak006       varchar2(1)      ,/* 客製 */
gzakownid       varchar2(20)      ,/* 資料所有者 */
gzakowndp       varchar2(10)      ,/* 資料所屬部門 */
gzakcrtid       varchar2(20)      ,/* 資料建立者 */
gzakcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzakcrtdt       timestamp(0)      ,/* 資料創建日 */
gzakmodid       varchar2(20)      ,/* 資料修改者 */
gzakmoddt       timestamp(0)      ,/* 最近修改日 */
gzakstus       varchar2(10)      ,/* 狀態碼 */
gzakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzak_t add constraint gzak_pk primary key (gzak001,gzak003) enable validate;

create unique index gzak_pk on gzak_t (gzak001,gzak003);

grant select on gzak_t to tiptop;
grant update on gzak_t to tiptop;
grant delete on gzak_t to tiptop;
grant insert on gzak_t to tiptop;

exit;
