/* 
================================================================================
檔案代號:mmbw_t
檔案名稱:卡積點進階規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbw_t
(
mmbwent       number(5)      ,/* 企業編號 */
mmbw001       varchar2(20)      ,/* 活動規則編號 */
mmbw002       varchar2(10)      ,/* 卡種編號 */
mmbw003       varchar2(10)      ,/* 進階規則類型 */
mmbw004       varchar2(10)      ,/* 進階規則編碼 */
mmbw005       varchar2(1)      ,/* 互斥 */
mmbw006       number(10,0)      ,/* 優先序 */
mmbw007       varchar2(10)      ,/* 紀念日回饋條件 */
mmbw008       number(5,0)      ,/* 紀念日前(日) */
mmbw009       number(5,0)      ,/* 紀念日後(日) */
mmbw010       varchar2(10)      ,/* 回饋類型 */
mmbw011       number(5,0)      ,/* 加送倍數 */
mmbw012       number(20,6)      ,/* 回饋基點基準 */
mmbw013       number(15,3)      ,/* 加送積點 */
mmbw014       date      ,/* 生效日期 */
mmbw015       date      ,/* 失效日期 */
mmbw016       varchar2(8)      ,/* 每日開始時間 */
mmbw017       varchar2(8)      ,/* 每日結束時間 */
mmbw018       varchar2(10)      ,/* 固定日期 */
mmbw019       varchar2(1)      ,/* 固定星期 */
mmbwstus       varchar2(1)      ,/* 資料有效 */
mmbwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbw_t add constraint mmbw_pk primary key (mmbwent,mmbw001,mmbw003,mmbw004) enable validate;

create unique index mmbw_pk on mmbw_t (mmbwent,mmbw001,mmbw003,mmbw004);

grant select on mmbw_t to tiptop;
grant update on mmbw_t to tiptop;
grant delete on mmbw_t to tiptop;
grant insert on mmbw_t to tiptop;

exit;
