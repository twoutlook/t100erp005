/* 
================================================================================
檔案代號:dbag_t
檔案名稱:發貨組織境外倉庫資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbag_t
(
dbagent       number(5)      ,/* 企業編號 */
dbagsite       varchar2(10)      ,/* 營運據點 */
dbag001       varchar2(10)      ,/* 倉庫類別 */
dbag002       varchar2(10)      ,/* 客戶編號/代送商編號 */
dbag003       varchar2(10)      ,/* 送貨客戶編號 */
dbag004       varchar2(10)      ,/* 成本倉庫 */
dbag005       varchar2(10)      ,/* 成本儲位 */
dbag006       varchar2(10)      ,/* 非成本倉庫 */
dbag007       varchar2(10)      ,/* 非成本儲位 */
dbagstus       varchar2(10)      ,/* 狀態碼 */
dbagownid       varchar2(20)      ,/* 資料所有者 */
dbagowndp       varchar2(10)      ,/* 資料所屬部門 */
dbagcrtid       varchar2(20)      ,/* 資料建立者 */
dbagcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbagcrtdt       timestamp(0)      ,/* 資料創建日 */
dbagmodid       varchar2(20)      ,/* 資料修改者 */
dbagmoddt       timestamp(0)      ,/* 最近修改日 */
dbagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbag_t add constraint dbag_pk primary key (dbagent,dbagsite,dbag001,dbag002,dbag003) enable validate;

create unique index dbag_pk on dbag_t (dbagent,dbagsite,dbag001,dbag002,dbag003);

grant select on dbag_t to tiptop;
grant update on dbag_t to tiptop;
grant delete on dbag_t to tiptop;
grant insert on dbag_t to tiptop;

exit;
