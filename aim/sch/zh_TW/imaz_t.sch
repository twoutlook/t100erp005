/* 
================================================================================
檔案代號:imaz_t
檔案名稱:商品流通補貨規格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imaz_t
(
imazent       number(5)      ,/* 企業編號 */
imaz001       varchar2(40)      ,/* 商品編號 */
imaz002       varchar2(10)      ,/* 補貨規格 */
imaz003       varchar2(40)      ,/* 補貨條碼 */
imaz004       varchar2(10)      ,/* 補貨單位 */
imaz005       number(20,6)      ,/* 件裝數 */
imazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imazud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imaz006       varchar2(80)      /* 補貨規格說明 */
);
alter table imaz_t add constraint imaz_pk primary key (imazent,imaz001,imaz002) enable validate;

create unique index imaz_pk on imaz_t (imazent,imaz001,imaz002);

grant select on imaz_t to tiptop;
grant update on imaz_t to tiptop;
grant delete on imaz_t to tiptop;
grant insert on imaz_t to tiptop;

exit;
