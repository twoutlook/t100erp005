/* 
================================================================================
檔案代號:srcf_t
檔案名稱:重複性生產製程變更歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table srcf_t
(
srcfent       number(5)      ,/* 企業代碼 */
srcfsite       varchar2(10)      ,/* 營運據點 */
srcf000       varchar2(1)      ,/* 類型 */
srcf001       varchar2(10)      ,/* 生產計劃 */
srcf002       varchar2(10)      ,/* 製程編號 */
srcf003       varchar2(40)      ,/* 料件編號 */
srcf004       varchar2(30)      ,/* BOM特性 */
srcf005       varchar2(256)      ,/* 產品特徵 */
srcf006       number(10,0)      ,/* 項次 */
srcfseq       number(10,0)      ,/* 項序 */
srcf007       number(10,0)      ,/* 變更序 */
srcf008       varchar2(20)      ,/* 變更欄位 */
srcf009       varchar2(10)      ,/* 變更類型 */
srcf010       varchar2(255)      ,/* 變更前內容 */
srcf011       varchar2(255)      ,/* 變更後內容 */
srcf012       varchar2(80)      ,/* 最後變更時間 */
srcf013       varchar2(500)      ,/* 欄位說明SQL */
srcfownid       varchar2(20)      ,/* 資料所有者 */
srcfowndp       varchar2(10)      ,/* 資料所屬部門 */
srcfcrtid       varchar2(20)      ,/* 資料建立者 */
srcfcrtdp       varchar2(10)      ,/* 資料建立部門 */
srcfcrtdt       timestamp(0)      ,/* 資料創建日 */
srcfmodid       varchar2(20)      ,/* 資料修改者 */
srcfmoddt       timestamp(0)      ,/* 最近修改日 */
srcfcnfid       varchar2(20)      ,/* 資料確認者 */
srcfcnfdt       timestamp(0)      ,/* 資料確認日 */
srcfpstid       varchar2(20)      ,/* 資料過帳者 */
srcfpstdt       timestamp(0)      ,/* 資料過帳日 */
srcfstus       varchar2(10)      ,/* 狀態碼 */
srcfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
srcfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
srcfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
srcfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
srcfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
srcfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
srcfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
srcfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
srcfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
srcfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
srcfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
srcfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
srcfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
srcfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
srcfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
srcfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
srcfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
srcfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
srcfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
srcfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
srcfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
srcfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
srcfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
srcfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
srcfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
srcfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
srcfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
srcfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
srcfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
srcfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table srcf_t add constraint srcf_pk primary key (srcfent,srcfsite,srcf000,srcf001,srcf002,srcf003,srcf004,srcf005,srcf006,srcfseq,srcf007,srcf008) enable validate;

create unique index srcf_pk on srcf_t (srcfent,srcfsite,srcf000,srcf001,srcf002,srcf003,srcf004,srcf005,srcf006,srcfseq,srcf007,srcf008);

grant select on srcf_t to tiptop;
grant update on srcf_t to tiptop;
grant delete on srcf_t to tiptop;
grant insert on srcf_t to tiptop;

exit;
