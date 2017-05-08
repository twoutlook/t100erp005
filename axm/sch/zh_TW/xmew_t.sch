/* 
================================================================================
檔案代號:xmew_t
檔案名稱:銷售估價組成明細單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmew_t
(
xmewent       number(5)      ,/* 企業編號 */
xmewsite       varchar2(10)      ,/* 營運據點 */
xmewdocno       varchar2(20)      ,/* 估價單號 */
xmewseq       number(10,0)      ,/* 階層項次 */
xmew001       varchar2(10)      ,/* 部位編號 */
xmew002       varchar2(10)      ,/* 作業編號 */
xmew003       varchar2(40)      ,/* 料件編號 */
xmew004       varchar2(256)      ,/* 產品特徵 */
xmew005       varchar2(255)      ,/* 輔助說明 */
xmew006       varchar2(10)      ,/* 單位 */
xmew007       number(20,6)      ,/* 組成用量 */
xmew008       number(20,6)      ,/* 主件底數 */
xmew009       varchar2(1)      ,/* 客供料 */
xmew010       varchar2(10)      ,/* 採購幣別 */
xmew011       number(20,10)      ,/* 採購匯率 */
xmew012       number(20,6)      ,/* 採購單價 */
xmew013       varchar2(10)      ,/* 指定廠商 */
xmew014       number(20,6)      ,/* 材料單價 */
xmew015       number(20,6)      ,/* 材料金額 */
xmew016       varchar2(255)      ,/* 備註 */
xmewud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmewud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmewud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmewud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmewud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmewud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmewud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmewud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmewud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmewud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmewud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmewud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmewud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmewud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmewud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmewud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmewud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmewud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmewud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmewud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmewud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmewud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmewud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmewud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmewud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmewud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmewud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmewud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmewud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmewud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmew_t add constraint xmew_pk primary key (xmewent,xmewdocno,xmewseq) enable validate;

create unique index xmew_pk on xmew_t (xmewent,xmewdocno,xmewseq);

grant select on xmew_t to tiptop;
grant update on xmew_t to tiptop;
grant delete on xmew_t to tiptop;
grant insert on xmew_t to tiptop;

exit;
