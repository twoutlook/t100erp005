/* 
================================================================================
檔案代號:xraf_t
檔案名稱:壞帳提列率依信評級設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xraf_t
(
xrafent       number(5)      ,/* 企業編號 */
xraf001       varchar2(10)      ,/* 帳齡類型編號 */
xraf002       varchar2(10)      ,/* 信評等級 */
xraf003       number(20,6)      ,/* 分段一壞帳提列率 */
xraf004       number(20,6)      ,/* 分段二壞帳提列率 */
xraf005       number(20,6)      ,/* 分段三壞帳提列率 */
xraf006       number(20,6)      ,/* 分段四壞帳提列率 */
xraf007       number(20,6)      ,/* 分段五壞帳提列率 */
xraf008       number(20,6)      ,/* 分段六壞帳提列率 */
xraf009       number(20,6)      ,/* 分段七壞帳提列率 */
xraf010       number(20,6)      ,/* 分段八壞帳提列率 */
xraf011       number(20,6)      ,/* 分段九壞帳提列率 */
xraf012       number(20,6)      ,/* 分段十壞帳提列率 */
xraf013       number(20,6)      ,/* 分段十一壞帳提列率 */
xraf014       number(20,6)      ,/* 分段十二壞帳提列率 */
xraf015       number(20,6)      ,/* 分段十三壞帳提列率 */
xraf016       number(20,6)      ,/* 分段十四壞帳提列率 */
xraf017       number(20,6)      ,/* 分段十五壞帳提列率 */
xraf018       number(20,6)      ,/* 分段十六壞帳提列率 */
xraf019       number(20,6)      ,/* 分段十七壞帳提列率 */
xraf020       number(20,6)      ,/* 分段十八壞帳提列率 */
xraf021       number(20,6)      ,/* 分段十九壞帳提列率 */
xraf022       number(20,6)      ,/* 分段二十壞帳提列率 */
xrafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xraf_t add constraint xraf_pk primary key (xrafent,xraf001,xraf002) enable validate;

create unique index xraf_pk on xraf_t (xrafent,xraf001,xraf002);

grant select on xraf_t to tiptop;
grant update on xraf_t to tiptop;
grant delete on xraf_t to tiptop;
grant insert on xraf_t to tiptop;

exit;
