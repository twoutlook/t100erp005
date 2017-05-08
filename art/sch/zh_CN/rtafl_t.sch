/* 
================================================================================
檔案代號:rtafl_t
檔案名稱:品類策略異動申請單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtafl_t
(
rtaflent       number(5)      ,/* 企業編號 */
rtafldocno       varchar2(20)      ,/* 單號 */
rtafl001       varchar2(6)      ,/* 語言別 */
rtafl002       varchar2(500)      ,/* 說明 */
rtafl003       varchar2(10)      /* 助記碼 */
);
alter table rtafl_t add constraint rtafl_pk primary key (rtaflent,rtafldocno,rtafl001) enable validate;

create  index rtafl_01 on rtafl_t (rtafl003);
create unique index rtafl_pk on rtafl_t (rtaflent,rtafldocno,rtafl001);

grant select on rtafl_t to tiptop;
grant update on rtafl_t to tiptop;
grant delete on rtafl_t to tiptop;
grant insert on rtafl_t to tiptop;

exit;
