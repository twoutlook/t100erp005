/* 
================================================================================
檔案代號:pjbr_t
檔案名稱:專案WBS人力預算變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbr_t
(
pjbrent       number(5)      ,/* 企業編號 */
pjbr001       varchar2(20)      ,/* 專案編號 */
pjbr002       varchar2(30)      ,/* 本階WBS */
pjbr003       varchar2(10)      ,/* 專案角色 */
pjbr004       number(15,3)      ,/* 時數 */
pjbr005       number(15,3)      ,/* 天數 */
pjbr006       number(20,6)      ,/* 職能成本單價(時) */
pjbr007       number(20,6)      ,/* 職能成本單價(天) */
pjbr008       number(20,6)      ,/* 職能成本金額 */
pjbr009       varchar2(255)      ,/* 備註 */
pjbr900       number(10,0)      ,/* 變更序 */
pjbr901       varchar2(1)      ,/* 變更類型 */
pjbr902       date      ,/* 變更日期 */
pjbr903       varchar2(10)      ,/* 變更理由 */
pjbr904       varchar2(255)      ,/* 變更備註 */
pjbrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbrud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbr010       varchar2(10)      ,/* 稅別 */
pjbr011       number(5,2)      ,/* 稅率 */
pjbr012       number(20,6)      ,/* 原幣含稅金額 */
pjbr013       number(20,6)      ,/* 本幣未稅金額 */
pjbr014       number(20,6)      /* 本幣含稅金額 */
);
alter table pjbr_t add constraint pjbr_pk primary key (pjbrent,pjbr001,pjbr002,pjbr003,pjbr900) enable validate;

create unique index pjbr_pk on pjbr_t (pjbrent,pjbr001,pjbr002,pjbr003,pjbr900);

grant select on pjbr_t to tiptop;
grant update on pjbr_t to tiptop;
grant delete on pjbr_t to tiptop;
grant insert on pjbr_t to tiptop;

exit;
