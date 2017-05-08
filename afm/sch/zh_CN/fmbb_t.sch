/* 
================================================================================
檔案代號:fmbb_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmbb_t
(
fmbbent       number(5)      ,/* 企業編號 */
fmbb001       varchar2(10)      ,/* 帳務中心 */
fmbb002       varchar2(10)      ,/* 法人組織 */
fmbb003       varchar2(5)      ,/* 帳套 */
fmbb004       number(5,0)      ,/* 年度 */
fmbb005       number(5,0)      ,/* 期別 */
fmbb006       varchar2(20)      ,/* 憑證編號 */
fmbb007       varchar2(1)      ,/* 來源單據性質 */
fmbb008       varchar2(20)      ,/* 單據編號 */
fmbb009       number(10,0)      ,/* 項次 */
fmbb010       varchar2(24)      ,/* 會計科目 */
fmbb011       varchar2(10)      ,/* 幣別 */
fmbb012       number(20,10)      ,/* 上期匯率 */
fmbb013       number(20,6)      ,/* 原幣金額 */
fmbb014       number(20,6)      ,/* 本幣金額 */
fmbb015       number(20,10)      ,/* 重評價匯率一 */
fmbb016       number(20,6)      ,/* 重評價金額一 */
fmbb017       number(20,6)      ,/* 匯兌損益一 */
fmbb018       number(20,10)      ,/* 上期匯率二 */
fmbb019       number(20,6)      ,/* 本幣金額二 */
fmbb020       number(20,10)      ,/* 重評價匯率二 */
fmbb021       number(20,6)      ,/* 重評價金額二 */
fmbb022       number(20,6)      ,/* 匯兌損益二 */
fmbb023       number(20,10)      ,/* 上期匯率三 */
fmbb024       number(20,6)      ,/* 本幣金額三 */
fmbb025       number(20,10)      ,/* 重評價匯率三 */
fmbb026       number(20,6)      ,/* 重評價金額三 */
fmbb027       number(20,6)      ,/* 匯兌損益三 */
fmbb028       varchar2(24)      ,/* 對方科目 */
fmbb029       varchar2(10)      ,/* 營運據點 */
fmbb030       varchar2(10)      ,/* 部門 */
fmbb031       varchar2(10)      ,/* 利潤/成本中心 */
fmbb032       varchar2(10)      ,/* 區域 */
fmbb033       varchar2(10)      ,/* 交易客商 */
fmbb034       varchar2(10)      ,/* 帳款客商 */
fmbb035       varchar2(10)      ,/* 客群 */
fmbb036       varchar2(10)      ,/* 產品類別 */
fmbb037       varchar2(20)      ,/* 人員 */
fmbb038       varchar2(10)      ,/* 預算編號 */
fmbb039       varchar2(20)      ,/* 專案編號 */
fmbb040       varchar2(30)      ,/* WBS */
fmbb041       varchar2(10)      ,/* 經營方式 */
fmbb042       varchar2(10)      ,/* 渠道 */
fmbb043       varchar2(10)      ,/* 品牌 */
fmbb044       varchar2(30)      ,/* 自由核算項(一) */
fmbb045       varchar2(30)      ,/* 自由核算項(二) */
fmbb046       varchar2(30)      ,/* 自由核算項(三) */
fmbb047       varchar2(30)      ,/* 自由核算項(四) */
fmbb048       varchar2(30)      ,/* 自由核算項(五) */
fmbb049       varchar2(30)      ,/* 自由核算項(六) */
fmbb050       varchar2(30)      ,/* 自由核算項(七) */
fmbb051       varchar2(30)      ,/* 自由核算項(八) */
fmbb052       varchar2(30)      ,/* 自由核算項(九) */
fmbb053       varchar2(30)      ,/* 自由核算項(十) */
fmbbownid       varchar2(20)      ,/* 資料所有者 */
fmbbowndp       varchar2(10)      ,/* 資料所屬部門 */
fmbbcrtid       varchar2(20)      ,/* 資料建立者 */
fmbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmbbcrtdt       timestamp(0)      ,/* 資料創建日 */
fmbbmodid       varchar2(20)      ,/* 資料修改者 */
fmbbmoddt       timestamp(0)      ,/* 最近修改日 */
fmbbcnfid       varchar2(20)      ,/* 資料確認者 */
fmbbcnfdt       timestamp(0)      ,/* 資料確認日 */
fmbbstus       varchar2(10)      /* 狀態碼 */
);
alter table fmbb_t add constraint fmbb_pk primary key (fmbbent,fmbb003,fmbb004,fmbb005,fmbb007,fmbb008,fmbb009) enable validate;

create unique index fmbb_pk on fmbb_t (fmbbent,fmbb003,fmbb004,fmbb005,fmbb007,fmbb008,fmbb009);

grant select on fmbb_t to tiptop;
grant update on fmbb_t to tiptop;
grant delete on fmbb_t to tiptop;
grant insert on fmbb_t to tiptop;

exit;
