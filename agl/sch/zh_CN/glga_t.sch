/* 
================================================================================
檔案代號:glga_t
檔案名稱:傳票預覽單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glga_t
(
glgaent       number(5)      ,/* 企業代碼 */
glgaownid       varchar2(20)      ,/* 資料所有者 */
glgaowndp       varchar2(10)      ,/* 資料所屬部門 */
glgacrtid       varchar2(20)      ,/* 資料建立者 */
glgacrtdp       varchar2(10)      ,/* 資料建立部門 */
glgacrtdt       timestamp(0)      ,/* 資料創建日 */
glgamodid       varchar2(20)      ,/* 資料修改者 */
glgamoddt       timestamp(0)      ,/* 最近修改日 */
glgacnfid       varchar2(20)      ,/* 資料確認者 */
glgacnfdt       timestamp(0)      ,/* 資料確認日 */
glgapstid       varchar2(20)      ,/* 資料過帳者 */
glgapstdt       timestamp(0)      ,/* 資料過帳日 */
glgastus       varchar2(10)      ,/* 狀態碼 */
glgald       varchar2(5)      ,/* 帳別(套)編號 */
glgacomp       varchar2(10)      ,/* 營運據點(法人) */
glgadocno       varchar2(20)      ,/* 單據編號 */
glgadocdt       date      ,/* 單據日期 */
glga100       varchar2(4)      ,/* 系統別 */
glga101       varchar2(10)      ,/* 類別 */
glga002       number(5,0)      ,/* 會計年度 */
glga003       number(5,0)      ,/* 會計季別 */
glga004       number(5,0)      ,/* 會計期別 */
glga005       number(5,0)      ,/* 會計週別 */
glga006       number(5,0)      ,/* 附件張數 */
glga007       varchar2(20)      ,/* 傳票號碼 */
glga008       date      ,/* 傳票日期 */
glga009       varchar2(1)      /* 統計更新否 */
);
alter table glga_t add constraint glga_pk primary key (glgaent,glgald,glgadocno,glga100,glga101) enable validate;

create unique index glga_pk on glga_t (glgaent,glgald,glgadocno,glga100,glga101);

grant select on glga_t to tiptop;
grant update on glga_t to tiptop;
grant delete on glga_t to tiptop;
grant insert on glga_t to tiptop;

exit;
