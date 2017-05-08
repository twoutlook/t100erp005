/* 
================================================================================
檔案代號:bcmd_t
檔案名稱:待辦事項交易資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcmd_t
(
bcmdent       number(5)      ,/* 企業編號 */
bcmdsite       varchar2(10)      ,/* 營運據點 */
bcmd001       varchar2(80)      ,/* 訊息ID */
bcmd002       varchar2(30)      ,/* 訊息批號 */
bcmd003       varchar2(20)      ,/* 訊息發送者 */
bcmd004       varchar2(10)      ,/* 發送者所屬部門 */
bcmd005       varchar2(20)      ,/* 訊息接收者 */
bcmd006       varchar2(10)      ,/* 訊息接收者所屬部門 */
bcmd007       varchar2(10)      ,/* 訊息類型 */
bcmd008       timestamp(5)      ,/* 訊息時間 */
bcmd009       varchar2(10)      ,/* 訊息重要性 */
bcmd010       varchar2(255)      ,/* 訊息主旨 */
bcmd011       varchar2(4000)      ,/* 訊息內容 */
bcmd012       varchar2(20)      ,/* 來源作業 */
bcmd013       varchar2(20)      ,/* 來源單號 */
bcmd014       varchar2(20)      ,/* 建議執行作業 */
bcmd015       varchar2(10)      ,/* 建議執行功能 */
bcmd016       varchar2(5)      ,/* 建議單別 */
bcmd017       varchar2(20)      ,/* 目的單號 */
bcmd018       varchar2(10)      ,/* 庫位 */
bcmd019       varchar2(10)      ,/* 儲位 */
bcmd020       varchar2(30)      ,/* 批號 */
bcmd021       number(20,6)      ,/* 數量 */
bcmd022       varchar2(30)      ,/* 製造批號 */
bcmd023       varchar2(30)      ,/* 製造序號 */
bcmd024       varchar2(1)      ,/* 最近一次同步資料 */
bcmd025       varchar2(1)      ,/* 待辦處理否 */
bcmd026       timestamp(5)      ,/* 待辦處理時間 */
bcmd027       varchar2(1)      ,/* 結案狀態 */
bcmd028       timestamp(5)      ,/* 回報時間 */
bcmd029       varchar2(4000)      ,/* 回報資訊 */
bcmd999       timestamp(5)      ,/* 最後異動時間 */
bcmdstus       varchar2(10)      ,/* 有效否 */
bcmdownid       varchar2(20)      ,/* 資料所有者 */
bcmdowndp       varchar2(10)      ,/* 資料所屬部門 */
bcmdcrtid       varchar2(20)      ,/* 資料建立者 */
bcmdcrtdp       varchar2(10)      ,/* 資料建立部門 */
bcmdcrtdt       timestamp(0)      ,/* 資料創建日 */
bcmdmodid       varchar2(20)      ,/* 資料修改者 */
bcmdmoddt       timestamp(0)      ,/* 最近修改日 */
bcmdcnfid       varchar2(20)      ,/* 資料確認者 */
bcmdcnfdt       timestamp(0)      ,/* 資料確認日 */
bcmdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcmdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcmdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcmdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcmdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcmdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcmdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcmdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcmdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcmdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcmdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcmdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcmdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcmdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcmdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcmdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcmdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcmdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcmdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcmdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcmdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcmdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcmdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcmdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcmdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcmdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcmdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcmdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcmdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcmdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bcmd_t add constraint bcmd_pk primary key (bcmdent,bcmdsite,bcmd001) enable validate;

create unique index bcmd_pk on bcmd_t (bcmdent,bcmdsite,bcmd001);

grant select on bcmd_t to tiptop;
grant update on bcmd_t to tiptop;
grant delete on bcmd_t to tiptop;
grant insert on bcmd_t to tiptop;

exit;
