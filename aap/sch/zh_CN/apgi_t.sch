/* 
================================================================================
檔案代號:apgi_t
檔案名稱:裝船通知單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apgi_t
(
apgient       number(5)      ,/* 企業編號 */
apgicomp       varchar2(10)      ,/* 法人 */
apgidocno       varchar2(20)      ,/* 通知單號 */
apgidocdt       date      ,/* 通知日期 */
apgi001       varchar2(10)      ,/* 供應商編號 */
apgi002       varchar2(20)      ,/* 申請單號 */
apgi003       varchar2(20)      ,/* L/C NO */
apgi004       varchar2(20)      ,/* 業務人員 */
apgi005       varchar2(10)      ,/* 運送方式 */
apgi006       date      ,/* 裝運(結關)日期 */
apgi007       varchar2(20)      ,/* S/O NO.(裝運單號) */
apgi008       varchar2(255)      ,/* 船名/航次 */
apgi009       varchar2(10)      ,/* 運輸公司 */
apgi010       varchar2(255)      ,/* 結關地 */
apgi011       varchar2(255)      ,/* 目的地 */
apgi012       date      ,/* 開航日期 */
apgi013       date      ,/* 預計抵達日 */
apgi014       varchar2(255)      ,/* 領櫃地點 */
apgi015       varchar2(255)      ,/* 領櫃編號 */
apgi016       varchar2(255)      ,/* 交櫃地點 */
apgi017       varchar2(80)      ,/* 櫃量 */
apgi018       varchar2(255)      ,/* 備註 */
apgiownid       varchar2(20)      ,/* 資料所有者 */
apgiowndp       varchar2(10)      ,/* 資料所屬部門 */
apgicrtid       varchar2(20)      ,/* 資料建立者 */
apgicrtdp       varchar2(10)      ,/* 資料建立部門 */
apgicrtdt       timestamp(0)      ,/* 資料創建日 */
apgimodid       varchar2(20)      ,/* 資料修改者 */
apgimoddt       timestamp(0)      ,/* 最近修改日 */
apgicnfid       varchar2(20)      ,/* 資料確認者 */
apgicnfdt       timestamp(0)      ,/* 資料確認日 */
apgipstid       varchar2(20)      ,/* 資料過帳者 */
apgipstdt       timestamp(0)      ,/* 資料過帳日 */
apgistus       varchar2(10)      ,/* 狀態碼 */
apgiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgi019       varchar2(20)      /* 帳務單號 */
);
alter table apgi_t add constraint apgi_pk primary key (apgient,apgicomp,apgidocno) enable validate;

create unique index apgi_pk on apgi_t (apgient,apgicomp,apgidocno);

grant select on apgi_t to tiptop;
grant update on apgi_t to tiptop;
grant delete on apgi_t to tiptop;
grant insert on apgi_t to tiptop;

exit;
