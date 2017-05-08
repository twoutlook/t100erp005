/* 
================================================================================
檔案代號:xmib_t
檔案名稱:銷售預測編號期別明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmib_t
(
xmibent       number(5)      ,/* 企業編號 */
xmib001       varchar2(10)      ,/* 預測編號 */
xmib002       number(5,0)      ,/* 期別 */
xmib003       varchar2(10)      ,/* 計算期間 */
xmibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmibud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmib_t add constraint xmib_pk primary key (xmibent,xmib001,xmib002) enable validate;

create unique index xmib_pk on xmib_t (xmibent,xmib001,xmib002);

grant select on xmib_t to tiptop;
grant update on xmib_t to tiptop;
grant delete on xmib_t to tiptop;
grant insert on xmib_t to tiptop;

exit;
