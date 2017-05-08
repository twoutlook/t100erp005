/* 
================================================================================
檔案代號:imbi_t
檔案名稱:料件申請料號據點資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table imbi_t
(
imbient       number(5)      ,/* 企業編號 */
imbisite       varchar2(10)      ,/* 營運據點 */
imbi000       varchar2(10)      ,/* 申請類別 */
imbi001       varchar2(40)      ,/* 料件編號 */
imbi038       date      ,/* 開帳呆滯日期 */
imbidocno       varchar2(20)      ,/* 申請單號 */
imbiownid       varchar2(10)      ,/* 資料所有者 */
imbiowndp       varchar2(10)      ,/* 資料所屬部門 */
imbicrtid       varchar2(10)      ,/* 資料建立者 */
imbicrtdt       date      ,/* 資料創建日 */
imbicrtdp       varchar2(10)      ,/* 資料建立部門 */
imbimodid       varchar2(10)      ,/* 資料修改者 */
imbimoddt       date      ,/* 最近修改日 */
imbicnfid       varchar2(10)      ,/* 資料確認者 */
imbicnfdt       date      ,/* 資料確認日 */
imbipstid       varchar2(10)      ,/* 資料過帳者 */
imbipstdt       date      /* 資料過帳日 */
);
alter table imbi_t add constraint imbi_pk primary key (imbient,imbisite,imbidocno) enable validate;

create  index imbi_01 on imbi_t (imbi001);

grant select on imbi_t to tiptop;
grant update on imbi_t to tiptop;
grant delete on imbi_t to tiptop;
grant insert on imbi_t to tiptop;

exit;
