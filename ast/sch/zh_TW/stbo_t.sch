/* 
================================================================================
檔案代號:stbo_t
檔案名稱:合約簽約門店表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbo_t
(
stboent       number(5)      ,/* 企業代碼 */
stbo001       varchar2(20)      ,/* 合約編號 */
stbo002       number(10,0)      ,/* 項次 */
stbo003       varchar2(10)      ,/* 門店 */
stboacti       varchar2(1)      /* 有效 */
);
alter table stbo_t add constraint stbo_pk primary key (stboent,stbo001,stbo002) enable validate;

create unique index stbo_pk on stbo_t (stboent,stbo001,stbo002);

grant select on stbo_t to tiptop;
grant update on stbo_t to tiptop;
grant delete on stbo_t to tiptop;
grant insert on stbo_t to tiptop;

exit;
