/* 
================================================================================
檔案代號:stia_t
檔案名稱:意向協議單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stia_t
(
stiaent       number(5)      ,/* 企業編號 */
stiasite       varchar2(10)      ,/* 營運據點 */
stiaunit       varchar2(10)      ,/* 制定組織 */
stiadocno       varchar2(20)      ,/* 單據編號 */
stiadocdt       date      ,/* 單據日期 */
stia001       varchar2(10)      ,/* 來源類型 */
stia002       varchar2(20)      ,/* 來源單號 */
stia003       varchar2(10)      ,/* 商戶編號 */
stia004       varchar2(80)      ,/* 商戶連絡電話 */
stia005       varchar2(10)      ,/* 主品牌 */
stia006       varchar2(20)      ,/* 鋪位編號 */
stia007       varchar2(10)      ,/* 鋪位版本 */
stia008       varchar2(10)      ,/* 樓棟編號 */
stia009       varchar2(10)      ,/* 樓層編號 */
stia010       varchar2(10)      ,/* 品類編號 */
stia011       varchar2(10)      ,/* 費用編號 */
stia012       number(20,6)      ,/* 預定金額 */
stia013       varchar2(20)      ,/* 費用單號 */
stia014       varchar2(20)      ,/* 業務人員 */
stia015       varchar2(10)      ,/* 業務部門 */
stia016       varchar2(80)      ,/* 備註 */
stiastus       varchar2(10)      ,/* 狀態碼 */
stiaownid       varchar2(20)      ,/* 資料所有者 */
stiaowndp       varchar2(10)      ,/* 資料所屬部門 */
stiacrtid       varchar2(20)      ,/* 資料建立者 */
stiacrtdp       varchar2(10)      ,/* 資料建立部門 */
stiacrtdt       timestamp(0)      ,/* 資料創建日 */
stiamodid       varchar2(20)      ,/* 資料修改者 */
stiamoddt       timestamp(0)      ,/* 最近修改日 */
stiacnfid       varchar2(20)      ,/* 資料確認者 */
stiacnfdt       timestamp(0)      ,/* 資料確認日 */
stiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stiaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stia_t add constraint stia_pk primary key (stiaent,stiadocno) enable validate;

create unique index stia_pk on stia_t (stiaent,stiadocno);

grant select on stia_t to tiptop;
grant update on stia_t to tiptop;
grant delete on stia_t to tiptop;
grant insert on stia_t to tiptop;

exit;
