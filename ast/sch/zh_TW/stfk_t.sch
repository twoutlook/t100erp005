/* 
================================================================================
檔案代號:stfk_t
檔案名稱:專櫃合同卡手续费费用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfk_t
(
stfkent       number(5)      ,/* 企業編號 */
stfkunit       varchar2(10)      ,/* 應用組織 */
stfksite       varchar2(10)      ,/* 營運據點 */
stfkseq       number(10,0)      ,/* 項次 */
stfk001       varchar2(20)      ,/* 合同編號 */
stfk002       varchar2(10)      ,/* 費用編號 */
stfk003       varchar2(10)      ,/* 會計期間 */
stfk004       varchar2(10)      ,/* 價款類別 */
stfk005       varchar2(10)      ,/* 計算類型 */
stfk006       varchar2(10)      ,/* 費用週期 */
stfk007       varchar2(10)      ,/* 費用週期方式 */
stfk008       varchar2(10)      ,/* 條件基準 */
stfk009       varchar2(10)      ,/* 計算基準 */
stfk010       number(20,6)      ,/* 費用淨額 */
stfk011       number(20,6)      ,/* 費用比率 */
stfk012       number(20,6)      ,/* 供應商承擔比率 */
stfk013       date      ,/* 生效日期 */
stfk014       date      ,/* 失效日期 */
stfk015       date      ,/* 下次計算日 */
stfk016       date      ,/* 下次費用開始日 */
stfk017       date      ,/* 下次費用截止日 */
stfk018       varchar2(10)      ,/* 款別性質 */
stfk019       varchar2(10)      ,/* 款別編號 */
stfk020       varchar2(1)      ,/* 納入結算單否 */
stfk021       varchar2(1)      ,/* 票扣否 */
stfkacti       varchar2(1)      ,/* 資料有效碼 */
stfk022       date      ,/* 上次計算日期 */
stfk023       date      ,/* 上次費用開始日期 */
stfk024       date      ,/* 上次費用結束日期 */
stfk025       varchar2(20)      ,/* 費用單號 */
stfk026       number(10,0)      /* 費用項次 */
);
alter table stfk_t add constraint stfk_pk primary key (stfkent,stfkseq,stfk001) enable validate;

create unique index stfk_pk on stfk_t (stfkent,stfkseq,stfk001);

grant select on stfk_t to tiptop;
grant update on stfk_t to tiptop;
grant delete on stfk_t to tiptop;
grant insert on stfk_t to tiptop;

exit;
