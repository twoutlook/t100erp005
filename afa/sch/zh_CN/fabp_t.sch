/* 
================================================================================
檔案代號:fabp_t
檔案名稱:資產類型異動單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabp_t
(
fabpent       number(5)      ,/* 企業編碼 */
fabpld       varchar2(5)      ,/* 帳套 */
fabpsite       varchar2(10)      ,/* 資產中心 */
fabpdocno       varchar2(20)      ,/* 異動單號 */
fabpseq       number(10,0)      ,/* 項次 */
fabp000       varchar2(10)      ,/* 卡片編號 */
fabp001       varchar2(20)      ,/* 財產編號 */
fabp002       varchar2(20)      ,/* 附號 */
fabp003       number(10)      ,/* 資產狀態 */
fabp004       varchar2(80)      ,/* 名稱 */
fabp005       varchar2(255)      ,/* 規格 */
fabp006       number(20,6)      ,/* 成本 */
fabp007       number(20,6)      ,/* 累計折舊 */
fabp010       varchar2(10)      ,/* 主要類型 */
fabp011       varchar2(10)      ,/* 次要類型 */
fabp012       varchar2(10)      ,/* 資產組 */
fabp013       varchar2(24)      ,/* 資產科目 */
fabp014       varchar2(24)      ,/* 累折科目 */
fabp015       varchar2(24)      ,/* 折舊科目 */
fabp016       varchar2(24)      ,/* 減值準備科目 */
fabp020       varchar2(10)      ,/* 異動後主要類型 */
fabp021       varchar2(10)      ,/* 異動後次要類型 */
fabp022       varchar2(10)      ,/* 異動後資產組織 */
fabp023       varchar2(24)      ,/* 異動後資產科目 */
fabp024       varchar2(24)      ,/* 異動後累折科目 */
fabp025       varchar2(24)      ,/* 異動後折舊科目 */
fabp026       varchar2(24)      ,/* 異動後減值準備科目 */
fabp027       varchar2(10)      ,/* 營運據點 */
fabp028       varchar2(10)      ,/* 部門 */
fabp029       varchar2(10)      ,/* 利潤/成本中心 */
fabp030       varchar2(10)      ,/* 區域 */
fabp031       varchar2(10)      ,/* 交易客商 */
fabp032       varchar2(10)      ,/* 帳款客商 */
fabp033       varchar2(10)      ,/* 客群 */
fabp034       varchar2(20)      ,/* 人員 */
fabp035       varchar2(20)      ,/* 專案編號 */
fabp036       varchar2(30)      ,/* WBS */
fabp037       varchar2(40)      ,/* 摘要 */
fabp038       varchar2(10)      ,/* 經營方式 */
fabp039       varchar2(10)      ,/* 渠道 */
fabp040       varchar2(10)      ,/* 品牌 */
fabp041       varchar2(10)      ,/* 自由核算項一 */
fabp042       varchar2(10)      ,/* 自由核算項二 */
fabp043       varchar2(10)      ,/* 自由核算項三 */
fabp044       varchar2(10)      ,/* 自由核算項四 */
fabp045       varchar2(10)      ,/* 自由核算項五 */
fabp046       varchar2(10)      ,/* 自由核算項六 */
fabp047       varchar2(10)      ,/* 自由核算項七 */
fabp048       varchar2(10)      ,/* 自由核算項八 */
fabp049       varchar2(10)      ,/* 自由核算項九 */
fabp050       varchar2(10)      ,/* 自由核算項十 */
fabp100       varchar2(10)      ,/* 本位幣二幣別 */
fabp101       number(20,10)      ,/* 本位幣二匯率 */
fabp102       number(20,6)      ,/* 本位幣二成本 */
fabp103       number(20,6)      ,/* 本位幣二累折 */
fabp110       varchar2(10)      ,/* 本位幣三幣別 */
fabp111       number(20,10)      ,/* 本位幣三匯率 */
fabp112       number(20,6)      ,/* 本位幣三成本 */
fabp113       number(20,6)      /* 本位幣三累折 */
);
alter table fabp_t add constraint fabp_pk primary key (fabpent,fabpld,fabpdocno,fabpseq) enable validate;

create unique index fabp_pk on fabp_t (fabpent,fabpld,fabpdocno,fabpseq);

grant select on fabp_t to tiptop;
grant update on fabp_t to tiptop;
grant delete on fabp_t to tiptop;
grant insert on fabp_t to tiptop;

exit;
