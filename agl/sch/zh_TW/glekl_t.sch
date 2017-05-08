/* 
================================================================================
檔案代號:glekl_t
檔案名稱:合併現金流量表間接法人工輸入金額設定資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glekl_t
(
gleklent       number(5)      ,/* 企業編號 */
gleklld       varchar2(5)      ,/* 合併帳別 */
glekl001       varchar2(10)      ,/* 上層公司 */
glekl002       number(5,0)      ,/* 年度 */
glekl003       number(5,0)      ,/* 期別 */
glekl004       varchar2(10)      ,/* 群組代碼 */
glekl005       varchar2(24)      ,/* 科目編號 */
glekl006       number(10,0)      ,/* 項次 */
glekl007       varchar2(6)      ,/* 語言別 */
glekl008       varchar2(500)      ,/* 說明 */
glekl009       varchar2(10)      /* 助記碼 */
);
alter table glekl_t add constraint glekl_pk primary key (gleklent,gleklld,glekl001,glekl002,glekl003,glekl004,glekl005,glekl006,glekl007) enable validate;

create unique index glekl_pk on glekl_t (gleklent,gleklld,glekl001,glekl002,glekl003,glekl004,glekl005,glekl006,glekl007);

grant select on glekl_t to tiptop;
grant update on glekl_t to tiptop;
grant delete on glekl_t to tiptop;
grant insert on glekl_t to tiptop;

exit;
