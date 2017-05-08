/* 
================================================================================
檔案代號:psgb_t
檔案名稱:集團MRP明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psgb_t
(
psgbent       number(5)      ,/* 企業編號 */
psgb001       varchar2(10)      ,/* 集團MRP版本 */
psgb002       varchar2(40)      ,/* 料件編號 */
psgb003       varchar2(256)      ,/* 產品特徵 */
psgb004       date      ,/* 日期 */
psgbsite       varchar2(10)      ,/* 營運據點 */
psgb005       number(20,6)      ,/* +庫存量 */
psgb006       number(20,6)      ,/* +替代量 */
psgb007       number(20,6)      ,/* +請購量 */
psgb008       number(20,6)      ,/* +採購量 */
psgb009       number(20,6)      ,/* +在驗量 */
psgb010       number(20,6)      ,/* +在製量 */
psgb011       number(20,6)      ,/* +交期重排供給增加量 */
psgb012       number(20,6)      ,/* +備料重排需求減少量 */
psgb013       number(20,6)      ,/* -安全庫存量 */
psgb014       number(20,6)      ,/* -訂單未交量 */
psgb015       number(20,6)      ,/* -預測需求量 */
psgb016       number(20,6)      ,/* -工單備料量 */
psgb017       number(20,6)      ,/* -計畫備料量 */
psgb018       number(20,6)      ,/* -交期重排減少量 */
psgb019       number(20,6)      ,/* -備料重排增加量 */
psgb020       number(20,6)      ,/* 結存量 */
psgb021       number(20,6)      ,/* +建議採購量 */
psgb022       number(20,6)      ,/* +建議生產量 */
psgb023       number(20,6)      ,/* 預計結存量 */
psgb024       number(20,6)      ,/* -建議撥出量 */
psgb025       number(20,6)      ,/* +建議撥入量 */
psgb026       number(20,6)      ,/* +可挪動庫存量 */
psgb027       varchar2(1)      ,/* 已轉請採購 */
psgb028       varchar2(1)      ,/* 已轉工單 */
psgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psgbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
psgb029       varchar2(1)      /* No Use */
);
alter table psgb_t add constraint psgb_pk primary key (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb029) enable validate;

create unique index psgb_pk on psgb_t (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb029);

grant select on psgb_t to tiptop;
grant update on psgb_t to tiptop;
grant delete on psgb_t to tiptop;
grant insert on psgb_t to tiptop;

exit;
