/* 
================================================================================
檔案代號:bmga_t
檔案名稱:BOM群組替代單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bmga_t
(
bmgaent       number(5)      ,/* 企業編號 */
bmgasite       varchar2(10)      ,/* 營運據點 */
bmga001       varchar2(40)      ,/* 主件料號 */
bmga002       varchar2(30)      ,/* 特性/版本 */
bmga003       varchar2(10)      ,/* 替代群組 */
bmga004       date      ,/* 生效日期 */
bmga005       date      ,/* 失效日期 */
bmgaownid       varchar2(20)      ,/* 資料所有者 */
bmgaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmgacrtid       varchar2(20)      ,/* 資料建立者 */
bmgacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmgacrtdt       timestamp(0)      ,/* 資料創建日 */
bmgamodid       varchar2(20)      ,/* 資料修改者 */
bmgamoddt       timestamp(0)      ,/* 最近修改日 */
bmgacnfid       varchar2(20)      ,/* 資料確認者 */
bmgacnfdt       timestamp(0)      ,/* 資料確認日 */
bmgastus       varchar2(10)      ,/* 狀態碼 */
bmgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmga_t add constraint bmga_pk primary key (bmgaent,bmgasite,bmga001,bmga002,bmga003) enable validate;

create unique index bmga_pk on bmga_t (bmgaent,bmgasite,bmga001,bmga002,bmga003);

grant select on bmga_t to tiptop;
grant update on bmga_t to tiptop;
grant delete on bmga_t to tiptop;
grant insert on bmga_t to tiptop;

exit;
