/* 
================================================================================
檔案代號:xccd_t
檔案名稱:在制主件成本期异动统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccd_t
(
xccdent       number(5)      ,/* 企业编号 */
xccdcomp       varchar2(10)      ,/* 法人组织 */
xccdld       varchar2(5)      ,/* 账套 */
xccd001       varchar2(1)      ,/* 账套本位币顺序 */
xccd002       varchar2(30)      ,/* 成本域 */
xccd003       varchar2(10)      ,/* 成本计算类型 */
xccd004       number(5,0)      ,/* 年度 */
xccd005       number(5,0)      ,/* 期别 */
xccd006       varchar2(20)      ,/* 工单编号 */
xccd007       varchar2(40)      ,/* 主件料号 */
xccd008       varchar2(256)      ,/* 产品特征 */
xccd009       varchar2(30)      ,/* 批号 */
xccd010       varchar2(20)      ,/* 项目号 */
xccd011       varchar2(10)      ,/* 核算币种 */
xccd012       varchar2(1)      ,/* 重复性成产否 */
xccd013       varchar2(10)      ,/* 成产计划号 */
xccd014       varchar2(30)      ,/* BOM特性 */
xccd101       number(20,6)      ,/* 上期结存数量 */
xccd102       number(20,6)      ,/* 上期结存金额 */
xccd102a       number(20,6)      ,/* 上期结存金额-材料 */
xccd102b       number(20,6)      ,/* 上期结存金额-人工 */
xccd102c       number(20,6)      ,/* 上期结存金额-加工 */
xccd102d       number(20,6)      ,/* 上期结存金额-制费一 */
xccd102e       number(20,6)      ,/* 上期结存金额-制费二 */
xccd102f       number(20,6)      ,/* 上期结存金额-制费三 */
xccd102g       number(20,6)      ,/* 上期结存金额-制费四 */
xccd102h       number(20,6)      ,/* 上期结存金额-制费五 */
xccd200       number(20,6)      ,/* 本期投入工时 */
xccd201       number(20,6)      ,/* 本期投入数量 */
xccd202       number(20,6)      ,/* 本期本阶投入金额 */
xccd202a       number(20,6)      ,/* 本期本阶投入金额-材料 */
xccd202b       number(20,6)      ,/* 本期本阶投入金额-人工 */
xccd202c       number(20,6)      ,/* 本期本阶投入金额-加工 */
xccd202d       number(20,6)      ,/* 本期本阶投入金额-制费一 */
xccd202e       number(20,6)      ,/* 本期本阶投入金额-制费二 */
xccd202f       number(20,6)      ,/* 本期本阶投入金额-制费三 */
xccd202g       number(20,6)      ,/* 本期本阶投入金额-制费四 */
xccd202h       number(20,6)      ,/* 本期本阶投入金额-制费五 */
xccd204       number(20,6)      ,/* 本期下阶投入金额 */
xccd204a       number(20,6)      ,/* 本期下阶投入金额-材料 */
xccd204b       number(20,6)      ,/* 本期下阶投入金额-人工 */
xccd204c       number(20,6)      ,/* 本期下阶投入金额-加工 */
xccd204d       number(20,6)      ,/* 本期下阶投入金额-制费一 */
xccd204e       number(20,6)      ,/* 本期下阶投入金额-制费二 */
xccd204f       number(20,6)      ,/* 本期下阶投入金额-制费三 */
xccd204g       number(20,6)      ,/* 本期下阶投入金额-制费四 */
xccd204h       number(20,6)      ,/* 本期下阶投入金额-制费五 */
xccd301       number(20,6)      ,/* 本期转出数量 */
xccd302       number(20,6)      ,/* 本期转出金额 */
xccd302a       number(20,6)      ,/* 本期转出金额-材料 */
xccd302b       number(20,6)      ,/* 本期转出金额-人工 */
xccd302c       number(20,6)      ,/* 本期转出金额-加工 */
xccd302d       number(20,6)      ,/* 本期转出金额-制费一 */
xccd302e       number(20,6)      ,/* 本期转出金额-制费二 */
xccd302f       number(20,6)      ,/* 本期转出金额-制费三 */
xccd302g       number(20,6)      ,/* 本期转出金额-制费四 */
xccd302h       number(20,6)      ,/* 本期转出金额-制费五 */
xccd303       number(20,6)      ,/* 差异转出数量 */
xccd304       number(20,6)      ,/* 差异转出金额 */
xccd304a       number(20,6)      ,/* 差异转出金额-材料 */
xccd304b       number(20,6)      ,/* 差异转出金额-人工 */
xccd304c       number(20,6)      ,/* 差异转出金额-加工 */
xccd304d       number(20,6)      ,/* 差异转出金额-制费一 */
xccd304e       number(20,6)      ,/* 差异转出金额-制费二 */
xccd304f       number(20,6)      ,/* 差异转出金额-制费三 */
xccd304g       number(20,6)      ,/* 差异转出金额-制费四 */
xccd304h       number(20,6)      ,/* 差异转出金额-制费五 */
xccd901       number(20,6)      ,/* 期末结存数量 */
xccd902       number(20,6)      ,/* 期末结存金额 */
xccd902a       number(20,6)      ,/* 期末结存金额-材料 */
xccd902b       number(20,6)      ,/* 期末结存金额-人工 */
xccd902c       number(20,6)      ,/* 期末结存金额-加工 */
xccd902d       number(20,6)      ,/* 期末结存金额-制费一 */
xccd902e       number(20,6)      ,/* 期末结存金额-制费二 */
xccd902f       number(20,6)      ,/* 期末结存金额-制费三 */
xccd902g       number(20,6)      ,/* 期末结存金额-制费四 */
xccd902h       number(20,6)      ,/* 期末结存金额-制费五 */
xccdtime       timestamp(0)      /* 最近成本计算时间 */
);
alter table xccd_t add constraint xccd_pk primary key (xccdent,xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006) enable validate;

create unique index xccd_pk on xccd_t (xccdent,xccdld,xccd001,xccd002,xccd003,xccd004,xccd005,xccd006);

grant select on xccd_t to tiptop;
grant update on xccd_t to tiptop;
grant delete on xccd_t to tiptop;
grant insert on xccd_t to tiptop;

exit;
