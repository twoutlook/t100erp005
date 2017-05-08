/* 
================================================================================
檔案代號:gcah_t
檔案名稱:券種基本資料檔-折價券收券限定商品設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcah_t
(
gcahent       number(5)      ,/* 企業編號 */
gcah001       varchar2(10)      ,/* 券種編碼 */
gcah002       varchar2(10)      ,/* 折價指定類型 */
gcah003       varchar2(40)      ,/* 折價指定類編碼 */
gcahstus       varchar2(1)      ,/* 有效 */
gcahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcah_t add constraint gcah_pk primary key (gcahent,gcah001,gcah002,gcah003) enable validate;

create unique index gcah_pk on gcah_t (gcahent,gcah001,gcah002,gcah003);

grant select on gcah_t to tiptop;
grant update on gcah_t to tiptop;
grant delete on gcah_t to tiptop;
grant insert on gcah_t to tiptop;

exit;
