/* 
================================================================================
檔案代號:mhaw_t
檔案名稱:場地資料匯入臨時檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mhaw_t
(
mhawent       number(5)      ,/* 企業代碼 */
mhawsite       varchar2(10)      ,/* 營運據點 */
mhawunit       varchar2(10)      ,/* 應用組織 */
mhaw001       varchar2(10)      ,/* 樓棟編號 */
mhaw002       varchar2(500)      ,/* 樓棟名稱 */
mhaw003       number(20,6)      ,/* 樓棟圖紙建築面積 */
mhaw004       number(20,6)      ,/* 樓棟圖紙測量面積 */
mhaw005       varchar2(10)      ,/* 樓層編號 */
mhaw006       varchar2(500)      ,/* 樓層名稱 */
mhaw007       number(20,6)      ,/* 樓層圖紙建築面積 */
mhaw008       number(20,6)      ,/* 樓層圖紙測量面積 */
mhaw009       number(20,6)      ,/* 建築公攤率 */
mhaw010       number(20,6)      ,/* 公攤系數 */
mhaw011       varchar2(10)      ,/* 區域編號 */
mhaw012       varchar2(500)      ,/* 區域名稱 */
mhaw013       varchar2(10)      ,/* 場地編號 */
mhaw014       varchar2(500)      ,/* 場地名稱 */
mhaw015       number(20,6)      ,/* 建築面積 */
mhaw016       number(20,6)      ,/* 測量面積 */
mhaw017       number(20,6)      ,/* 經營面積 */
mhaw018       varchar2(10)      ,/* 場地使用狀態 */
mhaw019       varchar2(10)      /* 有效否 */
);


grant select on mhaw_t to tiptop;
grant update on mhaw_t to tiptop;
grant delete on mhaw_t to tiptop;
grant insert on mhaw_t to tiptop;

exit;
