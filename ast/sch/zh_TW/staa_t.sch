/* 
================================================================================
檔案代號:staa_t
檔案名稱:結算方式基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table staa_t
(
staaent       number(5)      ,/* 企業編號 */
staa001       varchar2(10)      ,/* 結算方式編號 */
staa002       number(10,0)      ,/* 加月數 */
staa003       number(10,0)      ,/* 加天數 */
staa004       varchar2(10)      ,/* 帳期方式 */
staastus       varchar2(10)      ,/* 狀態碼 */
staaownid       varchar2(20)      ,/* 資料所有者 */
staaowndp       varchar2(10)      ,/* 資料所有部門 */
staacrtid       varchar2(20)      ,/* 資料建立者 */
staacrtdp       varchar2(10)      ,/* 資料建立部門 */
staacrtdt       timestamp(0)      ,/* 資料創建日 */
staamodid       varchar2(20)      ,/* 資料修改者 */
staamoddt       timestamp(0)      ,/* 最近修改日 */
staaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
staa005       number(10,0)      ,/* 月拆分期數 */
staa006       number(10,0)      /* 預付款加天 */
);
alter table staa_t add constraint staa_pk primary key (staaent,staa001) enable validate;

create unique index staa_pk on staa_t (staaent,staa001);

grant select on staa_t to tiptop;
grant update on staa_t to tiptop;
grant delete on staa_t to tiptop;
grant insert on staa_t to tiptop;

exit;
