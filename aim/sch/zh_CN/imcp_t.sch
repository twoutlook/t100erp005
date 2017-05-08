/* 
================================================================================
檔案代號:imcp_t
檔案名稱:料件據點關務分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcp_t
(
imcpent       number(5)      ,/* 企業編號 */
imcpsite       varchar2(10)      ,/* 營運據點 */
imcp011       varchar2(10)      ,/* 關務分群 */
imcp012       varchar2(1)      ,/* 保稅否 */
imcp013       varchar2(10)      ,/* 保稅料件型態 */
imcp014       varchar2(10)      ,/* 保稅料區分 */
imcp021       varchar2(10)      ,/* 保稅統計類別 */
imcp022       number(20,6)      ,/* 保稅年度盤差容許率 */
imcp023       varchar2(20)      ,/* 稅則編號 */
imcp024       number(5,2)      ,/* 保稅應補稅稅率 */
imcp025       number(20,6)      ,/* 保稅單價 */
imcp031       number(20,6)      ,/* 推廣貿易服務費 */
imcp032       varchar2(40)      ,/* 稅則 */
imcp033       varchar2(30)      ,/* 帳卡編號 */
imcp034       varchar2(1)      ,/* 受託加工成品 */
imcpownid       varchar2(20)      ,/* 資料所有者 */
imcpowndp       varchar2(10)      ,/* 資料所屬部門 */
imcpcrtid       varchar2(20)      ,/* 資料建立者 */
imcpcrtdp       varchar2(10)      ,/* 資料建立部門 */
imcpcrtdt       timestamp(0)      ,/* 資料創建日 */
imcpmodid       varchar2(20)      ,/* 資料修改者 */
imcpmoddt       timestamp(0)      ,/* 最近修改日 */
imcpstus       varchar2(10)      /* 狀態碼 */
);
alter table imcp_t add constraint imcp_pk primary key (imcpent,imcpsite,imcp011) enable validate;

create unique index imcp_pk on imcp_t (imcpent,imcpsite,imcp011);

grant select on imcp_t to tiptop;
grant update on imcp_t to tiptop;
grant delete on imcp_t to tiptop;
grant insert on imcp_t to tiptop;

exit;
