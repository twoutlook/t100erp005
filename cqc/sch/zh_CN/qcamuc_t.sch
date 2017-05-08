/* 
================================================================================
檔案代號:qcamuc_t
檔案名稱:质量检验项目单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcamuc_t
(
qcamucent       number(5)      ,/* 企业编号 */
qcamuc001       varchar2(5)      ,/* 参照表号 */
qcamuc002       varchar2(10)      ,/* 品管分群 */
qcamuc003       varchar2(40)      ,/* 料件编号 */
qcamuc004       varchar2(256)      ,/* 产品特征 */
qcamuc005       varchar2(10)      ,/* 作业编号 */
qcamuc006       number(10,0)      ,/* 加工序 */
qcamuc007       varchar2(10)      ,/* 交易对象类型 */
qcamuc008       varchar2(10)      ,/* 交易对象编号 */
qcamuc009       varchar2(10)      ,/* 检验类型 */
qcamuc010       varchar2(20)      ,/* 识别码 */
qcamucownid       varchar2(20)      ,/* 资料所有者 */
qcamucowndp       varchar2(10)      ,/* 资料所有部门 */
qcamuccrtid       varchar2(20)      ,/* 资料录入者 */
qcamuccrtdp       varchar2(10)      ,/* 资料录入部门 */
qcamuccrtdt       timestamp(0)      ,/* 资料创建日 */
qcamucmodid       varchar2(20)      ,/* 资料更改者 */
qcamucmoddt       timestamp(0)      ,/* 最近更改日 */
qcamucstus       varchar2(10)      ,/* 状态码 */
qcamucud001       varchar2(40)      ,/* 版本号 */
qcamucud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcamucud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcamucud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcamucud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcamucud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcamucud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcamucud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcamucud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcamucud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcamucud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcamucud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcamucud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcamucud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcamucud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcamucud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcamucud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcamucud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcamucud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcamucud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcamucud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcamucud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcamucud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcamucud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcamucud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcamucud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcamucud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcamucud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcamucud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcamucud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
qcamuccnfid       varchar2(20)      ,/* 资料确认者 */
qcamuccnfdt       timestamp(0)      /* 资料确认日 */
);
alter table qcamuc_t add constraint qcamuc_pk primary key (qcamucent,qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc008,qcamuc009,qcamucud001) enable validate;

create  index qcamuc_01 on qcamuc_t (qcamuc010);
create unique index qcamuc_pk on qcamuc_t (qcamucent,qcamuc001,qcamuc002,qcamuc003,qcamuc004,qcamuc005,qcamuc006,qcamuc008,qcamuc009,qcamucud001);

grant select on qcamuc_t to tiptop;
grant update on qcamuc_t to tiptop;
grant delete on qcamuc_t to tiptop;
grant insert on qcamuc_t to tiptop;

exit;
