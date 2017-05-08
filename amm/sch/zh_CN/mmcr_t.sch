/* 
================================================================================
檔案代號:mmcr_t
檔案名稱:會員等級升降策略申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmcr_t
(
mmcrent       number(5)      ,/* 企業編號 */
mmcrunit       varchar2(10)      ,/* 應用組織 */
mmcrsite       varchar2(10)      ,/* 營運據點 */
mmcrdocno       varchar2(20)      ,/* 單號 */
mmcrdocdt       date      ,/* 單據日期 */
mmcr000       varchar2(10)      ,/* 異動類型 */
mmcr001       varchar2(30)      ,/* 升降等策略編號 */
mmcr002       varchar2(10)      ,/* 版本 */
mmcr003       varchar2(80)      ,/* 升降等策略說明 */
mmcr004       varchar2(1)      ,/* 跨級升降等 */
mmcr005       varchar2(1)      ,/* 允許降等 */
mmcracti       varchar2(1)      ,/* 資料有效碼 */
mmcrownid       varchar2(20)      ,/* 資料所有者 */
mmcrowndp       varchar2(10)      ,/* 資料所屬部門 */
mmcrcrtid       varchar2(20)      ,/* 資料建立者 */
mmcrcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmcrcrtdt       timestamp(0)      ,/* 資料創建日 */
mmcrmodid       varchar2(20)      ,/* 資料修改者 */
mmcrmoddt       timestamp(0)      ,/* 最近修改日 */
mmcrstus       varchar2(10)      ,/* 狀態碼 */
mmcrcnfid       varchar2(20)      ,/* 資料確認者 */
mmcrcnfdt       timestamp(0)      ,/* 資料確認日 */
mmcrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcr_t add constraint mmcr_pk primary key (mmcrent,mmcrdocno) enable validate;

create unique index mmcr_pk on mmcr_t (mmcrent,mmcrdocno);

grant select on mmcr_t to tiptop;
grant update on mmcr_t to tiptop;
grant delete on mmcr_t to tiptop;
grant insert on mmcr_t to tiptop;

exit;
