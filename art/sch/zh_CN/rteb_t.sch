/* 
================================================================================
檔案代號:rteb_t
檔案名稱:市場調查計畫資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rteb_t
(
rtebent       number(5)      ,/* 企業編號 */
rtebsite       varchar2(10)      ,/* 營運據點 */
rtebdocno       varchar2(20)      ,/* 單據編號 */
rtebdocdt       date      ,/* 單據日期 */
rteb001       varchar2(10)      ,/* 市調門店 */
rteb002       varchar2(10)      ,/* 競爭門店 */
rteb003       number(10)      ,/* 市調類型 */
rteb004       date      ,/* 開始日期 */
rteb005       date      ,/* 結束日期 */
rteb006       varchar2(20)      ,/* 計劃人員 */
rteb007       varchar2(255)      ,/* 備註 */
rtebstus       varchar2(10)      ,/* 狀態碼 */
rtebownid       varchar2(20)      ,/* 資料所有者 */
rtebowndp       varchar2(10)      ,/* 資料所屬部門 */
rtebcrtid       varchar2(20)      ,/* 資料建立者 */
rtebcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtebcrtdt       timestamp(0)      ,/* 資料創建日 */
rtebmodid       varchar2(20)      ,/* 資料修改者 */
rtebmoddt       timestamp(0)      ,/* 最近修改日 */
rtebcnfid       varchar2(20)      ,/* 資料確認者 */
rtebcnfdt       timestamp(0)      ,/* 資料確認日 */
rtebunit       varchar2(10)      ,/* 應用組織 */
rtebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rteb_t add constraint rteb_pk primary key (rtebent,rtebdocno) enable validate;

create unique index rteb_pk on rteb_t (rtebent,rtebdocno);

grant select on rteb_t to tiptop;
grant update on rteb_t to tiptop;
grant delete on rteb_t to tiptop;
grant insert on rteb_t to tiptop;

exit;
