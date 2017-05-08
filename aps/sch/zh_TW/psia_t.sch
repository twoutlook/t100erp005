/* 
================================================================================
檔案代號:psia_t
檔案名稱:採購預測單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table psia_t
(
psiaent       number(5)      ,/* 企業編號 */
psiasite       varchar2(10)      ,/* 營運據點 */
psia001       varchar2(10)      ,/* 預測編號 */
psia002       date      ,/* 預測起始日期 */
psia003       varchar2(10)      ,/* 供應商 */
psia004       varchar2(20)      ,/* 計畫員 */
psia005       varchar2(10)      ,/* 版本 */
psiaownid       varchar2(20)      ,/* 資料所有者 */
psiaowndp       varchar2(10)      ,/* 資料所屬部門 */
psiacrtid       varchar2(20)      ,/* 資料建立者 */
psiacrtdp       varchar2(10)      ,/* 資料建立部門 */
psiacrtdt       timestamp(0)      ,/* 資料創建日 */
psiamodid       varchar2(20)      ,/* 資料修改者 */
psiamoddt       timestamp(0)      ,/* 最近修改日 */
psiacnfid       varchar2(20)      ,/* 資料確認者 */
psiacnfdt       timestamp(0)      ,/* 資料確認日 */
psiastus       varchar2(10)      ,/* 狀態碼 */
psiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psiaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psia_t add constraint psia_pk primary key (psiaent,psiasite,psia001,psia002,psia003,psia004,psia005) enable validate;

create unique index psia_pk on psia_t (psiaent,psiasite,psia001,psia002,psia003,psia004,psia005);

grant select on psia_t to tiptop;
grant update on psia_t to tiptop;
grant delete on psia_t to tiptop;
grant insert on psia_t to tiptop;

exit;
