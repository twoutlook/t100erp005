/* 
================================================================================
檔案代號:xcai_t
檔案名稱:標準成本_資源費用明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcai_t
(
xcaient       number(5)      ,/* 企業編號 */
xcaisite       varchar2(10)      ,/* 營運據點 */
xcaicomp       varchar2(10)      ,/* 法人組織 */
xcai001       varchar2(80)      ,/* 標準成本分類 */
xcai002       date      ,/* 生效日期 */
xcai003       date      ,/* 失效日期 */
xcai004       varchar2(40)      ,/* 最終件料號 */
xcaiseq       number(10,0)      ,/* 項次 */
xcai100       varchar2(40)      ,/* 製程料號 */
xcai101       varchar2(10)      ,/* 製程編號 */
xcai102       varchar2(10)      ,/* 作業編號 */
xcai103       varchar2(10)      ,/* 製程站 */
xcai104       varchar2(10)      ,/* 資源編號 */
xcai105       number(20,6)      ,/* 資源單位成本 */
xcai106       number(20,6)      ,/* 資源耗用量 */
xcai107       number(20,6)      ,/* 資源成本 */
xcai108       varchar2(1)      ,/* 委外否 */
xcai109       number(10,0)      ,/* 製程料號項次 */
xcai201       varchar2(10)      ,/* 資源歸屬主成本要素 */
xcai202       varchar2(10)      ,/* 資源歸屬次成本要素 */
xcaiownid       varchar2(20)      ,/* 資料所有者 */
xcaiowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaicrtid       varchar2(20)      ,/* 資料建立者 */
xcaicrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaicrtdt       timestamp(0)      ,/* 資料創建日 */
xcaimodid       varchar2(20)      ,/* 資料修改者 */
xcaimoddt       timestamp(0)      ,/* 最近修改日 */
xcaistus       varchar2(10)      /* 狀態碼 */
);
alter table xcai_t add constraint xcai_pk primary key (xcaient,xcaisite,xcai001,xcai002,xcai004,xcaiseq) enable validate;

create unique index xcai_pk on xcai_t (xcaient,xcaisite,xcai001,xcai002,xcai004,xcaiseq);

grant select on xcai_t to tiptop;
grant update on xcai_t to tiptop;
grant delete on xcai_t to tiptop;
grant insert on xcai_t to tiptop;

exit;
