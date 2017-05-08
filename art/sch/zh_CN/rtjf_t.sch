/* 
================================================================================
檔案代號:rtjf_t
檔案名稱:销售集成收款明细
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table rtjf_t
(
rtjfent       number(5)      ,/* 企业编号 */
rtjfsite       varchar2(10)      ,/* 营运据点 */
rtjfunit       varchar2(10)      ,/* 应用组织 */
rtjfdocno       varchar2(20)      ,/* 单据编号 */
rtjfseq       number(10,0)      ,/* 收款项次 */
rtjfseq1       number(10,0)      ,/* 收款序 */
rtjf001       varchar2(10)      ,/* 款别类型 */
rtjf002       varchar2(10)      ,/* 款别编号 */
rtjf003       number(20,6)      ,/* 收款金额 */
rtjf004       varchar2(40)      ,/* 款别类型对应凭证号 */
rtjf005       varchar2(40)      ,/* 刷卡机号 */
rtjf006       number(20,6)      ,/* 刷卡手续费率 */
rtjf007       number(20,6)      ,/* 刷卡手续金额 */
rtjf008       number(20,6)      ,/* 支票面额 */
rtjf009       date      ,/* 票据到期日 */
rtjf010       varchar2(15)      ,/* 票据付款银行 */
rtjf011       varchar2(1)      ,/* 开客票 */
rtjf012       varchar2(255)      ,/* 发票人全名 */
rtjf013       varchar2(10)      ,/* 卡/券种编号 */
rtjf014       varchar2(30)      ,/* 会员卡号 */
rtjf015       varchar2(10)      ,/* 券面额编号 */
rtjf016       varchar2(30)      ,/* 起始券号 */
rtjf017       varchar2(30)      ,/* 结束券号 */
rtjf018       number(20,6)      ,/* 券数量 */
rtjf019       varchar2(1)      ,/* 找零否 */
rtjf020       number(20,6)      ,/* 票券溢收金额 */
rtjf021       varchar2(10)      ,/* 冲预收款类型 */
rtjf022       number(15,3)      ,/* 抵现积分 */
rtjf023       number(20,6)      ,/* 固定手续费 */
rtjf024       varchar2(10)      ,/* 退款类型 */
rtjf025       date      ,/* 收款日期 */
rtjf026       varchar2(8)      ,/* 收款时间 */
rtjf027       varchar2(20)      ,/* 专柜/铺位编号 */
rtjf028       varchar2(10)      ,/* 班别 */
rtjf029       varchar2(10)      ,/* 收银机编号 */
rtjf030       varchar2(20)      ,/* 收银员编号 */
rtjf031       number(20,6)      ,/* 本币收款金额 */
rtjf032       timestamp(0)      ,/* 自定义字段(日期时间)032 */
rtjfud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtjfud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtjfud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtjfud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtjfud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtjfud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtjfud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtjfud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtjfud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtjfud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtjfud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtjfud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtjfud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtjfud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtjfud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtjfud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtjfud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtjfud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtjfud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtjfud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtjfud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtjfud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtjfud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtjfud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtjfud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtjfud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtjfud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtjfud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtjfud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtjfud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtjf033       varchar2(40)      ,/* 银行存缴单号 */
rtjf034       varchar2(10)      ,/* 交易对象 */
rtjf035       varchar2(20)      ,/* 作业编号 */
rtjf036       varchar2(40)      ,/* 第三方卡流水号 */
rtjf037       varchar2(1)      ,/* 立账否 */
rtjf038       number(20,6)      ,/* 找零转储金额 */
rtjf101       varchar2(10)      ,/* 来源类型(租赁) */
rtjf102       varchar2(20)      ,/* 来源单号(租赁) */
rtjf103       varchar2(30)      ,/* 交款单号(租赁) */
rtjf104       varchar2(10)      ,/* 交款状态(租赁) */
rtjf105       varchar2(20)      ,/* 抛转底稿单号(租赁) */
rtjf106       varchar2(20)      ,/* 审核人员 */
rtjf107       timestamp(0)      ,/* 审核日期 */
rtjf108       varchar2(1)      ,/* 收银交接否 */
rtjf109       timestamp(0)      ,/* POS收款日期 */
rtjf039       varchar2(40)      /* 找零转储GUID */
);
alter table rtjf_t add constraint rtjf_pk primary key (rtjfent,rtjfdocno,rtjfseq,rtjfseq1) enable validate;

create  index rtjf_n01 on rtjf_t (rtjfent,rtjfsite,rtjf001,rtjf025);
create unique index rtjf_pk on rtjf_t (rtjfent,rtjfdocno,rtjfseq,rtjfseq1);

grant select on rtjf_t to tiptop;
grant update on rtjf_t to tiptop;
grant delete on rtjf_t to tiptop;
grant insert on rtjf_t to tiptop;

exit;
