/* 
================================================================================
檔案代號:azae_t
檔案名稱:簽核等級單頭
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table azae_t
(
azaemodu       varchar2(10)      ,/* 資料修改者 */
azaedate       date      ,/* 最近修改日 */
azaeoriu       varchar2(10)      ,/* 資料建立者 */
azaeorid       varchar2(10)      ,/* 資料建立部門 */
azaeuser       varchar2(10)      ,/* 資料所有者 */
azaedept       varchar2(10)      ,/* 資料所有部門 */
azaebuid       date      ,/* 資料創建日 */
azaestus       varchar2(1)      ,/* 狀態碼 */
azae001       varchar2(4)      ,/* 簽核等級 */
azae002       varchar2(80)      ,/* 說明 */
azae003       varchar2(80)      ,/* 說明 */
azae004       varchar2(80)      ,/* 說明 */
azae005       varchar2(80)      ,/* 說明 */
azae006       varchar2(80)      ,/* 說明 */
azae007       varchar2(1)      ,/* 是否需查看後方可簽核 */
azae008       varchar2(1)      ,/* 是否由系統自動賦予簽核等級 */
azae009       number(5)      ,/* 簽核單據別 */
azae010       varchar2(80)      ,/* 賦予條件 */
azae011       varchar2(80)      /* 賦予條件 */
);
alter table azae_t add constraint azae_pk primary key (azae001) enable validate;


grant select on azae_t to tiptop;
grant update on azae_t to tiptop;
grant delete on azae_t to tiptop;
grant insert on azae_t to tiptop;

exit;
