/* 
================================================================================
檔案代號:inaw_t
檔案名稱:掃碼規則資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inaw_t
(
inawent       number(5)      ,/* 企业代码 */
inaw001       varchar2(10)      ,/* 條碼類型 */
inaw002       number(10,0)      ,/* 總碼長 */
inaw003       number(10,0)      ,/* 序號 */
inaw004       varchar2(10)      ,/* 項目 */
inaw005       number(10,0)      ,/* 起始位 */
inaw006       number(10,0)      ,/* 結束位 */
inaw007       varchar2(1)      ,/* 有效否 */
inawownid       varchar2(20)      ,/* 資料所屬者 */
inawowndp       varchar2(10)      ,/* 資料所屬部門 */
inawcrtid       varchar2(20)      ,/*   */
inawcrtdp       varchar2(10)      ,/*   */
inawcrtdt       timestamp(0)      ,/* 資料創建日 */
inawmodid       varchar2(20)      ,/*   */
inawmoddt       timestamp(0)      ,/*   */
inawstus       varchar2(10)      /* 狀態碼 */
);
alter table inaw_t add constraint inaw_pk primary key (inawent,inaw001,inaw002,inaw003) enable validate;

create unique index inaw_pk on inaw_t (inawent,inaw001,inaw002,inaw003);
create unique index inaw_uk on inaw_t (inawent,inaw001,inaw002,inaw004);

grant select on inaw_t to tiptop;
grant update on inaw_t to tiptop;
grant delete on inaw_t to tiptop;
grant insert on inaw_t to tiptop;

exit;
