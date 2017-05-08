/* 
================================================================================
檔案代號:pjbo_t
檔案名稱:專案WBS變更單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbo_t
(
pjboent       number(5)      ,/* 企業編號 */
pjbo001       varchar2(20)      ,/* 專案編號 */
pjbo002       varchar2(30)      ,/* 本階WBS */
pjbo003       varchar2(30)      ,/* 上階WBS */
pjbo004       varchar2(10)      ,/* WBS類型 */
pjbo005       date      ,/* 計畫起始日 */
pjbo006       date      ,/* 計畫截止日 */
pjbo007       number(15,3)      ,/* 工期天數 */
pjbo008       number(15,3)      ,/* 工期時數 */
pjbo009       varchar2(1)      ,/* 里程碑 */
pjbo010       varchar2(20)      ,/* 負責人員 */
pjbo011       varchar2(10)      ,/* 負責部門 */
pjbo012       varchar2(10)      ,/* 狀態碼 */
pjbo900       number(10,0)      ,/* 變更序 */
pjbo901       varchar2(1)      ,/* 變更類型 */
pjbo902       date      ,/* 變更日期 */
pjbo903       varchar2(10)      ,/* 變更理由 */
pjbo904       varchar2(255)      ,/* 變更備註 */
pjboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjboud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbo013       number(20,6)      ,/* 發包總額 */
pjbo014       number(20,6)      ,/* 未結案發包總額 */
pjbo015       number(20,6)      ,/* 結案發包總額 */
pjbo016       number(20,6)      /* 發包開帳金額 */
);
alter table pjbo_t add constraint pjbo_pk primary key (pjboent,pjbo001,pjbo002,pjbo900) enable validate;

create unique index pjbo_pk on pjbo_t (pjboent,pjbo001,pjbo002,pjbo900);

grant select on pjbo_t to tiptop;
grant update on pjbo_t to tiptop;
grant delete on pjbo_t to tiptop;
grant insert on pjbo_t to tiptop;

exit;
