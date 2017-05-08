/* 
================================================================================
檔案代號:psga_t
檔案名稱:集團MRP匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psga_t
(
psgaent       number(5)      ,/* 企業編號 */
psga001       varchar2(10)      ,/* 集團MRP版本 */
psga002       varchar2(40)      ,/* 料件編號 */
psga003       varchar2(256)      ,/* 產品特徵 */
psga004       date      ,/* 日期 */
psga005       number(20,6)      ,/* +庫存量 */
psga006       number(20,6)      ,/* +替代量 */
psga007       number(20,6)      ,/* +請購量 */
psga008       number(20,6)      ,/* +採購量 */
psga009       number(20,6)      ,/* +在驗量 */
psga010       number(20,6)      ,/* +在製量 */
psga011       number(20,6)      ,/* +交期重排供給增加量 */
psga012       number(20,6)      ,/* +備料重排需求減少量 */
psga013       number(20,6)      ,/* -安全庫存量 */
psga014       number(20,6)      ,/* -訂單未交量 */
psga015       number(20,6)      ,/* -預測需求量 */
psga016       number(20,6)      ,/* -工單備料量 */
psga017       number(20,6)      ,/* -計畫備料量 */
psga018       number(20,6)      ,/* -交期重排減少量 */
psga019       number(20,6)      ,/* -備料重排增加量 */
psga020       number(20,6)      ,/* 結存量 */
psga021       number(20,6)      ,/* +建議採購量 */
psga022       number(20,6)      ,/* +建議生產量 */
psga023       number(20,6)      ,/* 預計結存量 */
psga024       number(20,6)      ,/* 建議調撥量 */
psgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psga_t add constraint psga_pk primary key (psgaent,psga001,psga002,psga003,psga004) enable validate;

create unique index psga_pk on psga_t (psgaent,psga001,psga002,psga003,psga004);

grant select on psga_t to tiptop;
grant update on psga_t to tiptop;
grant delete on psga_t to tiptop;
grant insert on psga_t to tiptop;

exit;
