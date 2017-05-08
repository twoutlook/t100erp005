/* 
================================================================================
檔案代號:stkj_t
檔案名稱:招商租赁合同申请场地信息单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkj_t
(
stkjent       number(5)      ,/* 企业编号 */
stkjsite       varchar2(10)      ,/* 营运组织 */
stkjunit       varchar2(10)      ,/* 制定组织 */
stkjdocno       varchar2(20)      ,/* 单据编号 */
stkjseq       number(10,0)      ,/* 项次 */
stkjacti       varchar2(1)      ,/* 有效否 */
stkj001       varchar2(20)      ,/* 合同编号 */
stkj002       varchar2(20)      ,/* 场地编号 */
stkj003       number(20,6)      ,/* 建筑面积 */
stkj004       number(20,6)      ,/* 测量面积 */
stkj005       number(20,6)      ,/* 经营面积 */
stkj006       varchar2(10)      ,/* 楼栋编号 */
stkj007       varchar2(10)      ,/* 楼层编号 */
stkj008       varchar2(10)      ,/* 区域编号 */
stkj009       varchar2(10)      ,/* 合同版本 */
stkjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkjud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkjud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkjud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkjud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkjud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkjud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkjud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkjud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkjud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkjud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkjud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table stkj_t add constraint stkj_pk primary key (stkjent,stkjdocno,stkjseq,stkj001) enable validate;

create unique index stkj_pk on stkj_t (stkjent,stkjdocno,stkjseq,stkj001);

grant select on stkj_t to tiptop;
grant update on stkj_t to tiptop;
grant delete on stkj_t to tiptop;
grant insert on stkj_t to tiptop;

exit;
