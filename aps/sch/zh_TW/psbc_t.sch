/* 
================================================================================
檔案代號:psbc_t
檔案名稱:MDS銷售預測沖銷單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psbc_t
(
psbcent       number(5)      ,/* 企業編號 */
psbcsite       varchar2(10)      ,/* 營運據點 */
psbc001       varchar2(10)      ,/* MDS編號 */
psbc002       varchar2(10)      ,/* 預測組織 */
psbc003       varchar2(20)      ,/* 業務員 */
psbc004       varchar2(40)      ,/* 預測料號 */
psbc005       varchar2(256)      ,/* 產品特徵 */
psbc006       varchar2(10)      ,/* 客戶 */
psbc007       varchar2(10)      ,/* 通路 */
psbc008       number(5,0)      ,/* 期別 */
psbc009       date      ,/* 起始日期 */
psbc010       date      ,/* 截止日期 */
psbc011       varchar2(10)      ,/* 需求類型 */
psbc012       number(20,6)      ,/* 預測數量 */
psbc013       number(20,6)      ,/* 無效數量 */
psbc014       number(20,6)      ,/* 被沖銷數量 */
psbc015       number(20,6)      ,/* 沖銷後餘量 */
psbc016       varchar2(10)      ,/* 預測編號 */
psbc017       date      ,/* 預測起始日期 */
psbc018       varchar2(10)      ,/* 預測版本 */
psbc019       timestamp(0)      ,/* MDS計算日期時間 */
psbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psbc_t add constraint psbc_pk primary key (psbcent,psbcsite,psbc001,psbc002,psbc003,psbc004,psbc005,psbc006,psbc007,psbc008) enable validate;

create unique index psbc_pk on psbc_t (psbcent,psbcsite,psbc001,psbc002,psbc003,psbc004,psbc005,psbc006,psbc007,psbc008);

grant select on psbc_t to tiptop;
grant update on psbc_t to tiptop;
grant delete on psbc_t to tiptop;
grant insert on psbc_t to tiptop;

exit;
