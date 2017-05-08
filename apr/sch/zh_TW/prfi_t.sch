/* 
================================================================================
檔案代號:prfi_t
檔案名稱:客戶定價申請維護作業
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prfi_t
(
prfient       number(5)      ,/* 企業編號 */
prfiunit       varchar2(10)      ,/* 應用組織 */
prfisite       varchar2(10)      ,/* 營運據點 */
prfidocno       varchar2(20)      ,/* 申請單號 */
prfidocdt       date      ,/* 申請日期 */
prfi001       varchar2(10)      ,/* 價格類型 */
prfi002       varchar2(10)      ,/* 幣別 */
prfi003       varchar2(10)      ,/* 稅別 */
prfi004       date      ,/* 生效日期 */
prfi005       date      ,/* 失效日期 */
prfi006       varchar2(20)      ,/* 申請人員 */
prfi007       varchar2(10)      ,/* 申請部門 */
prfistus       varchar2(10)      ,/* 狀態碼 */
prfiownid       varchar2(20)      ,/* 資料所有者 */
prfiowndp       varchar2(10)      ,/* 資料所屬部門 */
prficrtid       varchar2(20)      ,/* 資料建立者 */
prficrtdp       varchar2(10)      ,/* 資料建立部門 */
prficrtdt       timestamp(0)      ,/* 資料創建日 */
prfimodid       varchar2(20)      ,/* 資料修改者 */
prfimoddt       timestamp(0)      ,/* 最近修改日 */
prficnfid       varchar2(20)      ,/* 資料確認者 */
prficnfdt       timestamp(0)      ,/* 資料確認日 */
prfiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prfiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prfiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prfiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prfiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prfiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prfiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prfiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prfiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prfiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prfiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prfiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prfiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prfiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prfiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prfiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prfiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prfiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prfiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prfiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prfiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prfiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prfiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prfiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prfiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prfiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prfiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prfiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prfiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prfiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prfi008       number(20,6)      /* 折扣率% */
);
alter table prfi_t add constraint prfi_pk primary key (prfient,prfidocno) enable validate;

create unique index prfi_pk on prfi_t (prfient,prfidocno);

grant select on prfi_t to tiptop;
grant update on prfi_t to tiptop;
grant delete on prfi_t to tiptop;
grant insert on prfi_t to tiptop;

exit;
