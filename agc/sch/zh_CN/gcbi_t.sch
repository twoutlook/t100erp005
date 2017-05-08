/* 
================================================================================
檔案代號:gcbi_t
檔案名稱:券銷售資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gcbi_t
(
gcbient       number(5)      ,/* 企業編號 */
gcbisite       varchar2(10)      ,/* 營運據點 */
gcbidocno       varchar2(20)      ,/* 單據編號 */
gcbiseq       number(10,0)      ,/* 項次 */
gcbiseq1       number(10,0)      ,/* 序 */
gcbi001       varchar2(30)      ,/* 開始券號 */
gcbi002       varchar2(30)      ,/* 結束券號 */
gcbi003       varchar2(10)      ,/* 券種 */
gcbi004       varchar2(10)      ,/* 券面額編號 */
gcbi005       number(20,6)      ,/* 券張數 */
gcbi006       number(20,6)      ,/* 券總金額 */
gcbi007       varchar2(10)      ,/* 庫區 */
gcbi008       varchar2(30)      ,/* 指定對應會員卡號 */
gcbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcbiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gcbi009       number(20,6)      /* 售券折扣 */
);
alter table gcbi_t add constraint gcbi_pk primary key (gcbient,gcbidocno,gcbiseq,gcbiseq1) enable validate;

create unique index gcbi_pk on gcbi_t (gcbient,gcbidocno,gcbiseq,gcbiseq1);

grant select on gcbi_t to tiptop;
grant update on gcbi_t to tiptop;
grant delete on gcbi_t to tiptop;
grant insert on gcbi_t to tiptop;

exit;
