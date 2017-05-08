/* 
================================================================================
檔案代號:bmif_t
檔案名稱:料件承認資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bmif_t
(
bmifent       number(5)      ,/* 企業編號 */
bmif001       varchar2(40)      ,/* 承認料件編號 */
bmif002       varchar2(10)      ,/* 作業編號 */
bmif003       varchar2(10)      ,/* 作業序 */
bmif004       varchar2(40)      ,/* 承認主件料號 */
bmif005       varchar2(256)      ,/* 產品特徵 */
bmif006       varchar2(10)      ,/* 承認類型 */
bmif007       varchar2(10)      ,/* 廠商/客戶編號 */
bmif008       varchar2(40)      ,/* 交易對象料號 */
bmif009       varchar2(10)      ,/* 承認狀態 */
bmif010       number(10,0)      ,/* 承認次數 */
bmif011       date      ,/* 承認日期 */
bmif012       varchar2(80)      ,/* 承認文號 */
bmif013       varchar2(10)      ,/* 更新料件生命週期 */
bmif014       varchar2(255)      ,/* 備註 */
bmif015       number(20,6)      ,/* 限制數量(暫時承認) */
bmif016       date      ,/* 失效日期(暫時承認) */
bmif017       date      ,/* 承認有效開始日期 */
bmif018       date      ,/* 承認有效截止日期 */
bmif019       varchar2(20)      ,/* 申請/執行人員 */
bmif020       varchar2(10)      ,/* 申請/執行部門 */
bmifownid       varchar2(20)      ,/* 資料所有者 */
bmifowndp       varchar2(10)      ,/* 資料所屬部門 */
bmifcrtid       varchar2(20)      ,/* 資料建立者 */
bmifcrtdp       varchar2(10)      ,/* 資料建立部門 */
bmifcrtdt       timestamp(0)      ,/* 資料創建日 */
bmifmodid       varchar2(20)      ,/* 資料修改者 */
bmifmoddt       timestamp(0)      ,/* 最近修改日 */
bmifud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmifud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmifud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmifud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmifud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmifud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmifud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmifud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmifud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmifud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmifud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmifud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmifud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmifud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmifud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmifud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmifud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmifud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmifud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmifud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmifud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmifud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmifud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmifud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmifud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmifud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmifud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmifud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmifud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmifud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmif_t add constraint bmif_pk primary key (bmifent,bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,bmif008) enable validate;

create unique index bmif_pk on bmif_t (bmifent,bmif001,bmif002,bmif003,bmif004,bmif005,bmif006,bmif007,bmif008);

grant select on bmif_t to tiptop;
grant update on bmif_t to tiptop;
grant delete on bmif_t to tiptop;
grant insert on bmif_t to tiptop;

exit;
