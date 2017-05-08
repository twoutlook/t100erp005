/* 
================================================================================
檔案代號:sfkg_t
檔案名稱:工單變更單備料單身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfkg_t
(
sfkgent       number(5)      ,/* 企業編號 */
sfkgsite       varchar2(10)      ,/* 營運據點 */
sfkgdocno       varchar2(20)      ,/* 工單單號 */
sfkgseq       number(10,0)      ,/* 項次 */
sfkgseq1       number(10,0)      ,/* 項序 */
sfkg001       varchar2(40)      ,/* 上階料號 */
sfkg002       varchar2(10)      ,/* 部位 */
sfkg003       varchar2(10)      ,/* 作業編號 */
sfkg004       varchar2(10)      ,/* 製程式 */
sfkg005       varchar2(40)      ,/* BOM料號 */
sfkg006       varchar2(40)      ,/* 發料料號 */
sfkg007       number(5,0)      ,/* 投料時距 */
sfkg008       varchar2(1)      ,/* 必要特性 */
sfkg009       varchar2(1)      ,/* 倒扣料 */
sfkg010       number(20,6)      ,/* 標準QPA */
sfkg011       number(20,6)      ,/* 實際QPA */
sfkg012       number(20,6)      ,/* 允許誤差率 */
sfkg013       number(20,6)      ,/* 應發數量 */
sfkg014       varchar2(10)      ,/* 單位 */
sfkg015       number(20,6)      ,/* 委外代買數量 */
sfkg016       number(20,6)      ,/* 已發數量 */
sfkg017       number(20,6)      ,/* 報廢數量 */
sfkg018       number(20,6)      ,/* 盤虧數量 */
sfkg019       varchar2(10)      ,/* 指定發料倉庫 */
sfkg020       varchar2(10)      ,/* 指定發料儲位 */
sfkg021       varchar2(256)      ,/* 產品特徵 */
sfkg022       number(20,6)      ,/* 替代率 */
sfkg023       number(20,6)      ,/* 標準應發數量 */
sfkg024       number(20,6)      ,/* 調整應發數量 */
sfkg025       number(20,6)      ,/* 超領數量 */
sfkg026       varchar2(1)      ,/* SET替代狀態 */
sfkg027       varchar2(10)      ,/* SET替代群組 */
sfkg028       varchar2(1)      ,/* 客供料 */
sfkg900       number(10,0)      ,/* 變更序 */
sfkg901       varchar2(1)      ,/* 變更類型 */
sfkg902       date      ,/* 變更日期 */
sfkg904       varchar2(10)      ,/* 變更理由 */
sfkg905       varchar2(255)      ,/* 變更備註 */
sfkgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfkg029       varchar2(30)      ,/* 指定發料批號 */
sfkg030       varchar2(30)      ,/* 指定庫存管理特征 */
sfkg031       number(20,6)      ,/* 備置量 */
sfkg032       varchar2(10)      ,/* 備置理由碼 */
sfkg033       varchar2(1)      /* 保稅否 */
);
alter table sfkg_t add constraint sfkg_pk primary key (sfkgent,sfkgdocno,sfkgseq,sfkgseq1,sfkg900) enable validate;

create unique index sfkg_pk on sfkg_t (sfkgent,sfkgdocno,sfkgseq,sfkgseq1,sfkg900);

grant select on sfkg_t to tiptop;
grant update on sfkg_t to tiptop;
grant delete on sfkg_t to tiptop;
grant insert on sfkg_t to tiptop;

exit;
