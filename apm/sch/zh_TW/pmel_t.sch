/* 
================================================================================
檔案代號:pmel_t
檔案名稱:收貨送貨預約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmel_t
(
pmelent       number(5)      ,/* 企業編號 */
pmelsite       varchar2(10)      ,/* 營運據點 */
pmelunit       varchar2(10)      ,/* 應用組織 */
pmeldocno       varchar2(20)      ,/* 單據單號 */
pmeldocdt       date      ,/* 單據日期 */
pmel000       varchar2(10)      ,/* 單據類型 */
pmel001       varchar2(20)      ,/* 預約來源單號 */
pmel002       date      ,/* 預計日期 */
pmel003       varchar2(10)      ,/* 預計時段 */
pmel004       varchar2(20)      ,/* 預約人員 */
pmel005       varchar2(10)      ,/* 預約部門 */
pmel006       varchar2(10)      ,/* 供應商編號客戶編號 */
pmel007       varchar2(10)      ,/* 送貨供應商送貨客戶 */
pmel008       varchar2(255)      ,/* 備註 */
pmelownid       varchar2(20)      ,/* 資料所有者 */
pmelowndp       varchar2(10)      ,/* 資料所屬部門 */
pmelcrtid       varchar2(20)      ,/* 資料建立者 */
pmelcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmelcrtdt       timestamp(0)      ,/* 資料創建日 */
pmelmodid       varchar2(20)      ,/* 資料修改者 */
pmelmoddt       timestamp(0)      ,/* 最近修改日 */
pmelcnfid       varchar2(20)      ,/* 資料確認者 */
pmelcnfdt       timestamp(0)      ,/* 資料確認日 */
pmelstus       varchar2(10)      ,/* 狀態碼 */
pmelud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmelud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmelud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmelud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmelud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmelud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmelud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmelud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmelud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmelud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmelud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmelud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmelud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmelud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmelud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmelud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmelud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmelud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmelud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmelud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmelud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmelud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmelud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmelud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmelud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmelud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmelud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmelud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmelud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmelud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmel009       varchar2(10)      ,/* 碼頭編號 */
pmel010       number(5,0)      ,/* 預約預計車輛數 */
pmel011       date      ,/* 實際到貨日期 */
pmel012       varchar2(8)      ,/* 實際到貨時間 */
pmel013       varchar2(1)      ,/* 是否準時到貨 */
pmel014       varchar2(8)      /* 到貨差異時數 */
);
alter table pmel_t add constraint pmel_pk primary key (pmelent,pmeldocno) enable validate;

create unique index pmel_pk on pmel_t (pmelent,pmeldocno);

grant select on pmel_t to tiptop;
grant update on pmel_t to tiptop;
grant delete on pmel_t to tiptop;
grant insert on pmel_t to tiptop;

exit;
