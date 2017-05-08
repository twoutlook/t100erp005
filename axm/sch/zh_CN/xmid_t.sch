/* 
================================================================================
檔案代號:xmid_t
檔案名稱:銷售預測單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmid_t
(
xmident       number(5)      ,/* 企業編號 */
xmid001       varchar2(10)      ,/* 預測編號 */
xmid002       date      ,/* 預測起始日 */
xmid003       number(5,0)      ,/* 版本 */
xmid004       varchar2(10)      ,/* 預測營運據點 */
xmid005       varchar2(10)      ,/* 銷售組織 */
xmid006       varchar2(20)      ,/* 業務員 */
xmid007       varchar2(40)      ,/* 預測料號 */
xmid008       varchar2(256)      ,/* 產品特徵 */
xmid009       varchar2(10)      ,/* 客戶 */
xmid010       varchar2(10)      ,/* 通路 */
xmid011       number(5,0)      ,/* 期別 */
xmid012       date      ,/* 起始日期 */
xmid013       date      ,/* 截止日期 */
xmid014       varchar2(10)      ,/* 單位 */
xmid015       number(20,6)      ,/* 預測數量 */
xmid016       number(20,6)      ,/* 調整量 */
xmid017       number(20,6)      ,/* 總數量 */
xmid018       number(20,6)      ,/* 單價 */
xmid019       number(20,6)      ,/* 金額 */
xmid020       number(20,6)      ,/* 調整金額 */
xmid021       number(20,6)      ,/* 總金額 */
xmidud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmidud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmidud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmidud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmidud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmidud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmidud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmidud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmidud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmidud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmidud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmidud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmidud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmidud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmidud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmidud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmidud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmidud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmidud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmidud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmidud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmidud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmidud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmidud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmidud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmidud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmidud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmidud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmidud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmidud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmid_t add constraint xmid_pk primary key (xmident,xmid001,xmid002,xmid003,xmid004,xmid005,xmid006,xmid007,xmid008,xmid009,xmid010,xmid011) enable validate;

create unique index xmid_pk on xmid_t (xmident,xmid001,xmid002,xmid003,xmid004,xmid005,xmid006,xmid007,xmid008,xmid009,xmid010,xmid011);

grant select on xmid_t to tiptop;
grant update on xmid_t to tiptop;
grant delete on xmid_t to tiptop;
grant insert on xmid_t to tiptop;

exit;
