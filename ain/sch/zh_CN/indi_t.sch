/* 
================================================================================
檔案代號:indi_t
檔案名稱:配送單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indi_t
(
indient       number(5)      ,/* 企業編號 */
indisite       varchar2(10)      ,/* 營運據點 */
indiunit       varchar2(10)      ,/* 應用組織 */
indidocno       varchar2(20)      ,/* 單據編號 */
indidocdt       date      ,/* 單據日期 */
indi001       date      ,/* 需求日期 */
indi002       varchar2(10)      ,/* 配送路線 */
indi003       varchar2(20)      ,/* 物流人員 */
indi004       varchar2(10)      ,/* 物流部門 */
indi005       varchar2(255)      ,/* 備註 */
indistus       varchar2(10)      ,/* 狀態 */
indiownid       varchar2(20)      ,/* 資料所有者 */
indiowndp       varchar2(10)      ,/* 資料所屬部門 */
indicrtid       varchar2(20)      ,/* 資料建立者 */
indicrtdp       varchar2(10)      ,/* 資料建立部門 */
indicrtdt       timestamp(0)      ,/* 資料創建日 */
indimodid       varchar2(20)      ,/* 資料修改者 */
indimoddt       timestamp(0)      ,/* 最近修改日 */
indicnfid       varchar2(20)      ,/* 資料確認者 */
indicnfdt       timestamp(0)      ,/* 資料確認日 */
indiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
indi000       varchar2(10)      ,/* 單據性質 */
indi006       varchar2(10)      /* 收貨時段 */
);
alter table indi_t add constraint indi_pk primary key (indient,indidocno) enable validate;

create unique index indi_pk on indi_t (indient,indidocno);

grant select on indi_t to tiptop;
grant update on indi_t to tiptop;
grant delete on indi_t to tiptop;
grant insert on indi_t to tiptop;

exit;
