/* 
================================================================================
檔案代號:sfba_t
檔案名稱:工單備料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfba_t
(
sfbaent       number(5)      ,/* 企業編號 */
sfbasite       varchar2(10)      ,/* 營運據點 */
sfbadocno       varchar2(20)      ,/* 單號 */
sfbaseq       number(10,0)      ,/* 項次 */
sfbaseq1       number(10,0)      ,/* 項序 */
sfba001       varchar2(40)      ,/* 上階料號 */
sfba002       varchar2(10)      ,/* 部位 */
sfba003       varchar2(10)      ,/* 作業編號 */
sfba004       varchar2(10)      ,/* 作業序 */
sfba005       varchar2(40)      ,/* BOM料號 */
sfba006       varchar2(40)      ,/* 發料料號 */
sfba007       number(5,0)      ,/* 投料時距 */
sfba008       varchar2(1)      ,/* 必要特性 */
sfba009       varchar2(1)      ,/* 倒扣料 */
sfba010       number(20,6)      ,/* 標準QPA分子 */
sfba011       number(20,6)      ,/* 標準QPA分母 */
sfba012       number(20,6)      ,/* 允許誤差率 */
sfba013       number(20,6)      ,/* 應發數量 */
sfba014       varchar2(10)      ,/* 單位 */
sfba015       number(20,6)      ,/* 委外代買數量 */
sfba016       number(20,6)      ,/* 已發數量 */
sfba017       number(20,6)      ,/* 報廢數量 */
sfba018       number(20,6)      ,/* 盤虧數量 */
sfba019       varchar2(10)      ,/* 指定發料倉庫 */
sfba020       varchar2(10)      ,/* 指定發料儲位 */
sfba021       varchar2(256)      ,/* 產品特徵 */
sfba022       number(20,6)      ,/* 替代率 */
sfba023       number(20,6)      ,/* 標準應發數量 */
sfba024       number(20,6)      ,/* 調整應發數量 */
sfba025       number(20,6)      ,/* 超領數量 */
sfba026       varchar2(1)      ,/* SET替代狀態 */
sfba027       varchar2(10)      ,/* SET替代群組 */
sfba028       varchar2(1)      ,/* 客供料 */
sfba029       varchar2(30)      ,/* 指定發料批號 */
sfba030       varchar2(30)      ,/* 指定庫存管理特徵 */
sfbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfba031       number(20,6)      ,/* 備置量 */
sfba032       varchar2(10)      ,/* 備置理由碼 */
sfba033       varchar2(1)      ,/* 保稅否 */
sfba034       varchar2(10)      ,/* SET被替代群組 */
sfba035       number(20,6)      /* SET替代套數 */
);
alter table sfba_t add constraint sfba_pk primary key (sfbaent,sfbadocno,sfbaseq,sfbaseq1) enable validate;

create  index sfba_n1 on sfba_t (sfbaent,sfbasite,sfba006,sfba021);
create unique index sfba_pk on sfba_t (sfbaent,sfbadocno,sfbaseq,sfbaseq1);

grant select on sfba_t to tiptop;
grant update on sfba_t to tiptop;
grant delete on sfba_t to tiptop;
grant insert on sfba_t to tiptop;

exit;
