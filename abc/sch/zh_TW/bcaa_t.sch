/* 
================================================================================
檔案代號:bcaa_t
檔案名稱:条码信息主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcaa_t
(
bcaaent       number(5)      ,/* 企业编号 */
bcaasite       varchar2(10)      ,/* 营运据点 */
bcaa000       number(5,0)      ,/* 版次 */
bcaa001       varchar2(255)      ,/* 条码编号 */
bcaa002       varchar2(40)      ,/* 料件编号 */
bcaa003       varchar2(20)      ,/* 来源作业 */
bcaa004       varchar2(20)      ,/* 来源单号 */
bcaa005       number(10,0)      ,/* 来源项次 */
bcaa006       number(10,0)      ,/* 来源项序 */
bcaa007       number(10,0)      ,/* 来源分批序 */
bcaa008       varchar2(256)      ,/* 产品特征 */
bcaa009       number(20,6)      ,/* 条位数量 */
bcaa010       number(5,0)      ,/* 打印次数 */
bcaa011       varchar2(255)      ,/* 原条码编号 */
bcaa012       varchar2(10)      ,/* 料件单位 */
bcaastus       varchar2(10)      ,/* 有效否 */
bcaaownid       varchar2(20)      ,/* 资料所有者 */
bcaaowndp       varchar2(10)      ,/* 资料所有部门 */
bcaacrtid       varchar2(20)      ,/* 资料录入者 */
bcaacrtdp       varchar2(10)      ,/* 资料录入部门 */
bcaacrtdt       timestamp(0)      ,/* 资料创建日 */
bcaamodid       varchar2(20)      ,/* 资料更改者 */
bcaamoddt       timestamp(0)      ,/* 最近更改日 */
bcaacnfid       varchar2(20)      ,/* 资料审核者 */
bcaacnfdt       timestamp(0)      ,/* 数据审核日 */
bcaaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcaaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcaaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcaaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcaaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcaaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcaaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcaaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcaaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcaaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcaaud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcaaud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcaaud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcaaud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcaaud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcaaud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcaaud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcaaud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcaaud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcaaud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcaaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcaaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcaaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcaaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcaaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcaaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcaaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcaaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcaaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcaaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcaa013       varchar2(30)      ,/* 批号 */
bcaa014       varchar2(10)      ,/* 条码类型 */
bcaa015       number(20,6)      /* 箱装数 */
);
alter table bcaa_t add constraint bcaa_pk primary key (bcaaent,bcaasite,bcaa000,bcaa001,bcaa002,bcaa003,bcaa004,bcaa005,bcaa006,bcaa007,bcaa008) enable validate;

create unique index bcaa_pk on bcaa_t (bcaaent,bcaasite,bcaa000,bcaa001,bcaa002,bcaa003,bcaa004,bcaa005,bcaa006,bcaa007,bcaa008);

grant select on bcaa_t to tiptop;
grant update on bcaa_t to tiptop;
grant delete on bcaa_t to tiptop;
grant insert on bcaa_t to tiptop;

exit;
