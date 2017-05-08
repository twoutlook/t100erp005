/* 
================================================================================
檔案代號:psib_t
檔案名稱:採購預測單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psib_t
(
psibent       number(5)      ,/* 企業編號 */
psibsite       varchar2(10)      ,/* 營運據點 */
psib001       varchar2(10)      ,/* 預測編號 */
psib002       date      ,/* 預測起始日期 */
psib003       varchar2(10)      ,/* 供應商 */
psib004       varchar2(20)      ,/* 計畫員 */
psib005       varchar2(10)      ,/* 版本 */
psib006       varchar2(40)      ,/* 料件編號 */
psib007       varchar2(256)      ,/* 產品特徵 */
psib008       number(5,0)      ,/* 期別 */
psib009       date      ,/* 起始日期 */
psib010       date      ,/* 截止日期 */
psib011       number(20,6)      ,/* 數量 */
psib012       varchar2(10)      ,/* 單位 */
psibud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psibud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psibud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psibud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psibud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psibud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psibud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psibud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psibud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psibud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psibud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psibud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psibud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psibud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psibud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psibud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psibud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psibud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psibud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psibud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psibud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psibud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psibud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psibud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psibud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psibud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psibud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psibud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psibud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psibud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psib_t add constraint psib_pk primary key (psibent,psibsite,psib001,psib002,psib003,psib004,psib005,psib006,psib007,psib008) enable validate;

create unique index psib_pk on psib_t (psibent,psibsite,psib001,psib002,psib003,psib004,psib005,psib006,psib007,psib008);

grant select on psib_t to tiptop;
grant update on psib_t to tiptop;
grant delete on psib_t to tiptop;
grant insert on psib_t to tiptop;

exit;
