/* 
================================================================================
檔案代號:gzxx_t
檔案名稱:用戶簽名圖檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzxx_t
(
gzxxent       number(5)      ,/* 企業編號 */
gzxx001       varchar2(20)      ,/* 使用者編號 */
gzxx002       blob      ,/* 個人簽名圖檔 */
gzxxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxx_t add constraint gzxx_pk primary key (gzxxent,gzxx001) enable validate;

create unique index gzxx_pk on gzxx_t (gzxxent,gzxx001);

grant select on gzxx_t to tiptop;
grant update on gzxx_t to tiptop;
grant delete on gzxx_t to tiptop;
grant insert on gzxx_t to tiptop;

exit;
