/* 
================================================================================
檔案代號:pjec_t
檔案名稱:项目费用分摊明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjec_t
(
pjecent       number(5)      ,/* 企业编号 */
pjeccomp       varchar2(10)      ,/* 法人组织 */
pjecld       varchar2(5)      ,/* 账套 */
pjec002       number(5,0)      ,/* 年度 */
pjec003       number(5,0)      ,/* 期别 */
pjecseq       number(10,0)      ,/* 项次 */
pjec004       varchar2(20)      ,/* 项目编号 */
pjec005       varchar2(30)      ,/* WBS编号 */
pjec010       varchar2(24)      ,/* 科目编号 */
pjec011       varchar2(10)      ,/* 营运组织 */
pjec012       varchar2(10)      ,/* 部门 */
pjec013       varchar2(10)      ,/* 交易对象 */
pjec014       varchar2(10)      ,/* 客群 */
pjec015       varchar2(10)      ,/* 区域 */
pjec016       varchar2(10)      ,/* 成本中心 */
pjec017       varchar2(10)      ,/* 经营类别 */
pjec018       varchar2(10)      ,/* 渠道 */
pjec019       varchar2(10)      ,/* 品类 */
pjec020       varchar2(10)      ,/* 品牌 */
pjec021       varchar2(20)      ,/* 项目编号（核算项） */
pjec022       varchar2(30)      ,/* WBS（核算项） */
pjec099       number(15,3)      ,/* 项目工时 */
pjec100       number(20,6)      ,/* 分摊金额 */
pjec110       number(20,6)      ,/* 分摊金额(本位币二) */
pjec120       number(20,6)      ,/* 分摊金额(本位币三) */
pjec200       number(20,6)      ,/* 分摊基数 */
pjec300       number(20,6)      ,/* 分摊单价 */
pjec310       number(20,6)      ,/* 分摊单价(本位币二) */
pjec320       number(20,6)      ,/* 分摊单价(本位币三) */
pjecownid       varchar2(20)      ,/* 资料所有者 */
pjecowndp       varchar2(10)      ,/* 资料所有部门 */
pjeccrtid       varchar2(20)      ,/* 资料录入者 */
pjeccrtdp       varchar2(10)      ,/* 资料录入部门 */
pjeccrtdt       timestamp(0)      ,/* 资料创建日 */
pjecmodid       varchar2(20)      ,/* 资料更改者 */
pjecmoddt       timestamp(0)      ,/* 最近更改日 */
pjecstus       varchar2(10)      ,/* 状态码 */
pjec023       varchar2(30)      ,/* 自由核算项一 */
pjec024       varchar2(30)      ,/* 自由核算项二 */
pjec025       varchar2(30)      ,/* 自由核算项三 */
pjec026       varchar2(30)      ,/* 自由核算项四 */
pjec027       varchar2(30)      ,/* 自由核算项五 */
pjec028       varchar2(30)      ,/* 自由核算项六 */
pjec029       varchar2(30)      ,/*   */
pjec030       varchar2(30)      ,/* 自由核算项八 */
pjec031       varchar2(30)      ,/* 自由核算项九 */
pjec032       varchar2(30)      /* 自由核算项十 */
);
alter table pjec_t add constraint pjec_pk primary key (pjecent,pjecld,pjec002,pjec003,pjecseq) enable validate;

create unique index pjec_pk on pjec_t (pjecent,pjecld,pjec002,pjec003,pjecseq);

grant select on pjec_t to tiptop;
grant update on pjec_t to tiptop;
grant delete on pjec_t to tiptop;
grant insert on pjec_t to tiptop;

exit;
