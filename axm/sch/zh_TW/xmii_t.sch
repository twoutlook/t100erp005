/* 
================================================================================
檔案代號:xmii_t
檔案名稱:銷售預測單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmii_t
(
xmiient       number(5)      ,/* 企業編號 */
xmii001       varchar2(10)      ,/* 預測編號 */
xmii002       date      ,/* 預測起始日 */
xmii003       number(5,0)      ,/* 版本 */
xmii004       varchar2(10)      ,/* 本層組織 */
xmii005       varchar2(10)      ,/* 上層組織 */
xmii006       varchar2(10)      ,/* 預測營運據點 */
xmii007       varchar2(20)      ,/* 銷售組織 */
xmii008       varchar2(20)      ,/* 業務員 */
xmii009       varchar2(40)      ,/* 預測料號 */
xmii010       varchar2(256)      ,/* 產品特徵 */
xmii011       varchar2(10)      ,/* 產品分類 */
xmii012       varchar2(10)      ,/* 客戶 */
xmii013       varchar2(10)      ,/* 通路 */
xmii014       number(5,0)      ,/* 期別 */
xmii015       date      ,/* 起始日期 */
xmii016       date      ,/* 截止日期 */
xmii017       varchar2(10)      ,/* 單位 */
xmii018       number(20,6)      ,/* 預測數量 */
xmii019       number(20,6)      ,/* 調整量 */
xmii020       number(20,6)      ,/* 總數量 */
xmii021       number(20,6)      ,/* 單價 */
xmii022       number(20,6)      ,/* 金額 */
xmii023       number(20,6)      ,/* 調整金額 */
xmii024       number(20,6)      ,/* 總金額 */
xmiiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmiiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmiiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmiiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmiiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmiiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmiiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmiiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmiiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmiiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmiiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmiiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmiiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmiiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmiiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmiiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmiiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmiiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmiiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmiiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmiiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmiiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmiiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmiiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmiiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmiiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmiiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmiiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmiiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmiiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmii_t add constraint xmii_pk primary key (xmiient,xmii001,xmii002,xmii003,xmii004,xmii006,xmii007,xmii008,xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii017) enable validate;

create unique index xmii_pk on xmii_t (xmiient,xmii001,xmii002,xmii003,xmii004,xmii006,xmii007,xmii008,xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii017);

grant select on xmii_t to tiptop;
grant update on xmii_t to tiptop;
grant delete on xmii_t to tiptop;
grant insert on xmii_t to tiptop;

exit;
