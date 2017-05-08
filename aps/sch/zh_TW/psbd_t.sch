/* 
================================================================================
檔案代號:psbd_t
檔案名稱:MDS銷售預測沖銷單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psbd_t
(
psbdent       number(5)      ,/* 企業編號 */
psbdsite       varchar2(10)      ,/* 營運據點 */
psbd001       varchar2(10)      ,/* MDS編號 */
psbd002       varchar2(10)      ,/* 預測組織 */
psbd003       varchar2(20)      ,/* 業務員 */
psbd004       varchar2(40)      ,/* 預測料號 */
psbd005       varchar2(256)      ,/* 產品特徵 */
psbd006       varchar2(10)      ,/* 客戶 */
psbd007       varchar2(10)      ,/* 通路 */
psbd008       number(5,0)      ,/* 期別 */
psbd009       varchar2(20)      ,/* 訂單單號 */
psbd010       number(10,0)      ,/* 項次 */
psbd011       number(10,0)      ,/* 項序 */
psbd012       number(10,0)      ,/* 分批序 */
psbd013       varchar2(10)      ,/* 訂單部門 */
psbd014       varchar2(20)      ,/* 訂單業務員 */
psbd015       varchar2(40)      ,/* 訂單料號 */
psbd016       varchar2(256)      ,/* 訂單產品特徵 */
psbd017       varchar2(10)      ,/* 訂單客戶 */
psbd018       varchar2(10)      ,/* 訂單通路 */
psbd019       number(20,6)      ,/* 訂單數量 */
psbd020       date      ,/* 訂單交期 */
psbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psbd_t add constraint psbd_pk primary key (psbdent,psbdsite,psbd001,psbd002,psbd003,psbd004,psbd005,psbd006,psbd007,psbd008,psbd009,psbd010,psbd011,psbd012) enable validate;

create unique index psbd_pk on psbd_t (psbdent,psbdsite,psbd001,psbd002,psbd003,psbd004,psbd005,psbd006,psbd007,psbd008,psbd009,psbd010,psbd011,psbd012);

grant select on psbd_t to tiptop;
grant update on psbd_t to tiptop;
grant delete on psbd_t to tiptop;
grant insert on psbd_t to tiptop;

exit;
