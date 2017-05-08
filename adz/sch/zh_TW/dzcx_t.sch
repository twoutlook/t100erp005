/* 
================================================================================
檔案代號:dzcx_t
檔案名稱:cch test
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcx_t
(
dzcx001       varchar2(15)      ,/* 111 */
dzcx002       varchar2(20)      ,/* 222 */
dzcx003       varchar2(20)      ,/* 333 */
dzcx004       varchar2(15)      ,/* 444 */
dzcx005       varchar2(15)      ,/* 555 */
dzcxent       number(5)      ,/* 企業編號 */
dzcxownid       varchar2(20)      ,/* 資料所有者 */
dzcxowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcxcrtid       varchar2(20)      ,/* 資料建立者 */
dzcxcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcxcrtdt       timestamp(0)      ,/* 資料創建日 */
dzcxmodid       varchar2(20)      ,/* 資料修改者 */
dzcxmoddt       timestamp(0)      ,/* 最近修改日 */
dzcxstus       varchar2(10)      /* 狀態碼 */
);
alter table dzcx_t add constraint dzcx_pk primary key (dzcx001,dzcx002,dzcx003,dzcx004) enable validate;

create unique index dzcx_pk on dzcx_t (dzcx001,dzcx002,dzcx003,dzcx004);

grant select on dzcx_t to tiptop;
grant update on dzcx_t to tiptop;
grant delete on dzcx_t to tiptop;
grant insert on dzcx_t to tiptop;

exit;
