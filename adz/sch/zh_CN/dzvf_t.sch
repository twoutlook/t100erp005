/* 
================================================================================
檔案代號:dzvf_t
檔案名稱:规格与程序版本历程对应表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvf_t
(
dzvf001       varchar2(20)      ,/* 建构代号 */
dzvf002       varchar2(10)      ,/* 建构版号 */
dzvf003       varchar2(15)      ,/* 规格版号 */
dzvf004       varchar2(15)      ,/* 代码版号 */
dzvf005       varchar2(10)      ,/* 建构类型 */
dzvf006       varchar2(10)      ,/* 模块 */
dzvf007       varchar2(10)      ,/* 产品代号 */
dzvf008       varchar2(10)      ,/* 产品版本 */
dzvf009       varchar2(40)      ,/* 客户代号 */
dzvf010       varchar2(1)      /* 识别标示 */
);
alter table dzvf_t add constraint dzvf_pk primary key (dzvf001,dzvf002,dzvf005,dzvf007,dzvf008,dzvf010) enable validate;


grant select on dzvf_t to tiptop;
grant update on dzvf_t to tiptop;
grant delete on dzvf_t to tiptop;
grant insert on dzvf_t to tiptop;

exit;
