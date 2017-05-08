/* 
================================================================================
檔案代號:pmaq_t
檔案名稱:採購替代檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmaq_t
(
pmaqent       number(5)      ,/* 企業編號 */
pmaqsite       varchar2(10)      ,/* 營運據點 */
pmaq001       varchar2(10)      ,/* 供應商編號 */
pmaq002       varchar2(40)      ,/* 料件編號 */
pmaq003       varchar2(40)      ,/* 可替代料號 */
pmaq004       varchar2(10)      ,/* 替代類別 */
pmaqownid       varchar2(20)      ,/* 資料所有者 */
pmaqowndp       varchar2(10)      ,/* 資料所屬部門 */
pmaqcrtid       varchar2(20)      ,/* 資料建立者 */
pmaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmaqcrtdt       timestamp(0)      ,/* 資料創建日 */
pmaqmodid       varchar2(20)      ,/* 資料修改者 */
pmaqmoddt       timestamp(0)      ,/* 最近修改日 */
pmaqstus       varchar2(10)      ,/* 狀態碼 */
pmaq005       varchar2(256)      ,/* 產品特徵 */
pmaq006       varchar2(256)      /* 可替代產品特徵 */
);
alter table pmaq_t add constraint pmaq_pk primary key (pmaqent,pmaqsite,pmaq001,pmaq002,pmaq003,pmaq004,pmaq005) enable validate;

create unique index pmaq_pk on pmaq_t (pmaqent,pmaqsite,pmaq001,pmaq002,pmaq003,pmaq004,pmaq005);

grant select on pmaq_t to tiptop;
grant update on pmaq_t to tiptop;
grant delete on pmaq_t to tiptop;
grant insert on pmaq_t to tiptop;

exit;
