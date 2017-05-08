/* 
================================================================================
檔案代號:gcan_t
檔案名稱:券狀態異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gcan_t
(
gcanent       number(5)      ,/* 企業編號 */
gcansite       varchar2(10)      ,/* 營運據點 */
gcanunit       varchar2(10)      ,/* 應用組織 */
gcandocno       varchar2(20)      ,/* 單號 */
gcanseq       number(10,0)      ,/* 項次 */
gcan001       varchar2(30)      ,/* 券號 */
gcan002       varchar2(10)      ,/* 券種編號 */
gcan003       date      ,/* 失效日期 */
gcan004       varchar2(10)      ,/* 異動前券狀態 */
gcanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcan_t add constraint gcan_pk primary key (gcanent,gcandocno,gcanseq) enable validate;

create unique index gcan_pk on gcan_t (gcanent,gcandocno,gcanseq);

grant select on gcan_t to tiptop;
grant update on gcan_t to tiptop;
grant delete on gcan_t to tiptop;
grant insert on gcan_t to tiptop;

exit;
