/* 
================================================================================
檔案代號:prbo_t
檔案名稱:門店商品捆綁單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbo_t
(
prboent       number(5)      ,/* 企業編號 */
prbounit       varchar2(10)      ,/* 應用組織 */
prbosite       varchar2(10)      ,/* 營運據點 */
prbodocno       varchar2(20)      ,/* 單據編號 */
prbodocdt       date      ,/* 單據日期 */
prbo001       varchar2(10)      ,/* 管理品類 */
prbo002       date      ,/* 開始日期 */
prbo003       date      ,/* 結束日期 */
prbo004       varchar2(40)      ,/* 捆綁條碼 */
prbo005       varchar2(80)      ,/* 捆綁說明 */
prbo006       number(20,6)      ,/* 捆綁價格 */
prbo007       varchar2(10)      ,/* 捆綁單位 */
prbo008       number(20,6)      ,/* 折讓額 */
prbo009       number(20,6)      ,/* 折扣率 */
prbo010       number(20,6)      ,/* 成本價 */
prbo011       number(20,6)      ,/* 毛利率 */
prbo012       varchar2(20)      ,/* 人員 */
prbo013       varchar2(10)      ,/* 部門 */
prbo014       varchar2(255)      ,/* 備註 */
prbostus       varchar2(10)      ,/* 狀態碼 */
prboownid       varchar2(20)      ,/* 資料所有者 */
prboowndp       varchar2(10)      ,/* 資料所屬部門 */
prbocrtid       varchar2(20)      ,/* 資料建立者 */
prbocrtdp       varchar2(10)      ,/* 資料建立部門 */
prbocrtdt       timestamp(0)      ,/* 資料創建日 */
prbomodid       varchar2(20)      ,/* 資料修改者 */
prbomoddt       timestamp(0)      ,/* 最近修改日 */
prbocnfid       varchar2(20)      ,/* 資料確認者 */
prbocnfdt       timestamp(0)      ,/* 資料確認日 */
prboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prboud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbo015       varchar2(10)      /* 稅別 */
);
alter table prbo_t add constraint prbo_pk primary key (prboent,prbodocno) enable validate;

create  index prbo_n on prbo_t (prboent,prbosite,prbo002);
create unique index prbo_pk on prbo_t (prboent,prbodocno);

grant select on prbo_t to tiptop;
grant update on prbo_t to tiptop;
grant delete on prbo_t to tiptop;
grant insert on prbo_t to tiptop;

exit;
