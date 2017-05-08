/* 
================================================================================
檔案代號:bgdg_t
檔案名稱:期別生產數量預測檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgdg_t
(
bgdgent       number(5)      ,/* 企业编号 */
bgdgownid       varchar2(20)      ,/* 资料所有者 */
bgdgowndp       varchar2(10)      ,/* 资料所有部门 */
bgdgcrtid       varchar2(20)      ,/* 资料录入者 */
bgdgcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgdgcrtdt       timestamp(0)      ,/* 资料创建日 */
bgdgmodid       varchar2(20)      ,/* 资料更改者 */
bgdgmoddt       timestamp(0)      ,/* 最近更改日 */
bgdgstus       varchar2(10)      ,/* 状态码 */
bgdg001       varchar2(10)      ,/* 预算编号 */
bgdg002       varchar2(10)      ,/* 预算版本 */
bgdg003       varchar2(10)      ,/* 预算组织 */
bgdg004       number(5,0)      ,/* 预算期别 */
bgdg005       varchar2(40)      ,/* 预算料号 */
bgdg006       varchar2(1)      ,/* 产量来源 */
bgdg007       varchar2(10)      ,/* 生产单位 */
bgdg008       number(20,6)      ,/* 期初库存 */
bgdg009       number(20,6)      ,/* 当期销售当期生产量 */
bgdg010       number(20,6)      ,/* 生产提前量 */
bgdg011       number(20,6)      ,/* 参考生产数量 */
bgdg012       number(20,6)      ,/* 本层调整生产数量 */
bgdg013       number(20,6)      ,/* 上层调整生产数量 */
bgdg014       number(20,6)      ,/* 下层调整生产数量 */
bgdg015       number(20,6)      ,/* 核准生产数量 */
bgdg016       number(20,6)      ,/* 期末库存量 */
bgdgud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgdgud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgdgud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgdgud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgdgud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgdgud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgdgud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgdgud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgdgud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgdgud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgdgud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgdgud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgdgud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgdgud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgdgud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgdgud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgdgud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgdgud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgdgud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgdgud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgdgud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgdgud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgdgud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgdgud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgdgud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgdgud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgdgud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgdgud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgdgud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgdgud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgdg017       number(20,6)      /* 当期销售预算量 */
);
alter table bgdg_t add constraint bgdg_pk primary key (bgdgent,bgdg001,bgdg002,bgdg003,bgdg004,bgdg005,bgdg006) enable validate;

create unique index bgdg_pk on bgdg_t (bgdgent,bgdg001,bgdg002,bgdg003,bgdg004,bgdg005,bgdg006);

grant select on bgdg_t to tiptop;
grant update on bgdg_t to tiptop;
grant delete on bgdg_t to tiptop;
grant insert on bgdg_t to tiptop;

exit;
