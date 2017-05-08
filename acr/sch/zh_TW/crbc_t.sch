/* 
================================================================================
檔案代號:crbc_t
檔案名稱:客訴經手人員記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table crbc_t
(
crbcent       number(5)      ,/* 企業編號 */
crbcsite       varchar2(10)      ,/* 營運據點 */
crbcdocno       varchar2(20)      ,/* 客訴單號 */
crbc000       varchar2(1)      ,/* 類別 */
crbc001       varchar2(20)      ,/* 主辦人員 */
crbc002       varchar2(20)      ,/* 審核人員 */
crbc003       varchar2(20)      ,/* 責任單位 */
crbcownid       varchar2(20)      ,/* 資料所有者 */
crbcowndp       varchar2(10)      ,/* 資料所屬部門 */
crbccrtid       varchar2(20)      ,/* 資料建立者 */
crbccrtdp       varchar2(10)      ,/* 資料建立部門 */
crbccrtdt       timestamp(0)      ,/* 資料創建日 */
crbcmodid       varchar2(20)      ,/* 資料修改者 */
crbcmoddt       timestamp(0)      ,/* 最近修改日 */
crbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crbc_t add constraint crbc_pk primary key (crbcent,crbcdocno,crbc000) enable validate;

create unique index crbc_pk on crbc_t (crbcent,crbcdocno,crbc000);

grant select on crbc_t to tiptop;
grant update on crbc_t to tiptop;
grant delete on crbc_t to tiptop;
grant insert on crbc_t to tiptop;

exit;
