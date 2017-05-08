/* 
================================================================================
檔案代號:mhak_t
檔案名稱:組織水電單價檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhak_t
(
mhakent       number(5)      ,/* 企業編號 */
mhaksite       varchar2(10)      ,/* 營運組織 */
mhakunit       varchar2(10)      ,/* 應用組織 */
mhak001       number(10,0)      ,/* 會計期間 */
mhak002       number(20,6)      ,/* 電費單價 */
mhak003       number(20,6)      ,/* 水費單價 */
mhak004       number(20,6)      ,/* 實際電費單價 */
mhak005       number(20,6)      ,/* 實際水費單價 */
mhak006       number(20,6)      ,/* 實際電費總金額 */
mhak007       number(20,6)      ,/* 實際電費總度數 */
mhak008       number(20,6)      ,/* 實際水費總金額 */
mhak009       number(20,6)      ,/* 實際水費總噸數 */
mhak010       varchar2(255)      ,/* 備註 */
mhakstus       varchar2(10)      ,/* 資料狀態碼 */
mhakownid       varchar2(20)      ,/* 資料所有者 */
mhakowndp       varchar2(10)      ,/* 資料所屬部門 */
mhakcrtid       varchar2(20)      ,/* 資料建立者 */
mhakcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhakcrtdt       timestamp(0)      ,/* 資料創建日 */
mhakmodid       varchar2(20)      ,/* 資料修改者 */
mhakmoddt       timestamp(0)      ,/* 最近修改日 */
mhakcnfid       varchar2(20)      ,/* 資料確認者 */
mhakcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table mhak_t add constraint mhak_pk primary key (mhakent,mhaksite,mhak001) enable validate;

create unique index mhak_pk on mhak_t (mhakent,mhaksite,mhak001);

grant select on mhak_t to tiptop;
grant update on mhak_t to tiptop;
grant delete on mhak_t to tiptop;
grant insert on mhak_t to tiptop;

exit;
