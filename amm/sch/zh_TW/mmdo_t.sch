/* 
================================================================================
檔案代號:mmdo_t
檔案名稱:会员晋级数据统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmdo_t
(
mmdoent       number(5)      ,/* 企业编号 */
mmdo001       varchar2(20)      ,/* 销售单号 */
mmdo002       number(10,0)      ,/* 销售项次 */
mmdo003       date      ,/* 销售日期 */
mmdo004       varchar2(10)      ,/* 销售组织 */
mmdo005       varchar2(30)      ,/* 会员编号 */
mmdo006       varchar2(30)      ,/* 会员卡号 */
mmdo007       varchar2(40)      ,/* 商品编号 */
mmdo008       number(20,6)      ,/* 消费额 */
mmdo009       number(15,3)      ,/* 积分 */
mmdo010       varchar2(20)      ,/* 作业编号 */
mmdo011       varchar2(20)      ,/* 销退来源销售单号 */
mmdo012       number(10,0)      ,/* 销退来源销售项次 */
mmdo013       varchar2(1)      /* 累计至会员卡数据 */
);
alter table mmdo_t add constraint mmdo_pk primary key (mmdoent,mmdo001,mmdo002) enable validate;

create unique index mmdo_pk on mmdo_t (mmdoent,mmdo001,mmdo002);

grant select on mmdo_t to tiptop;
grant update on mmdo_t to tiptop;
grant delete on mmdo_t to tiptop;
grant insert on mmdo_t to tiptop;

exit;
