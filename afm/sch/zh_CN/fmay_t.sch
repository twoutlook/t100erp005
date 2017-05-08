/* 
================================================================================
檔案代號:fmay_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmay_t
(
fmayent       number(5)      ,/* 企業代碼 */
fmay001       varchar2(10)      ,/* 帳務中心 */
fmay002       varchar2(20)      ,/* 償還本息賬務編號 */
fmay003       varchar2(5)      ,/* 帳套 */
fmay004       varchar2(10)      ,/* 歸屬法人 */
fmay005       number(5,0)      ,/* 年度 */
fmay006       number(5,0)      ,/* 期别 */
fmay007       varchar2(20)      ,/* 憑證編號 */
fmayownid       varchar2(20)      ,/* 資料所有者 */
fmayowndp       varchar2(10)      ,/* 資料所屬部門 */
fmaycrtid       varchar2(20)      ,/* 資料建立者 */
fmaycrtdp       varchar2(10)      ,/* 資料建立部門 */
fmaycrtdt       timestamp(0)      ,/* 資料創建日 */
fmaymodid       varchar2(20)      ,/* 資料修改者 */
fmaymoddt       timestamp(0)      ,/* 最近修改日 */
fmaycnfid       varchar2(20)      ,/* 資料確認者 */
fmaycnfdt       timestamp(0)      ,/* 資料確認日 */
fmaystus       varchar2(10)      /* 狀態碼 */
);
alter table fmay_t add constraint fmay_pk primary key (fmayent,fmay002) enable validate;

create unique index fmay_pk on fmay_t (fmayent,fmay002);

grant select on fmay_t to tiptop;
grant update on fmay_t to tiptop;
grant delete on fmay_t to tiptop;
grant insert on fmay_t to tiptop;

exit;
