/* 
================================================================================
檔案代號:ooif_t
檔案名稱:店群款別主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ooif_t
(
ooifent       number(5)      ,/* 企業編號 */
ooifstus       varchar2(10)      ,/* 狀態及異動 */
ooif000       varchar2(10)      ,/* 店群編號 */
ooif001       varchar2(10)      ,/* 款別編號 */
ooif002       varchar2(10)      ,/* 款別指定幣別 */
ooif003       varchar2(1)      ,/* 第三方代收繳款否 */
ooif004       varchar2(10)      ,/* 代收機構 */
ooif005       number(20,10)      ,/* 代收手續費費率 */
ooif006       number(15,3)      ,/* 代收手續費金額 */
ooif007       varchar2(1)      ,/* 產生代收帳款單否 */
ooif008       varchar2(1)      ,/* 預設款別否 */
ooif009       varchar2(10)      ,/* 對應款別編號 */
ooif010       varchar2(500)      ,/* 顯示名稱 */
ooif011       varchar2(500)      ,/* 打印名稱 */
ooif012       varchar2(1)      ,/* 是否實收折讓 */
ooif013       varchar2(1)      ,/* 儲值付款單次使用否 */
ooif014       number(5,0)      ,/* 錄入號碼最小長度 */
ooif015       varchar2(1)      ,/* 可退款 */
ooif016       varchar2(1)      ,/* 可找零 */
ooif017       varchar2(1)      ,/* 下傳款別 */
ooif018       varchar2(1)      ,/* 可溢收 */
ooif019       varchar2(1)      ,/* 是否執行接口程式 */
ooif020       varchar2(1)      ,/* 扣款金額自動取值 */
ooif021       varchar2(1)      ,/* 接口小數倍數 */
ooif022       varchar2(1)      ,/* 允許空單交易 */
ooif023       varchar2(1)      ,/* transflag標記 */
ooif024       varchar2(80)      ,/* 接口程式返回的列印檔案 */
ooif025       varchar2(80)      ,/* 執行的接口程式 */
ooif026       varchar2(80)      ,/* 執行接口傳入的檔案名 */
ooif027       varchar2(80)      ,/* 執行接口傳入檔資料類型ID */
ooif028       varchar2(80)      ,/* 執行接口後返回接口檔 */
ooif029       varchar2(80)      ,/* 執行接口返回檔資料類型 */
ooifpos       varchar2(1)      ,/* 下傳否 */
ooifstamp       timestamp(5)      ,/* 時間戳記 */
ooifownid       varchar2(20)      ,/* 資料所有者 */
ooifowndp       varchar2(10)      ,/* 資料所屬部門 */
ooifcrtid       varchar2(20)      ,/* 資料建立者 */
ooifcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooifcrtdt       timestamp(0)      ,/* 資料創建日 */
ooifmodid       varchar2(20)      ,/* 資料修改者 */
ooifmoddt       timestamp(0)      ,/* 最近修改日 */
ooifud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooifud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooifud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooifud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooifud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooifud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooifud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooifud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooifud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooifud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooifud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooifud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooifud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooifud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooifud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooifud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooifud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooifud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooifud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooifud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooifud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooifud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooifud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooifud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooifud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooifud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooifud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooifud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooifud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooifud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
ooif031       number(20,6)      ,/* 標準手續費費率 */
ooif032       varchar2(10)      /* 券消費認列方式 */
);
alter table ooif_t add constraint ooif_pk primary key (ooifent,ooif000,ooif001) enable validate;

create unique index ooif_pk on ooif_t (ooifent,ooif000,ooif001);

grant select on ooif_t to tiptop;
grant update on ooif_t to tiptop;
grant delete on ooif_t to tiptop;
grant insert on ooif_t to tiptop;

exit;
