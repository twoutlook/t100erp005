/* 
================================================================================
檔案代號:stbw_t
檔案名稱:供應商合約申請費用結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbw_t
(
stbwent       number(5)      ,/* 企業代碼 */
stbwsite       varchar2(10)      ,/* 營運據點 */
stbwunit       varchar2(10)      ,/* 應用執行組織物件 */
stbwdocno       varchar2(20)      ,/* 單號 */
stbwseq       number(10,0)      ,/* 帳期 */
stbw001       number(10,0)      ,/* 費用項次 */
stbw002       date      ,/* 起始日期 */
stbw003       date      ,/* 截止日期 */
stbw004       date      ,/* 費用計算日期 */
stbw005       varchar2(20)      ,/* 費用單號 */
stbw006       number(20,6)      ,/* 費用金額 */
stbw007       varchar2(10)      ,/* 費用編號 */
stbw008       varchar2(10)      ,/* 法人 */
stbw009       varchar2(1)      /* 已計算否 */
);
alter table stbw_t add constraint stbw_pk primary key (stbwent,stbwdocno,stbwseq,stbw001,stbw004,stbw008) enable validate;

create unique index stbw_pk on stbw_t (stbwent,stbwdocno,stbwseq,stbw001,stbw004,stbw008);

grant select on stbw_t to tiptop;
grant update on stbw_t to tiptop;
grant delete on stbw_t to tiptop;
grant insert on stbw_t to tiptop;

exit;
