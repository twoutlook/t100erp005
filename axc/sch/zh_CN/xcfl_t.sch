/* 
================================================================================
檔案代號:xcfl_t
檔案名稱:在制貨齡計算明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcfl_t
(
xcflent       number(5)      ,/* 企業編號 */
xcflcomp       varchar2(10)      ,/* 法人組織 */
xcflld       varchar2(5)      ,/* 帳套 */
xcfl001       varchar2(30)      ,/* 成本域 */
xcfl002       varchar2(10)      ,/* 成本計算類型 */
xcfl003       number(5,0)      ,/* 年度 */
xcfl004       number(5,0)      ,/* 期別 */
xcfl005       varchar2(20)      ,/* 工單編號 */
xcfl006       varchar2(40)      ,/* 料件 */
xcfl007       varchar2(256)      ,/* 特性 */
xcfl008       varchar2(30)      ,/* 批號 */
xcfl009       date      ,/* 異動日期 */
xcfl010       number(20,6)      /* 數量 */
);
alter table xcfl_t add constraint xcfl_pk primary key (xcflent,xcflld,xcfl001,xcfl002,xcfl003,xcfl004,xcfl005,xcfl006,xcfl007,xcfl008,xcfl009) enable validate;

create unique index xcfl_pk on xcfl_t (xcflent,xcflld,xcfl001,xcfl002,xcfl003,xcfl004,xcfl005,xcfl006,xcfl007,xcfl008,xcfl009);

grant select on xcfl_t to tiptop;
grant update on xcfl_t to tiptop;
grant delete on xcfl_t to tiptop;
grant insert on xcfl_t to tiptop;

exit;
