/* 
================================================================================
檔案代號:bcaf_t
檔案名稱:扫描异动纪录单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcaf_t
(
bcafent       number(5)      ,/* 企业编号 */
bcafsite       varchar2(10)      ,/* 营运据点 */
bcaf001       varchar2(80)      ,/* 信息ID */
bcaf002       varchar2(30)      ,/* 信息批号 */
bcaf003       varchar2(40)      ,/* 扫描单号 */
bcaf004       number(10,0)      ,/* 扫描项次 */
bcaf005       number(5,0)      ,/* 出入库码 */
bcaf006       varchar2(255)      ,/* 条码编号 */
bcaf007       varchar2(40)      ,/* 料件编号 */
bcaf008       varchar2(30)      ,/* 产品特征 */
bcaf009       varchar2(500)      ,/* 产品特征说明 */
bcaf010       varchar2(10)      ,/* 库位 */
bcaf011       varchar2(10)      ,/* 储位 */
bcaf012       varchar2(30)      ,/* 批号 */
bcaf013       varchar2(30)      ,/* 库存管理特征 */
bcaf014       varchar2(30)      ,/* 制造批号 */
bcaf015       varchar2(30)      ,/* 制造序号 */
bcaf016       number(20,6)      ,/* 拣货数量 */
bcaf017       varchar2(10)      ,/* 拣货单位 */
bcaf018       timestamp(5)      ,/* 拣货日期时间 */
bcaf019       timestamp(5)      ,/* 上传时间 */
bcaf020       varchar2(20)      ,/* 单号 */
bcaf021       number(10,0)      ,/* 项次 */
bcaf022       number(10,0)      ,/* 项序 */
bcaf023       number(10,0)      ,/* 分批序 */
bcafud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcafud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcafud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcafud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcafud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcafud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcafud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcafud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcafud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcafud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcafud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcafud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcafud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcafud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcafud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcafud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcafud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcafud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcafud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcafud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcafud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcafud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcafud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcafud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcafud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcafud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcafud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcafud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcafud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcafud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcaf031       varchar2(10)      ,/* 来源单位 */
bcaf032       number(20,6)      ,/* 来源数量 */
bcaf033       varchar2(10)      ,/* 目的单位 */
bcaf034       number(20,6)      ,/* 目的数量 */
bcaf035       number(20,6)      ,/* 换算后数量 */
bcaf036       varchar2(10)      ,/* 拨入库位 */
bcaf037       varchar2(10)      ,/* 拨入储位 */
bcaf038       varchar2(10)      ,/* 在途成本仓 */
bcaf039       varchar2(10)      ,/* 在途非成本仓 */
bcaf040       number(10,0)      /* RunCard */
);
alter table bcaf_t add constraint bcaf_pk primary key (bcafent,bcafsite,bcaf001,bcaf002,bcaf003,bcaf004) enable validate;

create unique index bcaf_pk on bcaf_t (bcafent,bcafsite,bcaf001,bcaf002,bcaf003,bcaf004);

grant select on bcaf_t to tiptop;
grant update on bcaf_t to tiptop;
grant delete on bcaf_t to tiptop;
grant insert on bcaf_t to tiptop;

exit;
