/* 
================================================================================
檔案代號:rtad_t
檔案名稱:品類策略品類明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtad_t
(
rtadent       number(5)      ,/* 企業編號 */
rtad001       varchar2(10)      ,/* 策略編號 */
rtad002       varchar2(10)      ,/* 品類編號 */
rtad003       varchar2(10)      ,/* 角色編號 */
rtad004       number(20,6)      ,/* SKU占比 */
rtad005       number(15,3)      ,/* SKU上限 */
rtad006       number(15,3)      ,/* SKU下限 */
rtad007       number(20,6)      ,/* 毛利率上限 */
rtad008       number(20,6)      ,/* 毛利率下限 */
rtadstus       varchar2(1)      ,/* 資料有效碼 */
rtadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtadud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtadsite       varchar2(10)      /* 營運據點 */
);
alter table rtad_t add constraint rtad_pk primary key (rtadent,rtad001,rtad002,rtadsite) enable validate;

create unique index rtad_pk on rtad_t (rtadent,rtad001,rtad002,rtadsite);

grant select on rtad_t to tiptop;
grant update on rtad_t to tiptop;
grant delete on rtad_t to tiptop;
grant insert on rtad_t to tiptop;

exit;
