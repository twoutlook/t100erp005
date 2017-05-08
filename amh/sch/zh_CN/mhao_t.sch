/* 
================================================================================
檔案代號:mhao_t
檔案名稱:電話費資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhao_t
(
mhaoent       number(5)      ,/* 企業編號 */
mhaosite       varchar2(10)      ,/* 營運組織 */
mhaounit       varchar2(10)      ,/* 應用組織 */
mhao001       number(10,0)      ,/* 會計期間 */
mhao002       varchar2(20)      ,/* 電話號碼 */
mhao003       varchar2(10)      ,/* 部門編號 */
mhao004       varchar2(1)      ,/* 使用類型 */
mhao005       varchar2(10)      ,/* 專櫃編號 */
mhao006       varchar2(10)      ,/* 供應商編號 */
mhao007       number(20,6)      ,/* 金額 */
mhao008       varchar2(1)      ,/* 價款類別 */
mhao009       varchar2(10)      ,/* 費用代碼 */
mhao010       varchar2(1)      ,/* 產生費用單否 */
mhao011       varchar2(20)      ,/* 費用單號 */
mhao012       varchar2(255)      ,/* 備註 */
mhaostus       varchar2(10)      ,/* 資料狀態碼 */
mhaoownid       varchar2(20)      ,/* 資料所有者 */
mhaoowndp       varchar2(10)      ,/* 資料所屬部門 */
mhaocrtid       varchar2(20)      ,/* 資料建立者 */
mhaocrtdp       varchar2(10)      ,/* 資料建立部門 */
mhaocrtdt       timestamp(0)      ,/* 資料創建日 */
mhaomodid       varchar2(20)      ,/* 資料修改者 */
mhaomoddt       timestamp(0)      ,/* 最近修改日 */
mhaocnfid       varchar2(20)      ,/* 資料確認者 */
mhaocnfdt       timestamp(0)      /* 資料確認日 */
);
alter table mhao_t add constraint mhao_pk primary key (mhaoent,mhaosite,mhao001,mhao002) enable validate;

create unique index mhao_pk on mhao_t (mhaoent,mhaosite,mhao001,mhao002);

grant select on mhao_t to tiptop;
grant update on mhao_t to tiptop;
grant delete on mhao_t to tiptop;
grant insert on mhao_t to tiptop;

exit;
