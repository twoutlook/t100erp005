/* 
================================================================================
檔案代號:imed_t
檔案名稱:料件建檔檢核設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imed_t
(
imedent       number(5)      ,/* 企業編號 */
imedownid       varchar2(20)      ,/* 資料所有者 */
imedowndp       varchar2(10)      ,/* 資料所屬部門 */
imedcrtid       varchar2(20)      ,/* 資料建立者 */
imedcrtdp       varchar2(10)      ,/* 資料建立部門 */
imedcrtdt       timestamp(0)      ,/* 資料創建日 */
imedmodid       varchar2(20)      ,/* 資料修改者 */
imedmoddt       timestamp(0)      ,/* 最近修改日 */
imedstus       varchar2(10)      ,/* 狀態碼 */
imed001       varchar2(10)      ,/* 營運據點 */
imed002       varchar2(10)      ,/* 主分群碼 */
imed003       varchar2(10)      ,/* 職能 */
imed004       varchar2(10)      ,/* 產品檢核類型 */
imed005       varchar2(10)      ,/* 角色 */
imed006       varchar2(20)      ,/* 通知人員 */
imed007       varchar2(500)      ,/* E-mail */
imed008       varchar2(20)      ,/* 分機 */
imedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imed_t add constraint imed_pk primary key (imedent,imed001,imed002,imed003) enable validate;

create unique index imed_pk on imed_t (imedent,imed001,imed002,imed003);

grant select on imed_t to tiptop;
grant update on imed_t to tiptop;
grant delete on imed_t to tiptop;
grant insert on imed_t to tiptop;

exit;
