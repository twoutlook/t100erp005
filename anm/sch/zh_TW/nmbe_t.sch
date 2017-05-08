/* 
================================================================================
檔案代號:nmbe_t
檔案名稱:收支項目對應存提碼資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmbe_t
(
nmbeent       number(5)      ,/* 企業編號 */
nmbeownid       varchar2(20)      ,/* 資料所有者 */
nmbeowndp       varchar2(10)      ,/* 資料所屬部門 */
nmbecrtid       varchar2(20)      ,/* 資料建立者 */
nmbecrtdp       varchar2(10)      ,/* 資料建立部門 */
nmbecrtdt       timestamp(0)      ,/* 資料創建日 */
nmbemodid       varchar2(20)      ,/* 資料修改者 */
nmbemoddt       timestamp(0)      ,/* 最近修改日 */
nmbestus       varchar2(10)      ,/* 狀態碼 */
nmbe001       varchar2(10)      ,/* 收支項目版本 */
nmbe002       varchar2(10)      ,/* 收支項目代碼 */
nmbe003       varchar2(10)      ,/* 存提碼 */
nmbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmbe_t add constraint nmbe_pk primary key (nmbeent,nmbe001,nmbe002,nmbe003) enable validate;

create unique index nmbe_pk on nmbe_t (nmbeent,nmbe001,nmbe002,nmbe003);

grant select on nmbe_t to tiptop;
grant update on nmbe_t to tiptop;
grant delete on nmbe_t to tiptop;
grant insert on nmbe_t to tiptop;

exit;
