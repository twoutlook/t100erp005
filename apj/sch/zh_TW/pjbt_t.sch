/* 
================================================================================
檔案代號:pjbt_t
檔案名稱:專案WBS費用預算變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbt_t
(
pjbtent       number(5)      ,/* 企業編號 */
pjbt001       varchar2(20)      ,/* 專案編號 */
pjbt002       varchar2(30)      ,/* 本階WBS */
pjbt003       varchar2(10)      ,/* 費用類型 */
pjbt004       number(20,6)      ,/* 金額 */
pjbt005       varchar2(255)      ,/* 備註 */
pjbt900       number(10,0)      ,/* 變更序 */
pjbt901       varchar2(1)      ,/* 變更類型 */
pjbt902       date      ,/* 變更日期 */
pjbt903       varchar2(10)      ,/* 變更理由 */
pjbt904       varchar2(255)      ,/* 變更備註 */
pjbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbtud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbt006       varchar2(10)      ,/* 稅別 */
pjbt007       number(5,2)      ,/* 稅率 */
pjbt008       number(20,6)      ,/* 原幣含稅金額 */
pjbt009       number(20,6)      ,/* 本幣未稅金額 */
pjbt010       number(20,6)      ,/* 本幣含稅金額 */
pjbt011       varchar2(10)      /* 成本要素 */
);
alter table pjbt_t add constraint pjbt_pk primary key (pjbtent,pjbt001,pjbt002,pjbt003,pjbt900) enable validate;

create unique index pjbt_pk on pjbt_t (pjbtent,pjbt001,pjbt002,pjbt003,pjbt900);

grant select on pjbt_t to tiptop;
grant update on pjbt_t to tiptop;
grant delete on pjbt_t to tiptop;
grant insert on pjbt_t to tiptop;

exit;
