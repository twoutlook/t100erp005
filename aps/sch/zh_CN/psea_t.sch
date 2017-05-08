/* 
================================================================================
檔案代號:psea_t
檔案名稱:APS运行阶段记录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psea_t
(
pseaent       number(5)      ,/* 企业编号 */
pseasite       varchar2(10)      ,/* 营运据点 */
psea001       varchar2(10)      ,/* APS版本 */
psea002       varchar2(20)      ,/* 运行日期时间 */
psea003       varchar2(10)      ,/* 运行阶段编号 */
psea004       varchar2(20)      ,/* 处理数据 */
psea005       varchar2(20)      /* 执行人 */
);
alter table psea_t add constraint psea_pk primary key (pseaent,pseasite,psea001,psea002) enable validate;

create unique index psea_pk on psea_t (pseaent,pseasite,psea001,psea002);

grant select on psea_t to tiptop;
grant update on psea_t to tiptop;
grant delete on psea_t to tiptop;
grant insert on psea_t to tiptop;

exit;
