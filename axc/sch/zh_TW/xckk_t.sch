/* 
================================================================================
檔案代號:xckk_t
檔案名稱:成本勾稽表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xckk_t
(
xckkent       number(5)      ,/* 企业编号 */
xckkcomp       varchar2(10)      ,/* 法人组织 */
xckkld       varchar2(5)      ,/* 账套 */
xckk001       varchar2(1)      ,/* 本位币顺序 */
xckk002       varchar2(10)      ,/* 成本计算类型 */
xckk003       number(5,0)      ,/* 年度 */
xckk004       number(5,0)      ,/* 期别 */
xckk005       varchar2(10)      ,/* 类型代码 */
xckk090       varchar2(20)      ,/* 明细程序编号 */
xckk101       number(20,6)      ,/* 总报表数量 */
xckk102       number(20,6)      ,/* 总报表金额 */
xckk102a       number(20,6)      ,/* 材料 */
xckk102b       number(20,6)      ,/* 人工 */
xckk102c       number(20,6)      ,/* 加工 */
xckk102d       number(20,6)      ,/* 制费一 */
xckk102e       number(20,6)      ,/* 制费二 */
xckk102f       number(20,6)      ,/* 制费三 */
xckk102g       number(20,6)      ,/* 制费四 */
xckk102h       number(20,6)      ,/* 制费五 */
xckk103       number(20,6)      ,/* 分报表数量 */
xckk104       number(20,6)      ,/* 分报表金额 */
xckk104a       number(20,6)      ,/* 分报表材料 */
xckk104b       number(20,6)      ,/* 分报表人工 */
xckk104c       number(20,6)      ,/* 分报表加工 */
xckk104d       number(20,6)      ,/* 分报表制费一 */
xckk104e       number(20,6)      ,/* 分报表制费二 */
xckk104f       number(20,6)      ,/* 分报表制费三 */
xckk104g       number(20,6)      ,/* 分报表制费四 */
xckk104h       number(20,6)      ,/* 分报表制费五 */
xckk105       number(20,6)      ,/* 差异数量 */
xckk106       number(20,6)      ,/* 差异金额 */
xckk106a       number(20,6)      ,/* 差异金额-材料 */
xckk106b       number(20,6)      ,/* 差异金额-人工 */
xckk106c       number(20,6)      ,/* 差异金额-加工 */
xckk106d       number(20,6)      ,/* 差异金额-制费一 */
xckk106e       number(20,6)      ,/* 差异金额-制费二 */
xckk106f       number(20,6)      ,/* 差异金额-制费三 */
xckk106g       number(20,6)      ,/* 差异金额-制费四 */
xckk106h       number(20,6)      /* 差异金额-制费五 */
);
alter table xckk_t add constraint xckk_pk primary key (xckkent,xckkld,xckk001,xckk002,xckk003,xckk004,xckk005) enable validate;

create unique index xckk_pk on xckk_t (xckkent,xckkld,xckk001,xckk002,xckk003,xckk004,xckk005);

grant select on xckk_t to tiptop;
grant update on xckk_t to tiptop;
grant delete on xckk_t to tiptop;
grant insert on xckk_t to tiptop;

exit;
