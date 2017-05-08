/* 
================================================================================
檔案代號:gzbe_t
檔案名稱:線上交談訊息記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzbe_t
(
gzbeent       number(5)      ,/* 企業碼 */
gzbe001       varchar2(20)      ,/* 發訊人 */
gzbe002       varchar2(20)      ,/* 收訊人 */
gzbe003       timestamp(5)      ,/* 發送時間 */
gzbe004       varchar2(1)      ,/* 是否已讀 */
gzbe005       varchar2(1)      ,/* 訊息類型 */
gzbe006       varchar2(255)      ,/* 其它說明 */
gzbe007       clob      ,/* 文字內容 */
gzbe008       blob      /* 檔案 */
);


grant select on gzbe_t to tiptop;
grant update on gzbe_t to tiptop;
grant delete on gzbe_t to tiptop;
grant insert on gzbe_t to tiptop;

exit;
