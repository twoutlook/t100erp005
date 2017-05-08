/* 
================================================================================
檔案代號:indw_t
檔案名稱:供應商庫存批量轉移單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indw_t
(
indwent       number(5)      ,/* 企業編號 */
indwsite       varchar2(10)      ,/* 營運組織 */
indwunit       varchar2(10)      ,/* 應用組織 */
indwdocno       varchar2(20)      ,/* 單據編號 */
indwseq       number(10,0)      ,/* 項次 */
indwseq1       number(10,0)      ,/* 序號 */
indw001       varchar2(40)      ,/* 商品編號 */
indw002       varchar2(30)      ,/* 轉出批次 */
indw003       varchar2(10)      ,/* 庫區編號 */
indw004       number(20,6)      ,/* 轉移數量 */
indw005       number(20,6)      ,/* 轉移金額 */
indwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indw_t add constraint indw_pk primary key (indwent,indwdocno,indwseq,indwseq1) enable validate;

create unique index indw_pk on indw_t (indwent,indwdocno,indwseq,indwseq1);

grant select on indw_t to tiptop;
grant update on indw_t to tiptop;
grant delete on indw_t to tiptop;
grant insert on indw_t to tiptop;

exit;
