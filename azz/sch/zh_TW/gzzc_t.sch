/* 
================================================================================
檔案代號:gzzc_t
檔案名稱:程式外部可傳入參數設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzzc_t
(
gzzc001       varchar2(20)      ,/* 程式編號 */
gzzc002       number(5,0)      ,/* 序號 */
gzzc003       varchar2(80)      ,/* 變數意義 */
gzzc004       varchar2(20)      ,/* 建議變數型態 */
gzzc005       number(5,0)      ,/* 建議變數長度 */
gzzc006       varchar2(80)      ,/* 使用程式(4gl) */
gzzc007       varchar2(255)      ,/* 參考程式碼段落 */
gzzcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzzc_t add constraint gzzc_pk primary key (gzzc001,gzzc002) enable validate;

create unique index gzzc_pk on gzzc_t (gzzc001,gzzc002);

grant select on gzzc_t to tiptop;
grant update on gzzc_t to tiptop;
grant delete on gzzc_t to tiptop;
grant insert on gzzc_t to tiptop;

exit;
