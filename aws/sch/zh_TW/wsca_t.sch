/* 
================================================================================
檔案代號:wsca_t
檔案名稱:ETL Job設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsca_t
(
wscamodid       varchar2(20)      ,/* 資料修改者 */
wscamoddt       timestamp(0)      ,/* 最近修改日 */
wscaownid       varchar2(20)      ,/* 資料所有者 */
wscaowndp       varchar2(10)      ,/* 資料所有部門 */
wscacrtid       varchar2(20)      ,/* 資料建立者 */
wscacrtdp       varchar2(10)      ,/* 資料建立部門 */
wscacrtdt       timestamp(0)      ,/* 資料建立日期 */
wscastus       varchar2(10)      ,/* 資料狀態碼 */
wsca001       varchar2(20)      ,/* 作業代碼 */
wsca002       varchar2(100)      ,/* Job代號 */
wsca003       varchar2(100)      ,/* 產生Excel範本 */
wsca004       varchar2(1)      ,/* 處理方式 */
wsca005       varchar2(255)      ,/* Job 名稱 */
wsca006       varchar2(255)      ,/* 產生Excel範本名稱 */
wsca007       number(10,0)      ,/* 序號 */
wsca008       varchar2(100)      /* 類型 */
);
alter table wsca_t add constraint wsca_pk primary key (wsca001,wsca007) enable validate;

create unique index wsca_pk on wsca_t (wsca001,wsca007);

grant select on wsca_t to tiptop;
grant update on wsca_t to tiptop;
grant delete on wsca_t to tiptop;
grant insert on wsca_t to tiptop;

exit;
