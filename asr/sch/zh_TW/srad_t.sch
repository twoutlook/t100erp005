/* 
================================================================================
檔案代號:srad_t
檔案名稱:重覆性生產計畫製程Check in/Check out項目檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srad_t
(
sradent       number(5)      ,/* 企業編號 */
sradsite       varchar2(10)      ,/* 營運據點 */
srad001       varchar2(10)      ,/* 生產計劃 */
srad002       varchar2(10)      ,/* 製程編號 */
srad004       varchar2(40)      ,/* 料件編號 */
srad005       varchar2(30)      ,/* BOM特性 */
srad006       varchar2(256)      ,/* 產品特徵 */
srad007       number(10,0)      ,/* 項次 */
sradseq       number(10,0)      ,/* 項序 */
srad008       varchar2(1)      ,/* check in/check out */
srad009       varchar2(10)      ,/* 項目 */
srad010       varchar2(10)      ,/* 型態 */
srad011       number(20,6)      ,/* 下限 */
srad012       number(20,6)      ,/* 上限 */
srad013       varchar2(80)      ,/* 預設值 */
srad014       varchar2(1)      ,/* 必要 */
sradud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sradud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sradud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sradud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sradud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sradud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sradud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sradud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sradud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sradud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sradud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sradud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sradud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sradud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sradud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sradud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sradud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sradud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sradud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sradud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sradud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sradud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sradud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sradud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sradud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sradud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sradud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sradud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sradud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sradud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srad_t add constraint srad_pk primary key (sradent,sradsite,srad001,srad002,srad004,srad005,srad006,srad007,sradseq) enable validate;

create unique index srad_pk on srad_t (sradent,sradsite,srad001,srad002,srad004,srad005,srad006,srad007,sradseq);

grant select on srad_t to tiptop;
grant update on srad_t to tiptop;
grant delete on srad_t to tiptop;
grant insert on srad_t to tiptop;

exit;
