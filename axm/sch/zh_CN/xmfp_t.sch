/* 
================================================================================
檔案代號:xmfp_t
檔案名稱:客訴單單身內容檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfp_t
(
xmfpent       number(5)      ,/* 企業編號 */
xmfpsite       varchar2(10)      ,/* 營運據點 */
xmfpdocno       varchar2(20)      ,/* 客訴單號 */
xmfpseq       number(10,0)      ,/* 項次 */
xmfp001       varchar2(500)      ,/* 客訴內容 */
xmfpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfp_t add constraint xmfp_pk primary key (xmfpent,xmfpdocno,xmfpseq) enable validate;

create unique index xmfp_pk on xmfp_t (xmfpent,xmfpdocno,xmfpseq);

grant select on xmfp_t to tiptop;
grant update on xmfp_t to tiptop;
grant delete on xmfp_t to tiptop;
grant insert on xmfp_t to tiptop;

exit;
