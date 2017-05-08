/* 
================================================================================
檔案代號:mmch_t
檔案名稱:卡折扣進階規則設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmch_t
(
mmchent       number(5)      ,/* 企業編號 */
mmch001       varchar2(20)      ,/* 活動規則編號 */
mmch002       varchar2(10)      ,/* 卡種編號 */
mmch003       varchar2(10)      ,/* 進階規則類型 */
mmch004       varchar2(10)      ,/* 進階規則編碼 */
mmch005       varchar2(1)      ,/* 互斥 */
mmch006       number(10,0)      ,/* 優先序 */
mmch007       varchar2(10)      ,/* 紀念日回饋條件 */
mmch008       number(5,0)      ,/* 紀念日前(日) */
mmch009       number(5,0)      ,/* 紀念日後(日) */
mmch010       number(20,6)      ,/* 折扣率 */
mmch011       date      ,/* 開始日期 */
mmch012       date      ,/* 結束日期 */
mmch013       varchar2(8)      ,/* 每日開始時間 */
mmch014       varchar2(8)      ,/* 每日結束時間 */
mmch015       varchar2(10)      ,/* 固定日期 */
mmch016       varchar2(10)      ,/* 固定星期 */
mmchstus       varchar2(1)      ,/* 資料有效 */
mmchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmch_t add constraint mmch_pk primary key (mmchent,mmch001,mmch003,mmch004) enable validate;

create unique index mmch_pk on mmch_t (mmchent,mmch001,mmch003,mmch004);

grant select on mmch_t to tiptop;
grant update on mmch_t to tiptop;
grant delete on mmch_t to tiptop;
grant insert on mmch_t to tiptop;

exit;
