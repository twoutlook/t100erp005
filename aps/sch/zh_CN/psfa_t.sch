/* 
================================================================================
檔案代號:psfa_t
檔案名稱:集團MRP版本單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table psfa_t
(
psfaent       number(5)      ,/* 企業編號 */
psfa001       varchar2(10)      ,/* 集團MRP版本 */
psfa002       varchar2(10)      ,/* 庫存保留天數 */
psfa003       number(5,0)      ,/* 固定保留天數 */
psfa004       varchar2(10)      ,/* 建議撥入順序 */
psfa005       varchar2(10)      ,/* 建議撥出順序 */
psfa006       varchar2(1)      ,/* 考慮最小調撥量與調撥批量 */
psfa007       varchar2(10)      ,/* 合併時距 */
psfa008       varchar2(1)      ,/* 產生庫存調撥建議 */
psfaownid       varchar2(20)      ,/* 資料所有者 */
psfaowndp       varchar2(10)      ,/* 資料所屬部門 */
psfacrtid       varchar2(20)      ,/* 資料建立者 */
psfacrtdp       varchar2(10)      ,/* 資料建立部門 */
psfacrtdt       timestamp(0)      ,/* 資料創建日 */
psfamodid       varchar2(20)      ,/* 資料修改者 */
psfamoddt       timestamp(0)      ,/* 最近修改日 */
psfastus       varchar2(10)      ,/* 狀態碼 */
psfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psfa_t add constraint psfa_pk primary key (psfaent,psfa001) enable validate;

create unique index psfa_pk on psfa_t (psfaent,psfa001);

grant select on psfa_t to tiptop;
grant update on psfa_t to tiptop;
grant delete on psfa_t to tiptop;
grant insert on psfa_t to tiptop;

exit;
