/* 
================================================================================
檔案代號:bxec_t
檔案名稱:保稅單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxec_t
(
bxecent       number(5)      ,/* 企業編號 */
bxecsite       varchar2(10)      ,/* 營運據點 */
bxecdocno       varchar2(20)      ,/* 保稅單號 */
bxecdocdt       date      ,/* 保稅日期 */
bxec001       varchar2(10)      ,/* 異動原因 */
bxec002       varchar2(20)      ,/* 保稅人員 */
bxec003       varchar2(10)      ,/* 保稅部門 */
bxec004       varchar2(10)      ,/* 異動類型 */
bxec005       varchar2(10)      ,/* 出入庫碼 */
bxec006       varchar2(20)      ,/* 異動作業編號 */
bxec007       varchar2(20)      ,/* 來源單號 */
bxec008       number(5,0)      ,/* 申報年度 */
bxec009       number(5,0)      ,/* 申報月份 */
bxec010       varchar2(10)      ,/* 交易對象 */
bxec011       varchar2(10)      ,/* 收/送貨對象 */
bxec012       varchar2(10)      ,/* 帳款對象 */
bxec013       varchar2(20)      ,/* 發票號碼 */
bxec014       varchar2(255)      /* 備註 */
);
alter table bxec_t add constraint bxec_pk primary key (bxecent,bxecdocno) enable validate;

create unique index bxec_pk on bxec_t (bxecent,bxecdocno);

grant select on bxec_t to tiptop;
grant update on bxec_t to tiptop;
grant delete on bxec_t to tiptop;
grant insert on bxec_t to tiptop;

exit;
