/* 
================================================================================
檔案代號:rtda_t
檔案名稱:商品生命周期表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtda_t
(
rtdaent       number(5)      ,/* 企業代碼 */
rtda001       varchar2(10)      ,/* 生命週期編號 */
rtda002       number(5,0)      ,/* 生命週期順序 */
rtda003       varchar2(10)      ,/* 自動轉換方式 */
rtda004       number(5,0)      ,/* 固定天數 */
rtda005       varchar2(20)      ,/* 程式編號 */
rtdaownid       varchar2(20)      ,/* 資料所有者 */
rtdaowndp       varchar2(10)      ,/* 資料所有部門 */
rtdacrtid       varchar2(20)      ,/* 資料建立者 */
rtdacrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdacrtdt       timestamp(0)      ,/* 資料創建日 */
rtdamodid       varchar2(20)      ,/* 資料修改者 */
rtdamoddt       timestamp(0)      ,/* 最近修改日 */
rtdastus       varchar2(10)      ,/* 狀態碼 */
rtda006       varchar2(10)      /* 狀態 */
);
alter table rtda_t add constraint rtda_pk primary key (rtdaent,rtda001,rtda005) enable validate;

create unique index rtda_pk on rtda_t (rtdaent,rtda001,rtda005);

grant select on rtda_t to tiptop;
grant update on rtda_t to tiptop;
grant delete on rtda_t to tiptop;
grant insert on rtda_t to tiptop;

exit;
