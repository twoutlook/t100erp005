/* 
================================================================================
檔案代號:dzcl_t
檔案名稱:複製規格與程式底稿
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcl_t
(
dzcl001       varchar2(10)      ,/* 程式類型 */
dzcl002       varchar2(20)      ,/* 複製來源 */
dzcl003       varchar2(20)      ,/* 複製目標 */
dzcl004       varchar2(1)      ,/* 使用表格欄位轉換 */
dzclownid       varchar2(20)      ,/* 資料所有者 */
dzclowndp       varchar2(10)      ,/* 資料所屬部門 */
dzclcrtid       varchar2(20)      ,/* 資料建立者 */
dzclcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzclcrtdt       timestamp(0)      ,/* 資料創建日 */
dzclmodid       varchar2(20)      ,/* 資料修改者 */
dzclmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzcl_t add constraint dzcl_pk primary key (dzcl001,dzcl002,dzcl003,dzcl004,dzclcrtid) enable validate;

create unique index dzcl_pk on dzcl_t (dzcl001,dzcl002,dzcl003,dzcl004,dzclcrtid);

grant select on dzcl_t to tiptop;
grant update on dzcl_t to tiptop;
grant delete on dzcl_t to tiptop;
grant insert on dzcl_t to tiptop;

exit;
