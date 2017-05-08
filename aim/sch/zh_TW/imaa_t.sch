/* 
================================================================================
檔案代號:imaa_t
檔案名稱:料件主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imaa_t
(
imaaent       number(5)      ,/* 企业编号 */
imaa001       varchar2(40)      ,/* 料号 */
imaa002       varchar2(10)      ,/* 当前版本 */
imaa003       varchar2(10)      ,/* 主分群码 */
imaa004       varchar2(10)      ,/* 料件类别 */
imaa005       varchar2(40)      ,/* 特征组别 */
imaa006       varchar2(10)      ,/* 基础单位 */
imaa009       varchar2(10)      ,/* 产品分类 */
imaa010       varchar2(10)      ,/* 生命周期状态 */
imaa011       varchar2(10)      ,/* 产出类型 */
imaa012       varchar2(1)      ,/* 允许副产品 */
imaa013       varchar2(40)      ,/* 目录编号 */
imaa014       varchar2(40)      ,/* 产品条码编号 */
imaa016       number(20,6)      ,/* 毛重 */
imaa017       number(20,6)      ,/* 净重 */
imaa018       varchar2(10)      ,/* 重量单位 */
imaa019       number(20,6)      ,/* 长度 */
imaa020       number(20,6)      ,/* 宽度 */
imaa021       number(20,6)      ,/* 高度 */
imaa022       varchar2(10)      ,/* 长度单位 */
imaa023       number(20,6)      ,/* 面积 */
imaa024       varchar2(10)      ,/* 面积单位 */
imaa025       number(20,6)      ,/* 体积 */
imaa026       varchar2(10)      ,/* 体积单位 */
imaa027       varchar2(1)      ,/* 为包装容器 */
imaa028       number(20,6)      ,/* 容量 */
imaa029       varchar2(10)      ,/* 容量单位 */
imaa030       number(20,6)      ,/* 超量容差(%) */
imaa031       number(20,6)      ,/* 载重量 */
imaa032       varchar2(10)      ,/* 载重单位 */
imaa033       number(20,6)      ,/* 超重容差(%) */
imaa034       varchar2(10)      ,/* 料号来源 */
imaa035       varchar2(40)      ,/* 来源参考料号 */
imaa036       varchar2(1)      ,/* 记录位置(插件) */
imaa037       varchar2(1)      ,/* 组装位置须勾稽 */
imaa038       varchar2(1)      ,/* 工程料件 */
imaa039       varchar2(40)      ,/* 转正式料号 */
imaa040       date      ,/* 转正式料号时间 */
imaa041       varchar2(255)      ,/* 工程图号 */
imaa042       varchar2(20)      ,/* 主要模具编号 */
imaa043       varchar2(10)      ,/* 据点研发可调整元件 */
imaa044       varchar2(10)      ,/* AVL控管点 */
imaa045       varchar2(10)      ,/* 生产国家地区 */
imaa100       varchar2(10)      ,/* 条码分类 */
imaa101       varchar2(10)      ,/* 主供应商 */
imaa102       number(5,0)      ,/* 保质期(月) */
imaa103       number(5,0)      ,/* 保质期(天) */
imaa104       varchar2(10)      ,/* 库存单位 */
imaa105       varchar2(10)      ,/* 销售单位 */
imaa106       varchar2(10)      ,/* 销售计价单位 */
imaa107       varchar2(10)      ,/* 采购单位 */
imaa108       varchar2(10)      ,/* 商品种类 */
imaa109       varchar2(10)      ,/* 条码类型 */
imaa110       varchar2(1)      ,/* 季节性商品 */
imaa111       date      ,/* 开始日期 */
imaa112       date      ,/* 结束日期 */
imaa113       number(5,0)      ,/* 传秤因子 */
imaa114       varchar2(10)      ,/* 计价币种 */
imaa115       number(20,6)      ,/* 预计进货价格 */
imaa116       number(20,6)      ,/* 预计销货价格 */
imaa117       number(20,6)      ,/* 进销差率 */
imaa118       number(5,0)      ,/* 试销期(天) */
imaa119       number(20,6)      ,/* 试销金额 */
imaa120       number(20,6)      ,/* 试销数量 */
imaa121       varchar2(1)      ,/* 是否网络经营 */
imaa122       varchar2(10)      ,/* 产地分类 */
imaa123       varchar2(80)      ,/* 产地说明 */
imaa124       varchar2(10)      ,/* 进销项税种 */
imaa125       varchar2(1)      ,/* 一次性商品 */
imaa126       varchar2(10)      ,/* 品牌 */
imaa127       varchar2(10)      ,/* 系列 */
imaa128       varchar2(10)      ,/* 类型 */
imaa129       varchar2(10)      ,/* 功能 */
imaa130       varchar2(80)      ,/* 主材 */
imaa131       varchar2(10)      ,/* 价格带 */
imaa132       varchar2(10)      ,/* 其他属性一 */
imaa133       varchar2(10)      ,/* 其他属性二 */
imaa134       varchar2(10)      ,/* 其他属性三 */
imaa135       varchar2(10)      ,/* 其他属性四 */
imaa136       varchar2(10)      ,/* 其他属性五 */
imaa137       varchar2(10)      ,/* 其他属性六 */
imaa138       varchar2(10)      ,/* 其他属性七 */
imaa139       varchar2(10)      ,/* 其他属性八 */
imaa140       varchar2(10)      ,/* 其他属性九 */
imaa141       varchar2(10)      ,/* 其他属性十 */
imaa142       varchar2(10)      ,/* 制定组织 */
imaa143       varchar2(10)      ,/* 产品组编号 */
imaa144       varchar2(1)      ,/* 库存多单位 */
imaa145       varchar2(10)      ,/* 采购计价单位 */
imaa146       varchar2(10)      ,/* 成本单位 */
imaastus       varchar2(10)      ,/* 状态码 */
imaaownid       varchar2(20)      ,/* 资料所有者 */
imaaowndp       varchar2(10)      ,/* 资料所有部门 */
imaacrtid       varchar2(20)      ,/* 资料录入者 */
imaacrtdp       varchar2(10)      ,/* 资料录入部门 */
imaacrtdt       timestamp(0)      ,/* 资料创建日 */
imaamodid       varchar2(20)      ,/* 资料更改者 */
imaamoddt       timestamp(0)      ,/* 最近更改日 */
imaacnfid       varchar2(20)      ,/* 资料审核者 */
imaacnfdt       timestamp(0)      ,/* 数据审核日 */
imaaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
imaaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
imaaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
imaaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
imaaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
imaaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
imaaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
imaaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
imaaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
imaaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
imaaud011       number(20,6)      ,/* 自定义字段(数字)011 */
imaaud012       number(20,6)      ,/* 自定义字段(数字)012 */
imaaud013       number(20,6)      ,/* 自定义字段(数字)013 */
imaaud014       number(20,6)      ,/* 自定义字段(数字)014 */
imaaud015       number(20,6)      ,/* 自定义字段(数字)015 */
imaaud016       number(20,6)      ,/* 自定义字段(数字)016 */
imaaud017       number(20,6)      ,/* 自定义字段(数字)017 */
imaaud018       number(20,6)      ,/* 自定义字段(数字)018 */
imaaud019       number(20,6)      ,/* 自定义字段(数字)019 */
imaaud020       number(20,6)      ,/* 自定义字段(数字)020 */
imaaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
imaaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
imaaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
imaaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
imaaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
imaaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
imaaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
imaaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
imaaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
imaaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
imaa147       number(20,6)      ,/* 默认商品临期比例 */
imaa148       number(5,0)      ,/* 商品临期天数 */
imaa149       varchar2(10)      ,/* 临期控管方式 */
imaa150       varchar2(80)      ,/* 辅材 */
imaa151       varchar2(80)      ,/* 等级 */
imaa152       varchar2(80)      ,/* 颜色 */
imaa153       varchar2(80)      ,/* 型号 */
imaa154       number(5,0)      ,/* 年份 */
imaa155       varchar2(10)      ,/* 订货季 */
imaa156       varchar2(10)      ,/* 性别 */
imaa157       number(20,6)      ,/* 标牌价 */
imaa158       date      ,/* 上市日 */
imaa159       number(20,6)      ,/* 每m²克重 */
imaa160       number(20,6)      ,/* 面料幅宽 */
imaa161       varchar2(10)      /* 触屏分类编号 */
);
alter table imaa_t add constraint imaa_pk primary key (imaaent,imaa001) enable validate;

create  index imaa_n on imaa_t (imaaent,imaa001,imaa108);
create unique index imaa_pk on imaa_t (imaaent,imaa001);

grant select on imaa_t to tiptop;
grant update on imaa_t to tiptop;
grant delete on imaa_t to tiptop;
grant insert on imaa_t to tiptop;

exit;
