/* 
================================================================================
檔案代號:bmaa_t
檔案名稱:產品結構單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bmaa_t
(
bmaaent       number(5)      ,/* 企業編號 */
bmaasite       varchar2(10)      ,/* 營運據點 */
bmaastus       varchar2(10)      ,/* 狀態碼 */
bmaa001       varchar2(40)      ,/* 主件料號 */
bmaa002       varchar2(30)      ,/* 特性 */
bmaa003       number(20,6)      ,/* 批次數量 */
bmaa004       varchar2(10)      ,/* 生產單位 */
bmaaownid       varchar2(20)      ,/* 資料所有者 */
bmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmaacrtid       varchar2(20)      ,/* 資料建立者 */
bmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmaacrtdt       timestamp(0)      ,/* 資料創建日 */
bmaamodid       varchar2(20)      ,/* 資料修改者 */
bmaamoddt       timestamp(0)      ,/* 最近修改日 */
bmaacnfid       varchar2(20)      ,/* 資料確認者 */
bmaacnfdt       timestamp(0)      ,/* 資料確認日 */
bmaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmaa_t add constraint bmaa_pk primary key (bmaaent,bmaasite,bmaa001,bmaa002) enable validate;

create  index bmaa_01 on bmaa_t (bmaa001,bmaa002);
create unique index bmaa_pk on bmaa_t (bmaaent,bmaasite,bmaa001,bmaa002);

grant select on bmaa_t to tiptop;
grant update on bmaa_t to tiptop;
grant delete on bmaa_t to tiptop;
grant insert on bmaa_t to tiptop;

exit;
