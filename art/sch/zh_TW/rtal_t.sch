/* 
================================================================================
檔案代號:rtal_t
檔案名稱:門店資源信息資料當
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rtal_t
(
rtalent       number(5)      ,/* 企業編號 */
rtalsite       varchar2(10)      ,/* 歸屬組織 */
rtalunit       varchar2(10)      ,/* 制定組織 */
rtal001       varchar2(10)      ,/* 資源編號 */
rtal002       varchar2(10)      ,/* 資源類型 */
rtal003       varchar2(10)      ,/* 計費單價週期 */
rtal004       varchar2(10)      ,/* 計費方式 */
rtal005       number(20,6)      ,/* 資源面積 */
rtal006       varchar2(1)      ,/* 單品管理否 */
rtal007       number(5,0)      ,/* 資源數量 */
rtal008       number(5,0)      ,/* 未租用數量 */
rtal009       varchar2(10)      ,/* 計價標準 */
rtal010       number(20,6)      ,/* 收費標準金額 */
rtal011       varchar2(20)      ,/* 費用編號 */
rtal012       varchar2(10)      ,/* 資源狀態 */
rtal013       date      ,/* 租用到期日 */
rtal014       varchar2(255)      ,/* 備註 */
rtal015       varchar2(80)      ,/* 資源位置 */
rtalownid       varchar2(20)      ,/* 資料所有者 */
rtalowndp       varchar2(10)      ,/* 資料所屬部門 */
rtalcrtid       varchar2(20)      ,/* 資料建立者 */
rtalcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtalcrtdt       timestamp(0)      ,/* 資料創建日 */
rtalmodid       varchar2(20)      ,/* 資料修改者 */
rtalmoddt       timestamp(0)      ,/* 最近修改日 */
rtalstus       varchar2(10)      /* 狀態碼 */
);
alter table rtal_t add constraint rtal_pk primary key (rtalent,rtalsite,rtal001,rtal002) enable validate;

create unique index rtal_pk on rtal_t (rtalent,rtalsite,rtal001,rtal002);

grant select on rtal_t to tiptop;
grant update on rtal_t to tiptop;
grant delete on rtal_t to tiptop;
grant insert on rtal_t to tiptop;

exit;
