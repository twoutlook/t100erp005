/* 
================================================================================
檔案代號:mrdl_t
檔案名稱:資源維修工單報工維修內容原因明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdl_t
(
mrdlent       number(5)      ,/* 企業編號 */
mrdlsite       varchar2(10)      ,/* 營運據點 */
mrdldocno       varchar2(20)      ,/* 維修工單單號 */
mrdlseq       number(10,0)      ,/* 項次 */
mrdlseq1       number(10,0)      ,/* 項序 */
mrdl001       varchar2(10)      ,/* 維修內容 */
mrdl002       varchar2(10)      ,/* 維修原因 */
mrdl003       number(5,0)      ,/* 耗用時間 */
mrdl004       varchar2(10)      ,/* 時間單位 */
mrdl006       varchar2(255)      ,/* 備註 */
mrdlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdl_t add constraint mrdl_pk primary key (mrdlent,mrdldocno,mrdlseq,mrdlseq1) enable validate;

create unique index mrdl_pk on mrdl_t (mrdlent,mrdldocno,mrdlseq,mrdlseq1);

grant select on mrdl_t to tiptop;
grant update on mrdl_t to tiptop;
grant delete on mrdl_t to tiptop;
grant insert on mrdl_t to tiptop;

exit;
