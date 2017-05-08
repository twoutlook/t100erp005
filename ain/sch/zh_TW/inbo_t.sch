/* 
================================================================================
檔案代號:inbo_t
檔案名稱:裝箱單單身商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table inbo_t
(
inboent       number(5)      ,/* 企業編號 */
inbosite       varchar2(10)      ,/* 營運據點 */
inbounit       varchar2(10)      ,/* 物流中心 */
inbodocno       varchar2(20)      ,/* 單據編號 */
inbo001       varchar2(10)      ,/* 箱號 */
inbo002       number(10,0)      ,/* 項次 */
inbo003       varchar2(10)      ,/* 來源需求類型 */
inbo004       varchar2(20)      ,/* 來源需求單號 */
inbo005       number(10,0)      ,/* 來源需求項次 */
inbo006       varchar2(40)      ,/* 商品編號 */
inbo007       varchar2(30)      ,/* 產品特徵 */
inbo008       varchar2(10)      ,/* 單位 */
inbo009       number(20,6)      ,/* 裝箱數量 */
inbo010       varchar2(40)      ,/* 商品條碼 */
inbo011       number(10,0)      ,/* 來源項次 */
inboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbo_t add constraint inbo_pk primary key (inboent,inbodocno,inbo001,inbo002) enable validate;

create unique index inbo_pk on inbo_t (inboent,inbodocno,inbo001,inbo002);

grant select on inbo_t to tiptop;
grant update on inbo_t to tiptop;
grant delete on inbo_t to tiptop;
grant insert on inbo_t to tiptop;

exit;
