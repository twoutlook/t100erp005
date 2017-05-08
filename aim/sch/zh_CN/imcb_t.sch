/* 
================================================================================
檔案代號:imcb_t
檔案名稱:料件據點產品分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcb_t
(
imcbent       number(5)      ,/* 企業編號 */
imcbsite       varchar2(10)      ,/* 營運據點 */
imcbownid       varchar2(20)      ,/* 資料所有者 */
imcbowndp       varchar2(10)      ,/* 資料所屬部門 */
imcbcrtid       varchar2(20)      ,/* 資料建立者 */
imcbcrtdt       timestamp(0)      ,/* 資料創建日 */
imcbcrtdp       varchar2(10)      ,/* 資料建立部門 */
imcbmodid       varchar2(20)      ,/* 資料修改者 */
imcbmoddt       timestamp(0)      ,/* 最近修改日 */
imcbstus       varchar2(10)      ,/* 狀態碼 */
imcb011       varchar2(10)      ,/* 主分群碼 */
imcb012       varchar2(10)      ,/* 存貨管制方法 */
imcb013       varchar2(10)      ,/* 補給策略 */
imcb014       varchar2(10)      ,/* 需求計算方法 */
imcb015       varchar2(10)      ,/* 參考單位 */
imcb016       varchar2(10)      ,/* 據點生命週期 */
imcb021       number(15,3)      ,/* 期間採購月數 */
imcb022       number(15,3)      ,/* 期間採購日數 */
imcb023       number(20,6)      ,/* 期間補足量 */
imcb024       number(20,6)      ,/* 再訂貨點 */
imcb025       number(20,6)      ,/* 再訂貨點量 */
imcb026       number(20,6)      ,/* 安全庫存量 */
imcb027       number(20,6)      ,/* 警戒庫存量 */
imcb031       number(15,3)      ,/* 有效期月數 */
imcb032       number(15,3)      ,/* 有效期加天數 */
imcb033       number(15,3)      ,/* 檢疫/隔離天數 */
imcb034       varchar2(1)      ,/* 保稅料件 */
imcb017       varchar2(10)      ,/* 稅別 */
imcb035       varchar2(40)      ,/* 對應非保稅料號 */
imcb018       varchar2(1)      ,/* 使用附屬零件 */
imcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imcb036       varchar2(1)      ,/* 是否產生條碼 */
imcb037       varchar2(10)      ,/* 條碼編碼方式 */
imcb038       number(20,6)      /* 條碼包裝數量 */
);
alter table imcb_t add constraint imcb_pk primary key (imcbent,imcbsite,imcb011) enable validate;

create unique index imcb_pk on imcb_t (imcbent,imcbsite,imcb011);

grant select on imcb_t to tiptop;
grant update on imcb_t to tiptop;
grant delete on imcb_t to tiptop;
grant insert on imcb_t to tiptop;

exit;
