/* 
================================================================================
檔案代號:prcd_t
檔案名稱:促銷活動計劃主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prcd_t
(
prcdent       number(5)      ,/* 企業編號 */
prcdunit       varchar2(10)      ,/* 應用組織 */
prcdsite       varchar2(10)      ,/* NO USE */
prcdstus       varchar2(10)      ,/* 有效否 */
prcd001       varchar2(30)      ,/* 活動計劃 */
prcd002       varchar2(10)      ,/* 檔期類型 */
prcd003       varchar2(10)      ,/* 活動等級 */
prcd004       date      ,/* 開始日期 */
prcd005       date      ,/* 截止日期 */
prcd006       varchar2(1)      ,/* 制定促銷方案否 */
prcd098       varchar2(10)      ,/* 應用業態 */
prcdownid       varchar2(20)      ,/* 資料所有者 */
prcdowndp       varchar2(10)      ,/* 資料所屬部門 */
prcdcrtid       varchar2(20)      ,/* 資料建立者 */
prcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
prcdcrtdt       timestamp(0)      ,/* 資料創建日 */
prcdmodid       varchar2(20)      ,/* 資料修改者 */
prcdmoddt       timestamp(0)      ,/* 最近修改日 */
prcd007       number(5,0)      /* 年度 */
);
alter table prcd_t add constraint prcd_pk primary key (prcdent,prcd001) enable validate;

create unique index prcd_pk on prcd_t (prcdent,prcd001);

grant select on prcd_t to tiptop;
grant update on prcd_t to tiptop;
grant delete on prcd_t to tiptop;
grant insert on prcd_t to tiptop;

exit;
