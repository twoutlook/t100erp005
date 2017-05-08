/* 
================================================================================
檔案代號:glfdl_t
檔案名稱:財務指標公式設定維護單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glfdl_t
(
glfdlent       number(5)      ,/* 企業編號 */
glfdl001       varchar2(10)      ,/* 報表結構編號 */
glfdl002       varchar2(6)      ,/* 語言別 */
glfdl003       varchar2(500)      ,/* 財務分析指標說明 */
glfdl004       varchar2(10)      /* 指標釋義 */
);
alter table glfdl_t add constraint glfdl_pk primary key (glfdlent,glfdl001,glfdl002) enable validate;

create unique index glfdl_pk on glfdl_t (glfdlent,glfdl001,glfdl002);

grant select on glfdl_t to tiptop;
grant update on glfdl_t to tiptop;
grant delete on glfdl_t to tiptop;
grant insert on glfdl_t to tiptop;

exit;
