/* 
================================================================================
檔案代號:xmfv_t
檔案名稱:客訴單結案註記檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfv_t
(
xmfvent       number(5)      ,/* 企業編號 */
xmfvsite       varchar2(10)      ,/* 營運據點 */
xmfvdocno       varchar2(20)      ,/* 客訴單號 */
xmfvseq       number(10,0)      ,/* 項次 */
xmfv001       varchar2(500)      ,/* 結案註記 */
xmfv002       varchar2(20)      ,/* 主辦人員 */
xmfvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfv_t add constraint xmfv_pk primary key (xmfvent,xmfvdocno,xmfvseq) enable validate;

create unique index xmfv_pk on xmfv_t (xmfvent,xmfvdocno,xmfvseq);

grant select on xmfv_t to tiptop;
grant update on xmfv_t to tiptop;
grant delete on xmfv_t to tiptop;
grant insert on xmfv_t to tiptop;

exit;
