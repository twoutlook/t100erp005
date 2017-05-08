/* 
================================================================================
檔案代號:inal_t
檔案名稱:制造批序号库存交易明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inal_t
(
inalent       number(5)      ,/* 企业编号 */
inalsite       varchar2(10)      ,/* 营运据点 */
inal001       varchar2(20)      ,/* 单据编号 */
inal002       number(10,0)      ,/* 项次 */
inal003       number(10,0)      ,/* 项序 */
inal004       number(5,0)      ,/* 序号 */
inal005       number(5,0)      ,/* 出入库码 */
inal006       varchar2(40)      ,/* 料件编号 */
inal007       varchar2(256)      ,/* 产品特征 */
inal008       varchar2(30)      ,/* 库存管理特征 */
inal009       varchar2(10)      ,/* 库位编号 */
inal010       varchar2(10)      ,/* 储位编号 */
inal011       varchar2(30)      ,/* 批号 */
inal012       varchar2(30)      ,/* 制造批号 */
inal013       varchar2(30)      ,/* 制造序号 */
inal014       number(20,6)      ,/* 交易数量 */
inal015       varchar2(20)      ,/* 异动指令编号 */
inal016       date      ,/* 单据扣账日期 */
inal017       date      ,/* 实际运行扣账日期 */
inalud001       varchar2(40)      ,/* 自定义栏位(文本)001 */
inalud002       varchar2(40)      ,/* 自定义栏位(文本)002 */
inalud003       varchar2(40)      ,/* 自定义栏位(文本)003 */
inalud004       varchar2(40)      ,/* 自定义栏位(文本)004 */
inalud005       varchar2(40)      ,/* 自定义栏位(文本)005 */
inalud006       varchar2(40)      ,/* 自定义栏位(文本)006 */
inalud007       varchar2(40)      ,/* 自定义栏位(文本)007 */
inalud008       varchar2(40)      ,/* 自定义栏位(文本)008 */
inalud009       varchar2(40)      ,/* 自定义栏位(文本)009 */
inalud010       varchar2(40)      ,/* 自定义栏位(文本)010 */
inalud011       number(20,6)      ,/* 自定义栏位(数字)011 */
inalud012       number(20,6)      ,/* 自定义栏位(数字)012 */
inalud013       number(20,6)      ,/* 自定义栏位(数字)013 */
inalud014       number(20,6)      ,/* 自定义栏位(数字)014 */
inalud015       number(20,6)      ,/* 自定义栏位(数字)015 */
inalud016       number(20,6)      ,/* 自定义栏位(数字)016 */
inalud017       number(20,6)      ,/* 自定义栏位(数字)017 */
inalud018       number(20,6)      ,/* 自定义栏位(数字)018 */
inalud019       number(20,6)      ,/* 自定义栏位(数字)019 */
inalud020       number(20,6)      ,/* 自定义栏位(数字)020 */
inalud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
inalud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
inalud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
inalud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
inalud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
inalud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
inalud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
inalud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
inalud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
inalud030       timestamp(0)      ,/* 自定义栏位(日期时间)030 */
inal018       varchar2(10)      /* 库存异动类型 */
);
alter table inal_t add constraint inal_pk primary key (inalent,inalsite,inal001,inal002,inal003,inal004,inal005) enable validate;

create  index inal_n01 on inal_t (inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013);
create unique index inal_pk on inal_t (inalent,inalsite,inal001,inal002,inal003,inal004,inal005);

grant select on inal_t to tiptop;
grant update on inal_t to tiptop;
grant delete on inal_t to tiptop;
grant insert on inal_t to tiptop;

exit;
