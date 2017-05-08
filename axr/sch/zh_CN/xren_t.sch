/* 
================================================================================
檔案代號:xren_t
檔案名稱:暫估帳務明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xren_t
(
xrenent       number(5)      ,/* 企業代碼 */
xrendocno       varchar2(20)      ,/* 單據編號 */
xrenseq       number(5,0)      ,/* 序號 */
xren001       number(5,0)      ,/* 年度 */
xren002       number(5,0)      ,/* 期別 */
xren003       varchar2(10)      ,/* 來源模組 */
xren004       varchar2(10)      ,/* 帳款單性質 */
xren005       varchar2(20)      ,/* 立帳單據號碼 */
xren006       number(10,0)      ,/* 項次 */
xren007       number(5,0)      ,/* 分期帳款序 */
xren008       date      ,/* 立帳日期 */
xren009       varchar2(10)      ,/* 帳款對象 */
xren010       varchar2(10)      ,/* 收款對象 */
xren011       varchar2(10)      ,/* 部門 */
xren012       varchar2(10)      ,/* 責任中心 */
xren013       varchar2(10)      ,/* 區域 */
xren014       varchar2(10)      ,/* 客群 */
xren015       varchar2(10)      ,/* 產品類別 */
xren016       varchar2(20)      ,/* 人員 */
xren017       varchar2(20)      ,/* 專案代號 */
xren018       varchar2(30)      ,/* WBS編號 */
xren019       varchar2(24)      ,/* 應收付科目 */
xrenorga       varchar2(10)      ,/* 來源組織 */
xren020       varchar2(10)      ,/* 經營方式 */
xren021       varchar2(10)      ,/* 渠道 */
xren022       varchar2(10)      ,/* 品牌 */
xren023       varchar2(30)      ,/* 自由核算項一 */
xren024       varchar2(30)      ,/* 自由核算項二 */
xren025       varchar2(30)      ,/* 自由核算項三 */
xren026       varchar2(30)      ,/* 自由核算項四 */
xren027       varchar2(30)      ,/* 自由核算項五 */
xren028       varchar2(30)      ,/* 自由核算項六 */
xren029       varchar2(30)      ,/* 自由核算項七 */
xren030       varchar2(30)      ,/* 自由核算項八 */
xren031       varchar2(30)      ,/* 自由核算項九 */
xren032       varchar2(30)      ,/* 自由核算項十 */
xren033       varchar2(255)      ,/* 摘要 */
xren040       varchar2(10)      ,/* 稅別 */
xren041       number(20,6)      ,/* 稅率 */
xren042       varchar2(24)      ,/* 稅別會科 */
xren043       varchar2(24)      ,/* 暫估費用/暫估收入科目 */
xren100       varchar2(10)      ,/* 幣別 */
xren101       number(20,6)      ,/* 匯率 */
xren103       number(20,6)      ,/* 原幣暫估金額 */
xren104       number(20,6)      ,/* 原幣暫估稅額 */
xren105       number(20,6)      ,/* 原幣暫估含稅金額 */
xren113       number(20,6)      ,/* 本幣暫估金額 */
xren114       number(20,6)      ,/* 本幣暫估稅額 */
xren115       number(20,6)      ,/* 本幣暫估含稅金額 */
xren121       number(20,10)      ,/* 本位幣二匯率 */
xren123       number(20,6)      ,/* 本位幣二暫估金額 */
xren124       number(20,6)      ,/* 本位幣二暫估稅額 */
xren125       number(20,6)      ,/* 本位幣二暫估含稅金額 */
xren131       number(20,10)      ,/* 本位幣三匯率 */
xren133       number(20,6)      ,/* 本位幣三暫估金額 */
xren134       number(20,6)      ,/* 本位幣三暫估稅額 */
xren135       number(20,6)      ,/* 本位幣三暫估含稅金額 */
xrenud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrenud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrenud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrenud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrenud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrenud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrenud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrenud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrenud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrenud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrenud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrenud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrenud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrenud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrenud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrenud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrenud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrenud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrenud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrenud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrenud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrenud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrenud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrenud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrenud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrenud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrenud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrenud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrenud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrenud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xren_t add constraint xren_pk primary key (xrenent,xrendocno,xrenseq) enable validate;

create unique index xren_pk on xren_t (xrenent,xrendocno,xrenseq);

grant select on xren_t to tiptop;
grant update on xren_t to tiptop;
grant delete on xren_t to tiptop;
grant insert on xren_t to tiptop;

exit;
