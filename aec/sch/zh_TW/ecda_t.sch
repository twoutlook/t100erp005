/* 
================================================================================
檔案代號:ecda_t
檔案名稱:作業資料預設說明檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ecda_t
(
ecdaent       number(5)      ,/* 企業編號 */
ecdasite       varchar2(10)      ,/* 營運據點 */
ecda001       varchar2(10)      ,/* 作業編號 */
ecda002       varchar2(10)      ,/* 預設項目 */
ecda003       varchar2(1)      ,/* 類型 */
ecda004       varchar2(10)      ,/* 單位 */
ecdaownid       varchar2(20)      ,/* 資料所有者 */
ecdaowndp       varchar2(10)      ,/* 資料所屬部門 */
ecdacrtid       varchar2(20)      ,/* 資料建立者 */
ecdacrtdp       varchar2(10)      ,/* 資料建立部門 */
ecdacrtdt       timestamp(0)      ,/* 資料創建日 */
ecdamodid       varchar2(20)      ,/* 資料修改者 */
ecdamoddt       timestamp(0)      ,/* 最近修改日 */
ecdastus       varchar2(10)      ,/* 狀態碼 */
ecdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecda_t add constraint ecda_pk primary key (ecdaent,ecdasite,ecda001,ecda002) enable validate;

create unique index ecda_pk on ecda_t (ecdaent,ecdasite,ecda001,ecda002);

grant select on ecda_t to tiptop;
grant update on ecda_t to tiptop;
grant delete on ecda_t to tiptop;
grant insert on ecda_t to tiptop;

exit;
