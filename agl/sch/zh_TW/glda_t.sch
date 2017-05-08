/* 
================================================================================
檔案代號:glda_t
檔案名稱:個體公司基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glda_t
(
gldaent       number(5)      ,/* 企業代碼 */
gldaownid       varchar2(20)      ,/* 資料所有者 */
gldaowndp       varchar2(10)      ,/* 資料所屬部門 */
gldacrtid       varchar2(20)      ,/* 資料建立者 */
gldacrtdp       varchar2(10)      ,/* 資料建立部門 */
gldacrtdt       timestamp(0)      ,/* 資料創建日 */
gldamodid       varchar2(20)      ,/* 資料修改者 */
gldamoddt       timestamp(0)      ,/* 最近修改日 */
gldastus       varchar2(10)      ,/* 狀態碼 */
glda001       varchar2(10)      ,/* 公司編號 */
glda002       varchar2(1)      ,/* 使用T100 */
glda003       varchar2(10)      ,/* 法人營運據點編號 */
glda004       varchar2(10)      ,/* 關係人編號 */
gldaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glda_t add constraint glda_pk primary key (gldaent,glda001) enable validate;

create unique index glda_pk on glda_t (gldaent,glda001);

grant select on glda_t to tiptop;
grant update on glda_t to tiptop;
grant delete on glda_t to tiptop;
grant insert on glda_t to tiptop;

exit;
