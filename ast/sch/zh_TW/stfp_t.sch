/* 
================================================================================
檔案代號:stfp_t
檔案名稱:聯營合同卡手續費費用模板設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfp_t
(
stfpent       number(5)      ,/* 企業編號 */
stfpunit       varchar2(10)      ,/* 應用組織 */
stfpsite       varchar2(10)      ,/* 營運據點 */
stfpseq       number(10,0)      ,/* 項次 */
stfp001       varchar2(20)      ,/* 模板編號 */
stfp002       varchar2(10)      ,/* 費用編號 */
stfp003       varchar2(10)      ,/* 會計期間 */
stfp004       varchar2(10)      ,/* 價款類別 */
stfp005       varchar2(10)      ,/* 計算類型 */
stfp006       varchar2(10)      ,/* 費用週期 */
stfp007       varchar2(10)      ,/* 費用週期方式 */
stfp008       varchar2(10)      ,/* 條件基準 */
stfp009       varchar2(10)      ,/* 計算基準 */
stfp010       number(20,6)      ,/* 費用淨額 */
stfp011       number(20,6)      ,/* 費用比率 */
stfp012       number(20,6)      ,/* 供應商承擔比率 */
stfp013       date      ,/* 生效日期 */
stfp014       date      ,/* 失效日期 */
stfp015       date      ,/* 下次計算日 */
stfp016       date      ,/* 下次費用開始日 */
stfp017       date      ,/* 下次費用截止日 */
stfp018       varchar2(10)      ,/* 款別性質 */
stfp019       varchar2(10)      ,/* 款別編號 */
stfp020       varchar2(1)      ,/* 納入結算單否 */
stfp021       varchar2(1)      ,/* 票扣否 */
stfpacti       varchar2(1)      ,/* 資料有效碼 */
stfp022       date      ,/* 上次計算日期 */
stfp023       date      ,/* 上次費用開始日期 */
stfp024       date      ,/* 上次費用結束日期 */
stfp025       varchar2(20)      ,/* 費用單號 */
stfp026       number(10,0)      /* 費用項次 */
);
alter table stfp_t add constraint stfp_pk primary key (stfpent,stfpseq,stfp001) enable validate;

create unique index stfp_pk on stfp_t (stfpent,stfpseq,stfp001);

grant select on stfp_t to tiptop;
grant update on stfp_t to tiptop;
grant delete on stfp_t to tiptop;
grant insert on stfp_t to tiptop;

exit;
