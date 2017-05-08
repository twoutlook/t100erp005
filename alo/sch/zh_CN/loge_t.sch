/* 
================================================================================
檔案代號:loge_t
檔案名稱:重要資料修改紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table loge_t
(
logeent       number(5)      ,/* 企業代碼 */
loge001       varchar2(20)      ,/* 員工編號 */
loge002       varchar2(20)      ,/* 作業編號 */
loge003       varchar2(10)      ,/* 營運據點編號 */
loge004       clob      ,/* 資料舊值 */
loge005       clob      ,/* 資料新值 */
loge006       timestamp(0)      ,/* 修改時間 */
loge007       varchar2(10)      ,/* 修改人員部門 */
logeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on loge_t to tiptop;
grant update on loge_t to tiptop;
grant delete on loge_t to tiptop;
grant insert on loge_t to tiptop;

exit;
