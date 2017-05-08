/* 
================================================================================
檔案代號:wsbd_t
檔案名稱:BPM 簽核關卡資訊表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsbd_t
(
wsbdent       number(5)      ,/* 企業編號 */
wsbd001       varchar2(500)      ,/* 單據組合Key */
wsbd002       varchar2(80)      ,/* 簽核關卡代號 */
wsbd003       varchar2(20)      ,/* 使用者代號 */
wsbd004       varchar2(1)      ,/* 簽核結果 */
wsbd005       varchar2(4000)      ,/* 簽核意見 */
wsbd006       date      ,/* 簽核日期 */
wsbd007       varchar2(10)      ,/* 簽核時間 */
wsbd008       blob      ,/* 手寫簽名圖檔 */
wsbd009       timestamp(0)      /* 更新時間 */
);
alter table wsbd_t add constraint wsbd_pk primary key (wsbdent,wsbd001,wsbd002) enable validate;

create unique index wsbd_pk on wsbd_t (wsbdent,wsbd001,wsbd002);

grant select on wsbd_t to tiptop;
grant update on wsbd_t to tiptop;
grant delete on wsbd_t to tiptop;
grant insert on wsbd_t to tiptop;

exit;
