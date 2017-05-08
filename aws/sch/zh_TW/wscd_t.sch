/* 
================================================================================
檔案代號:wscd_t
檔案名稱:ETL匯入excel樣版
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wscd_t
(
wscdent       number(5)      ,/* 企業代碼 */
wscd001       varchar2(256)      ,/* 檔案名稱 */
wscd002       number(10,0)      ,/* 版次 */
wscd003       blob      ,/* 檔案內容 */
wscdcrtid       varchar2(20)      ,/* 資料建立者 */
wscdcrtdt       timestamp(0)      /* 資料創建日 */
);
alter table wscd_t add constraint wscd_pk primary key (wscdent,wscd001,wscd002) enable validate;

create unique index wscd_pk on wscd_t (wscdent,wscd001,wscd002);

grant select on wscd_t to tiptop;
grant update on wscd_t to tiptop;
grant delete on wscd_t to tiptop;
grant insert on wscd_t to tiptop;

exit;
