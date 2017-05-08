/* 
================================================================================
檔案代號:stga_t
檔案名稱:專櫃每日銷售成本統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stga_t
(
stgaent       number(5)      ,/* 企業編號 */
stgasite       varchar2(10)      ,/* 營運組織 */
stgaunit       varchar2(10)      ,/* 應用組織 */
stga001       date      ,/* 銷售日期 */
stga002       varchar2(40)      ,/* 商品編號 */
stga003       varchar2(10)      ,/* 庫區編號 */
stga004       varchar2(10)      ,/* 專櫃編號 */
stga005       varchar2(10)      ,/* 供應商編號 */
stga006       varchar2(10)      ,/* 費用編號 */
stga007       number(10,0)      ,/* 銷售數量 */
stga008       number(20,6)      ,/* 原價金額 */
stga009       number(20,6)      ,/* 實收金額 */
stga010       number(20,6)      ,/* 費率 */
stga011       number(20,6)      ,/* 費用金額 */
stga012       number(20,6)      ,/* 成本金額 */
stga013       varchar2(10)      ,/* 日結成本類別 */
stga014       varchar2(10)      ,/* 價款類型 */
stga015       varchar2(1)      ,/* 已結轉否 */
stgadocno       varchar2(20)      ,/* 來源單號 */
stga016       varchar2(20)      ,/* 銷售單單號 */
stga017       number(10,0)      ,/* 銷售單項次 */
stgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stga_t add constraint stga_pk primary key (stgaent,stgasite,stga001,stga002,stga003,stga013,stgadocno) enable validate;

create unique index stga_pk on stga_t (stgaent,stgasite,stga001,stga002,stga003,stga013,stgadocno);

grant select on stga_t to tiptop;
grant update on stga_t to tiptop;
grant delete on stga_t to tiptop;
grant insert on stga_t to tiptop;

exit;
