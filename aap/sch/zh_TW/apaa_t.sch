/* 
================================================================================
檔案代號:apaa_t
檔案名稱:交易對象收付款方式依據點設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table apaa_t
(
apaaent       number(5)      ,/* 企業代碼 */
apaaownid       varchar2(20)      ,/* 資料所有者 */
apaaowndp       varchar2(10)      ,/* 資料所屬部門 */
apaacrtid       varchar2(20)      ,/* 資料建立者 */
apaacrtdp       varchar2(10)      ,/* 資料建立部門 */
apaacrtdt       timestamp(0)      ,/* 資料創建日 */
apaamodid       varchar2(20)      ,/* 資料修改者 */
apaamoddt       timestamp(0)      ,/* 最近修改日 */
apaastus       varchar2(10)      ,/* 狀態碼 */
apaasite       varchar2(10)      ,/* 營運據點 */
apaa001       varchar2(10)      ,/* 交易對象 */
apaa002       varchar2(1)      ,/* 付款/收款 */
apaa003       varchar2(1)      ,/* 票據應禁止背書 */
apaa004       varchar2(10)      ,/* 票據寄領方式 */
apaa005       number(20,6)      ,/* 手續費 */
apaa006       varchar2(10)      ,/* 手續費扣款方式 */
apaa007       number(20,6)      ,/* 寄送郵資費 */
apaa008       varchar2(10)      ,/* 郵資費扣款方式 */
apaa009       varchar2(10)      /* 通知方式 */
);
alter table apaa_t add constraint apaa_pk primary key (apaaent,apaasite,apaa001,apaa002) enable validate;

create unique index apaa_pk on apaa_t (apaaent,apaasite,apaa001,apaa002);

grant select on apaa_t to tiptop;
grant update on apaa_t to tiptop;
grant delete on apaa_t to tiptop;
grant insert on apaa_t to tiptop;

exit;
