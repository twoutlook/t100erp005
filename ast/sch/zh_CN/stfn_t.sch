/* 
================================================================================
檔案代號:stfn_t
檔案名稱:聯營合同模板主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stfn_t
(
stfnent       number(5)      ,/* 企業編號 */
stfn001       varchar2(10)      ,/* 模板編號 */
stfn002       varchar2(10)      ,/* 經營方式 */
stfn003       varchar2(10)      ,/* 收付款方式 */
stfn004       varchar2(10)      ,/* 結算方式 */
stfn005       varchar2(10)      ,/* 結算類型 */
stfn006       varchar2(10)      ,/* 幣別 */
stfnunit       varchar2(10)      ,/* 應用組織 */
stfnstus       varchar2(10)      ,/* 狀態碼 */
stfn007       varchar2(10)      ,/* 管理方式 */
stfn008       varchar2(10)      ,/* 業態 */
stfnsite       varchar2(10)      ,/* 營運據點 */
stfnownid       varchar2(20)      ,/* 資料所屬者 */
stfnowndp       varchar2(10)      ,/* 資料所屬部門 */
stfncrtid       varchar2(20)      ,/* 資料建立者 */
stfncrtdp       varchar2(10)      ,/* 資料建立部門 */
stfncrtdt       timestamp(0)      ,/* 資料創建日 */
stfnmodid       varchar2(20)      ,/* 資料修改者 */
stfnmoddt       timestamp(0)      ,/* 最近修改日 */
stfncnfid       varchar2(20)      ,/* 資料確認者 */
stfncnfdt       timestamp(0)      ,/* 資料確認日 */
stfn009       varchar2(1)      /* 含發票否 */
);
alter table stfn_t add constraint stfn_pk primary key (stfnent,stfn001) enable validate;

create unique index stfn_pk on stfn_t (stfnent,stfn001);

grant select on stfn_t to tiptop;
grant update on stfn_t to tiptop;
grant delete on stfn_t to tiptop;
grant insert on stfn_t to tiptop;

exit;
