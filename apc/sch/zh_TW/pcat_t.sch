/* 
================================================================================
檔案代號:pcat_t
檔案名稱:POS日結款別明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcat_t
(
pcatent       number(5)      ,/* 企業編號 */
pcatsite       varchar2(10)      ,/* 營運組織 */
pcat001       date      ,/* 日結日期 */
pcat002       varchar2(10)      ,/* 收銀員 */
pcat003       varchar2(10)      ,/* POS款別 */
pcat004       varchar2(10)      ,/* ERP款別 */
pcat005       number(20,6)      ,/* 金額 */
pcatstus       varchar2(10)      ,/* 狀態 */
pcatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcat_t add constraint pcat_pk primary key (pcatent,pcatsite,pcat001,pcat002,pcat003,pcat004) enable validate;

create unique index pcat_pk on pcat_t (pcatent,pcatsite,pcat001,pcat002,pcat003,pcat004);

grant select on pcat_t to tiptop;
grant update on pcat_t to tiptop;
grant delete on pcat_t to tiptop;
grant insert on pcat_t to tiptop;

exit;
