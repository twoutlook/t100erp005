/* 
================================================================================
檔案代號:xcct_t
檔案名稱:在制成本异动明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcct_t
(
xcctent       number(5)      ,/* 企业代码 */
xcctcomp       varchar2(10)      ,/* 法人 */
xcctld       varchar2(5)      ,/* 帐别 */
xcct001       varchar2(1)      ,/* 账套本位币顺序 */
xcct002       varchar2(30)      ,/* 成本域 */
xcct003       varchar2(10)      ,/* 成本计算类型 */
xcct004       number(5,0)      ,/* 年度 */
xcct005       number(5,0)      ,/* 期别 */
xcct006       varchar2(20)      ,/* 工单编号 */
xcct007       varchar2(40)      ,/* 元件编号 */
xcct008       varchar2(256)      ,/* 产品特征 */
xcct009       varchar2(30)      ,/* 批号 */
xcct010       varchar2(20)      ,/* 异动单据 */
xcct011       number(10,0)      ,/* 异动项次 */
xcct012       number(10,0)      ,/* 异动项序 */
xcct013       varchar2(10)      ,/* 异动类型 */
xcct014       varchar2(10)      ,/* 单据类型 */
xcct015       date      ,/* 单据日期 */
xcct016       varchar2(8)      ,/* 单据时间 */
xcct017       varchar2(10)      ,/* 核算币别 */
xcct101       number(20,6)      ,/* 前次结存数量 */
xcct102       number(20,6)      ,/* 前次结存金额 */
xcct102a       number(20,6)      ,/* 前次结存金额-材料 */
xcct102b       number(20,6)      ,/* 前次结存金额-人工 */
xcct102c       number(20,6)      ,/* 前次结存金额-加工 */
xcct102d       number(20,6)      ,/* 前次结存金额-制费一 */
xcct102e       number(20,6)      ,/* 前次结存金额-制费二 */
xcct102f       number(20,6)      ,/* 前次结存金额-制费三 */
xcct102g       number(20,6)      ,/* 前次结存金额-制费四 */
xcct102h       number(20,6)      ,/* 前次结存金额-制费五 */
xcct201       number(20,6)      ,/* 本期异动数量 */
xcct202       number(20,6)      ,/* 本期异动金额 */
xcct202a       number(20,6)      ,/* 本期异动金额-材料 */
xcct202b       number(20,6)      ,/* 本期异动金额-人工 */
xcct202c       number(20,6)      ,/* 本期异动金额-加工 */
xcct202d       number(20,6)      ,/* 本期异动金额-制费一 */
xcct202e       number(20,6)      ,/* 本期异动金额-制费二 */
xcct202f       number(20,6)      ,/* 本期异动金额-制费三 */
xcct202g       number(20,6)      ,/* 本期异动金额-制费四 */
xcct202h       number(20,6)      ,/* 本期异动金额-制费五 */
xcct901       number(20,6)      ,/* 本次结存数量 */
xcct902       number(20,6)      ,/* 本次结存金额 */
xcct902a       number(20,6)      ,/* 本次结存金额-材料 */
xcct902b       number(20,6)      ,/* 本次结存金额-人工 */
xcct902c       number(20,6)      ,/* 本次结存金额-加工 */
xcct902d       number(20,6)      ,/* 本次结存金额-制费一 */
xcct902e       number(20,6)      ,/* 本次结存金额-制费二 */
xcct902f       number(20,6)      ,/* 本次结存金额-制费三 */
xcct902g       number(20,6)      ,/* 本次结存金额-制费四 */
xcct902h       number(20,6)      ,/* 本次结存金额-制费五 */
xcctcrtdt       timestamp(0)      /* 最近成本计算时间 */
);
alter table xcct_t add constraint xcct_pk primary key (xcctent,xcctld,xcct001,xcct002,xcct003,xcct004,xcct005,xcct006,xcct007,xcct008,xcct009,xcct010,xcct011,xcct012) enable validate;

create unique index xcct_pk on xcct_t (xcctent,xcctld,xcct001,xcct002,xcct003,xcct004,xcct005,xcct006,xcct007,xcct008,xcct009,xcct010,xcct011,xcct012);

grant select on xcct_t to tiptop;
grant update on xcct_t to tiptop;
grant delete on xcct_t to tiptop;
grant insert on xcct_t to tiptop;

exit;
