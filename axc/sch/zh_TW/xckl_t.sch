/* 
================================================================================
檔案代號:xckl_t
檔案名稱:成本勾稽明细表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xckl_t
(
xcklent       number(5)      ,/* 企业编号 */
xcklcomp       varchar2(10)      ,/* 法人组织 */
xcklld       varchar2(5)      ,/* 账套 */
xckl001       varchar2(10)      ,/* 本位币顺序 */
xckl002       varchar2(10)      ,/* 成本计算类型 */
xckl003       number(5,0)      ,/* 年度 */
xckl004       number(5,0)      ,/* 期别 */
xckl005       varchar2(10)      ,/* 类型代码 */
xckl006       varchar2(20)      ,/* 在制单据编号 */
xckl007       varchar2(40)      ,/* 料号 */
xckl008       varchar2(256)      ,/* 特征 */
xckl009       varchar2(30)      ,/* 批号 */
xckl010       varchar2(30)      ,/* 成本域 */
xckl090       varchar2(20)      ,/* 明细程序编号 */
xckl101       number(20,6)      ,/* 总报表数量 */
xckl102       number(20,6)      ,/* 总报表金额 */
xckl102a       number(20,6)      ,/* 材料 */
xckl102b       number(20,6)      ,/* 人工 */
xckl102c       number(20,6)      ,/* 加工 */
xckl102d       number(20,6)      ,/* 制费一 */
xckl102e       number(20,6)      ,/* 制费二 */
xckl102f       number(20,6)      ,/* 制费三 */
xckl102g       number(20,6)      ,/* 制费四 */
xckl102h       number(20,6)      ,/* 制费五 */
xckl103       number(20,6)      ,/* 分报表数量 */
xckl104       number(20,6)      ,/* 分报表金额 */
xckl104a       number(20,6)      ,/* 分报表材料 */
xckl104b       number(20,6)      ,/* 分报表人工 */
xckl104c       number(20,6)      ,/* 分报表加工 */
xckl104d       number(20,6)      ,/* 分报表制费一 */
xckl104e       number(20,6)      ,/* 分报表制费二 */
xckl104f       number(20,6)      ,/* 分报表制费三 */
xckl104g       number(20,6)      ,/* 分报表制费四 */
xckl104h       number(20,6)      ,/* 分报表制费五 */
xckl105       number(20,6)      ,/* 差异数量 */
xckl106       number(20,6)      ,/* 差异金额 */
xckl106a       number(20,6)      ,/* 差异金额-材料 */
xckl106b       number(20,6)      ,/* 差异金额-人工 */
xckl106c       number(20,6)      ,/* 差异金额-加工 */
xckl106d       number(20,6)      ,/* 差异金额-制费一 */
xckl106e       number(20,6)      ,/* 差异金额-制费二 */
xckl106f       number(20,6)      ,/* 差异金额-制费三 */
xckl106g       number(20,6)      ,/* 差异金额-制费四 */
xckl106h       number(20,6)      /* 差异金额-制费五 */
);
alter table xckl_t add constraint xckl_pk primary key (xcklent,xcklld,xckl001,xckl002,xckl003,xckl004,xckl005,xckl006,xckl007,xckl008,xckl009,xckl010) enable validate;

create unique index xckl_pk on xckl_t (xcklent,xcklld,xckl001,xckl002,xckl003,xckl004,xckl005,xckl006,xckl007,xckl008,xckl009,xckl010);

grant select on xckl_t to tiptop;
grant update on xckl_t to tiptop;
grant delete on xckl_t to tiptop;
grant insert on xckl_t to tiptop;

exit;
