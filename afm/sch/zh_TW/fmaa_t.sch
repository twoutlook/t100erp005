/* 
================================================================================
檔案代號:fmaa_t
檔案名稱:融資類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmaa_t
(
fmaaent       number(5)      ,/* 企業編號 */
fmaa001       varchar2(10)      ,/* 融資類型 */
fmaa002       varchar2(1)      ,/* 是否計算 */
fmaa003       varchar2(1)      ,/* 類別 */
fmaa004       varchar2(1)      ,/* 融資費用處理方式 */
fmaaownid       varchar2(20)      ,/* 資料所有者 */
fmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
fmaacrtid       varchar2(20)      ,/* 資料建立者 */
fmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
fmaacrtdt       timestamp(0)      ,/* 資料創建日 */
fmaamodid       varchar2(20)      ,/* 資料修改者 */
fmaamoddt       timestamp(0)      ,/* 最近修改日 */
fmaastus       varchar2(10)      ,/* 狀態碼 */
fmaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmaa_t add constraint fmaa_pk primary key (fmaaent,fmaa001) enable validate;

create unique index fmaa_pk on fmaa_t (fmaaent,fmaa001);

grant select on fmaa_t to tiptop;
grant update on fmaa_t to tiptop;
grant delete on fmaa_t to tiptop;
grant insert on fmaa_t to tiptop;

exit;
