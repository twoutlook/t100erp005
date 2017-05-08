/* 
================================================================================
檔案代號:gcae_t
檔案名稱:券種基本資料申請檔-收券營運組織進階設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcae_t
(
gcaeent       number(5)      ,/* 企業編號 */
gcaesite       varchar2(10)      ,/* 營運據點 */
gcaeunit       varchar2(10)      ,/* 應用組織 */
gcaedocno       varchar2(20)      ,/* 單據編號 */
gcae000       varchar2(10)      ,/* 申請類別 */
gcae001       varchar2(10)      ,/* 券種編碼 */
gcae002       varchar2(10)      ,/* 限定營運組織 */
gcae003       varchar2(1)      ,/* 包含以下所有組織 */
gcaeacti       varchar2(1)      ,/* 有效 */
gcaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcae_t add constraint gcae_pk primary key (gcaeent,gcaedocno,gcae002) enable validate;

create unique index gcae_pk on gcae_t (gcaeent,gcaedocno,gcae002);

grant select on gcae_t to tiptop;
grant update on gcae_t to tiptop;
grant delete on gcae_t to tiptop;
grant insert on gcae_t to tiptop;

exit;
