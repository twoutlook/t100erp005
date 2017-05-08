/* 
================================================================================
檔案代號:xmbu_t
檔案名稱:銷售彈性價格申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmbu_t
(
xmbuent       number(5)      ,/* 企業編號 */
xmbudocno       varchar2(20)      ,/* 申請單號 */
xmbu010       varchar2(10)      ,/* 變更方式 */
xmbu011       varchar2(40)      ,/* 料件編號 */
xmbu012       varchar2(256)      ,/* 產品特徵 */
xmbu013       varchar2(10)      ,/* 洲別編號 */
xmbu014       varchar2(10)      ,/* 國家編號 */
xmbu015       varchar2(10)      ,/* 州省編號 */
xmbu016       varchar2(10)      ,/* 客戶價格群組 */
xmbu017       varchar2(10)      ,/* 客戶分類 */
xmbu018       varchar2(10)      ,/* 計價單位 */
xmbu019       varchar2(10)      ,/* 稅別編號 */
xmbu020       varchar2(10)      ,/* 收款條件 */
xmbu021       varchar2(10)      ,/* 交易條件 */
xmbu022       number(20,6)      ,/* 單價 */
xmbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmbuud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmbu031       varchar2(10)      ,/* 系列 */
xmbu032       varchar2(10)      /* 產品分類 */
);
alter table xmbu_t add constraint xmbu_pk primary key (xmbuent,xmbudocno,xmbu011,xmbu012,xmbu013,xmbu014,xmbu015,xmbu016,xmbu017,xmbu018,xmbu019,xmbu020,xmbu021,xmbu031,xmbu032) enable validate;

create unique index xmbu_pk on xmbu_t (xmbuent,xmbudocno,xmbu011,xmbu012,xmbu013,xmbu014,xmbu015,xmbu016,xmbu017,xmbu018,xmbu019,xmbu020,xmbu021,xmbu031,xmbu032);

grant select on xmbu_t to tiptop;
grant update on xmbu_t to tiptop;
grant delete on xmbu_t to tiptop;
grant insert on xmbu_t to tiptop;

exit;
