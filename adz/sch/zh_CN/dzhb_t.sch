/* 
================================================================================
檔案代號:dzhb_t
檔案名稱:資料表欄位檔簽出備份檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzhb_t
(
dzhb000       varchar2(40)      ,/* 簽出GUID */
dzhb001       varchar2(15)      ,/* table代號 */
dzhb002       varchar2(20)      ,/* 欄位代號 */
dzhb003       varchar2(80)      ,/* 欄位名稱 */
dzhb004       varchar2(1)      ,/* primary key */
dzhb005       varchar2(1)      ,/* 必要欄位 */
dzhb006       varchar2(4)      ,/* 欄位屬性 */
dzhb007       varchar2(20)      ,/* 資料型態(暫存) */
dzhb008       varchar2(10)      ,/* 欄位長度(暫存) */
dzhb012       varchar2(100)      ,/* 預設值 */
dzhb021       number(10,0)      ,/* 欄位序號 */
dzhb022       varchar2(100)      ,/* 欄位類別定義代號 */
dzhb023       number(10,0)      ,/* 序號欄位號碼 */
dzhb024       varchar2(500)      ,/* 欄位說明 */
dzhb027       varchar2(80)      ,/* 外部轉入識別碼 */
dzhb028       varchar2(1)      ,/* 異動確認碼 */
dzhb029       varchar2(1)      ,/* 客制標示 */
dzhb030       varchar2(1)      ,/* 原始客制標示 */
dzhb031       varchar2(1)      ,/* 出貨標示 */
dzhbstus       varchar2(10)      ,/* 狀態碼 */
dzhbownid       varchar2(20)      ,/* 資料所有者 */
dzhbowndp       varchar2(10)      ,/* 資料所屬部門 */
dzhbcrtid       varchar2(20)      ,/* 資料建立者 */
dzhbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzhbcrtdt       timestamp(0)      ,/* 資料創建日 */
dzhbmodid       varchar2(20)      ,/* 資料修改者 */
dzhbmoddt       timestamp(0)      ,/* 最近修改日 */
dzhbcnfid       varchar2(20)      ,/* 資料確認者 */
dzhbcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzhb_t add constraint dzhb_pk primary key (dzhb000,dzhb001,dzhb002) enable validate;

create unique index dzhb_pk on dzhb_t (dzhb000,dzhb001,dzhb002);

grant select on dzhb_t to tiptop;
grant update on dzhb_t to tiptop;
grant delete on dzhb_t to tiptop;
grant insert on dzhb_t to tiptop;

exit;
