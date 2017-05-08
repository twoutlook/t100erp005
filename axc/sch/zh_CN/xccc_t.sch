/* 
================================================================================
檔案代號:xccc_t
檔案名稱:料件库存成本期异动统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccc_t
(
xcccent       number(5)      ,/* 企业编号 */
xccccomp       varchar2(10)      ,/* 法人组织 */
xcccld       varchar2(5)      ,/* 账套 */
xccc001       varchar2(1)      ,/* 账套本位币顺序 */
xccc002       varchar2(30)      ,/* 成本域 */
xccc003       varchar2(10)      ,/* 成本计算类型 */
xccc004       number(5,0)      ,/* 年度 */
xccc005       number(5,0)      ,/* 期别 */
xccc006       varchar2(40)      ,/* 料号 */
xccc007       varchar2(256)      ,/* 产品特征 */
xccc008       varchar2(30)      ,/* 批号 */
xccc010       varchar2(10)      ,/* 核算币种 */
xccc101       number(20,6)      ,/* 上期结存数量 */
xccc102       number(20,6)      ,/* 上期结存金额 */
xccc102a       number(20,6)      ,/* 上期结存金额-材料 */
xccc102b       number(20,6)      ,/* 上期结存金额-人工 */
xccc102c       number(20,6)      ,/* 上期结存金额-加工 */
xccc102d       number(20,6)      ,/* 上期结存金额-制费一 */
xccc102e       number(20,6)      ,/* 上期结存金额-制费二 */
xccc102f       number(20,6)      ,/* 上期结存金额-制费三 */
xccc102g       number(20,6)      ,/* 上期结存金额-制费四 */
xccc102h       number(20,6)      ,/* 上期结存金额-制费五 */
xccc201       number(20,6)      ,/* 本期采购入库数量 */
xccc202       number(20,6)      ,/* 本期采购入库金额 */
xccc202a       number(20,6)      ,/* 本期采购入库金额-材料 */
xccc202b       number(20,6)      ,/* 本期采购入库金额-人工 */
xccc202c       number(20,6)      ,/* 本期采购入库金额-加工 */
xccc202d       number(20,6)      ,/* 本期采购入库金额-制费一 */
xccc202e       number(20,6)      ,/* 本期采购入库金额-制费二 */
xccc202f       number(20,6)      ,/* 本期采购入库金额-制费三 */
xccc202g       number(20,6)      ,/* 本期采购入库金额-制费四 */
xccc202h       number(20,6)      ,/* 本期采购入库金额-制费五 */
xccc203       number(20,6)      ,/* 本期委外入库数量 */
xccc204       number(20,6)      ,/* 本期委外入库金额 */
xccc204a       number(20,6)      ,/* 本期委外入库金额-材料 */
xccc204b       number(20,6)      ,/* 本期委外入库金额-人工 */
xccc204c       number(20,6)      ,/* 本期委外入库金额-加工 */
xccc204d       number(20,6)      ,/* 本期委外入库金额-制费一 */
xccc204e       number(20,6)      ,/* 本期委外入库金额-制费二 */
xccc204f       number(20,6)      ,/* 本期委外入库金额-制费三 */
xccc204g       number(20,6)      ,/* 本期委外入库金额-制费四 */
xccc204h       number(20,6)      ,/* 本期委外入库金额-制费五 */
xccc205       number(20,6)      ,/* 本期工单入库数量 */
xccc206       number(20,6)      ,/* 本期工单入库金额 */
xccc206a       number(20,6)      ,/* 本期工单入库金额-材料 */
xccc206b       number(20,6)      ,/* 本期工单入库金额-人工 */
xccc206c       number(20,6)      ,/* 本期工单入库金额-加工 */
xccc206d       number(20,6)      ,/* 本期工单入库金额-制费一 */
xccc206e       number(20,6)      ,/* 本期工单入库金额-制费二 */
xccc206f       number(20,6)      ,/* 本期工单入库金额-制费三 */
xccc206g       number(20,6)      ,/* 本期工单入库金额-制费四 */
xccc206h       number(20,6)      ,/* 本期工单入库金额-制费五 */
xccc207       number(20,6)      ,/* 本期返工领出数量 */
xccc208       number(20,6)      ,/* 本期返工领出金额 */
xccc208a       number(20,6)      ,/* 本期返工领出金额-材料 */
xccc208b       number(20,6)      ,/* 本期返工领出金额-人工 */
xccc208c       number(20,6)      ,/* 本期返工领出金额-加工 */
xccc208d       number(20,6)      ,/* 本期返工领出金额-制费一 */
xccc208e       number(20,6)      ,/* 本期返工领出金额-制费二 */
xccc208f       number(20,6)      ,/* 本期返工领出金额-制费三 */
xccc208g       number(20,6)      ,/* 本期返工领出金额-制费四 */
xccc208h       number(20,6)      ,/* 本期返工领出金额-制费五 */
xccc209       number(20,6)      ,/* 本期返工入库数量 */
xccc210       number(20,6)      ,/* 本期返工入库金额 */
xccc210a       number(20,6)      ,/* 本期返工入库金额-材料 */
xccc210b       number(20,6)      ,/* 本期返工入库金额-人工 */
xccc210c       number(20,6)      ,/* 本期返工入库金额-加工 */
xccc210d       number(20,6)      ,/* 本期返工入库金额-制费一 */
xccc210e       number(20,6)      ,/* 本期返工入库金额-制费二 */
xccc210f       number(20,6)      ,/* 本期返工入库金额-制费三 */
xccc210g       number(20,6)      ,/* 本期返工入库金额-制费四 */
xccc210h       number(20,6)      ,/* 本期返工入库金额-制费五 */
xccc211       number(20,6)      ,/* 本期杂项入库数量 */
xccc212       number(20,6)      ,/* 本期杂项入库金额 */
xccc212a       number(20,6)      ,/* 本期杂项入库金额-材料 */
xccc212b       number(20,6)      ,/* 本期杂项入库金额-人工 */
xccc212c       number(20,6)      ,/* 本期杂项入库金额-加工 */
xccc212d       number(20,6)      ,/* 本期杂项入库金额-制费一 */
xccc212e       number(20,6)      ,/* 本期杂项入库金额-制费二 */
xccc212f       number(20,6)      ,/* 本期杂项入库金额-制费三 */
xccc212g       number(20,6)      ,/* 本期杂项入库金额-制费四 */
xccc212h       number(20,6)      ,/* 本期杂项入库金额-制费五 */
xccc213       number(20,6)      ,/* 本期调整入库数量 */
xccc214       number(20,6)      ,/* 本期调整入库金额 */
xccc214a       number(20,6)      ,/* 本期调整入库金额-材料 */
xccc214b       number(20,6)      ,/* 本期调整入库金额-人工 */
xccc214c       number(20,6)      ,/* 本期调整入库金额-加工 */
xccc214d       number(20,6)      ,/* 本期调整入库金额-制费一 */
xccc214e       number(20,6)      ,/* 本期调整入库金额-制费二 */
xccc214f       number(20,6)      ,/* 本期调整入库金额-制费三 */
xccc214g       number(20,6)      ,/* 本期调整入库金额-制费四 */
xccc214h       number(20,6)      ,/* 本期调整入库金额-制费五 */
xccc215       number(20,6)      ,/* 本期销退入库数量 */
xccc216       number(20,6)      ,/* 本期销退入库金额 */
xccc216a       number(20,6)      ,/* 本期销退入库金额-材料 */
xccc216b       number(20,6)      ,/* 本期销退入库金额-人工 */
xccc216c       number(20,6)      ,/* 本期销退入库金额-加工 */
xccc216d       number(20,6)      ,/* 本期销退入库金额-制费一 */
xccc216e       number(20,6)      ,/* 本期销退入库金额-制费二 */
xccc216f       number(20,6)      ,/* 本期销退入库金额-制费三 */
xccc216g       number(20,6)      ,/* 本期销退入库金额-制费四 */
xccc216h       number(20,6)      ,/* 本期销退入库金额-制费五 */
xccc217       number(20,6)      ,/* 本期调拨入库数量 */
xccc218       number(20,6)      ,/* 本期调拨入库金额 */
xccc218a       number(20,6)      ,/* 本期调拨入库金额-材料 */
xccc218b       number(20,6)      ,/* 本期调拨入库金额-人工 */
xccc218c       number(20,6)      ,/* 本期调拨入库金额-加工 */
xccc218d       number(20,6)      ,/* 本期调拨入库金额-制费一 */
xccc218e       number(20,6)      ,/* 本期调拨入库金额-制费二 */
xccc218f       number(20,6)      ,/* 本期调拨入库金额-制费三 */
xccc218g       number(20,6)      ,/* 本期调拨入库金额-制费四 */
xccc218h       number(20,6)      ,/* 本期调拨入库金额-制费五 */
xccc280       number(20,6)      ,/* 本期平均单价 */
xccc280a       number(20,6)      ,/* 本期平均单价-材料 */
xccc280b       number(20,6)      ,/* 本期平均单价-人工 */
xccc280c       number(20,6)      ,/* 本期平均单价-加工 */
xccc280d       number(20,6)      ,/* 本期平均单价-制费一 */
xccc280e       number(20,6)      ,/* 本期平均单价-制费二 */
xccc280f       number(20,6)      ,/* 本期平均单价-制费三 */
xccc280g       number(20,6)      ,/* 本期平均单价-制费四 */
xccc280h       number(20,6)      ,/* 本期平均单价-制费五 */
xccc301       number(20,6)      ,/* 本期工单领用数量 */
xccc302       number(20,6)      ,/* 本期工单领用金额 */
xccc302a       number(20,6)      ,/* 本期工单领用金额-材料 */
xccc302b       number(20,6)      ,/* 本期工单领用金额-人工 */
xccc302c       number(20,6)      ,/* 本期工单领用金额-加工 */
xccc302d       number(20,6)      ,/* 本期工单领用金额-制费一 */
xccc302e       number(20,6)      ,/* 本期工单领用金额-制费二 */
xccc302f       number(20,6)      ,/* 本期工单领用金额-制费三 */
xccc302g       number(20,6)      ,/* 本期工单领用金额-制费四 */
xccc302h       number(20,6)      ,/* 本期工单领用金额-制费五 */
xccc303       number(20,6)      ,/* 本期销货数量 */
xccc304       number(20,6)      ,/* 本期销货成本 */
xccc304a       number(20,6)      ,/* 本期销货成本-材料 */
xccc304b       number(20,6)      ,/* 本期销货成本-人工 */
xccc304c       number(20,6)      ,/* 本期销货成本-加工 */
xccc304d       number(20,6)      ,/* 本期销货成本-制费一 */
xccc304e       number(20,6)      ,/* 本期销货成本-制费二 */
xccc304f       number(20,6)      ,/* 本期销货成本-制费三 */
xccc304g       number(20,6)      ,/* 本期销货成本-制费四 */
xccc304h       number(20,6)      ,/* 本期销货成本-制费五 */
xccc305       number(20,6)      ,/* 本期销退数量 */
xccc306       number(20,6)      ,/* 本期销退成本 */
xccc306a       number(20,6)      ,/* 本期销退成本-材料 */
xccc306b       number(20,6)      ,/* 本期销退成本-人工 */
xccc306c       number(20,6)      ,/* 本期销退成本-加工 */
xccc306d       number(20,6)      ,/* 本期销退成本-制费一 */
xccc306e       number(20,6)      ,/* 本期销退成本-制费二 */
xccc306f       number(20,6)      ,/* 本期销退成本-制费三 */
xccc306g       number(20,6)      ,/* 本期销退成本-制费四 */
xccc306h       number(20,6)      ,/* 本期销退成本-制费五 */
xccc307       number(20,6)      ,/* 本期销售费用数量 */
xccc308       number(20,6)      ,/* 本期销售费用成本 */
xccc308a       number(20,6)      ,/* 本期销售费用成本-材料 */
xccc308b       number(20,6)      ,/* 本期销售费用成本-人工 */
xccc308c       number(20,6)      ,/* 本期销售费用成本-加工 */
xccc308d       number(20,6)      ,/* 本期销售费用成本-制费一 */
xccc308e       number(20,6)      ,/* 本期销售费用成本-制费二 */
xccc308f       number(20,6)      ,/* 本期销售费用成本-制费三 */
xccc308g       number(20,6)      ,/* 本期销售费用成本-制费四 */
xccc308h       number(20,6)      ,/* 本期销售费用成本-制费五 */
xccc309       number(20,6)      ,/* 本期杂发数量 */
xccc310       number(20,6)      ,/* 本期杂发金额 */
xccc310a       number(20,6)      ,/* 本期杂发金额-材料 */
xccc310b       number(20,6)      ,/* 本期杂发金额-人工 */
xccc310c       number(20,6)      ,/* 本期杂发金额-加工 */
xccc310d       number(20,6)      ,/* 本期杂发金额-制费一 */
xccc310e       number(20,6)      ,/* 本期杂发金额-制费二 */
xccc310f       number(20,6)      ,/* 本期杂发金额-制费三 */
xccc310g       number(20,6)      ,/* 本期杂发金额-制费四 */
xccc310h       number(20,6)      ,/* 本期杂发金额-制费五 */
xccc311       number(20,6)      ,/* 本期盘盈亏数量 */
xccc312       number(20,6)      ,/* 本期盘盈亏金额 */
xccc312a       number(20,6)      ,/* 本期盘盈亏金额-材料 */
xccc312b       number(20,6)      ,/* 本期盘盈亏金额-人工 */
xccc312c       number(20,6)      ,/* 本期盘盈亏金额-加工 */
xccc312d       number(20,6)      ,/* 本期盘盈亏金额-制费一 */
xccc312e       number(20,6)      ,/* 本期盘盈亏金额-制费二 */
xccc312f       number(20,6)      ,/* 本期盘盈亏金额-制费三 */
xccc312g       number(20,6)      ,/* 本期盘盈亏金额-制费四 */
xccc312h       number(20,6)      ,/* 本期盘盈亏金额-制费五 */
xccc313       number(20,6)      ,/* 本期调拨出库数量 */
xccc314       number(20,6)      ,/* 本期调拨出库金额 */
xccc314a       number(20,6)      ,/* 本期调拨出库金额-材料 */
xccc314b       number(20,6)      ,/* 本期调拨出库金额-人工 */
xccc314c       number(20,6)      ,/* 本期调拨出库金额-加工 */
xccc314d       number(20,6)      ,/* 本期调拨出库金额-制费一 */
xccc314e       number(20,6)      ,/* 本期调拨出库金额-制费二 */
xccc314f       number(20,6)      ,/* 本期调拨出库金额-制费三 */
xccc314g       number(20,6)      ,/* 本期调拨出库金额-制费四 */
xccc314h       number(20,6)      ,/* 本期调拨出库金额-制费五 */
xccc401       number(20,6)      ,/* 本期销货收入金额 */
xccc402       number(20,6)      ,/* 本期销退金额 */
xccc901       number(20,6)      ,/* 期末结存数量 */
xccc902       number(20,6)      ,/* 期末结存金额 */
xccc902a       number(20,6)      ,/* 期末结存金额-材料 */
xccc902b       number(20,6)      ,/* 期末结存金额-人工 */
xccc902c       number(20,6)      ,/* 期末结存金额-加工 */
xccc902d       number(20,6)      ,/* 期末结存金额-制费一 */
xccc902e       number(20,6)      ,/* 期末结存金额-制费二 */
xccc902f       number(20,6)      ,/* 期末结存金额-制费三 */
xccc902g       number(20,6)      ,/* 期末结存金额-制费四 */
xccc902h       number(20,6)      ,/* 期末结存金额-制费五 */
xccc903       number(20,6)      ,/* 期末结存调整金额 */
xccc903a       number(20,6)      ,/* 期末结存调整金额-材料 */
xccc903b       number(20,6)      ,/* 期末结存调整金额-人工 */
xccc903c       number(20,6)      ,/* 期末结存调整金额-加工 */
xccc903d       number(20,6)      ,/* 期末结存调整金额-制费一 */
xccc903e       number(20,6)      ,/* 期末结存调整金额-制费二 */
xccc903f       number(20,6)      ,/* 期末结存调整金额-制费三 */
xccc903g       number(20,6)      ,/* 期末结存调整金额-制费四 */
xccc903h       number(20,6)      ,/* 期末结存调整金额-制费五 */
xccctime       timestamp(0)      /* 最近成本计算时间 */
);
alter table xccc_t add constraint xccc_pk primary key (xcccent,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008) enable validate;

create  index xccc_n on xccc_t (xcccent,xcccld,xccc003,xccc004,xccc005);
create  index xccc_n1 on xccc_t (xcccent,xcccld,xccc001,xccc003,xccc004,xccc005,xccc006);
create unique index xccc_pk on xccc_t (xcccent,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008);

grant select on xccc_t to tiptop;
grant update on xccc_t to tiptop;
grant delete on xccc_t to tiptop;
grant insert on xccc_t to tiptop;

exit;
