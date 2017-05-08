/* 
================================================================================
檔案代號:sfab_t
檔案名稱:工單來源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfab_t
(
sfabent       number(5)      ,/* 企業編號 */
sfabsite       varchar2(10)      ,/* 營運據點 */
sfabdocno       varchar2(20)      ,/* 單號 */
sfab001       varchar2(1)      ,/* 來源 */
sfab002       varchar2(20)      ,/* 來源單號 */
sfab003       number(10,0)      ,/* 來源項次 */
sfab004       number(10,0)      ,/* 來源項序 */
sfab005       number(5,0)      ,/* 分批序 */
sfab006       number(20,6)      ,/* 分配優先序 */
sfab007       number(20,6)      ,/* 本次轉開工單量 */
sfabseq       number(10,0)      ,/* 項次 */
sfabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfab_t add constraint sfab_pk primary key (sfabent,sfabdocno,sfabseq) enable validate;

create unique index sfab_pk on sfab_t (sfabent,sfabdocno,sfabseq);

grant select on sfab_t to tiptop;
grant update on sfab_t to tiptop;
grant delete on sfab_t to tiptop;
grant insert on sfab_t to tiptop;

exit;
