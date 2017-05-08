/* 
================================================================================
檔案代號:fmmy_t
檔案名稱:平仓出售档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmy_t
(
fmmyent       number(5)      ,/* 企业编号 */
fmmyownid       varchar2(20)      ,/* 资料所有者 */
fmmyowndp       varchar2(10)      ,/* 资料所有部门 */
fmmycrtid       varchar2(20)      ,/* 资料录入者 */
fmmycrtdp       varchar2(10)      ,/* 资料录入部门 */
fmmycrtdt       timestamp(0)      ,/* 资料创建日 */
fmmymodid       varchar2(20)      ,/* 资料更改者 */
fmmymoddt       timestamp(0)      ,/* 最近更改日 */
fmmycnfid       varchar2(20)      ,/* 资料审核者 */
fmmycnfdt       timestamp(0)      ,/* 数据审核日 */
fmmypstid       varchar2(20)      ,/* 资料过账者 */
fmmypstdt       timestamp(0)      ,/* 资料过账日 */
fmmystus       varchar2(10)      ,/* 状态码 */
fmmydocno       varchar2(20)      ,/* 单号 */
fmmydocdt       date      ,/* 单据日期 */
fmmysite       varchar2(10)      ,/* 营运据点 */
fmmy001       varchar2(20)      ,/* 投资购买单号 */
fmmy002       varchar2(10)      ,/* 交易币种 */
fmmy003       number(20,6)      ,/* 平仓出售数量 */
fmmy004       number(20,6)      ,/* 单价 */
fmmy005       number(20,6)      ,/* 平仓收入原币 */
fmmy006       number(20,6)      ,/* 最后一期利息 */
fmmy007       number(20,10)      ,/* 平仓汇率 */
fmmy008       varchar2(1)      ,/* 收款方式 */
fmmy009       varchar2(15)      ,/* 收款银行 */
fmmy010       varchar2(30)      ,/* 收款账户 */
fmmyud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fmmyud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fmmyud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fmmyud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fmmyud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fmmyud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fmmyud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fmmyud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fmmyud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fmmyud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fmmyud011       number(20,6)      ,/* 自定义字段(数字)011 */
fmmyud012       number(20,6)      ,/* 自定义字段(数字)012 */
fmmyud013       number(20,6)      ,/* 自定义字段(数字)013 */
fmmyud014       number(20,6)      ,/* 自定义字段(数字)014 */
fmmyud015       number(20,6)      ,/* 自定义字段(数字)015 */
fmmyud016       number(20,6)      ,/* 自定义字段(数字)016 */
fmmyud017       number(20,6)      ,/* 自定义字段(数字)017 */
fmmyud018       number(20,6)      ,/* 自定义字段(数字)018 */
fmmyud019       number(20,6)      ,/* 自定义字段(数字)019 */
fmmyud020       number(20,6)      ,/* 自定义字段(数字)020 */
fmmyud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fmmyud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fmmyud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fmmyud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fmmyud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fmmyud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fmmyud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fmmyud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fmmyud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fmmyud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
fmmy011       varchar2(10)      ,/* 现金变动码 */
fmmy012       varchar2(10)      ,/* 存提码 */
fmmy013       number(20,6)      ,/* 平仓收入本币 */
fmmy014       number(20,6)      ,/* 最后一期利息收入本币 */
fmmy015       number(20,6)      ,/* 出售成本原币 */
fmmy016       number(20,6)      ,/* 出售成本本币 */
fmmy017       number(20,6)      ,/* 平仓收益原币 */
fmmy018       number(20,6)      ,/* 平仓收益本币 */
fmmy019       number(20,10)      ,/* 利息汇率 */
fmmy020       number(20,6)      ,/* 平仓本金汇差 */
fmmy021       number(20,6)      ,/* 已计利息原币 */
fmmy022       number(20,6)      ,/* 已计利息本币 */
fmmy023       number(20,6)      ,/* 利息汇差 */
fmmy024       number(20,6)      ,/* 已宣告未发放股利原币 */
fmmy025       number(20,6)      ,/* 已宣告未发放利息原币 */
fmmy026       number(20,6)      ,/* 已宣告未发放股利本币 */
fmmy027       number(20,6)      ,/* 已宣告未发放利息本币 */
fmmy028       number(20,6)      ,/* 银存利息收入原币 */
fmmy029       number(20,6)      /* 银存利息收入本币 */
);
alter table fmmy_t add constraint fmmy_pk primary key (fmmyent,fmmydocno) enable validate;

create unique index fmmy_pk on fmmy_t (fmmyent,fmmydocno);

grant select on fmmy_t to tiptop;
grant update on fmmy_t to tiptop;
grant delete on fmmy_t to tiptop;
grant insert on fmmy_t to tiptop;

exit;
