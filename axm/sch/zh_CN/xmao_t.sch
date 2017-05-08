/* 
================================================================================
檔案代號:xmao_t
檔案名稱:嘜頭基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmao_t
(
xmaoent       number(5)      ,/* 企業編號 */
xmao001       varchar2(10)      ,/* 客戶編號 */
xmao002       varchar2(10)      ,/* 嘜頭編號 */
xmao003       varchar2(10)      ,/* 資料多筆時顯示方式 */
xmao004       varchar2(80)      ,/* 資料間間隔符號 */
xmaoownid       varchar2(20)      ,/* 資料所有者 */
xmaoowndp       varchar2(10)      ,/* 資料所屬部門 */
xmaocrtid       varchar2(20)      ,/* 資料建立者 */
xmaocrtdp       varchar2(10)      ,/* 資料建立部門 */
xmaocrtdt       timestamp(0)      ,/* 資料創建日 */
xmaomodid       varchar2(20)      ,/* 資料修改者 */
xmaomoddt       timestamp(0)      ,/* 最近修改日 */
xmaostus       varchar2(10)      ,/* 狀態碼 */
xmaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmao_t add constraint xmao_pk primary key (xmaoent,xmao001,xmao002) enable validate;

create unique index xmao_pk on xmao_t (xmaoent,xmao001,xmao002);

grant select on xmao_t to tiptop;
grant update on xmao_t to tiptop;
grant delete on xmao_t to tiptop;
grant insert on xmao_t to tiptop;

exit;
