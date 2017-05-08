/* 
================================================================================
檔案代號:prbh_t
檔案名稱:PLU碼對照清單表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prbh_t
(
prbhent       number(5)      ,/* 企業編號 */
prbhunit       varchar2(10)      ,/* 應用組織 */
prbhsite       varchar2(10)      ,/* 營運據點 */
prbh001       varchar2(10)      ,/* PLU編碼 */
prbh002       varchar2(80)      ,/* PLU說明 */
prbh003       varchar2(40)      ,/* 商品編碼 */
prbh004       varchar2(40)      ,/* 商品條碼 */
prbh005       varchar2(256)      ,/* 商品特征 */
prbh006       varchar2(10)      ,/* 包裝單位 */
prbh007       number(20,6)      ,/* 整包件數 */
prbh008       number(5,0)      ,/* 價格因子 */
prbh009       varchar2(10)      ,/* 進項稅別 */
prbh010       number(20,6)      ,/* 進價 */
prbh011       varchar2(10)      ,/* 銷項稅別 */
prbh012       number(20,6)      ,/* 售價 */
prbh013       number(20,6)      ,/* 會員價1 */
prbh014       number(20,6)      ,/* 會員價2 */
prbh015       number(20,6)      ,/* 會員價3 */
prbhstus       varchar2(10)      ,/* 狀態 */
prbhownid       varchar2(20)      ,/* 資料所有者 */
prbhowndp       varchar2(10)      ,/* 資料所屬部門 */
prbhcrtid       varchar2(20)      ,/* 資料建立者 */
prbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
prbhcrtdt       timestamp(0)      ,/* 資料創建日 */
prbhmodid       varchar2(20)      ,/* 資料修改者 */
prbhmoddt       timestamp(0)      ,/* 最近修改日 */
prbh016       date      ,/* 進價開始日期 */
prbh017       date      ,/* 進價結束日期 */
prbh018       date      ,/* 售價開始日期 */
prbh019       date      ,/* 售價結束日期 */
prbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbh_t add constraint prbh_pk primary key (prbhent,prbhsite,prbh001) enable validate;

create unique index prbh_pk on prbh_t (prbhent,prbhsite,prbh001);

grant select on prbh_t to tiptop;
grant update on prbh_t to tiptop;
grant delete on prbh_t to tiptop;
grant insert on prbh_t to tiptop;

exit;
