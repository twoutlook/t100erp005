/* 
================================================================================
檔案代號:stbd_t
檔案名稱:结算单数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stbd_t
(
stbdent       number(5)      ,/* 企业编号 */
stbdunit       varchar2(10)      ,/* 应用组织 */
stbdsite       varchar2(10)      ,/* 营运据点 */
stbddocno       varchar2(20)      ,/* 单据编号 */
stbddocdt       date      ,/* 单据日期 */
stbd001       varchar2(20)      ,/* 合同编号 */
stbd002       varchar2(10)      ,/* 供应商编号 */
stbd003       varchar2(10)      ,/* 经营方式 */
stbd004       number(5,0)      ,/* 结算账期 */
stbd005       date      ,/* 起始日期 */
stbd006       date      ,/* 截止日期 */
stbd007       number(20,6)      ,/* 上期结存金额 */
stbd008       number(20,6)      ,/* 本期销货成本 */
stbd009       number(20,6)      ,/* 本期进货金额 */
stbd010       number(20,6)      ,/* 本期退货金额 */
stbd011       number(20,6)      ,/* 本期折让金额 */
stbd012       number(20,6)      ,/* 税额 */
stbd013       number(20,6)      ,/* 价税合计 */
stbd014       number(20,6)      ,/* 本期预付金额 */
stbd015       number(20,6)      ,/* 本期价外扣款 */
stbd016       varchar2(1)      ,/* 货款扣费用否 */
stbd017       number(20,6)      ,/* 应结算金额 */
stbd018       number(20,6)      ,/* 实际计算金额 */
stbd019       number(20,6)      ,/* 本期结存金额 */
stbd020       varchar2(10)      ,/* 结算标识 */
stbd021       varchar2(20)      ,/* 人员 */
stbd022       varchar2(10)      ,/* 部门 */
stbd023       varchar2(20)      ,/* 结算地点 */
stbd024       varchar2(20)      ,/* 纳税编号 */
stbd025       varchar2(15)      ,/* 银行编号 */
stbd026       varchar2(30)      ,/* 银行帐号 */
stbd027       date      ,/* 发票日期 */
stbd028       varchar2(20)      ,/* 发票号码 */
stbd029       date      ,/* 付款日期 */
stbd030       varchar2(20)      ,/* 发票人 */
stbd031       date      ,/* 生效日期 */
stbd032       date      ,/* 失效日期 */
stbd033       varchar2(255)      ,/* 备注 */
stbdstus       varchar2(10)      ,/* 状态码 */
stbdownid       varchar2(20)      ,/* 资料所有者 */
stbdowndp       varchar2(10)      ,/* 资料所有部门 */
stbdcrtid       varchar2(20)      ,/* 资料录入者 */
stbdcrtdp       varchar2(10)      ,/* 资料录入部门 */
stbdcrtdt       timestamp(0)      ,/* 资料创建日 */
stbdmodid       varchar2(20)      ,/* 资料更改者 */
stbdmoddt       timestamp(0)      ,/* 最近更改日 */
stbdcnfid       varchar2(20)      ,/* 资料审核者 */
stbdcnfdt       timestamp(0)      ,/* 数据审核日 */
stbdud001       varchar2(40)      ,/* 含发票否 */
stbdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stbdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stbdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stbdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stbdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stbdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stbdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stbdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stbdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stbdud011       number(20,6)      ,/* 自定义字段(数字)011 */
stbdud012       number(20,6)      ,/* 自定义字段(数字)012 */
stbdud013       number(20,6)      ,/* 自定义字段(数字)013 */
stbdud014       number(20,6)      ,/* 自定义字段(数字)014 */
stbdud015       number(20,6)      ,/* 自定义字段(数字)015 */
stbdud016       number(20,6)      ,/* 自定义字段(数字)016 */
stbdud017       number(20,6)      ,/* 自定义字段(数字)017 */
stbdud018       number(20,6)      ,/* 自定义字段(数字)018 */
stbdud019       number(20,6)      ,/* 自定义字段(数字)019 */
stbdud020       number(20,6)      ,/* 自定义字段(数字)020 */
stbdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stbdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stbdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stbdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stbdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stbdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stbdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stbdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stbdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stbdud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stbd034       number(20,6)      ,/* 主账套账款金额 */
stbd035       number(20,6)      ,/* 次账套一账款金额 */
stbd036       number(20,6)      ,/* 次账套二账款金额 */
stbd000       varchar2(1)      ,/* 结算单类型 */
stbd037       varchar2(20)      ,/* 专柜编号 */
stbd038       date      ,/* 预估应付日 */
stbd039       varchar2(1)      ,/* 数据类型 */
stbd040       number(20,6)      ,/* 本期销售金额 */
stbd041       varchar2(10)      ,/* 合同状态 */
stbd042       varchar2(1)      ,/* 含发票否 */
stbd043       number(5,0)      ,/* 财务会计年度 */
stbd044       number(5,0)      ,/* 财务会计期别 */
stbd045       number(20,6)      ,/* 本期开票金额 */
stbd046       varchar2(10)      ,/* 付款供应商 */
stbd047       varchar2(40)      ,/* 文件编号 */
stbd048       varchar2(10)      ,/* 结算法人 */
stbd049       varchar2(10)      ,/* 管理品类 */
stbd050       varchar2(10)      ,/* 品牌 */
stbd051       number(20,6)      ,/* 上期结存费用 */
stbd052       number(20,6)      ,/* 实际结算结存货款 */
stbd053       number(20,6)      ,/* 实际结算结存费用 */
stbd054       number(20,6)      ,/* 实际结算销货成本 */
stbd055       number(20,6)      ,/* 实际结算收货金额 */
stbd056       number(20,6)      ,/* 实际结算退货金额 */
stbd057       number(20,6)      ,/* 实际结算费用金额 */
stbd058       number(20,6)      ,/* 实际结算税额合计 */
stbd059       number(20,6)      ,/* 实际结算总金额 */
stbd060       number(5)      /* 打印次数 */
);
alter table stbd_t add constraint stbd_pk primary key (stbdent,stbddocno) enable validate;

create unique index stbd_pk on stbd_t (stbdent,stbddocno);

grant select on stbd_t to tiptop;
grant update on stbd_t to tiptop;
grant delete on stbd_t to tiptop;
grant insert on stbd_t to tiptop;

exit;
