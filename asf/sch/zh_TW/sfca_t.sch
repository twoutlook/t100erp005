/* 
================================================================================
檔案代號:sfca_t
檔案名稱:工单工艺单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfca_t
(
sfcaent       number(5)      ,/* 企业编号 */
sfcasite       varchar2(10)      ,/* 营运据点 */
sfcadocno       varchar2(20)      ,/* 单号 */
sfca001       number(10,0)      ,/* RUN CARD编号 */
sfca002       number(10,0)      ,/* 变更版本 */
sfca003       number(20,6)      ,/* 生产数量 */
sfca004       number(20,6)      ,/* 完工数量 */
sfca005       varchar2(1)      ,/* RUN CARD类型 */
sfcaud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
sfcaud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
sfcaud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
sfcaud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
sfcaud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
sfcaud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
sfcaud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
sfcaud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
sfcaud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
sfcaud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
sfcaud011       number(20,6)      ,/* 自定义栏位(数字)011 */
sfcaud012       number(20,6)      ,/* 自定义栏位(数字)012 */
sfcaud013       number(20,6)      ,/* 自定义栏位(数字)013 */
sfcaud014       number(20,6)      ,/* 自定义栏位(数字)014 */
sfcaud015       number(20,6)      ,/* 自定义栏位(数字)015 */
sfcaud016       number(20,6)      ,/* 自定义栏位(数字)016 */
sfcaud017       number(20,6)      ,/* 自定义栏位(数字)017 */
sfcaud018       number(20,6)      ,/* 自定义栏位(数字)018 */
sfcaud019       number(20,6)      ,/* 自定义栏位(数字)019 */
sfcaud020       number(20,6)      ,/* 自定义栏位(数字)020 */
sfcaud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
sfcaud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
sfcaud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
sfcaud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
sfcaud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
sfcaud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
sfcaud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
sfcaud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
sfcaud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
sfcaud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table sfca_t add constraint sfca_pk primary key (sfcaent,sfcadocno,sfca001) enable validate;

create unique index sfca_pk on sfca_t (sfcaent,sfcadocno,sfca001);

grant select on sfca_t to tiptop;
grant update on sfca_t to tiptop;
grant delete on sfca_t to tiptop;
grant insert on sfca_t to tiptop;

exit;
