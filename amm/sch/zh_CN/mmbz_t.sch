/* 
================================================================================
檔案代號:mmbz_t
檔案名稱:生效營運據點卡積點一般規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mmbz_t
(
mmbzent       number(5)      ,/* 企業編號 */
mmbzsite       varchar2(10)      ,/* 營運據點 */
mmbz001       varchar2(30)      ,/* 活動規則編號 */
mmbz002       varchar2(10)      ,/* 卡種編號 */
mmbz003       varchar2(10)      ,/* 規則類型 */
mmbz004       varchar2(40)      ,/* 規則編碼 */
mmbz005       varchar2(1)      ,/* 基準單位 */
mmbz006       number(20,6)      ,/* 基準額滿 */
mmbz07       number(20,6)      ,/* 最小積點基準 */
mmbz008       number(15,3)      ,/* 最小單位積點 */
mmbzacti       varchar2(1)      ,/* 資料有效 */
mmbzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbz_t add constraint mmbz_pk primary key (mmbzent,mmbzsite,mmbz001,mmbz003,mmbz004) enable validate;

create unique index mmbz_pk on mmbz_t (mmbzent,mmbzsite,mmbz001,mmbz003,mmbz004);

grant select on mmbz_t to tiptop;
grant update on mmbz_t to tiptop;
grant delete on mmbz_t to tiptop;
grant insert on mmbz_t to tiptop;

exit;
