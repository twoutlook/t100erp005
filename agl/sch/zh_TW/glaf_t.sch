/* 
================================================================================
檔案代號:glaf_t
檔案名稱:自由核算項資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glaf_t
(
glafent       number(5)      ,/* 企業編號 */
glafownid       varchar2(20)      ,/* 資料所有者 */
glafowndp       varchar2(10)      ,/* 資料所屬部門 */
glafcrtid       varchar2(20)      ,/* 資料建立者 */
glafcrtdp       varchar2(10)      ,/* 資料建立部門 */
glafcrtdt       timestamp(0)      ,/* 資料創建日 */
glafmodid       varchar2(20)      ,/* 資料修改者 */
glafmoddt       timestamp(0)      ,/* 最近修改日 */
glafstus       varchar2(10)      ,/* 狀態碼 */
glaf001       varchar2(10)      ,/* 自由核算項類型編號 */
glaf002       varchar2(30)      ,/* 核算項值 */
glafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glaf_t add constraint glaf_pk primary key (glafent,glaf001,glaf002) enable validate;

create unique index glaf_pk on glaf_t (glafent,glaf001,glaf002);

grant select on glaf_t to tiptop;
grant update on glaf_t to tiptop;
grant delete on glaf_t to tiptop;
grant insert on glaf_t to tiptop;

exit;
