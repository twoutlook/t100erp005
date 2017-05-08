/* 
================================================================================
檔案代號:stjf_t
檔案名稱:招商租賃合約費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjf_t
(
stjfent       number(5)      ,/* 企業編號 */
stjfsite       varchar2(10)      ,/* 營運組織 */
stjfunit       varchar2(10)      ,/* 制定組織 */
stjfseq       number(10,0)      ,/* 項次 */
stjf001       varchar2(20)      ,/* 合約編號 */
stjf002       varchar2(1)      ,/* 標準否 */
stjf003       varchar2(20)      ,/* 費用方案 */
stjf004       varchar2(10)      ,/* 費用編號 */
stjf005       date      ,/* 開始日期 */
stjf006       date      ,/* 結束日期 */
stjf007       varchar2(10)      ,/* 費用計算週期 */
stjf008       number(10,0)      ,/* 週期數值 */
stjf009       varchar2(10)      ,/* 計算類型 */
stjf010       varchar2(10)      ,/* 計算基準 */
stjf011       number(20,6)      ,/* 固定/單位金額 */
stjf012       number(20,6)      ,/* 比例 */
stjf013       varchar2(10)      ,/* 保底否 */
stjf014       number(20,6)      ,/* 保底金額 */
stjf015       number(20,6)      ,/* 保底扣點 */
stjf016       varchar2(10)      ,/* 分量扣點 */
stjf017       number(20,6)      ,/* 費用總金額 */
stjf018       number(20,6)      ,/* 確認金額 */
stjf019       number(20,6)      ,/* 確認比例 */
stjf020       varchar2(1)      ,/* 可延用 */
stjf021       varchar2(10)      ,/* 方案版本號 */
stjf022       varchar2(20)      ,/* 場地編號 */
stjf023       varchar2(10)      ,/* 費用歸屬類型 */
stjf024       varchar2(10)      ,/* 費用歸屬組織 */
stjf025       varchar2(10)      /* 合約版本 */
);
alter table stjf_t add constraint stjf_pk primary key (stjfent,stjfseq,stjf001) enable validate;

create unique index stjf_pk on stjf_t (stjfent,stjfseq,stjf001);

grant select on stjf_t to tiptop;
grant update on stjf_t to tiptop;
grant delete on stjf_t to tiptop;
grant insert on stjf_t to tiptop;

exit;
