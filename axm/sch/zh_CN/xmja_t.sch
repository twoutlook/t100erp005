/* 
================================================================================
檔案代號:xmja_t
檔案名稱:分销订单商品明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table xmja_t
(
xmjaent       number(5)      ,/* 企业编号 */
xmjasite       varchar2(10)      ,/* 营运据点 */
xmjaunit       varchar2(10)      ,/* 应用组织 */
xmjadocno       varchar2(20)      ,/* 单据编号 */
xmjaseq       number(10,0)      ,/* 项次 */
xmja001       varchar2(10)      ,/* 交易类型 */
xmja002       varchar2(40)      ,/* 商品条码 */
xmja003       varchar2(40)      ,/* 商品编号 */
xmja004       varchar2(256)      ,/* 产品特征 */
xmja005       varchar2(30)      ,/* 促销方案 */
xmja006       varchar2(10)      ,/* 税种编号 */
xmja007       number(5,2)      ,/* 税率 */
xmja008       number(20,6)      ,/* 标准售价 */
xmja009       number(20,6)      ,/* 促销价 */
xmja010       number(20,6)      ,/* 交易价 */
xmja011       varchar2(10)      ,/* 包装单位 */
xmja012       number(20,6)      ,/* 包装数量 */
xmja013       varchar2(10)      ,/* 销售单位 */
xmja014       number(20,6)      ,/* 销售数量 */
xmja015       varchar2(10)      ,/* 参考单位 */
xmja016       number(20,6)      ,/* 参考数量 */
xmja017       varchar2(10)      ,/* 计价单位 */
xmja018       number(20,6)      ,/* 计价数量 */
xmja019       number(20,6)      ,/* 税前金额 */
xmja020       number(20,6)      ,/* 税额 */
xmja021       number(20,6)      ,/* 含税金额 */
xmja022       number(20,6)      ,/* 折价金额 */
xmja024       varchar2(10)      ,/* 收货网点 */
xmja025       varchar2(10)      ,/* 送货客户 */
xmja026       varchar2(10)      ,/* 送货地址码 */
xmja027       varchar2(10)      ,/* 送货站点 */
xmja028       varchar2(20)      ,/* 主合同编号 */
xmja029       varchar2(20)      ,/* 协议编号 */
xmja030       varchar2(1)      ,/* 多交期 */
xmja031       date      ,/* 约定交货日 */
xmja032       date      ,/* 约定签收日 */
xmja033       varchar2(40)      ,/* 客户料号 */
xmja034       varchar2(255)      ,/* 备注 */
xmja035       varchar2(20)      ,/* 来源促销分配单号 */
xmja036       number(10,0)      ,/* 来源促销分配项次 */
xmja037       varchar2(10)      ,/* 地区编号 */
xmja038       varchar2(10)      ,/* 县市编号 */
xmja039       varchar2(10)      ,/* 省区编号 */
xmja040       varchar2(10)      ,/* 区域编号 */
xmjaud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
xmjaud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
xmjaud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
xmjaud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
xmjaud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
xmjaud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
xmjaud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
xmjaud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
xmjaud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
xmjaud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
xmjaud011       number(20,6)      ,/* 自定义栏位(数字)011 */
xmjaud012       number(20,6)      ,/* 自定义栏位(数字)012 */
xmjaud013       number(20,6)      ,/* 自定义栏位(数字)013 */
xmjaud014       number(20,6)      ,/* 自定义栏位(数字)014 */
xmjaud015       number(20,6)      ,/* 自定义栏位(数字)015 */
xmjaud016       number(20,6)      ,/* 自定义栏位(数字)016 */
xmjaud017       number(20,6)      ,/* 自定义栏位(数字)017 */
xmjaud018       number(20,6)      ,/* 自定义栏位(数字)018 */
xmjaud019       number(20,6)      ,/* 自定义栏位(数字)019 */
xmjaud020       number(20,6)      ,/* 自定义栏位(数字)020 */
xmjaud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
xmjaud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
xmjaud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
xmjaud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
xmjaud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
xmjaud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
xmjaud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
xmjaud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
xmjaud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
xmjaud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table xmja_t add constraint xmja_pk primary key (xmjaent,xmjadocno,xmjaseq) enable validate;

create unique index xmja_pk on xmja_t (xmjaent,xmjadocno,xmjaseq);

grant select on xmja_t to tiptop;
grant update on xmja_t to tiptop;
grant delete on xmja_t to tiptop;
grant insert on xmja_t to tiptop;

exit;
