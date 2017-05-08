/* 
================================================================================
檔案代號:qcanuc_t
檔案名稱:质量检验项目单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcanuc_t
(
qcanucent       number(5)      ,/* 企业编号 */
qcanuc001       varchar2(5)      ,/* 参照表号 */
qcanuc002       varchar2(10)      ,/* 品管分群 */
qcanuc003       varchar2(40)      ,/* 料件编号 */
qcanuc004       varchar2(256)      ,/* 产品特征 */
qcanuc005       varchar2(10)      ,/* 作业编号 */
qcanuc006       number(10,0)      ,/* 加工序 */
qcanuc007       varchar2(10)      ,/* 交易对象编号 */
qcanuc008       varchar2(10)      ,/* 检验类型 */
qcanuc009       number(10,0)      ,/* 项次 */
qcanuc010       varchar2(10)      ,/* 检验项目 */
qcanuc011       varchar2(40)      ,/* 检验位置 */
qcanuc012       varchar2(10)      ,/* 缺点等级 */
qcanuc013       varchar2(10)      ,/* 抽样计划 */
qcanuc014       number(7,3)      ,/* AQL */
qcanuc015       varchar2(10)      ,/* 测量值控制方式 */
qcanuc016       varchar2(10)      ,/* 检验方式 */
qcanuc017       varchar2(10)      ,/* 资源类型 */
qcanuc018       varchar2(10)      ,/* 指定仪器 */
qcanuc019       number(15,3)      ,/* 规范上限 */
qcanuc020       number(15,3)      ,/* 检验上限 */
qcanuc021       number(15,3)      ,/* 检验标准值 */
qcanuc022       number(15,3)      ,/* 检验下限 */
qcanuc023       number(15,3)      ,/* 规范下限 */
qcanuc024       varchar2(40)      ,/* 计量单位 */
qcanuc025       varchar2(255)      ,/* 检验规格说明 */
qcanuc026       varchar2(255)      ,/* 备注 */
qcanucud001       varchar2(40)      ,/* 版本号 */
qcanucud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
qcanucud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
qcanucud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
qcanucud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
qcanucud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
qcanucud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
qcanucud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
qcanucud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
qcanucud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
qcanucud011       number(20,6)      ,/* 自定义栏位(数字)011 */
qcanucud012       number(20,6)      ,/* 自定义栏位(数字)012 */
qcanucud013       number(20,6)      ,/* 自定义栏位(数字)013 */
qcanucud014       number(20,6)      ,/* 自定义栏位(数字)014 */
qcanucud015       number(20,6)      ,/* 自定义栏位(数字)015 */
qcanucud016       number(20,6)      ,/* 自定义栏位(数字)016 */
qcanucud017       number(20,6)      ,/* 自定义栏位(数字)017 */
qcanucud018       number(20,6)      ,/* 自定义栏位(数字)018 */
qcanucud019       number(20,6)      ,/* 自定义栏位(数字)019 */
qcanucud020       number(20,6)      ,/* 自定义栏位(数字)020 */
qcanucud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
qcanucud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
qcanucud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
qcanucud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
qcanucud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
qcanucud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
qcanucud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
qcanucud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
qcanucud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
qcanucud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table qcanuc_t add constraint qcanuc_pk primary key (qcanucent,qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanuc009,qcanucud001) enable validate;

create unique index qcanuc_pk on qcanuc_t (qcanucent,qcanuc001,qcanuc002,qcanuc003,qcanuc004,qcanuc005,qcanuc006,qcanuc007,qcanuc008,qcanuc009,qcanucud001);

grant select on qcanuc_t to tiptop;
grant update on qcanuc_t to tiptop;
grant delete on qcanuc_t to tiptop;
grant insert on qcanuc_t to tiptop;

exit;
