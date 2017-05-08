/* 
================================================================================
檔案代號:stfo_t
檔案名稱:聯營合同費用模板設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfo_t
(
stfoent       number(5)      ,/* 企業編號 */
stfounit       varchar2(10)      ,/* 應用組織 */
stfosite       varchar2(10)      ,/* 營運據點 */
stfoseq       number(10,0)      ,/* 項次 */
stfo001       varchar2(20)      ,/* 模板編號 */
stfo002       varchar2(10)      ,/* 費用編號 */
stfo003       varchar2(10)      ,/* 會計期間 */
stfo004       varchar2(10)      ,/* 價款類型 */
stfo005       varchar2(10)      ,/* 計算類型 */
stfo006       varchar2(10)      ,/* 費用類型 */
stfo007       varchar2(10)      ,/* 費用週期方式 */
stfo008       varchar2(10)      ,/* 條件基準 */
stfo009       varchar2(10)      ,/* 計算基準 */
stfo010       number(20,6)      ,/* 費用淨額 */
stfo011       number(20,6)      ,/* 費用比率 */
stfo012       number(20,6)      ,/* 供應商承擔比率 */
stfo013       date      ,/* 生效日期 */
stfo014       date      ,/* 失效日期 */
stfo015       date      ,/* 下次計算日 */
stfo016       date      ,/* 下次費用開始日 */
stfo017       date      ,/* 下次費用截止日 */
stfo018       varchar2(1)      ,/* 納入結算單否 */
stfo019       varchar2(1)      ,/* 票扣否 */
stfo020       varchar2(1)      ,/* 按自然月計費否 */
stfo021       date      ,/* 上次計算日期 */
stfo022       date      ,/* 上次費用開始日期 */
stfo023       date      ,/* 上次費用結束日期 */
stfo024       varchar2(20)      ,/* 費用單號 */
stfo025       number(10,0)      ,/* 費用項次 */
stfo026       varchar2(1)      /* 有效 */
);
alter table stfo_t add constraint stfo_pk primary key (stfoent,stfoseq,stfo001) enable validate;

create unique index stfo_pk on stfo_t (stfoent,stfoseq,stfo001);

grant select on stfo_t to tiptop;
grant update on stfo_t to tiptop;
grant delete on stfo_t to tiptop;
grant insert on stfo_t to tiptop;

exit;
