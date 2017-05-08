/* 
================================================================================
檔案代號:mmaj_t
檔案名稱:會員基本資料檔-訊息通知方式
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmaj_t
(
mmajent       number(5)      ,/* 企業編號 */
mmaj001       varchar2(30)      ,/* 會員編號 */
mmaj002       varchar2(10)      ,/* 訊息通知方式代碼 */
mmajstus       varchar2(10)      ,/* 狀態碼 */
mmajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmaj_t add constraint mmaj_pk primary key (mmajent,mmaj001,mmaj002) enable validate;

create unique index mmaj_pk on mmaj_t (mmajent,mmaj001,mmaj002);

grant select on mmaj_t to tiptop;
grant update on mmaj_t to tiptop;
grant delete on mmaj_t to tiptop;
grant insert on mmaj_t to tiptop;

exit;
