/* 
================================================================================
檔案代號:logd_t
檔案名稱:資料庫連結紀錄
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logd_t
(
logd001       varchar2(20)      ,/* 使用者編號 */
logd002       varchar2(20)      ,/* 作業編號 */
logd003       varchar2(20)      ,/* 資料庫編號 */
logd004       number(20,0)      ,/* SESSION ID */
logd005       varchar2(40)      ,/* ORACLE AUSID */
logd006       timestamp(0)      ,/* 啟動時間 */
logd007       timestamp(0)      ,/* 關閉時間 */
logdent       number(5)      ,/* 企業編號 */
logdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logd_t to tiptop;
grant update on logd_t to tiptop;
grant delete on logd_t to tiptop;
grant insert on logd_t to tiptop;

exit;
