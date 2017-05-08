/* 
================================================================================
檔案代號:pmdf_t
檔案名稱:詢價單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmdf_t
(
pmdfent       number(5)      ,/* 企業編號 */
pmdfownid       varchar2(20)      ,/* 資料所有者 */
pmdfowndp       varchar2(10)      ,/* 資料所屬部門 */
pmdfcrtid       varchar2(20)      ,/* 資料建立者 */
pmdfcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmdfcrtdt       timestamp(0)      ,/* 資料創建日 */
pmdfmodid       varchar2(20)      ,/* 資料修改者 */
pmdfmoddt       timestamp(0)      ,/* 最近修改日 */
pmdfcnfid       varchar2(20)      ,/* 資料確認者 */
pmdfcnfdt       timestamp(0)      ,/* 資料確認日 */
pmdfstus       varchar2(10)      ,/* 狀態碼 */
pmdfsite       varchar2(10)      ,/* 營運據點 */
pmdfdocno       varchar2(20)      ,/* 詢價單號 */
pmdfdocdt       date      ,/* 單據日期 */
pmdf001       varchar2(1)      ,/* 委外否 */
pmdf002       varchar2(20)      ,/* 詢價人員 */
pmdf003       varchar2(10)      ,/* 詢價部門 */
pmdf004       varchar2(10)      ,/* 詢價供應商 */
pmdf005       varchar2(10)      ,/* 幣別 */
pmdf006       varchar2(10)      ,/* 稅別 */
pmdf007       number(5,2)      ,/* 稅率 */
pmdf008       varchar2(1)      ,/* 單價含稅否 */
pmdf009       varchar2(10)      ,/* 付款條件 */
pmdf010       varchar2(10)      ,/* 交易條件 */
pmdf030       varchar2(255)      ,/* 備註 */
pmdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdf_t add constraint pmdf_pk primary key (pmdfent,pmdfdocno) enable validate;

create unique index pmdf_pk on pmdf_t (pmdfent,pmdfdocno);

grant select on pmdf_t to tiptop;
grant update on pmdf_t to tiptop;
grant delete on pmdf_t to tiptop;
grant insert on pmdf_t to tiptop;

exit;
