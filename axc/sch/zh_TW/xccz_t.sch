/* 
================================================================================
檔案代號:xccz_t
檔案名稱:在製元件發料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table xccz_t
(
xcczent       number(5)      ,/* 企業編號 */
xcczcomp       varchar2(10)      ,/* 法人 */
xcczld       varchar2(5)      ,/* 帳套 */
xccz001       varchar2(1)      ,/* 帳套本位幣順序 */
xccz002       varchar2(30)      ,/* 成本域 */
xccz003       varchar2(10)      ,/* 成本計算類型 */
xccz004       number(5,0)      ,/* 年度 */
xccz005       number(5,0)      ,/* 期別 */
xccz006       varchar2(20)      ,/* 工單編號 */
xccz007       varchar2(40)      ,/* 元件編號 */
xccz008       varchar2(256)      ,/* 產品特徵 */
xccz009       varchar2(30)      ,/* 批號 */
xccz010       number(10,0)      ,/* 項次 */
xccz011       number(5,0)      ,/* 項序 */
xccz101       number(20,6)      ,/* 上期結存數量 */
xccz201       number(20,6)      ,/* 本期投入數量 */
xccz205       number(20,6)      ,/* 本期當站下線數量 */
xccz207       number(20,6)      ,/* 本期一般退料數量 */
xccz209       number(20,6)      ,/* 本期超領退數量 */
xccz301       number(20,6)      ,/* 本期轉出數量 */
xccz303       number(20,6)      ,/* 差異轉出數量 */
xccz307       number(20,6)      ,/* 盤差數量 */
xccz901       number(20,6)      ,/* 期末結存數量 */
xcczud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcczud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcczud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcczud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcczud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcczud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcczud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcczud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcczud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcczud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcczud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcczud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcczud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcczud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcczud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcczud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcczud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcczud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcczud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcczud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcczud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcczud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcczud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcczud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcczud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcczud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcczud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcczud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcczud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcczud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccz_t add constraint xccz_pk primary key (xcczent,xcczld,xccz001,xccz002,xccz003,xccz004,xccz005,xccz006,xccz007,xccz008,xccz009,xccz010,xccz011) enable validate;

create unique index xccz_pk on xccz_t (xcczent,xcczld,xccz001,xccz002,xccz003,xccz004,xccz005,xccz006,xccz007,xccz008,xccz009,xccz010,xccz011);

grant select on xccz_t to tiptop;
grant update on xccz_t to tiptop;
grant delete on xccz_t to tiptop;
grant insert on xccz_t to tiptop;

exit;
