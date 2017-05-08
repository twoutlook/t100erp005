/* 
================================================================================
檔案代號:inpi_t
檔案名稱:ABC產品分類資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inpi_t
(
inpient       number(5)      ,/* 企業編號 */
inpisite       varchar2(10)      ,/* 營運據點 */
inpi001       varchar2(1)      ,/* ABC分類 */
inpi002       varchar2(10)      ,/* 產品分類碼 */
inpiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpi_t add constraint inpi_pk primary key (inpient,inpisite,inpi001,inpi002) enable validate;


grant select on inpi_t to tiptop;
grant update on inpi_t to tiptop;
grant delete on inpi_t to tiptop;
grant insert on inpi_t to tiptop;

exit;
