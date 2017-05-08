/* 
================================================================================
檔案代號:dzeh_t
檔案名稱:SA分鏡表格資料匯入介面檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzeh_t
(
dzehstus       varchar2(10)      ,/* 狀態碼 */
dzeh001       varchar2(80)      ,/* SID       */
dzeh002       varchar2(1)      ,/* 處理狀態  */
dzeh003       varchar2(500)      ,/* 處理結果說明 */
dzeh004       varchar2(20)      ,/* 處理序號 */
dzeh005       varchar2(500)      ,/* 欄位序號 */
dzeh006       varchar2(20)      ,/* table代號 */
dzeh007       varchar2(80)      ,/* table說明 */
dzeh008       varchar2(20)      ,/* 欄位代號 */
dzeh009       varchar2(100)      ,/* 欄位名稱 */
dzeh010       varchar2(20)      ,/* 主鍵 */
dzeh011       varchar2(10)      ,/* 索引 */
dzeh012       varchar2(500)      ,/* 資料型態 */
dzeh013       varchar2(40)      ,/* 欄位長度 */
dzeh014       varchar2(255)      ,/* 欄位說明 */
dzeh015       varchar2(40)      ,/* 欄位屬性 */
dzehownid       varchar2(20)      ,/* 資料所有者 */
dzehowndp       varchar2(10)      ,/* 資料所屬部門 */
dzehcrtid       varchar2(20)      ,/* 資料建立者 */
dzehcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzehcrtdt       timestamp(0)      ,/* 資料創建日 */
dzehmodid       varchar2(20)      ,/* 資料修改者 */
dzehmoddt       timestamp(0)      ,/* 最近修改日 */
dzeh016       varchar2(40)      ,/* 擴充欄位  */
dzeh017       varchar2(40)      ,/* 擴充欄位  */
dzeh018       varchar2(40)      ,/* 擴充欄位  */
dzeh019       varchar2(40)      ,/* 擴充欄位  */
dzeh020       varchar2(40)      /* 擴充欄位  */
);

create  index dzeh_t_i0 on dzeh_t (dzeh001);
create  index dzeh_t_i1 on dzeh_t (dzeh001,dzeh008);

grant select on dzeh_t to tiptop;
grant update on dzeh_t to tiptop;
grant delete on dzeh_t to tiptop;
grant insert on dzeh_t to tiptop;

exit;
