/* 
================================================================================
檔案代號:ooefl_t
檔案名稱:組織基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooefl_t
(
ooeflent       number(5)      ,/* 企業編號 */
ooefl001       varchar2(10)      ,/* 組織編號 */
ooefl002       varchar2(6)      ,/* 語言別 */
ooefl003       varchar2(500)      ,/* 說明(簡稱) */
ooefl004       varchar2(500)      ,/* 說明(對內全稱) */
ooefl005       varchar2(10)      ,/* 助記碼 */
ooefl006       varchar2(500)      /* 說明(對外全稱) */
);
alter table ooefl_t add constraint ooefl_pk primary key (ooeflent,ooefl001,ooefl002) enable validate;

create unique index ooefl_pk on ooefl_t (ooeflent,ooefl001,ooefl002);

grant select on ooefl_t to tiptop;
grant update on ooefl_t to tiptop;
grant delete on ooefl_t to tiptop;
grant insert on ooefl_t to tiptop;

exit;
