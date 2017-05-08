/* 
================================================================================
檔案代號:pmes_t
檔案名稱:要貨模板引用組織設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmes_t
(
pmesent       number(5)      ,/* 企業編號 */
pmesunit       varchar2(10)      ,/* 應用組織 */
pmes001       varchar2(10)      ,/* 要貨模板編號 */
pmes002       varchar2(10)      ,/* 要貨組織 */
pmes003       varchar2(10)      ,/* 部門編號 */
pmesstus       varchar2(10)      ,/* 狀態碼 */
pmesud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmesud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmesud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmesud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmesud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmesud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmesud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmesud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmesud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmesud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmesud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmesud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmesud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmesud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmesud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmesud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmesud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmesud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmesud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmesud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmesud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmesud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmesud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmesud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmesud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmesud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmesud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmesud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmesud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmesud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmes_t add constraint pmes_pk primary key (pmesent,pmes001,pmes002,pmes003) enable validate;

create unique index pmes_pk on pmes_t (pmesent,pmes001,pmes002,pmes003);

grant select on pmes_t to tiptop;
grant update on pmes_t to tiptop;
grant delete on pmes_t to tiptop;
grant insert on pmes_t to tiptop;

exit;
