/* 
================================================================================
檔案代號:rtae_t
檔案名稱:品類策略門店明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtae_t
(
rtaeent       number(5)      ,/* 企業編號 */
rtae001       varchar2(10)      ,/* 策略編號 */
rtae002       varchar2(10)      ,/* 門店編號 */
rtaestus       varchar2(1)      ,/* 資料有效碼 */
rtaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtae_t add constraint rtae_pk primary key (rtaeent,rtae001,rtae002) enable validate;

create unique index rtae_pk on rtae_t (rtaeent,rtae001,rtae002);

grant select on rtae_t to tiptop;
grant update on rtae_t to tiptop;
grant delete on rtae_t to tiptop;
grant insert on rtae_t to tiptop;

exit;
