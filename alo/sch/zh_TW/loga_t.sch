/* 
================================================================================
檔案代號:loga_t
檔案名稱:使用者程式執行時間記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table loga_t
(
loga001       varchar2(20)      ,/* 使用者編號 */
loga002       varchar2(20)      ,/* 作業編號 */
loga003       varchar2(20)      ,/* 資料庫編號 */
loga004       varchar2(20)      ,/* 主機位址 */
loga005       varchar2(20)      ,/* sessionkey */
loga006       timestamp(0)      ,/* 啟動時間 */
loga007       timestamp(0)      ,/* 關閉時間 */
loga008       varchar2(80)      ,/* 離開編號 */
loga009       varchar2(20)      ,/* 員工編號 */
loga010       varchar2(20)      ,/* 程式編號 */
loga011       number(5)      ,/* NO USE */
loga012       varchar2(10)      ,/* 初始營運據點編號 */
loga013       varchar2(20)      ,/* 作業PID */
loga014       varchar2(20)      ,/* 父階sessionkey */
logaent       number(5)      ,/* 企業編號 */
logaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table loga_t add constraint loga_pk primary key (loga005) enable validate;

create unique index loga_pk on loga_t (loga005);

grant select on loga_t to tiptop;
grant update on loga_t to tiptop;
grant delete on loga_t to tiptop;
grant insert on loga_t to tiptop;

exit;
