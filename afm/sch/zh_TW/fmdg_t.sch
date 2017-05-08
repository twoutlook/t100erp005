/* 
================================================================================
檔案代號:fmdg_t
檔案名稱:融资系统重评价單身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmdg_t
(
fmdgent       number(5)      ,/* 企業編號 */
fmdgld       varchar2(5)      ,/* 帳套 */
fmdgdocno       varchar2(20)      ,/* 單據號碼 */
fmdg001       number(5,0)      ,/* 年度 */
fmdg002       number(5,0)      ,/* 期別 */
fmdgseq       number(10,0)      ,/* 項次 */
fmdg003       varchar2(10)      ,/* 來源組織 */
fmdg004       varchar2(10)      ,/* 來源性質 */
fmdg005       varchar2(20)      ,/* 來源單號 */
fmdg006       number(10,0)      ,/* 來源項次 */
fmdg007       varchar2(20)      ,/* 融資到帳單號 */
fmdg008       number(10,0)      ,/* 融資到帳單項次 */
fmdg009       number(10,0)      ,/* 融資費用單項次 */
fmdg010       varchar2(10)      ,/* 帳款對象 */
fmdg011       varchar2(10)      ,/* 收款對象 */
fmdg012       varchar2(10)      ,/* 部門 */
fmdg013       varchar2(10)      ,/* 利潤中心 */
fmdg014       varchar2(10)      ,/* 區域 */
fmdg015       varchar2(10)      ,/* 客群 */
fmdg016       varchar2(10)      ,/* 產品類別 */
fmdg017       varchar2(20)      ,/* 人員 */
fmdg018       varchar2(20)      ,/*   */
fmdg019       varchar2(30)      ,/* WBS編號 */
fmdg020       varchar2(10)      ,/* 經營方式 */
fmdg021       varchar2(10)      ,/* 通路 */
fmdg022       varchar2(10)      ,/* 品牌 */
fmdg023       varchar2(30)      ,/* 自由核算項一 */
fmdg024       varchar2(30)      ,/* 自由核算項二 */
fmdg025       varchar2(30)      ,/* 自由核算項三 */
fmdg026       varchar2(30)      ,/* 自由核算項四 */
fmdg027       varchar2(30)      ,/* 自由核算項五 */
fmdg028       varchar2(30)      ,/* 自由核算項六 */
fmdg029       varchar2(30)      ,/* 自由核算項七 */
fmdg030       varchar2(30)      ,/* 自由核算項八 */
fmdg031       varchar2(30)      ,/* 自由核算項九 */
fmdg032       varchar2(30)      ,/* 自由核算項十 */
fmdg033       varchar2(24)      ,/* 重評價會計科目 */
fmdg034       varchar2(24)      ,/* 科目 */
fmdg035       varchar2(255)      ,/* 摘要 */
fmdg100       varchar2(10)      ,/* 幣別 */
fmdg101       number(20,10)      ,/* 重評價匯率 */
fmdg102       number(20,10)      ,/* 上月重評匯率 */
fmdg103       number(20,6)      ,/* 本期原幣未沖金額 */
fmdg113       number(20,6)      ,/* 本期本幣未沖金額 */
fmdg114       number(20,6)      ,/* 本期重評價後本幣金額 */
fmdg115       number(20,6)      ,/* 本期匯差金額 */
fmdg116       number(20,6)      ,/* 本幣累計匯差 */
fmdg121       number(20,10)      ,/* 本位幣二重評價匯率 */
fmdg122       number(20,10)      ,/* 本位幣二上月重估匯率 */
fmdg123       number(20,6)      ,/* 本期本位幣二未沖金額 */
fmdg124       number(20,6)      ,/* 本期本位幣二重評價後金額 */
fmdg125       number(20,6)      ,/* 本期本位幣二匯差金額 */
fmdg126       number(20,6)      ,/* 本位幣二累計匯差 */
fmdg131       number(20,10)      ,/* 本位幣三重評價匯率 */
fmdg132       number(20,10)      ,/* 本位幣三上月重估匯率 */
fmdg133       number(20,6)      ,/* 本期本位幣三未沖金額 */
fmdg134       number(20,6)      ,/* 本期本位幣三重評價後金額 */
fmdg135       number(20,6)      ,/* 本期本位幣三匯差金額 */
fmdg136       number(20,6)      /* 本位幣三累計匯差 */
);
alter table fmdg_t add constraint fmdg_pk primary key (fmdgent,fmdgld,fmdgdocno,fmdg001,fmdg002,fmdgseq) enable validate;

create unique index fmdg_pk on fmdg_t (fmdgent,fmdgld,fmdgdocno,fmdg001,fmdg002,fmdgseq);

grant select on fmdg_t to tiptop;
grant update on fmdg_t to tiptop;
grant delete on fmdg_t to tiptop;
grant insert on fmdg_t to tiptop;

exit;
