/* 
================================================================================
檔案代號:xreq_t
檔案名稱:各期遞延沖轉明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xreq_t
(
xreqent       number(5)      ,/* 企業代碼 */
xreqdocno       varchar2(20)      ,/* 單據號碼 */
xreqld       varchar2(5)      ,/* 帳別 */
xreqseq       number(10,0)      ,/* 項次 */
xreqorga       varchar2(10)      ,/* 來源組織 */
xreq001       number(5,0)      ,/* 年度 */
xreq002       number(5,0)      ,/* 期別 */
xreq003       varchar2(10)      ,/* 異動類型 */
xreq004       varchar2(20)      ,/* 交易單號 */
xreq005       number(10,0)      ,/* 交易單項次 */
xreq006       varchar2(20)      ,/* 帳款單號 */
xreq007       date      ,/* 立帳日期 */
xreq008       number(5,0)      ,/* 攤銷期別 */
xreq009       varchar2(10)      ,/* 攤銷類型 */
xreq010       varchar2(40)      ,/* 產品代碼 */
xreq011       number(20,6)      ,/* 本期已實現比例 */
xreq012       varchar2(24)      ,/* 遞延科目 */
xreq013       varchar2(24)      ,/* 沖轉認列收入科目 */
xreq014       varchar2(20)      ,/* 參考單號 */
xreq015       number(10,0)      ,/* 參考項次 */
xreq016       varchar2(10)      ,/* 帳款對象 */
xreq017       varchar2(10)      ,/* 收款對象 */
xreq018       varchar2(10)      ,/* 部門 */
xreq019       varchar2(10)      ,/* 責任中心 */
xreq020       varchar2(10)      ,/* 區域 */
xreq021       varchar2(10)      ,/* 客群 */
xreq022       varchar2(10)      ,/* 產品類別 */
xreq023       varchar2(20)      ,/* 人員 */
xreq024       varchar2(20)      ,/* 專案代號 */
xreq025       varchar2(30)      ,/* WBS編號 */
xreq026       varchar2(10)      ,/* 經營方式 */
xreq027       varchar2(10)      ,/* 渠道 */
xreq028       varchar2(10)      ,/* 品牌 */
xreq029       varchar2(30)      ,/* 自由核算項一 */
xreq030       varchar2(30)      ,/* 自由核算項二 */
xreq031       varchar2(30)      ,/* 自由核算項三 */
xreq032       varchar2(30)      ,/* 自由核算項四 */
xreq033       varchar2(30)      ,/* 自由核算項五 */
xreq034       varchar2(30)      ,/* 自由核算項六 */
xreq035       varchar2(30)      ,/* 自由核算項七 */
xreq036       varchar2(30)      ,/* 自由核算項八 */
xreq037       varchar2(30)      ,/* 自由核算項九 */
xreq038       varchar2(30)      ,/* 自由核算項十 */
xreq039       varchar2(255)      ,/* 摘要 */
xreq040       number(5,0)      ,/* 已攤銷期別 */
xreq041       number(20,6)      ,/* 遞延認列交易原幣金額 */
xreq042       number(20,6)      ,/* 遞延認列交易本幣金額 */
xreq043       number(20,6)      ,/* 遞延認列交易本幣二金額 */
xreq044       number(20,6)      ,/* 遞延認列交易本幣三金額 */
xreq045       varchar2(10)      ,/* 銷售分群 */
xreq100       varchar2(10)      ,/* 交易原幣幣別 */
xreq101       number(20,10)      ,/* 匯率 */
xreq103       number(20,6)      ,/* 本期已實現原幣金額 */
xreq113       number(20,6)      ,/* 本期已實現本幣金額 */
xreq121       number(20,10)      ,/* 本位幣二匯率 */
xreq123       number(20,6)      ,/* 本期已實現本位幣二金額 */
xreq131       number(20,10)      ,/* 本位幣三匯率 */
xreq133       number(20,6)      ,/* 本期已實現本位幣三金額 */
xrequd001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrequd002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrequd003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrequd004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrequd005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrequd006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrequd007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrequd008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrequd009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrequd010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrequd011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrequd012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrequd013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrequd014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrequd015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrequd016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrequd017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrequd018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrequd019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrequd020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrequd021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrequd022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrequd023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrequd024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrequd025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrequd026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrequd027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrequd028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrequd029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrequd030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xreq_t add constraint xreq_pk primary key (xreqent,xreqdocno,xreqld,xreqseq) enable validate;

create  index xreq_n on xreq_t (xreq004,xreq005,xreq006,xreq003,xreq001,xreq002);
create unique index xreq_pk on xreq_t (xreqent,xreqdocno,xreqld,xreqseq);

grant select on xreq_t to tiptop;
grant update on xreq_t to tiptop;
grant delete on xreq_t to tiptop;
grant insert on xreq_t to tiptop;

exit;
