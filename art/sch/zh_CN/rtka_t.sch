/* 
================================================================================
檔案代號:rtka_t
檔案名稱:自動補貨供應商出單日設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table rtka_t
(
rtkaent       number(5)      ,/* 企業編號 */
rtkaunit       varchar2(10)      ,/* 應用組織 */
rtka001       varchar2(10)      ,/* 供應商編號 */
rtka002       varchar2(1)      ,/* 資料類型 */
rtka003       varchar2(10)      ,/* 店群門店編號 */
rtka004       varchar2(10)      ,/* 出單週期類型 */
rtka005       varchar2(255)      ,/* 出單日 */
rtka006       varchar2(255)      ,/* 出單週 */
rtka007       varchar2(10)      ,/* 送貨時段 */
rtka008       number(20,6)      ,/* 最小送貨量 */
rtka009       number(20,6)      ,/* 最小送貨金額 */
rtka010       number(5,0)      ,/* 訂單有效期 */
rtka011       number(5,0)      ,/* 要貨頻率 */
rtka012       number(5,0)      ,/* 送貨天數 */
rtkaownid       varchar2(20)      ,/* 資料所有者 */
rtkaowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkacrtid       varchar2(20)      ,/* 資料建立者 */
rtkacrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkacrtdt       timestamp(0)      ,/* 資料創建日 */
rtkamodid       varchar2(20)      ,/* 資料修改者 */
rtkamoddt       timestamp(0)      ,/* 最近修改日 */
rtkastus       varchar2(10)      ,/* 狀態碼 */
rtkaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtka_t add constraint rtka_pk primary key (rtkaent,rtka001,rtka002,rtka003) enable validate;

create unique index rtka_pk on rtka_t (rtkaent,rtka001,rtka002,rtka003);

grant select on rtka_t to tiptop;
grant update on rtka_t to tiptop;
grant delete on rtka_t to tiptop;
grant insert on rtka_t to tiptop;

exit;
