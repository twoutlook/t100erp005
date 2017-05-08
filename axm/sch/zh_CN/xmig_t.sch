/* 
================================================================================
檔案代號:xmig_t
檔案名稱:營運據點銷售預測分配資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmig_t
(
xmigent       number(5)      ,/* 企業編號 */
xmigsite       varchar2(10)      ,/* 營運據點 */
xmig001       varchar2(10)      ,/* 預測編號 */
xmig002       date      ,/* 預測起始日 */
xmig003       number(5,0)      ,/* 版本 */
xmig004       varchar2(10)      ,/* 預測組織 */
xmig005       varchar2(20)      ,/* 業務員 */
xmig006       varchar2(40)      ,/* 預測料號 */
xmig007       varchar2(256)      ,/* 產品特徵 */
xmig008       varchar2(10)      ,/* 客戶 */
xmig009       varchar2(10)      ,/* 通路 */
xmig010       number(5,0)      ,/* 期別 */
xmig011       date      ,/* 起始日期 */
xmig012       date      ,/* 截止日期 */
xmig013       number(20,6)      ,/* 業務預測數量 */
xmig014       number(20,6)      ,/* 單價 */
xmig015       number(20,6)      ,/* 金額 */
xmig016       number(20,6)      ,/* 生管確認數量 */
xmig017       varchar2(10)      ,/* 預測類型 */
xmig018       varchar2(10)      ,/* 單位 */
xmigud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmigud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmigud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmigud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmigud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmigud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmigud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmigud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmigud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmigud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmigud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmigud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmigud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmigud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmigud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmigud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmigud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmigud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmigud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmigud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmigud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmigud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmigud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmigud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmigud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmigud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmigud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmigud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmigud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmigud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmig_t add constraint xmig_pk primary key (xmigent,xmigsite,xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,xmig017) enable validate;

create unique index xmig_pk on xmig_t (xmigent,xmigsite,xmig001,xmig002,xmig003,xmig004,xmig005,xmig006,xmig007,xmig008,xmig009,xmig010,xmig017);

grant select on xmig_t to tiptop;
grant update on xmig_t to tiptop;
grant delete on xmig_t to tiptop;
grant insert on xmig_t to tiptop;

exit;
