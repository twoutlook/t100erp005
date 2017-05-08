/* 
================================================================================
檔案代號:bgcd_t
檔案名稱:計價因子主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgcd_t
(
bgcdent       number(5)      ,/* 企業編號 */
bgcd001       varchar2(10)      ,/* 計價因子 */
bgcdstus       varchar2(10)      ,/* 狀態碼 */
bgcdownid       varchar2(20)      ,/* 資料所有者 */
bgcdowndp       varchar2(10)      ,/* 資料所屬部門 */
bgcdcrtid       varchar2(20)      ,/* 資料建立者 */
bgcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgcdcrtdt       timestamp(0)      ,/* 資料創建日 */
bgcdmodid       varchar2(20)      ,/* 資料修改者 */
bgcdmoddt       timestamp(0)      ,/* 最近修改日 */
bgcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgcd_t add constraint bgcd_pk primary key (bgcdent,bgcd001) enable validate;

create unique index bgcd_pk on bgcd_t (bgcdent,bgcd001);

grant select on bgcd_t to tiptop;
grant update on bgcd_t to tiptop;
grant delete on bgcd_t to tiptop;
grant insert on bgcd_t to tiptop;

exit;
