/* 
================================================================================
檔案代號:deaf_t
檔案名稱:門店繳款單單身檔-收銀員差異處理檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deaf_t
(
deafent       number(5)      ,/* 企業編號 */
deafsite       varchar2(10)      ,/* 營運據點 */
deafdocno       varchar2(20)      ,/* 繳款單據編號 */
deafstatu       varchar2(10)      ,/* 單據狀態 */
deafdocdt       date      ,/* 單據日期 */
deaf001       varchar2(10)      ,/* 專櫃編號 */
deaf002       varchar2(10)      ,/* 班別 */
deaf003       varchar2(10)      ,/* 收銀機編號 */
deaf004       varchar2(20)      ,/* 收銀員編號 */
deaf005       varchar2(10)      ,/* 款別編號 */
deaf006       number(20,6)      ,/* 總繳金額 */
deaf007       number(20,6)      ,/* 系統金額 */
deaf008       number(20,6)      ,/* 差錯金額 */
deaf009       varchar2(10)      ,/* 差錯處理方式 */
deaf010       varchar2(80)      ,/* 備註 */
deaf011       varchar2(1)      ,/* 主帳套立帳否 */
deaf012       varchar2(10)      ,/* 款別分類 */
deaf013       varchar2(10)      ,/* 幣別 */
deaf014       number(20,10)      ,/* 匯率 */
deaf015       number(20,6)      ,/* 串幣金額 */
deaf016       varchar2(10)      ,/* 串幣款別分類 */
deaf017       varchar2(10)      ,/* 串幣款別編號 */
deaf018       varchar2(20)      ,/* 對應單據編號 */
deafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
deaf019       number(20,6)      ,/* 應繳金額 */
deaf020       number(20,6)      ,/* 其他金額 */
deaf021       varchar2(1)      ,/* 次帳套一立帳否 */
deaf022       varchar2(1)      /* 次帳套二立帳否 */
);
alter table deaf_t add constraint deaf_pk primary key (deafent,deafdocno,deaf005) enable validate;

create unique index deaf_pk on deaf_t (deafent,deafdocno,deaf005);

grant select on deaf_t to tiptop;
grant update on deaf_t to tiptop;
grant delete on deaf_t to tiptop;
grant insert on deaf_t to tiptop;

exit;
