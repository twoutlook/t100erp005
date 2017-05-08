/* 
================================================================================
檔案代號:xmet_t
檔案名稱:銷售估價範本組成明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmet_t
(
xmetent       number(5)      ,/* 企業編號 */
xmetsite       varchar2(10)      ,/* 營運據點 */
xmetdocno       varchar2(20)      ,/* 範本料號 */
xmet001       number(5,0)      ,/* 版次 */
xmet002       number(10,0)      ,/* 階層項次 */
xmet003       varchar2(10)      ,/* 部位編號 */
xmet004       varchar2(10)      ,/* 作業編號 */
xmet005       varchar2(40)      ,/* 料件編號 */
xmet006       varchar2(256)      ,/* 產品特徵 */
xmet007       varchar2(255)      ,/* 輔助說明 */
xmet008       varchar2(10)      ,/* 單位 */
xmet009       number(20,6)      ,/* 組成用量 */
xmet010       number(20,6)      ,/* 主件底數 */
xmet011       varchar2(1)      ,/* 客供料 */
xmet012       varchar2(10)      ,/* 幣別 */
xmet013       varchar2(10)      ,/* 指定廠商 */
xmet014       varchar2(255)      ,/* 備註 */
xmetud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmetud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmetud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmetud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmetud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmetud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmetud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmetud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmetud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmetud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmetud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmetud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmetud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmetud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmetud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmetud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmetud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmetud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmetud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmetud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmetud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmetud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmetud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmetud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmetud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmetud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmetud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmetud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmetud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmetud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmet_t add constraint xmet_pk primary key (xmetent,xmetsite,xmetdocno,xmet001,xmet002) enable validate;

create unique index xmet_pk on xmet_t (xmetent,xmetsite,xmetdocno,xmet001,xmet002);

grant select on xmet_t to tiptop;
grant update on xmet_t to tiptop;
grant delete on xmet_t to tiptop;
grant insert on xmet_t to tiptop;

exit;
