/* 
================================================================================
檔案代號:crba_t
檔案名稱:客訴單維護單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table crba_t
(
crbaent       number(5)      ,/* 企業編號 */
crbasite       varchar2(10)      ,/* 營運據點 */
crbadocno       varchar2(20)      ,/* 客訴單號 */
crbadocdt       date      ,/* 客訴日期 */
crba001       varchar2(20)      ,/* 處理人員 */
crba002       varchar2(10)      ,/* 處理部門 */
crba003       varchar2(20)      ,/* 負責業務 */
crba004       date      ,/* 處理期限 */
crba005       date      ,/* 結案日期 */
crba006       varchar2(20)      ,/* 原銷售單號 */
crba007       number(10,0)      ,/* 原銷售項次 */
crba008       date      ,/* 原銷售日期 */
crba009       varchar2(10)      ,/* 客戶編號 */
crba010       varchar2(80)      ,/* 客戶簡稱 */
crba011       varchar2(30)      ,/* 會員卡號 */
crba012       varchar2(30)      ,/* 會員編號 */
crba013       varchar2(255)      ,/* 會員姓名 */
crba014       varchar2(20)      ,/* 發票號碼 */
crba015       varchar2(20)      ,/* 客戶訂單 */
crba016       varchar2(40)      ,/* 產品編號 */
crba017       varchar2(255)      ,/* 品名 */
crba018       varchar2(10)      ,/* 幣別 */
crba019       number(20,10)      ,/* 匯率 */
crba020       number(20,6)      ,/* 單價 */
crba021       number(20,6)      ,/* 客訴數量 */
crba022       number(20,6)      ,/* 補貨數量 */
crba023       number(20,6)      ,/* 換貨數量 */
crba024       number(20,6)      ,/* 銷貨退回 */
crba025       number(20,6)      ,/* 折讓金額 */
crba026       varchar2(20)      ,/* 來源單號 */
crbaownid       varchar2(20)      ,/* 資料所有者 */
crbaowndp       varchar2(10)      ,/* 資料所屬部門 */
crbacrtid       varchar2(20)      ,/* 資料建立者 */
crbacrtdp       varchar2(10)      ,/* 資料建立部門 */
crbacrtdt       timestamp(0)      ,/* 資料創建日 */
crbamodid       varchar2(20)      ,/* 資料修改者 */
crbamoddt       timestamp(0)      ,/* 最近修改日 */
crbacnfid       varchar2(20)      ,/* 資料確認者 */
crbacnfdt       timestamp(0)      ,/* 資料確認日 */
crbastus       varchar2(10)      ,/* 狀態碼 */
crbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crba_t add constraint crba_pk primary key (crbaent,crbadocno) enable validate;

create unique index crba_pk on crba_t (crbaent,crbadocno);

grant select on crba_t to tiptop;
grant update on crba_t to tiptop;
grant delete on crba_t to tiptop;
grant insert on crba_t to tiptop;

exit;
