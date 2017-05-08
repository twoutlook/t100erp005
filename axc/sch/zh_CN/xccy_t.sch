/* 
================================================================================
檔案代號:xccy_t
檔案名稱:成本計算的特殊狀況訊息檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xccy_t
(
xccyent       number(5)      ,/* 企業代碼 */
xccycomp       varchar2(10)      ,/* 法人 */
xccyld       varchar2(5)      ,/* 帳別 */
xccy001       varchar2(1)      ,/* 帳套本位幣順序 */
xccy002       varchar2(30)      ,/* 成本域 */
xccy003       varchar2(10)      ,/* 成本計算類型 */
xccy004       number(5,0)      ,/* 年度 */
xccy005       number(5,0)      ,/* 期別 */
xccy006       varchar2(20)      ,/* 參考單號 */
xccy007       number(5,0)      ,/* 項次 */
xccy008       number(5,0)      ,/* 項序 */
xccy009       number(5,0)      ,/* 出入庫碼 */
xccy010       varchar2(40)      ,/* 料號 */
xccy011       varchar2(256)      ,/* 產品特徵 */
xccy012       varchar2(30)      ,/* 批號 */
xccy013       varchar2(10)      ,/* 成本次要素編號 */
xccy021       varchar2(10)      ,/* 錯誤代號 */
xccy022       varchar2(255)      ,/* 異常說明 */
xccycrtid       varchar2(20)      ,/* 資料建立者 */
xccycrtdp       varchar2(10)      ,/* 資料建立部門 */
xccycrtdt       timestamp(0)      ,/* 資料創建日 */
xccyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on xccy_t to tiptop;
grant update on xccy_t to tiptop;
grant delete on xccy_t to tiptop;
grant insert on xccy_t to tiptop;

exit;
