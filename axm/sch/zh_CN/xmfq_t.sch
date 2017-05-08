/* 
================================================================================
檔案代號:xmfq_t
檔案名稱:客訴單原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfq_t
(
xmfqent       number(5)      ,/* 企業編號 */
xmfqsite       varchar2(10)      ,/* 營運據點 */
xmfqdocno       varchar2(20)      ,/* 客訴單號 */
xmfqseq       number(10,0)      ,/* 項次 */
xmfq001       varchar2(500)      ,/* 客訴原因 */
xmfq002       varchar2(20)      ,/* 主辦人員 */
xmfq003       varchar2(10)      ,/* 責任單位 */
xmfqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfq_t add constraint xmfq_pk primary key (xmfqent,xmfqdocno,xmfqseq) enable validate;

create unique index xmfq_pk on xmfq_t (xmfqent,xmfqdocno,xmfqseq);

grant select on xmfq_t to tiptop;
grant update on xmfq_t to tiptop;
grant delete on xmfq_t to tiptop;
grant insert on xmfq_t to tiptop;

exit;
