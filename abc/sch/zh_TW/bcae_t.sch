/* 
================================================================================
檔案代號:bcae_t
檔案名稱:掃描異動紀錄單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bcae_t
(
bcaeent       number(5)      ,/* 企業編號 */
bcaesite       varchar2(10)      ,/* 營運據點 */
bcae001       varchar2(80)      ,/* 訊息ID */
bcae002       varchar2(30)      ,/* 訊息批號 */
bcae003       varchar2(40)      ,/* 掃描單號 */
bcae004       varchar2(20)      ,/* 目的單號 */
bcae005       number(5,0)      ,/* 出入庫瑪 */
bcae006       varchar2(10)      ,/* 庫存異動類型 */
bcae007       varchar2(20)      ,/* 掃描人員 */
bcae008       varchar2(10)      ,/* 上傳狀態 */
bcae009       timestamp(5)      ,/* 上傳時間 */
bcae010       varchar2(4000)      ,/* 異常原因 */
bcae011       varchar2(10)      ,/* 批次處理狀態碼 */
bcae012       varchar2(4000)      ,/* 批次處理異常說明 */
bcae013       timestamp(5)      ,/* 批次接收處理時間 */
bcae014       varchar2(20)      ,/* 建議執行作業 */
bcae015       varchar2(10)      ,/* 建議執行功能 */
bcae999       timestamp(5)      ,/* 最後異動時間 */
bcaestus       varchar2(10)      ,/* 有效否 */
bcaeownid       varchar2(20)      ,/* 資料所有者 */
bcaeowndp       varchar2(10)      ,/* 資料所屬部門 */
bcaecrtid       varchar2(20)      ,/* 資料建立者 */
bcaecrtdp       varchar2(10)      ,/* 資料建立部門 */
bcaecrtdt       timestamp(0)      ,/* 資料創建日 */
bcaemodid       varchar2(20)      ,/* 資料修改者 */
bcaemoddt       timestamp(0)      ,/* 最近修改日 */
bcaecnfid       varchar2(20)      ,/* 資料確認者 */
bcaecnfdt       timestamp(0)      ,/* 資料確認日 */
bcaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bcae_t add constraint bcae_pk primary key (bcaeent,bcaesite,bcae001,bcae002,bcae003) enable validate;

create unique index bcae_pk on bcae_t (bcaeent,bcaesite,bcae001,bcae002,bcae003);

grant select on bcae_t to tiptop;
grant update on bcae_t to tiptop;
grant delete on bcae_t to tiptop;
grant insert on bcae_t to tiptop;

exit;
