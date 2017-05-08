/* 
================================================================================
檔案代號:logz_t
檔案名稱:系統資料依時紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logz_t
(
logz001       date      ,/* 紀錄時間 */
logz002       number(5,0)      ,/* 系統模組數 */
logz003       number(5,0)      ,/* 登記主程式數 */
logz004       number(5,0)      ,/* 有效主程式數 */
logz005       number(5,0)      ,/* Free Style程式支數 */
logz006       number(5,0)      ,/* 登記子程式數 */
logz007       number(5,0)      ,/* 有效子程式數 */
logz008       number(5,0)      ,/* 註冊作業數 */
logz009       number(5,0)      ,/* 有效作業數 */
logz010       number(5,0)      ,/* 實際開表數(ds) */
logzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logz_t to tiptop;
grant update on logz_t to tiptop;
grant delete on logz_t to tiptop;
grant insert on logz_t to tiptop;

exit;
