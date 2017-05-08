/* 
================================================================================
檔案代號:pcbd_t
檔案名稱:触屏产品数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcbd_t
(
pcbdent       number(5)      ,/* 企业编号 */
pcbd001       varchar2(10)      ,/* 方案编号 */
pcbd002       varchar2(40)      ,/* 商品编号 */
pcbd003       varchar2(256)      ,/* 产品特征 */
pcbd004       varchar2(10)      ,/* 单位编号 */
pcbd005       varchar2(10)      ,/* 所属小类 */
pcbd006       blob      ,/* 图片 */
pcbd007       varchar2(10)      ,/* 背景颜色 */
pcbd008       varchar2(40)      ,/* 背景颜色-RGB */
pcbd009       number(5,0)      ,/* 顺序号 */
pcbdstus       varchar2(10)      ,/* 状态码 */
pcbdud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pcbdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pcbdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pcbdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pcbdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pcbdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pcbdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pcbdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pcbdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pcbdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pcbdud011       number(20,6)      ,/* 自定义字段(数字)011 */
pcbdud012       number(20,6)      ,/* 自定义字段(数字)012 */
pcbdud013       number(20,6)      ,/* 自定义字段(数字)013 */
pcbdud014       number(20,6)      ,/* 自定义字段(数字)014 */
pcbdud015       number(20,6)      ,/* 自定义字段(数字)015 */
pcbdud016       number(20,6)      ,/* 自定义字段(数字)016 */
pcbdud017       number(20,6)      ,/* 自定义字段(数字)017 */
pcbdud018       number(20,6)      ,/* 自定义字段(数字)018 */
pcbdud019       number(20,6)      ,/* 自定义字段(数字)019 */
pcbdud020       number(20,6)      ,/* 自定义字段(数字)020 */
pcbdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pcbdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pcbdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pcbdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pcbdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pcbdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pcbdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pcbdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pcbdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pcbdud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table pcbd_t add constraint pcbd_pk primary key (pcbdent,pcbd001,pcbd002,pcbd003,pcbd004,pcbd005) enable validate;

create unique index pcbd_pk on pcbd_t (pcbdent,pcbd001,pcbd002,pcbd003,pcbd004,pcbd005);

grant select on pcbd_t to tiptop;
grant update on pcbd_t to tiptop;
grant delete on pcbd_t to tiptop;
grant insert on pcbd_t to tiptop;

exit;
