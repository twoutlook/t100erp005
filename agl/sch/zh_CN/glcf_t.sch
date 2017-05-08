/* 
================================================================================
檔案代號:glcf_t
檔案名稱:總帳期末調匯科目餘額明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glcf_t
(
glcfent       number(5)      ,/* 企業編碼 */
glcfcomp       varchar2(10)      ,/* 法人 */
glcfld       varchar2(5)      ,/* 帳套 */
glcf001       number(5,0)      ,/* 年度 */
glcf002       number(5,0)      ,/* 期別 */
glcf003       varchar2(24)      ,/* 科目編號 */
glcf004       varchar2(256)      ,/* 組合要素 */
glcf005       varchar2(10)      ,/* 外幣 */
glcf006       number(20,6)      ,/* 外幣借方餘額 */
glcf007       number(20,6)      ,/* 外幣貸方餘額 */
glcf008       number(20,6)      ,/* 本幣借方餘額(一) */
glcf009       number(20,6)      ,/* 本幣貸方餘額(一) */
glcf010       number(20,10)      ,/* 重估匯率(一) */
glcf011       number(20,6)      ,/* 重估餘額(一) */
glcf012       number(20,6)      ,/* 匯兌損益(一) */
glcf013       number(20,6)      ,/* 本幣借方餘額(二) */
glcf014       number(20,6)      ,/* 本幣貸方餘額(二) */
glcf015       number(20,10)      ,/* 重估匯率(二) */
glcf016       number(20,6)      ,/* 重估餘額(二) */
glcf017       number(20,6)      ,/* 匯兌損益(二) */
glcf018       number(20,6)      ,/* 本幣借方餘額(三) */
glcf019       number(20,6)      ,/* 本幣貸方餘額(三) */
glcf020       number(20,10)      ,/* 重估匯率(三) */
glcf021       number(20,6)      ,/* 重估餘額(三) */
glcf022       number(20,6)      ,/* 匯兌損益(三) */
glcf023       varchar2(10)      ,/* 營運據點 */
glcf024       varchar2(10)      ,/* 部門 */
glcf025       varchar2(10)      ,/* 利潤/成本中心 */
glcf026       varchar2(10)      ,/* 區域 */
glcf027       varchar2(10)      ,/* 交易客商 */
glcf028       varchar2(10)      ,/* 帳款客戶 */
glcf029       varchar2(10)      ,/* 客群 */
glcf030       varchar2(10)      ,/* 產品類別 */
glcf031       varchar2(10)      ,/* 經營方式 */
glcf032       varchar2(10)      ,/* 渠道 */
glcf033       varchar2(10)      ,/* 品牌 */
glcf034       varchar2(20)      ,/* 人員 */
glcf035       varchar2(20)      ,/* 專案 */
glcf036       varchar2(30)      ,/* WBS */
glcf037       varchar2(30)      ,/* 自由核算項(一) */
glcf038       varchar2(30)      ,/* 自由核算項(二) */
glcf039       varchar2(30)      ,/* 自由核算項(三) */
glcf040       varchar2(30)      ,/* 自由核算項(四) */
glcf041       varchar2(30)      ,/* 自由核算項(五) */
glcf042       varchar2(30)      ,/* 自由核算項(六) */
glcf043       varchar2(30)      ,/* 自由核算項(七) */
glcf044       varchar2(30)      ,/* 自由核算項(八) */
glcf045       varchar2(30)      ,/* 自由核算項(九) */
glcf046       varchar2(30)      ,/* 自由核算項(十) */
glcf047       varchar2(24)      ,/* 匯差科目 */
glcf048       varchar2(10)      ,/* 營運據點(匯差) */
glcf049       varchar2(10)      ,/* 部門(匯差) */
glcf050       varchar2(10)      ,/* 利潤/成本中心(匯差) */
glcf051       varchar2(10)      ,/* 區域(匯差) */
glcf052       varchar2(10)      ,/* 交易客商(匯差) */
glcf053       varchar2(10)      ,/* 帳款客戶(匯差) */
glcf054       varchar2(10)      ,/* 客群(匯差) */
glcf055       varchar2(10)      ,/* 產品類別(匯差) */
glcf056       varchar2(10)      ,/* 經營方式(匯差) */
glcf057       varchar2(10)      ,/* 渠道(匯差) */
glcf058       varchar2(10)      ,/* 品牌(匯差) */
glcf059       varchar2(20)      ,/* 人員(匯差) */
glcf060       varchar2(20)      ,/* 專案(匯差) */
glcf061       varchar2(30)      ,/* WBS(匯差) */
glcf062       varchar2(30)      ,/* 自由核算項(一)(匯差) */
glcf063       varchar2(30)      ,/* 自由核算項(二)(匯差) */
glcf064       varchar2(30)      ,/* 自由核算項(三)(匯差) */
glcf065       varchar2(30)      ,/* 自由核算項(四)(匯差) */
glcf066       varchar2(30)      ,/* 自由核算項(五)(匯差) */
glcf067       varchar2(30)      ,/* 自由核算項(六)(匯差) */
glcf068       varchar2(30)      ,/* 自由核算項(七)(匯差) */
glcf069       varchar2(30)      ,/* 自由核算項(八)(匯差) */
glcf070       varchar2(30)      ,/* 自由核算項(九)(匯差) */
glcf071       varchar2(30)      ,/* 自由核算項(十)(匯差) */
glcf072       varchar2(80)      ,/* 摘要(匯差) */
glcf073       varchar2(80)      /* 摘要(重估) */
);
alter table glcf_t add constraint glcf_pk primary key (glcfent,glcfld,glcf001,glcf002,glcf003,glcf004,glcf005) enable validate;

create unique index glcf_pk on glcf_t (glcfent,glcfld,glcf001,glcf002,glcf003,glcf004,glcf005);

grant select on glcf_t to tiptop;
grant update on glcf_t to tiptop;
grant delete on glcf_t to tiptop;
grant insert on glcf_t to tiptop;

exit;
