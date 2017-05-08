/* 
================================================================================
檔案代號:wsac_t
檔案名稱:BPM 單據重要欄位設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsac_t
(
wsac001       varchar2(10)      ,/* 單據性質 */
wsac002       varchar2(20)      ,/* 作業編號 */
wsac003       varchar2(40)      ,/* 結構 */
wsac004       varchar2(40)      ,/* 控件代號 */
wsac005       varchar2(40)      ,/* 欄位標籤代號 */
wsac006       varchar2(40)      ,/* 參考欄位代號 */
wsac007       varchar2(40)      /* 自定義變數名稱 */
);
alter table wsac_t add constraint wsac_pk primary key (wsac001,wsac004) enable validate;

create unique index wsac_pk on wsac_t (wsac001,wsac004);

grant select on wsac_t to tiptop;
grant update on wsac_t to tiptop;
grant delete on wsac_t to tiptop;
grant insert on wsac_t to tiptop;

exit;
