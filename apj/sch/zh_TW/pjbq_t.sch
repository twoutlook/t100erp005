/* 
================================================================================
檔案代號:pjbq_t
檔案名稱:專案WBS材料預算變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbq_t
(
pjbqent       number(5)      ,/* 企業編號 */
pjbq001       varchar2(20)      ,/* 專案編號 */
pjbq002       varchar2(30)      ,/* 本階WBS */
pjbq003       number(10,0)      ,/* 項次 */
pjbq004       varchar2(10)      ,/* 產品分類 */
pjbq005       varchar2(40)      ,/* 限定料號 */
pjbq006       varchar2(10)      ,/* 單位 */
pjbq007       number(20,6)      ,/* 數量 */
pjbq008       number(20,6)      ,/* 單價 */
pjbq009       number(20,6)      ,/* 金額 */
pjbq010       varchar2(255)      ,/* 補充說明 */
pjbq900       number(10,0)      ,/* 變更序 */
pjbq901       varchar2(1)      ,/* 變更類型 */
pjbq902       date      ,/* 變更日期 */
pjbq903       varchar2(10)      ,/* 變更理由 */
pjbq904       varchar2(255)      ,/* 變更備註 */
pjbqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbqud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbq020       number(20,6)      ,/* 本幣稅額 */
pjbq021       varchar2(256)      ,/* 產品特徵 */
pjbq019       number(20,6)      ,/* 本幣含稅金額 */
pjbq011       number(20,6)      ,/* 已轉請購量 */
pjbq012       varchar2(10)      ,/* 幣別 */
pjbq013       number(20,10)      ,/* 匯率 */
pjbq014       varchar2(10)      ,/* 稅別 */
pjbq015       number(5,2)      ,/* 稅率 */
pjbq016       number(20,6)      ,/* 原幣含稅金額 */
pjbq017       number(20,6)      ,/* 原幣稅額 */
pjbq018       number(20,6)      /* 本幣未稅金額 */
);
alter table pjbq_t add constraint pjbq_pk primary key (pjbqent,pjbq001,pjbq002,pjbq003,pjbq900) enable validate;

create unique index pjbq_pk on pjbq_t (pjbqent,pjbq001,pjbq002,pjbq003,pjbq900);

grant select on pjbq_t to tiptop;
grant update on pjbq_t to tiptop;
grant delete on pjbq_t to tiptop;
grant insert on pjbq_t to tiptop;

exit;
