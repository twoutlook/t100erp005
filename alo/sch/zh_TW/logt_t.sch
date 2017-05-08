/* 
================================================================================
檔案代號:logt_t
檔案名稱:事件檢視器資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logt_t
(
logtent       number(5)      ,/* 企業編號 */
logt001       varchar2(10)      ,/* 事件類別 */
logt002       timestamp(0)      ,/* 事件時間 */
logt003       varchar2(20)      ,/* 使用者編號 */
logt004       varchar2(20)      ,/* 作業編號 */
logt005       varchar2(1000)      ,/* 說明 */
logt006       varchar2(10)      ,/* 營運據點編號 */
logt007       varchar2(20)      ,/* ClientIP */
logt008       varchar2(20)      ,/* ServerIP */
logt009       varchar2(1)      ,/* 等級 */
logtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logt_t to tiptop;
grant update on logt_t to tiptop;
grant delete on logt_t to tiptop;
grant insert on logt_t to tiptop;

exit;
