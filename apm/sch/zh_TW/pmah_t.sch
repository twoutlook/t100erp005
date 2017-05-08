/* 
================================================================================
檔案代號:pmah_t
檔案名稱:供應商談判記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmah_t
(
pmahent       number(5)      ,/* 企業編號 */
pmah001       varchar2(10)      ,/* 供應商編號 */
pmah002       number(10,0)      ,/* 序號 */
pmah003       varchar2(255)      ,/* 談判人員 */
pmah004       date      ,/* 談判日期 */
pmah005       varchar2(10)      ,/* 訊息分類 */
pmah006       varchar2(80)      ,/* 說明 */
pmah007       varchar2(500)      ,/* 內容 */
pmah008       varchar2(10)      ,/* no use */
pmahstus       varchar2(10)      ,/* 狀態碼 */
pmahownid       varchar2(20)      ,/* 資料所有者 */
pmahowndp       varchar2(10)      ,/* 資料所屬部門 */
pmahcrtid       varchar2(20)      ,/* 資料建立者 */
pmahcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmahcrtdt       timestamp(0)      ,/* 資料創建日 */
pmahmodid       varchar2(20)      ,/* 資料修改者 */
pmahmoddt       timestamp(0)      ,/* 最近修改日 */
pmahcnfid       varchar2(20)      ,/* 資料確認者 */
pmahcnfdt       timestamp(0)      ,/* 資料確認日 */
pmahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmahud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmahunit       varchar2(10)      /* 應用組織 */
);
alter table pmah_t add constraint pmah_pk primary key (pmahent,pmah001,pmah002) enable validate;

create unique index pmah_pk on pmah_t (pmahent,pmah001,pmah002);

grant select on pmah_t to tiptop;
grant update on pmah_t to tiptop;
grant delete on pmah_t to tiptop;
grant insert on pmah_t to tiptop;

exit;
