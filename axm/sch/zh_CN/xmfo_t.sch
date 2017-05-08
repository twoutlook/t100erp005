/* 
================================================================================
檔案代號:xmfo_t
檔案名稱:客訴單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmfo_t
(
xmfoent       number(5)      ,/* 企業編號 */
xmfosite       varchar2(10)      ,/* 營運據點 */
xmfodocno       varchar2(20)      ,/* 客訴單號 */
xmfodocdt       date      ,/* 客訴日期 */
xmfo001       date      ,/* 處理期限 */
xmfo002       date      ,/* 結案日期 */
xmfo003       varchar2(20)      ,/* 處理人員 */
xmfo004       varchar2(10)      ,/* 處理部門 */
xmfo005       varchar2(10)      ,/* 客戶編號 */
xmfo006       varchar2(20)      ,/* 出貨單號 */
xmfo007       number(10,0)      ,/* 出貨項次 */
xmfo008       varchar2(20)      ,/* 訂單單號 */
xmfo009       number(10,0)      ,/* 訂單項次 */
xmfo010       number(10,0)      ,/* 訂單項序 */
xmfo011       number(10,0)      ,/* 訂單分批序 */
xmfo012       varchar2(40)      ,/* 產品編號 */
xmfo013       varchar2(30)      ,/* 產品特徵 */
xmfo014       number(20,6)      ,/* 客訴數量 */
xmfo015       varchar2(10)      ,/* 單位 */
xmfo016       varchar2(1)      ,/* 處理方式 */
xmfo017       varchar2(20)      ,/* RMA/銷退單號 */
xmfo018       varchar2(4000)      ,/* 備註 */
xmfoownid       varchar2(20)      ,/* 資料所有者 */
xmfoowndp       varchar2(10)      ,/* 資料所屬部門 */
xmfocrtid       varchar2(20)      ,/* 資料建立者 */
xmfocrtdp       varchar2(10)      ,/* 資料建立部門 */
xmfocrtdt       timestamp(0)      ,/* 資料創建日 */
xmfomodid       varchar2(20)      ,/* 資料修改者 */
xmfomoddt       timestamp(0)      ,/* 最近修改日 */
xmfocnfid       varchar2(20)      ,/* 資料確認者 */
xmfocnfdt       timestamp(0)      ,/* 資料確認日 */
xmfopstid       varchar2(20)      ,/* 資料過帳者 */
xmfopstdt       timestamp(0)      ,/* 資料過帳日 */
xmfostus       varchar2(10)      ,/* 狀態碼 */
xmfoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfo_t add constraint xmfo_pk primary key (xmfoent,xmfodocno) enable validate;

create unique index xmfo_pk on xmfo_t (xmfoent,xmfodocno);

grant select on xmfo_t to tiptop;
grant update on xmfo_t to tiptop;
grant delete on xmfo_t to tiptop;
grant insert on xmfo_t to tiptop;

exit;
