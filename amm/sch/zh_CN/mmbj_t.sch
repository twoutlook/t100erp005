/* 
================================================================================
檔案代號:mmbj_t
檔案名稱:會員卡券存放位置異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmbj_t
(
mmbjent       number(5)      ,/* 企業編號 */
mmbjsite       varchar2(10)      ,/* 營運據點 */
mmbj000       varchar2(10)      ,/* 資料類型 */
mmbj001       varchar2(30)      ,/* 會員卡號 */
mmbj002       varchar2(10)      ,/* 卡種編號 */
mmbj003       varchar2(20)      ,/* 異動作業 */
mmbj004       varchar2(20)      ,/* 異動單據編號 */
mmbj005       date      ,/* 異動日期 */
mmbj006       number(5,0)      ,/* 異動類型 */
mmbj007       varchar2(10)      ,/* 異動庫位 */
mmbj008       date      ,/* 資料產生日期 */
mmbj009       timestamp(0)      ,/* 資料產生時間 */
mmbj010       varchar2(20)      ,/* 資料產生人員 */
mmbj011       number(10,0)      /* 異動數量 */
);
alter table mmbj_t add constraint mmbj_pk primary key (mmbjent,mmbj000,mmbj001,mmbj002,mmbj004,mmbj006,mmbj007) enable validate;

create unique index mmbj_pk on mmbj_t (mmbjent,mmbj000,mmbj001,mmbj002,mmbj004,mmbj006,mmbj007);

grant select on mmbj_t to tiptop;
grant update on mmbj_t to tiptop;
grant delete on mmbj_t to tiptop;
grant insert on mmbj_t to tiptop;

exit;
