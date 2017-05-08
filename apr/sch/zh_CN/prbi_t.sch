/* 
================================================================================
檔案代號:prbi_t
檔案名稱:生鮮調價單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbi_t
(
prbient       number(5)      ,/* 企業編號 */
prbiunit       varchar2(10)      ,/* 應用組織 */
prbisite       varchar2(10)      ,/* 營運據點 */
prbidocno       varchar2(20)      ,/* 單據編號 */
prbidocdt       date      ,/* 單據日期 */
prbi001       varchar2(10)      ,/* 供應商編號 */
prbi002       varchar2(10)      ,/* 管理品類 */
prbi003       date      ,/* 執行日期 */
prbi004       varchar2(20)      ,/* 人員 */
prbi005       varchar2(10)      ,/* 部門 */
prbi006       varchar2(255)      ,/* 備註 */
prbistus       varchar2(10)      ,/* 狀態碼 */
prbiownid       varchar2(20)      ,/* 資料所有者 */
prbiowndp       varchar2(10)      ,/* 資料所有部門 */
prbicrtid       varchar2(20)      ,/* 資料建立者 */
prbicrtdp       varchar2(10)      ,/* 資料建立部門 */
prbicrtdt       timestamp(0)      ,/* 資料創建日 */
prbimodid       varchar2(20)      ,/* 資料修改者 */
prbimoddt       timestamp(0)      ,/* 最近修改日 */
prbicnfid       varchar2(20)      ,/* 資料確認者 */
prbicnfdt       timestamp(0)      ,/* 資料確認日 */
prbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbi000       varchar2(10)      /* 單據類型 */
);
alter table prbi_t add constraint prbi_pk primary key (prbient,prbidocno) enable validate;

create unique index prbi_pk on prbi_t (prbient,prbidocno);

grant select on prbi_t to tiptop;
grant update on prbi_t to tiptop;
grant delete on prbi_t to tiptop;
grant insert on prbi_t to tiptop;

exit;
