/* 
================================================================================
檔案代號:rteh_t
檔案名稱:專櫃新商品引進-商品庫區明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rteh_t
(
rtehent       number(5)      ,/* 企業編號 */
rtehsite       varchar2(10)      ,/* 營運據點 */
rtehunit       varchar2(10)      ,/* 應用組織 */
rtehdocno       varchar2(20)      ,/* 單據編號 */
rtehseq       number(10,0)      ,/* 商品明細項次 */
rtehseq1       number(10,0)      ,/* 項次 */
rteh001       varchar2(40)      ,/* 商品編號 */
rteh002       varchar2(10)      ,/* 庫區編號 */
rteh003       varchar2(10)      ,/* 庫區用途分類 */
rtehacti       varchar2(1)      ,/* 有效 */
rtehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rteh_t add constraint rteh_pk primary key (rtehent,rtehdocno,rtehseq,rtehseq1) enable validate;

create unique index rteh_pk on rteh_t (rtehent,rtehdocno,rtehseq,rtehseq1);

grant select on rteh_t to tiptop;
grant update on rteh_t to tiptop;
grant delete on rteh_t to tiptop;
grant insert on rteh_t to tiptop;

exit;
