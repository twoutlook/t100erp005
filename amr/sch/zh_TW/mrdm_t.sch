/* 
================================================================================
檔案代號:mrdm_t
檔案名稱:資源維修工單報工維修料號明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdm_t
(
mrdment       number(5)      ,/* 企業編號 */
mrdmsite       varchar2(10)      ,/* 營運據點 */
mrdmdocno       varchar2(20)      ,/* 維修工單單號 */
mrdmseq       number(10,0)      ,/* 項次 */
mrdmseq1       number(10,0)      ,/* 項序 */
mrdm001       varchar2(40)      ,/* 料號 */
mrdm002       varchar2(10)      ,/* 處理類型 */
mrdm003       varchar2(10)      ,/* 單位 */
mrdm004       number(20,6)      ,/* 數量 */
mrdm005       varchar2(10)      ,/* 退回狀態 */
mrdm006       varchar2(10)      ,/* 更換原因 */
mrdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdm_t add constraint mrdm_pk primary key (mrdment,mrdmdocno,mrdmseq,mrdmseq1) enable validate;

create unique index mrdm_pk on mrdm_t (mrdment,mrdmdocno,mrdmseq,mrdmseq1);

grant select on mrdm_t to tiptop;
grant update on mrdm_t to tiptop;
grant delete on mrdm_t to tiptop;
grant insert on mrdm_t to tiptop;

exit;
