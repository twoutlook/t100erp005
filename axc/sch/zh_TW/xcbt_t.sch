/* 
================================================================================
檔案代號:xcbt_t
檔案名稱:工单制程顺序档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcbt_t
(
xcbtent       number(5)      ,/* 企业代码 */
xcbtsite       varchar2(10)      ,/* 营运据点 */
xcbtcomp       varchar2(10)      ,/* 法人 */
xcbt001       number(5,0)      ,/* 年度 */
xcbt002       number(5,0)      ,/* 期别 */
xcbt003       varchar2(20)      ,/* 工单单号 */
xcbt004       varchar2(10)      ,/* 作业编号 */
xcbt005       varchar2(10)      ,/* 作业序 */
xcbt006       varchar2(10)      ,/* 转出作业编号 */
xcbt007       varchar2(10)      ,/* 转出作业序 */
xcbt008       number(5,0)      ,/* 顺序 */
xcbt009       number(20,6)      ,/* 上站转入数量 */
xcbt010       number(20,6)      ,/* 良品转出数量 */
xcbt011       number(20,6)      ,/* 报废转出数量 */
xcbt012       number(20,6)      ,/* 回收转出数量 */
xcbt013       number(20,6)      /* 当站下线数量 */
);
alter table xcbt_t add constraint xcbt_pk primary key (xcbtent,xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,xcbt006,xcbt007) enable validate;

create  index xcbt_n01 on xcbt_t (xcbtent,xcbt001,xcbt002,xcbt003,xcbt008);
create  index xcbt_n02 on xcbt_t (xcbtent,xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,xcbt008);
create  index xcbt_n03 on xcbt_t (xcbt008);
create unique index xcbt_pk on xcbt_t (xcbtent,xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,xcbt006,xcbt007);

grant select on xcbt_t to tiptop;
grant update on xcbt_t to tiptop;
grant delete on xcbt_t to tiptop;
grant insert on xcbt_t to tiptop;

exit;
