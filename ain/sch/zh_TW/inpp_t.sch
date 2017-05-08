/* 
================================================================================
檔案代號:inpp_t
檔案名稱:存貨週期律資料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inpp_t
(
inppent       number(5)      ,/* 企業編號 */
inppsite       varchar2(10)      ,/* 營運據點 */
inpp001       varchar2(10)      ,/* 計算原則編號 */
inpp002       varchar2(10)      ,/* 計算分類碼 */
inpp003       number(20,6)      ,/* 權重 */
inppud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inppud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inppud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inppud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inppud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inppud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inppud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inppud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inppud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inppud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inppud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inppud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inppud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inppud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inppud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inppud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inppud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inppud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inppud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inppud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inppud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inppud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inppud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inppud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inppud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inppud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inppud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inppud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inppud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inppud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpp_t add constraint inpp_pk primary key (inppent,inppsite,inpp001,inpp002) enable validate;

create unique index inpp_pk on inpp_t (inppent,inppsite,inpp001,inpp002);

grant select on inpp_t to tiptop;
grant update on inpp_t to tiptop;
grant delete on inpp_t to tiptop;
grant insert on inpp_t to tiptop;

exit;
