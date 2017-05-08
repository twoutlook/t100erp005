/* 
================================================================================
檔案代號:indv_t
檔案名稱:供應商庫存批量轉移單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indv_t
(
indvent       number(5)      ,/* 企業編號 */
indvsite       varchar2(10)      ,/* 營運組織 */
indvunit       varchar2(10)      ,/* 應用組織 */
indvdocno       varchar2(20)      ,/* 單據編號 */
indvseq       number(10,0)      ,/* 項次 */
indv001       varchar2(40)      ,/* 商品編號 */
indv002       varchar2(30)      ,/* 轉出批次 */
indv003       number(20,6)      ,/* 轉移數量 */
indvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indv_t add constraint indv_pk primary key (indvent,indvdocno,indvseq) enable validate;

create unique index indv_pk on indv_t (indvent,indvdocno,indvseq);

grant select on indv_t to tiptop;
grant update on indv_t to tiptop;
grant delete on indv_t to tiptop;
grant insert on indv_t to tiptop;

exit;
