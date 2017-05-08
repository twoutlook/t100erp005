/* 
================================================================================
檔案代號:crbe_t
檔案名稱:客訴單處理說明檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table crbe_t
(
crbeent       number(5)      ,/* 企業編號 */
crbesite       varchar2(10)      ,/* 營運據點 */
crbedocno       varchar2(20)      ,/* 客訴單號 */
crbe000       varchar2(255)      ,/* 類別 */
crbeseq       number(10,0)      ,/* 項次 */
crbe001       varchar2(500)      ,/* 說明 */
crbe002       varchar2(255)      ,/* 備註 */
crbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crbe_t add constraint crbe_pk primary key (crbeent,crbedocno,crbe000,crbeseq) enable validate;

create unique index crbe_pk on crbe_t (crbeent,crbedocno,crbe000,crbeseq);

grant select on crbe_t to tiptop;
grant update on crbe_t to tiptop;
grant delete on crbe_t to tiptop;
grant insert on crbe_t to tiptop;

exit;
