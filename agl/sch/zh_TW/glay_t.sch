/* 
================================================================================
檔案代號:glay_t
檔案名稱:傳票項次沖帳異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glay_t
(
glayent       number(5)      ,/* 企業編號 */
glayownid       varchar2(20)      ,/* 資料所有者 */
glayowndp       varchar2(10)      ,/* 資料所屬部門 */
glaycrtid       varchar2(20)      ,/* 資料建立者 */
glaycrtdp       varchar2(10)      ,/* 資料建立部門 */
glaycrtdt       timestamp(0)      ,/* 資料創建日 */
glaymodid       varchar2(20)      ,/* 資料修改者 */
glaymoddt       timestamp(0)      ,/* 最近修改日 */
glaycnfid       varchar2(20)      ,/* 資料確認者 */
glaycnfdt       timestamp(0)      ,/* 資料確認日 */
glaystus       varchar2(10)      ,/* 狀態碼 */
glayld       varchar2(5)      ,/* 帳套 */
glaycomp       varchar2(10)      ,/* 法人 */
glaydocno       varchar2(20)      ,/* 沖帳傳票單號 */
glayseq       number(10,0)      ,/* 沖帳傳票項次 */
glaydocdt       date      ,/* 沖帳傳票日期 */
glayseq1       number(10,0)      ,/* 行序 */
glay001       varchar2(255)      ,/* 摘要 */
glay002       varchar2(24)      ,/* 科目編號 */
glay003       number(20,6)      ,/* 本幣沖帳金額 */
glay005       varchar2(10)      ,/* 交易幣別 */
glay006       number(20,10)      ,/* 匯率 */
glay007       varchar2(10)      ,/* 計價單位 */
glay008       number(20,6)      ,/* 沖帳數量 */
glay009       number(20,6)      ,/* 單價 */
glay010       number(20,6)      ,/* 原幣沖帳金額 */
glay011       varchar2(20)      ,/* 票據號碼 */
glay012       date      ,/* 票據日期 */
glay013       varchar2(20)      ,/* 申請人 */
glay014       varchar2(30)      ,/* 銀行帳號 */
glay015       varchar2(10)      ,/* 結算方式 */
glay016       varchar2(10)      ,/* 收支專案 */
glay017       varchar2(10)      ,/* 營運據點 */
glay018       varchar2(10)      ,/* 部門 */
glay019       varchar2(10)      ,/* 利潤/成本中心 */
glay020       varchar2(10)      ,/* 區域 */
glay021       varchar2(10)      ,/* 收付款客商 */
glay022       varchar2(10)      ,/* 帳款客商 */
glay023       varchar2(10)      ,/* 客群 */
glay024       varchar2(10)      ,/* 產品類別 */
glay025       varchar2(20)      ,/* 人員 */
glay026       varchar2(10)      ,/* no use */
glay027       varchar2(20)      ,/* 專案編號 */
glay028       varchar2(30)      ,/* WBS */
glay029       varchar2(30)      ,/* 自由核算項一 */
glay030       varchar2(30)      ,/* 自由核算項二 */
glay031       varchar2(30)      ,/* 自由核算項三 */
glay032       varchar2(30)      ,/* 自由核算項四 */
glay033       varchar2(30)      ,/* 自由核算項五 */
glay034       varchar2(30)      ,/* 自由核算項六 */
glay035       varchar2(30)      ,/* 自由核算項七 */
glay036       varchar2(30)      ,/* 自由核算項八 */
glay037       varchar2(30)      ,/* 自由核算項九 */
glay038       varchar2(30)      ,/* 自由核算項十 */
glay041       varchar2(20)      ,/* 立帳傳票編號 */
glay042       number(10,0)      ,/* 立帳傳票項次 */
glay049       number(5,0)      ,/* 會計年度 */
glay050       number(5,0)      ,/* 會計期別 */
glay051       number(20,10)      ,/* 匯率(本位幣二) */
glay052       number(20,6)      ,/* 沖帳金額(本位幣二) */
glay053       number(20,10)      ,/* 匯率(本位幣三) */
glay054       number(20,6)      ,/* 沖帳金額(本位幣三) */
glay061       varchar2(10)      ,/* 經營方式 */
glay062       varchar2(10)      ,/* 通路 */
glay063       varchar2(10)      ,/* 品牌 */
glayud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glayud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glayud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glayud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glayud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glayud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glayud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glayud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glayud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glayud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glayud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glayud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glayud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glayud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glayud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glayud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glayud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glayud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glayud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glayud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glayud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glayud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glayud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glayud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glayud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glayud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glayud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glayud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glayud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glayud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glay_t add constraint glay_pk primary key (glayent,glayld,glaydocno,glayseq,glayseq1) enable validate;

create unique index glay_pk on glay_t (glayent,glayld,glaydocno,glayseq,glayseq1);

grant select on glay_t to tiptop;
grant update on glay_t to tiptop;
grant delete on glay_t to tiptop;
grant insert on glay_t to tiptop;

exit;
