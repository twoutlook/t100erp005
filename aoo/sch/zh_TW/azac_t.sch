/* 
================================================================================
檔案代號:azac_t
檔案名稱:簽核等級檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table azac_t
(
azacmodu       varchar2(10)      ,/* 資料修改者 */
azacdate       date      ,/* 最近修改日 */
azacoriu       varchar2(10)      ,/* 資料所有者 */
azacorid       varchar2(10)      ,/* 資料所有部門 */
azacuser       varchar2(10)      ,/* 資料建立者 */
azacdept       varchar2(10)      ,/* 資料建立部門 */
azacbuid       date      ,/* 資料創建日 */
azacstus       varchar2(1)      ,/* 狀態碼 */
azac001       varchar2(4)      ,/* 簽核等級 */
azac002       number(5)      ,/* 順序 */
azac003       varchar2(10)      ,/* 人員代碼 */
azac004       varchar2(255)      /* 備註 */
);


grant select on azac_t to tiptop;
grant update on azac_t to tiptop;
grant delete on azac_t to tiptop;
grant insert on azac_t to tiptop;

exit;
