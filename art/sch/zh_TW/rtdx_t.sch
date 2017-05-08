/* 
================================================================================
檔案代號:rtdx_t
檔案名稱:门店商品清单
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdx_t
(
rtdxent       number(5)      ,/* 企业编号 */
rtdxunit       varchar2(10)      ,/* 应用组织 */
rtdxsite       varchar2(10)      ,/* 营运据点 */
rtdx001       varchar2(40)      ,/* 商品编号 */
rtdx002       varchar2(40)      ,/* 商品主条码 */
rtdx003       varchar2(10)      ,/* 经营方式 */
rtdx004       varchar2(10)      ,/* 包装单位 */
rtdx005       number(20,6)      ,/* 整包装数 */
rtdx006       varchar2(10)      ,/* 生命周期 */
rtdx007       date      ,/* 生命周期更新日期 */
rtdx008       varchar2(10)      ,/* 重要程度 */
rtdx009       varchar2(10)      ,/* 敏感度 */
rtdx010       date      ,/* 停购日期 */
rtdx011       date      ,/* 停销日期 */
rtdx012       varchar2(80)      ,/* 产地 */
rtdx013       number(20,6)      ,/* 原价销售记录 */
rtdx014       varchar2(10)      ,/* 销项税目 */
rtdx015       number(5,2)      ,/* No use */
rtdx016       number(20,6)      ,/* 售价 */
rtdx017       number(20,6)      ,/* 门店会员价1 */
rtdx018       number(20,6)      ,/* 门店会员价2 */
rtdx019       number(20,6)      ,/* 门店会员价3 */
rtdx020       number(20,6)      ,/* 促销原价 */
rtdx021       number(20,6)      ,/* 促销售价 */
rtdx022       date      ,/* 促销售价开始日期 */
rtdx023       date      ,/* 促销售价结束日期 */
rtdx024       varchar2(1)      ,/* 可调价 */
rtdx025       varchar2(1)      ,/* 可售 */
rtdx026       varchar2(1)      ,/* 可退 */
rtdx027       varchar2(10)      ,/* 采购方式 */
rtdx028       varchar2(10)      ,/* 采购中心 */
rtdx029       varchar2(10)      ,/* 配送中心 */
rtdx030       varchar2(10)      ,/* No use */
rtdx031       varchar2(10)      ,/* No use */
rtdx032       number(20,6)      ,/* 促销进价 */
rtdx033       varchar2(10)      ,/* No use */
rtdxstus       varchar2(10)      ,/* 状态码 */
rtdxownid       varchar2(20)      ,/* 资料所有者 */
rtdxowndp       varchar2(10)      ,/* 资料所有部门 */
rtdxcrtid       varchar2(20)      ,/* 资料录入者 */
rtdxcrtdp       varchar2(10)      ,/* 资料录入部门 */
rtdxcrtdt       timestamp(0)      ,/* 资料创建日 */
rtdxmodid       varchar2(20)      ,/* 资料更改者 */
rtdxmoddt       timestamp(0)      ,/* 最近更改日 */
rtdx034       number(20,6)      ,/* 最新进价 */
rtdx035       varchar2(10)      ,/* 进项税目 */
rtdx036       varchar2(8)      ,/* No use */
rtdx037       varchar2(8)      ,/* No use */
rtdx038       number(20,6)      ,/* 促销会员价1 */
rtdx039       number(20,6)      ,/* 促销会员价2 */
rtdx040       number(20,6)      ,/* 促销会员价3 */
rtdx041       date      ,/* 促销进价开始日期 */
rtdx042       date      ,/* 促销进价结束日期 */
rtdx043       varchar2(10)      ,/* 引进异动版本 */
rtdxud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtdxud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtdxud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtdxud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtdxud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtdxud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtdxud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtdxud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtdxud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtdxud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtdxud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtdxud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtdxud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtdxud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtdxud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtdxud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtdxud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtdxud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtdxud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtdxud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtdxud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtdxud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtdxud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtdxud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtdxud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtdxud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtdxud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtdxud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtdxud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtdxud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtdx044       varchar2(10)      ,/* 库位编号 */
rtdx045       number(20,6)      ,/* 结算扣率 */
rtdx046       varchar2(1)      ,/* 手工折价否 */
rtdx047       date      ,/* 会员促销开始日 */
rtdx048       date      ,/* 会员促销结束日 */
rtdx049       varchar2(8)      ,/* 会员促销开始时间 */
rtdx050       varchar2(8)      ,/* 会员促销结束时间 */
rtdx051       number(20,6)      ,/* 最近入库进价 */
rtdx000       varchar2(10)      ,/* 门店商品类型 */
rtdx052       number(20,6)      ,/* 执行进价 */
rtdx053       number(20,6)      ,/* 执行售价 */
rtdx054       number(20,6)      ,/* 执行会员价 */
rtdx101       number(22,2)      ,/* 单位兑换积分 */
rtdx102       number(22,2)      ,/* 促销单位兑换积分 */
rtdx103       number(22,2)      ,/* 促销原单位兑换积分 */
rtdx055       varchar2(20)      ,/* 铺位编号 */
rtdx056       varchar2(80)      ,/* 主材 */
rtdx057       varchar2(80)      ,/* 辅材 */
rtdx058       varchar2(80)      ,/* 等级 */
rtdx059       varchar2(80)      ,/* 颜色 */
rtdx060       varchar2(80)      /* 型号 */
);
alter table rtdx_t add constraint rtdx_pk primary key (rtdxent,rtdxsite,rtdx001) enable validate;

create unique index rtdx_pk on rtdx_t (rtdxent,rtdxsite,rtdx001);

grant select on rtdx_t to tiptop;
grant update on rtdx_t to tiptop;
grant delete on rtdx_t to tiptop;
grant insert on rtdx_t to tiptop;

exit;
