/* 
================================================================================
檔案代號:xcaj_t
檔案名稱:物料標準成本要素明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcaj_t
(
xcajent       number(5)      ,/* 企業編號 */
xcajsite       varchar2(10)      ,/* 營運據點 */
xcajcomp       varchar2(10)      ,/* 法人組織 */
xcaj001       varchar2(80)      ,/* 標準成本分類 */
xcaj002       date      ,/* 生效日期 */
xcaj003       date      ,/* 失效日期 */
xcaj004       varchar2(40)      ,/* 物料編碼 */
xcaj005       varchar2(10)      ,/* 次成本要素 */
xcaj010       varchar2(10)      ,/* 版本 */
xcaj011       varchar2(10)      ,/* 幣別 */
xcaj102       number(20,6)      ,/* 標準單位成本 */
xcajownid       varchar2(20)      ,/* 資料所有者 */
xcajowndp       varchar2(10)      ,/* 資料所屬部門 */
xcajcrtid       varchar2(20)      ,/* 資料建立者 */
xcajcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcajcrtdt       timestamp(0)      ,/* 資料創建日 */
xcajmodid       varchar2(20)      ,/* 資料修改者 */
xcajmoddt       timestamp(0)      ,/* 最近修改日 */
xcajstus       varchar2(10)      /* 狀態碼 */
);
alter table xcaj_t add constraint xcaj_pk primary key (xcajent,xcajsite,xcaj001,xcaj002,xcaj004,xcaj005) enable validate;

create unique index xcaj_pk on xcaj_t (xcajent,xcajsite,xcaj001,xcaj002,xcaj004,xcaj005);

grant select on xcaj_t to tiptop;
grant update on xcaj_t to tiptop;
grant delete on xcaj_t to tiptop;
grant insert on xcaj_t to tiptop;

exit;
