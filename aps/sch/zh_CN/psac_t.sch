/* 
================================================================================
檔案代號:psac_t
檔案名稱:MPS計劃單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table psac_t
(
psacent       number(5)      ,/* 企業編號 */
psacsite       varchar2(10)      ,/* 營運據點 */
psacdocno       varchar2(20)      ,/* MPS計劃單號 */
psacdocdt       date      ,/* 單據日期 */
psac001       varchar2(20)      ,/* 申請人員 */
psac002       varchar2(10)      ,/* 申請部門 */
psac003       varchar2(255)      ,/* 備註 */
psacownid       varchar2(20)      ,/* 資料所有者 */
psacowndp       varchar2(10)      ,/* 資料所屬部門 */
psaccrtid       varchar2(20)      ,/* 資料建立者 */
psaccrtdp       varchar2(10)      ,/* 資料建立部門 */
psaccrtdt       timestamp(0)      ,/* 資料創建日 */
psacmodid       varchar2(20)      ,/* 資料修改者 */
psacmoddt       timestamp(0)      ,/* 最近修改日 */
psaccnfid       varchar2(20)      ,/* 資料確認者 */
psaccnfdt       timestamp(0)      ,/* 資料確認日 */
psacpstid       varchar2(20)      ,/* 資料過帳者 */
psacpstdt       timestamp(0)      ,/* 資料過帳日 */
psacstus       varchar2(10)      /* 狀態碼 */
);
alter table psac_t add constraint psac_pk primary key (psacent,psacdocno) enable validate;

create unique index psac_pk on psac_t (psacent,psacdocno);

grant select on psac_t to tiptop;
grant update on psac_t to tiptop;
grant delete on psac_t to tiptop;
grant insert on psac_t to tiptop;

exit;
