/* 
================================================================================
檔案代號:isap_t
檔案名稱:媒體申報格式檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isap_t
(
isapent       number(5)      ,/* 企業編號 */
isap001       varchar2(10)      ,/* 交易稅區 */
isap002       varchar2(10)      ,/* 媒體申報格式 */
isap003       varchar2(1)      ,/* 匯總否 */
isapstus       varchar2(1)      ,/* 狀態碼 */
isapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isap_t add constraint isap_pk primary key (isapent,isap001,isap002) enable validate;

create unique index isap_pk on isap_t (isapent,isap001,isap002);

grant select on isap_t to tiptop;
grant update on isap_t to tiptop;
grant delete on isap_t to tiptop;
grant insert on isap_t to tiptop;

exit;
