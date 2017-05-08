/* 
================================================================================
檔案代號:gcab_t
檔案名稱:券種基本資料申請檔-折價券收券限制條件設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcab_t
(
gcabent       number(5)      ,/* 企業編號 */
gcabsite       varchar2(10)      ,/* 營運據點 */
gcabunit       varchar2(10)      ,/* 應用組織 */
gcabdocno       varchar2(20)      ,/* 單據編號 */
gcab000       varchar2(10)      ,/* 申請類別 */
gcab001       varchar2(10)      ,/* 券種編碼 */
gcab002       number(10,0)      ,/* 序 */
gcab003       varchar2(10)      ,/* 消費數量滿/ 額滿 */
gcab004       number(20,6)      ,/* 單位消費金額/ 數量 */
gcab005       number(20,6)      ,/* 單位收券金額 */
gcab006       number(20,6)      ,/* 收券金額上限 */
gcabacti       varchar2(1)      ,/* 有效 */
gcabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcab_t add constraint gcab_pk primary key (gcabent,gcabdocno,gcab002) enable validate;

create unique index gcab_pk on gcab_t (gcabent,gcabdocno,gcab002);

grant select on gcab_t to tiptop;
grant update on gcab_t to tiptop;
grant delete on gcab_t to tiptop;
grant insert on gcab_t to tiptop;

exit;
