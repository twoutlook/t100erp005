/* 
================================================================================
檔案代號:srca_t
檔案名稱:重複性生產製程變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table srca_t
(
srcaent       number(5)      ,/* 企業代碼 */
srcasite       varchar2(10)      ,/* 營運據點 */
srca000       varchar2(1)      ,/* 類型 */
srca001       varchar2(10)      ,/* 生產計劃 */
srca002       varchar2(10)      ,/* 製程編號 */
srca004       varchar2(40)      ,/* 料件編號 */
srca005       varchar2(30)      ,/* BOM特性 */
srca006       varchar2(256)      ,/* 產品特徵 */
srca900       number(10,0)      ,/* 變更序 */
srca901       varchar2(1)      ,/* 變更類型 */
srca902       date      ,/* 變更日期 */
srca905       varchar2(10)      ,/* 變更理由 */
srca906       varchar2(255)      ,/* 變更備註 */
srcaownid       varchar2(20)      ,/* 資料所有者 */
srcaowndp       varchar2(10)      ,/* 資料所屬部門 */
srcacrtid       varchar2(20)      ,/* 資料建立者 */
srcacrtdp       varchar2(10)      ,/* 資料建立部門 */
srcacrtdt       timestamp(0)      ,/* 資料創建日 */
srcamodid       varchar2(20)      ,/* 資料修改者 */
srcamoddt       timestamp(0)      ,/* 最近修改日 */
srcacnfid       varchar2(20)      ,/* 資料確認者 */
srcacnfdt       timestamp(0)      ,/* 資料確認日 */
srcapstid       varchar2(20)      ,/* 資料過帳者 */
srcapstdt       timestamp(0)      ,/* 資料過帳日 */
srcastus       varchar2(10)      ,/* 狀態碼 */
srcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srca_t add constraint srca_pk primary key (srcaent,srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900) enable validate;

create unique index srca_pk on srca_t (srcaent,srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900);

grant select on srca_t to tiptop;
grant update on srca_t to tiptop;
grant delete on srca_t to tiptop;
grant insert on srca_t to tiptop;

exit;
