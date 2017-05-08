/* 
================================================================================
檔案代號:crbd_t
檔案名稱:客訴原因編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table crbd_t
(
crbdent       number(5)      ,/* 企業編號 */
crbdsite       varchar2(10)      ,/* 營運據點 */
crbddocno       varchar2(20)      ,/* 客訴單號 */
crbd000       varchar2(1)      ,/* 類別 */
crbdseq       number(10,0)      ,/* 項次 */
crbd001       varchar2(10)      ,/* 客訴原因編號 */
crbd002       varchar2(255)      ,/* 備註 */
crbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crbd_t add constraint crbd_pk primary key (crbdent,crbddocno,crbd000,crbdseq) enable validate;

create unique index crbd_pk on crbd_t (crbdent,crbddocno,crbd000,crbdseq);

grant select on crbd_t to tiptop;
grant update on crbd_t to tiptop;
grant delete on crbd_t to tiptop;
grant insert on crbd_t to tiptop;

exit;
