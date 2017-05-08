/* 
================================================================================
檔案代號:wsec_t
檔案名稱:整合產品資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsec_t
(
wsec001       varchar2(10)      ,/* 產品別 */
wsec002       varchar2(80)      ,/* 產品名稱 */
wsecstus       varchar2(10)      ,/* 狀態碼 */
wsecownid       varchar2(20)      ,/* 資料所有者 */
wsecowndp       varchar2(10)      ,/* 資料所屬部門 */
wseccrtid       varchar2(20)      ,/* 資料建立者 */
wseccrtdp       varchar2(10)      ,/* 資料建立部門 */
wseccrtdt       timestamp(0)      ,/* 資料創建日 */
wsecmodid       varchar2(20)      ,/* 資料修改者 */
wsecmoddt       timestamp(0)      /* 最近修改日 */
);
alter table wsec_t add constraint wsec_pk primary key (wsec001) enable validate;

create unique index wsec_pk on wsec_t (wsec001);

grant select on wsec_t to tiptop;
grant update on wsec_t to tiptop;
grant delete on wsec_t to tiptop;
grant insert on wsec_t to tiptop;

exit;
