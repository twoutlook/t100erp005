/* 
================================================================================
檔案代號:xcagl_t
檔案名稱:物料標準成本檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcagl_t
(
xcagl001       varchar2(10)      ,/* 营运据点 */
xcagl002       varchar2(80)      ,/* 标准成本分类 */
xcagl003       date      ,/* 生效日期 */
xcagl004       date      ,/* 失效日期 */
xcagl005       varchar2(40)      ,/* 物料编码 */
xcagl006       varchar2(6)      ,/* 語言別 */
xcagl007       varchar2(500)      ,/* 說明 */
xcagl008       varchar2(10)      /* 助記碼 */
);
alter table xcagl_t add constraint xcagl_pk primary key (xcagl001,xcagl002,xcagl003,xcagl004,xcagl005,xcagl006) enable validate;


grant select on xcagl_t to tiptop;
grant update on xcagl_t to tiptop;
grant delete on xcagl_t to tiptop;
grant insert on xcagl_t to tiptop;

exit;
