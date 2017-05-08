/* 
================================================================================
檔案代號:info_t
檔案名稱:隨貨同行單單身擋-明細匯總
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table info_t
(
infoent       number(5)      ,/* 企業編號 */
infosite       varchar2(10)      ,/* 營運據點 */
infounit       varchar2(10)      ,/* 應用組織 */
infodocno       varchar2(20)      ,/* 隨貨同行單號 */
infoseq       number(10,0)      ,/* 項次 */
info001       varchar2(40)      ,/* 商品編號 */
info002       varchar2(40)      ,/* 商品條碼 */
info003       varchar2(256)      ,/* 產品特徵 */
info004       varchar2(10)      ,/* 經營方式 */
info005       varchar2(10)      ,/* 庫存單位 */
info006       varchar2(10)      ,/* 包裝單位 */
info007       number(20,6)      ,/* 撥出包裝數量 */
info008       number(20,6)      ,/* 撥出庫存數量 */
info009       varchar2(10)      ,/* 撥出庫位 */
info010       varchar2(10)      ,/* 撥出儲位 */
info011       varchar2(30)      ,/* 撥出批號 */
info012       number(20,6)      ,/* 撥入包裝數量 */
info013       number(20,6)      ,/* 撥入庫存數量 */
info014       varchar2(10)      ,/* 撥入庫位 */
info015       varchar2(10)      ,/* 撥入儲位 */
info016       varchar2(30)      ,/* 撥入批號 */
infoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table info_t add constraint info_pk primary key (infoent,infodocno,infoseq) enable validate;

create unique index info_pk on info_t (infoent,infodocno,infoseq);

grant select on info_t to tiptop;
grant update on info_t to tiptop;
grant delete on info_t to tiptop;
grant insert on info_t to tiptop;

exit;
