/* 
================================================================================
檔案代號:rtbb_t
檔案名稱:庫區異動單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtbb_t
(
rtbbent       number(5)      ,/* 企業編號 */
rtbbsite       varchar2(10)      ,/* 營運據點 */
rtbbdocno       varchar2(20)      ,/* 單據編號 */
rtbbseqno       number(10,0)      ,/* 項次 */
rtbb001       varchar2(10)      ,/* 庫位編號 */
rtbb002       varchar2(500)      ,/* 庫位名稱 */
rtbb003       varchar2(10)      ,/* 助記碼 */
rtbb004       varchar2(20)      ,/* 連絡對象識別碼 */
rtbb005       varchar2(10)      ,/* 成本中心 */
rtbb008       varchar2(1)      ,/* 庫存可用否 */
rtbb009       varchar2(1)      ,/* MRP可用否 */
rtbb010       varchar2(1)      ,/* 成本庫否 */
rtbb011       varchar2(1)      ,/* 與WMS整合否 */
rtbb014       varchar2(1)      ,/* 允許負庫存否 */
rtbbunit       varchar2(10)      ,/* 應用組織 */
rtbb101       varchar2(10)      ,/* 庫位類別 */
rtbb102       varchar2(10)      ,/* 庫區類別 */
rtbb103       varchar2(10)      ,/* 銷售類別 */
rtbb104       varchar2(10)      ,/* 收入類別 */
rtbb105       varchar2(10)      ,/* 業態 */
rtbb106       varchar2(10)      ,/* 品類編號 */
rtbb110       varchar2(10)      ,/* 收銀方式 */
rtbb111       varchar2(10)      ,/* 商品管理方式 */
rtbb120       varchar2(20)      ,/* 专柜编号 */
rtbb121       varchar2(20)      ,/* 場地 */
rtbb122       varchar2(10)      ,/* 區域 */
rtbb123       varchar2(10)      ,/* 樓層 */
rtbb124       varchar2(10)      ,/* 樓棟 */
rtbb130       date      ,/* 啟用日期 */
rtbbacti       varchar2(10)      ,/* 有效碼 */
rtbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtbb131       varchar2(10)      ,/* 管理方式 */
rtbb132       varchar2(1)      ,/* 參與自動補貨 */
rtbb133       varchar2(1)      ,/* 參與上下限計算 */
rtbb134       varchar2(10)      ,/* 專櫃類型 */
rtbb135       varchar2(10)      ,/* 庫區用途分類 */
rtbb136       varchar2(1)      ,/* 是否為默認庫區 */
rtbb137       varchar2(1)      ,/* 接贈卡否 */
rtbb138       varchar2(1)      ,/* 接贈券否 */
rtbb139       varchar2(1)      ,/* 接禮券否 */
rtbb140       varchar2(10)      ,/* 庫區特殊屬性 */
rtbb141       varchar2(10)      ,/* 對應常規庫區 */
rtbb142       number(5,0)      /* 優先級 */
);
alter table rtbb_t add constraint rtbb_pk primary key (rtbbent,rtbbdocno,rtbbseqno) enable validate;

create unique index rtbb_pk on rtbb_t (rtbbent,rtbbdocno,rtbbseqno);

grant select on rtbb_t to tiptop;
grant update on rtbb_t to tiptop;
grant delete on rtbb_t to tiptop;
grant insert on rtbb_t to tiptop;

exit;
