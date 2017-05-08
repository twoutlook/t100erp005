/* 
================================================================================
檔案代號:pmcr_t
檔案名稱:庫存組織要貨範圍設定-採購方式範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmcr_t
(
pmcrent       number(5)      ,/* 企業編號 */
pmcrsite       varchar2(10)      ,/* 營運據點 */
pmcr001       varchar2(10)      ,/* 庫位編號 */
pmcr002       varchar2(10)      ,/* 採購方式 */
pmcrstus       varchar2(10)      ,/* 狀態 */
pmcrownid       varchar2(20)      ,/* 資料所有者 */
pmcrowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcrcrtid       varchar2(20)      ,/* 資料建立者 */
pmcrcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcrcrtdt       timestamp(0)      ,/* 資料創建日 */
pmcrmodid       varchar2(20)      ,/* 資料修改者 */
pmcrmoddt       timestamp(0)      ,/* 最近修改日 */
pmcrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmcr_t add constraint pmcr_pk primary key (pmcrent,pmcrsite,pmcr001,pmcr002) enable validate;

create unique index pmcr_pk on pmcr_t (pmcrent,pmcrsite,pmcr001,pmcr002);

grant select on pmcr_t to tiptop;
grant update on pmcr_t to tiptop;
grant delete on pmcr_t to tiptop;
grant insert on pmcr_t to tiptop;

exit;
