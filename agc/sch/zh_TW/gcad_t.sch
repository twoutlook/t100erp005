/* 
================================================================================
檔案代號:gcad_t
檔案名稱:券種基本資料申請檔-收券時間進階設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcad_t
(
gcadent       number(5)      ,/* 企業編號 */
gcadsite       varchar2(10)      ,/* 營運據點 */
gcadunit       varchar2(10)      ,/* 應用組織 */
gcaddocno       varchar2(20)      ,/* 單據編號 */
gcad000       varchar2(10)      ,/* 申請類別 */
gcad001       varchar2(10)      ,/* 券種編碼 */
gcad002       number(10,0)      ,/* 時段序 */
gcad003       date      ,/* 開始日期 */
gcad004       date      ,/* 結束日期 */
gcad005       varchar2(8)      ,/* 每日開始時間 */
gcad006       varchar2(8)      ,/* 每日結束時間 */
gcad007       varchar2(10)      ,/* 固定日期 */
gcad008       varchar2(10)      ,/* 固定星期 */
gcadacti       varchar2(1)      ,/* 有效 */
gcadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcad_t add constraint gcad_pk primary key (gcadent,gcaddocno,gcad002) enable validate;

create unique index gcad_pk on gcad_t (gcadent,gcaddocno,gcad002);

grant select on gcad_t to tiptop;
grant update on gcad_t to tiptop;
grant delete on gcad_t to tiptop;
grant insert on gcad_t to tiptop;

exit;
