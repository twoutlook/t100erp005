/* 
================================================================================
檔案代號:xrai_t
檔案名稱:據點收付款條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrai_t
(
xraient       number(5)      ,/* 企業編號 */
xraiownid       varchar2(20)      ,/* 資料所有者 */
xraiowndp       varchar2(10)      ,/* 資料所屬部門 */
xraicrtid       varchar2(20)      ,/* 資料建立者 */
xraicrtdp       varchar2(10)      ,/* 資料建立部門 */
xraicrtdt       timestamp(0)      ,/* 資料創建日 */
xraimodid       varchar2(20)      ,/* 資料修改者 */
xraimoddt       timestamp(0)      ,/* 最近修改日 */
xraistus       varchar2(10)      ,/* 狀態碼 */
xraisite       varchar2(10)      ,/* 營運據點 */
xrai001       varchar2(10)      ,/* 收付款條件編號 */
xrai002       varchar2(10)      ,/* 慣用多賬期類型 */
xraiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xraiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xraiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xraiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xraiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xraiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xraiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xraiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xraiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xraiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xraiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xraiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xraiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xraiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xraiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xraiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xraiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xraiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xraiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xraiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xraiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xraiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xraiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xraiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xraiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xraiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xraiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xraiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xraiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xraiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrai_t add constraint xrai_pk primary key (xraient,xraisite,xrai001) enable validate;

create unique index xrai_pk on xrai_t (xraient,xraisite,xrai001);

grant select on xrai_t to tiptop;
grant update on xrai_t to tiptop;
grant delete on xrai_t to tiptop;
grant insert on xrai_t to tiptop;

exit;
