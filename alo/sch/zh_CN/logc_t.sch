/* 
================================================================================
檔案代號:logc_t
檔案名稱:修改歷程記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logc_t
(
logc001       varchar2(20)      ,/* 員工編號 */
logc002       varchar2(20)      ,/* 程式編號 */
logc003       date      ,/* 事件時間 */
logc004       varchar2(4000)      ,/* 舊值 */
logc005       varchar2(10)      ,/* 事件營運據點 */
logc006       varchar2(4000)      ,/* 新值 */
logcent       number(5)      ,/* 企業編號 */
logc007       varchar2(10)      ,/* 行為代碼 */
logc008       varchar2(4000)      ,/* key值舊值 */
logcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logc_t to tiptop;
grant update on logc_t to tiptop;
grant delete on logc_t to tiptop;
grant insert on logc_t to tiptop;

exit;
