/* 
================================================================================
檔案代號:logw_t
檔案名稱:服務執行運作記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table logw_t
(
logwent       number(5)      ,/* 企業代碼 */
logw001       varchar2(20)      ,/* sessionkey */
logw002       varchar2(20)      ,/* 作業編號 */
logw003       timestamp(0)      ,/* 執行時間 */
logw004       varchar2(40)      ,/* 服務名稱 */
logw005       varchar2(80)      ,/* 來源產品名稱 */
logw006       varchar2(20)      ,/* 來源主機 IP */
logw007       varchar2(20)      ,/* 來源主機登入帳號 */
logw008       varchar2(255)      ,/* 關鍵字 */
logw009       timestamp(0)      ,/* 結束時間 */
logw010       varchar2(10)      ,/* 服務執行結果狀態代碼 */
logw011       varchar2(10)      ,/* 執行狀態 */
logw012       varchar2(255)      ,/* 執行狀態訊息 */
logw013       varchar2(80)      ,/* 傳入資料檔案路徑 */
logw014       varchar2(80)      ,/* 回傳資料檔案路徑 */
logwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logw_t to tiptop;
grant update on logw_t to tiptop;
grant delete on logw_t to tiptop;
grant insert on logw_t to tiptop;

exit;
