/* 
================================================================================
檔案代號:gzkg_t
檔案名稱:訊息通知記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzkg_t
(
gzkg001       varchar2(80)      ,/* 訊息ID */
gzkg002       varchar2(20)      ,/* 使用者編號 */
gzkg003       varchar2(20)      ,/* 員工編號 */
gzkg004       varchar2(40)      ,/* 模板ID */
gzkg005       varchar2(80)      ,/* 模板名稱 */
gzkg006       varchar2(255)      ,/* 實體檔案網址 */
gzkg007       varchar2(255)      ,/* Web報表網址 */
gzkg008       varchar2(255)      ,/* Mobile APP網址 */
gzkg009       varchar2(80)      ,/* 訊息批號 */
gzkg010       varchar2(80)      ,/* 訊息包序號 */
gzkg011       clob      ,/* Param XML */
gzkg012       varchar2(10)      ,/* 來源應用程式 */
gzkg013       varchar2(1)      ,/* 重要性 */
gzkg014       varchar2(1)      ,/* 通知分類 */
gzkg015       timestamp(0)      ,/* 訊息日期 */
gzkg016       varchar2(20)      ,/* 發送者 */
gzkg017       timestamp(0)      ,/* 回報時間 */
gzkg018       varchar2(4000)      ,/* 回報資訊 */
gzkg019       varchar2(255)      ,/* 訊息title */
gzkg020       varchar2(4000)      ,/* 訊息內容 */
gzkg021       varchar2(1)      ,/* 結案否 */
gzkgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzkgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzkgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzkgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzkgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzkgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzkgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzkgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzkgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzkgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzkgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzkgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzkgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzkgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzkgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzkgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzkgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzkgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzkgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzkgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzkgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzkgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzkgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzkgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzkgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzkgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzkgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzkgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzkgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzkgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzkg022       varchar2(10)      ,/* 群組類別代號 */
gzkg023       varchar2(80)      /* 群組類別名稱 */
);
alter table gzkg_t add constraint gzkg_pk primary key (gzkg001) enable validate;

create unique index gzkg_pk on gzkg_t (gzkg001);

grant select on gzkg_t to tiptop;
grant update on gzkg_t to tiptop;
grant delete on gzkg_t to tiptop;
grant insert on gzkg_t to tiptop;

exit;
