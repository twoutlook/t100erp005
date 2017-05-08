/* 
================================================================================
檔案代號:stabl_t
檔案名稱:合約計算及條件基準基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stabl_t
(
stablent       number(5)      ,/* 企業編號 */
stabl001       varchar2(10)      ,/* 基準編號 */
stabl002       varchar2(6)      ,/* 語言別 */
stabl003       varchar2(500)      ,/* 說明 */
stabl004       varchar2(10)      /* 助記碼 */
);
alter table stabl_t add constraint stabl_pk primary key (stablent,stabl001,stabl002) enable validate;

create  index stabl_01 on stabl_t (stabl004);
create unique index stabl_pk on stabl_t (stablent,stabl001,stabl002);

grant select on stabl_t to tiptop;
grant update on stabl_t to tiptop;
grant delete on stabl_t to tiptop;
grant insert on stabl_t to tiptop;

exit;
