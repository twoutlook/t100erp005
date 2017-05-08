/* 
================================================================================
檔案代號:steb_t
檔案名稱:專櫃合同費用申请設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table steb_t
(
stebent       number(5)      ,/* 企業編號 */
stebsite       varchar2(10)      ,/* 營運據點 */
stebunit       varchar2(10)      ,/* 應用組織 */
stebdocno       varchar2(20)      ,/* 單據編號 */
stebseq       number(10,0)      ,/* 項次 */
steb001       varchar2(20)      ,/* 合同編號 */
steb002       varchar2(10)      ,/* 費用編號 */
steb003       varchar2(10)      ,/* 會計期間 */
steb004       varchar2(10)      ,/* 價款類別 */
steb005       varchar2(10)      ,/* 計算類型 */
steb006       varchar2(10)      ,/* 費用週期 */
steb007       varchar2(10)      ,/* 費用週期方式 */
steb008       varchar2(10)      ,/* 條件基準 */
steb009       varchar2(10)      ,/* 計算基準 */
steb010       number(20,6)      ,/* 費用淨額 */
steb011       number(20,6)      ,/* 費用比率 */
steb012       number(20,6)      ,/* 供應商承擔比率 */
steb013       date      ,/* 生效日期 */
steb014       date      ,/* 失效日期 */
steb015       date      ,/* 下次計算日 */
steb016       date      ,/* 下次費用開始日 */
steb017       date      ,/* 下次費用截止日 */
steb018       varchar2(1)      ,/* 納入結算單否 */
steb019       varchar2(1)      ,/* 票扣否 */
steb020       varchar2(1)      ,/* 按自然月計費否 */
steb021       date      ,/* 上次計算日期 */
steb022       date      ,/* 上次費用開始日期 */
steb023       date      ,/* 上次費用結束日期 */
steb024       varchar2(20)      ,/* 費用單號 */
steb025       number(10,0)      ,/* 費用項次 */
steb026       varchar2(1)      /* 有效 */
);
alter table steb_t add constraint steb_pk primary key (stebent,stebdocno,stebseq) enable validate;

create unique index steb_pk on steb_t (stebent,stebdocno,stebseq);

grant select on steb_t to tiptop;
grant update on steb_t to tiptop;
grant delete on steb_t to tiptop;
grant insert on steb_t to tiptop;

exit;
