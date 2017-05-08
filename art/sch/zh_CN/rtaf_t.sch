/* 
================================================================================
檔案代號:rtaf_t
檔案名稱:品類策略異動申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtaf_t
(
rtafent       number(5)      ,/* 企業編號 */
rtafdocno       varchar2(20)      ,/* 單號 */
rtafdocdt       date      ,/* 單據日期 */
rtaf000       varchar2(10)      ,/* 作業方式 */
rtaf001       varchar2(10)      ,/* 策略編號 */
rtaf002       varchar2(10)      ,/* 店群編號 */
rtaf003       number(5,0)      ,/* 品類層級 */
rtaf004       varchar2(20)      ,/* 申請人員 */
rtaf005       varchar2(10)      ,/* 申請部門 */
rtafacti       varchar2(1)      ,/* 資料有效碼 */
rtafownid       varchar2(20)      ,/* 資料所有者 */
rtafowndp       varchar2(10)      ,/* 資料所屬部門 */
rtafcrtid       varchar2(20)      ,/* 資料建立者 */
rtafcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtafcrtdt       timestamp(0)      ,/* 資料創建日 */
rtafmodid       varchar2(20)      ,/* 資料修改者 */
rtafmoddt       timestamp(0)      ,/* 最近修改日 */
rtafcnfid       varchar2(20)      ,/* 資料確認者 */
rtafcnfdt       timestamp(0)      ,/* 資料確認日 */
rtafstus       varchar2(10)      ,/* 狀態碼 */
rtafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtafsite       varchar2(10)      ,/* 營運據點 */
rtafunit       varchar2(10)      ,/* 應用組織 */
rtaf006       varchar2(10)      /* 引用參考門店 */
);
alter table rtaf_t add constraint rtaf_pk primary key (rtafent,rtafdocno) enable validate;

create unique index rtaf_pk on rtaf_t (rtafent,rtafdocno);

grant select on rtaf_t to tiptop;
grant update on rtaf_t to tiptop;
grant delete on rtaf_t to tiptop;
grant insert on rtaf_t to tiptop;

exit;
