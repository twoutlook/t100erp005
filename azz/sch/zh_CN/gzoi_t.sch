/* 
================================================================================
檔案代號:gzoi_t
檔案名稱:行業別資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzoi_t
(
gzoistus       varchar2(10)      ,/* 狀態碼 */
gzoi001       varchar2(2)      ,/* 行業編號 */
gzoi002       varchar2(80)      ,/* 行業說明 */
gzoiownid       varchar2(20)      ,/* 資料所有者 */
gzoiowndp       varchar2(10)      ,/* 資料所屬部門 */
gzoicrtid       varchar2(20)      ,/* 資料建立者 */
gzoicrtdp       varchar2(10)      ,/* 資料建立部門 */
gzoicrtdt       timestamp(0)      ,/* 資料創建日 */
gzoimodid       varchar2(20)      ,/* 資料修改者 */
gzoimoddt       timestamp(0)      ,/* 最近修改日 */
gzoiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzoiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzoiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzoiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzoiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzoiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzoiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzoiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzoiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzoiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzoiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzoiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzoiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzoiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzoiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzoiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzoiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzoiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzoiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzoiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzoiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzoiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzoiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzoiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzoiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzoiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzoiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzoiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzoiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzoiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzoi_t add constraint gzoi_pk primary key (gzoi001) enable validate;

create unique index gzoi_pk on gzoi_t (gzoi001);

grant select on gzoi_t to tiptop;
grant update on gzoi_t to tiptop;
grant delete on gzoi_t to tiptop;
grant insert on gzoi_t to tiptop;

exit;
