/* 
================================================================================
檔案代號:fabb_t
檔案名稱:资产异动单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabb_t
(
fabbent       number(5)      ,/* 企业编号 */
fabbcomp       varchar2(10)      ,/* 法人 */
fabbdocno       varchar2(20)      ,/* 单据编号 */
fabbseq       number(10,0)      ,/* 项次 */
fabblegl       varchar2(10)      ,/* 核算组织 */
fabb000       varchar2(10)      ,/* 卡片编号 */
fabb001       varchar2(20)      ,/* 财产编号 */
fabb002       varchar2(20)      ,/* 附号 */
fabb003       varchar2(10)      ,/* 部门 */
fabb004       varchar2(20)      ,/* 人员 */
fabb005       number(15,3)      ,/* 工作量值 */
fabb006       varchar2(40)      ,/* 备注 */
fabb007       varchar2(1)      ,/* 资产状态 */
fabb008       varchar2(1)      ,/* 停用否 */
fabbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fabbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fabbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fabbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fabbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fabbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fabbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fabbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fabbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fabbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fabbud011       number(20,6)      ,/* 自定义字段(数字)011 */
fabbud012       number(20,6)      ,/* 自定义字段(数字)012 */
fabbud013       number(20,6)      ,/* 自定义字段(数字)013 */
fabbud014       number(20,6)      ,/* 自定义字段(数字)014 */
fabbud015       number(20,6)      ,/* 自定义字段(数字)015 */
fabbud016       number(20,6)      ,/* 自定义字段(数字)016 */
fabbud017       number(20,6)      ,/* 自定义字段(数字)017 */
fabbud018       number(20,6)      ,/* 自定义字段(数字)018 */
fabbud019       number(20,6)      ,/* 自定义字段(数字)019 */
fabbud020       number(20,6)      ,/* 自定义字段(数字)020 */
fabbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fabbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fabbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fabbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fabbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fabbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fabbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fabbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fabbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fabbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
fabb009       varchar2(10)      ,/* 存放位置 */
fabb010       varchar2(10)      ,/* 部门(旧) */
fabb011       varchar2(20)      ,/* 人员(旧) */
fabb012       varchar2(10)      ,/* 存放位置(旧) */
fabb013       varchar2(1)      ,/* 单一部门分摊时同时更新分摊部门 */
fabb014       varchar2(24)      ,/* 资产科目(旧) */
fabb015       varchar2(24)      ,/* 资产科目 */
fabb016       varchar2(24)      ,/* 累折科目(旧) */
fabb017       varchar2(24)      ,/* 累折科目 */
fabb018       varchar2(24)      ,/* 折旧科目(旧) */
fabb019       varchar2(24)      ,/* 折旧科目 */
fabb020       varchar2(24)      ,/* 减值准备科目(旧) */
fabb021       varchar2(24)      ,/* 减值准备科目 */
fabb022       varchar2(10)      ,/* 异动原因 */
fabb023       varchar2(10)      ,/* 所有组织(旧) */
fabb024       varchar2(10)      ,/* 所有组织 */
fabb025       varchar2(10)      ,/* 管理组织(旧) */
fabb026       varchar2(10)      ,/* 管理组织 */
fabb027       varchar2(10)      ,/* 核算组织(旧) */
fabb028       varchar2(10)      ,/* 核算组织 */
fabb029       varchar2(80)      ,/* 分摊部门/类别 */
fabb030       varchar2(80)      ,/* 分摊部门/类别(新) */
fabb031       number(10)      ,/* 分摊方式(旧) */
fabb032       number(10)      /* 分摊方式(新) */
);
alter table fabb_t add constraint fabb_pk primary key (fabbent,fabbdocno,fabbseq) enable validate;

create unique index fabb_pk on fabb_t (fabbent,fabbdocno,fabbseq);

grant select on fabb_t to tiptop;
grant update on fabb_t to tiptop;
grant delete on fabb_t to tiptop;
grant insert on fabb_t to tiptop;

exit;
