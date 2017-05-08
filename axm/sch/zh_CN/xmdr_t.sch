/* 
================================================================================
檔案代號:xmdr_t
檔案名稱:訂單備置明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdr_t
(
xmdrent       number(5)      ,/* 企業編號 */
xmdrsite       varchar2(10)      ,/* 營運據點 */
xmdrdocno       varchar2(20)      ,/* 訂單單號 */
xmdrseq       number(10,0)      ,/* 訂單項次 */
xmdrseq1       number(10,0)      ,/* 訂單項序 */
xmdrseq2       number(10,0)      ,/* 訂單分批序 */
xmdr001       varchar2(40)      ,/* 料件編號 */
xmdr002       varchar2(256)      ,/* 產品特徵 */
xmdr003       varchar2(30)      ,/* 庫存管理特徵 */
xmdr004       varchar2(10)      ,/* 庫位 */
xmdr005       varchar2(10)      ,/* 儲位 */
xmdr006       varchar2(30)      ,/* 批號 */
xmdr007       varchar2(10)      ,/* 庫存單位 */
xmdr008       number(20,6)      ,/* 備置量 */
xmdr009       number(20,6)      ,/* 備置已沖銷量 */
xmdr010       varchar2(10)      ,/* 備置單位 */
xmdrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdr_t add constraint xmdr_pk primary key (xmdrent,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdr007) enable validate;

create unique index xmdr_pk on xmdr_t (xmdrent,xmdrdocno,xmdrseq,xmdrseq1,xmdrseq2,xmdr001,xmdr002,xmdr003,xmdr004,xmdr005,xmdr006,xmdr007);

grant select on xmdr_t to tiptop;
grant update on xmdr_t to tiptop;
grant delete on xmdr_t to tiptop;
grant insert on xmdr_t to tiptop;

exit;
