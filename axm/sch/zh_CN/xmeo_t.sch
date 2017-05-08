/* 
================================================================================
檔案代號:xmeo_t
檔案名稱:派車單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeo_t
(
xmeoent       number(5)      ,/* 企業編號 */
xmeosite       varchar2(10)      ,/* 營運據點 */
xmeodocno       varchar2(20)      ,/* 派車單號 */
xmeoseq       number(10,0)      ,/* 項次 */
xmeo001       varchar2(10)      ,/* 來源類型 */
xmeo002       varchar2(20)      ,/* 來源單號 */
xmeo003       number(10,0)      ,/* 來源項次 */
xmeo004       varchar2(10)      ,/* 交易對象編號 */
xmeo005       varchar2(10)      ,/* 送貨地址碼 */
xmeo006       varchar2(40)      ,/* 料件編號 */
xmeo007       number(20,6)      ,/* 數量 */
xmeo008       varchar2(10)      ,/* 單位 */
xmeo009       varchar2(10)      ,/* 重量單位 */
xmeo010       number(20,6)      ,/* 淨重 */
xmeo011       number(20,6)      ,/* 毛重 */
xmeo012       date      ,/* 預計到達日期 */
xmeo013       varchar2(8)      ,/* 預計到達時間 */
xmeo014       date      ,/* 實際到達日期 */
xmeo015       varchar2(8)      ,/* 實際到達時間 */
xmeoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmeo_t add constraint xmeo_pk primary key (xmeoent,xmeodocno,xmeoseq) enable validate;

create unique index xmeo_pk on xmeo_t (xmeoent,xmeodocno,xmeoseq);

grant select on xmeo_t to tiptop;
grant update on xmeo_t to tiptop;
grant delete on xmeo_t to tiptop;
grant insert on xmeo_t to tiptop;

exit;
