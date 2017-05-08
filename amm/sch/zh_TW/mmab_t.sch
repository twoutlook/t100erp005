/* 
================================================================================
檔案代號:mmab_t
檔案名稱:會員基本資料申請檔-屬性資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmab_t
(
mmabent       number(5)      ,/* 企業編號 */
mmabdocno       varchar2(20)      ,/* 單據編號 */
mmab001       varchar2(30)      ,/* 會員編號 */
mmab002       varchar2(10)      ,/* 屬性代碼類別 */
mmab003       varchar2(40)      ,/* 對應應用分類代碼 */
mmab004       varchar2(10)      ,/* 屬性代碼值 */
mmabacti       varchar2(10)      ,/* 資料有效碼 */
mmabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmab_t add constraint mmab_pk primary key (mmabent,mmabdocno,mmab002) enable validate;

create unique index mmab_pk on mmab_t (mmabent,mmabdocno,mmab002);

grant select on mmab_t to tiptop;
grant update on mmab_t to tiptop;
grant delete on mmab_t to tiptop;
grant insert on mmab_t to tiptop;

exit;
