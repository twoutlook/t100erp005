/* 
================================================================================
檔案代號:deaj_t
檔案名稱:門店收銀交款單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deaj_t
(
deajent       number(5)      ,/* 企業編號 */
deajsite       varchar2(10)      ,/* 營運據點 */
deajunit       varchar2(10)      ,/* 應用組織 */
deajdocno       varchar2(20)      ,/* 單據編號 */
deaj001       number(20,6)      ,/* 營業現金(上班結餘) */
deaj002       number(20,6)      ,/* 營業外收入(雜收) */
deaj003       number(20,6)      ,/* 營業外支出(雜支) */
deaj004       number(20,6)      ,/* 收銀機銷貨金額 */
deaj005       number(20,6)      ,/* 手開發票銷貨金額 */
deaj006       number(20,6)      ,/* 應結餘金額 */
deaj007       number(20,6)      ,/* 點收總金額 */
deaj008       number(20,6)      ,/* 繳大鈔 */
deaj009       number(20,6)      ,/* 差異金額 */
deajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deaj_t add constraint deaj_pk primary key (deajent,deajdocno) enable validate;

create unique index deaj_pk on deaj_t (deajent,deajdocno);

grant select on deaj_t to tiptop;
grant update on deaj_t to tiptop;
grant delete on deaj_t to tiptop;
grant insert on deaj_t to tiptop;

exit;
