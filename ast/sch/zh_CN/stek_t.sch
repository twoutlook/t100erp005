/* 
================================================================================
檔案代號:stek_t
檔案名稱:專櫃合同卡手续费费用申请設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stek_t
(
stekent       number(5)      ,/* 企業編號 */
stekunit       varchar2(10)      ,/* 應用組織 */
stekdocno       varchar2(20)      ,/* 單據編號 */
steksite       varchar2(10)      ,/* 營運據點 */
stekseq       number(10,0)      ,/* 項次 */
stek001       varchar2(20)      ,/* 合同編號 */
stek002       varchar2(10)      ,/* 費用編號 */
stek003       varchar2(10)      ,/* 會計期間 */
stek004       varchar2(10)      ,/* 價款類別 */
stek005       varchar2(10)      ,/* 計算類型 */
stek006       varchar2(10)      ,/* 費用週期 */
stek007       varchar2(10)      ,/* 費用週期方式 */
stek008       varchar2(10)      ,/* 條件基準 */
stek009       varchar2(10)      ,/* 計算基準 */
stek010       number(20,6)      ,/* 費用淨額 */
stek011       number(20,6)      ,/* 費用比率 */
stek012       number(20,6)      ,/* 供應商承擔比率 */
stek013       date      ,/* 生效日期 */
stek014       date      ,/* 失效日期 */
stek015       date      ,/* 下次計算日 */
stek016       date      ,/* 下次費用開始日 */
stek017       date      ,/* 下次費用截止日 */
stek018       varchar2(10)      ,/* 款別性質 */
stek019       varchar2(10)      ,/* 款別編號 */
stek020       varchar2(1)      ,/* 納入結算單否 */
stek021       varchar2(1)      ,/* 票扣否 */
stekacti       varchar2(1)      ,/* 資料有效碼 */
stek022       date      ,/* 上次計算日期 */
stek023       date      ,/* 上次費用開始日期 */
stek024       date      ,/* 上次費用結束日期 */
stek025       varchar2(20)      ,/* 費用單號 */
stek026       number(10,0)      /* 費用項次 */
);
alter table stek_t add constraint stek_pk primary key (stekent,stekdocno,stekseq) enable validate;

create unique index stek_pk on stek_t (stekent,stekdocno,stekseq);

grant select on stek_t to tiptop;
grant update on stek_t to tiptop;
grant delete on stek_t to tiptop;
grant insert on stek_t to tiptop;

exit;
