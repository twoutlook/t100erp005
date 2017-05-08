/* 
================================================================================
檔案代號:srce_t
檔案名稱:重複性生產計劃製程上站作業變更檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srce_t
(
srceent       number(5)      ,/* 企業代碼 */
srcesite       varchar2(10)      ,/* 營運據點 */
srce000       varchar2(1)      ,/* 類型 */
srce001       varchar2(10)      ,/* 生產計劃 */
srce002       varchar2(10)      ,/* 製程編號 */
srce004       varchar2(40)      ,/* 料件編號 */
srce005       varchar2(30)      ,/* BOM特性 */
srce006       varchar2(256)      ,/* 產品特徵 */
srce007       number(10,0)      ,/* 項次 */
srceseq       number(10,0)      ,/* 項序 */
srce008       varchar2(10)      ,/* 上站作業 */
srce009       varchar2(10)      ,/* 上站作業序 */
srce900       number(10,0)      ,/* 變更序 */
srce901       varchar2(1)      ,/* 變更類型 */
srce902       date      ,/* 變更日期 */
srce905       varchar2(10)      ,/* 變更理由 */
srce906       varchar2(255)      ,/* 變更備註 */
srceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srce_t add constraint srce_pk primary key (srceent,srcesite,srce000,srce001,srce002,srce004,srce005,srce006,srce007,srceseq,srce900) enable validate;

create unique index srce_pk on srce_t (srceent,srcesite,srce000,srce001,srce002,srce004,srce005,srce006,srce007,srceseq,srce900);

grant select on srce_t to tiptop;
grant update on srce_t to tiptop;
grant delete on srce_t to tiptop;
grant insert on srce_t to tiptop;

exit;
