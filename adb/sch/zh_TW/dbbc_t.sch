/* 
================================================================================
檔案代號:dbbc_t
檔案名稱:銷售範圍基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbbc_t
(
dbbcent       number(5)      ,/* 企業編號 */
dbbc001       varchar2(10)      ,/* 銷售範圍編號 */
dbbc002       varchar2(10)      ,/* 銷售組織編號 */
dbbc003       varchar2(10)      ,/* 通路編號 */
dbbc004       varchar2(10)      ,/* 產品組編號 */
dbbc005       varchar2(10)      ,/* 辦事處編號 */
dbbcownid       varchar2(20)      ,/* 資料所有者 */
dbbcowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbccrtid       varchar2(20)      ,/* 資料建立者 */
dbbccrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbccrtdt       timestamp(0)      ,/* 資料創建日 */
dbbcmodid       varchar2(20)      ,/* 資料修改者 */
dbbcmoddt       timestamp(0)      ,/* 最近修改日 */
dbbcstus       varchar2(10)      ,/* 狀態碼 */
dbbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbc_t add constraint dbbc_pk primary key (dbbcent,dbbc001) enable validate;

create unique index dbbc_pk on dbbc_t (dbbcent,dbbc001);

grant select on dbbc_t to tiptop;
grant update on dbbc_t to tiptop;
grant delete on dbbc_t to tiptop;
grant insert on dbbc_t to tiptop;

exit;
