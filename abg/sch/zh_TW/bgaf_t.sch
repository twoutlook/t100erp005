/* 
================================================================================
檔案代號:bgaf_t
檔案名稱:预算变量档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgaf_t
(
bgafstus       varchar2(10)      ,/* 有效码 */
bgafent       number(5)      ,/* 企业编号 */
bgaf001       varchar2(10)      ,/* 预算组织 */
bgaf002       date      ,/* 起始日期 */
bgaf003       date      ,/* 截止日期 */
bgaf005       varchar2(10)      ,/* 运行预算版本 */
bgafownid       varchar2(20)      ,/* 资料所有者 */
bgafowndp       varchar2(10)      ,/* 资料所有部门 */
bgafcrtid       varchar2(20)      ,/* 资料录入者 */
bgafcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgafcrtdt       timestamp(0)      ,/* 资料创建日 */
bgafmodid       varchar2(20)      ,/* 资料更改者 */
bgafmoddt       timestamp(0)      ,/* 最近更改日 */
bgafcnfid       varchar2(20)      ,/* 资料审核者 */
bgafcnfdt       timestamp(0)      ,/* 数据审核日 */
bgaf006       varchar2(1)      ,/* 滚动周期 */
bgafud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgafud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgafud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgafud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgafud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgafud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgafud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgafud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgafud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgafud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgafud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgafud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgafud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgafud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgafud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgafud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgafud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgafud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgafud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgafud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgafud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgafud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgafud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgafud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgafud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgafud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgafud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgafud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgafud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgafud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgaf007       varchar2(24)      ,/* 预算细项 */
bgaf008       varchar2(1)      ,/* 总额控制 */
bgaf009       varchar2(1)      ,/* 前期未用完是否可延抵 */
bgaf010       number(5,0)      ,/* 可抵延期别 */
bgaf011       varchar2(1)      ,/* 可否挪用后期 */
bgaf012       varchar2(1)      ,/* 可否追加 */
bgaf013       varchar2(1)      ,/* 可否挪用 */
bgaf014       varchar2(1)      ,/* 控制类型 */
bgaf015       varchar2(1)      ,/* 控制方向 */
bgaf016       varchar2(1)      ,/* 超额控制方式 */
bgaf004       varchar2(10)      /* 运行预算编号 */
);
alter table bgaf_t add constraint bgaf_pk primary key (bgafent,bgaf001,bgaf002,bgaf003,bgaf007) enable validate;

create unique index bgaf_pk on bgaf_t (bgafent,bgaf001,bgaf002,bgaf003,bgaf007);

grant select on bgaf_t to tiptop;
grant update on bgaf_t to tiptop;
grant delete on bgaf_t to tiptop;
grant insert on bgaf_t to tiptop;

exit;
