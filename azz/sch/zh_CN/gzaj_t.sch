/* 
================================================================================
檔案代號:gzaj_t
檔案名稱:應用分類客製參考欄位控制設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzaj_t
(
gzaj001       number(5)      ,/* 應用分類 */
gzaj002       number(10,0)      ,/* 客製參考欄位編號 */
gzaj003       varchar2(1)      ,/* 顯示否 */
gzaj004       varchar2(1)      ,/* 可空白否 */
gzaj005       varchar2(1)      ,/* 資料來源 */
gzaj006       number(5)      ,/* 系統分類碼 */
gzaj007       varchar2(20)      ,/* 建檔開窗 */
gzaj008       varchar2(20)      ,/* 校驗帶值 */
gzaj009       varchar2(1)      ,/* 型態 */
gzaj010       varchar2(10)      ,/* 比較符號(最小值) */
gzaj011       number(15,3)      ,/* 最小值 */
gzaj012       varchar2(10)      ,/* 比較符號(最大值) */
gzaj013       number(15,3)      ,/* 最大值 */
gzaj014       varchar2(40)      ,/* 預設值 */
gzaj015       varchar2(15)      ,/* 說明來源表 */
gzaj016       varchar2(20)      ,/* 說明欄位代號 */
gzaj017       varchar2(20)      ,/* 說明來源表Key欄位 */
gzajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzaj_t add constraint gzaj_pk primary key (gzaj001,gzaj002) enable validate;

create unique index gzaj_pk on gzaj_t (gzaj001,gzaj002);

grant select on gzaj_t to tiptop;
grant update on gzaj_t to tiptop;
grant delete on gzaj_t to tiptop;
grant insert on gzaj_t to tiptop;

exit;
