/* 
================================================================================
檔案代號:deac_t
檔案名稱:門店營業款轉備用金明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deac_t
(
deacent       number(5)      ,/* 企業編號 */
deacsite       varchar2(10)      ,/* 營運據點 */
deacunit       varchar2(10)      ,/* 應用組織 */
deacdocno       varchar2(20)      ,/* 轉撥單號 */
deacseq       number(10,0)      ,/* 項次 */
deac001       date      ,/* 營業日期 */
deac002       varchar2(30)      ,/* 帳戶編號 */
deac003       varchar2(30)      ,/* 銀行帳號 */
deac004       varchar2(10)      ,/* 幣別 */
deac005       varchar2(10)      ,/* 款別分類 */
deac006       varchar2(10)      ,/* 款別編號 */
deac007       number(20,6)      ,/* 轉撥金額 */
deac008       varchar2(4000)      ,/* 備註 */
deacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deac_t add constraint deac_pk primary key (deacent,deacdocno,deacseq) enable validate;

create unique index deac_pk on deac_t (deacent,deacdocno,deacseq);

grant select on deac_t to tiptop;
grant update on deac_t to tiptop;
grant delete on deac_t to tiptop;
grant insert on deac_t to tiptop;

exit;
