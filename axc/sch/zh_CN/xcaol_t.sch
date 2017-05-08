/* 
================================================================================
檔案代號:xcaol_t
檔案名稱:成本差異分攤依據單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcaol_t
(
xcaolent       number(5)      ,/* 企业编号 */
xcaolld       varchar2(5)      ,/* 账别编号 */
xcaol001       varchar2(80)      ,/* 分摊公式类型 */
xcaol002       varchar2(6)      ,/* 語言別 */
xcaol003       varchar2(500)      ,/* 說明 */
xcaol004       varchar2(10)      /* 助記碼 */
);
alter table xcaol_t add constraint xcaol_pk primary key (xcaolent,xcaolld,xcaol001,xcaol002) enable validate;

create unique index xcaol_pk on xcaol_t (xcaolent,xcaolld,xcaol001,xcaol002);

grant select on xcaol_t to tiptop;
grant update on xcaol_t to tiptop;
grant delete on xcaol_t to tiptop;
grant insert on xcaol_t to tiptop;

exit;
