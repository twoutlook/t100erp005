/* 
================================================================================
檔案代號:gzxq_t
檔案名稱:使用者首頁功能設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxq_t
(
gzxqent       number(5)      ,/* 企業代碼 */
gzxq001       varchar2(20)      ,/* 使用者編號 */
gzxq002       number(10,0)      ,/* 功能排序 */
gzxq003       varchar2(10)      ,/* 首頁功能 */
gzxq004       number(5,0)      ,/* 區塊格寬 */
gzxq005       number(5,0)      ,/* 區塊格高 */
gzxq006       number(5,0)      ,/* 區塊資料數 */
gzxqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxq_t add constraint gzxq_pk primary key (gzxqent,gzxq001,gzxq002) enable validate;

create unique index gzxq_pk on gzxq_t (gzxqent,gzxq001,gzxq002);

grant select on gzxq_t to tiptop;
grant update on gzxq_t to tiptop;
grant delete on gzxq_t to tiptop;
grant insert on gzxq_t to tiptop;

exit;
