/* 
================================================================================
檔案代號:xcbg_t
檔案名稱:按期在製成套發料套數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcbg_t
(
xcbgent       number(5)      ,/* 企業編號 */
xcbgcomp       varchar2(10)      ,/* 法人組織 */
xcbg001       number(5,0)      ,/* 年度 */
xcbg002       number(5,0)      ,/* 期別 */
xcbg003       varchar2(20)      ,/* 在制單號 */
xcbg004       number(20,6)      ,/* 成套數量 */
xcbg005       varchar2(10)      ,/* 工單生產單位 */
xcbg006       number(20,6)      /* 生產單位對成本單位轉換率 */
);
alter table xcbg_t add constraint xcbg_pk primary key (xcbgent,xcbgcomp,xcbg001,xcbg002,xcbg003) enable validate;

create unique index xcbg_pk on xcbg_t (xcbgent,xcbgcomp,xcbg001,xcbg002,xcbg003);

grant select on xcbg_t to tiptop;
grant update on xcbg_t to tiptop;
grant delete on xcbg_t to tiptop;
grant insert on xcbg_t to tiptop;

exit;
