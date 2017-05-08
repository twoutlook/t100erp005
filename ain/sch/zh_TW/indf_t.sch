/* 
================================================================================
檔案代號:indf_t
檔案名稱:調撥差異調整單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indf_t
(
indfent       number(5)      ,/* 企業編號 */
indfsite       varchar2(10)      ,/* 營運據點 */
indfunit       varchar2(10)      ,/* 應用組織 */
indfdocno       varchar2(20)      ,/* 單號 */
indfseq       number(10,0)      ,/* 項次 */
indf001       number(10,0)      ,/* 來源項次 */
indf002       varchar2(40)      ,/* 商品編號 */
indf003       varchar2(40)      ,/* 商品條碼 */
indf004       varchar2(256)      ,/* 產品特徵 */
indf005       varchar2(10)      ,/* 經營方式 */
indf006       varchar2(10)      ,/* 庫存單位 */
indf007       varchar2(10)      ,/* 包裝單位 */
indf008       number(20,6)      ,/* 件裝數 */
indf020       number(20,6)      ,/* 撥出件數 */
indf021       number(20,6)      ,/* 撥出數量 */
indf022       varchar2(10)      ,/* 撥出庫位 */
indf023       varchar2(10)      ,/* 撥出儲位 */
indf024       varchar2(30)      ,/* 撥出批號 */
indf030       number(20,6)      ,/* 撥入件數 */
indf031       number(20,6)      ,/* 撥入數量 */
indf032       varchar2(10)      ,/* 撥入庫位 */
indf033       varchar2(10)      ,/* 撥入儲位 */
indf034       varchar2(30)      ,/* 撥入批號 */
indf040       number(20,6)      ,/* 申請調整數量 */
indf041       number(20,6)      ,/* 核准數量 */
indf042       varchar2(10)      ,/* 原因碼 */
indf043       varchar2(255)      ,/* 備註 */
indf101       varchar2(20)      ,/* 來源調撥單號 */
indf102       varchar2(30)      ,/* 庫存管理特徵 */
indf103       number(20,6)      ,/* 撥入方權責量 */
indf104       varchar2(10)      ,/* 參考單位 */
indf105       number(20,6)      ,/* 撥出方權責參考數量 */
indf106       number(20,6)      ,/* 撥入方權責參考數量 */
indfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
indf044       varchar2(10)      ,/* 撥入單位 */
indf009       number(10,0)      ,/* 來源項序 */
indf045       number(20,6)      ,/* 預估單價 */
indf046       number(20,6)      ,/* 預估金額 */
indf047       number(20,6)      ,/* 成本單價 */
indf048       number(20,6)      /* 成本金額 */
);
alter table indf_t add constraint indf_pk primary key (indfent,indfdocno,indfseq) enable validate;

create unique index indf_pk on indf_t (indfent,indfdocno,indfseq);

grant select on indf_t to tiptop;
grant update on indf_t to tiptop;
grant delete on indf_t to tiptop;
grant insert on indf_t to tiptop;

exit;
