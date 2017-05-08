/* 
================================================================================
檔案代號:xmfs_t
檔案名稱:客訴單處理及改善對策檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfs_t
(
xmfsent       number(5)      ,/* 企業編號 */
xmfssite       varchar2(10)      ,/* 營運據點 */
xmfsdocno       varchar2(20)      ,/* 客訴單號 */
xmfsseq       number(10,0)      ,/* 項次 */
xmfs001       varchar2(500)      ,/* 處理及改善對策 */
xmfs002       varchar2(20)      ,/* 主辦人員 */
xmfs003       varchar2(10)      ,/* 責任單位 */
xmfsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfs_t add constraint xmfs_pk primary key (xmfsent,xmfsdocno,xmfsseq) enable validate;

create unique index xmfs_pk on xmfs_t (xmfsent,xmfsdocno,xmfsseq);

grant select on xmfs_t to tiptop;
grant update on xmfs_t to tiptop;
grant delete on xmfs_t to tiptop;
grant insert on xmfs_t to tiptop;

exit;
