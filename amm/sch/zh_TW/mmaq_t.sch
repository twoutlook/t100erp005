/* 
================================================================================
檔案代號:mmaq_t
檔案名稱:会员卡数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table mmaq_t
(
mmaqent       number(5)      ,/* 企业编号 */
mmaq001       varchar2(30)      ,/* 会员卡号 */
mmaq002       varchar2(10)      ,/* 卡种编号 */
mmaq003       varchar2(30)      ,/* 会员编号 */
mmaq004       varchar2(40)      ,/* 会员卡口令 */
mmaq005       date      ,/* 会员卡有效期 */
mmaq006       varchar2(1)      ,/* 会员卡状态 */
mmaq007       varchar2(1)      ,/* 会员卡可储值 */
mmaq008       number(5,0)      ,/* 会员卡储值折扣 */
mmaq009       number(20,6)      ,/* 会员卡储值余额 */
mmaq010       number(20,6)      ,/* 累计储值折扣金额 */
mmaq011       number(20,6)      ,/* 累计加值金额 */
mmaq012       number(20,6)      ,/* 累计送抵现值金额 */
mmaq013       date      ,/* 最后消费日 */
mmaq014       number(5,0)      ,/* 累计消费次数 */
mmaq015       number(20,6)      ,/* 累计消费额 */
mmaq016       number(15,3)      ,/* 累计积分 */
mmaq017       number(15,3)      ,/* 已兑换积分 */
mmaq018       number(15,3)      ,/* 剩余积分 */
mmaq019       date      ,/* 最后积分清零日 */
mmaq020       varchar2(10)      ,/* 发行组织 */
mmaq021       date      ,/* 发行日期 */
mmaq022       varchar2(10)      ,/* 发卡组织 */
mmaq023       date      ,/* 发卡日期 */
mmaq024       varchar2(10)      ,/* 开卡组织 */
mmaq025       date      ,/* 开卡日期 */
mmaq026       varchar2(10)      ,/* 作废组织 */
mmaq027       date      ,/* 作废日期 */
mmaq028       varchar2(10)      ,/* 注销组织 */
mmaq029       date      ,/* 注销日期 */
mmaq030       varchar2(10)      ,/* 挂失组织 */
mmaq031       date      ,/* 挂失日期 */
mmaq032       number(20,6)      ,/* 累计储值成本 */
mmaq033       varchar2(10)      ,/* 发行异动组织 */
mmaq034       varchar2(10)      ,/* 发卡异动组织 */
mmaq035       varchar2(10)      ,/* 开卡异动组织 */
mmaq036       varchar2(10)      ,/* 作废异动组织 */
mmaq037       varchar2(10)      ,/* 注销异动组织 */
mmaq038       varchar2(10)      ,/* 挂失异动组织 */
mmaq040       date      ,/* 期初最后消费日期 */
mmaq041       number(15,3)      ,/* 期初累计消费次数 */
mmaq042       number(20,6)      ,/* 期初累计消费金额 */
mmaq100       varchar2(40)      ,/* GUID */
mmaq043       varchar2(10)      ,/* 卡发行方式 */
mmaq044       date      ,/* 生效日期 */
mmaq045       number(15,3)      ,/* 本期会员晋级积分 */
mmaq046       number(15,3)      ,/* 累计会员晋级积分 */
mmaq047       number(20,6)      ,/* 本期会员晋级消费额 */
mmaq048       number(20,6)      ,/* 累计会员晋级消费额 */
mmaq049       number(15,3)      ,/* 本期会员晋级消费次数 */
mmaq050       number(15,3)      ,/* 累计会员晋级消费次数 */
mmaq051       date      ,/* 本期晋级数据重计日期 */
mmaq052       varchar2(20)      ,/* 会员等级变更单号 */
mmaq053       date      ,/* 上次会员有效期 */
mmaq054       varchar2(10)      ,/* 最后消费门店 */
mmaq055       number(20,6)      ,/* 最后消费金额 */
mmaq056       varchar2(10)      /* 最后消费区域 */
);
alter table mmaq_t add constraint mmaq_pk primary key (mmaqent,mmaq001) enable validate;

create unique index mmaq_pk on mmaq_t (mmaqent,mmaq001);

grant select on mmaq_t to tiptop;
grant update on mmaq_t to tiptop;
grant delete on mmaq_t to tiptop;
grant insert on mmaq_t to tiptop;

exit;
