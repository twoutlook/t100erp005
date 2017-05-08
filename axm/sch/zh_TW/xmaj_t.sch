/* 
================================================================================
檔案代號:xmaj_t
檔案名稱:信用評等公式資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmaj_t
(
xmajent       number(5)      ,/* 企業編號 */
xmaj001       varchar2(10)      ,/* 信用評等編號 */
xmaj002       varchar2(10)      ,/* 訂單列印時超限控管方式 */
xmaj003       varchar2(10)      ,/* 訂單確認時超限控管方式 */
xmaj004       varchar2(10)      ,/* 出通單列印時超限控管方式 */
xmaj005       varchar2(10)      ,/* 出通單確認時超限控管方式 */
xmaj006       varchar2(10)      ,/* 出貨單列印時超限控管方式 */
xmaj007       varchar2(10)      ,/* 出貨單確認時超限控管方式 */
xmajownid       varchar2(20)      ,/* 資料所有者 */
xmajowndp       varchar2(10)      ,/* 資料所屬部門 */
xmajcrtid       varchar2(20)      ,/* 資料建立者 */
xmajcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmajcrtdt       timestamp(0)      ,/* 資料創建日 */
xmajmodid       varchar2(20)      ,/* 資料修改者 */
xmajmoddt       timestamp(0)      ,/* 最近修改日 */
xmajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmaj_t add constraint xmaj_pk primary key (xmajent,xmaj001) enable validate;

create unique index xmaj_pk on xmaj_t (xmajent,xmaj001);

grant select on xmaj_t to tiptop;
grant update on xmaj_t to tiptop;
grant delete on xmaj_t to tiptop;
grant insert on xmaj_t to tiptop;

exit;
