/* 
================================================================================
檔案代號:xcha_t
檔案名稱:工艺工单在制作业成本期异动统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcha_t
(
xchaent       number(5)      ,/* 企业编号 */
xchacomp       varchar2(10)      ,/* 法人组织 */
xchald       varchar2(5)      ,/* 账套 */
xcha001       varchar2(1)      ,/* 账套本位币顺序 */
xcha002       varchar2(30)      ,/* 成本域 */
xcha003       varchar2(10)      ,/* 成本计算类型 */
xcha004       number(5,0)      ,/* 年度 */
xcha005       number(5,0)      ,/* 期别 */
xcha006       varchar2(20)      ,/* 工单编号 */
xcha007       varchar2(10)      ,/* 作业编号 */
xcha008       varchar2(10)      ,/* 作业序 */
xcha009       varchar2(40)      ,/* 主件料号 */
xcha010       varchar2(256)      ,/* 产品特征 */
xcha011       varchar2(30)      ,/* 批号 */
xcha012       varchar2(20)      ,/* 项目号 */
xcha013       varchar2(10)      ,/* 核算币种 */
xcha101       number(20,6)      ,/* 上期结存数量 */
xcha102       number(20,6)      ,/* 上期结存金额 */
xcha102a       number(20,6)      ,/* 上期结存金额-材料 */
xcha102b       number(20,6)      ,/* 上期结存金额-人工 */
xcha102c       number(20,6)      ,/* 上期结存金额-加工 */
xcha102d       number(20,6)      ,/* 上期结存金额-制费一 */
xcha102e       number(20,6)      ,/* 上期结存金额-制费二 */
xcha102f       number(20,6)      ,/* 上期结存金额-制费三 */
xcha102g       number(20,6)      ,/* 上期结存金额-制费四 */
xcha102h       number(20,6)      ,/* 上期结存金额-制费五 */
xcha201       number(20,6)      ,/* 本期投入数量 */
xcha202       number(20,6)      ,/* 本期投入金额 */
xcha202a       number(20,6)      ,/* 本期投入金额-材料 */
xcha202b       number(20,6)      ,/* 本期投入金额-人工 */
xcha202c       number(20,6)      ,/* 本期投入金额-加工 */
xcha202d       number(20,6)      ,/* 本期投入金额-制费一 */
xcha202e       number(20,6)      ,/* 本期投入金额-制费二 */
xcha202f       number(20,6)      ,/* 本期投入金额-制费三 */
xcha202g       number(20,6)      ,/* 本期投入金额-制费四 */
xcha202h       number(20,6)      ,/* 本期投入金额-制费五 */
xcha203       number(20,6)      ,/* 上站转入数量 */
xcha204       number(20,6)      ,/* 上站转入金额 */
xcha204a       number(20,6)      ,/* 上站转入金额-材料 */
xcha204b       number(20,6)      ,/* 上站转入金额-人工 */
xcha204c       number(20,6)      ,/* 上站转入金额-加工 */
xcha204d       number(20,6)      ,/* 上站转入金额-制费一 */
xcha204e       number(20,6)      ,/* 上站转入金额-制费二 */
xcha204f       number(20,6)      ,/* 上站转入金额-制费三 */
xcha204g       number(20,6)      ,/* 上站转入金额-制费四 */
xcha204h       number(20,6)      ,/* 上站转入金额-制费五 */
xcha301       number(20,6)      ,/* 良品转出数量 */
xcha302       number(20,6)      ,/* 良品转出金额 */
xcha302a       number(20,6)      ,/* 良品转出金额-材料 */
xcha302b       number(20,6)      ,/* 良品转出金额-人工 */
xcha302c       number(20,6)      ,/* 良品转出金额-加工 */
xcha302d       number(20,6)      ,/* 良品转出金额-制费一 */
xcha302e       number(20,6)      ,/* 良品转出金额-制费二 */
xcha302f       number(20,6)      ,/* 良品转出金额-制费三 */
xcha302g       number(20,6)      ,/* 良品转出金额-制费四 */
xcha302h       number(20,6)      ,/* 良品转出金额-制费五 */
xcha303       number(20,6)      ,/* 报废数量 */
xcha304       number(20,6)      ,/* 报废金额 */
xcha304a       number(20,6)      ,/* 报废金额-材料 */
xcha304b       number(20,6)      ,/* 报废金额-人工 */
xcha304c       number(20,6)      ,/* 报废金额-加工 */
xcha304d       number(20,6)      ,/* 报废金额-制费一 */
xcha304e       number(20,6)      ,/* 报废金额-制费二 */
xcha304f       number(20,6)      ,/* 报废金额-制费三 */
xcha304g       number(20,6)      ,/* 报废金额-制费四 */
xcha304h       number(20,6)      ,/* 报废金额-制费五 */
xcha305       number(20,6)      ,/* 当站下线数量 */
xcha306       number(20,6)      ,/* 当站下线金额 */
xcha306a       number(20,6)      ,/* 当站下线金额-材料 */
xcha306b       number(20,6)      ,/* 当站下线金额-人工 */
xcha306c       number(20,6)      ,/* 当站下线金额-加工 */
xcha306d       number(20,6)      ,/* 当站下线金额-制费一 */
xcha306e       number(20,6)      ,/* 当站下线金额-制费二 */
xcha306f       number(20,6)      ,/* 当站下线金额-制费三 */
xcha306g       number(20,6)      ,/* 当站下线金额-制费四 */
xcha306h       number(20,6)      ,/* 当站下线金额-制费五 */
xcha307       number(20,6)      ,/* 回收转出数量 */
xcha308       number(20,6)      ,/* 回收转出金额 */
xcha308a       number(20,6)      ,/* 回收转出金额-材料 */
xcha308b       number(20,6)      ,/* 回收转出金额-人工 */
xcha308c       number(20,6)      ,/* 回收转出金额-委外 */
xcha308d       number(20,6)      ,/* 回收转出金额-制费一 */
xcha308e       number(20,6)      ,/* 回收转出金额-制费二 */
xcha308f       number(20,6)      ,/* 回收转出金额-制费三 */
xcha308g       number(20,6)      ,/* 回收转出金额-制费四 */
xcha308h       number(20,6)      ,/* 回收转出金额-制费五 */
xcha309       number(20,6)      ,/* 差异转出数量 */
xcha310       number(20,6)      ,/* 差异转出金额 */
xcha310a       number(20,6)      ,/* 差异转出金额-材料 */
xcha310b       number(20,6)      ,/* 差异转出金额-人工 */
xcha310c       number(20,6)      ,/* 差异转出金额-加工 */
xcha310d       number(20,6)      ,/* 差异转出金额-制费一 */
xcha310e       number(20,6)      ,/* 差异转出金额-制费二 */
xcha310f       number(20,6)      ,/* 差异转出金额-制费三 */
xcha310g       number(20,6)      ,/* 差异转出金额-制费四 */
xcha310h       number(20,6)      ,/* 差异转出金额-制费五 */
xcha901       number(20,6)      ,/* 期末结存数量 */
xcha902       number(20,6)      ,/* 期末结存金额 */
xcha902a       number(20,6)      ,/* 期末结存金额-材料 */
xcha902b       number(20,6)      ,/* 期末结存金额-人工 */
xcha902c       number(20,6)      ,/* 期末结存金额-加工 */
xcha902d       number(20,6)      ,/* 期末结存金额-制费一 */
xcha902e       number(20,6)      ,/* 期末结存金额-制费二 */
xcha902f       number(20,6)      ,/* 期末结存金额-制费三 */
xcha902g       number(20,6)      ,/* 期末结存金额-制费四 */
xcha902h       number(20,6)      ,/* 期末结存金额-制费五 */
xchatime       timestamp(0)      /* 最近成本计算时间 */
);
alter table xcha_t add constraint xcha_pk primary key (xchaent,xchald,xcha001,xcha002,xcha003,xcha004,xcha005,xcha006,xcha007,xcha008) enable validate;

create unique index xcha_pk on xcha_t (xchaent,xchald,xcha001,xcha002,xcha003,xcha004,xcha005,xcha006,xcha007,xcha008);

grant select on xcha_t to tiptop;
grant update on xcha_t to tiptop;
grant delete on xcha_t to tiptop;
grant insert on xcha_t to tiptop;

exit;
