/* 
================================================================================
檔案代號:dedc_t
檔案名稱:作廢發票缺單維護作業單頭
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table dedc_t
(
dedcent       number(5)      ,/* 企業編號 */
dedcsite       varchar2(10)      ,/* 營運據點 */
dedcunit       varchar2(10)      ,/* 應用組織 */
dedcdocdt       date      ,/* 單據日期 */
dedcdocno       varchar2(20)      ,/* 單據編號 */
dedc001       varchar2(10)      ,/* 部門 */
dedc002       varchar2(20)      ,/* 人員 */
dedc003       varchar2(80)      ,/* 備註 */
dedcownid       varchar2(20)      ,/* 資料所有者 */
dedcowndp       varchar2(10)      ,/* 資料所屬部門 */
dedccrtid       varchar2(20)      ,/* 資料建立者 */
dedccrtdp       varchar2(10)      ,/* 資料建立部門 */
dedccrtdt       timestamp(0)      ,/* 資料創建日 */
dedcmodid       varchar2(20)      ,/* 資料修改者 */
dedcmoddt       timestamp(0)      ,/* 最近修改日 */
dedccnfid       varchar2(20)      ,/* 資料確認者 */
dedccnfdt       timestamp(0)      ,/* 資料確認日 */
dedcstus       varchar2(10)      ,/* 狀態碼 */
dedcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dedcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dedcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dedcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dedcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dedcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dedcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dedcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dedcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dedcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dedcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dedcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dedcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dedcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dedcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dedcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dedcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dedcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dedcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dedcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dedcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dedcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dedcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dedcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dedcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dedcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dedcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dedcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dedcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dedcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dedc_t add constraint dedc_pk primary key (dedcent,dedcdocno) enable validate;

create unique index dedc_pk on dedc_t (dedcent,dedcdocno);

grant select on dedc_t to tiptop;
grant update on dedc_t to tiptop;
grant delete on dedc_t to tiptop;
grant insert on dedc_t to tiptop;

exit;
