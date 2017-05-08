/* 
================================================================================
檔案代號:dbed_t
檔案名稱:配送預排車次發貨組織明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table dbed_t
(
dbedent       number(5)      ,/* 企業編號 */
dbedsite       varchar2(10)      ,/* 營運據點 */
dbedunit       varchar2(10)      ,/* 應用組織 */
dbeddocno       varchar2(20)      ,/* 單據編號 */
dbed001       varchar2(10)      ,/* 發貨組織 */
dbedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbed_t add constraint dbed_pk primary key (dbedent,dbeddocno,dbed001) enable validate;

create unique index dbed_pk on dbed_t (dbedent,dbeddocno,dbed001);

grant select on dbed_t to tiptop;
grant update on dbed_t to tiptop;
grant delete on dbed_t to tiptop;
grant insert on dbed_t to tiptop;

exit;
