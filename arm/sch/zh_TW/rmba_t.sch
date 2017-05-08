/* 
================================================================================
檔案代號:rmba_t
檔案名稱:RMA報價單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmba_t
(
rmbaent       number(5)      ,/* 企業編號 */
rmbasite       varchar2(10)      ,/* 營運據點 */
rmbadocno       varchar2(20)      ,/* 單據單號 */
rmbadocdt       date      ,/* 單據日期 */
rmba000       number(10,0)      ,/* 版本 */
rmba001       varchar2(10)      ,/* 客戶編號 */
rmba002       varchar2(20)      ,/* 報價人員 */
rmba003       varchar2(10)      ,/* 報價部門 */
rmba004       varchar2(10)      ,/* 收款條件 */
rmba005       varchar2(10)      ,/* 交易條件 */
rmba006       varchar2(10)      ,/* 稅別 */
rmba007       number(5,2)      ,/* 稅率 */
rmba008       varchar2(1)      ,/* 單價含稅否 */
rmba009       varchar2(2)      ,/* 發票類型 */
rmba010       varchar2(10)      ,/* 幣別 */
rmba011       number(20,10)      ,/* 匯率 */
rmba012       varchar2(10)      ,/* 匯率計算基準 */
rmba013       varchar2(10)      ,/* 內外銷 */
rmbaownid       varchar2(20)      ,/* 資料所有者 */
rmbaowndp       varchar2(10)      ,/* 資料所屬部門 */
rmbacrtid       varchar2(20)      ,/* 資料建立者 */
rmbacrtdp       varchar2(10)      ,/* 資料建立部門 */
rmbacrtdt       timestamp(0)      ,/* 資料創建日 */
rmbamodid       varchar2(20)      ,/* 資料修改者 */
rmbamoddt       timestamp(0)      ,/* 最近修改日 */
rmbacnfid       varchar2(20)      ,/* 資料確認者 */
rmbacnfdt       timestamp(0)      ,/* 資料確認日 */
rmbapstid       varchar2(20)      ,/* 資料過帳者 */
rmbapstdt       timestamp(0)      ,/* 資料過帳日 */
rmbastus       varchar2(10)      ,/* 狀態碼 */
rmbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rmbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rmbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rmbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rmbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rmbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rmbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rmbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rmbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rmbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rmbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rmbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rmbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rmbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rmbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rmbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rmbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rmbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rmbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rmbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rmbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rmbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rmbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rmbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rmbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rmbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rmbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rmbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rmbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rmbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rmba_t add constraint rmba_pk primary key (rmbaent,rmbadocno,rmba000) enable validate;

create unique index rmba_pk on rmba_t (rmbaent,rmbadocno,rmba000);

grant select on rmba_t to tiptop;
grant update on rmba_t to tiptop;
grant delete on rmba_t to tiptop;
grant insert on rmba_t to tiptop;

exit;
