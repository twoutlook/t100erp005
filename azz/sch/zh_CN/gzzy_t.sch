/* 
================================================================================
檔案代號:gzzy_t
檔案名稱:語系資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzzy_t
(
gzzystus       varchar2(10)      ,/* 狀態碼 */
gzzy001       varchar2(6)      ,/* 界面語言編號 */
gzzy002       varchar2(80)      ,/* 語言名稱 */
gzzy003       varchar2(6)      ,/* 資料語言編號 */
gzzyownid       varchar2(20)      ,/* 資料所有者 */
gzzyowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzycrtid       varchar2(20)      ,/* 資料建立者 */
gzzycrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzycrtdt       timestamp(0)      ,/* 資料創建日 */
gzzymodid       varchar2(20)      ,/* 資料修改者 */
gzzymoddt       timestamp(0)      ,/* 最近修改日 */
gzzyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzzy_t add constraint gzzy_pk primary key (gzzy001) enable validate;

create unique index gzzy_pk on gzzy_t (gzzy001);

grant select on gzzy_t to tiptop;
grant update on gzzy_t to tiptop;
grant delete on gzzy_t to tiptop;
grant insert on gzzy_t to tiptop;

exit;
