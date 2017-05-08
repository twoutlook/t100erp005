/* 
================================================================================
檔案代號:oojk_t
檔案名稱:報表簽核關卡設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojk_t
(
oojkstus       varchar2(10)      ,/* 狀態碼 */
oojk001       varchar2(10)      ,/* 簽核代號 */
oojk002       number(10,0)      ,/* 序號 */
oojk003       varchar2(6)      ,/* 語言別 */
oojk004       varchar2(80)      ,/* 職稱 */
oojk005       varchar2(1)      ,/* 客制 */
oojkownid       varchar2(20)      ,/* 資料所有者 */
oojkowndp       varchar2(10)      ,/* 資料所屬部門 */
oojkcrtid       varchar2(20)      ,/* 資料建立者 */
oojkcrtdp       varchar2(10)      ,/* 資料建立部門 */
oojkcrtdt       timestamp(0)      ,/* 資料創建日 */
oojkmodid       varchar2(20)      ,/* 資料修改者 */
oojkmoddt       timestamp(0)      /* 最近修改日 */
);
alter table oojk_t add constraint oojk_pk primary key (oojk001,oojk002,oojk003) enable validate;

create unique index oojk_pk on oojk_t (oojk001,oojk002,oojk003);

grant select on oojk_t to tiptop;
grant update on oojk_t to tiptop;
grant delete on oojk_t to tiptop;
grant insert on oojk_t to tiptop;

exit;
