/* 
================================================================================
檔案代號:pmaj_t
檔案名稱:交易對象聯絡人檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmaj_t
(
pmajent       number(5)      ,/* 企業編號 */
pmaj001       varchar2(10)      ,/* 交易對象編號 */
pmaj002       varchar2(20)      ,/* 聯絡人識別碼 */
pmaj003       varchar2(10)      ,/* 聯絡人類別 */
pmaj004       varchar2(1)      ,/* 主要聯絡人否 */
pmaj005       varchar2(1)      ,/* 財務主要聯絡人否 */
pmaj006       varchar2(80)      ,/* 聯絡人部門 */
pmaj007       varchar2(80)      ,/* 職稱 */
pmaj008       varchar2(255)      ,/* 簡要說明 */
pmajstus       varchar2(10)      ,/* 狀態碼 */
pmajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmajud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmaj009       varchar2(80)      ,/* 姓氏 */
pmaj010       varchar2(80)      ,/* 中間名 */
pmaj011       varchar2(80)      ,/* 名字 */
pmaj012       varchar2(255)      ,/* 全名 */
pmaj013       varchar2(80)      ,/* 參考名 */
pmaj014       varchar2(80)      /* 昵稱 */
);
alter table pmaj_t add constraint pmaj_pk primary key (pmajent,pmaj001,pmaj002) enable validate;

create unique index pmaj_pk on pmaj_t (pmajent,pmaj001,pmaj002);

grant select on pmaj_t to tiptop;
grant update on pmaj_t to tiptop;
grant delete on pmaj_t to tiptop;
grant insert on pmaj_t to tiptop;

exit;
