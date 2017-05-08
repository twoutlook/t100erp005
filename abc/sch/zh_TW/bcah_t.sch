/* 
================================================================================
檔案代號:bcah_t
檔案名稱:条码盘点明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcah_t
(
bcahent       number(5)      ,/* 企业编号 */
bcahsite       varchar2(10)      ,/* 营运据点 */
bcahdocno       varchar2(20)      ,/* 标签编号 */
bcahseq       number(10,0)      ,/* 项次 */
bcah001       varchar2(255)      ,/* 条码编号 */
bcah002       varchar2(40)      ,/* 料件编号 */
bcah003       varchar2(256)      ,/* 产品特征 */
bcah004       varchar2(30)      ,/* 库存管理特征 */
bcah005       varchar2(10)      ,/* 库位编号 */
bcah006       varchar2(10)      ,/* 储位编号 */
bcah007       varchar2(30)      ,/* 批号 */
bcah008       varchar2(20)      ,/* 盘点计划单号 */
bcah009       varchar2(1)      ,/* 空白标签 */
bcah010       varchar2(10)      ,/* 库存单位 */
bcah011       number(20,6)      ,/* 现有库存量 */
bcah012       varchar2(10)      ,/* 参考单位 */
bcah013       number(20,6)      ,/* 参考单位现有库存量 */
bcah014       varchar2(10)      ,/* 理由码 */
bcah015       varchar2(255)      ,/* 备注 */
bcah016       number(20,6)      ,/* 盘点数量-初盘(一) */
bcah017       number(20,6)      ,/* 参考单位盘点量-初盘(一) */
bcah018       varchar2(20)      ,/* 盘点人员-初盘(一) */
bcah019       date      ,/* 盘点日期-初盘(一) */
bcah020       number(20,6)      ,/* 盘点数量-初盘(二) */
bcah021       number(20,6)      ,/* 参考单位盘点量-初盘(二) */
bcah022       varchar2(20)      ,/* 盘点人员-初盘(二) */
bcah023       date      ,/* 盘点日期-初盘(二) */
bcah024       number(20,6)      ,/* 初盘调整数量 */
bcah025       number(20,6)      ,/* 参考单位初盘调整数量 */
bcah026       number(20,6)      ,/* 盘点数量-复盘(一) */
bcah027       number(20,6)      ,/* 参考单位盘点量-复盘(一) */
bcah028       varchar2(20)      ,/* 盘点人员-复盘(一) */
bcah029       date      ,/* 盘点日期-复盘(一) */
bcah030       number(20,6)      ,/* 盘点数量-复盘(二) */
bcah031       number(20,6)      ,/* 参考单位盘点量-复盘(二) */
bcah032       varchar2(20)      ,/* 盘点人员-复盘(二) */
bcah033       date      ,/* 盘点日期-复盘(二) */
bcah034       number(20,6)      ,/* 复盘调整数量 */
bcah035       number(20,6)      ,/* 参考单位复盘调整数量 */
bcahownid       varchar2(20)      ,/* 资料所有者 */
bcahowndp       varchar2(10)      ,/* 资料所有部门 */
bcahcrtid       varchar2(20)      ,/* 资料录入者 */
bcahcrtdp       varchar2(10)      ,/* 资料录入部门 */
bcahcrtdt       timestamp(0)      ,/* 资料创建日 */
bcahmodid       varchar2(20)      ,/* 资料更改者 */
bcahmoddt       timestamp(0)      ,/* 最近更改日 */
bcahcnfid       varchar2(20)      ,/* 资料审核者 */
bcahcnfdt       timestamp(0)      ,/* 数据审核日 */
bcahstus       varchar2(10)      /* 状态码 */
);
alter table bcah_t add constraint bcah_pk primary key (bcahent,bcahsite,bcahdocno,bcahseq,bcah001) enable validate;

create unique index bcah_pk on bcah_t (bcahent,bcahsite,bcahdocno,bcahseq,bcah001);

grant select on bcah_t to tiptop;
grant update on bcah_t to tiptop;
grant delete on bcah_t to tiptop;
grant insert on bcah_t to tiptop;

exit;
