/* 
================================================================================
檔案代號:wsae_t
檔案名稱:營運據點簽核設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsae_t
(
wsaeent       number(5)      ,/* 企業編號 */
wsae001       varchar2(10)      ,/* 營運據點 */
wsae002       varchar2(1)      ,/* 簽核否 */
wsae003       varchar2(1)      ,/* 自動確認否 */
wsae004       varchar2(1)      ,/* no use */
wsae005       varchar2(100)      ,/* no use */
wsaeownid       varchar2(20)      ,/* 資料所有者 */
wsaeowndp       varchar2(10)      ,/* 資料所屬部門 */
wsaecrtid       varchar2(20)      ,/* 資料建立者 */
wsaecrtdp       varchar2(10)      ,/* 資料建立部門 */
wsaecrtdt       timestamp(0)      ,/* 資料創建日 */
wsaemodid       varchar2(20)      ,/* 資料修改者 */
wsaemoddt       timestamp(0)      ,/* 最近修改日 */
wsaestus       varchar2(10)      /* 狀態碼 */
);
alter table wsae_t add constraint wsae_pk primary key (wsaeent,wsae001) enable validate;

create unique index wsae_pk on wsae_t (wsaeent,wsae001);

grant select on wsae_t to tiptop;
grant update on wsae_t to tiptop;
grant delete on wsae_t to tiptop;
grant insert on wsae_t to tiptop;

exit;
