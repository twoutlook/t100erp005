/* 
================================================================================
檔案代號:sfpa_t
檔案名稱:製程期末結存狀況檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table sfpa_t
(
sfpaent       number(5)      ,/* 企業代碼 */
sfpasite       varchar2(10)      ,/* 營運據點 */
sfpa000       number(5,0)      ,/* 年度 */
sfpa001       number(5,0)      ,/* 期別 */
sfpa002       varchar2(20)      ,/* 工單單號 */
sfpa003       number(10,0)      ,/* RunCard */
sfpa004       varchar2(10)      ,/* 作業編號 */
sfpa005       varchar2(10)      ,/* 作業序 */
sfpa006       number(20,6)      ,/* 良品轉入 */
sfpa007       number(20,6)      ,/* 重工轉入 */
sfpa008       number(20,6)      ,/* 回收轉入 */
sfpa009       number(20,6)      ,/* 分割轉入 */
sfpa010       number(20,6)      ,/* 合併轉入 */
sfpa011       number(20,6)      ,/* 良品轉出 */
sfpa012       number(20,6)      ,/* 重工轉出 */
sfpa013       number(20,6)      ,/* 工單轉出 */
sfpa014       number(20,6)      ,/* 當站報廢 */
sfpa015       number(20,6)      ,/* 當站下線 */
sfpa016       number(20,6)      ,/* 分割轉出 */
sfpa017       number(20,6)      ,/* 合併轉出 */
sfpa018       number(20,6)      /* 期末結存 */
);
alter table sfpa_t add constraint sfpa_pk primary key (sfpaent,sfpa000,sfpa001,sfpa002,sfpa003,sfpa004,sfpa005) enable validate;

create unique index sfpa_pk on sfpa_t (sfpaent,sfpa000,sfpa001,sfpa002,sfpa003,sfpa004,sfpa005);

grant select on sfpa_t to tiptop;
grant update on sfpa_t to tiptop;
grant delete on sfpa_t to tiptop;
grant insert on sfpa_t to tiptop;

exit;
