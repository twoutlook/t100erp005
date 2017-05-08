/* 
================================================================================
檔案代號:crbb_t
檔案名稱:客訴單維護明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table crbb_t
(
crbbent       number(5)      ,/* 企業編號 */
crbbsite       varchar2(10)      ,/* 營運據點 */
crbbdocno       varchar2(20)      ,/* 客訴單號 */
crbbseq       number(10,0)      ,/* 項次 */
crbb001       varchar2(500)      ,/* 客訴內容 */
crbb002       varchar2(255)      ,/* 備註 */
crbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crbb_t add constraint crbb_pk primary key (crbbent,crbbdocno,crbbseq) enable validate;

create unique index crbb_pk on crbb_t (crbbent,crbbdocno,crbbseq);

grant select on crbb_t to tiptop;
grant update on crbb_t to tiptop;
grant delete on crbb_t to tiptop;
grant insert on crbb_t to tiptop;

exit;
