/* 
================================================================================
檔案代號:glak_t
檔案名稱:會計科目設限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glak_t
(
glakent       number(5)      ,/* 企業編號 */
glakownid       varchar2(20)      ,/* 資料所有者 */
glakowndp       varchar2(10)      ,/* 資料所屬部門 */
glakcrtid       varchar2(20)      ,/* 資料建立者 */
glakcrtdp       varchar2(10)      ,/* 資料建立部門 */
glakcrtdt       timestamp(0)      ,/* 資料創建日 */
glakmodid       varchar2(20)      ,/* 資料修改者 */
glakmoddt       timestamp(0)      ,/* 最近修改日 */
glakstus       varchar2(10)      ,/* 狀態碼 */
glakld       varchar2(5)      ,/* 帳別 */
glak001       varchar2(10)      ,/* 固定核算項 */
glak002       varchar2(1)      ,/* 正負向表列 */
glak003       varchar2(24)      ,/* 科目編號 */
glak004       varchar2(30)      /* 固定核算項值 */
);
alter table glak_t add constraint glak_pk primary key (glakent,glakld,glak001,glak003,glak004) enable validate;

create unique index glak_pk on glak_t (glakent,glakld,glak001,glak003,glak004);

grant select on glak_t to tiptop;
grant update on glak_t to tiptop;
grant delete on glak_t to tiptop;
grant insert on glak_t to tiptop;

exit;
