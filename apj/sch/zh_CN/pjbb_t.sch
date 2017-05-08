/* 
================================================================================
檔案代號:pjbb_t
檔案名稱:專案WBS單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbb_t
(
pjbbent       number(5)      ,/* 企業編號 */
pjbb001       varchar2(20)      ,/* 專案編號 */
pjbb002       varchar2(30)      ,/* 本階WBS */
pjbb003       varchar2(30)      ,/* 上階WBS */
pjbb004       varchar2(10)      ,/* WBS類型 */
pjbb005       date      ,/* 計畫起始日 */
pjbb006       date      ,/* 計畫截止日 */
pjbb007       number(15,3)      ,/* 工期天數 */
pjbb008       number(15,3)      ,/* 工期時數 */
pjbb009       varchar2(1)      ,/* 里程碑 */
pjbb010       varchar2(20)      ,/* 負責人員 */
pjbb011       varchar2(10)      ,/* 負責部門 */
pjbb012       varchar2(10)      ,/* 狀態碼 */
pjbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbb013       number(20,6)      ,/* 發包總額 */
pjbb014       number(20,6)      ,/* 未結案發包總額 */
pjbb015       number(20,6)      ,/* 結案發包總額 */
pjbb016       number(20,6)      /* 發包開帳金額 */
);
alter table pjbb_t add constraint pjbb_pk primary key (pjbbent,pjbb001,pjbb002) enable validate;

create  index pjbb_01 on pjbb_t (pjbb002);
create unique index pjbb_pk on pjbb_t (pjbbent,pjbb001,pjbb002);

grant select on pjbb_t to tiptop;
grant update on pjbb_t to tiptop;
grant delete on pjbb_t to tiptop;
grant insert on pjbb_t to tiptop;

exit;
