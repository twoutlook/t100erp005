/* 
================================================================================
檔案代號:xrda
檔案名稱:收款核銷單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrda
(
xrdaent       number(5)      ,/* 企業代碼 */
xrdacomp       varchar2(10)      ,/* 所屬法人 */
xrdald       varchar2(5)      ,/* 帳套別 */
xrdadocno       varchar2(20)      ,/* 沖帳單號 */
xrdadocdt       date      ,/* 沖帳日期 */
xrdasite       varchar2(10)      ,/* 帳務中心 */
xrda001       varchar2(10)      ,/* 帳款單性質 */
xrda003       varchar2(10)      ,/* 帳務人員 */
xrda004       varchar2(10)      ,/* 帳款核銷客戶 */
xrda005       varchar2(10)      ,/* 收款客戶 */
xrda006       varchar2(20)      ,/* 一次性對象識別碼 */
xrda007       varchar2(1)      ,/* 產生方式 */
xrda008       varchar2(20)      ,/* 來源參考單號 */
xrda009       varchar2(20)      ,/* 沖帳批序號 */
xrda010       varchar2(20)      ,/* 集團代收付單號 */
xrda011       varchar2(1)      ,/* 差異處理 */
xrda012       varchar2(10)      ,/* 退款類型 */
xrda013       varchar2(1)      ,/* 分錄底稿是否可重新產生 */
xrda014       varchar2(20)      ,/* 拋轉傳票號碼 */
xrda015       varchar2(10)      ,/* 作廢理由碼 */
xrda016       number(10,0)      ,/* 列印次數 */
xrda017       varchar2(255)      ,/* MEMO備註 */
xrdastus       varchar2(1)      /* 確認否 */
);
alter table xrda add constraint xrda_pk primary key (xrdaent,xrdald,xrdadocno) enable validate;


grant select on xrda to tiptop;
grant update on xrda to tiptop;
grant delete on xrda to tiptop;
grant insert on xrda to tiptop;

exit;
