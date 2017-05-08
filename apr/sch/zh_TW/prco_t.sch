/* 
================================================================================
檔案代號:prco_t
檔案名稱:專櫃促銷預算明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prco_t
(
prcoent       number(5)      ,/* 企業代碼 */
prcounit       varchar2(10)      ,/* 應用執行組織物件 */
prcosite       varchar2(10)      ,/* 營運據點 */
prco001       varchar2(30)      ,/* 方案編號 */
prcoseq       number(10,0)      ,/* 項次 */
prco002       varchar2(10)      ,/* 促銷費用預算類別 */
prco003       varchar2(10)      ,/* 費用代碼 */
prco004       number(20,6)      ,/* 預算費用金額 */
prco005       number(20,6)      ,/* 實際支出金額 */
prcoacti       varchar2(1)      ,/* 資料有效碼 */
prcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prco_t add constraint prco_pk primary key (prcoent,prco001,prcoseq) enable validate;

create unique index prco_pk on prco_t (prcoent,prco001,prcoseq);

grant select on prco_t to tiptop;
grant update on prco_t to tiptop;
grant delete on prco_t to tiptop;
grant insert on prco_t to tiptop;

exit;
