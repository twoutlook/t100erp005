/* 
================================================================================
檔案代號:dzdg_t
檔案名稱:維度分類關係檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdg_t
(
dzdgstus       varchar2(10)      ,/* 狀態碼 */
dzdg001       number(5,0)      ,/* 維度編號 */
dzdg002       varchar2(10)      ,/* 分類編號 */
dzdg003       varchar2(1)      ,/* 標準否 */
dzdg004       varchar2(1)      ,/* 更新關鍵詞否 */
dzdg005       varchar2(1)      ,/* no use（flag類預留字段） */
dzdg006       varchar2(1)      ,/* no use（flag類預留字段） */
dzdg007       varchar2(1)      ,/* no use（flag類預留字段） */
dzdg008       varchar2(1)      ,/* no use（flag類預留字段） */
dzdg009       varchar2(1)      ,/* no use（flag類預留字段） */
dzdg010       number(10,0)      ,/* no use（數值型預留字段） */
dzdg011       number(10,0)      ,/* no use（數值型預留字段） */
dzdg012       number(10,0)      ,/* no use（數值型預留字段） */
dzdg013       varchar2(40)      ,/* no use(自定欄位 文字) */
dzdg014       varchar2(40)      ,/* no use(自定欄位 文字) */
dzdgownid       varchar2(20)      ,/* 資料所有者 */
dzdgowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdgcrtid       varchar2(20)      ,/* 資料建立者 */
dzdgcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdgcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdgmodid       varchar2(20)      ,/* 資料修改者 */
dzdgmoddt       timestamp(0)      ,/* 最近修改日 */
dzdgcnfid       varchar2(20)      ,/* 資料確認者 */
dzdgcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzdg_t add constraint dzdg_pk primary key (dzdg001,dzdg002) enable validate;

create unique index dzdg_pk on dzdg_t (dzdg001,dzdg002);

grant select on dzdg_t to tiptop;
grant update on dzdg_t to tiptop;
grant delete on dzdg_t to tiptop;
grant insert on dzdg_t to tiptop;

exit;
