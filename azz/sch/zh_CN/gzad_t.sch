/* 
================================================================================
檔案代號:gzad_t
檔案名稱:應用分類參考欄位控制設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzad_t
(
gzad001       number(5)      ,/* 應用分類 */
gzad002       number(10,0)      ,/* 參考欄位編號 */
gzad003       varchar2(1)      ,/* 顯示否 */
gzad004       varchar2(1)      ,/* 可空白否 */
gzad005       varchar2(1)      ,/* 資料來源 */
gzad006       number(5)      ,/* 系統分類碼 */
gzad007       varchar2(20)      ,/* 建檔開窗 */
gzad008       varchar2(20)      ,/* 校驗帶值 */
gzad009       varchar2(1)      ,/* 形態 */
gzad010       varchar2(10)      ,/* 比較符號（最小值） */
gzad011       number(15,3)      ,/* 最小值 */
gzad012       varchar2(10)      ,/* 比較符號（最大值） */
gzad013       number(15,3)      ,/* 最大值 */
gzad014       varchar2(40)      ,/* 預設值 */
gzad015       varchar2(15)      ,/* 說明來源表 */
gzad016       varchar2(20)      ,/* 說明欄位代號 */
gzad017       varchar2(20)      ,/* 說明來源表Key欄位 */
gzadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzad_t add constraint gzad_pk primary key (gzad001,gzad002) enable validate;

create unique index gzad_pk on gzad_t (gzad001,gzad002);

grant select on gzad_t to tiptop;
grant update on gzad_t to tiptop;
grant delete on gzad_t to tiptop;
grant insert on gzad_t to tiptop;

exit;
