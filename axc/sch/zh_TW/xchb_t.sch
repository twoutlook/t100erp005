/* 
================================================================================
檔案代號:xchb_t
檔案名稱:工艺工单在制作业元件成本期异动统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xchb_t
(
xchbent       number(5)      ,/* 企业编号 */
xchbcomp       varchar2(10)      ,/* 法人组织 */
xchbld       varchar2(5)      ,/* 账套 */
xchb001       varchar2(1)      ,/* 账套本位币顺序 */
xchb002       varchar2(30)      ,/* 成本域 */
xchb003       varchar2(10)      ,/* 成本计算类型 */
xchb004       number(5,0)      ,/* 年度 */
xchb005       number(5,0)      ,/* 期别 */
xchb006       varchar2(20)      ,/* 工单编号 */
xchb007       varchar2(10)      ,/* 作业编号 */
xchb008       varchar2(10)      ,/* 作业序 */
xchb009       varchar2(40)      ,/* 元件料号 */
xchb010       varchar2(256)      ,/* 产品特征 */
xchb011       varchar2(30)      ,/* 批号 */
xchb012       varchar2(20)      ,/* 项目号 */
xchb013       varchar2(10)      ,/* 核算币种 */
xchb014       varchar2(10)      ,/* 投入作业 */
xchb015       varchar2(10)      ,/* 投入作业序 */
xchb101       number(20,6)      ,/* 上期结存数量 */
xchb102       number(20,6)      ,/* 上期结存金额 */
xchb102a       number(20,6)      ,/* 上期结存金额-材料 */
xchb102b       number(20,6)      ,/* 上期结存金额-人工 */
xchb102c       number(20,6)      ,/* 上期结存金额-加工 */
xchb102d       number(20,6)      ,/* 上期结存金额-制费一 */
xchb102e       number(20,6)      ,/* 上期结存金额-制费二 */
xchb102f       number(20,6)      ,/* 上期结存金额-制费三 */
xchb102g       number(20,6)      ,/* 上期结存金额-制费四 */
xchb102h       number(20,6)      ,/* 上期结存金额-制费五 */
xchb201       number(20,6)      ,/* 本期投入数量 */
xchb202       number(20,6)      ,/* 本期投入金额 */
xchb202a       number(20,6)      ,/* 本期投入金额-材料 */
xchb202b       number(20,6)      ,/* 本期投入金额-人工 */
xchb202c       number(20,6)      ,/* 本期投入金额-加工 */
xchb202d       number(20,6)      ,/* 本期投入金额-制费一 */
xchb202e       number(20,6)      ,/* 本期投入金额-制费二 */
xchb202f       number(20,6)      ,/* 本期投入金额-制费三 */
xchb202g       number(20,6)      ,/* 本期投入金额-制费四 */
xchb202h       number(20,6)      ,/* 本期投入金额-制费五 */
xchb203       number(20,6)      ,/* 上站转入数量 */
xchb204       number(20,6)      ,/* 上站转入金额 */
xchb204a       number(20,6)      ,/* 上站转入金额-材料 */
xchb204b       number(20,6)      ,/* 上站转入金额-人工 */
xchb204c       number(20,6)      ,/* 上站转入金额-加工 */
xchb204d       number(20,6)      ,/* 上站转入金额-制费一 */
xchb204e       number(20,6)      ,/* 上站转入金额-制费二 */
xchb204f       number(20,6)      ,/* 上站转入金额-制费三 */
xchb204g       number(20,6)      ,/* 上站转入金额-制费四 */
xchb204h       number(20,6)      ,/* 上站转入金额-制费五 */
xchb207       number(20,6)      ,/* 本期一般退料数量 */
xchb208       number(20,6)      ,/* 本期一般退料成本 */
xchb208a       number(20,6)      ,/* 本期一般退料成本-材料 */
xchb208b       number(20,6)      ,/* 本期一般退料成本-人工 */
xchb208c       number(20,6)      ,/* 本期一般退料成本-加工 */
xchb208d       number(20,6)      ,/* 本期一般退料成本-制费一 */
xchb208e       number(20,6)      ,/* 本期一般退料成本-制费二 */
xchb208f       number(20,6)      ,/* 本期一般退料成本-制费三 */
xchb208g       number(20,6)      ,/* 本期一般退料成本-制费四 */
xchb208h       number(20,6)      ,/* 本期一般退料成本-制费五 */
xchb209       number(20,6)      ,/* 本期超领退数量 */
xchb210       number(20,6)      ,/* 本期超领退金额 */
xchb210a       number(20,6)      ,/* 本期超领退金额-材料 */
xchb210b       number(20,6)      ,/* 本期超领退金额-人工 */
xchb210c       number(20,6)      ,/* 本期超领退金额-加工 */
xchb210d       number(20,6)      ,/* 本期超领退金额-制费一 */
xchb210e       number(20,6)      ,/* 本期超领退金额-制费二 */
xchb210f       number(20,6)      ,/* 本期超领退金额-制费三 */
xchb210g       number(20,6)      ,/* 本期超领退金额-制费四 */
xchb210h       number(20,6)      ,/* 本期超领退金额-制费五 */
xchb301       number(20,6)      ,/* 良品转出数量 */
xchb302       number(20,6)      ,/* 良品转出金额 */
xchb302a       number(20,6)      ,/* 良品转出金额-材料 */
xchb302b       number(20,6)      ,/* 良品转出金额-人工 */
xchb302c       number(20,6)      ,/* 良品转出金额-加工 */
xchb302d       number(20,6)      ,/* 良品转出金额-制费一 */
xchb302e       number(20,6)      ,/* 良品转出金额-制费二 */
xchb302f       number(20,6)      ,/* 良品转出金额-制费三 */
xchb302g       number(20,6)      ,/* 良品转出金额-制费四 */
xchb302h       number(20,6)      ,/* 良品转出金额-制费五 */
xchb303       number(20,6)      ,/* 报废数量 */
xchb304       number(20,6)      ,/* 报废金额 */
xchb304a       number(20,6)      ,/* 报废金额-材料 */
xchb304b       number(20,6)      ,/* 报废金额-人工 */
xchb304c       number(20,6)      ,/* 报废金额-加工 */
xchb304d       number(20,6)      ,/* 报废金额-制费一 */
xchb304e       number(20,6)      ,/* 报废金额-制费二 */
xchb304f       number(20,6)      ,/* 报废金额-制费三 */
xchb304g       number(20,6)      ,/* 报废金额-制费四 */
xchb304h       number(20,6)      ,/* 报废金额-制费五 */
xchb305       number(20,6)      ,/* 当站下线数量 */
xchb306       number(20,6)      ,/* 当站下线金额 */
xchb306a       number(20,6)      ,/* 当站下线金额-材料 */
xchb306b       number(20,6)      ,/* 当站下线金额-人工 */
xchb306c       number(20,6)      ,/* 当站下线金额-加工 */
xchb306d       number(20,6)      ,/* 当站下线金额-制费一 */
xchb306e       number(20,6)      ,/* 当站下线金额-制费二 */
xchb306f       number(20,6)      ,/* 当站下线金额-制费三 */
xchb306g       number(20,6)      ,/* 当站下线金额-制费四 */
xchb306h       number(20,6)      ,/* 当站下线金额-制费五 */
xchb307       number(20,6)      ,/* 回收转出数量 */
xchb308       number(20,6)      ,/* 回收转出金额 */
xchb308a       number(20,6)      ,/* 回收转出金额-材料 */
xchb308b       number(20,6)      ,/* 回收转出金额-人工 */
xchb308c       number(20,6)      ,/* 回收转出金额-委外 */
xchb308d       number(20,6)      ,/* 回收转出金额-制费一 */
xchb308e       number(20,6)      ,/* 回收转出金额-制费二 */
xchb308f       number(20,6)      ,/* 回收转出金额-制费三 */
xchb308g       number(20,6)      ,/* 回收转出金额-制费四 */
xchb308h       number(20,6)      ,/* 回收转出金额-制费五 */
xchb309       number(20,6)      ,/* 差异转出数量 */
xchb310       number(20,6)      ,/* 差异转出金额 */
xchb310a       number(20,6)      ,/* 差异转出金额-材料 */
xchb310b       number(20,6)      ,/* 差异转出金额-人工 */
xchb310c       number(20,6)      ,/* 差异转出金额-加工 */
xchb310d       number(20,6)      ,/* 差异转出金额-制费一 */
xchb310e       number(20,6)      ,/* 差异转出金额-制费二 */
xchb310f       number(20,6)      ,/* 差异转出金额-制费三 */
xchb310g       number(20,6)      ,/* 差异转出金额-制费四 */
xchb310h       number(20,6)      ,/* 差异转出金额-制费五 */
xchb901       number(20,6)      ,/* 期末结存数量 */
xchb902       number(20,6)      ,/* 期末结存金额 */
xchb902a       number(20,6)      ,/* 期末结存金额-材料 */
xchb902b       number(20,6)      ,/* 期末结存金额-人工 */
xchb902c       number(20,6)      ,/* 期末结存金额-加工 */
xchb902d       number(20,6)      ,/* 期末结存金额-制费一 */
xchb902e       number(20,6)      ,/* 期末结存金额-制费二 */
xchb902f       number(20,6)      ,/* 期末结存金额-制费三 */
xchb902g       number(20,6)      ,/* 期末结存金额-制费四 */
xchb902h       number(20,6)      ,/* 期末结存金额-制费五 */
xchbtime       timestamp(0)      /* 最近成本计算时间 */
);
alter table xchb_t add constraint xchb_pk primary key (xchbent,xchbld,xchb001,xchb002,xchb003,xchb004,xchb005,xchb006,xchb007,xchb008,xchb009,xchb010,xchb011,xchb014,xchb015) enable validate;

create  index xchb_n01 on xchb_t (xchb006);
create unique index xchb_pk on xchb_t (xchbent,xchbld,xchb001,xchb002,xchb003,xchb004,xchb005,xchb006,xchb007,xchb008,xchb009,xchb010,xchb011,xchb014,xchb015);

grant select on xchb_t to tiptop;
grant update on xchb_t to tiptop;
grant delete on xchb_t to tiptop;
grant insert on xchb_t to tiptop;

exit;
