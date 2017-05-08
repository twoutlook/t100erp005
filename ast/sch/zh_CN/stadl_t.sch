/* 
================================================================================
檔案代號:stadl_t
檔案名稱:費用編號異動申請明細檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stadl_t
(
stadlent       number(5)      ,/* 企業編號 */
stadldocno       varchar2(20)      ,/* 單號 */
stadlseq       number(10,0)      ,/* 項次 */
stadl001       varchar2(6)      ,/* 語言別 */
stadl002       varchar2(500)      ,/* 說明 */
stadl003       varchar2(10)      /* 助記碼 */
);
alter table stadl_t add constraint stadl_pk primary key (stadlent,stadldocno,stadlseq,stadl001) enable validate;

create  index stadl_01 on stadl_t (stadl003);
create unique index stadl_pk on stadl_t (stadlent,stadldocno,stadlseq,stadl001);

grant select on stadl_t to tiptop;
grant update on stadl_t to tiptop;
grant delete on stadl_t to tiptop;
grant insert on stadl_t to tiptop;

exit;
