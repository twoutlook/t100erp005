/* 
================================================================================
檔案代號:ooia_t
檔案名稱:款別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooia_t
(
ooiaent       number(5)      ,/* 企業編號 */
ooia001       varchar2(10)      ,/* 款別編號 */
ooia002       varchar2(10)      ,/* 款別性質 */
ooia003       varchar2(1)      ,/* 本幣否 */
ooia004       varchar2(10)      ,/* 交易憑證類型 */
ooia005       varchar2(1)      ,/* POS整合否 */
ooiastus       varchar2(10)      ,/* 狀態碼 */
ooia006       varchar2(10)      ,/* 預設幣別 */
ooia007       varchar2(10)      ,/* 上級款別 */
ooia008       number(5,0)      ,/* 層級 */
ooia009       number(5,0)      ,/* 下級款別數 */
ooia010       varchar2(10)      ,/* 所屬一級款別 */
ooia011       varchar2(1)      ,/* 即期票據否 */
ooia012       varchar2(1)      ,/* 第三方代收繳款否 */
ooia013       varchar2(10)      ,/* 代收機構 */
ooia014       number(20,6)      ,/* 代收手續費費率 */
ooia015       number(20,6)      ,/* 代收手續費金額 */
ooia016       varchar2(1)      ,/* 產生代收帳款單否 */
ooia017       varchar2(10)      ,/* 對應款別編號 */
ooia018       varchar2(500)      ,/* 顯示名稱 */
ooia019       varchar2(500)      ,/* 列印名稱 */
ooia020       varchar2(1)      ,/* 是否實收折讓 */
ooia021       varchar2(1)      ,/* 儲值付款單次使用否 */
ooia022       number(5,0)      ,/* 錄入號碼最小長度 */
ooia023       varchar2(1)      ,/* 可退款 */
ooia024       varchar2(1)      ,/* 可找零 */
ooia025       varchar2(1)      ,/* 下傳款別 */
ooia026       varchar2(1)      ,/* 可溢收 */
ooia027       varchar2(1)      ,/* 是否執行介面程式 */
ooia028       varchar2(1)      ,/* 扣款金額自動取值 */
ooia029       varchar2(1)      ,/* 介面小數倍數 */
ooia030       varchar2(1)      ,/* 允許空單交易 */
ooia031       varchar2(1)      ,/* transflag標記 */
ooia032       varchar2(80)      ,/* 介面程式返回的列印檔案 */
ooia033       varchar2(80)      ,/* 執行的介面程式 */
ooia034       varchar2(80)      ,/* 執行介面傳入的檔案名 */
ooia035       varchar2(80)      ,/* 執行介面傳入檔資料類型ID */
ooia036       varchar2(80)      ,/* 執行介面後返回介面檔 */
ooia037       varchar2(80)      ,/* 執行介面返回檔資料類型 */
ooiaownid       varchar2(20)      ,/* 資料所有者 */
ooiaowndp       varchar2(10)      ,/* 資料所屬部門 */
ooiacrtid       varchar2(20)      ,/* 資料建立者 */
ooiacrtdp       varchar2(10)      ,/* 資料建立部門 */
ooiacrtdt       timestamp(0)      ,/* 資料創建日 */
ooiamodid       varchar2(20)      ,/* 資料修改者 */
ooiamoddt       timestamp(0)      ,/* 最近修改日 */
ooiaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooiaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooiaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooiaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooiaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooiaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooiaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooiaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooiaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooiaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooiaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooiaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooiaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooiaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooiaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooiaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooiaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooiaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooiaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooiaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooiaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooiaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooiaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooiaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooiaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooiaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooiaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooiaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooiaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooiaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooia038       number(20,6)      ,/* 標準手續費費率 */
ooia039       varchar2(10)      /* 券消費認列方式 */
);
alter table ooia_t add constraint ooia_pk primary key (ooiaent,ooia001) enable validate;

create  index ooia_01 on ooia_t (ooia002);
create unique index ooia_pk on ooia_t (ooiaent,ooia001);

grant select on ooia_t to tiptop;
grant update on ooia_t to tiptop;
grant delete on ooia_t to tiptop;
grant insert on ooia_t to tiptop;

exit;
