/* 
================================================================================
檔案代號:stcm_t
檔案名稱:分銷客戶合作進場協議資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stcm_t
(
stcment       number(5)      ,/* 企業編號 */
stcmsite       varchar2(10)      ,/* 營運據點 */
stcmunit       varchar2(10)      ,/* 應用組織 */
stcmdocno       varchar2(20)      ,/* 單據編號 */
stcmdocdt       date      ,/* 單據日期 */
stcm001       varchar2(20)      ,/* 合同編號 */
stcm002       varchar2(10)      ,/* 客戶類型 */
stcm003       varchar2(10)      ,/* 經銷商編號 */
stcm004       varchar2(10)      ,/* 網點編號 */
stcm005       varchar2(10)      ,/* 經營方式 */
stcm006       varchar2(10)      ,/* 結算方式 */
stcm007       varchar2(10)      ,/* 結算類型 */
stcm008       varchar2(20)      ,/* 人員 */
stcm009       varchar2(10)      ,/* 部門 */
stcm010       varchar2(10)      ,/* 結算中心 */
stcm011       varchar2(10)      ,/* 銷售組織 */
stcm012       varchar2(10)      ,/* 銷售範圍 */
stcm013       varchar2(10)      ,/* 銷售渠道 */
stcm014       varchar2(10)      ,/* 產品組 */
stcm015       varchar2(10)      ,/* 辦事處 */
stcm016       varchar2(10)      ,/* 幣別 */
stcm017       varchar2(10)      ,/* 稅目 */
stcm018       date      ,/* 開始日期 */
stcm019       date      ,/* 截止日期 */
stcmstus       varchar2(10)      ,/* 狀態碼 */
stcmownid       varchar2(20)      ,/* 資料所有者 */
stcmowndp       varchar2(10)      ,/* 資料所屬部門 */
stcmcrtid       varchar2(20)      ,/* 資料建立者 */
stcmcrtdp       varchar2(10)      ,/* 資料建立部門 */
stcmcrtdt       timestamp(0)      ,/* 資料創建日 */
stcmmodid       varchar2(20)      ,/* 資料修改者 */
stcmmoddt       timestamp(0)      ,/* 最近修改日 */
stcmcnfid       varchar2(20)      ,/* 資料確認者 */
stcmcnfdt       timestamp(0)      ,/* 資料確認日 */
stcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcm_t add constraint stcm_pk primary key (stcment,stcmdocno) enable validate;

create unique index stcm_pk on stcm_t (stcment,stcmdocno);

grant select on stcm_t to tiptop;
grant update on stcm_t to tiptop;
grant delete on stcm_t to tiptop;
grant insert on stcm_t to tiptop;

exit;
