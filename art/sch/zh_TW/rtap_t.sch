/* 
================================================================================
檔案代號:rtap_t
檔案名稱:门店资源协议维护明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtap_t
(
rtapent       number(5)      ,/* 企业编号 */
rtapsite       varchar2(10)      ,/* 所属组织 */
rtapcomp       varchar2(10)      ,/* 所属法人 */
rtapseq       number(10,0)      ,/* 单据项次 */
rtap001       varchar2(20)      ,/* 资源协议编号 */
rtap002       varchar2(10)      ,/* 资源编号 */
rtap003       date      ,/* 生效日期 */
rtap004       date      ,/* 失效日期 */
rtap005       number(5,0)      ,/* 本次租用资源数量 */
rtap006       number(20,6)      ,/* 资源面积 */
rtap007       varchar2(20)      ,/* 专柜编号 */
rtap008       varchar2(10)      ,/* 供应商编号 */
rtap009       varchar2(10)      ,/* 经营类别 */
rtap010       varchar2(10)      ,/* 所属部门 */
rtap011       varchar2(10)      ,/* 费用编号 */
rtap012       varchar2(1)      ,/* 纳入结算单否 */
rtap013       varchar2(1)      ,/* 票扣否 */
rtap014       varchar2(10)      ,/* 价款类型 */
rtap015       varchar2(10)      ,/* 计算类型 */
rtap016       number(20,6)      ,/* 收费标准金额 */
rtap017       number(20,6)      ,/* 协议金额 */
rtap018       number(20,6)      ,/* 仓库押金 */
rtap019       varchar2(255)      ,/* 备注 */
rtap020       varchar2(10)      ,/* 协议状态 */
rtap021       date      ,/* 下次结算日 */
rtap022       date      ,/* 下次费用开始日 */
rtap023       date      ,/* 下次费用截止日 */
rtap024       varchar2(10)      ,/* 租用对象 */
rtap025       varchar2(20)      /* 合同编号 */
);
alter table rtap_t add constraint rtap_pk primary key (rtapent,rtapseq,rtap001) enable validate;

create unique index rtap_pk on rtap_t (rtapent,rtapseq,rtap001);

grant select on rtap_t to tiptop;
grant update on rtap_t to tiptop;
grant delete on rtap_t to tiptop;
grant insert on rtap_t to tiptop;

exit;
