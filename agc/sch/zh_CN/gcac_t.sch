/* 
================================================================================
檔案代號:gcac_t
檔案名稱:券種基本資料申請檔-折價券收券限定商品設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcac_t
(
gcacent       number(5)      ,/* 企業編號 */
gcacsite       varchar2(10)      ,/* 營運據點 */
gcacunit       varchar2(10)      ,/* 應用組織 */
gcacdocno       varchar2(20)      ,/* 單據編號 */
gcac000       varchar2(10)      ,/* 申請類別 */
gcac001       varchar2(10)      ,/* 券種編碼 */
gcac002       varchar2(10)      ,/* 折價指定類型 */
gcac003       varchar2(40)      ,/* 折價指定類編碼 */
gcacacti       varchar2(1)      ,/* 有效 */
gcacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcac_t add constraint gcac_pk primary key (gcacent,gcacdocno,gcac002,gcac003) enable validate;

create unique index gcac_pk on gcac_t (gcacent,gcacdocno,gcac002,gcac003);

grant select on gcac_t to tiptop;
grant update on gcac_t to tiptop;
grant delete on gcac_t to tiptop;
grant insert on gcac_t to tiptop;

exit;
