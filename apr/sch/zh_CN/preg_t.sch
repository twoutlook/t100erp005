/* 
================================================================================
檔案代號:preg_t
檔案名稱:促銷談判結果單頭資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table preg_t
(
pregent       number(5)      ,/* 企業編號 */
pregunit       varchar2(10)      ,/* 制定組織 */
pregsite       varchar2(10)      ,/* 營運組織 */
pregstus       varchar2(10)      ,/* 狀態碼 */
preg001       varchar2(20)      ,/* 規則編號 */
preg002       varchar2(10)      ,/* 版本 */
preg003       varchar2(30)      ,/* 促銷方案編號 */
preg004       varchar2(10)      ,/* 促銷方式 */
preg005       varchar2(10)      ,/* 換贈對象 */
preg006       varchar2(10)      ,/* 換贈編號 */
preg007       varchar2(30)      ,/* 活動計劃 */
preg008       varchar2(10)      ,/* 活動類型 */
preg009       varchar2(10)      ,/* 檔期類型 */
preg010       varchar2(10)      ,/* 活動等級 */
preg011       varchar2(20)      ,/* 申請人員 */
preg012       varchar2(10)      ,/* 申請部門 */
preg013       varchar2(1)      ,/* 日期高階設定 */
preg014       date      ,/* 發佈日期 */
preg015       timestamp(0)      ,/* 終止日期 */
preg016       varchar2(20)      ,/* 發布人員 */
preg017       varchar2(20)      ,/* 終止人員 */
preg018       varchar2(8)      ,/* 釋出時間 */
pregownid       varchar2(20)      ,/* 資料所屬者 */
pregowndp       varchar2(10)      ,/* 資料所有部門 */
pregcrtid       varchar2(20)      ,/* 資料建立者 */
pregcrtdp       varchar2(10)      ,/* 資料建立部門 */
pregcrtdt       timestamp(0)      ,/* 資料創建日 */
pregmodid       varchar2(20)      ,/* 資料修改者 */
pregmoddt       timestamp(0)      ,/* 最近修改日 */
pregcnfid       varchar2(20)      ,/* 資料確認者 */
pregcnfdt       timestamp(0)      ,/* 資料確認日 */
pregpstid       varchar2(20)      ,/* 資料過帳者 */
pregpstdt       timestamp(0)      ,/* 資料過賬日 */
preg050       varchar2(1)      ,/* 相同基數取最低 */
preg051       varchar2(10)      ,/* 主題分類 */
preg052       varchar2(10)      /* 促銷類型 */
);
alter table preg_t add constraint preg_pk primary key (pregent,preg001) enable validate;

create unique index preg_pk on preg_t (pregent,preg001);

grant select on preg_t to tiptop;
grant update on preg_t to tiptop;
grant delete on preg_t to tiptop;
grant insert on preg_t to tiptop;

exit;
