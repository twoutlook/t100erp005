/* 
================================================================================
檔案代號:indo_t
檔案名稱:高低庫存設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table indo_t
(
indoent       number(5)      ,/* 企業編號 */
indo001       varchar2(10)      ,/* 品類編號 */
indo002       number(5,0)      ,/* 零銷售標準天數 */
indo003       number(5,0)      ,/* 零庫存標準天數 */
indo004       number(5,0)      ,/* 零到貨標準天數 */
indo005       number(5,0)      ,/* 考核週期天數 */
indo006       number(5,0)      ,/* 缺貨標準 */
indo007       number(5,0)      ,/* 高庫存標準 */
indoownid       varchar2(20)      ,/* 資料所有者 */
indoowndp       varchar2(10)      ,/* 資料所屬部門 */
indocrtid       varchar2(20)      ,/* 資料建立者 */
indocrtdp       varchar2(10)      ,/* 資料建立部門 */
indocrtdt       timestamp(0)      ,/* 資料創建日 */
indomodid       varchar2(20)      ,/* 資料修改者 */
indomoddt       timestamp(0)      ,/* 最近修改日 */
indostus       varchar2(10)      ,/* 狀態碼 */
indoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indo_t add constraint indo_pk primary key (indoent,indo001) enable validate;

create unique index indo_pk on indo_t (indoent,indo001);

grant select on indo_t to tiptop;
grant update on indo_t to tiptop;
grant delete on indo_t to tiptop;
grant insert on indo_t to tiptop;

exit;
