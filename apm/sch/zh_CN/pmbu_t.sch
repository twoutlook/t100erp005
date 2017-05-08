/* 
================================================================================
檔案代號:pmbu_t
檔案名稱:採購彈性價格申請單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbu_t
(
pmbuent       number(5)      ,/* 企業編號 */
pmbudocno       varchar2(20)      ,/* 申請單號 */
pmbu010       varchar2(10)      ,/* 變更方式 */
pmbu011       varchar2(40)      ,/* 料件編號 */
pmbu012       varchar2(256)      ,/* 產品特徵 */
pmbu013       varchar2(10)      ,/* 洲別編號 */
pmbu014       varchar2(10)      ,/* 國家編號 */
pmbu015       varchar2(10)      ,/* 州省編號 */
pmbu016       varchar2(10)      ,/* 供應商價格群組 */
pmbu017       varchar2(10)      ,/* 供應商分類 */
pmbu018       varchar2(10)      ,/* 計價單位 */
pmbu019       varchar2(10)      ,/* 稅別編號 */
pmbu020       varchar2(10)      ,/* 付款條件 */
pmbu021       varchar2(10)      ,/* 交易條件 */
pmbu022       number(20,6)      ,/* 單價 */
pmbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbuud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmbu031       varchar2(10)      ,/* 系列 */
pmbu032       varchar2(10)      /* 產品分類 */
);
alter table pmbu_t add constraint pmbu_pk primary key (pmbuent,pmbudocno,pmbu011,pmbu012,pmbu013,pmbu014,pmbu015,pmbu016,pmbu017,pmbu018,pmbu019,pmbu020,pmbu021,pmbu031,pmbu032) enable validate;

create unique index pmbu_pk on pmbu_t (pmbuent,pmbudocno,pmbu011,pmbu012,pmbu013,pmbu014,pmbu015,pmbu016,pmbu017,pmbu018,pmbu019,pmbu020,pmbu021,pmbu031,pmbu032);

grant select on pmbu_t to tiptop;
grant update on pmbu_t to tiptop;
grant delete on pmbu_t to tiptop;
grant insert on pmbu_t to tiptop;

exit;
