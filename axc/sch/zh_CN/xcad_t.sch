/* 
================================================================================
檔案代號:xcad_t
檔案名稱:成本BOM主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcad_t
(
xcadent       number(5)      ,/* 企業編號 */
xcadownid       varchar2(20)      ,/* 資料所有者 */
xcadowndp       varchar2(10)      ,/* 資料所屬部門 */
xcadcrtid       varchar2(20)      ,/* 資料建立者 */
xcadcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcadcrtdt       timestamp(0)      ,/* 資料創建日 */
xcadmodid       varchar2(20)      ,/* 資料修改者 */
xcadmoddt       timestamp(0)      ,/* 最近修改日 */
xcadstus       varchar2(10)      ,/* 狀態碼 */
xcadsite       varchar2(10)      ,/* 營運據點 */
xcad001       varchar2(10)      ,/* 版本 */
xcad002       varchar2(40)      ,/* 主件料號 */
xcadseq       number(10,0)      ,/* 項次 */
xcad003       varchar2(40)      ,/* 元件料號 */
xcad004       number(20,6)      ,/* 組成用量 */
xcad005       number(20,6)      ,/* 主件底數 */
xcad006       number(20,6)      ,/* 變動損耗率 */
xcad007       number(20,6)      ,/* 固定損耗量 */
xcad008       number(20,6)      ,/* 損耗批量 */
xcad009       varchar2(10)      ,/* 作業編號 */
xcad010       varchar2(10)      ,/* 作業序 */
xcad011       varchar2(10)      ,/* 部位編號 */
xcad012       timestamp(0)      ,/* 生效日期 */
xcad013       timestamp(0)      /* 失效日期 */
);
alter table xcad_t add constraint xcad_pk primary key (xcadent,xcad001,xcad002,xcadseq) enable validate;

create unique index xcad_pk on xcad_t (xcadent,xcad001,xcad002,xcadseq);

grant select on xcad_t to tiptop;
grant update on xcad_t to tiptop;
grant delete on xcad_t to tiptop;
grant insert on xcad_t to tiptop;

exit;
