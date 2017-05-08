/* 
================================================================================
檔案代號:xmfu_t
檔案名稱:客訴單核決紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfu_t
(
xmfuent       number(5)      ,/* 企業編號 */
xmfusite       varchar2(10)      ,/* 營運據點 */
xmfudocno       varchar2(20)      ,/* 客訴單號 */
xmfuseq       number(10,0)      ,/* 項次 */
xmfu001       varchar2(500)      ,/* 核決 */
xmfu002       varchar2(20)      ,/* 核決人員 */
xmfuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfu_t add constraint xmfu_pk primary key (xmfuent,xmfudocno,xmfuseq) enable validate;

create unique index xmfu_pk on xmfu_t (xmfuent,xmfudocno,xmfuseq);

grant select on xmfu_t to tiptop;
grant update on xmfu_t to tiptop;
grant delete on xmfu_t to tiptop;
grant insert on xmfu_t to tiptop;

exit;
