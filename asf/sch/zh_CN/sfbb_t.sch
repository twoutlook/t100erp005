/* 
================================================================================
檔案代號:sfbb_t
檔案名稱:工單備置明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfbb_t
(
sfbbent       number(5)      ,/* 企業編號 */
sfbbsite       varchar2(10)      ,/* 營運據點 */
sfbbdocno       varchar2(20)      ,/* 工單單號 */
sfbbseq       number(10,0)      ,/* 工單項次 */
sfbbseq1       number(10,0)      ,/* 工單項序 */
sfbb001       varchar2(40)      ,/* 料件編號 */
sfbb002       varchar2(256)      ,/* 產品特徵 */
sfbb003       varchar2(30)      ,/* 庫存管理特徵 */
sfbb004       varchar2(10)      ,/* 庫位 */
sfbb005       varchar2(10)      ,/* 儲位 */
sfbb006       varchar2(30)      ,/* 批號 */
sfbb007       varchar2(10)      ,/* 庫存單位 */
sfbb008       number(20,6)      ,/* 備置量 */
sfbb009       number(20,6)      ,/* 備置已沖銷量 */
sfbb010       varchar2(10)      ,/* 備置單位 */
sfbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfbb_t add constraint sfbb_pk primary key (sfbbent,sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb007) enable validate;

create unique index sfbb_pk on sfbb_t (sfbbent,sfbbdocno,sfbbseq,sfbbseq1,sfbb001,sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,sfbb007);

grant select on sfbb_t to tiptop;
grant update on sfbb_t to tiptop;
grant delete on sfbb_t to tiptop;
grant insert on sfbb_t to tiptop;

exit;
