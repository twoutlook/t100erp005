/* 
================================================================================
檔案代號:gcaj_t
檔案名稱:券種基本資料檔-收券組織進階設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcaj_t
(
gcajent       number(5)      ,/* 企業編號 */
gcaj001       varchar2(10)      ,/* 券種編碼 */
gcaj002       varchar2(10)      ,/* 限定組織 */
gcaj003       varchar2(1)      ,/* 包含以下所有組織 */
gcajstus       varchar2(1)      ,/* 有效 */
gcajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcaj_t add constraint gcaj_pk primary key (gcajent,gcaj001,gcaj002) enable validate;

create unique index gcaj_pk on gcaj_t (gcajent,gcaj001,gcaj002);

grant select on gcaj_t to tiptop;
grant update on gcaj_t to tiptop;
grant delete on gcaj_t to tiptop;
grant insert on gcaj_t to tiptop;

exit;
