/* 
================================================================================
檔案代號:infi_t
檔案名稱:貨架商品數量調整
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table infi_t
(
infient       number(5)      ,/* 企業編號 */
infisite       varchar2(10)      ,/* 營運據點 */
infiunit       varchar2(10)      ,/* 應用組織 */
infidocno       varchar2(20)      ,/* 單據編號 */
infidocdt       date      ,/* 單據日期 */
infi001       varchar2(10)      ,/* 單據類型 */
infi002       varchar2(10)      ,/* 貨架類型 */
infi003       varchar2(20)      ,/* 業務人員 */
infi004       varchar2(10)      ,/* 業務部門 */
infistus       varchar2(10)      ,/* 狀態 */
infiownid       varchar2(20)      ,/* 資料所有者 */
infiowndp       varchar2(10)      ,/* 資料所屬部門 */
inficrtid       varchar2(20)      ,/* 資料建立者 */
inficrtdp       varchar2(10)      ,/* 資料建立部門 */
inficrtdt       timestamp(0)      ,/* 資料創建日 */
infimodid       varchar2(20)      ,/* 資料修改者 */
infimoddt       timestamp(0)      ,/* 最近修改日 */
inficnfid       varchar2(20)      ,/* 資料確認者 */
inficnfdt       timestamp(0)      ,/* 資料確認日 */
infiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infi_t add constraint infi_pk primary key (infient,infidocno) enable validate;

create unique index infi_pk on infi_t (infient,infidocno);

grant select on infi_t to tiptop;
grant update on infi_t to tiptop;
grant delete on infi_t to tiptop;
grant insert on infi_t to tiptop;

exit;
