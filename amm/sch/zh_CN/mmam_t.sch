/* 
================================================================================
檔案代號:mmam_t
檔案名稱:卡券生效申請檔營運據點設定申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmam_t
(
mmament       number(5)      ,/* 企業編號 */
mmamdocno       varchar2(20)      ,/* 單據編號 */
mmam000       varchar2(10)      ,/* 申請類別 */
mmam001       varchar2(20)      ,/* 程式編號 */
mmam002       varchar2(10)      ,/* 卡種/券種 */
mmam003       varchar2(10)      ,/* 生效營運據點 */
mmam004       number(20,6)      ,/* 卡/券安全庫量 */
mmam005       varchar2(1)      ,/* 包括組織以下所有營運據點 */
mmam006       varchar2(1)      ,/* 上級發佈卡儲值規則自行確認 */
mmam007       varchar2(1)      ,/* 上級發佈卡積點規則自行確認 */
mmamacti       varchar2(1)      ,/* 有效 */
mmamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmam_t add constraint mmam_pk primary key (mmament,mmamdocno,mmam003) enable validate;

create unique index mmam_pk on mmam_t (mmament,mmamdocno,mmam003);

grant select on mmam_t to tiptop;
grant update on mmam_t to tiptop;
grant delete on mmam_t to tiptop;
grant insert on mmam_t to tiptop;

exit;
