/* 
================================================================================
檔案代號:infd_t
檔案名稱:貨架商品關係申請表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table infd_t
(
infdent       number(5)      ,/* 企業編號 */
infdsite       varchar2(10)      ,/* 營運據點 */
infdunit       varchar2(10)      ,/* 應用組織 */
infddocno       varchar2(20)      ,/* 單據編號 */
infddocdt       date      ,/* 單據日期 */
infd001       varchar2(10)      ,/* 貨架類型 */
infd002       varchar2(20)      ,/* 申請人員 */
infd003       varchar2(10)      ,/* 申請部門 */
infdstus       varchar2(10)      ,/* 狀態 */
infdownid       varchar2(20)      ,/* 資料所有者 */
infdowndp       varchar2(10)      ,/* 資料所屬部門 */
infdcrtid       varchar2(20)      ,/* 資料建立者 */
infdcrtdp       varchar2(10)      ,/* 資料建立部門 */
infdcrtdt       timestamp(0)      ,/* 資料創建日 */
infdmodid       varchar2(20)      ,/* 資料修改者 */
infdmoddt       timestamp(0)      ,/* 最近修改日 */
infdcnfid       varchar2(20)      ,/* 資料確認者 */
infdcnfdt       timestamp(0)      ,/* 資料確認日 */
infdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infd_t add constraint infd_pk primary key (infdent,infddocno) enable validate;

create unique index infd_pk on infd_t (infdent,infddocno);

grant select on infd_t to tiptop;
grant update on infd_t to tiptop;
grant delete on infd_t to tiptop;
grant insert on infd_t to tiptop;

exit;
