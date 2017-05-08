/* 
================================================================================
檔案代號:bgca_t
檔案名稱:銷售模擬因子主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgca_t
(
bgcaent       number(5)      ,/* 企業編號 */
bgca001       varchar2(10)      ,/* 影響因子編號 */
bgca002       varchar2(10)      ,/* 影響標的 */
bgca003       varchar2(10)      ,/* 影響方式 */
bgcastus       varchar2(10)      ,/* 狀態碼 */
bgcaownid       varchar2(20)      ,/* 資料所有者 */
bgcaowndp       varchar2(10)      ,/* 資料所屬部門 */
bgcacrtid       varchar2(20)      ,/* 資料建立者 */
bgcacrtdp       varchar2(10)      ,/* 資料建立部門 */
bgcacrtdt       timestamp(0)      ,/* 資料創建日 */
bgcamodid       varchar2(20)      ,/* 資料修改者 */
bgcamoddt       timestamp(0)      ,/* 最近修改日 */
bgcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgca_t add constraint bgca_pk primary key (bgcaent,bgca001) enable validate;

create unique index bgca_pk on bgca_t (bgcaent,bgca001);

grant select on bgca_t to tiptop;
grant update on bgca_t to tiptop;
grant delete on bgca_t to tiptop;
grant insert on bgca_t to tiptop;

exit;
