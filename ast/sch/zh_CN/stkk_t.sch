/* 
================================================================================
檔案代號:stkk_t
檔案名稱:招商租赁合同申请品类品牌单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkk_t
(
stkkent       number(5)      ,/* 企业编号 */
stkksite       varchar2(10)      ,/* 营运组织 */
stkkunit       varchar2(10)      ,/* 制定组织 */
stkkdocno       varchar2(20)      ,/* 单据编号 */
stkkseq       number(10,0)      ,/* 项次 */
stkkacti       varchar2(1)      ,/* 有效否 */
stkk001       varchar2(20)      ,/* 合同编号 */
stkk002       varchar2(10)      ,/* 品类编号 */
stkk003       varchar2(10)      ,/* 品牌编号 */
stkkud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkkud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkkud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkkud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkkud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkkud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkkud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkkud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkkud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkkud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkkud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkkud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkkud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkkud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkkud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkkud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkkud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkkud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkkud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkkud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkkud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkkud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkkud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkkud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkkud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkkud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkkud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkkud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkkud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkkud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkk004       varchar2(1)      ,/* 主品类 */
stkk005       varchar2(1)      /* 主品牌 */
);
alter table stkk_t add constraint stkk_pk primary key (stkkent,stkkdocno,stkkseq,stkk001) enable validate;

create unique index stkk_pk on stkk_t (stkkent,stkkdocno,stkkseq,stkk001);

grant select on stkk_t to tiptop;
grant update on stkk_t to tiptop;
grant delete on stkk_t to tiptop;
grant insert on stkk_t to tiptop;

exit;
