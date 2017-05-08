/* 
================================================================================
檔案代號:mmbe_t
檔案名稱:會員卡狀態異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbe_t
(
mmbeent       number(5)      ,/* 企業編號 */
mmbesite       varchar2(10)      ,/* 營運據點 */
mmbedocno       varchar2(20)      ,/* 單據編號 */
mmbeseq       number(10,0)      ,/* 項次 */
mmbe001       varchar2(30)      ,/* 會員卡號 */
mmbe002       varchar2(10)      ,/* 卡種編號 */
mmbe003       varchar2(30)      ,/* 會員編號 */
mmbe004       number(10,0)      ,/* 數量 */
mmbe005       varchar2(1)      ,/* 異動前卡狀態 */
mmbe006       date      ,/* 有效期至 */
mmbeunit       varchar2(10)      ,/* 應用組織 */
mmbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbe_t add constraint mmbe_pk primary key (mmbeent,mmbedocno,mmbeseq) enable validate;

create unique index mmbe_pk on mmbe_t (mmbeent,mmbedocno,mmbeseq);

grant select on mmbe_t to tiptop;
grant update on mmbe_t to tiptop;
grant delete on mmbe_t to tiptop;
grant insert on mmbe_t to tiptop;

exit;
