/* 
================================================================================
檔案代號:stci_t
檔案名稱:分銷費用單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stci_t
(
stcient       number(5)      ,/* 企業編號 */
stcisite       varchar2(10)      ,/* 營運據點 */
stciunit       varchar2(10)      ,/* 應用組織 */
stcidocno       varchar2(20)      ,/* 單據編號 */
stcidocdt       date      ,/* 單據日期 */
stci001       varchar2(10)      ,/* 客戶類別 */
stci002       varchar2(10)      ,/* 經銷商編號 */
stci003       varchar2(10)      ,/* 網點編號 */
stci004       varchar2(10)      ,/* 經營方式 */
stci005       varchar2(10)      ,/* 結算方式 */
stci006       varchar2(10)      ,/* 結算類型 */
stci007       varchar2(20)      ,/* 人員 */
stci008       varchar2(10)      ,/* 部門 */
stci009       varchar2(10)      ,/* 結算中心 */
stci010       varchar2(10)      ,/* 來源類別 */
stci011       varchar2(20)      ,/* 來源單號 */
stci012       varchar2(30)      ,/* 促銷單號 */
stci013       varchar2(10)      ,/* 銷售組織 */
stci014       varchar2(10)      ,/* 銷售範圍 */
stci015       varchar2(10)      ,/* 銷售渠道 */
stci016       varchar2(10)      ,/* 產品組 */
stci017       varchar2(10)      ,/* 辦事處 */
stci018       varchar2(10)      ,/* 幣別 */
stci019       varchar2(10)      ,/* 稅別 */
stci020       varchar2(10)      ,/* 專項編碼 */
stci021       varchar2(10)      ,/* 回饋方式 */
stci022       varchar2(10)      ,/* 回饋金額類別 */
stci023       number(20,6)      ,/* 投入費用金額 */
stci024       number(20,6)      ,/* 經銷商承擔金額 */
stci025       number(20,6)      ,/* 內部承擔金額 */
stcistus       varchar2(10)      ,/* 狀態碼 */
stciownid       varchar2(20)      ,/* 資料所有者 */
stciowndp       varchar2(10)      ,/* 資料所屬部門 */
stcicrtid       varchar2(20)      ,/* 資料建立者 */
stcicrtdp       varchar2(10)      ,/* 資料建立部門 */
stcicrtdt       timestamp(0)      ,/* 資料創建日 */
stcimodid       varchar2(20)      ,/* 資料修改者 */
stcimoddt       timestamp(0)      ,/* 最近修改日 */
stcicnfid       varchar2(20)      ,/* 資料確認者 */
stcicnfdt       timestamp(0)      ,/* 資料確認日 */
stci000       varchar2(20)      ,/* 合同編號 */
stciud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stciud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stciud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stciud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stciud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stciud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stciud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stciud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stciud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stciud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stciud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stciud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stciud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stciud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stciud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stciud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stciud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stciud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stciud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stciud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stciud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stciud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stciud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stciud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stciud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stciud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stciud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stciud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stciud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stciud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stci_t add constraint stci_pk primary key (stcient,stcidocno) enable validate;

create unique index stci_pk on stci_t (stcient,stcidocno);

grant select on stci_t to tiptop;
grant update on stci_t to tiptop;
grant delete on stci_t to tiptop;
grant insert on stci_t to tiptop;

exit;
