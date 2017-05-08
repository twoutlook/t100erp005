/* 
================================================================================
檔案代號:pjbg_t
檔案名稱:專案WBS費用預算檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjbg_t
(
pjbgent       number(5)      ,/* 企業編號 */
pjbg001       varchar2(20)      ,/* 專案編號 */
pjbg002       varchar2(30)      ,/* 本階WBS */
pjbg003       varchar2(10)      ,/* 費用類型 */
pjbg004       number(20,6)      ,/* 金額 */
pjbg005       varchar2(255)      ,/* 備註 */
pjbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjbg006       varchar2(80)      ,/* 稅別 */
pjbg007       number(5,2)      ,/* 稅率 */
pjbg008       number(20,6)      ,/* 原幣規劃含稅金額 */
pjbg009       number(20,6)      ,/* 本幣規劃未稅金額 */
pjbg010       number(20,6)      ,/* 本幣規劃含稅金額 */
pjbg011       varchar2(10)      /* 成本要素 */
);
alter table pjbg_t add constraint pjbg_pk primary key (pjbgent,pjbg001,pjbg002,pjbg003) enable validate;

create unique index pjbg_pk on pjbg_t (pjbgent,pjbg001,pjbg002,pjbg003);

grant select on pjbg_t to tiptop;
grant update on pjbg_t to tiptop;
grant delete on pjbg_t to tiptop;
grant insert on pjbg_t to tiptop;

exit;
