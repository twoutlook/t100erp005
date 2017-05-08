/* 
================================================================================
檔案代號:pcaj_t
檔案名稱:POS參數值基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcaj_t
(
pcajent       number(5)      ,/* 企業編號 */
pcajunit       varchar2(10)      ,/* 應用組織 */
pcaj001       varchar2(60)      ,/* 參數編號 */
pcaj002       varchar2(60)      ,/* 參數值 */
pcaj003       varchar2(1)      ,/* 默認值否 */
pcajstus       varchar2(10)      ,/* 狀態碼 */
pcajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcaj_t add constraint pcaj_pk primary key (pcajent,pcaj001,pcaj002) enable validate;

create unique index pcaj_pk on pcaj_t (pcajent,pcaj001,pcaj002);

grant select on pcaj_t to tiptop;
grant update on pcaj_t to tiptop;
grant delete on pcaj_t to tiptop;
grant insert on pcaj_t to tiptop;

exit;
