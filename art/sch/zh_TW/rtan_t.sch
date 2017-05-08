/* 
================================================================================
檔案代號:rtan_t
檔案名稱:门店资源协议申请明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtan_t
(
rtanent       number(5)      ,/* 企业编号 */
rtansite       varchar2(10)      ,/* 所属组织 */
rtancomp       varchar2(10)      ,/* 所属法人 */
rtandocno       varchar2(20)      ,/* 单据编号 */
rtanseq       number(10,0)      ,/* 单据项次 */
rtan001       varchar2(20)      ,/* 资源协议编号 */
rtan002       varchar2(10)      ,/* 资源编号 */
rtan003       date      ,/* 生效日期 */
rtan004       date      ,/* 失效日期 */
rtan005       number(5,0)      ,/* 本次租用资源数量 */
rtan006       number(20,6)      ,/* 资源面积 */
rtan007       varchar2(20)      ,/* 专柜编号 */
rtan008       varchar2(10)      ,/* 供应商编号 */
rtan009       varchar2(10)      ,/* 经营类别 */
rtan010       varchar2(10)      ,/* 所属部门 */
rtan011       varchar2(10)      ,/* 费用编号 */
rtan012       varchar2(1)      ,/* 纳入结算单否 */
rtan013       varchar2(1)      ,/* 票扣否 */
rtan014       varchar2(10)      ,/* 价款类型 */
rtan015       varchar2(10)      ,/* 计算类型 */
rtan016       number(20,6)      ,/* 收费标准金额 */
rtan017       number(20,6)      ,/* 协议金额 */
rtan018       number(20,6)      ,/* 仓库押金 */
rtan019       varchar2(255)      ,/* 备注 */
rtan020       varchar2(10)      ,/* 协议状态 */
rtan021       date      ,/* 下次结算日 */
rtan022       date      ,/* 下次费用开始日 */
rtan023       date      ,/* 下次费用截止日 */
rtan024       varchar2(10)      ,/* 租用对象 */
rtan025       varchar2(20)      /* 合同编号 */
);
alter table rtan_t add constraint rtan_pk primary key (rtanent,rtandocno,rtanseq) enable validate;

create unique index rtan_pk on rtan_t (rtanent,rtandocno,rtanseq);

grant select on rtan_t to tiptop;
grant update on rtan_t to tiptop;
grant delete on rtan_t to tiptop;
grant insert on rtan_t to tiptop;

exit;
