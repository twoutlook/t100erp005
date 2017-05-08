/* 
================================================================================
檔案代號:prbn_t
檔案名稱:電子秤匯出日誌資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table prbn_t
(
prbnent       number(5)      ,/* 企業編號 */
prbnsite       varchar2(10)      ,/* 營運據點 */
prbn001       varchar2(20)      ,/* 任務編號 */
prbn002       number(10,0)      ,/* 項次 */
prbn003       varchar2(10)      ,/* 電子秤編號 */
prbn004       varchar2(40)      ,/* 導出文件名 */
prbn005       varchar2(10)      ,/* 人員 */
prbn006       varchar2(10)      ,/* 部門 */
prbn007       date      ,/* 操作日期 */
prbn008       varchar2(8)      /* 操作時間 */
);
alter table prbn_t add constraint prbn_pk primary key (prbnent,prbn001,prbn002) enable validate;

create unique index prbn_pk on prbn_t (prbnent,prbn001,prbn002);

grant select on prbn_t to tiptop;
grant update on prbn_t to tiptop;
grant delete on prbn_t to tiptop;
grant insert on prbn_t to tiptop;

exit;
