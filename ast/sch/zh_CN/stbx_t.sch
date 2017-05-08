/* 
================================================================================
檔案代號:stbx_t
檔案名稱:供應商合約費用結算帳期資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbx_t
(
stbxent       number(5)      ,/* 企業代碼 */
stbxsite       varchar2(10)      ,/* 營運據點 */
stbxunit       varchar2(10)      ,/* 應用執行組織物件 */
stbxseq       number(10,0)      ,/* 帳期 */
stbxseq1       number(10,0)      ,/* 費用項次 */
stbx001       varchar2(20)      ,/* 合約編號 */
stbx002       date      ,/* 起始日期 */
stbx003       date      ,/* 截止日期 */
stbx004       date      ,/* 費用計算日期 */
stbx005       varchar2(20)      ,/* 費用單號 */
stbx006       number(20,6)      ,/* 費用金額 */
stbx007       varchar2(10)      ,/* 費用編號 */
stbx008       varchar2(10)      ,/* 法人 */
stbx009       varchar2(1)      /* 已計算否 */
);
alter table stbx_t add constraint stbx_pk primary key (stbxent,stbxseq,stbxseq1,stbx001,stbx004,stbx008) enable validate;

create unique index stbx_pk on stbx_t (stbxent,stbxseq,stbxseq1,stbx001,stbx004,stbx008);

grant select on stbx_t to tiptop;
grant update on stbx_t to tiptop;
grant delete on stbx_t to tiptop;
grant insert on stbx_t to tiptop;

exit;
