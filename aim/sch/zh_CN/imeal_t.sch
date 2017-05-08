/* 
================================================================================
檔案代號:imeal_t
檔案名稱:料件特徵群組單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imeal_t
(
imealent       number(5)      ,/* 企業編號 */
imeal001       varchar2(40)      ,/* 特徵群組代碼 */
imeal002       varchar2(6)      ,/* 語言別 */
imeal003       varchar2(500)      ,/* 說明 */
imeal004       varchar2(10)      /* 助記碼 */
);
alter table imeal_t add constraint imeal_pk primary key (imealent,imeal001,imeal002) enable validate;

create unique index imeal_pk on imeal_t (imealent,imeal001,imeal002);

grant select on imeal_t to tiptop;
grant update on imeal_t to tiptop;
grant delete on imeal_t to tiptop;
grant insert on imeal_t to tiptop;

exit;
