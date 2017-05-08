/* 
================================================================================
檔案代號:ooeb_t
檔案名稱:組織計劃申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ooeb_t
(
ooebent       number(5)      ,/* 企業編號 */
ooebstus       varchar2(10)      ,/* 狀態碼 */
ooeb001       varchar2(10)      ,/* 申請編號 */
ooeb002       date      ,/* 申請日期 */
ooeb003       varchar2(10)      ,/* 變更類型 */
ooeb004       varchar2(10)      ,/* 組織類型 */
ooeb005       varchar2(10)      ,/* 最上層組織 */
ooeb006       varchar2(10)      ,/* 版本 */
ooeb007       date      ,/* 生效日期 */
ooeb008       date      ,/* 失效日期 */
ooebownid       varchar2(20)      ,/* 資料所有者 */
ooebowndp       varchar2(10)      ,/* 資料所屬部門 */
ooebcrtid       varchar2(20)      ,/* 資料建立者 */
ooebcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooebcrtdt       timestamp(0)      ,/* 資料創建日 */
ooebmodid       varchar2(20)      ,/* 資料修改者 */
ooebmoddt       timestamp(0)      ,/* 最近修改日 */
ooebcnfid       varchar2(20)      ,/* 資料確認者 */
ooebcnfdt       timestamp(0)      ,/* 資料確認日 */
ooebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooeb_t add constraint ooeb_pk primary key (ooebent,ooeb001) enable validate;

create unique index ooeb_pk on ooeb_t (ooebent,ooeb001);

grant select on ooeb_t to tiptop;
grant update on ooeb_t to tiptop;
grant delete on ooeb_t to tiptop;
grant insert on ooeb_t to tiptop;

exit;
