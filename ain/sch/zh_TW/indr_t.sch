/* 
================================================================================
檔案代號:indr_t
檔案名稱:批號數量更正單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table indr_t
(
indrent       number(5)      ,/* 企業編號 */
indrsite       varchar2(10)      ,/* 營運組織 */
indrunit       varchar2(10)      ,/* 應用組織 */
indrdocno       varchar2(20)      ,/* 單號 */
indrdocdt       date      ,/* 單據日期 */
indr000       varchar2(10)      ,/* 單據類別 */
indr001       varchar2(20)      ,/* 人員 */
indr002       varchar2(10)      ,/* 管理品類 */
indr003       varchar2(255)      ,/* 調整說明 */
indr004       varchar2(1)      ,/* 產生結算底稿否 */
indr005       varchar2(1)      ,/* 調整模式 */
indr006       varchar2(10)      ,/* 供應商編號 */
indrownid       varchar2(20)      ,/* 資料所有者 */
indrowndp       varchar2(10)      ,/* 資料所屬部門 */
indrcrtid       varchar2(20)      ,/* 資料建立者 */
indrcrtdp       varchar2(10)      ,/* 資料建立部門 */
indrcrtdt       timestamp(0)      ,/* 資料創建日 */
indrmodid       varchar2(20)      ,/* 資料修改者 */
indrmoddt       timestamp(0)      ,/* 最近修改日 */
indrcnfid       varchar2(20)      ,/* 資料確認者 */
indrcnfdt       timestamp(0)      ,/* 資料確認日 */
indrstus       varchar2(10)      ,/* 狀態碼 */
indrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indr_t add constraint indr_pk primary key (indrent,indrdocno) enable validate;

create unique index indr_pk on indr_t (indrent,indrdocno);

grant select on indr_t to tiptop;
grant update on indr_t to tiptop;
grant delete on indr_t to tiptop;
grant insert on indr_t to tiptop;

exit;
