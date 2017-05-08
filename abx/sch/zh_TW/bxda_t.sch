/* 
================================================================================
檔案代號:bxda_t
檔案名稱:保稅廠外加工海關核准文號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxda_t
(
bxdaent       number(5)      ,/* 企業編號 */
bxdasite       varchar2(10)      ,/* 營運據點 */
bxda001       varchar2(20)      ,/* 核准文號 */
bxda002       varchar2(40)      ,/* 申請料號 */
bxda003       varchar2(10)      ,/* 加工廠商 */
bxda004       date      ,/* 起始日期 */
bxda005       date      ,/* 截止日期 */
bxda006       number(20,6)      ,/* 核准加工數量 */
bxda007       number(20,6)      ,/* 已核銷數量 */
bxda008       varchar2(255)      ,/* 備註 */
bxdaownid       varchar2(20)      ,/* 資料所有者 */
bxdaowndp       varchar2(10)      ,/* 資料所屬部門 */
bxdacrtid       varchar2(20)      ,/* 資料建立者 */
bxdacrtdp       varchar2(10)      ,/* 資料建立部門 */
bxdacrtdt       timestamp(0)      ,/* 資料創建日 */
bxdamodid       varchar2(20)      ,/* 資料修改者 */
bxdamoddt       timestamp(0)      ,/* 最近修改日 */
bxdacnfid       varchar2(20)      ,/* 資料確認者 */
bxdacnfdt       timestamp(0)      ,/* 資料確認日 */
bxdastus       varchar2(10)      ,/* 狀態碼 */
bxdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxda_t add constraint bxda_pk primary key (bxdaent,bxdasite,bxda001,bxda002) enable validate;

create unique index bxda_pk on bxda_t (bxdaent,bxdasite,bxda001,bxda002);

grant select on bxda_t to tiptop;
grant update on bxda_t to tiptop;
grant delete on bxda_t to tiptop;
grant insert on bxda_t to tiptop;

exit;
