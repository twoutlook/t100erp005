/* 
================================================================================
檔案代號:pjaf_t
檔案名稱:專案報價人力明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjaf_t
(
pjafent       number(5)      ,/* 企業編號 */
pjaf001       varchar2(20)      ,/* 專案編號 */
pjaf002       number(10,0)      ,/* 報價版本 */
pjaf003       varchar2(10)      ,/* WBS類型 */
pjaf004       varchar2(10)      ,/* 專案角色 */
pjaf005       number(15,3)      ,/* 時數 */
pjaf006       number(15,3)      ,/* 天數 */
pjaf007       number(20,6)      ,/* 職能成本單價(時) */
pjaf008       number(20,6)      ,/* 職能成本單價(天) */
pjaf009       number(20,6)      ,/* 職能成本原幣未稅金額 */
pjaf010       varchar2(255)      ,/* 備註 */
pjaf011       number(20,6)      ,/* 職能成本原幣含稅金額 */
pjaf012       varchar2(10)      ,/* 稅別 */
pjafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjaf013       number(5,2)      /* 稅率 */
);
alter table pjaf_t add constraint pjaf_pk primary key (pjafent,pjaf001,pjaf002,pjaf003,pjaf004) enable validate;

create unique index pjaf_pk on pjaf_t (pjafent,pjaf001,pjaf002,pjaf003,pjaf004);

grant select on pjaf_t to tiptop;
grant update on pjaf_t to tiptop;
grant delete on pjaf_t to tiptop;
grant insert on pjaf_t to tiptop;

exit;
