/* 
================================================================================
檔案代號:wsad_t
檔案名稱:BPM 單據其他相關設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table wsad_t
(
wsad001       varchar2(10)      ,/* 單據性質 */
wsad002       varchar2(20)      ,/* 作業編號 */
wsad003       varchar2(40)      ,/* 表單關係人欄位 */
wsad004       varchar2(40)      /* 交易對象欄位 */
);
alter table wsad_t add constraint wsad_pk primary key (wsad001) enable validate;


grant select on wsad_t to tiptop;
grant update on wsad_t to tiptop;
grant delete on wsad_t to tiptop;
grant insert on wsad_t to tiptop;

exit;
