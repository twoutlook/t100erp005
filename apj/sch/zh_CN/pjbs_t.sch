/* 
================================================================================
檔案代號:pjbs_t
檔案名稱:專案WBS設備預算變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbs_t
(
pjbsent       number(5)      ,/* 企業編號 */
pjbs001       varchar2(20)      ,/* 專案編號 */
pjbs002       varchar2(30)      ,/* 本階WBS */
pjbs003       varchar2(20)      ,/* 限定機器 */
pjbs004       varchar2(10)      ,/* 耗用單位 */
pjbs005       number(20,6)      ,/* 耗用數量 */
pjbs006       number(20,6)      ,/* 單位成本率 */
pjbs007       number(20,6)      ,/* 金額 */
pjbs008       varchar2(255)      ,/* 備註 */
pjbs900       number(10,0)      ,/* 變更序 */
pjbs901       varchar2(1)      ,/* 變更類型 */
pjbs902       date      ,/* 變更日期 */
pjbs903       varchar2(10)      ,/* 變更理由 */
pjbs904       varchar2(255)      ,/* 變更備註 */
pjbsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbsud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbs009       varchar2(10)      ,/* 稅別 */
pjbs010       number(5,2)      ,/* 稅率 */
pjbs011       number(20,6)      ,/* 原幣含稅金額 */
pjbs012       number(20,6)      ,/* 本幣未稅金額 */
pjbs013       number(20,6)      ,/* 本幣含稅金額 */
pjbs014       varchar2(10)      /* 成本要素 */
);
alter table pjbs_t add constraint pjbs_pk primary key (pjbsent,pjbs001,pjbs002,pjbs003,pjbs900) enable validate;

create unique index pjbs_pk on pjbs_t (pjbsent,pjbs001,pjbs002,pjbs003,pjbs900);

grant select on pjbs_t to tiptop;
grant update on pjbs_t to tiptop;
grant delete on pjbs_t to tiptop;
grant insert on pjbs_t to tiptop;

exit;
