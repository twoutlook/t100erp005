/* 
================================================================================
檔案代號:sfda_t
檔案名稱:發退料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table sfda_t
(
sfdaent       number(5)      ,/* 企業編號 */
sfdasite       varchar2(10)      ,/* 營運據點 */
sfdadocno       varchar2(20)      ,/* 發退料單號 */
sfdadocdt       date      ,/* 單據日期 */
sfda001       date      ,/* 過帳日期 */
sfda002       varchar2(10)      ,/* 發退料類別 */
sfda003       varchar2(10)      ,/* 生產部門 */
sfda004       varchar2(20)      ,/* 申請人 */
sfda005       varchar2(20)      ,/* PBI編號 */
sfda006       varchar2(40)      ,/* 生產料號 */
sfda007       varchar2(30)      ,/* BOM特性 */
sfda008       varchar2(256)      ,/* 產品特徵 */
sfda009       varchar2(10)      ,/* 生產控制組 */
sfda010       varchar2(10)      ,/* 作業編號 */
sfda011       varchar2(10)      ,/* 作業序 */
sfda012       varchar2(10)      ,/* 庫位 */
sfda013       number(20,6)      ,/* 套數 */
sfda014       varchar2(20)      ,/* 來源單號 */
sfda015       varchar2(10)      ,/* 來源類型 */
sfdaownid       varchar2(20)      ,/* 資料所有者 */
sfdaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfdacrtid       varchar2(20)      ,/* 資料建立者 */
sfdacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfdacrtdt       timestamp(0)      ,/* 資料創建日 */
sfdamodid       varchar2(20)      ,/* 資料修改者 */
sfdamoddt       timestamp(0)      ,/* 最近修改日 */
sfdacnfid       varchar2(20)      ,/* 資料確認者 */
sfdacnfdt       timestamp(0)      ,/* 資料確認日 */
sfdapstid       varchar2(20)      ,/* 資料過帳者 */
sfdapstdt       timestamp(0)      ,/* 資料過帳日 */
sfdastus       varchar2(10)      ,/* 狀態碼 */
sfdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfda_t add constraint sfda_pk primary key (sfdaent,sfdadocno) enable validate;

create unique index sfda_pk on sfda_t (sfdaent,sfdadocno);

grant select on sfda_t to tiptop;
grant update on sfda_t to tiptop;
grant delete on sfda_t to tiptop;
grant insert on sfda_t to tiptop;

exit;
