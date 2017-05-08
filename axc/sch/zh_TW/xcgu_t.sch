/* 
================================================================================
檔案代號:xcgu_t
檔案名稱:料件即时数量成本档（期末值）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcgu_t
(
xcguent       number(5)      ,/* 企业编号 */
xcgucomp       varchar2(10)      ,/* 法人组织 */
xcguld       varchar2(5)      ,/* 账套 */
xcgu001       varchar2(1)      ,/* 账套本位币顺序 */
xcgu002       varchar2(30)      ,/* 成本域 */
xcgu003       varchar2(10)      ,/* 成本计算类型 */
xcgu004       varchar2(40)      ,/* 料号 */
xcgu005       varchar2(256)      ,/* 特性码 */
xcgu006       varchar2(30)      ,/* 批号 */
xcgu007       number(5,0)      ,/* 年度 */
xcgu008       number(5,0)      ,/* 期别 */
xcgu010       varchar2(10)      ,/* 核算币种 */
xcgu101       number(20,6)      ,/* 数量 */
xcgu102       number(20,6)      ,/* 成本金额 */
xcgu102a       number(20,6)      ,/* 成本金额-材料 */
xcgu102b       number(20,6)      ,/* 成本金额-人工 */
xcgu102c       number(20,6)      ,/* 成本金额-加工 */
xcgu102d       number(20,6)      ,/* 成本金额-制费一 */
xcgu102e       number(20,6)      ,/* 成本金额-制费二 */
xcgu102f       number(20,6)      ,/* 成本金额-制费三 */
xcgu102g       number(20,6)      ,/* 成本金额-制费四 */
xcgu102h       number(20,6)      ,/* 成本金额制费五 */
xcgu202       number(20,6)      ,/* 单位成本 */
xcgu202a       number(20,6)      ,/* 单位成本-材料 */
xcgu202b       number(20,6)      ,/* 单位成本-人工 */
xcgu202c       number(20,6)      ,/* 单位成本-加工 */
xcgu202d       number(20,6)      ,/* 单位成本-制费一 */
xcgu202e       number(20,6)      ,/* 单位成本-制费二 */
xcgu202f       number(20,6)      ,/* 单位成本-制费三 */
xcgu202g       number(20,6)      ,/* 单位成本-制费四 */
xcgu202h       number(20,6)      ,/* 单位成本-制费五 */
xcgumoddt       timestamp(0)      /* 最近成本计算时间 */
);
alter table xcgu_t add constraint xcgu_pk primary key (xcguent,xcguld,xcgu001,xcgu002,xcgu003,xcgu004,xcgu005,xcgu006,xcgu007,xcgu008) enable validate;

create unique index xcgu_pk on xcgu_t (xcguent,xcguld,xcgu001,xcgu002,xcgu003,xcgu004,xcgu005,xcgu006,xcgu007,xcgu008);

grant select on xcgu_t to tiptop;
grant update on xcgu_t to tiptop;
grant delete on xcgu_t to tiptop;
grant insert on xcgu_t to tiptop;

exit;
