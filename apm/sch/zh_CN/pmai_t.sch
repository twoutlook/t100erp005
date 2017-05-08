/* 
================================================================================
檔案代號:pmai_t
檔案名稱:供應商不良記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmai_t
(
pmaistus       varchar2(10)      ,/* 狀態碼 */
pmaient       number(5)      ,/* 企業編號 */
pmai001       varchar2(10)      ,/* 供應商編號 */
pmai002       number(10,0)      ,/* 序號 */
pmai003       varchar2(10)      ,/* 反應門店 */
pmai004       varchar2(255)      ,/* 反應人員 */
pmai005       date      ,/* 反應日期 */
pmai006       varchar2(10)      ,/* 訊息分類 */
pmai007       varchar2(80)      ,/* 說明 */
pmai008       varchar2(500)      ,/* 反應內容 */
pmai009       varchar2(255)      ,/* 後續處理人員 */
pmai010       date      ,/* 後續處理日期 */
pmai011       varchar2(500)      ,/* 後續處理內容 */
pmai012       varchar2(10)      ,/* no use */
pmaiownid       varchar2(20)      ,/* 資料所有者 */
pmaiowndp       varchar2(10)      ,/* 資料所屬部門 */
pmaicrtid       varchar2(20)      ,/* 資料建立者 */
pmaicrtdp       varchar2(10)      ,/* 資料建立部門 */
pmaicrtdt       timestamp(0)      ,/* 資料創建日 */
pmaimodid       varchar2(20)      ,/* 資料修改者 */
pmaimoddt       timestamp(0)      ,/* 最近修改日 */
pmaicnfid       varchar2(20)      ,/* 資料確認者 */
pmaicnfdt       timestamp(0)      ,/* 資料確認日 */
pmaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmaiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmaiunit       varchar2(10)      /* 應用組織 */
);
alter table pmai_t add constraint pmai_pk primary key (pmaient,pmai001,pmai002) enable validate;

create unique index pmai_pk on pmai_t (pmaient,pmai001,pmai002);

grant select on pmai_t to tiptop;
grant update on pmai_t to tiptop;
grant delete on pmai_t to tiptop;
grant insert on pmai_t to tiptop;

exit;
