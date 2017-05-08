/* 
================================================================================
檔案代號:pmde_t
檔案名稱:请购变更历程档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmde_t
(
pmdeent       number(5)      ,/* 企业编号 */
pmdesite       varchar2(10)      ,/* 营运据点 */
pmdedocno       varchar2(20)      ,/* 请购单号 */
pmdeseq       number(10,0)      ,/* 请购项次 */
pmde001       number(10,0)      ,/* 变更序 */
pmde002       varchar2(20)      ,/* 变更字段 */
pmde003       varchar2(10)      ,/* 变更类型 */
pmde004       varchar2(255)      ,/* 变更前内容 */
pmde005       varchar2(255)      ,/* 变更后内容 */
pmde006       timestamp(0)      ,/* 最后变更时间 */
pmde007       varchar2(500)      ,/* 字段说明SQL */
pmdeownid       varchar2(20)      ,/* 资料所有者 */
pmdeowndp       varchar2(10)      ,/* 资料所有部门 */
pmdecrtid       varchar2(20)      ,/* 资料录入者 */
pmdecrtdp       varchar2(10)      ,/* 资料录入部门 */
pmdecrtdt       timestamp(0)      ,/* 资料创建日 */
pmdemodid       varchar2(20)      ,/* 资料更改者 */
pmdemoddt       timestamp(0)      ,/* 最近更改日 */
pmdecnfid       varchar2(20)      ,/* 资料审核者 */
pmdecnfdt       timestamp(0)      ,/* 数据审核日 */
pmdepstid       varchar2(20)      ,/* 资料过账者 */
pmdepstdt       timestamp(0)      ,/* 资料过账日 */
pmdestus       varchar2(10)      ,/* 状态码 */
pmdeud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
pmdeud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
pmdeud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
pmdeud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
pmdeud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
pmdeud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
pmdeud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
pmdeud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
pmdeud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
pmdeud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
pmdeud011       number(20,6)      ,/* 自定义栏位(数字)011 */
pmdeud012       number(20,6)      ,/* 自定义栏位(数字)012 */
pmdeud013       number(20,6)      ,/* 自定义栏位(数字)013 */
pmdeud014       number(20,6)      ,/* 自定义栏位(数字)014 */
pmdeud015       number(20,6)      ,/* 自定义栏位(数字)015 */
pmdeud016       number(20,6)      ,/* 自定义栏位(数字)016 */
pmdeud017       number(20,6)      ,/* 自定义栏位(数字)017 */
pmdeud018       number(20,6)      ,/* 自定义栏位(数字)018 */
pmdeud019       number(20,6)      ,/* 自定义栏位(数字)019 */
pmdeud020       number(20,6)      ,/* 自定义栏位(数字)020 */
pmdeud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
pmdeud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
pmdeud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
pmdeud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
pmdeud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
pmdeud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
pmdeud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
pmdeud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
pmdeud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
pmdeud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table pmde_t add constraint pmde_pk primary key (pmdeent,pmdedocno,pmdeseq,pmde001,pmde002) enable validate;

create unique index pmde_pk on pmde_t (pmdeent,pmdedocno,pmdeseq,pmde001,pmde002);

grant select on pmde_t to tiptop;
grant update on pmde_t to tiptop;
grant delete on pmde_t to tiptop;
grant insert on pmde_t to tiptop;

exit;
