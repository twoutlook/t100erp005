/* 
================================================================================
檔案代號:sfac_t
檔案名稱:工單聯產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfac_t
(
sfacent       number(5)      ,/* 企業編號 */
sfacsite       varchar2(10)      ,/* 營運據點 */
sfacdocno       varchar2(20)      ,/* 單號 */
sfac001       varchar2(40)      ,/* 料件編號 */
sfac002       varchar2(1)      ,/* 類型 */
sfac003       number(20,6)      ,/* 預計產出量 */
sfac004       varchar2(10)      ,/* 單位 */
sfac005       number(20,6)      ,/* 實際產出數量 */
sfacseq       number(10,0)      ,/* 項次 */
sfac006       varchar2(256)      ,/* 產品特徵 */
sfacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfac_t add constraint sfac_pk primary key (sfacent,sfacdocno,sfacseq) enable validate;

create unique index sfac_pk on sfac_t (sfacent,sfacdocno,sfacseq);

grant select on sfac_t to tiptop;
grant update on sfac_t to tiptop;
grant delete on sfac_t to tiptop;
grant insert on sfac_t to tiptop;

exit;
