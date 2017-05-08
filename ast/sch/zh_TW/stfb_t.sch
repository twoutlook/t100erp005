/* 
================================================================================
檔案代號:stfb_t
檔案名稱:專櫃合同費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfb_t
(
stfbent       number(5)      ,/* 企業編號 */
stfbunit       varchar2(10)      ,/* 應用組織 */
stfbsite       varchar2(10)      ,/* 營運據點 */
stfbseq       number(10,0)      ,/* 項次 */
stfb001       varchar2(20)      ,/* 合同編號 */
stfb002       varchar2(10)      ,/* 費用編號 */
stfb003       varchar2(10)      ,/* 會計期間 */
stfb004       varchar2(10)      ,/* 價款類別 */
stfb005       varchar2(10)      ,/* 計算類型 */
stfb006       varchar2(10)      ,/* 費用週期 */
stfb007       varchar2(10)      ,/* 費用週期方式 */
stfb008       varchar2(10)      ,/* 條件基準 */
stfb009       varchar2(10)      ,/* 計算基準 */
stfb010       number(20,6)      ,/* 費用淨額 */
stfb011       number(20,6)      ,/* 費用比率 */
stfb012       number(20,6)      ,/* 供應商承擔比率 */
stfb013       date      ,/* 生效日期 */
stfb014       date      ,/* 失效日期 */
stfb015       date      ,/* 下次計算日 */
stfb016       date      ,/* 下次費用開始日 */
stfb017       date      ,/* 下次費用截止日 */
stfb018       varchar2(1)      ,/* 納入結算單否 */
stfb019       varchar2(1)      ,/* 票扣否 */
stfb020       varchar2(1)      ,/* 按自然月計費否 */
stfb021       date      ,/* 上次計算日期 */
stfb022       date      ,/* 上次費用開始日期 */
stfb023       date      ,/* 上次費用結束日期 */
stfb024       varchar2(20)      ,/* 費用單號 */
stfb025       number(10,0)      ,/* 費用項次 */
stfb026       varchar2(1)      /* 有效 */
);
alter table stfb_t add constraint stfb_pk primary key (stfbent,stfbseq,stfb001) enable validate;

create unique index stfb_pk on stfb_t (stfbent,stfbseq,stfb001);

grant select on stfb_t to tiptop;
grant update on stfb_t to tiptop;
grant delete on stfb_t to tiptop;
grant insert on stfb_t to tiptop;

exit;
