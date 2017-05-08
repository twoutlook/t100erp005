/* 
================================================================================
檔案代號:xcfg_t
檔案名稱:LCM存货成本和市价期数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcfg_t
(
xcfgent       number(5)      ,/* 企业编号 */
xcfgcomp       varchar2(10)      ,/* 法人组织 */
xcfgld       varchar2(5)      ,/* 账套 */
xcfg001       varchar2(1)      ,/* 账套本位币顺序 */
xcfg002       varchar2(30)      ,/* 成本域 */
xcfg003       varchar2(10)      ,/* 成本计算类型 */
xcfg004       number(5,0)      ,/* 年度 */
xcfg005       number(5,0)      ,/* 期别 */
xcfg006       varchar2(40)      ,/* 料件 */
xcfg007       varchar2(256)      ,/* 特性 */
xcfg008       varchar2(30)      ,/* 批号 */
xcfg010       varchar2(1)      ,/* 存货类别 */
xcfg011       varchar2(10)      ,/* 材料分类 */
xcfg012       varchar2(10)      ,/* 单位 */
xcfg013       varchar2(10)      ,/* 币种 */
xcfg014       number(20,6)      ,/* 库存数量 */
xcfg015       number(20,6)      ,/* 进货单价 */
xcfg016       number(20,6)      ,/* 销售单价 */
xcfg017       number(20,6)      ,/* 单位成本 */
xcfg018       number(20,6)      ,/* No Use */
xcfg019       number(20,6)      ,/* 净变现单价 */
xcfg020       number(20,6)      ,/* 净变现市价 */
xcfg021       varchar2(10)      ,/* 净变现逆推顺序 */
xcfg022       varchar2(10)      ,/* 净变现销售费用率类别 */
xcfg023       number(20,6)      ,/* 净变现销售费用率 */
xcfg024       varchar2(1)      ,/* 逆推成品平均QPA */
xcfg025       varchar2(40)      ,/* 净变现逆推成品料号 */
xcfg026       number(20,6)      ,/* 净变现逆推成品平均单位成本 */
xcfg027       number(20,6)      ,/* 净变现逆推成品平均净变现单价 */
xcfg028       varchar2(20)      ,/* 净变现逆推参考单号 */
xcfg029       number(10,0)      ,/* 净变现逆推参考项次 */
xcfg030       date      /* 净变现逆推单据日期 */
);
alter table xcfg_t add constraint xcfg_pk primary key (xcfgent,xcfgld,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008) enable validate;

create unique index xcfg_pk on xcfg_t (xcfgent,xcfgld,xcfg001,xcfg002,xcfg003,xcfg004,xcfg005,xcfg006,xcfg007,xcfg008);

grant select on xcfg_t to tiptop;
grant update on xcfg_t to tiptop;
grant delete on xcfg_t to tiptop;
grant insert on xcfg_t to tiptop;

exit;
