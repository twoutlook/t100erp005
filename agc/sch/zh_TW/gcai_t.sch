/* 
================================================================================
檔案代號:gcai_t
檔案名稱:券種基本資料檔-收券時間進階設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcai_t
(
gcaient       number(5)      ,/* 企業編號 */
gcai001       varchar2(10)      ,/* 券種編碼 */
gcai002       number(10,0)      ,/* 時段序 */
gcai003       date      ,/* 開始日期 */
gcai004       date      ,/* 結束日期 */
gcai005       varchar2(8)      ,/* 每日開始時間 */
gcai006       varchar2(8)      ,/* 每日結束時間 */
gcai007       varchar2(10)      ,/* 固定日期 */
gcai008       varchar2(10)      ,/* 固定星期 */
gcaistus       varchar2(1)      ,/* 有效 */
gcaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcai_t add constraint gcai_pk primary key (gcaient,gcai001,gcai002) enable validate;

create unique index gcai_pk on gcai_t (gcaient,gcai001,gcai002);

grant select on gcai_t to tiptop;
grant update on gcai_t to tiptop;
grant delete on gcai_t to tiptop;
grant insert on gcai_t to tiptop;

exit;
