/* 
================================================================================
檔案代號:nmcy_t
檔案名稱:資金系統月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table nmcy_t
(
nmcyent       number(5)      ,/* 企業代碼 */
nmcycomp       varchar2(10)      ,/* 法人 */
nmcysite       varchar2(10)      ,/* 資金中心 */
nmcyld       varchar2(5)      ,/* 帳別 */
nmcy001       number(5,0)      ,/* 年度 */
nmcy002       number(5,0)      ,/* 期別 */
nmcy003       varchar2(10)      ,/* 資金來源 */
nmcy004       varchar2(20)      ,/* 單據號碼 */
nmcy005       number(10,0)      ,/* 項次 */
nmcy006       varchar2(1)      ,/* 票況 */
nmcy007       varchar2(20)      ,/* 票據號碼 */
nmcy008       varchar2(10)      ,/* 交易對象 */
nmcy009       varchar2(10)      ,/* 帳款對象 */
nmcy010       varchar2(10)      ,/* 部門 */
nmcy011       varchar2(10)      ,/* 責任中心 */
nmcy012       varchar2(10)      ,/* 區域 */
nmcy013       varchar2(10)      ,/* 客群 */
nmcy014       varchar2(10)      ,/* 產品類別 */
nmcy015       varchar2(20)      ,/* 人員 */
nmcy016       varchar2(20)      ,/* 專案代號 */
nmcy017       varchar2(30)      ,/* WBS編號 */
nmcy018       varchar2(24)      ,/* 應收付科目 */
nmcy019       varchar2(10)      ,/* 來源組織 */
nmcy020       varchar2(10)      ,/* 經營方式 */
nmcy021       varchar2(10)      ,/* 渠道 */
nmcy022       varchar2(10)      ,/* 品牌 */
nmcy023       varchar2(10)      ,/* 自由核算項一 */
nmcy024       varchar2(10)      ,/* 自由核算項二 */
nmcy025       varchar2(10)      ,/* 自由核算項三 */
nmcy026       varchar2(10)      ,/* 自由核算項四 */
nmcy027       varchar2(10)      ,/* 自由核算項五 */
nmcy028       varchar2(10)      ,/* 自由核算項六 */
nmcy029       varchar2(10)      ,/* 自由核算項七 */
nmcy030       varchar2(10)      ,/* 自由核算項八 */
nmcy031       varchar2(10)      ,/* 自由核算項九 */
nmcy032       varchar2(10)      ,/* 自由核算項十 */
nmcy033       date      ,/* 開票日期 */
nmcy034       date      ,/* 到期日 */
nmcy035       varchar2(30)      ,/* 交易帳戶 */
nmcy036       varchar2(15)      ,/* 開票銀行 */
nmcy037       varchar2(1)      ,/* 票面利率種類 */
nmcy038       number(10,6)      ,/* 票面利率 */
nmcy039       varchar2(10)      ,/* 款別 */
nmcy040       varchar2(24)      ,/* 科目 */
nmcy100       varchar2(10)      ,/* 交易幣別 */
nmcy101       number(20,10)      ,/* 交易匯率 */
nmcy102       number(20,10)      ,/* 重評匯率 */
nmcy103       number(20,6)      ,/* 原幣金額 */
nmcy113       number(20,6)      ,/* 本幣金額 */
nmcy121       number(20,10)      ,/* 本幣二匯率 */
nmcy122       number(20,10)      ,/* 本位幣二重評匯率 */
nmcy123       number(20,6)      ,/* 本位幣二金額 */
nmcy131       number(20,10)      ,/* 本幣三匯率 */
nmcy132       number(20,10)      ,/* 本位幣三重評匯率 */
nmcy133       number(20,6)      /* 本位幣三金額 */
);
alter table nmcy_t add constraint nmcy_pk primary key (nmcyent,nmcyld,nmcy001,nmcy002,nmcy004,nmcy005) enable validate;

create unique index nmcy_pk on nmcy_t (nmcyent,nmcyld,nmcy001,nmcy002,nmcy004,nmcy005);

grant select on nmcy_t to tiptop;
grant update on nmcy_t to tiptop;
grant delete on nmcy_t to tiptop;
grant insert on nmcy_t to tiptop;

exit;
