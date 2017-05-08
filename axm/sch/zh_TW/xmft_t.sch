/* 
================================================================================
檔案代號:xmft_t
檔案名稱:客訴單審核紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmft_t
(
xmftent       number(5)      ,/* 企業編號 */
xmftsite       varchar2(10)      ,/* 營運據點 */
xmftdocno       varchar2(20)      ,/* 客訴單號 */
xmftseq       number(10,0)      ,/* 項次 */
xmft001       varchar2(500)      ,/* 稽覈結果 */
xmft002       varchar2(20)      ,/* 審核人員 */
xmftud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmftud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmftud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmftud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmftud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmftud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmftud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmftud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmftud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmftud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmftud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmftud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmftud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmftud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmftud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmftud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmftud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmftud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmftud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmftud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmftud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmftud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmftud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmftud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmftud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmftud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmftud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmftud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmftud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmftud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmft_t add constraint xmft_pk primary key (xmftent,xmftdocno,xmftseq) enable validate;

create unique index xmft_pk on xmft_t (xmftent,xmftdocno,xmftseq);

grant select on xmft_t to tiptop;
grant update on xmft_t to tiptop;
grant delete on xmft_t to tiptop;
grant insert on xmft_t to tiptop;

exit;
