/* 
================================================================================
檔案代號:stcn_t
檔案名稱:分銷客戶合作進場協議條款明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcn_t
(
stcnent       number(5)      ,/* 企業編號 */
stcnunit       varchar2(10)      ,/* 應用組織 */
stcnsite       varchar2(10)      ,/* 營運據點 */
stcndocno       varchar2(20)      ,/* 單據編號 */
stcnseq       number(10,0)      ,/* 項次 */
stcn001       varchar2(10)      ,/* 費用編號 */
stcn002       varchar2(10)      ,/* 幣別 */
stcn003       varchar2(10)      ,/* 稅別 */
stcn004       varchar2(10)      ,/* 價款類別 */
stcn005       date      ,/* 生效日期 */
stcn006       number(20,6)      ,/* 費用金額 */
stcn007       date      ,/* 下次計算日 */
stcn008       varchar2(10)      ,/* 對象類型 */
stcn009       varchar2(10)      ,/* 經銷商 */
stcn010       varchar2(10)      ,/* 網點 */
stcn011       varchar2(10)      ,/* 經銷方式 */
stcn012       varchar2(10)      ,/* 結算類型 */
stcn013       varchar2(10)      ,/* 結算方式 */
stcn014       varchar2(10)      ,/* 銷售組織 */
stcn015       varchar2(10)      ,/* 銷售範圍 */
stcn016       varchar2(10)      ,/* 銷售渠道 */
stcn017       varchar2(10)      ,/* 產品組 */
stcn018       varchar2(10)      ,/* 辦事處 */
stcn019       varchar2(80)      ,/* 備註 */
stcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcn_t add constraint stcn_pk primary key (stcnent,stcndocno,stcnseq) enable validate;

create unique index stcn_pk on stcn_t (stcnent,stcndocno,stcnseq);

grant select on stcn_t to tiptop;
grant update on stcn_t to tiptop;
grant delete on stcn_t to tiptop;
grant insert on stcn_t to tiptop;

exit;
