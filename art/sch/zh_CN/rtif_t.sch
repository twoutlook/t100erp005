/* 
================================================================================
檔案代號:rtif_t
檔案名稱:销售交易收款明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtif_t
(
rtifent       number(5)      ,/* 企业编号 */
rtifsite       varchar2(10)      ,/* 营运据点 */
rtifunit       varchar2(10)      ,/* 应用组织 */
rtifdocno       varchar2(20)      ,/* 单据编号 */
rtifseq       number(10,0)      ,/* 收款项次 */
rtifseq1       number(10,0)      ,/* 收款序 */
rtif001       varchar2(10)      ,/* 款别类型 */
rtif002       varchar2(10)      ,/* 款别编号 */
rtif003       number(20,6)      ,/* 收款金额 */
rtif004       varchar2(40)      ,/* 款别类型对应凭证号 */
rtif005       varchar2(40)      ,/* 刷卡机号 */
rtif006       number(20,6)      ,/* 刷卡手续费率 */
rtif007       number(20,6)      ,/* 刷卡手续金额 */
rtif008       number(20,6)      ,/* 支票面额 */
rtif009       date      ,/* 票据到期日 */
rtif010       varchar2(15)      ,/* 票据付款银行 */
rtif011       varchar2(1)      ,/* 开客票 */
rtif012       varchar2(255)      ,/* 发票人全名 */
rtif013       varchar2(10)      ,/* 卡/券种编号 */
rtif014       varchar2(30)      ,/* 会员卡号 */
rtif015       varchar2(10)      ,/* 券面额编号 */
rtif016       varchar2(30)      ,/* 起始券号 */
rtif017       varchar2(30)      ,/* 结束券号 */
rtif018       number(20,6)      ,/* 券数量 */
rtif019       varchar2(1)      ,/* 找零否 */
rtif020       number(20,6)      ,/* 票券溢收金额 */
rtif021       varchar2(10)      ,/* 冲预收款类型 */
rtif022       number(15,3)      ,/* 抵现积分 */
rtif023       number(20,6)      ,/* 固定手续费 */
rtif024       varchar2(10)      ,/* 退款类型 */
rtif025       date      ,/* 收款日期 */
rtif026       varchar2(8)      ,/* 收款时间 */
rtif027       varchar2(20)      ,/* 专柜/铺位编号 */
rtif028       varchar2(10)      ,/* 班别 */
rtif029       varchar2(10)      ,/* 收银机编号 */
rtif030       varchar2(20)      ,/* 收银员编号 */
rtif031       number(20,6)      ,/* 本币应收金额 */
rtif032       timestamp(0)      ,/* 自定义字段(日期时间)032 */
rtifud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rtifud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rtifud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rtifud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rtifud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rtifud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rtifud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rtifud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rtifud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rtifud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rtifud011       number(20,6)      ,/* 自定义字段(数字)011 */
rtifud012       number(20,6)      ,/* 自定义字段(数字)012 */
rtifud013       number(20,6)      ,/* 自定义字段(数字)013 */
rtifud014       number(20,6)      ,/* 自定义字段(数字)014 */
rtifud015       number(20,6)      ,/* 自定义字段(数字)015 */
rtifud016       number(20,6)      ,/* 自定义字段(数字)016 */
rtifud017       number(20,6)      ,/* 自定义字段(数字)017 */
rtifud018       number(20,6)      ,/* 自定义字段(数字)018 */
rtifud019       number(20,6)      ,/* 自定义字段(数字)019 */
rtifud020       number(20,6)      ,/* 自定义字段(数字)020 */
rtifud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rtifud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rtifud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rtifud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rtifud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rtifud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rtifud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rtifud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rtifud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rtifud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
rtif033       varchar2(40)      ,/* 银行存缴单号 */
rtif034       varchar2(10)      ,/* 交易对象 */
rtif035       varchar2(20)      ,/* 作业编号 */
rtif036       varchar2(40)      ,/* 第三方卡流水号 */
rtif037       varchar2(1)      ,/* 立账否 */
rtif038       number(20,6)      ,/* 找零转储金额 */
rtif101       varchar2(10)      ,/* 来源类型(租赁) */
rtif102       varchar2(20)      ,/* 来源单号(租赁) */
rtif103       varchar2(30)      ,/* 交款单号(租赁) */
rtif104       varchar2(10)      ,/* 交款状态(租赁) */
rtif105       varchar2(20)      ,/* 抛转底稿单号(租赁) */
rtif106       varchar2(20)      ,/* 审核人员 */
rtif107       timestamp(0)      ,/* 审核日期 */
rtif108       varchar2(1)      ,/* 收银交接否 */
rtif109       timestamp(0)      ,/* POS收款日期 */
rtif039       varchar2(40)      /* 找零转储GUID */
);
alter table rtif_t add constraint rtif_pk primary key (rtifent,rtifdocno,rtifseq,rtifseq1) enable validate;

create unique index rtif_pk on rtif_t (rtifent,rtifdocno,rtifseq,rtifseq1);

grant select on rtif_t to tiptop;
grant update on rtif_t to tiptop;
grant delete on rtif_t to tiptop;
grant insert on rtif_t to tiptop;

exit;
