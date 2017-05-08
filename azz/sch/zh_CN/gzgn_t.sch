/* 
================================================================================
檔案代號:gzgn_t
檔案名稱:報表直接送印設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgn_t
(
gzgn001       varchar2(20)      ,/* 使用者編號 */
gzgn002       varchar2(10)      ,/* 職能角色編號 */
gzgn003       varchar2(20)      ,/* 作業編號 */
gzgn004       varchar2(40)      ,/* 報表樣板名稱 */
gzgn005       varchar2(1)      ,/* 輸出種類 */
gzgn006       varchar2(255)      ,/* 印表機名稱 */
gzgn007       number(10,0)      ,/* 列印份數 */
gzgn008       varchar2(80)      ,/* 印表機參數 */
gzgn009       varchar2(1)      ,/* 立即列印否 */
gzgn010       varchar2(80)      ,/* Client端IP */
gzgnstus       varchar2(10)      ,/* 狀態碼 */
gzgnownid       varchar2(20)      ,/* 資料所有者 */
gzgnowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgncrtid       varchar2(20)      ,/* 資料建立者 */
gzgncrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgncrtdt       timestamp(0)      ,/* 資料創建日 */
gzgnmodid       varchar2(20)      ,/* 資料修改者 */
gzgnmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzgn_t add constraint gzgn_pk primary key (gzgn001,gzgn002,gzgn003,gzgn004,gzgn010) enable validate;

create unique index gzgn_pk on gzgn_t (gzgn001,gzgn002,gzgn003,gzgn004,gzgn010);

grant select on gzgn_t to tiptop;
grant update on gzgn_t to tiptop;
grant delete on gzgn_t to tiptop;
grant insert on gzgn_t to tiptop;

exit;
