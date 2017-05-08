/* 
================================================================================
檔案代號:stem_t
檔案名稱:合同费用优惠审批单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stem_t
(
stement       number(5)      ,/* 企业编号 */
stemunit       varchar2(10)      ,/* 制定组织 */
stemsite       varchar2(10)      ,/* 营运组织 */
stemdocno       varchar2(20)      ,/* 审批单号 */
stemdocdt       date      ,/* 申请日期 */
stemacti       varchar2(1)      ,/* 数据有效 */
stemstus       varchar2(10)      ,/* 状态码 */
stem001       varchar2(20)      ,/* 合约编号 */
stem002       varchar2(20)      ,/* 专柜编号 */
stem003       varchar2(10)      ,/* 供应商编号 */
stem004       varchar2(10)      ,/* 品牌编号 */
stem005       varchar2(10)      ,/* 经营小类 */
stem006       number(20,6)      ,/* 建筑面积 */
stem007       number(20,6)      ,/* 经营面积 */
stem008       varchar2(1)      ,/* 是否按账期抹零 */
stem009       date      ,/* 生效日期 */
stem010       date      ,/* 失效日期 */
stem011       date      ,/* 进场日期 */
stem012       varchar2(20)      ,/* 申请人员 */
stem013       varchar2(10)      ,/* 申请部门 */
stem014       varchar2(20)      ,/* 执行人员 */
stem015       timestamp(0)      ,/* 执行日期 */
stemownid       varchar2(20)      ,/* 资料所有者 */
stemowndp       varchar2(10)      ,/* 资料所有部门 */
stemcrtid       varchar2(20)      ,/* 资料建立者 */
stemcrtdp       varchar2(10)      ,/* 资料建立部门 */
stemcrtdt       timestamp(0)      ,/* 资料创建日 */
stemmodid       varchar2(20)      ,/* 资料修改者 */
stemmoddt       timestamp(0)      ,/* 最近修改日 */
stemcnfid       varchar2(20)      ,/* 资料确认者 */
stemcnfdt       timestamp(0)      ,/* 数据确认日 */
stem000       varchar2(20)      ,/* 程序编号 */
stem016       varchar2(10)      ,/* 合同版本号 */
stem017       number(20,6)      ,/* 测量面积 */
stem018       number(20,6)      ,/* 优惠总金额 */
stem019       date      ,/* 延期日期 */
stem020       date      ,/* 面积更改日 */
stem021       number(20,6)      ,/* 新建筑面积 */
stem022       number(20,6)      ,/* 新测量面积 */
stem023       number(20,6)      ,/* 新经营面积 */
stem024       varchar2(10)      ,/* 终止类型 */
stem025       date      ,/* 终止结算日 */
stem026       varchar2(10)      ,/* 违约方 */
stem027       number(15,3)      ,/* 违约金比例 */
stem028       number(20,6)      ,/* 违约金额 */
stem029       varchar2(10)      ,/* 违约费用编号 */
stem030       number(20,6)      ,/* 合同总额 */
stem031       number(20,6)      ,/* 原付款金额 */
stem032       number(20,6)      ,/* 应扣款金额 */
stem033       number(20,6)      ,/* 应退款金额 */
stem034       varchar2(4000)      ,/* 备注 */
stem035       varchar2(10)      ,/* 申请类型 */
stem036       date      /* 运行日期 */
);
alter table stem_t add constraint stem_pk primary key (stement,stemdocno) enable validate;

create unique index stem_pk on stem_t (stement,stemdocno);

grant select on stem_t to tiptop;
grant update on stem_t to tiptop;
grant delete on stem_t to tiptop;
grant insert on stem_t to tiptop;

exit;
