/* 
================================================================================
檔案代號:infc_t
檔案名稱:货架资料档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table infc_t
(
infcent       number(5)      ,/* 企業代碼 */
infcsite       varchar2(10)      ,/* 營運據點 */
infc001       varchar2(10)      ,/* 貨架編號 */
infc002       varchar2(10)      ,/* 貨架類型 */
infc003       number(5,0)      ,/* 層數 */
infc004       number(5,0)      ,/* 列數 */
infc005       number(15,3)      ,/* 長度 */
infc006       number(15,3)      ,/* 寬度 */
infc007       number(15,3)      ,/* 高度 */
infc008       varchar2(80)      ,/* 備註 */
infcownid       varchar2(20)      ,/* 資料所有者 */
infcowndp       varchar2(10)      ,/* 資料所有部門 */
infccrtid       varchar2(20)      ,/* 資料建立者 */
infccrtdp       varchar2(10)      ,/* 資料建立部門 */
infccrtdt       timestamp(0)      ,/* 資料創建日 */
infcmodid       varchar2(20)      ,/* 資料修改者 */
infcmoddt       timestamp(0)      ,/* 最近修改日 */
infcstus       varchar2(10)      ,/* 狀態碼 */
infc009       varchar2(10)      /* 管理品類 */
);
alter table infc_t add constraint infc_pk primary key (infcent,infcsite,infc001) enable validate;

create unique index infc_pk on infc_t (infcent,infcsite,infc001);

grant select on infc_t to tiptop;
grant update on infc_t to tiptop;
grant delete on infc_t to tiptop;
grant insert on infc_t to tiptop;

exit;
