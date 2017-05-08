/* 
================================================================================
檔案代號:mhaf_t
檔案名稱:專櫃人員基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhaf_t
(
mhafent       number(5)      ,/* 企業編號 */
mhafsite       varchar2(10)      ,/* 營運組織 */
mhafunit       varchar2(10)      ,/* 制定組織 */
mhaf001       varchar2(20)      ,/* 人員編號 */
mhaf002       varchar2(40)      ,/* 姓名 */
mhaf003       varchar2(20)      ,/* 身份證號碼 */
mhaf004       varchar2(10)      ,/* 性別 */
mhaf005       varchar2(10)      ,/* 入職類型 */
mhaf006       varchar2(20)      ,/* 工牌號 */
mhaf007       date      ,/* 入職日期 */
mhaf008       date      ,/* 離職日期 */
mhaf009       varchar2(10)      ,/* 目前等級 */
mhaf010       varchar2(10)      ,/* 前期等級 */
mhaf011       varchar2(10)      ,/* 在職狀態 */
mhaf012       varchar2(10)      ,/* 專櫃編號 */
mhaf013       varchar2(10)      ,/* 品牌編號 */
mhaf014       varchar2(20)      ,/* 交款單單號 */
mhaf015       varchar2(20)      ,/* 工牌押金交款單號 */
mhaf016       varchar2(255)      ,/* 備註 */
mhafownid       varchar2(20)      ,/* 資料所有者 */
mhafowndp       varchar2(10)      ,/* 資料所有部門 */
mhafcrtid       varchar2(20)      ,/* 資料建立者 */
mhafcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhafcrtdt       timestamp(0)      ,/* 資料創建日 */
mhafmodid       varchar2(20)      ,/* 資料修改者 */
mhafmoddt       timestamp(0)      ,/* 最近修改日 */
mhafcnfid       varchar2(20)      ,/* 資料確認者 */
mhafcnfdt       timestamp(0)      ,/* 資料確認日 */
mhafstus       varchar2(10)      ,/* 狀態碼 */
mhaf017       varchar2(10)      /* 工牌押金交款方式 */
);
alter table mhaf_t add constraint mhaf_pk primary key (mhafent,mhaf001) enable validate;

create unique index mhaf_pk on mhaf_t (mhafent,mhaf001);

grant select on mhaf_t to tiptop;
grant update on mhaf_t to tiptop;
grant delete on mhaf_t to tiptop;
grant insert on mhaf_t to tiptop;

exit;
