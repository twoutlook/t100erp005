/* 
================================================================================
檔案代號:apad_t
檔案名稱:零用金交易帳號明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apad_t
(
apadent       number(5)      ,/* 企業編號 */
apadsite       varchar2(10)      ,/* 營運據點 */
apad001       varchar2(10)      ,/* 零用金帳戶代碼 */
apad002       varchar2(10)      ,/* 交易帳號 */
apad003       number(20,6)      ,/* 應備底下限額度 */
apad004       number(20,6)      ,/* 留存上限金額 */
apad005       varchar2(10)      ,/* 啟用否 */
apad006       date      ,/* 失效日期 */
apadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apad_t add constraint apad_pk primary key (apadent,apad001,apad002) enable validate;

create  index apad001 on apad_t (apad005,apad002,apad001);
create unique index apad_pk on apad_t (apadent,apad001,apad002);

grant select on apad_t to tiptop;
grant update on apad_t to tiptop;
grant delete on apad_t to tiptop;
grant insert on apad_t to tiptop;

exit;
