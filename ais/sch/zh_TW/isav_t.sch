/* 
================================================================================
檔案代號:isav_t
檔案名稱:電子發票匯出記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isav_t
(
isavent       number(5)      ,/* 企業代碼 */
isavcomp       varchar2(10)      ,/* 法人 */
isavsite       varchar2(10)      ,/* 營運據點 */
isavseq       number(10,0)      ,/* 發票歷程項次 */
isav001       varchar2(10)      ,/* 申報單位 */
isav002       varchar2(255)      ,/* 法人統編 */
isav003       varchar2(20)      ,/* 檔案格式 */
isav004       date      ,/* 匯出日期 */
isav005       timestamp(5)      ,/* 匯出時間 */
isav006       varchar2(20)      ,/* 發票代碼 */
isav007       varchar2(20)      ,/* 發票號碼 */
isav008       date      ,/* 發票日期 */
isav009       timestamp(5)      ,/* 發票時間 */
isav010       varchar2(20)      ,/* 執行人員 */
isav011       varchar2(80)      ,/* 匯出xml檔名 */
isav012       varchar2(1)      ,/* 處理成功否 */
isav013       varchar2(255)      /* 訊息 */
);
alter table isav_t add constraint isav_pk primary key (isavent,isav001,isav002,isav003,isav004,isav005) enable validate;

create unique index isav_pk on isav_t (isavent,isav001,isav002,isav003,isav004,isav005);

grant select on isav_t to tiptop;
grant update on isav_t to tiptop;
grant delete on isav_t to tiptop;
grant insert on isav_t to tiptop;

exit;
