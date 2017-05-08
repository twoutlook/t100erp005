/* 
================================================================================
檔案代號:prfc_t
檔案名稱:客戶組資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table prfc_t
(
prfcent       number(5)      ,/* 企業編號 */
prfcunit       varchar2(10)      ,/* 應用組織 */
prfcsite       varchar2(10)      ,/* NO USE */
prfc001       varchar2(10)      ,/* 客戶組編號 */
prfc002       varchar2(10)      ,/* 版本 */
prfcstus       varchar2(10)      ,/* 狀態碼 */
prfcownid       varchar2(20)      ,/* 資料所有者 */
prfcowndp       varchar2(10)      ,/* 資料所屬部門 */
prfccrtid       varchar2(20)      ,/* 資料建立者 */
prfccrtdp       varchar2(10)      ,/* 資料建立部門 */
prfccrtdt       timestamp(0)      ,/* 資料創建日 */
prfcmodid       varchar2(20)      ,/* 資料修改者 */
prfcmoddt       timestamp(0)      ,/* 最近修改日 */
prfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfc_t add constraint prfc_pk primary key (prfcent,prfc001) enable validate;

create unique index prfc_pk on prfc_t (prfcent,prfc001);

grant select on prfc_t to tiptop;
grant update on prfc_t to tiptop;
grant delete on prfc_t to tiptop;
grant insert on prfc_t to tiptop;

exit;
