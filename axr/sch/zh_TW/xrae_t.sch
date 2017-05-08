/* 
================================================================================
檔案代號:xrae_t
檔案名稱:帳齡類型天數分段檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrae_t
(
xraeent       number(5)      ,/* 企業編號 */
xrae001       varchar2(10)      ,/* 帳齡類型編號 */
xrae002       number(5,0)      ,/* 分段序號 */
xrae003       number(5,0)      ,/* 起始天數 */
xrae004       number(5,0)      ,/* 截止天數 */
xrae005       number(20,6)      ,/* 慣用壞帳提列率 */
xraeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xraeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xraeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xraeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xraeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xraeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xraeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xraeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xraeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xraeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xraeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xraeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xraeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xraeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xraeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xraeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xraeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xraeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xraeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xraeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xraeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xraeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xraeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xraeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xraeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xraeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xraeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xraeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xraeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xraeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrae_t add constraint xrae_pk primary key (xraeent,xrae001,xrae002) enable validate;

create unique index xrae_pk on xrae_t (xraeent,xrae001,xrae002);

grant select on xrae_t to tiptop;
grant update on xrae_t to tiptop;
grant delete on xrae_t to tiptop;
grant insert on xrae_t to tiptop;

exit;
