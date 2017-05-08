/* 
================================================================================
檔案代號:dzgn_t
檔案名稱:報表元件規格設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzgn_t
(
dzgn001       varchar2(20)      ,/* 報表元件代號 */
dzgn002       varchar2(15)      ,/* 版次 */
dzgn003       varchar2(1)      ,/* 使用標示 */
dzgn099       clob      ,/* 規格描述 */
dzgnownid       varchar2(10)      ,/* 資料所有者 */
dzgnowndp       varchar2(10)      ,/* 資料所屬部門 */
dzgncrtid       varchar2(10)      ,/* 資料建立者 */
dzgncrtdp       varchar2(10)      ,/* 資料建立部門 */
dzgncrtdt       date      ,/* 資料創建日 */
dzgnmodid       varchar2(10)      ,/* 資料修改者 */
dzgnmoddt       date      ,/* 最近修改日 */
dzgnstus       varchar2(10)      /* 狀態碼 */
);
alter table dzgn_t add constraint dzgn_pk primary key (dzgn001,dzgn002,dzgn003) enable validate;


grant select on dzgn_t to tiptop;
grant update on dzgn_t to tiptop;
grant delete on dzgn_t to tiptop;
grant insert on dzgn_t to tiptop;

exit;
