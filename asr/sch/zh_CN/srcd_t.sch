/* 
================================================================================
檔案代號:srcd_t
檔案名稱:重複性生產計劃製程Check in/Check out項目變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srcd_t
(
srcdent       number(5)      ,/* 企業代碼 */
srcdsite       varchar2(10)      ,/* 營運據點 */
srcd000       varchar2(1)      ,/* 類型 */
srcd001       varchar2(10)      ,/* 生產計劃 */
srcd002       varchar2(10)      ,/* 製程編號 */
srcd004       varchar2(40)      ,/* 料件編號 */
srcd005       varchar2(30)      ,/* BOM特性 */
srcd006       varchar2(256)      ,/* 產品特徵 */
srcd007       number(10,0)      ,/* 項次 */
srcdseq       number(10,0)      ,/* 項序 */
srcd008       varchar2(1)      ,/* Check in/Check out */
srcd009       varchar2(10)      ,/* 項目 */
srcd010       varchar2(10)      ,/* 形態 */
srcd011       number(20,6)      ,/* 下限 */
srcd012       number(20,6)      ,/* 上限 */
srcd013       varchar2(80)      ,/* 預設值 */
srcd014       varchar2(1)      ,/* 必要 */
srcd900       number(10,0)      ,/* 變更序 */
srcd901       varchar2(1)      ,/* 變更類型 */
srcd902       date      ,/* 變更日期 */
srcd905       varchar2(10)      ,/* 變更理由 */
srcd906       varchar2(255)      ,/* 變更備註 */
srcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srcd_t add constraint srcd_pk primary key (srcdent,srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd007,srcdseq,srcd900) enable validate;

create unique index srcd_pk on srcd_t (srcdent,srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd007,srcdseq,srcd900);

grant select on srcd_t to tiptop;
grant update on srcd_t to tiptop;
grant delete on srcd_t to tiptop;
grant insert on srcd_t to tiptop;

exit;
