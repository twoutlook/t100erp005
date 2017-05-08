/* 
================================================================================
檔案代號:mhal_t
檔案名稱:專櫃自用水電費資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhal_t
(
mhalent       number(5)      ,/* 企業編號 */
mhalsite       varchar2(10)      ,/* 營運組織 */
mhalunit       varchar2(10)      ,/* 應用組織 */
mhal001       number(10,0)      ,/* 會計期間 */
mhal002       varchar2(1)      ,/* 費用類型 */
mhal003       varchar2(1)      ,/* 來源類型 */
mhal004       varchar2(1)      ,/* 類型 */
mhal005       varchar2(10)      ,/* 專櫃編號 */
mhal006       varchar2(10)      ,/* 部門編號 */
mhal007       varchar2(20)      ,/* 電器編號 */
mhal008       date      ,/* 進場日期 */
mhal009       date      ,/* 撤櫃日期 */
mhal010       number(20,6)      ,/* 數量 */
mhal011       number(20,6)      ,/* 單價 */
mhal012       number(20,6)      ,/* 金額 */
mhal013       number(20,6)      ,/* 上月讀數 */
mhal014       number(20,6)      ,/* 本月讀數 */
mhal015       number(20,6)      ,/* 本月實際度數/噸數 */
mhal016       number(20,6)      ,/* 標準經營時數 */
mhal017       number(20,6)      ,/* 實際營業時數 */
mhal018       number(20,6)      ,/* 實際單價 */
mhal019       number(20,6)      ,/* 實際金額 */
mhal020       varchar2(10)      ,/* 品類編號 */
mhal021       varchar2(1)      ,/* 分攤原則 */
mhal022       varchar2(1)      ,/* 產生費用單否 */
mhal023       varchar2(20)      ,/* 費用單號 */
mhal024       varchar2(255)      ,/* 備註 */
mhalstus       varchar2(10)      ,/* 資料狀態碼 */
mhalownid       varchar2(20)      ,/* 資料所有者 */
mhalowndp       varchar2(10)      ,/* 資料所有部門 */
mhalcrtid       varchar2(20)      ,/* 資料建立者 */
mhalcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhalcrtdt       timestamp(0)      ,/* 資料創建日 */
mhalmodid       varchar2(20)      ,/* 資料修改者 */
mhalmoddt       timestamp(0)      ,/* 最近修改日 */
mhalcnfid       varchar2(20)      ,/* 資料確認者 */
mhalcnfdt       timestamp(0)      ,/* 資料確認日 */
mhal025       number(20,6)      ,/* 優惠度數 */
mhal026       number(20,6)      /* 優惠金額 */
);
alter table mhal_t add constraint mhal_pk primary key (mhalent,mhalsite,mhal001,mhal002,mhal004,mhal005,mhal007) enable validate;

create unique index mhal_pk on mhal_t (mhalent,mhalsite,mhal001,mhal002,mhal004,mhal005,mhal007);

grant select on mhal_t to tiptop;
grant update on mhal_t to tiptop;
grant delete on mhal_t to tiptop;
grant insert on mhal_t to tiptop;

exit;
