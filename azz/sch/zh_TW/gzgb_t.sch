/* 
================================================================================
檔案代號:gzgb_t
檔案名稱:相關文件資料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzgb_t
(
gzgb001       varchar2(10)      ,/* 文件編號 */
gzgb002       varchar2(10)      ,/* 文件類型 */
gzgb003       varchar2(10)      ,/* 文件分輯 */
gzgb004       varchar2(10)      ,/* 文件版本 */
gzgb005       varchar2(255)      ,/* 文件說明 */
gzgb006       varchar2(500)      ,/* 文件完整說明 */
gzgb007       varchar2(500)      ,/* 文件名稱 */
gzgb008       varchar2(1)      ,/* 文件儲存方式 */
gzgb009       blob      ,/* 文件內容 */
gzgb010       varchar2(500)      ,/* 文件位置 */
gzgb011       varchar2(1)      ,/* 文件讀取權限 */
gzgb012       varchar2(1)      ,/* 文件異動權限 */
gzgb013       varchar2(20)      ,/* 文件建立人員 */
gzgb014       varchar2(10)      ,/* 文件建立人員群組 */
gzgb015       date      ,/* 文件建立日期 */
gzgb016       varchar2(20)      ,/* 最後異動人員 */
gzgb017       varchar2(10)      ,/* 最後異動人員群組 */
gzgb018       date      ,/* 最後異動日期 */
gzgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzgbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzgb_t add constraint gzgb_pk primary key (gzgb001,gzgb002,gzgb003,gzgb004) enable validate;

create unique index gzgb_pk on gzgb_t (gzgb001,gzgb002,gzgb003,gzgb004);

grant select on gzgb_t to tiptop;
grant update on gzgb_t to tiptop;
grant delete on gzgb_t to tiptop;
grant insert on gzgb_t to tiptop;

exit;
