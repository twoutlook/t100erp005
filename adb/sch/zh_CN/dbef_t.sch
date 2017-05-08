/* 
================================================================================
檔案代號:dbef_t
檔案名稱:配送排車單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table dbef_t
(
dbefent       number(5)      ,/* 企業編號 */
dbefsite       varchar2(10)      ,/* 營運據點 */
dbefunit       varchar2(10)      ,/* 應用組織 */
dbefdocno       varchar2(20)      ,/* 單據編號 */
dbefseq       number(10,0)      ,/* 項次 */
dbef000       varchar2(10)      ,/* 來源類型 */
dbef001       varchar2(20)      ,/* 來源單據編號 */
dbef002       number(10,0)      ,/* 來源單據項次 */
dbef003       date      ,/* 出貨日期 */
dbef004       varchar2(10)      ,/* 送貨客戶編號 */
dbef005       varchar2(40)      ,/* 產品編號 */
dbef006       varchar2(10)      ,/* 單位 */
dbef007       number(20,6)      ,/* 數量 */
dbef008       varchar2(10)      ,/* 包裝單位 */
dbef009       number(20,6)      ,/* 包裝數量 */
dbef010       varchar2(40)      ,/* 商品條碼 */
dbef011       number(20,6)      ,/* 重量 */
dbef012       number(20,6)      ,/* 體積 */
dbef013       varchar2(10)      ,/* 站點 */
dbef014       varchar2(10)      ,/* 片區 */
dbef015       number(5,0)      ,/* 卸貨順序 */
dbef016       varchar2(255)      ,/* 備註 */
dbefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbefud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbef_t add constraint dbef_pk primary key (dbefent,dbefdocno,dbefseq) enable validate;

create unique index dbef_pk on dbef_t (dbefent,dbefdocno,dbefseq);

grant select on dbef_t to tiptop;
grant update on dbef_t to tiptop;
grant delete on dbef_t to tiptop;
grant insert on dbef_t to tiptop;

exit;
